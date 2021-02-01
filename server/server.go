package server

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"
)

const(
	DefaultPort int = 3000
)

type Greeting struct {
	Greeting string `json:"Greeting"`
}

type HealthStatus struct {
	HealthStatus string `json:"HealthStatus"`
}

func NewServer() *http.Server {
	serveMux := http.NewServeMux()
	serveMux.HandleFunc("/greet", func (w http.ResponseWrite, req *http.Request){
		response:= Greeting{
			Greeting: "Hello",
		}
		w.Header().Set("Content-Type", "application/json")
		output, err:= json.Marshal(response)
		if err!=nil {
			panic(err)
		}
		_, err=io.WriteString(w, string(output))
		if err!=nil {
			panic(err)
		}
	})
	serveMux.HandleFunc("/healthz", func (w http.ResponseWrite, req *http.Request){
		response:= HealthStatus{
			HealthStatus: "Normal",
		}
		w.Header().Set("Content-Type", "application/json")
		output, err:= json.Marshal(response)
		if err!=nil {
			panic(err)
		}
		_, err=io.WriteString(w, string(output))
		if err!=nil {
			panic(err)
		}
	})
	return &http.Server{
		Addr: 			fmt.Sprintf(":%v", DefaultPort),
		Handler: 		serveMux,
		ReadTimout:		10* time.Second,
		WriteTimout:	10* time.Second,
		MaxHeaderBytes: 1<<20,
	}
}