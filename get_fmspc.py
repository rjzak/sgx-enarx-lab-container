#!/usr/bin/python3

import urllib.request

INTEL_CACHE_DIR = "/var/cache/intel-sgx/"
CSV_FILE = INTEL_CACHE_DIR + "pckid_retrieval.csv"
FMSPC_FILE = INTEL_CACHE_DIR + "fmspc.txt"
PCK_FILE = INTEL_CACHE_DIR + "pck.crt"

CSV = open(CSV_FILE).read().split(",")
url = f"https://api.trustedservices.intel.com/sgx/certification/v4/pckcert?encrypted_ppid={CSV[0]}&cpusvn={CSV[2]}&pcesvn={CSV[3]}&pceid={CSV[1]}"

response = urllib.request.urlopen(url)
fmspc = response.getheader("SGX-FMSPC")
pck = response.read()

open(FMSPC_FILE, "w").write(fmspc)
open(PCK_FILE, "wb").write(pck)
