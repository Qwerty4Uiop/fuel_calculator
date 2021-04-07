![alt text](./apps/traveler/assets/static/images/nasa.png)
# fuel_calculator
App for calculating required fuel for launches and lands on space objects with different gravity.

The core logic is in calculator_core app. 

## Usage

You can use the core from the command line:

```
$ iex -S mix

iex(1)> CalculatorCore.calculate_fuel(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
{:ok, 51898}
```
or you can try the demo web app [here](http://82.148.30.32:4000/)

## Run on your own
### Requirements
[Docker](https://docs.docker.com/install/)  
[Docker-compose](https://docs.docker.com/compose/install/)  
### Running tests
```
$ bash deploy.sh -t
```
### Running web app
```
$ bash deploy.sh -s
```
### Running web app with tests
```
$ bash deploy.sh -ts
```