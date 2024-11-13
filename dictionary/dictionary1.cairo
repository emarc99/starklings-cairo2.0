#[generate_trait]
impl TeamImpl of TeamTrait {
    fn new() -> Team {
        Team {
            level: Default::default(),
            players_count: 0
        }
    }

    fn get_level(ref self: Team, name: felt252) -> usize {
        self.level.get(name)
    }

    fn add_player(ref self: Team, name: felt252, level: usize) {
        self.level.insert(name, level);
        self.players_count += 1;
    }
    fn level_up(ref self: Team, name: felt252) {
        let current_level = self.level.get(name);
        self.level.insert(name, current_level + 1);
    }
    fn get_players_count(self: @Team) -> usize {
        *self.players_count
    }
}
