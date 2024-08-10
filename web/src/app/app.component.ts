import { Component, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { Task } from '../task';
import { TaskService } from '../task.service';
import { NgFor, NgIf } from '@angular/common';
import { DeleteTaskComponent } from '../components/delete-task/delete-task.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NgFor, NgIf, DeleteTaskComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
  tasks: Task[] = [];
  completedTasks: Task[] = [];
  incompletedTasks: Task[] = [];

  constructor(private taskService: TaskService) {}

  ngOnInit() {
    this.taskService.getTasks().subscribe(tasks => {
      this.tasks = tasks;
      console.log(this.tasks)
      this.completedTasks = tasks.filter(task => task.completed);
      this.incompletedTasks = tasks.filter(task => !task.completed);
    });
  }
}
