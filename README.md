# Script Usage Guide

This script is designed to test the `push_swap` algorithm. It requires the following executables to be present in the same directory:

- **push_swap**: The executable that implements the push_swap algorithm.
- **checker_linux**: The executable that checks if the result of the `push_swap` is correct.
- **tester**: A script that helps test the `push_swap` algorithm with different inputs.

You can follow the instructions below to get started.

## Prerequisites

Before running the script, ensure that the following conditions are met:

1. **Executables (`push_swap`, `checker_linux`, `tester`)**:
   - The `push_swap` and `checker_linux` executables must exist in the same directory as the script. 
   - Ensure the `tester` file is also in the same directory.
   
2. **Permissions**:
   - The `push_swap` and `checker_linux` executables must have the appropriate execute permissions. You can grant them execute permissions by running:
     ```bash
     chmod +x checker_linux push_swap_tester
     ```

3. **Configuration (Optional)**:
   - If your `push_swap` or `checker_linux` executables are located elsewhere, you can change the variables `EXEC` and `CHECKER` in the script to point to their respective paths.
   - Example:
     ```bash
     EXEC="/path/to/push_swap"
     CHECKER="/path/to/checker_linux"
     ```

## Installation

1. **Clone the Tester Repository**:
   - Clone the tester repository that contains the script and executables. To clone the repository, run the following command:
     ```bash
     git clone <repository_url>
     ```

2. **Navigate to the Directory**:
   - Change to the directory where the script and executables are located:
     ```bash
     cd path/to/your/directory
     ```

3. **Ensure Executable Permissions**:
   - Make sure the `push_swap` and `checker_linux` executables have execute permissions:
     ```bash
     chmod +x push_swap_tester checker_linux
     ```

## Running the Script

1. **Execute the Script**:
   - Once the necessary files are in place, and permissions are set, you can run the script by executing the following:
     ```bash
     ./push_swap_tester.sh
     ```
   - The script will use the `push_swap` and `checker_linux` executables to test the algorithm.

2. **Changing Executables (Optional)**:
   - If you want to use a different `push_swap` or `checker_linux`, you can modify the variables `EXEC` and `CHECKER` at the beginning of the script. For example:
     ```bash
     EXEC="/path/to/your_push_swap"
     CHECKER="/path/to/your_checker_linux"
     ```

3. **Enabling Hardmode (Optional)**:
   - If you want more strict tests then you can pass `hardmode` argument when running the script:
      ```
      bash push_swap_tester.sh hardmode
      ```
   - By enabling hardmode it will reduce the timeout from 10 seconds to 3 seconds and strict tests will be tested.

## General Workflow

1. **Clone the Tester**:
   - Clone the repository to get started with the tests.

2. **Place Executables in the Same Directory**:
   - Ensure that `push_swap`, `checker_linux`, and the `tester` script are in the same directory as the script you're going to run.

3. **Run the Script**:
   - Execute the script to start testing the `push_swap` algorithm.

4. **Test Results**:
   - The script will automatically check the correctness of your `push_swap` algorithm by comparing the output against the checker. You will see the test results in the terminal.

## Troubleshooting

- **Error: Executable Not Found**:
  - Ensure that the `push_swap` and `checker_linux` files are in the same directory as the script and have execute permissions. You can check their existence using:
    ```bash
    ls -l push_swap checker_linux
    ```

- **Permissions Issue**:
  - If the script or executables do not have execute permissions, use the `chmod +x` command to set the correct permissions.
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

