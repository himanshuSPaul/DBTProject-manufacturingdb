SELECT
    s.SupplierID,
    rm.MaterialID,
    s.SupplierName,
    rm.MaterialName,
    rm.UnitPrice AS CurrentUnitPrice,  -- Current price
    po.OrderDate,  -- Date of the order
    po.OrderID,
    po.Quantity AS OrderQuantity
FROM {{ref('bronze_Suppliers')}} s --VISK_INDUS_PVT_LTD.RAW.Suppliers s
JOIN  {{ref("bronze_RawMaterials")}} rm --VISK_INDUS_PVT_LTD.RAW.RawMaterials rm 
ON s.SupplierID = rm.SupplierID
JOIN {{ref('bronze_ProductionOrders')}} po --VISK_INDUS_PVT_LTD.RAW.ProductionOrders po 
  ON rm.MaterialID =po.ProductID
-- ORDER BY s.SupplierID, rm.MaterialID, po.OrderDate


-- JOIN VISK_INDUS_PVT_LTD.RAW.ProductionOrders po 
-- ON rm.MaterialID = (SELECT MaterialID FROM VISK_INDUS_PVT_LTD.RAW.product_raw_materials WHERE ProductID = po.ProductID)
-- ORDER BY s.Supplier_SK, rm.Material_SK, po.OrderDate;