#runmeonce.sh
echo "Installing sfu-util"
sudo apt-get install dfu-util
echo "installing PIP"
sudo pip install hid
echo "installing libfuse2"
sudo apt install libfuse2 libhidapi-hidraw0 libhidapi-libusb0
echo "Getting AIOC.PY"
wget www.g1lro.uk/aioc.py
echo "Getting AIOC-REVERT.PY"
wget www.g1lro.uk/aioc-revert.py
echo "Getting firmware falsh"
wget www.g1lro.uk/flash1.3.sh
echo "Making firmware flash executable"
sudo chmod +x flash1.3.sh
echo "Getting AIOC Firmware 1.3"
wget www.g1lro.uk/aioc-fw-1.3.0-rc.1.bin
echo "Processe complete"