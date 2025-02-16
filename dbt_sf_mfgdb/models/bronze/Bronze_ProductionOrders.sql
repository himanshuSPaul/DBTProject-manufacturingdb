SELECT 
    OrderID,
    ProductID,
    WorkCenterID,
    Quantity,
    Status
FROM VISK_INDUS_PVT_LTD.RAW.ProductionOrders







-- -- CREATE OR REPLACE TABLE VISK_INDUS_PVT_LTD.SILVER.ProductionOrders_Silver AS
-- SELECT
--     OrderID,
--     ProductID,
--     OrderDate AS OrderDate,
--     Quantity,
--     DueDate AS DueDate,
--     WorkCenterID,
--     Status,
--     CustomerID
-- FROM VISK_INDUS_PVT_LTD.RAW.ProductionOrders
