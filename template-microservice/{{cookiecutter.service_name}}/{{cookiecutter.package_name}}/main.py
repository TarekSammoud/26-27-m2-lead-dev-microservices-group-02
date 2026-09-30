from fastapi import FastAPI

app = FastAPI(title="NetFlux — {{ cookiecutter.service_name }}")


@app.get("/health")
def health() -> dict[str, str]:
    return {"service": "{{ cookiecutter.service_name }}", "status": "ok"}
