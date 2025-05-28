module my_address::token_store {
    use std::signer;
    use std::string::{Self, String};

    struct Token has key, store {
        name: String,
        supply: u64,
    }

    struct Vault has key {
        token: Token,
    }

    /// initialize a Vault that wraps a Token and store it in the signer's account
    public entry fun initialize(admin: &signer, name: String, supply: u64) {
        let token = Token {
            name,
            supply,
        };

        let vault = Vault {
            token,
        };

        move_to(admin, vault); 
    }
    
    public fun get_token_supply(addr: address): u64 acquires Vault {
        let vault = borrow_global<Vault>(addr);
        vault.token.supply
    }
}
