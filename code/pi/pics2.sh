#!/bin/bash
DATE=$(date +"%Y-%m-%d_%H%M")
raspistill -vf -hf -o /home/pi/picsMG/$DATE.jpg
