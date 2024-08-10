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
      var task = Task.builder().id(UUID.randomUUID()).title(title).completed(false).build();
        
        return task;
    }

    public void eliminarTask(UUID id) {
        if (getTaskById(id) != null) {
            tasks.removeIf(task -> task.getId().equals(id));
        }
    }

    public void completarTask(UUID id) {
        getTaskById(id).setCompleted(true);
    }
}
