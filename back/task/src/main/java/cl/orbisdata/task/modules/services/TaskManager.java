package cl.orbisdata.task.modules.services;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;

import cl.orbisdata.task.modules.dto.Task;

@Service
public class TaskManager {
    private List<Task> tasks = new ArrayList<>();

    public List<Task> getAllTasks() {
        return tasks;
    }

    public Task getTaskById(UUID id) {
        return tasks.stream()
                .filter(task -> task.getId().equals(id))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("Task no encontrada"));
    }

    public Task crearTask(String title) {
        Task task = new Task();
        task.setId(UUID.randomUUID());
        task.setTitle(title);
        tasks.add(task);
        return task;        
    }

    public void eliminarTask(UUID id) {
        System.out.println("Eliminando tarea con ID: " + id);
        if (getTaskById(id) != null) {
            tasks.removeIf(task -> task.getId().equals(id));
        }
    }

    public void completarTask(UUID id) {
        System.out.println("Completando tarea con ID: " + id);
        getTaskById(id).setCompleted(true);
    }
}
