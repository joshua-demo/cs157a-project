<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Tasks</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .modal {
            transition: opacity 0.25s ease;
        }
        body.modal-active {
            overflow-x: hidden;
            overflow-y: visible !important;
        }
    </style>
</head>
<body class="bg-gray-100 font-sans">
    <div class="container mx-auto p-6">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Manage My Tasks</h1>

        <!-- Button to open modal -->
        <button class="modal-open bg-blue-500 text-white font-bold py-2 px-4 rounded mb-6">
            Add New Task
        </button>

        <!-- Modal -->
        <div class="modal opacity-0 pointer-events-none fixed w-full h-full top-0 left-0 flex items-center justify-center">
            <div class="modal-overlay absolute w-full h-full bg-gray-900 opacity-50"></div>
            
            <div class="modal-container bg-white w-11/12 md:max-w-md mx-auto rounded shadow-lg z-50 overflow-y-auto">
                <div class="modal-content py-4 text-left px-6">
                    <!-- Modal Header -->
                    <div class="flex justify-between items-center pb-3">
                        <p class="text-2xl font-bold">Add New Task</p>
                        <div class="modal-close cursor-pointer z-50">
                            <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
                                <path d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"></path>
                            </svg>
                        </div>
                    </div>

                    <!-- Modal Body -->
                    <form action="UAddTask" method="post" class="space-y-4" onsubmit="setTimeout(refreshTasks, 1000)">
                        <div>
                            <label for="taskName" class="block text-gray-700 text-sm font-bold mb-2">Task Name:</label>
                            <input type="text" id="taskName" name="taskName" required 
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                   placeholder="Enter task name">
                        </div>

                        <div>
                            <label for="description" class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
                            <textarea id="description" name="description" rows="4" required 
                                      class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                      placeholder="Enter task description"></textarea>
                        </div>

                        <div>
                            <label for="dueDate" class="block text-gray-700 text-sm font-bold mb-2">Due Date:</label>
                            <input type="date" id="dueDate" name="dueDate" required 
                                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                        </div>

                        <div>
                            <label for="priority" class="block text-gray-700 text-sm font-bold mb-2">Priority:</label>
                            <select id="priority" name="priority" required 
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                <option value="Low">Low</option>
                                <option value="Medium">Medium</option>
                                <option value="High">High</option>
                            </select>
                        </div>

                        <div>
                            <label for="status" class="block text-gray-700 text-sm font-bold mb-2">Status:</label>
                            <select id="status" name="status" required 
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                <option value="Pending">Pending</option>
                                <option value="Completed">Completed</option>
                                <option value="Overdue">Overdue</option>
                            </select>
                        </div>

                        <div>
                            <label for="type" class="block text-gray-700 text-sm font-bold mb-2">Type:</label>
                            <select id="type" name="type" required 
                                    class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                <option value="Group Project">Group Project</option>
                                <option value="Assignment">Assignment</option>
                            </select>
                        </div>

                        <div class="flex justify-end pt-2">
                            <button type="submit" 
                                    class="px-4 bg-blue-500 p-3 rounded-lg text-white hover:bg-blue-400">Add Task</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Display User's Tasks -->
        <h2 class="text-2xl font-semibold text-gray-700 mb-4">My Tasks</h2>
        
        <c:if test="${empty taskList}">
            <p class="text-gray-600">No tasks found. Add a new task to get started!</p>
        </c:if>

        <c:if test="${not empty taskList}">
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white shadow-md rounded-lg">
                    <thead>
                        <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                            <th class="py-3 px-6 text-left">Task ID</th>
                            <th class="py-3 px-6 text-left">Task Name</th>
                            <th class="py-3 px-6 text-left">Description</th>
                            <th class="py-3 px-6 text-left">Due Date</th>
                            <th class="py-3 px-6 text-left">Priority</th>
                            <th class="py-3 px-6 text-left">Status</th>
                            <th class="py-3 px-6 text-left">Type</th>
                            <th class="py-3 px-6 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="text-gray-600 text-sm font-light">
                        <c:forEach var="task" items="${taskList}">
                            <tr class="border-b border-gray-200 hover:bg-gray-100">
                                <td class="py-3 px-6 text-left whitespace-nowrap">${task.taskId}</td>
                                <td class="py-3 px-6 text-left whitespace-nowrap">${task.taskName}</td>
                                <td class="py-3 px-6 text-left">${task.description}</td>
                                <td class="py-3 px-6 text-left">${task.dueDate}</td>
                                <td class="py-3 px-6 text-left">
                                    <span class="
                                        px-2 py-1 rounded-full text-xs
                                        ${task.priority eq 'High' ? 'bg-red-200 text-red-800' : 
                                        task.priority eq 'Medium' ? 'bg-yellow-200 text-yellow-800' : 
                                        'bg-green-200 text-green-800'}">
                                        ${task.priority}
                                    </span>
                                </td>
                                <td class="py-3 px-6 text-left">
                                    <span class="
                                        px-2 py-1 rounded-full text-xs
                                        ${task.status eq 'Completed' ? 'bg-green-200 text-green-800' : 
                                        task.status eq 'Overdue' ? 'bg-red-200 text-red-800' : 
                                        'bg-yellow-200 text-yellow-800'}">
                                        ${task.status}
                                    </span>
                                </td>
                                <td class="py-3 px-6 text-left">${task.type}</td>
                                <td class="py-3 px-6 text-left">
                                    <button onclick="openEditModal('${task.taskId}')" 
                                            class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded mr-2">
                                        Edit
                                    </button>
                                    <button onclick="deleteTask('${task.taskId}')" 
                                            class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <!-- Edit Task Modal -->
        <div id="editModal" class="modal opacity-0 pointer-events-none fixed w-full h-full top-0 left-0 flex items-center justify-center">
            <div class="modal-overlay absolute w-full h-full bg-gray-900 opacity-50"></div>
            
            <div class="modal-container bg-white w-11/12 md:max-w-md mx-auto rounded shadow-lg z-50 overflow-y-auto">
                <div class="modal-content py-4 text-left px-6">
                    <!-- Modal Header -->
                    <div class="flex justify-between items-center pb-3">
                        <p class="text-2xl font-bold">Edit Task</p>
                        <div class="modal-close cursor-pointer z-50">
                            <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
                                <path d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"></path>
                            </svg>
                        </div>
                    </div>

                    <!-- Modal Body -->
                    <form id="editForm" method="post" class="space-y-4">
                        <input type="hidden" id="editTaskId" name="taskId">
                        
                        <div>
                            <label for="editTaskName" class="block text-gray-700 text-sm font-bold mb-2">Task Name:</label>
                            <input type="text" id="editTaskName" name="taskName" required 
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                        </div>
                    
                        <div>
                            <label for="editDescription" class="block text-gray-700 text-sm font-bold mb-2">Description:</label>
                            <textarea id="editDescription" name="description" rows="4" required 
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"></textarea>
                        </div>
                    
                        <div>
                            <label for="editDueDate" class="block text-gray-700 text-sm font-bold mb-2">Due Date:</label>
                            <input type="date" id="editDueDate" name="dueDate" required 
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                        </div>
                    
                        <div>
                            <label for="editPriority" class="block text-gray-700 text-sm font-bold mb-2">Priority:</label>
                            <select id="editPriority" name="priority" required 
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                <option value="Low">Low</option>
                                <option value="Medium">Medium</option>
                                <option value="High">High</option>
                            </select>
                        </div>
                    
                        <div>
                            <label for="editStatus" class="block text-gray-700 text-sm font-bold mb-2">Status:</label>
                            <select id="editStatus" name="status" required 
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                <option value="Pending">Pending</option>
                                <option value="Completed">Completed</option>
                                <option value="Overdue">Overdue</option>
                            </select>
                        </div>
                    
                        <div>
                            <label for="editType" class="block text-gray-700 text-sm font-bold mb-2">Type:</label>
                            <select id="editType" name="type" required 
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                <option value="Group Project">Group Project</option>
                                <option value="Assignment">Assignment</option>
                            </select>
                        </div>
                    
                        <div class="flex justify-end pt-2">
                            <button type="submit" 
                                    class="px-4 bg-blue-500 p-3 rounded-lg text-white hover:bg-blue-400">Update Task</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        var openmodal = document.querySelectorAll('.modal-open')
        for (var i = 0; i < openmodal.length; i++) {
          openmodal[i].addEventListener('click', function(event){
            event.preventDefault()
            toggleModal()
          })
        }
        
        const overlay = document.querySelector('.modal-overlay')
        overlay.addEventListener('click', toggleModal)
        
        var closemodal = document.querySelectorAll('.modal-close')
        for (var i = 0; i < closemodal.length; i++) {
          closemodal[i].addEventListener('click', toggleModal)
        }
        
        document.onkeydown = function(evt) {
          evt = evt || window.event
          var isEscape = false
          if ("key" in evt) {
            isEscape = (evt.key === "Escape" || evt.key === "Esc")
          } else {
            isEscape = (evt.keyCode === 27)
          }
          if (isEscape && document.body.classList.contains('modal-active')) {
            toggleModal()
          }
        };
        
        function toggleModal () {
          const body = document.querySelector('body')
          const modal = document.querySelector('.modal')
          modal.classList.toggle('opacity-0')
          modal.classList.toggle('pointer-events-none')
          body.classList.toggle('modal-active')
        }

        function refreshTasks() {
            window.location.href = 'UViewTask';
        }
    
        // Call refreshTasks when the page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Only refresh if we haven't just added a task
            if (!window.location.href.includes('UViewTask')) {
                refreshTasks();
            }
        });

        async function openEditModal(taskId) {
            try {
                const response = await fetch(`UGetTask?taskId=${taskId}`);
                const task = await response.json();
                
                // Populate the form
                document.getElementById('editTaskId').value = task.taskId;  // Updated from task.id
                document.getElementById('editTaskName').value = task.taskName;
                document.getElementById('editDescription').value = task.description;
                document.getElementById('editDueDate').value = task.dueDate;
                document.getElementById('editPriority').value = task.priority;
                document.getElementById('editStatus').value = task.status;
                document.getElementById('editType').value = task.type;
                
                // Show the modal
                const editModal = document.getElementById('editModal');
                editModal.classList.remove('opacity-0', 'pointer-events-none');
                document.body.classList.add('modal-active');
            } catch (error) {
                console.error('Error:', error);
            }
        }
    
        // Function to handle task update
        document.getElementById('editForm').addEventListener('submit', async (e) => {
            e.preventDefault();
            const formData = new FormData(e.target);
            
            try {
                const response = await fetch('UUpdateTask', {
                    method: 'POST',
                    body: formData
                });
                
                if (response.ok) {
                    // Close modal
                    const editModal = document.getElementById('editModal');
                    editModal.classList.add('opacity-0', 'pointer-events-none');
                    document.body.classList.remove('modal-active');
                    
                    // Refresh task list
                    refreshTasks();
                }
            } catch (error) {
                console.error('Error:', error);
            }
        });
    
        // Function to delete task
        async function deleteTask(taskId) {
            if (confirm('Are you sure you want to delete this task?')) {
                try {
                    const response = await fetch('UDeleteTask', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: `taskId=${taskId}`
                    });
                    
                    if (response.ok) {
                        refreshTasks();
                    }
                } catch (error) {
                    console.error('Error:', error);
                }
            }
        }
    </script>
</body>
</html>