import { Component, OnInit } from '@angular/core';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { CommunicationService } from 'src/app/services/communication.service';
import { PlanRepas } from 'src/app/Interfaces/plan-repas';
import { PendingDialogComponent } from '../pending-dialog/pending-dialog.component';
import { Fournisseur } from 'src/app/Interfaces/fournisseur';

@Component({
  selector: "app-add-plan-repas-form",
  templateUrl: "./add-plan-repas-form.component.html",
  styleUrls: ["./add-plan-repas-form.component.css"],
})
export class AddPlanRepasFormComponent implements OnInit {
  numeroFournisseur: number = 1; 
  categorie: string = "japonais";
  frequence: number = 5;
  nbrPersonnes: number = 4;
  nbrCalories: number = 550;
  prix: number = 12.50;
  public fournisseurs: Fournisseur[];
  success: boolean = false;

  constructor(private communicationService: CommunicationService, public dialog: MatDialog) {}

  ngOnInit(): void {
    this.getAllFournisseurs();
  }

  private getAllFournisseurs(): void {
    this.communicationService
      .getAllFournisseurs()
      .subscribe((fournisseurs: Fournisseur[]) => {
        this.fournisseurs = fournisseurs ? fournisseurs : [];
      });
  }

  addPlanRepas(): void {
    this.communicationService
      .insertPlanRepas({
        categorie: this.categorie,
        frequence: this.frequence,
        nbrcalories: this.nbrCalories,
        nbrpersonnes: this.nbrPersonnes,
        prix: this.prix,
        numerofournisseur: this.numeroFournisseur,
      } as PlanRepas)
      .subscribe((res: number) => {
        if(res !== -1)
        this.success = true;
      this.openDialog();
      });
  }

  isEmpty(): boolean {
    return this.categorie.trim().length <= 0;
}

openDialog() {
  const dialogConfig = new MatDialogConfig();
  dialogConfig.disableClose = true;
  dialogConfig.autoFocus = true;
  dialogConfig.minWidth = '650px';
  dialogConfig.data = {
    success: this.success,
  };
  this.dialog.closeAll();
  this.dialog.open(PendingDialogComponent, dialogConfig);
}
   
}
