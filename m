Return-Path: <stable+bounces-145085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01BABD99E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F5923A7365
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5F323496B;
	Tue, 20 May 2025 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOG3hwCj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E998BEC
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748215; cv=none; b=ZIAbic16kK/yTvGmcgbLm2NkDZMPRe8wp0jpkP+0IuBQT4C7gB/u01oRpO0TMmgDRS9oyNktPKzClTi0uL68GAGnkm6Dp8vYT0PS7dukfhclaqiQV3DVNlry5/5LZKMdlXH61pQx+t8FS2BKlBTYZF+gH+UXwsDY/lHHHuBF2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748215; c=relaxed/simple;
	bh=WqRr3nqjm20VjEHf3q0KQuqJeyXZus7y7rw2EFogFE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opQ6klV4AxpFAN+ftJDKuse1pFvs9asUZ4z7AERQB2yBENYNaFcCm4f+i9Xf/vTXWU/wIg6TSKW9fXK+py0gKyX9TQYO+0WOtaZuimVuDNWrd2qYKmEcxeGfT1sBOKQlm7CLRdvBQcPYLWiivGU8TR9apR0WRuIMmAXp8tawaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOG3hwCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DCCC4CEE9;
	Tue, 20 May 2025 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748215;
	bh=WqRr3nqjm20VjEHf3q0KQuqJeyXZus7y7rw2EFogFE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOG3hwCjnWPFW3sK67YX4QtuYJogAzfYVTxQI6YbiITHgeyKh5LcGK9UR8Qp9MzKX
	 cy99jctkIOd0PDITgdNK6NnyohrttIbN9dWi5EUD8IvPuUmGI/lB5rHuBK1qyJuTgx
	 HhQapEfXZitn1Jlv7mb7uv9dSD053Oo7w6faYDfUA6i6ZB4DxePYHqQn9LcMLnEl4w
	 9EH3rOLds1ab3gmB4BR9weRAcNIO4a0L4MDxh0vuR/aSns7EN2rI92k0efaxp7L/TU
	 DV58ZTNsS4/PnlTZEKbh0YntS4XcF7rzPuMJTKhPSbt68eLA5uY9V59WJ8gzp0K7I6
	 gjpj8EvfiB22w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,5.10 3/3] netfilter: nf_tables: do not defer rule destruction via call_rcu
Date: Tue, 20 May 2025 09:36:53 -0400
Message-Id: <20250520051517-df4929e37225f830@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520002236.185365-4-pablo@netfilter.org>
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

The upstream commit SHA1 provided is correct: b04df3da1b5c6f6dc7cdccc37941740c078c4043

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pablo Neira Ayuso<pablo@netfilter.org>
Commit author: Florian Westphal<fw@strlen.de>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 7cf0bd232b56)
6.6.y | Present (different SHA1: 27f0574253f6)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b04df3da1b5c6 ! 1:  3ff4a6c514b0d netfilter: nf_tables: do not defer rule destruction via call_rcu
    @@ Metadata
      ## Commit message ##
         netfilter: nf_tables: do not defer rule destruction via call_rcu
     
    +    commit b04df3da1b5c6f6dc7cdccc37941740c078c4043 upstream.
    +
         nf_tables_chain_destroy can sleep, it can't be used from call_rcu
         callbacks.
     
    @@ Commit message
         Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
     
      ## include/net/netfilter/nf_tables.h ##
    -@@ include/net/netfilter/nf_tables.h: struct nft_rule_blob {
    -  *	@name: name of the chain
    -  *	@udlen: user data length
    -  *	@udata: user data in the chain
    -- *	@rcu_head: rcu head for deferred release
    -  *	@blob_next: rule blob pointer to the next in the chain
    -  */
    - struct nft_chain {
     @@ include/net/netfilter/nf_tables.h: struct nft_chain {
      	char				*name;
      	u16				udlen;
    @@ include/net/netfilter/nf_tables.h: struct nft_chain {
     -	struct rcu_head			rcu_head;
      
      	/* Only used during control plane commit phase: */
    - 	struct nft_rule_blob		*blob_next;
    + 	struct nft_rule			**rules_next;
     @@ include/net/netfilter/nf_tables.h: static inline void nft_use_inc_restore(u32 *use)
       *	@sets: sets in the table
       *	@objects: stateful objects in the table
    @@ include/net/netfilter/nf_tables.h: struct nft_table {
      	u32				use;
     
      ## net/netfilter/nf_tables_api.c ##
    -@@ net/netfilter/nf_tables_api.c: static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
    +@@ net/netfilter/nf_tables_api.c: static int nf_tables_newtable(struct net *net, struct sock *nlsk,
      	INIT_LIST_HEAD(&table->sets);
      	INIT_LIST_HEAD(&table->objects);
      	INIT_LIST_HEAD(&table->flowtables);
     -	write_pnet(&table->net, net);
      	table->family = family;
      	table->flags = flags;
    - 	table->handle = ++nft_net->table_handle;
    + 	table->handle = ++table_handle;
     @@ net/netfilter/nf_tables_api.c: void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
      	kfree(rule);
      }
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

