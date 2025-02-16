SELECT 
    EmployeeID,
    WorkCenterID,
    StartDate,
    EndDate
FROM VISK_INDUS_PVT_LTD.RAW.EmployeeWorkCenterAssignment
WHERE EmployeeID IS NOT NULL 
    AND WorkCenterID IS NOT NULL
    AND StartDate IS NOT NULL