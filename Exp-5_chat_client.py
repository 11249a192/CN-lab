import socket

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect(("127.0.0.1", 12346))

print("Connected to Chat Server!")
print("Type 'exit' to close the chat.")

while True:
    message = input("You: ")
    client.sendall(message.encode())

    if message.lower() == "exit":
        break

    reply = client.recv(1024).decode()

    if not reply or reply.lower() == "exit":
        print("Server disconnected.")
        break

    print("Server:", reply)

client.close()
print("Chat Client closed.")

#output
Connected to Chat Server!
Type 'exit' to close the chat.
You: Hello
Server: Hi!
You: How are you?
Server: I am fine.
You: What are you doing?
Server: I am chatting with you.
You: exit
Chat Client closed.
