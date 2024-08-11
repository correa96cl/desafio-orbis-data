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
export class AppComponent implements OnInit {
  tasks: Task[] = [];
  completedTasks: Task[] = [];
  incompletedTasks: Task[] = [];
  task!: Task;


  constructor(private taskService: TaskService) {
    this.completedTasks = [];
    this.incompletedTasks= [];
    
  }
  ngOnInit(): void {
    console.log("ngOnInit")
    this.listTasks();
  }

  listTasks() {
    console.log("listTasks")
     this.taskService.getTasks().subscribe(tasks => {
      this.tasks = tasks;
      this.completedTasks = tasks.filter(task => task.completed);
      console.log(this.completedTasks.length);
      this.incompletedTasks = tasks.filter(task => !task.completed);
      console.log(this.incompletedTasks.length);


    });
  }

  completeTask(task: Task): void {
    console.log(task.id)
    this.taskService.completeTask(task.id).subscribe(
      () => this.ngOnInit()
    );


  }

   deleteTask(task: Task):void {
    console.log(task.id)
    this.taskService.deleteTask(task.id).subscribe(
      () => this.ngOnInit()
    );


  }

  addTask(): void{
    this.taskService.addTask(this.task).subscribe(
      () => this.ngOnInit()
    );
  }
}
