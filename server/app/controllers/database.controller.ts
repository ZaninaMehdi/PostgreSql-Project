import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import { DatabaseService } from "../services/database.service";
import Types from "../types";
import * as pg from "pg";
import { PlanRepas } from "../interfaces/plan-repas";
import { Fournisseur } from "@app/interfaces/fournisseur";

@injectable()
export class DatabaseController {
  public constructor(
    // @ts-ignore -- À ENLEVER LORSQUE L'IMPLÉMENTATION EST TERMINÉE
    @inject(Types.DatabaseService)
    private readonly databaseService: DatabaseService
  ) {}

  public get router(): Router {
    const router: Router = Router();

    // ======= PLANS REPAS ROUTES =======
    router.get(
      "/plan-repas",
      (req: Request, res: Response, _: NextFunction) => {
        this.databaseService
          .getAllPlanRepas()
          .then((result: pg.QueryResult) => {
            const planRepas: PlanRepas[] = result.rows.map(
              (planRepas: PlanRepas) =>
                ({
                  numeroplan: planRepas.numeroplan,
                  numerofournisseur: planRepas.numerofournisseur,
                  categorie: planRepas.categorie,
                  frequence: planRepas.frequence,
                  nbrpersonnes: planRepas.nbrpersonnes,
                  nbrcalories: planRepas.nbrcalories,
                  prix: planRepas.prix,
                } as PlanRepas)
            );
            res.json(planRepas);
          })
          .catch((e: Error) => {
            console.error(e.stack);
          });
      }
    );

    router.get(
      "/fournisseurs",
      (req: Request, res: Response, _: NextFunction) => {
        this.databaseService
          .getAllFournisseur()
          .then((result: pg.QueryResult) => {
            const fournisseurs: Fournisseur[] = result.rows.map(
              (fournisseur: Fournisseur) => ({
                numerofournisseur: fournisseur.numerofournisseur,
                nomfournisseur: fournisseur.nomfournisseur,
                adressefournisseur: fournisseur.adressefournisseur,
              })
            );
            res.json(fournisseurs);
          })
          .catch((e: Error) => {
            console.error(e.stack);
          });
      }
    );

    router.post(
      "/plan-repas",
      (req: Request, res: Response, _: NextFunction) => {
        const planRepas: PlanRepas = {
          numerofournisseur: req.body.numerofournisseur,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbrcalories: req.body.nbrcalories,
          prix: req.body.prix,
        } as PlanRepas;
        this.databaseService
          .addPlanRepas(planRepas)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    router.put(
      "/plan-repas",
      (req: Request, res: Response, _: NextFunction) => {
        const planRepas: PlanRepas = {
          numeroplan: req.body.numeroplan,
          numerofournisseur: req.body.numerofournisseur,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbrcalories: req.body.nbrcalories,
          prix: req.body.prix,
        };
        this.databaseService
          .updatePlanRepas(planRepas)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    router.delete(
      "/plan-repas/:numeroplan",
      (req: Request, res: Response, _: NextFunction) => {
        this.databaseService
          .deletePlanRepas(parseInt(req.params.numeroplan))
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    return router;
  }
}
