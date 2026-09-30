from fastapi import FastAPI

app = FastAPI(title="NetFlux — main")


@app.get("/health")
def health() -> dict[str, str]:
    return {"service": "main", "status": "ok"}
