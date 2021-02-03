package main

import (
	"github.com/dilingchen/myapp-go/server"
)

func main(){
	s := server.NewServer()
 	err := s.ListenAndServe()
	if err!=nil {
		panic(err.Error())
	}
}
