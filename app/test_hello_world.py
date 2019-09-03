import unittest
import os
import flaskapi
import requests
import json
import sys
from credtodos
import credtodos

class TestFlaskApiUsingRequests(unittest.TestCase):
    def setUp(self):
        self.app = hello_world.app.test_client()
        self.app.testing = True

    def test_status_code(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 401)

    def test_bucketlist_can_be_edited(self):
        """Test API can edit an existing bucketlist. (PUT request)"""
        
        rv = self.client().put(
            '/',
            data={
                "Authorization": "Token credtodos"
            })
        self.assertEqual(rv.status_code, 201)
        results = self.client().get('/')
        self.assertIn('devops test server flying!!', str(results.data))    


if __name__ == "__main__":
    unittest.main()