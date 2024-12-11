Return-Path: <stable+bounces-100679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 660169ED205
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD9E1889E3A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F11DDC20;
	Wed, 11 Dec 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvWcSrZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED91DD9A6
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934814; cv=none; b=t1V+1bORbhmFCEV2/QAd/tB2IuAHqPbTvr+QjyiGqcFR2kja1wZubmsDUOEVulu4GhFBP3u8OadI5+mZ9ORHtBidoK05UhdtaNHlPkkFub/zfjOYXUJH5k0/3YWz7IFVHAGilRnGmWFoSTf3DhGkfKKdwriVhl77VZFVvTSAtv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934814; c=relaxed/simple;
	bh=9ZpvkrOEFPQlV40bKZ5TO8hUH8CUqHpRbswMAkuQo0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAKSlvUjaVTvLKN/mjv8u76M4Mn9RjeJ+Vc1uAqOhcRJA6Z9l4nonxRlPZCa0Sa4iYxxSGakVqab86yU721I/Ia9JVggYOHzE7X0hoUf9TGeF6xRLmib/2wSfvLwQyCMBBtZ0Z361eCTbP1Dm6mJ6j+gvHMGbiH/2NCRWdxnoY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvWcSrZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD70C4CED2;
	Wed, 11 Dec 2024 16:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934813;
	bh=9ZpvkrOEFPQlV40bKZ5TO8hUH8CUqHpRbswMAkuQo0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvWcSrZIOWe4EZbLr+WB54CgsncYJzlZOyuHhcAhcVfNr29YiMSFKpvBf5e63IasY
	 BO+e5qFabzhNyr1jcpTkdlY3D/Hg4Tybfnfc0mJJEUh0LyBXtzeGfAgNAtwsh2R9gq
	 aDVOypU8Y+mc0X7aKMs2RXRPvrLfuuSKNgtSJmk1F9r4vrCQmdRQMRBpIUHdFDIwmu
	 KmbpImbipPsKC4L0O5MgQ6zIFTQmB2VL7ohgSdVwIm2xeboIhaYfXH6Oxsm9S92d7j
	 ObifLEU/SQXb+N5uQFG2ByEVeOcYb2th5zjX02KftEbyYQu8xKZtPuJbQgJgIOvdOL
	 dzbxsclES/y6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ziwei Xiao <ziweixiao@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 v2] gve: Fixes for napi_poll when budget is 0
Date: Wed, 11 Dec 2024 11:33:32 -0500
Message-ID: <20241211103629-2d6e9d387278b995@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210235758.637910-1-ziweixiao@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 278a370c1766060d2144d6cf0b06c101e1043b6d


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ff33be9cecee)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  278a370c17660 ! 1:  68463e6a71027 gve: Fixes for napi_poll when budget is 0
    @@ Metadata
      ## Commit message ##
         gve: Fixes for napi_poll when budget is 0
     
    -    Netpoll will explicilty pass the polling call with a budget of 0 to
    +    Netpoll will explicitly pass the polling call with a budget of 0 to
         indicate it's clearing the Tx path only. For the gve_rx_poll and
         gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
         to do all the work. Add check to avoid the rx path and xdp path being
         called when budget is 0. And also avoid napi_complete_done being called
         when budget is 0 for netpoll.
     
    +    The original fix was merged here:
    +    https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
    +    Resend it since the original one was not cleanly applied to 6.1 kernel.
    +
    +    commit 278a370c1766 ("gve: Fixes for napi_poll when budget is 0")
    +
         Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
         Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
    -    Link: https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
    -    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
    +    Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
     
      ## drivers/net/ethernet/google/gve/gve_main.c ##
     @@ drivers/net/ethernet/google/gve/gve_main.c: static int gve_napi_poll(struct napi_struct *napi, int budget)
    - 	if (block->tx) {
    - 		if (block->tx->q_num < priv->tx_cfg.num_queues)
    - 			reschedule |= gve_tx_poll(block, budget);
    --		else
    -+		else if (budget)
    - 			reschedule |= gve_xdp_poll(block, budget);
    - 	}
      
    + 	if (block->tx)
    + 		reschedule |= gve_tx_poll(block, budget);
    ++
     +	if (!budget)
     +		return 0;
     +
    @@ drivers/net/ethernet/google/gve/gve_rx.c: int gve_rx_poll(struct gve_notify_bloc
      
     
      ## drivers/net/ethernet/google/gve/gve_tx.c ##
    -@@ drivers/net/ethernet/google/gve/gve_tx.c: bool gve_xdp_poll(struct gve_notify_block *block, int budget)
    - 	bool repoll;
    +@@ drivers/net/ethernet/google/gve/gve_tx.c: bool gve_tx_poll(struct gve_notify_block *block, int budget)
    + 	u32 nic_done;
      	u32 to_do;
      
     -	/* If budget is 0, do all the work */
     -	if (budget == 0)
     -		budget = INT_MAX;
     -
    - 	/* Find out how much work there is to be done */
    - 	nic_done = gve_tx_load_event_counter(priv, tx);
    - 	to_do = min_t(u32, (nic_done - tx->done), budget);
    + 	/* In TX path, it may try to clean completed pkts in order to xmit,
    + 	 * to avoid cleaning conflict, use spin_lock(), it yields better
    + 	 * concurrency between xmit/clean than netif's lock.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

