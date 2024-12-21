$(document).ready(function () {
    const input = $("#taskInput");
    const addTaskButton = $("#addTask");
    const taskTableBody = $("#tasks tbody"); 
    const filter = $("#filter");
  
    const loadTasks = () => {
      const tasks = JSON.parse(localStorage.getItem("tasks")) || [];
      tasks.forEach((task) => {
        const row = $("<tr></tr>");
        const taskNameCell = $("<td></td>").text(task.name);
        const actionsCell = $("<td></td>").addClass("action-buttons");
  
        // Complete Button
        const completeButton = $("<button></button>")
          .addClass("complete-btn")
          .text("Mark Complete")
          .click(function () {
            row.toggleClass("completed");
            updateLocalStorage();
          });
  
        // Edit Button
        const editButton = $("<button></button>")
          .addClass("edit-btn")
          .text("Edit")
          .click(function () {
            const currentText = taskNameCell.text();
            taskNameCell.html(
              `<input type="text" class="edit-input" value="${currentText}">`
            );
  
            editButton
              .text("Save")
              .off("click")
              .click(function () {
                const updatedText = taskNameCell.find(".edit-input").val().trim();
                if (updatedText !== "") {
                  taskNameCell.text(updatedText); 
                  task.name = updatedText; 
                  editButton.text("Edit"); 
                  updateLocalStorage();
                }
              });
          });
  
        // Delete Button
        const deleteButton = $("<button></button>")
          .addClass("delete-btn")
          .text("Delete")
          .click(function () {
            row.fadeOut(500, function () {
              row.remove();
              updateLocalStorage();
            });
          });
  
        actionsCell.append(completeButton, editButton, deleteButton);
        row.append(taskNameCell, actionsCell);
        taskTableBody.append(row.hide().fadeIn(500));
  
        if (task.completed) {
          row.addClass("completed");
        }
      });
    };
  
    const updateLocalStorage = () => {
      const tasks = [];
      $("#tasks tbody tr").each(function () {
        const taskName = $(this).find("td:first").text();
        const isCompleted = $(this).hasClass("completed");
        tasks.push({ name: taskName, completed: isCompleted });
      });
      localStorage.setItem("tasks", JSON.stringify(tasks));
    };
  
    const addTask = () => {
      const taskName = input.val().trim();
  
      if (taskName === "") {
        alert("Please enter a task.");
        return;
      }
  
      const row = $("<tr></tr>");
      const taskNameCell = $("<td></td>").text(taskName);
      const actionsCell = $("<td></td>").addClass("action-buttons");
  
      // Complete Button
      const completeButton = $("<button></button>")
        .addClass("complete-btn")
        .text("Mark Complete")
        .click(function () {
          row.toggleClass("completed");
          updateLocalStorage();
        });
  
      // Edit Button
      const editButton = $("<button></button>")
        .addClass("edit-btn")
        .text("Edit")
        .click(function () {
          const currentText = taskNameCell.text();
          taskNameCell.html(
            `<input type="text" class="edit-input" value="${currentText}">`
          );
  
          editButton
            .text("Save")
            .off("click")
            .click(function () {
              const updatedText = taskNameCell.find(".edit-input").val().trim();
              if (updatedText !== "") {
                taskNameCell.text(updatedText); 
                editButton.text("Edit"); 
                updateLocalStorage();
              }
            });
        });
  
      // Delete Button
      const deleteButton = $("<button></button>")
        .addClass("delete-btn")
        .text("Delete")
        .click(function () {
          row.fadeOut(500, function () {
            row.remove();
            updateLocalStorage();
          });
        });
  
      actionsCell.append(completeButton, editButton, deleteButton);
      row.append(taskNameCell, actionsCell);
  
      taskTableBody.append(row.hide().fadeIn(500));
  
      input.val("");
  
      const tasks = JSON.parse(localStorage.getItem("tasks")) || [];
      tasks.push({ name: taskName, completed: false });
      localStorage.setItem("tasks", JSON.stringify(tasks));
    };
  
    addTaskButton.click(addTask);
  
    input.keypress(function (event) {
      if (event.key === "Enter") {
        addTask();
      }
    });
  
    const filterTasks = () => {
      const filterValue = filter.val();
  
      $("#tasks tbody tr").each(function () {
        const row = $(this);
        const isCompleted = row.hasClass("completed");
  
        if (filterValue === "all") {
          row.show();
        } else if (filterValue === "completed" && isCompleted) {
          row.show();
        } else if (filterValue === "pending" && !isCompleted) {
          row.show();
        } else {
          row.hide();
        }
      });
    };
  
    filter.change(filterTasks);
  
    loadTasks();
  });
  