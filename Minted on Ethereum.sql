/*
name: Minted on Ethereum
viz: Table
*/
WITH CalculatedValues AS (
    SELECT 
        value / 1e18 AS calculatedValue,
        "from"
    FROM 
        ethereum.transactions
    WHERE 
        "to" = 0x9a6735518847e59b71530512941afdf014a8a74b
        AND CAST(data AS VARCHAR) LIKE '0x9dbb844d%'
)
SELECT
    "from",
    calculatedValue,
    CASE 
        WHEN calculatedValue BETWEEN 0.000777 AND 0.01554 
            THEN ROUND((calculatedValue - 0.000777) / 0.000777) + 1
        ELSE 21
    END AS num_mints
FROM 
    CalculatedValues;
