from fastapi import FastAPI

app = FastAPI(title="NetFlux — bookmarks")


@app.get("/health")
def health() -> dict[str, str]:
    return {"service": "bookmarks", "status": "ok"}
