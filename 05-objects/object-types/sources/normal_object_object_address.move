/// this defines a simple module to demonstrate Normal object creation
/// particularly focusing on the generation of an object's address
module my_address::normal_object {
    use std::signer;
    use std::string::{Self, String};
    use aptos_framework::object::{Self, Object};
    use aptos_framework::event;

    /// a simple resource to store inside our Normal Object.
    /// tt must have the `key` ability to be stored directly under an object's address.
    struct MySimpleObjectData has key {
        unique_id: u64, // application-specific unique identifier
        message: String,
    }

    // event emitted when a Normal Object is created.
    // this event will contain the address of the newly created object,
    // making it easy to find on the Aptos Explorer.
    #[event]
    struct NormalObjectCreatedEvent has drop, store {
        creator: address,
        object_address: address,
        initial_message: String,
    }

    /// entry function to create a new Normal Object.
    /// the `creator` signer is the account that will initiate the transaction.
    public entry fun create_a_normal_object(
        creator: &signer,
        initial_message: String,
        unique_id_value: u64,
    ) {
        let creator_address = signer::address_of(creator);

        // create a Normal Object using object::create_object.
        // this function returns a ConstructorRef. the object's address
        // is randomly generated based on the creator's address and an
        // internal GUID counter, ensuring uniqueness.
        let constructor_ref = object::create_object(creator_address);

        // generate a signer for the new object.
        // this allows the object itself to 'sign' transactions to move
        // resources into its own storage.
        let object_signer = object::generate_signer(&constructor_ref);
        let object_address = signer::address_of(&object_signer); // Get the object's newly generated address

        // move our custom resource into the object's storage.
        move_to(
            &object_signer,
            MySimpleObjectData {
                unique_id: unique_id_value,
                message: initial_message,
            }
        );

        // emit an event with the object's address and other relevant data.
        // this is key for observing the object's creation on the explorer.
        event::emit(NormalObjectCreatedEvent {
            creator: creator_address,
            object_address: object_address,
            initial_message: initial_message,
        });
    }

    /// view function to read data from a Normal Object.
    public fun get_object_data(
        object_address: address,
    ): (u64, String) acquires MySimpleObjectData {
        let data = borrow_global<MySimpleObjectData>(object_address);
        (data.unique_id, data.message)
    }
}