module my_note::personal_note {
    use std::signer;
    use std::vector;
    use std::string::{String};

    use aptos_framework::timestamp;

    //
    // errors,
    //

    /// when user has not initialized their notes
    const EUSER_NOT_INITIALIZED: u64 = 0; 

    /// when user has already initialized their notes
    const EUSER_ALREADY_INITIALIZED: u64 = 1;

    /// when note is not found
    /// (e.g. when user tries to delete a note that does not exist)
    /// or when user tries to get a note that does not exist)
    const ENOTE_NOT_FOUND: u64 = 2;

    /// core data structures

    struct Note has copy, drop, store {
        content: String,
        created_at: u64,
        updated_at: u64,
    }

    /// this is a resource that stores the notes of a user
    /// it is stored in the global storage
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

        let user_notes = borrow_global_mut<UserNotes>(user_address);
        
        let current_time = timestamp::now_seconds();
        let new_note = Note { content, created_at: current_time, updated_at: current_time };
        vector::push_back(&mut user_notes.notes, new_note);
    }


    #[view]
    public fun view_notes(user_address: address): vector<Note> acquires UserNotes {
        
        // Check if the user has notes initialized
        assert!(exists<UserNotes>(user_address), EUSER_NOT_INITIALIZED);

        let user_notes = borrow_global<UserNotes>(user_address);
        user_notes.notes

    }

    public entry fun delete_note(account: &signer, index: u64) acquires UserNotes {
        let user_address = signer::address_of(account);

        // Check if the user has notes initialized
        assert!(exists<UserNotes>(user_address), EUSER_NOT_INITIALIZED);

        let user_notes = borrow_global_mut<UserNotes>(user_address);
        
        // Check if the note exists
        assert!(index < vector::length(&user_notes.notes), ENOTE_NOT_FOUND);
        
        vector::remove(&mut user_notes.notes, index);
    }

    public entry fun update_note(account: &signer, index: u64, new_content: String) acquires UserNotes {
        let user_address = signer::address_of(account);

        assert!(exists<UserNotes>(user_address), EUSER_NOT_INITIALIZED);

        let user_notes = borrow_global_mut<UserNotes>(user_address);

        // Check if the note exists
        assert!(index < vector::length(&user_notes.notes), ENOTE_NOT_FOUND);
        let note = vector::borrow_mut(&mut user_notes.notes, index);    
        note.content = new_content;
        note.updated_at = timestamp::now_seconds();
    }

}