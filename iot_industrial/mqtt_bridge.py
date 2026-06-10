import paho.mqtt.client as mqtt
import requests
import json

# Configuración del Broker MQTT y API
BROKER = "broker.hivemq.com"
TOPIC = "citysafe/estaciones/#"
API_URL = "http://localhost:8000/incidentes/"  # Reemplazar por la ruta exacta de su router de incidentes
TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhbGV4IiwiZXhwIjoxNzgxMTc5MTIwfQ.TUFpusUKv_hoQS748Epoo9Jq2cAB_fIoMXFmpWA6GOY"  # Token de un usuario autenticado para evadir falsas alarmas

# Diccionario de infraestructura urbana (Simula la ubicación real de los postes en la ciudad)
# Permite asociar el ID del tópico con las coordenadas geográficas reales
ESTACIONES_GEO = {
    "1": {
        "latitud": -12.046374, 
        "longitud": -77.042793, 
        "ubicacion": "Av. Alfonso Ugarte - Cercado de Lima"
    },
    "2": {
        "latitud": -12.056034, 
        "longitud": -77.084422, 
        "ubicacion": "Puerta 3 - Universidad Nacional Mayor de San Marcos"
    }
}

def on_message(client, userdata, msg):
    try:
        # 1. Decodificar payload enviado por el sensor
        payload = json.loads(msg.payload.decode())
        print(f"Telemetría recibida en [{msg.topic}]: {payload}")
        
        # 2. Extraer el ID del poste desde el tópico (ej: citysafe/estaciones/1 -> "1")
        estacion_id = msg.topic.split("/")[-1]
        
        # 3. Obtener los datos geográficos del diccionario de infraestructura
        geo_info = ESTACIONES_GEO.get(estacion_id, {
            "latitud": -12.046374,
            "longitud": -77.042793,
            "ubicacion": f"Poste Genérico ID {estacion_id}"
        })
        
        # 4. Estructurar el JSON final mapeando los campos hacia IncidenteCreate
        # Se extraen los datos dinámicos del payload y los estáticos del mapeo geoespacial
        tipo_incidente = payload.get("tipo", "Sospechoso")
        urgencia = int(payload.get("nivel_urgencia", 1))
        detalles_sensor = payload.get("detalles", "Alerta activada por dispositivo IoT.")
        
        descripcion_completa = f"{geo_info['ubicacion']} | {detalles_sensor}"

        data_to_send = {
            "tipo": tipo_incidente,
            "latitud": geo_info["latitud"],
            "longitud": geo_info["longitud"],
            "nivel_urgencia": urgencia,
            "descripcion": descripcion_completa
        }
        
        # 5. Envío seguro de la petición HTTP POST al backend de FastAPI
        headers = {"Authorization": f"Bearer {TOKEN}"}
        response = requests.post(API_URL, json=data_to_send, headers=headers)
        
        if response.status_code in [200, 201]:
            print(f"Éxito: Incidente de estación {estacion_id} registrado en la base de datos.")
        else:
            print(f"Fallo en validación API ({response.status_code}): {response.text}")

    except Exception as e:
        print(f"Error crítico procesando el mensaje en el Bridge: {e}")

# Configuración del Cliente MQTT de escucha continua
client = mqtt.Client()
client.on_message = on_message

print("Puente MQTT de CitySafe iniciado de manera exitosa. Esperando datos de sensores...")
client.connect(BROKER, 1883)
client.subscribe(TOPIC)
client.loop_forever()