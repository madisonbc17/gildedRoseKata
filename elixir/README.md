# Elixir Guilded Rose Kata
## Item Struct Approach

Elixir's pattern matching makes working with strict, unmodifiable structs like `Item` somewhat awkward, since each function call typically creates a new struct or map. However, in real world scenarios, it's common to encounter legacy database tables where adding new columns is difficult and requires extensive data backfilling. For this kata, I imagine the Gilded Rose Inn has been collecting data for centuries, so the Goblin is understandably resistant to modifying the `Item` struct.

If the Gilded Rose were a brand new inn, I would design the `Item` struct to include a `type` field. This field would determine how properties like `quality` (and potentially others, such as `price`) are calculated, while the `name` would simply describe the item. For example, "+5 Dexterity Vest" would have a `type` of "normal", and "Backstage passes to ..." would have a `type` of "backstage_pass". This separation makes the codebase more flexible and maintainable, as item behavior would not be tied to the item's name.

## Running the Tests

This project uses Elixir's built-in testing framework, ExUnit.

### Prerequisites

- Ensure you have Elixir installed:
    ```
    elixir --version
    ```
- Install project dependencies:
    ```
    mix deps.get
    ```

### Running the Tests

To run all tests:
```
mix test
```
This will compile the project (if necessary) and run all test files in the `test/` directory.

### Additional Notes

- Run a specific test file:
    ```
    mix test test/<filename>_test.exs
    ```
- For detailed output:
    ```
    mix test --trace
    ```
- Ensure your environment is properly configured for testing.

If you encounter issues, consult the project documentation or open an issue.
