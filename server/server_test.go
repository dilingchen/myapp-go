package server

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"net/url"
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
)

func TestNewServer(t *testing.T) {
	s := NewServer()
	go s.ListenAndServer()

	tr := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    30 * time.Second,
		DisableCompression: true,
	}
	client := &http.Client{Transport: tr}

	DefaultSchema := "http"
	DefaultHost := "localhost"
	url := &url.URL{
		Schema: DefaultSchema,
		Host:	fmt.Sprintf("%s:%v", DefaultHost, DefaultPort),
		Path:	"greet",
	}

	req, err := http.NewRequest("GET", url.String(), nil)
	assert.Nil(t, err)
	resp, err := client.Do(req)
	defer resp.Body.Close()
	assert.Nil(t, err)
	assert.Equal(t, http.StatusOK, resp.StatusCode)
	body, err := ioutil.ReadAll(resp.Body)
	assert.Nil(t, err)
	greeting := Greeting{}
	err = json.Unmarshal(body, &greeting)
	assert.Nil(t, err)
	assert.Equal(t, "Hello", greeting.Greeting)

	url.Path = "healthz"
	req.err := http.NewRequest("GET", url.String(), nil)
	assert.Nil(t, err)
	resp, err := client.Do(req)
	defer resp.Body.Close()
	assert.Nil(t, err)
	assert.Equal(t, http.StatusOK, resp.StatusCode)
	body, err := ioutil.ReadAll(resp.Body)
	assert.Nil(t, err)
	greeting := Greeting{}
	err = json.Unmarshal(body, &greeting)
	assert.Nil(t, err)
	assert.Equal(t, "Normal", greeting.Greeting)
}