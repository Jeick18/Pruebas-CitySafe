from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from typing import List
from . import models, schemas, auth, database

models.Base.metadata.create_all(bind=database.engine)
app = FastAPI(title="CitySafe API - Ecosistema de Seguridad", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_current_user(db: Session = Depends(database.get_db), username: str = Depends(auth.validar_token)):
    user = db.query(models.UsuarioDB).filter(models.UsuarioDB.username == username).first()
    if user is None:
        raise HTTPException(status_code=404, detail="Usuario no encontrado")
    return user

@app.post("/usuarios/", response_model=schemas.Usuario, tags=["Usuarios"])
def registrar_usuario(user: schemas.UsuarioCreate, db: Session = Depends(database.get_db)):
    db_user = db.query(models.UsuarioDB).filter(models.UsuarioDB.username == user.username).first()
    if db_user:
        raise HTTPException(status_code=400, detail="El nombre de usuario ya está registrado")
    
    hashed_password = auth.obtener_password_hash(user.password)
    nuevo_usuario = models.UsuarioDB(username=user.username, hashed_password=hashed_password)
    db.add(nuevo_usuario)
    db.commit()
    db.refresh(nuevo_usuario)
    return nuevo_usuario

@app.post("/token", tags=["Seguridad"])
def login_para_access_token(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(database.get_db)):
    user = db.query(models.UsuarioDB).filter(models.UsuarioDB.username == form_data.username).first()
    if not user or not auth.verificar_password(form_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Usuario o contraseña incorrectos",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token = auth.crear_token(data={"sub": user.username})
    return {"access_token": access_token, "token_type": "bearer"}

@app.post("/incidentes/", response_model=schemas.Incidente, tags=["Incidentes y Despacho"])
def reportar_incidente(
    incidente: schemas.IncidenteCreate, 
    db: Session = Depends(database.get_db), 
    current_user: models.UsuarioDB = Depends(get_current_user)
):
   
    nuevo_incidente = models.IncidenteDB(**incidente.model_dump(), usuario_id=current_user.id)
    db.add(nuevo_incidente)
    db.commit()
    db.refresh(nuevo_incidente)
    return nuevo_incidente

@app.get("/incidentes/", response_model=List[schemas.Incidente], tags=["Incidentes y Despacho"])
def listar_incidentes(db: Session = Depends(database.get_db)):
   
    return db.query(models.IncidenteDB).all()