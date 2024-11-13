    let mut i: usize = 0;
    loop {
        if i > n {
            break;
        }
        let key = i.into();  // Convert usize to felt252
        let value = dict.get(key);
        dict.insert(key, value * 10);
        i += 1;
    }
