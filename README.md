# desafio-orbis-data

## Backend ##

## Para Obtener todas las tareas. Metodo: GET ##

http://localhost:8080/tasks

## Para Crear una tarea. Metodo PUT ##

http://localhost:8080/tasks

Body

```

{
    "title": "Dormir"
}

```


## Eliminar tarea. Metodo: DELETE ##

http://localhost:8080/tasks/${id}


## Completar tarea. Metodo: PUT ##

http://localhost:8080/tasks/${id}/complete