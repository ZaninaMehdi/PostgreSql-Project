import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddPlanRepasFormComponent } from './add-plan-repas-form.component';

describe('AddPlanRepasFormComponent', () => {
  let component: AddPlanRepasFormComponent;
  let fixture: ComponentFixture<AddPlanRepasFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddPlanRepasFormComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AddPlanRepasFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
