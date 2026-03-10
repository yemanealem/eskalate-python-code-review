# AI Python Code Review Assignment

## Run Tests Locally

Install dependencies:

pip install -r requirements.txt

Run tests:

python -m pytest -v

## Run Tests with Docker

Build the image:

docker build -t eskalate-assignment .

Run tests:

docker run --rm eskalate-assignment
