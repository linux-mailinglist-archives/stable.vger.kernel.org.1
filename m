Return-Path: <stable+bounces-132790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCAAA8AA42
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 23:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA464413A5
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D48B256C60;
	Tue, 15 Apr 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrZGEMEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F53253357
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744753403; cv=none; b=LXCKb4DxrAIiV52BgJHV5/XHI8pgBIN+IAMED6XvvW12jsWBqDppxIwkJ2Nnxt6/hEdD5wOtw07nKbfljU8iPGs3guDzAzVZ7IbUAVsVuGzXSBre/2KZH5FTcenAPHq/TWwTMFpcvmxwCQjRYZOFMzPbgwbXKqAmtE1BoNYtMbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744753403; c=relaxed/simple;
	bh=kE+aPT5wvJ58RaJ7LPHwfUb7icFh7pmNSidIrc174ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBd/rRhhicWMweNWUMCqoDdIrja/OG++Iu7FxU3kqeWJoSn2BnzKxOpbzvzIe2tE/tmmC16Crb98DZCWZsfr5pUnI/+XWRO3NhR1iF3q8zq1vAWRUjrNABDP6ygj7+i/zuY2vDaohmzVTRHSUEKMViO5V12qjZWDa8cZ1RUYWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrZGEMEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AB7C4CEE7;
	Tue, 15 Apr 2025 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744753403;
	bh=kE+aPT5wvJ58RaJ7LPHwfUb7icFh7pmNSidIrc174ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrZGEMEYC3KbdKkEZHbDBTA35gFcPmSOCkythyai4AhyJWNX3qA5G/4pxJjiSi8nP
	 v+dNzx1lutCslyq3FMTrLrlRtFcmnkejkWzjYxgzkGdgWEph2MQ06WXdRykEhyx7SU
	 tdvPEgk0o/k25WvY6AbZ+ME3/tcZSo9I8GohZbeCJV27mqrimy8RTjxxDd/BQO8FUh
	 ZTZstQZWYwzuA2oToEGpme/EN9GYwsLHdneLHWB6JR/BJ0GnUKvzXwYhlLVFFCYHYj
	 Bs8GfsquHHZUYdWTTpqhBi/gCyKf4dm80KLiECWnttj/Xnykvr8D2U1LDeVFg92wt6
	 Znny206/KbPTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/6] net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup
Date: Tue, 15 Apr 2025 17:43:21 -0400
Message-Id: <20250415122901-6bfa14a44451aef9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414185023.2165422-2-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: b6ecc662037694488bfff7c9fd21c405df8411f2

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>
Commit author: Souradeep Chakrabarti<schakrabarti@linux.microsoft.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 9e0bff4900b5)
6.1.y | Present (different SHA1: 9178eb8ebcd8)

Note: The patch differs from the upstream commit:
---
1:  b6ecc66203769 ! 1:  63ebacf9b41b2 net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup
    @@ Metadata
      ## Commit message ##
         net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup
     
    +    [ Upstream commit b6ecc662037694488bfff7c9fd21c405df8411f2 ]
    +
         Currently napi_disable() gets called during rxq and txq cleanup,
         even before napi is enabled and hrtimer is initialized. It causes
         kernel panic.
    @@ Commit message
         Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
         Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    (cherry picked from commit b6ecc662037694488bfff7c9fd21c405df8411f2)
    +    [Harshit: conflicts resolved due to missing commit: ed5356b53f07 ("net:
    +    mana: Add XDP support") and commit: d356abb95b98 ("net: mana: Add
    +    counter for XDP_TX") in 5.15.y]
    +    Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    +
    + ## drivers/net/ethernet/microsoft/mana/mana.h ##
    +@@ drivers/net/ethernet/microsoft/mana/mana.h: struct mana_txq {
    + 
    + 	atomic_t pending_sends;
    + 
    ++	bool napi_initialized;
    ++
    + 	struct mana_stats stats;
    + };
    + 
     
      ## drivers/net/ethernet/microsoft/mana/mana_en.c ##
     @@ drivers/net/ethernet/microsoft/mana/mana_en.c: static void mana_destroy_txq(struct mana_port_context *apc)
    @@ drivers/net/ethernet/microsoft/mana/mana_en.c: static int mana_create_txq(struct
      		memset(&spec, 0, sizeof(spec));
     @@ drivers/net/ethernet/microsoft/mana/mana_en.c: static int mana_create_txq(struct mana_port_context *apc,
      
    - 		netif_napi_add_tx(net, &cq->napi, mana_poll);
    + 		netif_tx_napi_add(net, &cq->napi, mana_poll, NAPI_POLL_WEIGHT);
      		napi_enable(&cq->napi);
     +		txq->napi_initialized = true;
      
    @@ drivers/net/ethernet/microsoft/mana/mana_en.c: static void mana_destroy_rxq(stru
      		napi_synchronize(napi);
      
     -	napi_disable(napi);
    +-	netif_napi_del(napi);
     +		napi_disable(napi);
      
     +		netif_napi_del(napi);
     +	}
    - 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
    - 
    --	netif_napi_del(napi);
    --
      	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
      
      	mana_deinit_cq(apc, &rxq->rx_cq);
    -
    - ## include/net/mana/mana.h ##
    -@@ include/net/mana/mana.h: struct mana_txq {
    - 
    - 	atomic_t pending_sends;
    - 
    -+	bool napi_initialized;
    -+
    - 	struct mana_stats_tx stats;
    - };
    - 
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

