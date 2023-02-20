import { Component, Inject, OnInit } from '@angular/core';
import { MatDialog, MatDialogConfig, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CommunicationService } from 'src/app/services/communication.service';
import { PlanRepas } from 'src/app/Interfaces/plan-repas';
import { PendingDialogComponent } from '../pending-dialog/pending-dialog.component';
import { Fournisseur } from 'src/app/Interfaces/fournisseur';

@Component({
  selector: 'app-update-plan-repas-form',
  templateUrl: './update-plan-repas-form.component.html',
  styleUrls: ['./update-plan-repas-form.component.css']
})
export class UpdatePlanRepasFormComponent implements OnInit {

  numeroFournisseur : number;
  categorie : string;
  frequence : number;
  nbrPersonnes : number;
  nbrCalories : number;
  prix : number;
  numeroPlanActuel : number
  public fournisseurs: Fournisseur[];
  success : boolean = false

  constructor(private communicationService: CommunicationService, @Inject(MAT_DIALOG_DATA) public data: PlanRepas, public dialog: MatDialog) { }

  ngOnInit(): void {
    this.getAllFournisseurs();
    this.numeroPlanActuel = this.data.numeroplan;
    this.categorie = this.data.categorie;
    this.frequence = this.data.frequence;
    this.nbrCalories = this.data.nbrcalories;
    this.nbrPersonnes = this.data.nbrpersonnes;
    this.prix = this.data.prix;
    this.numeroFournisseur = this.data.numerofournisseur;
  }

  private getAllFournisseurs(): void {
    this.communicationService
      .getAllFournisseurs()
      .subscribe((fournisseurs: Fournisseur[]) => {
        this.fournisseurs = fournisseurs ? fournisseurs : [];
      });
  }

  modifyPlanRepas(): void {
    this.communicationService
      .modifyPlanRepas({
        categorie: this.categorie,
        frequence: this.frequence,
        nbrcalories: this.nbrCalories,
        nbrpersonnes: this.nbrPersonnes,
        prix: this.prix,
        numerofournisseur: this.numeroFournisseur,
        numeroplan : this.numeroPlanActuel
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
    update: true
  };
  this.dialog.closeAll();
  this.dialog.open(PendingDialogComponent, dialogConfig);
}

}
