import { Component, EventEmitter, Input, Output } from '@angular/core';
import { Task } from '../../task';
import { TaskService } from '../../task.service';

@Component({
  selector: 'app-delete-task',
  standalone: true,
  imports: [],
  templateUrl: './delete-task.component.html',
  styleUrl: './delete-task.component.css'
})
export class DeleteTaskComponent {

  @Input() id: string | undefined;
  
  constructor(private taskService: TaskService) {}

  onDelete() {

  // Crida al servei per eliminar la tasca
  if (this.id) {
    this.taskService.deleteTask(this.id);
  }


}
}
