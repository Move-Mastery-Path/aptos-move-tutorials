module my_address::token_copy {
    use std::signer;
    use std::string::{Self, String};

    struct Token has drop, copy {
        name: String,
        supply: u64,
    }

    public entry fun initialize(admin: &signer, name: String, supply: u64) {
        let token = Token {
            name,
            supply,
        };

        consume_token(copy token); //Explicitly copy the token
        consume_token(token);
    }
    
     fun consume_token(t: Token){}
}