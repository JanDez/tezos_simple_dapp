let mint (token_amount, (data, ledger): nat * (data * ledger)): storage =
    (* creting new tokens *)
    if Tezos.sender <> data.admin
    then (failwith "UNAUTHORIZED_ACTION": storage)
    else
        (*finds if admin already has a balance in the token*)
        let (token, ledger_1): token option * ledger =
            Big_map.get_and_update (data.native_token, Tezos.sender) (None: token option) ledger in
        let (_, ledger_2): token option * ledger =
            match token with 
            | None ->
                (* admin didn't have a previous balance *)
                let new_token: token = Tezos.create_ticket data.native_token token_amount in
                Big_map.get_and_update (data.native_token, Tezos.sender) (Some new_token) ledger_1
            | Some op_t ->
                (* admin already had a balance *)
                (* creates a new token *)
                let new_token: token = Tezos.create_ticket data.native_token token_amount in
                