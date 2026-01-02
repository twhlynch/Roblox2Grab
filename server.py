from flask import Flask, request
import time
import json

app = Flask(__name__)


@app.route("/", methods=["POST"])
def receive_data():
    data = request.json
    message = data["message"]

    with open(f"{int(time.time())}.json", "w") as file:
        json.dump(message, file, indent=2)

    return "Received data!"


if __name__ == "__main__":
    app.run()
