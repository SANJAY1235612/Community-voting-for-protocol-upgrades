module MyModule::CommunityVoting {
    use aptos_framework::signer;

    /// Struct representing a protocol upgrade proposal.
    struct Proposal has store, key {
        support_votes: u64,  // Votes in support of the proposal
        total_votes: u64,   // Total votes submitted
    }

    /// Function to create a new proposal.
    public fun create_proposal(owner: &signer) {
        let proposal = Proposal {
            support_votes: 0,
            total_votes: 0,
        };
        move_to(owner, proposal);
    }

    /// Function to vote on a proposal.
    public fun vote_on_proposal(_voter: &signer, proposal_owner: address, support: bool)
    acquires Proposal {
        let proposal = borrow_global_mut<Proposal>(proposal_owner);
        // Increment total votes
        proposal.total_votes = proposal.total_votes + 1;
        // Increment support votes if the voter supports the proposal
        if (support) {
            proposal.support_votes = proposal.support_votes + 1;
        }
    }
}
