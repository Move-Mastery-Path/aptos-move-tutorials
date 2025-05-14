module my_note::personal_note {
    use std::signer;
    use std::vector;
    use std::string::{String};

    //errors
    const EUSER_NOT_INITIALIZED: u64 = 0; 
    const EUSER_ALREADY_INITIALIZED: u64 = 1;
    const ENOTE_NOT_FOUND: u64 = 2;

    struct Note has copy, drop, store {
        content: String,
    }

    struct UserNotes has key {
        notes: vector<Note>,
    }

    public entry fun init_user(account: &signer) {
        let user_address = signer::address_of(account);
        // Check if the user already has notes initialized
        assert!(!exists<UserNotes>(user_address), EUSER_ALREADY_INITIALIZED);
        let user_notes = UserNotes 
        { 
            notes: vector::empty<Note>(),
        };
        
        move_to(account, user_notes);
        
    }

    public entry fun add_note(account: &signer, content: String) acquires UserNotes {
        let user_address = signer::address_of(account);
        // Check if the user has notes initialized
        assert!(exists<UserNotes>(user_address), EUSER_NOT_INITIALIZED);

        let mut user_notes = borrow_global_mut<UserNotes>(user_address);
        
        let new_note = Note { content };
        vector::push_back(&mut user_notes.notes, new_note);
    }

    public entry fun get_notes(account: &signer): vector<Note> acquires UserNotes {
        let user_address = signer::address_of(account);

        // Check if the user has notes initialized
        assert!(exists<UserNotes>(user_address), EUSER_NOT_INITIALIZED);

        let user_notes = borrow_global<UserNotes>(user_address);
        user_notes.notes

    }

}