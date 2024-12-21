# Task Manager 

## Overview
The Task Manager Web App is a simple yet feature-rich application that allows users to manage their daily tasks effectively. It supports features such as adding, editing, completing, deleting tasks, and filtering tasks by their status. The app is built using **HTML**, **CSS**, **JavaScript**, and **jQuery**, with dynamic behaviors and a responsive design.

---

## Features

### 1. Add Task
- Users can add new tasks by entering a task name and clicking the **Add Task** button.
- Tasks are validated to ensure the input is not empty.

### 2. Mark Complete
- Users can mark tasks as complete using the **Mark Complete** button.
- Completed tasks are visually distinguished with a strikethrough and green background.

### 3. Edit Task
- Tasks can be edited inline by clicking the **Edit** button.
- The user can modify the task name and save the changes.

### 4. Delete Task
- Tasks can be removed from the list using the **Delete** button with a smooth fade-out animation.

### 5. Filter Tasks
- A filter dropdown allows users to view:
  - All Tasks
  - Completed Tasks
  - Pending Tasks
- Tasks are filtered dynamically based on the selected option.



---

## How to Run the Project Locally

### Prerequisites
- A modern web browser (e.g., Chrome, Firefox, Edge).
- Internet connection to load jQuery from a CDN.

### Steps
1. Clone or download the project repository to your local machine.
   ```bash
   git clone <repository-url>
   ```
2. Open the project folder.
3. Locate the `index.html` file.
4. Open `index.html` in your preferred web browser.
5. You can now interact with the Task Manager Web App.

---

## Key Features Implemented Using jQuery and JavaScript

### jQuery Features
- **Smooth Animations**
  - Fade-in animation for adding tasks.
  - Fade-out animation for deleting tasks.

- **Event Handling**
  - Click events for adding, editing, completing, and deleting tasks.
  - Change event for filtering tasks dynamically.

- **DOM Manipulation**
  - Dynamically appends tasks to the task table.
  - Updates task status and text inline.

### JavaScript Features
- **Input Validation**
  - Ensures task input is not empty before adding a task.

- **Task Filtering Logic**
  - Filters tasks based on their status (All, Completed, Pending).

- **LocalStorage**
  - Saves and retrieves tasks to/from the browser’s local storage.

- **Dynamic Task Rendering**
  - On page load, renders tasks stored in localStorage.

---

## Project Structure
```
|-- index.html        # Main HTML file
|-- style.css         # Styling for the app
|-- script.js         # Core functionality (JavaScript + jQuery)
|-- README.md         # Project documentation
```

---



