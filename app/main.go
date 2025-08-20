package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strings"
	"unicode"
)

// RequestBody defines the expected structure of the JSON input.
// It should contain a single field: "sentence".
type RequestBody struct {
	Sentence string `json:"sentence"`
}

// ResponseBody defines the structure of the JSON response.
// It will contain the counts for words, vowels, and consonants.
type ResponseBody struct {
	Words      int `json:"words"`
	Vowels     int `json:"vowels"`
	Consonants int `json:"consonants"`
}

// analyzeTextHandler is the HTTP handler for the /analyze endpoint.
// It accepts a POST request with a JSON body, analyzes the text,
// and returns the counts in a JSON response.
func analyzeTextHandler(w http.ResponseWriter, r *http.Request) {
	// Check if the request method is POST.
	if r.Method != "POST" {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	// Decode the JSON request body.
	var reqBody RequestBody
	err := json.NewDecoder(r.Body).Decode(&reqBody)
	if err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	// Count words, vowels, and consonants.
	words := countWords(reqBody.Sentence)
	vowels, consonants := countVowelsAndConsonants(reqBody.Sentence)

	// Create the response body.
	resBody := ResponseBody{
		Words:      words,
		Vowels:     vowels,
		Consonants: consonants,
	}

	// Set the Content-Type header to application/json.
	w.Header().Set("Content-Type", "application/json")

	// Encode and send the JSON response.
	err = json.NewEncoder(w).Encode(resBody)
	if err != nil {
		http.Error(w, "Failed to encode response", http.StatusInternalServerError)
	}
}

// countWords counts the number of words in a sentence.
// It uses strings.Fields to split the string by whitespace.
func countWords(s string) int {
	// Trim leading/trailing whitespace and split by one or more spaces.
	fields := strings.Fields(s)
	return len(fields)
}

// countVowelsAndConsonants iterates through a string and counts
// the number of vowels and consonants. It ignores non-alphabetic characters.
func countVowelsAndConsonants(s string) (vowels, consonants int) {
	s = strings.ToLower(s) // Convert to lowercase for easier comparison
	for _, char := range s {
		if !unicode.IsLetter(char) {
			continue // Skip characters that are not letters
		}

		switch char {
		case 'a', 'e', 'i', 'o', 'u':
			vowels++
		default:
			consonants++
		}
	}
	return
}

func main() {
	// Register the handler for the /analyze endpoint.
	http.HandleFunc("/analyze", analyzeTextHandler)

	// Start the web server on port 8080.
	fmt.Println("Server listening on port 8080...")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
