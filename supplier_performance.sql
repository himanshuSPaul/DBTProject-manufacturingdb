WITH SupplierOrderStats AS (
    SELECT
        sms.SupplierID,
        sms.SupplierName,
        COUNT(DISTINCT sms.MaterialID) AS NumberOfMaterialsSupplied,
        AVG(DATE_DIFF( day, po.DueDate, sms.OrderDate)) AS AverageLeadTime,  -- Using DueDate as a proxy (refine if actual receiving data is available)
        SUM(CASE WHEN po.DueDate >= sms.OrderDate THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DeliveryReliability,
        AVG(sms.CurrentUnitPrice) AS AverageUnitPrice,
        STDDEV(sms.CurrentUnitPrice) AS PriceVolatility,
        SUM(sms.CurrentUnitPrice * sms.OrderQuantity) AS TotalSpend,
        SUM(DATE_DIFF( day, po.DueDate, sms.OrderDate) * sms.OrderQuantity) / SUM(sms.OrderQuantity) as WeightedAverageLeadTime,
        COUNT(DISTINCT po.OrderID) AS NumberOfOrders
    FROM  {{ref('silver_suppliers_materials')}} sms
    --VISK_INDUS_PVT_LTD.SILVER.Suppliers_Materials_Silver sms
    JOIN {{ref('bronze_ProductionOrders')}} po ON sms.OrderID = po.OrderID
    --VISK_INDUS_PVT_LTD.SILVER.ProductionOrders_Silver po 
    GROUP BY sms.SupplierID, sms.SupplierName
),
MaterialCount AS (
  SELECT MaterialID, 
        COUNT(DISTINCT SupplierID) AS SupplierCount 
  FROM {{ref('silver_suppliers_materials')}}
  --VISK_INDUS_PVT_LTD.SILVER.Suppliers_Materials_Silver 
  GROUP BY MaterialID
)
SELECT
    sos.*,
    (SELECT COUNT(DISTINCT SupplierID) FROM {{ref('silver_suppliers_materials')}}) as TotalSuppliers,
    (SELECT AVG(AverageLeadTime) FROM SupplierOrderStats) as AvgLeadTimeAcrossSuppliers,
    (SELECT AVG(DeliveryReliability) FROM SupplierOrderStats) as AvgDeliveryReliabilityAcrossSuppliers,
    (SELECT AVG(AverageUnitPrice) FROM SupplierOrderStats) as AvgUnitPriceAcrossSuppliers,
    (SELECT AVG(PriceVolatility) FROM SupplierOrderStats) as AvgPriceVolatilityAcrossSuppliers,
    (SELECT AVG(TotalSpend) FROM SupplierOrderStats) as AvgTotalSpendAcrossSuppliers,
    (SELECT AVG(WeightedAverageLeadTime) FROM SupplierOrderStats) as AvgWeightedAverageLeadTimeAcrossSuppliers
FROM SupplierOrderStats sos
