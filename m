Return-Path: <stable+bounces-145092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 472CCABD9C8
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D05188A295
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E01242D76;
	Tue, 20 May 2025 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy3EQG9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1062F37
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748574; cv=none; b=cEM1H/wplpUyoL85ICgWrdVTPPkLaeO9Pqt+oSlXhz6dTQ2FufzBNtBQQuDiVSALzx8geKkJqZ5ogimigMKhaa6yh2i+pVWkRBWmQJXaK5pE1kcGJTLmThK6erGdCbJqGSNyxuHlBLQT/Vv9aFMdwsF77wW67JQQ587fiwiLydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748574; c=relaxed/simple;
	bh=h8jXzIWJiawuxMJKhKBnO01ZxxuccT76hd6oU6TD2xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlIS0Rn2Jy1F22KQVjY3u5uUa8jpyFILVnm2oqJ0tDEGNuKualWntGFcJ//gFrrUSCoZd1LSGSbjOZFA4SaJsoq7wIlSf3kBhaAy5rdbfTKnL4C+uW82hmqNfCDioxo34WFNrJEDdtBoitJvp+b0kZH3JlDHAxoXmD7UoGQ2Q/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy3EQG9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A791C4CEE9;
	Tue, 20 May 2025 13:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748573;
	bh=h8jXzIWJiawuxMJKhKBnO01ZxxuccT76hd6oU6TD2xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uy3EQG9HFSnEYcvSjk9a37R+4ML0gsENQ3G8T2+o15yeHcJlPv/V3W3ED7e79LnG8
	 Kob8uNqDMVHUpCFW4FrkH7Sdr9ZGZwlJSoecRxH6SAsJh7QQv5c6Agwq6tolrgtLSJ
	 quTmXXd+1KpUDtORiIsnLRiiAM5wZZmItGBz9t7hTIJCKA9RbykrmcJVrrrJ8bNVDA
	 FlTWNs5wkuvEFEtCi/+T56fFVz31ANYMs9x0j4B0keExguASOSilCzmOsUeiMP14R3
	 PiaL8gQQgN3yOIWDKt/F+bIkkD7C4cUTnsv25Bc8F5FyV3bqOl5wtvvhFC+eSmEerd
	 ssb5EsTH2HX0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pablo@netfilter.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH -stable,5.10 2/3] netfilter: nf_tables: wait for rcu grace period on net_device removal
Date: Tue, 20 May 2025 09:42:52 -0400
Message-Id: <20250520050514-7a16f4c9834fb4a7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520002236.185365-3-pablo@netfilter.org>
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
5.15.y | Not found

Found fixes commits:
b04df3da1b5c netfilter: nf_tables: do not defer rule destruction via call_rcu

Note: The patch differs from the upstream commit:
---
1:  c03d278fdf35e ! 1:  69ad0f74eb737 netfilter: nf_tables: wait for rcu grace period on net_device removal
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
    @@ include/net/netfilter/nf_tables.h: struct nft_table {
      	u32				use;
     
      ## net/netfilter/nf_tables_api.c ##
    -@@ net/netfilter/nf_tables_api.c: static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
    +@@ net/netfilter/nf_tables_api.c: static int nf_tables_newtable(struct net *net, struct sock *nlsk,
      	INIT_LIST_HEAD(&table->sets);
      	INIT_LIST_HEAD(&table->objects);
      	INIT_LIST_HEAD(&table->flowtables);
     +	write_pnet(&table->net, net);
      	table->family = family;
      	table->flags = flags;
    - 	table->handle = ++nft_net->table_handle;
    + 	table->handle = ++table_handle;
     @@ net/netfilter/nf_tables_api.c: int nft_data_dump(struct sk_buff *skb, int attr, const struct nft_data *data,
      }
      EXPORT_SYMBOL_GPL(nft_data_dump);
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

