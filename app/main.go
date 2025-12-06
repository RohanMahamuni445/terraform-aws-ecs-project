package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello from DevOps demo!")
    })

    http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "OK")
    })

    fmt.Println("Server running on port 8080")
    http.ListenAndServe(":8080", nil)
}

