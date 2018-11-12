#!/bin/bash
clear
flex plates.l
cc lex.yy.c -lfl
./a.out
