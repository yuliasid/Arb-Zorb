/*
  name: Minted NFTs
  viz: Table
*/
WITH EthereumCalculatedValues AS (
    SELECT 
        'Ethereum' AS network,
        value / 1e18 AS calculatedValue,
        "from"
    FROM 
        ethereum.transactions
    WHERE 
        "to" = 0x9a6735518847e59b71530512941afdf014a8a74b
        AND CAST(data AS VARCHAR) LIKE '0x9dbb844d%'
),
ZoraCalculatedValues AS (
    SELECT 
        'Zora' AS network,
        recipient AS "from",
        total_price AS calculatedValue,
        quantity AS num_mints
    FROM 
        zora.mints
    WHERE 
        contract_address = 0x9a6735518847e59b71530512941afdf014a8a74b
),
ArbitrumCalculatedValues AS (
    SELECT 
        'Arbitrum' AS network,
        value / 1e18 AS calculatedValue,
        "from"
    FROM 
        arbitrum.transactions
    WHERE 
        "to" = 0x9a6735518847e59b71530512941afdf014a8a74b
        AND CAST(data AS VARCHAR) LIKE '0x9dbb844d%'
)

SELECT
    "from",
    network,
    calculatedValue,
    CASE 
        WHEN calculatedValue BETWEEN 0.000777 AND 0.01554 
            THEN ROUND((calculatedValue - 0.000777) / 0.000777) + 1
        ELSE 21
    END AS num_mints
FROM 
    EthereumCalculatedValues

UNION ALL

SELECT
    "from",
    network,
    calculatedValue,
    num_mints
FROM 
    ZoraCalculatedValues

UNION ALL

SELECT
    "from",
    network,
    calculatedValue,
    CASE 
        WHEN calculatedValue BETWEEN 0.000777 AND 0.01554 
            THEN ROUND((calculatedValue - 0.000777) / 0.000777) + 1
        ELSE 21
    END AS num_mints
FROM 
    ArbitrumCalculatedValues;
