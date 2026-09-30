from fastapi import FastAPI

app = FastAPI(title="NetFlux — video-convert")


@app.get("/health")
def health() -> dict[str, str]:
    return {"service": "video-convert", "status": "ok"}
