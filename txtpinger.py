#!/usr/bin/python3
import sys
import json
import pingparsing
import logging


class Pinger:

    def __init__(self):
        logging.info('Iniciando test')
        self.count = 5
        self.timeout = 1000
        self.deadline = 3000

    def pinga(self, destination):
        ping_parser = pingparsing.PingParsing()
        transmitter = pingparsing.PingTransmitter()
        transmitter.destination = destination
        transmitter.count = self.count
        transmitter.deadline = self.deadline
        transmitter.timeout = self.timeout
        try:
            result = transmitter.ping()
            resultasdict = json.loads((json.dumps(ping_parser.parse(result).as_dict(), indent=4)))
            return(resultasdict)
        except Exception as e:
            logging.error('Error en ping: {}'.format(e))
            return False

destination = sys.argv[1]
pinger = Pinger()
d = pinger.pinga(destination)
print(f"{d['rtt_min']} {d['packet_loss_rate']}")
#print(f"Latencia: Min: {d['rtt_min']}ms Max: {d['rtt_max']}ms Prom: {d['rtt_avg']}ms - perdida: {d['packet_loss_rate']}%")