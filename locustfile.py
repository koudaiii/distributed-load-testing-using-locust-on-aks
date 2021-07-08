import time
from locust import HttpUser, task, between
from lib.example_functions import choose_random_page

default_headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36'}

class WebsiteUser(HttpUser):
    wait_time = between(1, 2.5)

    @task
    def hello_world(self):
        with self.client.get("/", catch_response=True) as response:
            print("Response status code:", response.status_code)
            print("Response text:", response.text)
            if response.text != "Hello, World!":
                response.failure("Got wrong response")
            elif response.elapsed.total_seconds() > 0.5:
                response.failure("Request took too long")

    @task(3)
    def get_random_page(self):
        self.client.get(choose_random_page(), headers=default_headers)

    def on_start(self):
        pass
