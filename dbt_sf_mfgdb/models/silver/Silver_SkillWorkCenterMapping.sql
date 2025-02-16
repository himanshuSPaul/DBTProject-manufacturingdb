SELECT 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.Department,
    wca.WorkCenterID,
    wc.WorkCenterName,
    CASE 
        WHEN e.Department LIKE '%Mechanical%' AND wc.WorkCenterName NOT LIKE '%Mechanical%' THEN 'Mismatch'
        WHEN e.Department LIKE '%Electrical%' AND wc.WorkCenterName NOT LIKE '%Electrical%' THEN 'Mismatch'
        ELSE 'Match'
    END AS SkillMatchStatus
FROM {{ref('Bronze_Employees')}} e
-- VISK_INDUS_PVT_LTD.BRONZE.Bronze_Employees e
LEFT JOIN {{ref('Bronze_WorkCenterAssignments')}} wca
-- VISK_INDUS_PVT_LTD.BRONZE.Bronze_WorkCenterAssignments wca 
    ON e.EmployeeID = wca.EmployeeID
LEFT JOIN {{ref('Bronze_WorkCenters')}} wc
--VISK_INDUS_PVT_LTD.BRONZE.Bronze_WorkCenters wc 
    ON wca.WorkCenterID = wc.WorkCenterID