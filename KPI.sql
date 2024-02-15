/*
  name: KPI
  viz: KPI objects
*/

WITH CombinedArbitrumEthereum AS (
    SELECT 
        "from",
        value / 1e18 AS value_eth
    FROM 
        arbitrum.transactions
    WHERE 
        "to" = 0x9a6735518847e59b71530512941afdf014a8a74b
        AND CAST(data AS VARCHAR) LIKE '0x9dbb844d%'
    UNION ALL
    SELECT 
        "from",
        value / 1e18 AS value_eth
    FROM 
        ethereum.transactions
    WHERE 
        "to" = 0x9a6735518847e59b71530512941afdf014a8a74b
        AND CAST(data AS VARCHAR) LIKE '0x9dbb844d%'
),
CalculatedArbitrumEthereum AS (
    SELECT
        "from",
        CASE 
            WHEN value_eth BETWEEN 0.000777 AND 0.01554 
                THEN ROUND((value_eth - 0.000777) / 0.000777) + 1
            ELSE 21
        END AS num_mints
    FROM CombinedArbitrumEthereum
),
ZoraData AS (
    SELECT 
        recipient AS "from",
        quantity AS num_mints
    FROM 
        zora.mints
    WHERE 
        contract_address = 0x9a6735518847e59b71530512941afdf014a8a74b
),
CombinedData AS (
    SELECT * FROM CalculatedArbitrumEthereum
    UNION ALL
    SELECT * FROM ZoraData
)
SELECT
    COUNT(DISTINCT "from") AS "Total Distinct Addresses",
    SUM(num_mints) AS "Total Minted NFT"
FROM CombinedData;
