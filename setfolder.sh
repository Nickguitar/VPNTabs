#!/bin/bash
# Nicholas Ferreira - github.com/Nickguitar
# 08/10/21
touch setup.sh
sed 's?ABSOLUTEPATH?'`pwd`'?g' defaultsetup.sh > setup.sh
chmod +x setup.sh
