#!/bin/bash

sudo apt-get remove subversion libsvn1

sudo apt-get install libsvn1=1.6.17dfsg-3ubuntu3 
sudo apt-get install subversion=1.6.17dfsg-3ubuntu3 

sudo echo "libsvn1 hold" | sudo dpkg --set-selections
sudo echo "subversion hold" | sudo dpkg --set-selections

