from fastapi import FastAPI

app = FastAPI(title="NetFlux — stats")


@app.get("/health")
def health() -> dict[str, str]:
    return {"service": "stats", "status": "ok"}
