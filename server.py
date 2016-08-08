import socket

import socket
import sys

HOST = ''   # Symbolic name, meaning all available interfaces
PORT = 5003 # Arbitrary non-privileged port

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print 'Socket created'

#Bind socket to local host and port
try:
    s.bind((HOST, PORT))
except socket.error as msg:
    print 'Bind failed. Error Code : ' + str(msg[0]) + ' Message ' + msg[1]
    sys.exit()

print 'Socket bind complete'

#Start listening on socket
s.listen(10)
print 'Socket now listening'

#now keep talking with the client
while 1:
    #wait to accept a connection - blocking call
    conn, addr = s.accept()
    print 'Connected with ' + addr[0] + ':' + str(addr[1])

    data = conn.recv(1024).decode()
    print("fron connected user: ", str(data))
s.close()

# def Main():
    # host = "127.0.0.1"
    # port = 5001
    # mySocket = socket.socket()
    # mySocket.bind((host,port))
    # mySocket.listen(1)
    # conn, addr = mySocket.accept()
    # print ("Connection from: " + str(addr))
    # while True:
        # data = conn.recv(1024).decode()
        # if not data:
                # break
        # print ("from connected  user: " + str(data))
        # data = str(data).upper()
        # print ("sending: " + str(data))
        # conn.send(data.encode())
    # conn.close()
# if __name__ == '__main__':
    # Main()
