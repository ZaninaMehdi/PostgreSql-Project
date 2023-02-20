import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PlanRepasPageComponent } from './plan-repas-page.component';

describe('PlanRepasPageComponent', () => {
  let component: PlanRepasPageComponent;
  let fixture: ComponentFixture<PlanRepasPageComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PlanRepasPageComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PlanRepasPageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
