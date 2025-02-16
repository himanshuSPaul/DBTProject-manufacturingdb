SELECT
    MaterialID,
    MaterialName,
    MaterialDescription,
    UnitOfMeasure,
    MaterialType,
    UnitPrice,
    SupplierID,
    Quantity AS Quantity
FROM {{ref("bronze_RawMaterials")}}
   -- VISK_INDUS_PVT_LTD.RAW.RawMaterials;