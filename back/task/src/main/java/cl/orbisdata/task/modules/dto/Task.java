package cl.orbisdata.task.modules.dto;

import java.util.UUID;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;



@Data
@AllArgsConstructor
@Builder
@NoArgsConstructor
public class Task {
    private UUID id;
    @NotBlank(message = "El titulo de la tarea es obligatorio")
    private String title;
    private boolean completed;
}
