from fastapi import FastAPI

app = FastAPI(title="NetFlux — search")


@app.get("/health")
def health() -> dict[str, str]:
    return {"service": "search", "status": "ok"}
