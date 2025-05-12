module my_address::hello_wallet{
    use std::string::{String, utf8};
    use std::signer;
    use std::debug;

    fun say_hello(account: &signer): (String, address) {
        let account_address = signer::address_of(account);
        let greeting = utf8(b"Hello Petra Wallet!");

        (greeting, account_address)
    }

    #[test(account_signer = @0x2)]
    fun print_greeting_and_address(account_signer: &signer){

        let (greeting, addr) = say_hello(account_signer);
        debug::print(&greeting);
        debug::print(&addr);
    }
}