Return-Path: <stable+bounces-145078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F8ABD99B
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841C63A3B2B
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6222417F8;
	Tue, 20 May 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQtxvlzI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018E2417E4
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748203; cv=none; b=Bx9XmqhsPLhWVw9L/v7Y6w5UHdSco9CnsAgGB08MI8Q4aqyKe2p2xU7LbRQli/XVB2vEhGRF3YXF8vXGiFEAShhwdhw/0E67SJN6cFpLdIcAbrW7gvXWG0eIvBDJnskwyxWWR1jZXxJD1e1HU8UjmqGANKldSYsE/2caM738ejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748203; c=relaxed/simple;
	bh=5ORxJxUsquv4n4IfZrMP/dOVnmOYOAvp8wnJjMYlpdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uI2qNBPO4+/rOnyUczNTl8xidfBlZKLvZk6Ewhv6qccF5FsMJxxtWwFioJsVBc70t/AwyF1gAjr6L6aYyzOHY639NQsZLgtEs18SSBXi4buP6ey8FMQsdLJ71cyyiYdnC+lxi1rs70yXjkmL35i0J/A63E4BXxHy1qI8RSMgwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQtxvlzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA08EC4CEE9;
	Tue, 20 May 2025 13:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748202;
	bh=5ORxJxUsquv4n4IfZrMP/dOVnmOYOAvp8wnJjMYlpdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hQtxvlzID6nw/dTb/RARVjyicSLycgsX+jZveq2NcVb1vg0wg+JIfvhA/1sZ/Op78
	 5KZYD/JRbldtr08ueDo8/GxQrhLnvGLIG4VdmudKBBi+Lhtamfw6RyjUdfglhi90JY
	 3EBEnZRL+xuY5RRJ2Ie4GGcFzlHqMKFyB7hIHyz8ezzfo/BD4gClf0W5fGyDT42CfZ
	 ijqbGKXY+SGtOtbZQPDjGAVFzFNcjQ5KCHDi/Jn/xC0wakli/YQ0DJbU4wNV/3oPxE
	 FIZYx07bWKWWmv8nPx0fShkiO0rR9km5v0VxeXkQnFdamE+KIfYwjlGGqYgUdKcqm3
	 ITZuMvHCh+cnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,5.15 1/3] netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
Date: Tue, 20 May 2025 09:36:40 -0400
Message-Id: <20250520071006-2a8ceed8d6c511f0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519233515.25539-2-pablo@netfilter.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 8965d42bcf54d42cbc72fe34a9d0ec3f8527debd

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pablo Neira Ayuso<pablo@netfilter.org>
Commit author: Florian Westphal<fw@strlen.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 825a80817cf1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8965d42bcf54d ! 1:  55bc2f4ca3c46 netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
    @@ Metadata
      ## Commit message ##
         netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
     
    +    commit 8965d42bcf54d42cbc72fe34a9d0ec3f8527debd upstream.
    +
         It would be better to not store nft_ctx inside nft_trans object,
         the netlink ctx strucutre is huge and most of its information is
         never needed in places that use trans->ctx.
    @@ include/net/netfilter/nf_tables.h: static inline bool nft_chain_is_bound(struct
     
      ## net/netfilter/nf_tables_api.c ##
     @@ net/netfilter/nf_tables_api.c: static void nf_tables_chain_free_chain_rules(struct nft_chain *chain)
    - 	kvfree(chain->blob_next);
    + 	kvfree(chain->rules_next);
      }
      
     -void nf_tables_chain_destroy(struct nft_ctx *ctx)
    @@ net/netfilter/nf_tables_api.c: void nf_tables_chain_destroy(struct nft_ctx *ctx)
      						 &basechain->hook_list, list) {
      				list_del_rcu(&hook->list);
     @@ net/netfilter/nf_tables_api.c: static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
    - err_trans:
    - 	nft_use_dec_restore(&table->use);
    + err_use:
    + 	nf_tables_unregister_hook(net, table, chain);
      err_destroy_chain:
     -	nf_tables_chain_destroy(ctx);
     +	nf_tables_chain_destroy(chain);
    @@ net/netfilter/nf_tables_api.c: static int nf_tables_addchain(struct nft_ctx *ctx
      	return err;
      }
     @@ net/netfilter/nf_tables_api.c: static void nft_commit_release(struct nft_trans *trans)
    - 		if (nft_trans_chain_update(trans))
    - 			nft_hooks_destroy(&nft_trans_chain_hooks(trans));
    - 		else
    --			nf_tables_chain_destroy(&trans->ctx);
    -+			nf_tables_chain_destroy(nft_trans_chain(trans));
    + 		kfree(nft_trans_chain_name(trans));
    + 		break;
    + 	case NFT_MSG_DELCHAIN:
    +-		nf_tables_chain_destroy(&trans->ctx);
    ++		nf_tables_chain_destroy(nft_trans_chain(trans));
      		break;
      	case NFT_MSG_DELRULE:
    - 	case NFT_MSG_DESTROYRULE:
    + 		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
     @@ net/netfilter/nf_tables_api.c: static void nf_tables_abort_release(struct nft_trans *trans)
    - 		if (nft_trans_chain_update(trans))
    - 			nft_hooks_destroy(&nft_trans_chain_hooks(trans));
    - 		else
    --			nf_tables_chain_destroy(&trans->ctx);
    -+			nf_tables_chain_destroy(nft_trans_chain(trans));
    + 		nf_tables_table_destroy(&trans->ctx);
    + 		break;
    + 	case NFT_MSG_NEWCHAIN:
    +-		nf_tables_chain_destroy(&trans->ctx);
    ++		nf_tables_chain_destroy(nft_trans_chain(trans));
      		break;
      	case NFT_MSG_NEWRULE:
      		nf_tables_rule_destroy(&trans->ctx, nft_trans_rule(trans));
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

