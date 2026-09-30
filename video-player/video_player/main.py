from fastapi import FastAPI

app = FastAPI(title="NetFlux — video-player")


@app.get("/health")
def health() -> dict[str, str]:
    return {"service": "video-player", "status": "ok"}
