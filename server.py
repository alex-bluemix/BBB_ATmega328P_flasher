from os import curdir
from os.path import join as pjoin
import subprocess

sketch = 'sketch.hex'

from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

class StoreHandler(BaseHTTPRequestHandler):
    store_path = pjoin(curdir, sketch)

    def do_GET(self):
        if self.path == '/store.json':
            with open(self.store_path) as fh:
                self.send_response(200)
                self.send_header('Content-type', 'text/json')
                self.end_headers()
                self.wfile.write(fh.read().encode())

    def do_POST(self):
        status_code = 503

        if self.path == '/' + sketch:
            length = self.headers['content-length']
            data = self.rfile.read(int(length))

            print "Received File"
            with open(self.store_path, 'wb') as fh:
                fh.write(data)

            try:
                subprocess.check_call(["./upload.sh", sketch])
                status_code = 200
            except subprocess.CalledProcessError:
                status_code = 500

            self.send_response(status_code)


server = HTTPServer(('', 8080), StoreHandler)
server.serve_forever()
