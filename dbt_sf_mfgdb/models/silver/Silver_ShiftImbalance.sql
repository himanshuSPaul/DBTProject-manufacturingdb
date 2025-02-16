SELECT 
    ws.WorkCenterID,
    ws.Shift,
    COUNT(po.OrderID) AS ScheduledOrders,
    ws.Capacity,
    CASE 
        WHEN COUNT(po.OrderID) > ws.Capacity THEN 'Overloaded'
        WHEN COUNT(po.OrderID) < (ws.Capacity * 0.5) THEN 'Underutilized'
        ELSE 'Balanced'
    END AS ShiftLoadStatus
FROM {{ref('Bronze_WorkCenterSchedule')}} ws
--VISK_INDUS_PVT_LTD.BRONZE.Bronze_WorkCenterSchedule ws
LEFT JOIN {{ref('Bronze_ProductionOrders')}} po
--VISK_INDUS_PVT_LTD.BRONZE.Bronze_ProductionOrders po 
    ON ws.WorkCenterID = po.WorkCenterID
    AND ws.OrderID = po.OrderID
GROUP BY ws.WorkCenterID, ws.Shift, ws.Capacity