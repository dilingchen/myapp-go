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
	go s.ListenAndServe()

	tr := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    30 * time.Second,
		DisableCompression: true,
	}
	client := &http.Client{Transport: tr}

	DefaultScheme := "http"
	DefaultHost := "localhost"
	url := &url.URL{
		Scheme: DefaultScheme,
		Host:	fmt.Sprintf("%s:%v", DefaultHost, DefaultPort),
		Path:	"greet",
	}

	req, err := http.NewRequest("GET", url.String(), nil)
	assert.Nil(t, err)
	resp1, err := client.Do(req)
	defer resp1.Body.Close()
	assert.Nil(t, err)
	assert.Equal(t, http.StatusOK, resp1.StatusCode)
	body1, err := ioutil.ReadAll(resp1.Body)
	assert.Nil(t, err)
	greeting := Greeting{}
	err = json.Unmarshal(body1, &greeting)
	assert.Nil(t, err)
	assert.Equal(t, "Hello", greeting.Greeting)

	url.Path = "healthz"
	req, err = http.NewRequest("GET", url.String(), nil)
	assert.Nil(t, err)
	resp2, err := client.Do(req)
        defer resp2.Body.Close()
	assert.Nil(t, err)
	assert.Equal(t, http.StatusOK, resp2.StatusCode)
	body2, err := ioutil.ReadAll(resp2.Body)
	assert.Nil(t, err)
	health := HealthStatus{}
	err = json.Unmarshal(body2, &health)
	assert.Nil(t, err)
	assert.Equal(t, "Normal", health.HealthStatus)
}

