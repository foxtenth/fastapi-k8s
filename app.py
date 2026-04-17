from fastapi import FastAPI
import redis
import os

app = FastAPI()

REDIS_HOST = os.getenv("REDIS_HOST", "redis")
REDIS_PORT = os.getenv("REDIS_DB_PORT", 6379)
REDIS_PASSWORD = os.getenv("REDIS_PASSWORD", '') # Add this

# Update the client to use the password
r = redis.Redis(
    host=REDIS_HOST, 
    port=REDIS_PORT, 
    password=REDIS_PASSWORD, 
    decode_responses=True
)

@app.get("/")
def read_root():
    return {"status": "FastAPI is running"}

@app.get("/hits")
def read_hits():
    try:
        hits = r.incr("hits")
        return {"hits": hits, "redis_host": REDIS_HOST}
    except Exception as e:
        return {"error": str(e)}
