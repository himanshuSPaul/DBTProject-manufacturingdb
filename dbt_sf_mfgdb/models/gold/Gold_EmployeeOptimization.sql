SELECT 
    ew.EmployeeID,
    ew.FirstName,
    ew.LastName,
    ew.WorkCenterID AS CurrentWorkCenter,
    ssm.WorkCenterID AS RecommendedWorkCenter
FROM  {{ref('Silver_EmployeeWorkload')}} ew
--VISK_INDUS_PVT_LTD.SILVER.Silver_EmployeeWorkload ew
JOIN  {{ref('Silver_ShiftImbalance')}} ssm
--VISK_INDUS_PVT_LTD.SILVER.Silver_ShiftImbalance ssm 
  ON ew.WorkloadStatus = 'Overloaded'  
 AND ssm.ShiftLoadStatus = 'Underutilized'