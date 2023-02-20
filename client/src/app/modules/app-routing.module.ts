import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";

import { AppComponent } from "../app.component";
import { PlanRepasPageComponent } from "../pages/plan-repas-page/plan-repas-page.component";

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: 'plan-repas', component: PlanRepasPageComponent },
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }
