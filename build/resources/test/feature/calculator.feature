Feature: Calculator
    Scenario: Sum two numbers
        Given I have two numbers: 1 and 4
        When the calculator sums them
        Then I receive 5 as a result