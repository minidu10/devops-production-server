from http.server import BaseHTTPRequestHandler, HTTPServer
import socket
import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s"
)

logger = logging.getLogger(__name__)
class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        hostname = socket.gethostname()

        logger.info("GET request received: %s", self.path)

        response = f"""
        <html>
            <head>
                <title>DevOps Project</title>
            </head>
            <body>
                <h1>🚀 My DevOps Server</h1>
                <p>Application is running!</p>
                <p>Server: {hostname}</p>
            </body>
        </html>
        """

        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(response.encode())

        logger.info("GET request completed: %s 200", self.path)

server = HTTPServer(("127.0.0.1", 8000), Handler)

print("Server running on port 8000...")
server.serve_forever()
