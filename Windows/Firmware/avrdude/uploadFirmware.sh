#!/bin/sh
avrdude -F -V -c arduino -p ATMEGA328P -P $1 -b 115200 -U flash:w:firmware_12s.hex
