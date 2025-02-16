-- CREATE OR REPLACE TABLE VISK_INDUS_PVT_LTD.SILVER.RawMaterials_Silver AS
-- {{config(alias="bronze_raw_materials")}}
SELECT
    MaterialID,
    MaterialName,
    MaterialDescription,
    UnitOfMeasure,
    MaterialType,
    UnitPrice,
    SupplierID,
    Quantity AS Quantity
FROM VISK_INDUS_PVT_LTD.RAW.RawMaterials


