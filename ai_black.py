import xmlrpclib
from SimpleXMLRPCServer import SimpleXMLRPCServer
import sys


p = sys.argv[1]

print p

def python_logo(hey):
    return "hi"

server = SimpleXMLRPCServer(("localhost", int(p)))
print("Listening on port :",p)
server.register_function(python_logo, 'python_logo')
server.serve_forever()
