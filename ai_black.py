import xmlrpclib
from SimpleXMLRPCServer import SimpleXMLRPCServer
import sys


p = sys.argv[0]

def python_logo():
    return "hi"

server = SimpleXMLRPCServer(("localhost", p))
print("Listening on port :",p)
server.register_function(python_logo, 'python_logo')
server.serve_forever()
