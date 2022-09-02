from fastapi import FastAPI
from starlette.responses import RedirectResponse

from .constants import API_PREFIX
from indexer_api.api.v1.routes import api_router


app = FastAPI(
    title="Media Indexer API",
    version="v1",
    openapi_url=f"{API_PREFIX}/openapi.json",
    docs_url=f"{API_PREFIX}/swagger",
    redoc_url=f"{API_PREFIX}/docs",
    debug=False,
)


@app.get(f"{API_PREFIX}/", include_in_schema=False)
def root():
    return RedirectResponse(f"{API_PREFIX}/docs")


app.include_router(api_router, prefix=f"{API_PREFIX}/v1")
