import socket

# Create TCP socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind server to localhost and port
server_socket.bind(("127.0.0.1", 12345))
server_socket.listen(1)

print("Echo Server is waiting for a connection...")

conn, addr = server_socket.accept()
print("Connected by:", addr)

while True:
    data = conn.recv(1024)

    if not data:
        break

    print("Client:", data.decode())
    conn.sendall(data)

conn.close()
server_socket.close()
print("Server closed.")

#output
Echo Server is waiting for a connection...
Connected by: ('127.0.0.1', 54321)
Client: Hello
Client: How are you?
Client: Python
Server closed.
