#!/bin/bash

## IMPORTANT: replace this values with your deployment values
INT_IFACE=enp0s8
INT_NETWORK=192.168.250.0/24
EXT_IFACE=enp0s3

## enable forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward

## flush rules
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X

## default policy
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

## enable ip masquerade
iptables -t nat -A POSTROUTING -o $EXT_IFACE -j MASQUERADE

## allow established
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

## allow internal connections to all firewall exposed services
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i $INT_IFACE -s $INT_NETWORK -j ACCEPT

## allow external connections to ssh
iptables -A INPUT -i $EXT_IFACE -p tcp –dport 22 -j ACCEPT

## set forwarding rules
iptables -A FORWARD -i $INT_IFACE -o $EXT_IFACE -s $INT_NETWORK \
        -p icmp -j NFQUEUE --queue-num 100
iptables -A FORWARD -i $INT_IFACE -o $EXT_IFACE -s $INT_NETWORK \
        -p tcp -m tcp -m multiport --dports 80,443 -j NFQUEUE --queue-num 100
