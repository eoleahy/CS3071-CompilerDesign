#!/bin/bash
clear
flex comments.l
cc lex.yy.c -lfl
./a.out
