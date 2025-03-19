module LegalDocument::Storage {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a legal document
    struct Document has store, key {
        document_hash: vector<u8>,  // SHA256 hash of the document
        owner: address,            // Address of the document owner
    }

    /// Function to store a legal document hash
    public fun store_document(owner: &signer, document_hash: vector<u8>) {
        let doc = Document {
            document_hash,
            owner: signer::address_of(owner),
        };
        move_to(owner, doc);
    }

    /// Function to verify a legal document by its hash
    public fun verify_document(doc_owner: address, document_hash: vector<u8>) acquires Document {
        let doc = borrow_global<Document>(doc_owner);

        // Check if the provided hash matches the stored one
        assert!(doc.document_hash == document_hash, 1);  // Error code 1 for hash mismatch
    }
}

