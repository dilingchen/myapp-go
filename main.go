package main

import (
	"github.com/dilingchen/myapp-go/server"
)

func main(){
	s:= server.NewServer()
	s.ListenAndServer()
}