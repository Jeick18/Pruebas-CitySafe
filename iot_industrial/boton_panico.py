import paho.mqtt.client as mqtt
import json
import time

# --- CONFIGURACIÓN DEL DISPOSITIVO IoT (MQTT PUBLISHER) ---
BROKER = "broker.hivemq.com"
PORT = 1883
TOPIC = "citysafe/estaciones/2"  # Identificador final de este tótem (Estación 2)

def iniciar_totem():
    print("--- Tótem de Seguridad CitySafe (BOTON-002) Iniciado ---")
    print("Esperando interacción ciudadana...")
    
    # Inicialización del cliente MQTT
    client = mqtt.Client()
    
    try:
        client.connect(BROKER, PORT)
        print(f"[MQTT] Conectado exitosamente al broker: {BROKER}")
    except Exception as e:
        print(f"[CRÍTICO] No se pudo establecer conexión con el broker MQTT: {e}")
        return

    while True:
        input("\n[PULSA ENTER PARA ACTIVAR EL BOTÓN DE PÁNICO]")
        
        print("🚨 ¡BOTÓN PRESIONADO! Enviando señal de auxilio vía MQTT...")
        
        # Formato de carga útil optimizado para el Puente MQTT
        payload = {
            "tipo": "Botón de Pánico",
            "nivel_urgencia": 5,
            "detalles": "Activación manual del tótem de seguridad. Requiere asistencia policial inmediata."
        }

        try:
            # Publicación del mensaje estructurado hacia el broker
            client.publish(TOPIC, json.dumps(payload))
            print(f"[ÉXITO] Alerta publicada en el tópico: {TOPIC}")
        except Exception as e:
            print(f"[ERROR] No se pudo enviar el mensaje por MQTT: {e}")
            
        time.sleep(2)

if __name__ == "__main__":
    iniciar_totem()