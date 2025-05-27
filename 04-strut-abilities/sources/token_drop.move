module my_address::token_drop {
    use std::signer;
    use std::string::{Self, String};

    struct Token has drop {
        name: String,
        supply: u64,
    }

    public entry fun initialize(admin: &signer, name: String, supply: u64) {
        let token = Token {
            name,
            supply,
        };
    }
    
}