/*
  name: KPI Arbitrum
  viz: Table
*/

WITH CalculatedValues AS (
    SELECT 
        "from",
        value,
        CASE 
            WHEN value / 1e18 BETWEEN 0.000777 AND 0.01554 
                THEN ROUND((value / 1e18 - 0.000777) / 0.000777) + 1
            ELSE 21
        END AS num_mints
    FROM 
        arbitrum.transactions
    WHERE 
        "to" = 0x9a6735518847e59b71530512941afdf014a8a74b
        AND CAST(data AS VARCHAR) LIKE '0x9dbb844d%'
)

SELECT
    (SELECT SUM(num_mints) FROM CalculatedValues) AS "Total Amount of Minted NFT",
    (SELECT SUM(num_mints)*0.000777 FROM CalculatedValues) AS "Total ETH Spent",
    (SELECT avg(num_mints) FROM CalculatedValues) AS "Median Amount of Minted NFT",
    (SELECT COUNT(DISTINCT "from") FROM CalculatedValues) AS "Total Distinct Addresses";
