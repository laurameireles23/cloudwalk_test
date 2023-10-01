# Cloudwalk Test - Player Score Analysis

This repository contains a test developed in Ruby to calculate players' scores in a first-person shooter game called Quake III Arena. The test is based on a data structure provided through a log file and provides a ranking of players based on their scores, as well as the cause of deaths and a summary of each match.


## Como Executar


To execute this test, follow the steps below:

1. **Clone the Repository**: Clone this repository to your local environment using the following command:

    ```bash
    git clone https://github.com/laurameireles23/cloudwalk_test.git
    ```

2. **Navigate to the Project Directory**: Use the `cd` command to enter the project folder:

    ```bash
    cd cloudwalk_test
    ```

3. **Execute the Ruby Script**: Use Ruby to execute the `quake.rb` file:

    ```bash
    ruby quake.rb
    ```

4. **Execution Result**: After the successful execution of the script, you will see a ranking of players based on their scores, as well as the cause of deaths and a summary of each match.
Example:
```
Summary of game matches:
{
  "game_2"=>{
    "total_kills"=>15,
    "players"=>[
       "Isgalamido",
       "Mocinha",
       "Zeh",
       "Dono da Bola"
     ],
   "kills"=>{
     "game_2"=>{
       "Isgalamido"=>-8,
       "Mocinha"=>0,
       "Zeh"=>-2,
       "Dono da Bola"=>-1
       }
     }
  }
   
----------------------------
Reason for deaths per round:
{"game-2"=>{"kills_by_means"=>{"MOD_TRIGGER_HURT"=>9, "MOD_ROCKET_SPLASH"=>3, "MOD_FALLING"=>2, "MOD_ROCKET"=>1}}}
----------------------------
Rating of players:
1. Mocinha: 0 points
2. Dono da Bola: -1 points
3. Zeh: -2 points
4. Isgalamido: -8 points
```

## Project Structure

The project structure is quite simple:

- `quake.rb`: The main file that contains the code for generating data for analysis.
- `quake.log`: A file containing information for the execution of the main file.

## Requirements

- Ruby: Make sure you have Ruby installed on your system to run the script.

## Contributions

Contributions are welcome! Feel free to open issues or send pull requests to improve this test.

---

**Note**: This is a test project created for technical evaluation purposes at Cloudwalk.
