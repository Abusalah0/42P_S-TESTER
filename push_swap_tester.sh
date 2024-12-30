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

  CHECK_RESULT=$($EXEC $array | $CHECKER $array)

  echo -e "test case : $array"
  OUTPUT=$($EXEC $array)
  OPERATIONS=$(wc -l <<< "$OUTPUT")
  echo -e "${GREEN}Operations: $OPERATIONS${NC}"

  if [ "$CHECK_RESULT" == "OK" ]; then
    echo -e "${GREEN}sorted Correctly! OK!!!${NC}"
  else
    echo -e "${RED}KO!${NC}"
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


echo -e  "\n"
echo -e "${MAGENTA}intra-name :  msalim -> DM me for any feedback , Good luck with your Projects! \U1F49C ${NC}"

