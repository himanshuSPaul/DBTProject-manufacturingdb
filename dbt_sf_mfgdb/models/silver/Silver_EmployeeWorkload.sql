--CREATE OR REPLACE TABLE VISK_INDUS_PVT_LTD.SILVER.Silver_EmployeeWorkload AS 
WITH ShiftHours AS (
    SELECT 
        wcs.WorkCenterID,
        ewca.EmployeeID,
        SUM(DATEDIFF(HOUR, wcs.ScheduledStartDate, wcs.ScheduledEndDate)) AS TotalHoursWorked
    FROM {{ref('Bronze_WorkCenterSchedule')}}  wcs
    --VISK_INDUS_PVT_LTD.BRONZE.Bronze_WorkCenterSchedule wcs
    JOIN {{ref('Bronze_WorkCenterAssignments')}} ewca
    --VISK_INDUS_PVT_LTD.BRONZE.Bronze_EmployeeWorkCenterAssignment ewca
        ON wcs.WorkCenterID = ewca.WorkCenterID
    --WHERE ewca.EndDate IS NULL OR ewca.EndDate > CURRENT_DATE  -- Only active employees
    GROUP BY wcs.WorkCenterID, ewca.EmployeeID
),
Overtime AS (
    SELECT 
        EmployeeID,
        WorkCenterID,
        SUM(CASE 
            WHEN TotalHoursWorked > 40 THEN TotalHoursWorked - 40  -- Overtime calculation
            ELSE 0 
        END) AS OvertimeHours
    FROM ShiftHours
    GROUP BY EmployeeID, WorkCenterID
)
SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Department,
    e.Position,
    sh.WorkCenterID,
    sh.TotalHoursWorked,
    COALESCE(o.OvertimeHours, 0) AS OvertimeHours,
    CASE 
        WHEN sh.TotalHoursWorked > 50 THEN 'Overloaded'
        WHEN sh.TotalHoursWorked < 30 THEN 'Underutilized'
        ELSE 'Balanced'
    END AS WorkloadCategory
FROM ShiftHours sh
LEFT JOIN Overtime o 
    ON sh.EmployeeID = o.EmployeeID 
    AND sh.WorkCenterID = o.WorkCenterID
LEFT JOIN VISK_INDUS_PVT_LTD.BRONZE.Bronze_Employees e 
    ON sh.EmployeeID = e.EmployeeID


























---Old logic
-----------
-- SELECT 
--     e.EmployeeID,
--     e.FirstName,
--     e.LastName,
--     wca.WorkCenterID,
--     COUNT(po.OrderID) AS TotalOrders,
--     CASE 
--         WHEN COUNT(po.OrderID) > 8 THEN 'Overloaded'
--         WHEN COUNT(po.OrderID) < 3 THEN 'Underutilized'
--         ELSE 'Balanced'
--     END AS WorkloadStatus
-- FROM {{ref('Bronze_Employees')}} e   --VISK_INDUS_PVT_LTD.BRONZE.Bronze_Employees e
-- LEFT JOIN {{ref('Bronze_WorkCenterAssignments')}} wca   --VISK_INDUS_PVT_LTD.BRONZE.Bronze_WorkCenterAssignments wca 
--        ON e.EmployeeID = wca.EmployeeID
-- LEFT JOIN {{ref('Bronze_ProductionOrders')}} po
-- --VISK_INDUS_PVT_LTD.BRONZE.Bronze_ProductionOrders po 
--        ON wca.WorkCenterID = po.WorkCenterID
-- GROUP BY e.EmployeeID, e.FirstName, e.LastName, wca.WorkCenterID