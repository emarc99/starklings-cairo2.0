#[starknet::contract]
mod LizInventory {
    use starknet::ContractAddress;
    use starknet::get_caller_address;

    #[storage]
    struct Storage {
        contract_owner: ContractAddress,
        // TODO: add storage inventory, that maps product (felt252) to stock quantity (u32)
        inventory: LegacyMap<felt252, u32>
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.contract_owner.write(owner);
    }


    #[abi(embed_v0)]
    impl LizInventoryImpl of super::ILizInventory<ContractState> {
        fn add_stock(ref self: ContractState, product: felt252, new_stock: u32 ) {
            // TODO:
            // * takes product and new_stock
            // * adds new_stock to stock in inventory
            // * only owner can call this
            assert(get_caller_address() == self.contract_owner.read(), 'Caller is not the owner');
            let current_stock = self.inventory.read(product);
            self.inventory.write(product, current_stock + new_stock);
        }

        fn purchase(ref self: ContractState, product: felt252, quantity: u32) {
            // TODO:
            // * takes product and quantity
            // * subtracts quantity from stock in inventory
            // * anybody can call this
            
                let current_stock = self.inventory.read(product);
                assert(current_stock >= quantity, 'Insufficient stock');
    
                self.inventory.write(product, current_stock - quantity);
        }

        fn get_stock(self: @ContractState, product: felt252)  -> u32 {
            // TODO:
            // * takes product
            // * returns product stock in inventory
            self.inventory.read(product)
        }

        fn get_owner(self: @ContractState) -> ContractAddress {
            self.contract_owner.read()
        }
    }
}