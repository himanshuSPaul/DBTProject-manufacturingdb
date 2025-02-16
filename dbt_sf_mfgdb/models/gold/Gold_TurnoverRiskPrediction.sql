SELECT 
    se.EmployeeID,
    se.FirstName,
    se.LastName,
    se.Department,
    ew.WorkCenterID,
    ew.TotalHoursWorked,
    ew.OvertimeHours,
    ew.WorkloadCategory,
    ssi.ShiftLoadStatus,
    CASE 
        WHEN ew.WorkloadCategory = 'Overloaded' AND ssi.ShiftLoadStatus = 'Overloaded' THEN 'High Risk'
        WHEN ew.WorkloadCategory = 'Underutilized' AND ssi.ShiftLoadStatus = 'Underutilized' THEN 'Moderate Risk'
        ELSE 'Low Risk'
    END AS TurnoverRisk
FROM {{ref('Silver_EmployeeWorkload')}} ew
--VISK_INDUS_PVT_LTD.SILVER.Silver_EmployeeWorkload ew
JOIN {{ref('Silver_ShiftImbalance')}} ssi
--VISK_INDUS_PVT_LTD.SILVER.Silver_ShiftImbalance ssi 
    ON ew.WorkCenterID = ssi.WorkCenterID
JOIN {{ref('Silver_Employees')}} se
--VISK_INDUS_PVT_LTD.SILVER.Silver_Employees se
    ON ew.EmployeeID = se.EmployeeID