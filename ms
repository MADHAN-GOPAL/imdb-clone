import React, { useEffect, useState } from "react";

const API_KEY = "YOUR_API_KEY";

function MovieSearch() {
  const [search, setSearch] = useState("");
  const [movies, setMovies] = useState([]);
  const [loading, setLoading] = useState(false);
  const [noResults, setNoResults] = useState(false);

  useEffect(() => {
    if (search.trim() === "") {
      setMovies([]);
      setNoResults(false);
      return;
    }

    const timer = setTimeout(() => {
      getMovies();
    }, 500); // debounce delay

    return () => clearTimeout(timer);
  }, [search]);

  const getMovies = async () => {
    setLoading(true);
    setNoResults(false);

    try {
      const response = await fetch(
        `https://www.omdbapi.com/?s=${search}&apikey=${API_KEY}`
      );
      const data = await response.json();

      if (data.Response === "True") {
        setMovies(data.Search);
      } else {
        setMovies([]);
        setNoResults(true);
      }
    } catch (error) {
      console.log("Error fetching movies", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ width: "400px", margin: "auto" }}>
      <h2>Movie Search</h2>

      <input
        type="text"
        placeholder="Search for a movie..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        style={{ width: "100%", padding: "10px" }}
      />

      {loading && <p>Loading...</p>}
      {noResults && <p>No Results Found</p>}

      <ul>
        {movies.map((movie) => (
          <li key={movie.imdbID}>
            {movie.Title} ({movie.Year})
          </li>
        ))}
      </ul>
    </div>
  );
}

export default MovieSearch;
