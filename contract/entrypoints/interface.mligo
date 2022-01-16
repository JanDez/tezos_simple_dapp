type token_id = nat

type token = token_id ticket 

type transfer_params = 
[@layout:comb]
{
    token_id: token_id;
    recipient: address;
    token_amount: nat;
}

type entrypoints =
| Mint of nat
| Transfer of transfer_params
| Receive of nat ticket

