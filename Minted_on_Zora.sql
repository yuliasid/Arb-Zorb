/*
name: Minted on Zora
viz: Table
*/

select 
    recipient,
    total_price, 
    quantity
from zora.mints
where contract_address = 0x9a6735518847e59b71530512941afdf014a8a74b
