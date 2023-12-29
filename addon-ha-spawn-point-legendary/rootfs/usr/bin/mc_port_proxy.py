import argparse
import socket
import sys

sys.stdout.write('Stdout\n') ; sys.stdout.flush()
#sys.stderr.write('Stderr \n') ; sys.stderr.flush()

parser = argparse.ArgumentParser()

parser.add_argument("--port_server", action="store_true", default=19135, help="uses copy instead move for files")
parser.add_argument("--ip_server", action="store_true", default="127.0.0.1", help="uses copy instead move for files")
parser.add_argument("--port_host", action="store_true", default=19132, help="uses copy instead move for files")
parser.add_argument("--ip_host", action="store_true", default='0.0.0.0', help="uses copy instead move for files")

args = parser.parse_args()

server_address = (args.ip_server, args.port_server)
client_address = ("",0)

sys.stdout.write('Waiting for Client\n')
sys.stdout.flush()

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM, socket.IPPROTO_UDP) as s:
    s.bind((args.ip_host, args.port_host))
    s.setblocking(True)
    while True:
        #sys.stdout.write('Enter Loop\n') ; sys.stdout.flush()
        bytes_, adress_ = s.recvfrom(1024 * 1024 * 8)

        tartByte = bytes_[0]
        if bytes_[0] == 1:
            sys.stdout.write(f"Found Client ip: {adress_[0]} on port: {adress_[1]}\n")
            sys.stdout.flush()
            client_address = adress_

            s.sendto(bytes_, server_address)
            s.settimeout(5)
            bytes_, adress_ = s.recvfrom(1024 * 1024 * 8)
            s.settimeout(None)
            if bytes_[0] == 0x1c and adress_ == server_address:
                sys.stdout.write("Got ping response from server\n")
                sys.stdout.flush()
                s.sendto(bytes_, client_address)
        elif bytes_[0] == 5:
            client_address = adress_
            sys.stdout.write(f"Got connection {adress_[0]} on port: {adress_[1]}\n")
            sys.stdout.flush()
            break

    s.settimeout(None)
    while True:
        bytes_, adress_ = s.recvfrom(1024 * 1024 * 8)
        sys.stdout.write(f"Traffic: {adress_[0]} on port: {adress_[1]}\n")
        sys.stdout.flush()
        if adress_ == server_address:
            size = s.sendto(bytes_, client_address)
        elif adress_ == client_address:
            size = s.sendto(bytes_, server_address)
        else:
            pass
