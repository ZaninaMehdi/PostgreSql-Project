import { Component, Inject, OnInit } from "@angular/core";
import {
  MatDialog,
  MatDialogConfig,
  MAT_DIALOG_DATA,
} from "@angular/material/dialog";
import { CommunicationService } from "src/app/services/communication.service";
import { PendingDialogComponent } from "../pending-dialog/pending-dialog.component";

@Component({
  selector: "app-delete-plan-repas-form",
  templateUrl: "./delete-plan-repas-form.component.html",
  styleUrls: ["./delete-plan-repas-form.component.css"],
})
export class DeletePlanRepasFormComponent implements OnInit {
  numeroPlanRepasASupprimer: number;
  success: boolean = false;

  constructor(
    private communicationService: CommunicationService,
    @Inject(MAT_DIALOG_DATA) public data: number,
    public dialog: MatDialog
  ) {}

  ngOnInit(): void {
    this.numeroPlanRepasASupprimer = this.data;
  }

  deletePlanRepas(numeroPlanRepas: number): void {
    this.communicationService
      .deletePlanRepas(numeroPlanRepas)
      .subscribe((res: number) => {
        if (res !== -1) this.success = true;
        this.openDialog();
      });
    this.success = false;
  }

  openDialog() {
    const dialogConfig = new MatDialogConfig();
    dialogConfig.disableClose = true;
    dialogConfig.autoFocus = true;
    dialogConfig.minWidth = "650px";
    dialogConfig.data = {
      success: this.success,
      delete: true,
    };
    this.dialog.closeAll();
    this.dialog.open(PendingDialogComponent, dialogConfig);
  }
}
