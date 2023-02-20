import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UpdatePlanRepasFormComponent } from './update-plan-repas-form.component';

describe('UpdatePlanRepasFormComponent', () => {
  let component: UpdatePlanRepasFormComponent;
  let fixture: ComponentFixture<UpdatePlanRepasFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ UpdatePlanRepasFormComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(UpdatePlanRepasFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
