setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/../src:$PATH"
}

teardown() {
    rm -f /tmp/bats-tutorial-project-ran
}

verify_move() {
    run mars-rover.sh $1
    assert_output $2
}

@test "Should stay at origin" {
    verify_move "" '0:0:N'
}

@test "Should move north" {
    verify_move "M" '0:1:N'
    verify_move "MM" '0:2:N'
    verify_move "MMM" '0:3:N'
    verify_move "MMMMMMMMMM" '0:0:N'
    verify_move "MMMMMMMMMMMM" '0:2:N'
}

@test "Should rotate right" {
    verify_move "R" '0:0:E'
    verify_move "RR" '0:0:S'
    verify_move "RRR" '0:0:W'
    verify_move "RRRR" '0:0:N'
    verify_move "RRRRR" '0:0:E'
}

@test "Should rotate left" {
    verify_move "L" '0:0:W'
    verify_move "LL" '0:0:S'
    verify_move "LLL" '0:0:E'
    verify_move "LLLL" '0:0:N'
    verify_move "LLLLL" '0:0:W'
}

@test "Should move east" {
    verify_move "RM" '1:0:E'
    verify_move "RMM" '2:0:E'
    verify_move "RMMM" '3:0:E'
    verify_move "RMMMMMMMMMM" '0:0:E'
    verify_move "RMMMMMMMMMMMM" '2:0:E'
}

@test "Should move south" {
    verify_move "RRM" '0:9:S'
    verify_move "RRMM" '0:8:S'
    verify_move "RRMMMMMMMMMM" '0:0:S'
    verify_move "RRMMMMMMMMMMM" '0:9:S'
}

@test "Should move west" {
    verify_move "LM" '9:0:W'
    verify_move "LMM" '8:0:W'
    verify_move "LMMMMMMMMMM" '0:0:W'
    verify_move "LMMMMMMMMMMM" '9:0:W'
}

@test "Should move around the grid" {
    verify_move "MMRMMLM" '2:3:N'
}
