use starknet::ContractAddress;

#[starknet::interface]
trait IProgressTracker<TContractState> {
    fn set_progress(ref self: TContractState, user: ContractAddress, new_progress: u16);
    fn get_progress(self: @TContractState, user: ContractAddress) -> u16;
    fn get_contract_owner(self: @TContractState) -> ContractAddress;
}

#[starknet::contract]
mod ProgressTracker {
    use starknet::ContractAddress;
    use starknet::get_caller_address; // Required to use get_caller_address function

    #[storage]
    struct Storage {
        contract_owner: ContractAddress,
        // TODO: Set types for LegacyMap
        progress: LegacyMap<ContractAddress, u16>
    }

    #[constructor]
    fn constructor(ref self: ContractState, owner: ContractAddress) {
        self.contract_owner.write(owner);
    }


    #[abi(embed_v0)]
    impl ProgressTrackerImpl of super::IProgressTracker<ContractState> {
        fn set_progress(
            ref self: ContractState, user: ContractAddress, new_progress: u16
        ) { // TODO: assert owner is calling
        let caller = get_caller_address();
        assert(caller == self.contract_owner.read(), 'Caller is not the owner');
        // TODO: set new_progress for user,
        self.progress.write(user, new_progress)
        
        }

        fn get_progress(self: @ContractState, user: ContractAddress) -> u16 { // Get user progress
        self.progress.read(user)

        }

        fn get_contract_owner(self: @ContractState) -> ContractAddress {
            self.contract_owner.read()
        }
    }
}