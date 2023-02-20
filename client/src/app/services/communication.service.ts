import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable, Subject, of } from "rxjs";
import { PlanRepas } from "../Interfaces/plan-repas";
import { catchError } from "rxjs/operators";
import { Fournisseur } from "../Interfaces/fournisseur";

@Injectable()
export class CommunicationService {
  private readonly BASE_URL: string = "http://localhost:3000/database";

  public constructor(private readonly http: HttpClient) {}

  private _listeners: any = new Subject<any>();

  listen(): Observable<any> {
    return this._listeners.asObservable();
  }

  filter(filterBy: string): void {
    this._listeners.next(filterBy);
  }

   // ======= PLANS REPAS =======
   getAllPlanRepas(): Observable<PlanRepas[]> {
    return this.http
      .get<PlanRepas[]>(this.BASE_URL + "/plan-repas")
      .pipe(catchError(this.handleError<PlanRepas[]>("getAllPlanRepas")));
  }

  getAllFournisseurs(): Observable<Fournisseur[]> {
    return this.http
      .get<Fournisseur[]>(this.BASE_URL + "/fournisseurs")
      .pipe(catchError(this.handleError<Fournisseur[]>("getAllFournisseurs")));
  }

  getSpecificPlanRepas(id: number): Observable<PlanRepas[]> {
    return this.http
      .get<PlanRepas[]>(this.BASE_URL + `/plan-repas/${id}`)
      .pipe(catchError(this.handleError<PlanRepas[]>("getSpecificPlanRepas")));
  }

  insertPlanRepas(planRepas: PlanRepas): Observable<number> {
    return this.http
      .post<number>(this.BASE_URL + "/plan-repas", planRepas)
      .pipe(catchError(this.handleError<number>("insertPlanRepas")));
  }

  modifyPlanRepas(planRepas: PlanRepas): Observable<number> {
    return this.http
      .put<number>(this.BASE_URL + "/plan-repas", planRepas)
      .pipe(catchError(this.handleError<number>("modifyPlanRepas")));
  }

  deletePlanRepas(numeroPlanRepas: number): Observable<number> {
    return this.http
      .delete<number>(this.BASE_URL + `/plan-repas/${numeroPlanRepas}`)
      .pipe(catchError(this.handleError<number>("deletePlanRepas")));
  }


  private handleError<T>(
    request: string,
    result?: T
  ): (error: Error) => Observable<T> {
    return (error: Error): Observable<T> => {
      window.alert(error)
      return of(result as T);
    };
  }
}
