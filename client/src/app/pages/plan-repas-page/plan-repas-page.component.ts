import { Component, OnInit, ViewChild } from "@angular/core";
import { MatDialog, MatDialogConfig } from "@angular/material/dialog";
import { Sort } from "@angular/material/sort";
import { MatTable } from "@angular/material/table";
import { AddPlanRepasFormComponent } from "src/app/component/add-plan-repas-form/add-plan-repas-form.component";
import { DeletePlanRepasFormComponent } from "src/app/component/delete-plan-repas-form/delete-plan-repas-form.component";
import { UpdatePlanRepasFormComponent } from "src/app/component/update-plan-repas-form/update-plan-repas-form.component";
import { CommunicationService } from "src/app/services/communication.service";
import { PlanRepas } from "src/app/Interfaces/plan-repas";

@Component({
  selector: "app-plan-repas-page",
  templateUrl: "./plan-repas-page.component.html",
  styleUrls: ["./plan-repas-page.component.css"],
})
export class PlanRepasPageComponent implements OnInit {
  public plansRepas: PlanRepas[];
  displayedColumns: string[] = [
    "numeroplan",
    "categorie",
    "frequence",
    "nbrcalories",
    "nbrpersonnes",
    "prix",
    "numerofournisseur",
    "actions",
  ];
  @ViewChild(MatTable) table: MatTable<any>;

  constructor(
    private communicationService: CommunicationService,
    public dialog: MatDialog
  ) {}

  ngOnInit(): void {
    this.getAllPlansRepas();
  }

  private getAllPlansRepas(): void {
    this.communicationService
      .getAllPlanRepas()
      .subscribe((plansRepas: PlanRepas[]) => {
        this.plansRepas = plansRepas ? plansRepas : [];
        this.sortByPlanNumber("desc");
      });
  }

  openAddDialog() {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = false;
    dialogConfig.autoFocus = true;
    dialogConfig.minWidth = "650px";
    dialogConfig.maxWidth = "650px";
    this.dialog.open(AddPlanRepasFormComponent, dialogConfig);
  }

  openDeleteDialog(numeroPlan : number) {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = false;
    dialogConfig.autoFocus = true;
    dialogConfig.minWidth = "650px";
    dialogConfig.maxWidth = "650px";
    dialogConfig.data = numeroPlan;
    this.dialog.open(DeletePlanRepasFormComponent, dialogConfig);
  }

  openUpdateDialog(planRepas: PlanRepas) {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = false;
    dialogConfig.autoFocus = true;
    dialogConfig.minWidth = "650px";
    dialogConfig.maxWidth = "650px";
    dialogConfig.data = planRepas;
    this.dialog.open(UpdatePlanRepasFormComponent, dialogConfig);
  }

  deletePlanRepas(numeroPlanRepas: number): void {
    this.communicationService
      .deletePlanRepas(numeroPlanRepas)
      .subscribe((res: number) => {
        if (res !== -1) window.location.reload();
        else window.alert("Impossible de supprimer le plan repas désiré.");
      });
  }

  sortData(sort: Sort): void {
    this.sortByPlanNumber(sort.direction);
    this.table.renderRows();
  }

  sortByPlanNumber(direction: string): void {
    if (direction === "desc")
      this.plansRepas.sort((planRepas1: PlanRepas, planRepas2: PlanRepas) =>
        planRepas1.numeroplan < planRepas2.numeroplan ? -1 : 1
      );
    else if (direction === "asc")
      this.plansRepas.sort((planRepas1: PlanRepas, planRepas2: PlanRepas) =>
        planRepas1.numeroplan < planRepas2.numeroplan ? 1 : -1
      );
  }
}
