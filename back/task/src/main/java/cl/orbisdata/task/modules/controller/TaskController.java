package cl.orbisdata.task.modules.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cl.orbisdata.task.modules.dto.Task;
import cl.orbisdata.task.modules.services.TaskManager;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/tasks")
public class TaskController {
    @Autowired
    private TaskManager taskManager;

    @GetMapping
    public ResponseEntity<List<Task>> getAllTasks() {
        System.out.println(taskManager.getAllTasks().size());
        return ResponseEntity.ok(taskManager.getAllTasks());
    }

    @PostMapping
    public ResponseEntity<Object> createTask(@Valid @RequestBody Task task) {
        try{
        return ResponseEntity.status(HttpStatus.CREATED).body(taskManager.crearTask(task.getTitle()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Ya existe una tarea con ese ID");
        }

    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Object> deleteTask(@PathVariable UUID id) {
        try {
            taskManager.eliminarTask(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("No existe una tarea con ese ID");

        }
    }

    @PutMapping("/{id}/complete")
    public ResponseEntity<Object> completeTask(@PathVariable UUID id) {
        try {
            taskManager.completarTask(id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("No existe una tarea con ese ID");

        }
    }
}
