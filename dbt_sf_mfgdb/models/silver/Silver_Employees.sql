SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Department,
    e.Position,
    ewca.WorkCenterID,
    ewca.StartDate,
    COALESCE(ewca.EndDate, CURRENT_DATE) AS EndDate,
    DATEDIFF(DAY, ewca.StartDate, COALESCE(ewca.EndDate, CURRENT_DATE)) AS EmploymentDuration,
    CASE 
        WHEN ewca.EndDate IS NULL OR ewca.EndDate > CURRENT_DATE THEN 'Active'
        ELSE 'Inactive'
    END AS EmploymentStatus
FROM {{ref('Bronze_Employees')}} e
--VISK_INDUS_PVT_LTD.BRONZE.Bronze_Employees e
LEFT JOIN {{ref('Bronze_EmployeeWorkCenterAssignment')}} ewca
--VISK_INDUS_PVT_LTD.BRONZE.Bronze_EmployeeWorkCenterAssignment ewca
    ON e.EmployeeID = ewca.EmployeeID
    AND ewca.EndDate IS NULL  -- Only take currently assigned employees