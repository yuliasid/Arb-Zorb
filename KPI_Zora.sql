/*
  name: KPI Zora
  viz: KPI objects
*/

WITH CalculatedValues AS (
    SELECT 
        recipient,
        total_price, 
        quantity
    FROM 
        zora.mints
    WHERE 
        contract_address = 0x9a6735518847e59b71530512941afdf014a8a74b
)

SELECT
    (SELECT SUM(quantity) FROM CalculatedValues) AS "Total Amount of Minted NFT",
    (SELECT AVG(quantity) FROM CalculatedValues) AS "Median Amount of Minted NFT",
    (SELECT COUNT(DISTINCT recipient) FROM CalculatedValues) AS "Total Distinct Addresses";
