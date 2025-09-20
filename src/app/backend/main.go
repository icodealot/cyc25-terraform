package main

import (
	"encoding/json"
	"net/http"
)

func main() {
	http.HandleFunc("/hello", hello)

	http.ListenAndServe(":8000", nil)
}

func hello(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	message := map[string]string{
		"message": "Hello, Commit Your Code!",
	}
	encoder := json.NewEncoder(w)
	encoder.Encode(message)
}
