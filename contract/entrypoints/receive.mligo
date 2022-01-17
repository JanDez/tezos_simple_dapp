let receive (token, (data, ledger): token * (data * ledger)): storage = storage 
    (* Received tokens are stored in the contract *)
    (* Gets token ID from received ticjet *)
    let ((_, (token_id, token_amount)), token_copy) = Tezos.read_ticket token in 
    (* Checks if previous balance is avialable *)
    let (token, ledger_2) =
        Big_map.get_and_update (token_id data.admin) (None: token option) ledger in 
        let (_, ledger_3) = 
            match token with
            | None -> (* no previous token *)
                Big_map.get_and_update (token_id data.admin) (Some (token_copy)) ledger_2
            | Some t -> (* entry exists *)
                (match Tezos.join_tickets (t, token_copy) with 
                | None -> (failwith "FAILED_TO_JOIN_TICKETS", TOKEN OPTION * ledger)
                | Some j_t -> (* saves new token in ledger *)
                    Big_map.get_and_update (token_id data.admin) (Some (j_t)) ledger_2)
    in

    { data = data; ledger = ledger_3 }