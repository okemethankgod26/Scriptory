// tests/manuscript.test.ts
import { describe, it, expect, beforeEach } from "vitest"

interface Manuscript {
  owner: string;
  uri: string;
  version: number;
  history: Map<number, string>;
}

const admin = "ST1ADMIN...";

let mockManuscripts: Map<number, Manuscript>;
let ownerMap: Map<number, string>;
let tokenCounter: number;

beforeEach(() => {
  mockManuscripts = new Map();
  ownerMap = new Map();
  tokenCounter = 0;
})

function mintManuscript(sender: string, uri: string): { value?: number; error?: number } {
  if (uri.length <= 5) return { error: 101 }
  tokenCounter++
  mockManuscripts.set(tokenCounter, {
    owner: sender,
    uri,
    version: 1,
    history: new Map([[1, uri]])
  })
  ownerMap.set(tokenCounter, sender)
  return { value: tokenCounter }
}

function updateVersion(sender: string, tokenId: number, newUri: string): { value?: number; error?: number } {
  const manuscript = mockManuscripts.get(tokenId)
  if (!manuscript) return { error: 104 }
  if (manuscript.owner !== sender) return { error: 102 }
  if (newUri.length <= 5) return { error: 101 }
  manuscript.version++
  manuscript.uri = newUri
  manuscript.history.set(manuscript.version, newUri)
  return { value: manuscript.version }
}

describe("Manuscript Contract", () => {
  it("should mint a manuscript with valid URI", () => {
    const result = mintManuscript("ST2WRITER...", "ipfs://hash1")
    expect(result).toEqual({ value: 1 })
  })

  it("should reject minting with short URI", () => {
    const result = mintManuscript("ST2WRITER...", "bad")
    expect(result).toEqual({ error: 101 })
  })

  it("should update manuscript version if owner", () => {
    mintManuscript("ST2WRITER...", "ipfs://original")
    const result = updateVersion("ST2WRITER...", 1, "ipfs://v2")
    expect(result).toEqual({ value: 2 })
  })

  it("should reject update from non-owner", () => {
    mintManuscript("ST2WRITER...", "ipfs://original")
    const result = updateVersion("ST3NOTOWNER...", 1, "ipfs://v2")
    expect(result).toEqual({ error: 102 })
  })

  it("should reject update with short URI", () => {
    mintManuscript("ST2WRITER...", "ipfs://original")
    const result = updateVersion("ST2WRITER...", 1, "bad")
    expect(result).toEqual({ error: 101 })
  })

  it("should return correct version after multiple updates", () => {
    mintManuscript("ST2WRITER...", "ipfs://v1")
    updateVersion("ST2WRITER...", 1, "ipfs://v2")
    const result = updateVersion("ST2WRITER...", 1, "ipfs://v3")
    expect(result).toEqual({ value: 3 })
  })
})
