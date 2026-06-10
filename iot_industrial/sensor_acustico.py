import paho.mqtt.client as mqtt
import json
import time
import random

# --- CONFIGURACIÓN DEL DISPOSITIVO IoT (MQTT PUBLISHER) ---
BROKER = "broker.hivemq.com"
PORT = 1883
TOPIC = "citysafe/estaciones/1"  # Identificador final de este poste (Estación 1)

def generar_decibelios():
    # 90% del tiempo hay ruido urbano normal, 10% de probabilidad de un pico fuerte
    if random.random() > 0.90:
        return round(random.uniform(120.0, 140.0), 1) # Disparo o choque en carretera
    else:
        return round(random.uniform(40.0, 75.0), 1)   # Tráfico y ambiente normal

def monitorear_audio():
    print("--- Iniciando Módulo IoT Acústico CitySafe (MOTE-001) ---")
    
    # Inicialización del cliente MQTT
    client = mqtt.Client()
    
    try:
        client.connect(BROKER, PORT)
        print(f"[MQTT] Conectado exitosamente al broker: {BROKER}")
    except Exception as e:
        print(f"[CRÍTICO] No se pudo establecer conexión con el broker MQTT: {e}")
        return

    while True:
        db_actual = generar_decibelios()
        print(f"[Micrófono] Nivel de ruido local: {db_actual} dB")

        if db_actual > 120.0:
            print(f"[ALERTA] Ruido extremo detectado ({db_actual} dB). Transmitiendo telemetría...")
            
            # Formato de carga útil optimizado para el Puente MQTT
            payload = {
                "tipo": "Alarma Acústica",
                "nivel_urgencia": 5,
                "detalles": f"Pico acústico anómalo de {db_actual} dB detectado automáticamente. Posible altercado o disparo en la zona."
            }

            try:
                # Publicación del mensaje estructurado hacia el broker
                client.publish(TOPIC, json.dumps(payload))
                print(f"[ÉXITO] Mensaje publicado en el tópico: {TOPIC}\n")
            except Exception as e:
                print(f"[ERROR] No se pudo enviar el mensaje por MQTT: {e}\n")
            
            # Entra en modo de enfriamiento temporal para no generar reportes duplicados
            time.sleep(15) 
        else:
            # Pausa corta entre mediciones de rutina
            time.sleep(3)

if __name__ == "__main__":
    monitorear_audio()