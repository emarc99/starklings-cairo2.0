#[test]
fn test_options() {
    let target = 'starklings';
    let optional_some = Option::Some(target);
    let optional_none: Option<felt252> = Option::None;
    simple_option(optional_some);
    simple_option(optional_none);
}

fn simple_option(optional_target: Option<felt252>) {
    // TODO: use the `is_some` and `is_none` methods to check if `optional_target` contains a value.
    // Place the assertion and the print statement below in the correct blocks.
    
       match optional_target {
        Option::Some(value) => {
            assert(value == 'starklings', 'err1');
            // You can add more code here to handle the Some case
        },
        Option::None => {
            println!("option is empty!");
            // You can add more code here to handle the None case
        },
    }
    
}