#[starknet::interface]
trait IContractA<TContractState> {
    fn set_value(ref self: TContractState, value: u128) -> bool;
    fn get_value(self: @TContractState) -> u128;
}


#[starknet::contract]
mod ContractA {
    use starknet::ContractAddress;
    use super::IContractBDispatcher;
    use super::IContractBDispatcherTrait;

    #[storage]
    struct Storage {
        contract_b: ContractAddress,
        value: u128,
    }

    #[constructor]
    fn constructor(ref self: ContractState, contract_b: ContractAddress) {
        self.contract_b.write(contract_b)
    }

    #[abi(embed_v0)]
    impl ContractAImpl of super::IContractA<ContractState> {
        fn set_value(ref self: ContractState, value: u128) -> bool {
            // TODO: check if contract_b is enabled.
            // If it is, set the value and return true. Otherwise, return false.
        let contract = IContractBDispatcher { contract_address: self.contract_b.read() };
        if contract.is_enabled() == true {
            self.value.write(value);
            return true;
            }
        false
        }

        fn get_value(self: @ContractState) -> u128 {
            self.value.read()
        }
    }
}

#[starknet::interface]
trait IContractB<TContractState> {
    fn enable(ref self: TContractState);
    fn disable(ref self: TContractState);
    fn is_enabled(self: @TContractState) -> bool;
}

#[starknet::contract]
mod ContractB {
    #[storage]
    struct Storage {
        enabled: bool
    }

    #[constructor]
    fn constructor(ref self: ContractState) {}

    #[abi(embed_v0)]
    impl ContractBImpl of super::IContractB<ContractState> {
        fn enable(ref self: ContractState) {
            self.enabled.write(true);
        }

        fn disable(ref self: ContractState) {
            self.enabled.write(false);
        }

        fn is_enabled(self: @ContractState) -> bool {
            self.enabled.read()
        }
    }
}
