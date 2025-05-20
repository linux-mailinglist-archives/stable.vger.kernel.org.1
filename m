Return-Path: <stable+bounces-145082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11551ABD995
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11437ADC07
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54E222DA1A;
	Tue, 20 May 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M45eseUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657222D794
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748210; cv=none; b=R6ocx94JyiQ1Hj8aNeovtoA1Ez2/iUT7Jnrib7o4UmgpTdfl5ogJN5P+HaHpbrXa//k5mN0ELP/82J2i6/628jLMfC1QSGAGTQTCLzVWR/0NVFzh8T1jJJv1ipljI4tWRDYGKXbVBbRBbdhLuu68OJ6ECw2VtnKKM/s6z9Jee2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748210; c=relaxed/simple;
	bh=VH1aLAo58w/ZoSTQREnTFSjAzdw4acckexITH+6cesM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcXztF2JvGg/WEU+PtVxtDVxMZeQtsl6esOASKJnITdHyiP57odLNMbUL+TqGbGzod0NGZlLsztoKia8PBzL1QUT846xrdAzDse4TZo1Noin/jSSmFKOgvgrJO6XAB0BMT9ZfsY4QiUAqztdS21+U5qL7B4y7X8XjZcAKkM2iYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M45eseUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EEEC4CEEA;
	Tue, 20 May 2025 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748209;
	bh=VH1aLAo58w/ZoSTQREnTFSjAzdw4acckexITH+6cesM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M45eseUSoJn2wOzRuIUaAvoYv3/NfnGOQOyX8yRQ/AxM7ldBhpQ1hfV06Yr47Otpf
	 k9NNEuON9/nIkIN+vUnlPlRv9Ptb3iUEIk0OLVksN/5DkYaaZjK36mDczypT6ezY/i
	 fgvj4NIvCf+mAeCpEfsXvfIsHTuXjivQfB9sPJsCsLsYuKv/1f3z7MBMSQnjcjqkbE
	 aHMMPTEMQKS62GHU4cNOWqMyYRLa/fXc13E9EAIt3EFfXyzOJDj5Xoc963FcDiGnsh
	 vMaY0MTfsUNm54PFfcYJdBrP0KwwVMRg8kZ4+GbAAz91mQNyj+2iRDvPaUcjD+X9Hp
	 6/DsSGfLbiWvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pablo@netfilter.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,5.15 2/3] netfilter: nf_tables: wait for rcu grace period on net_device removal
Date: Tue, 20 May 2025 09:36:48 -0400
Message-Id: <20250520072116-ee51acaeee7e7292@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519233515.25539-3-pablo@netfilter.org>
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

Summary of potential issues:
ℹ️ This is part 2/3 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: c03d278fdf35e73dd0ec543b9b556876b9d9a8dc

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: bfd05c68e4c6)
6.1.y | Not found

Found fixes commits:
b04df3da1b5c netfilter: nf_tables: do not defer rule destruction via call_rcu

Note: The patch differs from the upstream commit:
---
1:  c03d278fdf35e ! 1:  14e8d506ade73 netfilter: nf_tables: wait for rcu grace period on net_device removal
    @@ Metadata
      ## Commit message ##
         netfilter: nf_tables: wait for rcu grace period on net_device removal
     
    +    commit c03d278fdf35e73dd0ec543b9b556876b9d9a8dc upstream.
    +
         8c873e219970 ("netfilter: core: free hooks with call_rcu") removed
         synchronize_net() call when unregistering basechain hook, however,
         net_device removal event handler for the NFPROTO_NETDEV was not updated
    @@ Commit message
         Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
     
      ## include/net/netfilter/nf_tables.h ##
    -@@ include/net/netfilter/nf_tables.h: struct nft_rule_blob {
    -  *	@name: name of the chain
    -  *	@udlen: user data length
    -  *	@udata: user data in the chain
    -+ *	@rcu_head: rcu head for deferred release
    -  *	@blob_next: rule blob pointer to the next in the chain
    -  */
    - struct nft_chain {
     @@ include/net/netfilter/nf_tables.h: struct nft_chain {
      	char				*name;
      	u16				udlen;
    @@ include/net/netfilter/nf_tables.h: struct nft_chain {
     +	struct rcu_head			rcu_head;
      
      	/* Only used during control plane commit phase: */
    - 	struct nft_rule_blob		*blob_next;
    + 	struct nft_rule			**rules_next;
     @@ include/net/netfilter/nf_tables.h: static inline void nft_use_inc_restore(u32 *use)
       *	@sets: sets in the table
       *	@objects: stateful objects in the table
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

