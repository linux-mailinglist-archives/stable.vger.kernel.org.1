Return-Path: <stable+bounces-145093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF8ABD9C9
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BE6188C6CE
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F82242D7F;
	Tue, 20 May 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axPx0/GX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E81ACECE
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748576; cv=none; b=cttx/Ozbl6dtUE8K1jEV07cedWkh0xR1MkLEFlT5St7GHYLIdi7xzKBHHrjKim1NH7uoDr59IMxZ1eqY4YETF+87WfKOQVqeLVIyAjv+J1od7jZ2meR10FmWv1yxSxlpQOAMJOA6LsF33ACI9gbHzVDnMyQ2kzBL/AwxR1GzATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748576; c=relaxed/simple;
	bh=ccQw1ypctHamaUnTzujs+eh5roAr5Jl+wnIYF0/bJAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIr02q+o+Iee7206O2Qi6qY6leFftxihFb0JUn5Ch5eIFu9C4qNagogII4eDhJ/leGF5pqQTcKGcQ82QHeimIJxC3387yVq/+37w5DTuIC/uDTBEffsVzA722XZyMBpn2eY36UJdkYqgPtnrhI8lnISMyjsQyTB6Il+NeBV8PJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axPx0/GX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDAFC4CEEA;
	Tue, 20 May 2025 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748575;
	bh=ccQw1ypctHamaUnTzujs+eh5roAr5Jl+wnIYF0/bJAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=axPx0/GXEZvFTHgeBk4pPCfhpyzRq3FVjYRumXLVadK9vKaPlC8kAgdDE6p7VY/GW
	 Ql3L5z0nnKeO/1m+GZXlIGHT4RLxuuoY4Jhv0HHxcrqHbw2+x/l4GdDqDNZ76CuKoI
	 lNIjBDGTxc0Zh036+P7QshjjtUt2W7gKdf0MU2nnDtgHaNxxIRt+BHhi5O6li8Z+e9
	 PLXxB6s+JzJ4hkha473sWFQETQqRmRok7hWl9uskZDxIm6XNfp+AcXoeYXaZjTCnhp
	 05lR+CcKMWkK78kSP02+mVSfMgf0EdbNhzpP7BTQtmWegSQqzOAnYzuRYFB5Rn7Dxc
	 FF5aCocS91jag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,5.10 1/3] netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
Date: Tue, 20 May 2025 09:42:53 -0400
Message-Id: <20250520045436-a59c2fa3c85f0dd8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520002236.185365-2-pablo@netfilter.org>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8965d42bcf54d ! 1:  b89d3ef279494 netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
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
    @@ net/netfilter/nf_tables_api.c: static void __nft_release_table(struct net *net,
     -		nf_tables_chain_destroy(&ctx);
     +		nf_tables_chain_destroy(chain);
      	}
    + 	list_del(&table->list);
      	nf_tables_table_destroy(&ctx);
    - }
     
      ## net/netfilter/nft_immediate.c ##
     @@ net/netfilter/nft_immediate.c: static void nft_immediate_destroy(const struct nft_ctx *ctx,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

