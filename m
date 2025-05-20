Return-Path: <stable+bounces-145094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55AAABD9CA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019671887A21
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C01EA7FF;
	Tue, 20 May 2025 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGE1WNAW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069019F464
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748578; cv=none; b=btmdt7ueGHJaXxJMgPRduMF5Ot4MnMFXMtqyaaih5h9Rgt1OkQ4ekaliCYM51T2uTI12GjTR78StO2wI8Vpn8EGAIUuvzVXU76qv1nBEFIxPCO68kQNzBGrd6IBJx22I/7Lc43VbIT97ZH8fBsbqAU9SrpdTujye4UmWSiLldxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748578; c=relaxed/simple;
	bh=0TGjtmDobw+tUKG3gswG1Rzzeko+WH0xFidHgkBkJTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/XpsmPLPWvKyZk3Bulwj99AB4E749UL65ceAJNnChbNXXTYFDaQ4ShlEoWkOaMPB3kKu3PjhONqEovk0vBgv5sycldrXtqdWH7oy46CSwGv2ohsfewENjC57KqfC2XeyNYc5w2sQHHzrQyJoYxw+R9i52pvR7RpnGZWHzQ3Rp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGE1WNAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D99CC4CEE9;
	Tue, 20 May 2025 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748577;
	bh=0TGjtmDobw+tUKG3gswG1Rzzeko+WH0xFidHgkBkJTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZGE1WNAWmUsDzEk71LmMY6YlGoz/pXGgnb/p1hIBE3Kkhr5VtfOuT2tTmb8ih63o6
	 TeYi2V6Z8Qws/M35HU7x0I29dFpu/JtbKLBBF1valBT6DNh9kFf/xbcWiXusK0wd6v
	 ZtooRq0BPtk5yvhd7nZqNcDra+NMpH9SYP1ZlUN7EY8lgxcpPPNCvJNA5Z3eyKLzYP
	 cbDuUoPG5Cl8eu/Tcxhqp8I3qvaon67awMB8B3k65+3qyqwlaoQ78VEL7tTD9RTnAm
	 on0tDI5gkU4W3c3wkBaL1tRctwaGncdzvDxtzdKo+8ir8AEP4Q1zv2xEUMSy0fbHON
	 XOPzf9THFS5+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,6.1 1/3] netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
Date: Tue, 20 May 2025 09:42:55 -0400
Message-Id: <20250520063816-41ba984eaddb5b28@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519233438.22640-2-pablo@netfilter.org>
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

Note: The patch differs from the upstream commit:
---
1:  8965d42bcf54d ! 1:  ef035fe6fb396 netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
    @@ Metadata
      ## Commit message ##
         netfilter: nf_tables: pass nft_chain to destroy function, not nft_ctx
     
    +    commit 8965d42bcf54d42cbc72fe34a9d0ec3f8527debd upstream.
    +
         It would be better to not store nft_ctx inside nft_trans object,
         the netlink ctx strucutre is huge and most of its information is
         never needed in places that use trans->ctx.
    @@ Commit message
     
         Signed-off-by: Florian Westphal <fw@strlen.de>
         Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
    +    Stable-dep-of: c03d278fdf35 ("netfilter: nf_tables: wait for rcu grace period on net_device removal")
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
     
      ## include/net/netfilter/nf_tables.h ##
     @@ include/net/netfilter/nf_tables.h: static inline bool nft_chain_is_bound(struct nft_chain *chain)
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
| stable/linux-6.1.y        |  Success    |  Success   |

