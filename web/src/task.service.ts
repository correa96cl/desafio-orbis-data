import { inject, Injectable } from '@angular/core';
import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { catchError, Observable, Subject, throwError } from 'rxjs';
import { Task } from './task';

@Injectable({ providedIn: 'root' })
export class TaskService {
  private apiUrl = 'http://localhost:8080/tasks';
  http = inject(HttpClient);
  public   customerAdded: Subject<boolean>;


  constructor() {
    this.customerAdded = new Subject<boolean>();
  }

  getTasks(): Observable<Task[]> {
    return this.http.get<Task[]>(this.apiUrl);
  }

  addTask(task: Task): Observable<Task> {
    return this.http.post<Task>(this.apiUrl, task);
  }

  deleteTask(id: string): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}/`+id);
  }

  completeTask(id: string): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}/${id}/complete`, { });

  }

  private handleError<T>(operation = 'operation'): (error: HttpErrorResponse) => Observable<T> {
    return (error: HttpErrorResponse): Observable<T> => {

      console.error(error);

      let message: string;
      if (error.error instanceof ErrorEvent) {
        // Client-side or network error occurred. Handle it accordingly.
        message = `Error: ${error.error.message}`;
      } else {
        // Backend returned an unsuccessful response code.
        const status = error.status || 0; // Handle potential undefined status
        const statusText = error.statusText || 'Unknown Error';
        message = `Server returned status code ${status} with body "${error.error}" (Text: ${statusText})`;
      }

      // Return an observable with a user-facing error message.
      return throwError(() => new Error(`${operation} Fallo: ${message}`));
    };
  }
}
