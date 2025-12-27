import { useState, useEffect } from "react";

export default function App() {
  const [note, setNote] = useState("");
  const [notes, setNotes] = useState([]);

  // Load notes from localStorage on first render
  useEffect(() => {
    const savedNotes = JSON.parse(localStorage.getItem("notes"));
    if (savedNotes) {
      setNotes(savedNotes);
    }
  }, []);

  // Save notes to localStorage whenever notes change
  useEffect(() => {
    localStorage.setItem("notes", JSON.stringify(notes));
  }, [notes]);

  const addNote = () => {
    if (note.trim() === "") return;
    setNotes([...notes, note]);
    setNote("");
  };

  const deleteNote = (index) => {
    const updatedNotes = notes.filter((_, i) => i !== index);
    setNotes(updatedNotes);
  };

  return (
    <div style={{ padding: "20px", maxWidth: "400px", margin: "auto" }}>
      <h2>📝 Notes App</h2>

      <input
        type="text"
        placeholder="Write a note..."
        value={note}
        onChange={(e) => setNote(e.target.value)}
        style={{ width: "100%", padding: "8px" }}
      />

      <button
        onClick={addNote}
        style={{ marginTop: "10px", width: "100%" }}
      >
        Save Note
      </button>

      <ul style={{ marginTop: "20px" }}>
        {notes.map((n, index) => (
          <li key={index} style={{ marginBottom: "8px" }}>
            {n}
            <button
              onClick={() => deleteNote(index)}
              style={{ marginLeft: "10px" }}
            >
              ❌
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}
