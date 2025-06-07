// let's create a normal object in aptos
module my_address::normal_object {
    use std::signer;
    use std::signer::address_of;
    use std::string::{Self, String};
    use aptos_framework::object::{Self, Object, ConstructorRef, TransferRef, DeleteRef, LinearTransferRef, ExtendRef,
        generate_transfer_ref};
    use aptos_framework::event;
    use aptos_framework::guid::creator_address;

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct MyCustomObjectData has key {
        object_type: String,
        data_payload: String,
    }

    #[resource_group_member(group = aptos_framework::object::ObjectGroup)]
    struct ObjectCapabilities has key {
        transfer_ref: TransferRef,
        //delete_ref: DeleteRef,
        //extend_ref: ExtendRef,
        //linear_transfer_ref: LinearTransferRef,
    }

    #[event]
    struct NormalObjectCreatedEvent has drop, store {
        creator: address,
        object_address: address,
        data_payload: String
    }

    public entry fun create_normal_obj(creator: &signer){
        let creator_addr = signer::address_of(creator);

        let constructor_ref = object::create_object(creator_addr);

        let object_signer = object::generate_signer(&constructor_ref);
        let object_addr = signer::address_of(&object_signer);

        let transfer_ref= generate_transfer_ref(&constructor_ref);

        move_to(&object_signer, ObjectCapabilities{
            transfer_ref,
            //delete_ref,
            //extend_ref,
            //linear_transfer_ref
        });
    }
}

