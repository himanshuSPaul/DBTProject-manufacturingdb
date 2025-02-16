-- SELECT 
--     EmployeeID,
--     FirstName,
--     LastName,
--     Department,
--     Position
-- FROM VISK_INDUS_PVT_LTD.RAW.Employees

SELECT 
    EmployeeID,
    TRIM(FirstName) AS FirstName,
    TRIM(LastName) AS LastName,
    TRIM(Department) AS Department,
    TRIM(Position) AS Position
FROM VISK_INDUS_PVT_LTD.RAW.Employees
WHERE EmployeeID IS NOT NULL
    AND FirstName IS NOT NULL
    AND LastName IS NOT NULL;