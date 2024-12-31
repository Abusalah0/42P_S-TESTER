#!/bin/bash


EXEC="./push_swap"
CHECKER="./checker_linux"

GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m" # No color
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
LIGHT_BLUE="\033[0;36m"    # Light Blue color
WHITE="\033[0;37m"
MAGENTA="\033[0;35m"
echo -e "${GREEN}"
cat << "EOF"
,------.       ,---.      ,--------.,------. ,---. ,--------.,------.,------.     ,-----.,--.   ,--.    ,--.   ,--. ,---.    ,---.  ,--.   ,--.,--.   ,--. 
|  .--. '     '   .-'     '--.  .--'|  .---''   .-''--.  .--'|  .---'|  .--. '    |  |) /_\  `.'  /     |   `.'   |'   .-'  /  O  \ |  |   |  ||   `.'   | 
|  '--' |     `.  `-.        |  |   |  `--, `.  `-.   |  |   |  `--, |  '--'.'    |  .-.  \'.    /      |  |'.'|  |`.  `-. |  .-.  ||  |   |  ||  |'.'|  | 
|  | --',----..-'    |       |  |   |  `---..-'    |  |  |   |  `---.|  |\  \     |  '--' /  |  |       |  |   |  |.-'    ||  | |  ||  '--.|  ||  |   |  | 
`--'    '----'`-----'        `--'   `------'`-----'   `--'   `------'`--' '--'    `------'   `--'       `--'   `--'`-----' `--' `--'`-----'`--'`--'   `--' 
EOF

# Reset color to default
echo -e "${NC}"
declare -a TEST_CASES_FOR_3=(
  "3 2 1"
  "-1 5 4"
  "0 1 3"
  "-1 -2 -3"
  "10 20 30"
  "20 10 30"
)

declare -a TEST_CASES_FOR_5=(
  "-1 7 2 3 1"
  "0 -2 10 100 200"
  "9 10 20 -30 29"
  "5 4 3 2 1"
  "-100 -200 -300 -400"
)

declare -a TEST_CASES_ERRORS_HARDMODE=(
  "0 7 2 3 0"
  "10 2147483648"
  "10 -2147483649"
  "10 -9223372036854775807"
  "10 9223372036854775807"
  "10 18446744073709551615"
  "2147483648"
  "-2147483649"
  "-9223372036854775807"
  "9223372036854775807"
  "18446744073709551615"
)

declare -a TEST_CASES_ERRORS_HARDMODE=(
  "0 7 2 3 0"
  "10 2147483648"
  "10 -2147483649"
  "10 -9223372036854775807"
  "10 9223372036854775807"
  "10 18446744073709551615"
  "2147483648"
  "-2147483649"
  "-9223372036854775807"
  "9223372036854775807"
  "18446744073709551615"
)

generate_random_test_cases() {
  local size=$1
  shuf -i 1-$size -n $size | tr '\n' ' '
}

test_cases_for_100=$(generate_random_test_cases 100) #this gives us 100 random numbers;
test_cases_for_500=$(generate_random_test_cases 500) #and this 500 random numbers;

test_case() {
  local array=$1
  if [ ! -f "$EXEC" ]; then
    echo -e "${RED}Executable not found! -> make sure to (make)${NC}";
    return
  fi
   if [ ! -f $CHECKER ]; then
    echo -e "${RED}Executable 'checker' not found! -> make sure it exists or check permissions!${NC}"
    return
   fi

  INSTRUCITONS=$(timeout 3 "$EXEC" "$array")
  if [ "$?" -eq 124 ]; then
    echo -e "${RED}TIMEOUT: KO!${NC}"
    return;
  fi
  if [ -z "$INSTRUCITONS" ]; then
    CHECKER_OUTPUT=$($CHECKER $array < "/dev/null")
  else
    CHECKER_OUTPUT=$($CHECKER $array <<< $INSTRUCITONS)
  fi
  echo -e "test case : $array"
  OPERATIONS=$(wc -l <<< "$INSTRUCITONS")
  echo -e "${GREEN}Operations: $OPERATIONS${NC}"

  if [ "$CHECKER_OUTPUT" == "OK" ]; then
    echo -e "${GREEN}sorted Correctly! OK!!!${NC}"
  else
    echo -e "${RED}KO!${NC}"
  fi

}

test_case_errors() {
  local array=$1
  if [ ! -f "$EXEC" ]; then
    echo -e "${RED}Executable not found! -> make sure to (make)${NC}";
    return
  fi

  echo -e "test case : $array"
  OUTPUT=$(timeout 3 "$EXEC" "$array" 2>&1)
  if [ "$?" -eq 124 ]; then
    echo -e "${RED}TIMEOUT: KO!${NC}"
    return;
  fi
  if [ "$OUTPUT" == "Error" ]; then
    echo -e "${GREEN}Error as expected.${NC}"
  else
    echo -e "${RED}KO, Expected Error!${NC}"
  fi
}

echo -e "${YELLOW}=== Testing Arrays of Size 3 ===${NC}"
for case in "${TEST_CASES_FOR_3[@]}"; do
  test_case "$case"
done


echo -e "${YELLOW}=== Testing Arrays of Size 5 ===${NC}"
for case in "${TEST_CASES_FOR_5[@]}"; do
  test_case "$case"
done

echo -e "${LIGHT_BLUE}=== Testing Arrays of Size 100 ===${NC}"
for case in "${test_cases_for_100[@]}"; do
  test_case "$case"
done


echo -e "${LIGHT_BLUE}=== Testing Arrays of Size 500 ===${NC}"
for case in "${test_cases_for_500[@]}"; do
  test_case "$case"
done

echo -e "${RED}=== Testing Hardmode Errors Cases ===${NC}"
for case in "${TEST_CASES_ERRORS_HARDMODE[@]}"; do
  test_case_errors "$case"
done


echo -e  "\n"
echo -e "${MAGENTA}intra-name :  msalim -> DM me for any feedback , Good luck with your Projects! \U1F49C ${NC}"

