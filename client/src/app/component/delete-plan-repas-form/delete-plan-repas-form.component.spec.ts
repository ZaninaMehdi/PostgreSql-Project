import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeletePlanRepasFormComponent } from './delete-plan-repas-form.component';

describe('DeletePlanRepasFormComponent', () => {
  let component: DeletePlanRepasFormComponent;
  let fixture: ComponentFixture<DeletePlanRepasFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DeletePlanRepasFormComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(DeletePlanRepasFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
