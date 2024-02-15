/*
  name: KPI by Network
  viz: Table
*/

SELECT 
    'Zora' AS network, 
    COUNT(DISTINCT recipient) AS unique_addresses, 
    SUM(quantity) AS minted_nft
FROM 
    zora.mints
WHERE 
    contract_address = 0x9a6735518847e59b71530512941afdf014a8a74b

UNION ALL

SELECT 
    'Ethereum' AS network, 
    COUNT(DISTINCT "from") AS unique_addresses, 
    SUM(CASE 
            WHEN value / 1e18 BETWEEN 0.000777 AND 0.01554 
                THEN ROUND((value / 1e18 - 0.000777) / 0.000777) + 1
            ELSE 21
        END) AS minted_nft
FROM 
    ethereum.transactions
WHERE 
    "to" = 0x9a6735518847e59b71530512941afdf014a8a74b
    AND CAST(data AS VARCHAR) LIKE '0x9dbb844d%'

UNION ALL

SELECT 
    'Arbitrum' AS network, 
    COUNT(DISTINCT "from") AS unique_addresses, 
    SUM(CASE 
            WHEN value / 1e18 BETWEEN 0.000777 AND 0.01554 
                THEN ROUND((value / 1e18 - 0.000777) / 0.000777) + 1
            ELSE 21
        END) AS minted_nft
FROM 
    arbitrum.transactions
WHERE 
    "to" = 0x9a6735518847e59b71530512941afdf014a8a74b
    AND CAST(data AS VARCHAR) LIKE '0x9dbb844d%'
ORDER BY 2 DESC;

