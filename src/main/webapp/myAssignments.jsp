<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Assignments</title>
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
    <!-- Include the navigation bar -->
    <jsp:include page="navbar.jsp" />
    <div class="container mx-auto p-6">
    
    	<!-- Back Button -->
        <a href="myCourses.jsp" class="flex items-center text-blue-500 font-bold mb-6">
            <svg class="h-5 w-5 mr-2" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
            Back
        </a>
	    
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Manage My Assignments For ${param.courseName}</h1>

        <!-- Button to open modal -->
        <button class="modal-open bg-blue-500 text-white font-bold py-2 px-4 rounded mb-6">
            Add New Assignment
        </button>

        <!-- Modal -->
        <div class="modal opacity-0 pointer-events-none fixed w-full h-full top-0 left-0 flex items-center justify-center">
            <div class="modal-overlay absolute w-full h-full bg-gray-900 opacity-50"></div>
            
            <div class="modal-container bg-white w-11/12 md:max-w-md mx-auto rounded shadow-lg z-50 overflow-y-auto">
                <div class="modal-content py-4 text-left px-6">
                    <!-- Modal Header -->
                    <div class="flex justify-between items-center pb-3">
                        <p class="text-2xl font-bold">Add New Assignments</p>
                        <div class="modal-close cursor-pointer z-50">
                            <svg class="fill-current text-black" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18">
                                <path d="M14.53 4.53l-1.06-1.06L9 7.94 4.53 3.47 3.47 4.53 7.94 9l-4.47 4.47 1.06 1.06L9 10.06l4.47 4.47 1.06-1.06L10.06 9z"></path>
                            </svg>
                        </div>
                    </div>
	                <!-- Modal Body -->
					<form action="UAddAssignment" method="post" class="space-y-4" onsubmit="setTimeout(refreshCourses, 1000)">
					    <!-- Assignment Name -->
					    <div>
					        <label for="assignmentName" class="block text-gray-700 text-sm font-bold mb-2">
					            Assignment Name:
					        </label>
					        <input type="text" id="assignmentName" name="assignmentName" required
					               class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					               placeholder="Enter assignment name">
					    </div>
					
					    <!-- Description -->
					    <div>
					        <label for="description" class="block text-gray-700 text-sm font-bold mb-2">
					            Description:
					        </label>
					        <input type="text" id="description" name="description" required
					               class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					               placeholder="Enter assignment description">
					    </div>
					
					    <!-- Grade -->
					    <div>
					        <label for="grade" class="block text-gray-700 text-sm font-bold mb-2">
					            Grade:
					        </label>
					        <input type="number" id="grade" name="grade" step="0.01" required
					               class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					               placeholder="Enter grade">
					    </div>
					
						<!-- Max Grade -->
					    <div>
					        <label for="maxgrade" class="block text-gray-700 text-sm font-bold mb-2">
					            Maximum Possible Grade:
					        </label>
					        <input type="number" id="maxgrade" name="maxgrade" step="0.01" required
					               class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					               placeholder="Enter Maximum Grade">
					    </div>
					
					    <!-- Weight -->
					    <div>
					        <label for="weight" class="block text-gray-700 text-sm font-bold mb-2">
					            Weight:
					        </label>
					        <input type="number" id="weight" name="weight" step="0.01" required
					               class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
					               placeholder="Enter weight (e.g., 50 for 50%)">
					    </div>
					    
					    <input type="hidden" id="courseId" name="courseId" value="${param.courseId}">
					    <input type="hidden" id="courseName" name="courseName" value="${param.courseName}">
					
					    <!-- Submit Button -->
					    <div class="flex justify-end pt-2">
					        <button type="submit"
					                class="px-4 bg-blue-500 p-3 rounded-lg text-white hover:bg-blue-400">
					            Add Assignment
					        </button>
					    </div>
					</form>
                </div>
            </div>
        </div>

        <!-- Display User's Assignments for Specific Course -->
        <h2 class="text-2xl font-semibold text-gray-700 mb-4">My Assignments</h2>
        
        <c:if test="${empty assignmentList}">
            <p class="text-gray-600">No Assignments found. Add a new assignment to get started!</p>
        </c:if>

        <c:if test="${not empty assignmentList}">
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white shadow-md rounded-lg">
                    <thead>
                        <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                            <th class="py-3 px-6 text-left">Assignment Name</th>
                            <th class="py-3 px-6 text-left">Description</th>
                            <th class="py-3 px-6 text-left">Grade</th>
                            <th class="py-3 px-6 text-left">Max Grade</th>
                            <th class="py-3 px-6 text-left">Weight (%)</th>
                            <th class="py-3 px-3 text-left">Remove</th> 
                        </tr>
                    </thead>
                    <tbody class="text-gray-600 text-sm font-light">
                        <c:forEach var="assignment" items="${assignmentList}">
                            <tr class="border-b border-gray-200 hover:bg-gray-100">
                                <td class="py-3 px-6 text-left whitespace-nowrap">${assignment.name}</td>
                                <td class="py-3 px-6 text-left">${assignment.description}</td>
                                <td class="py-3 px-6 text-left">${assignment.grade}</td> 
                                <td class="py-3 px-6 text-left">${assignment.maxGrade}</td> 
                                <td class="py-3 px-6 text-left">${assignment.weight}</td>                               
                               	<td class="py-3 px-6 text-left">
					                <form action="UDeleteAssignment" method="post" onsubmit="return confirm('Are you sure you want to remove this assignment?') & setTimeout(refreshCourses, 1000);">
					                    <input type="hidden" name="assignmentId" value="${assignment.assignmentId}" />
					                    <input type="hidden" id="courseId" name="courseId" value="${param.courseId}">
					  					<input type="hidden" id="courseName" name="courseName" value="${param.courseName}">
					                    <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600">
					                        Remove
					                    </button>
					                </form>
					            </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
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
        
        function refreshCourses() {
            window.location.href = 'UViewAssignment';
        }
    
        // Call refreshCourses when the page loads
        document.addEventListener('DOMContentLoaded', function() {
            // Only refresh if we haven't just added a course
            if (!window.location.href.includes('UViewAssignment')) {
                refreshCourses();
            }
        });
    </script>
</body>
</html>
