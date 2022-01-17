let transfer ((p, (data, ledger)): (transfer_params * (data * ledger))): operation list * storage = 
    (* Finds or detects sender in ledger *)
    let (sender_tickets , ledger_1) = 
        Big_map.get_and_update (p.token_id, Tezos.sender) (None: token option) ledger in
    let (sender_balance, sender_token): nat * token =
        match sender_ticket with 
        | None => (failwith "NO_BALANCE": nat * token)
        | Some t ->
            let ((_, (_, b)), tck) = Tezos.read_ticket t in
            b, tck