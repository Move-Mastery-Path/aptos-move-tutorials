module my_address::token_key {
    use std::signer;
    use std::string::{Self, String};

    struct Token has key {
        name: String,
        supply: u64,
    }

    public entry fun initialize(admin: &signer, name: String, supply: u64) {
        let token = Token {
            name,
            supply,
        };

        move_to(admin, token); // Move the token to the admin's account
    }

    public fun get_token_supply(addr: address): u64 acquires Token {
        let token = borrow_global<Token>(addr);
        token.supply
    }
    
}