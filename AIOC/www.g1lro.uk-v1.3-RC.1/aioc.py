#simon script
import sys
import hid
from struct import Struct
from enum import IntEnum, IntFlag

class Register(IntEnum):
    MAGIC = 0x00
    USBID = 0x08
    AIOC_IOMUX0 = 0x24
    AIOC_IOMUX1 = 0x25
    CM108_IOMUX0 = 0x44
    CM108_IOMUX1 = 0x45
    CM108_IOMUX2 = 0x46
    CM108_IOMUX3 = 0x47
    SERIAL_CTRL = 0x60
    SERIAL_IOMUX0 = 0x64
    SERIAL_IOMUX1 = 0x65
    SERIAL_IOMUX2 = 0x66
    SERIAL_IOMUX3 = 0x67
    VPTT_LVLCTRL = 0x82
    VPTT_TIMCTRL = 0x84
    VCOS_LVLCTRL = 0x92
    VCOS_TIMCTRL = 0x94

    
class Command(IntFlag):
    DEFAULTS = 0x10
    RECALL = 0x40
    STORE = 0x80


def read(device, address):
    data = device.get_feature_report(int(address), 5)
    address, value = Struct('<BL').unpack(data)
    return value

def write(device, address, value):
    data = Struct('<BL').pack(address, value)
    device.send_feature_report(data)

# AIOC is searched for on the system using these values
aioc = hid.Device(vid=0x1209, pid=0x7388)

magic = Struct("<L").pack(read(aioc, Register.MAGIC))

if (magic != b'AIOC'):
    sys.exit(-1)

print(f'Manufacturer: {aioc.manufacturer}')
print(f'Product: {aioc.product}')
print(f'Serial No: {aioc.serial}')
print(f'Magic: {magic}')

if True:
    # Load the hardware defaults
    print(f'Loading Defaults...')
    write(aioc, 0, Command.DEFAULTS)

if True:
    # Set USB VID and PID (use with caution. Will need changes above to be able>
    vid = 0x0d8c # Set VID here
    pid = 0x000c # Set PID here
    write(aioc, Register.USBID, (vid << 0) | (pid << 16))
    print(f'Now USBID: {read(aioc, Register.USBID):08x}')

if True:
    # Set VCOS trail time
    vcos_trail_ms = 1500
    write(aioc, Register.VCOS_TIMCTRL, (vcos_trail_ms << 4))
    print(f'Now VCOS_TIMCTRL: {read(aioc, Register.VCOS_TIMCTRL):08x}')

if True:
    # Store settings into flash
    print(f'Storing...')
    write(aioc, 0, Command.STORE)