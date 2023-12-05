import socket
import sys

sys.stdout.write('Stdout\n') ; sys.stdout.flush()
#sys.stderr.write('Stderr \n') ; sys.stderr.flush()

HOST = '0.0.0.0'                 # Symbolic name meaning all available interfaces
PORT = 19132             # Arbitrary non-privileged port

SERVER_IP = "127.0.0.1"
SERVER_PORT = 19135

server_address = (SERVER_IP, SERVER_PORT)
client_address = ("",0)

sys.stdout.write('Waiting for Client -StdOut\n') ; sys.stdout.flush()
#print("Waiting for Client")
with socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP) as s:
    s.bind((HOST, PORT))
    s.setblocking(True)
    while True:
        #sys.stdout.write('Enter Loop\n') ; sys.stdout.flush()
        bytes_, adress_ = s.recvfrom(1024 * 1024 * 8)

        tartByte = bytes_[0]
        if bytes_[0] == 1:
            sys.stdout.write(f"Found Client ip: {adress_[0]} on port: {adress_[1]}\n"); sys.stdout.flush()
            client_address = adress_

            s.sendto(bytes_, server_address)
            s.settimeout(5)
            bytes_, adress_ = s.recvfrom(1024 * 1024 * 8)
            s.settimeout(None)
            if bytes_[0] == 0x1c and adress_ == server_address:
                sys.stdout.write("Got ping response from server\n"); sys.stdout.flush()
                s.sendto(bytes_, client_address)
        elif bytes_[0] == 5:
            client_address = adress_
            sys.stdout.write(f"Got connection {adress_[0]} on port: {adress_[1]}\n"); sys.stdout.flush()
            break

    s.settimeout(None)
    while True:
        bytes_, adress_ = s.recvfrom(1024 * 1024 * 8)
        print(f"Rec Size {len(bytes_)}")
        if adress_ == server_address:
            size = s.sendto(bytes_, client_address)
        elif adress_ == client_address:
            size = s.sendto(bytes_, server_address)
        else:
            pass
