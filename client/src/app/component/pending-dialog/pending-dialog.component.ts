import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-pending-dialog',
  templateUrl: './pending-dialog.component.html',
  styleUrls: ['./pending-dialog.component.css']
})
export class PendingDialogComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<PendingDialogComponent>, @Inject(MAT_DIALOG_DATA) public data:   {success: boolean,
  update: boolean,
  delete: boolean}) { }

  ngOnInit(): void {
  }

}
