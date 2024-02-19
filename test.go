package main

import (
	"fmt"
	"net/http"
)

func main() {
	println("Hello, World!")
	// create a handler
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, World!")
	})
	// create a route
	http.HandleFunc("/test", func(w http.ResponseWriter, r *http.Request) {
		// check request authorization header, print if present
		if auth_header := r.Header.Get("Authorization"); auth_header != "" {
			fmt.Fprintf(w, "Authorization Header: %s", auth_header)
		}
		fmt.Fprintf(w, "Testing")
	})
	// start the server
	http.ListenAndServe(":8080", nil)
}
