import { CommonModule } from "@angular/common";
import { HttpClientModule } from "@angular/common/http";
import { NgModule } from "@angular/core";
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from "@angular/platform-browser";
import { AppRoutingModule } from "./modules/app-routing.module";
import { AppComponent } from "./app.component";
import { CommunicationService } from "./services/communication.service";
import { AppMaterialModule } from './modules/material.module';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { PlanRepasPageComponent } from './pages/plan-repas-page/plan-repas-page.component';
import { AddPlanRepasFormComponent } from './component/add-plan-repas-form/add-plan-repas-form.component';
import { UpdatePlanRepasFormComponent } from './component/update-plan-repas-form/update-plan-repas-form.component';
import { DeletePlanRepasFormComponent } from './component/delete-plan-repas-form/delete-plan-repas-form.component';
import { PendingDialogComponent } from './component/pending-dialog/pending-dialog.component';

@NgModule({
  declarations: [
    AppComponent,
    PlanRepasPageComponent,
    AddPlanRepasFormComponent,
    UpdatePlanRepasFormComponent,
    DeletePlanRepasFormComponent,
    PendingDialogComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    HttpClientModule,
    FormsModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    ReactiveFormsModule,
    AppMaterialModule
  ],
  providers: [CommunicationService],
  entryComponents: [],
  bootstrap: [AppComponent],
})
export class AppModule { }
