import { Component, Input, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Task } from '../task';
import { TaskService } from '../task.service';
import { NgFor, NgIf } from '@angular/common';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NgFor, NgIf],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  tasks: Task[] = [];
  completedTasks: Task[] = [];
  incompletedTasks: Task[] = [];
  task!: Task;


  constructor(private taskService: TaskService) {
    this.taskService.getTasks().subscribe(tasks => {
      this.tasks = tasks;
      this.completedTasks = tasks.filter(task => task.completed);
      this.incompletedTasks = tasks.filter(task => !task.completed);
    });
  }

  completeTask(task: Task): void {
    this.taskService.completeTask(task.id);
  }

  deleteTask(task: Task): void {
    this.taskService.deleteTask(task.id);
  }

  addTask(): void{
    this.taskService.addTask(this.task);
  }
}
