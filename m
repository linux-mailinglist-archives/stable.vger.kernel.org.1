Return-Path: <stable+bounces-95568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091589D9E1F
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 20:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF137282F86
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3D71DE4FF;
	Tue, 26 Nov 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtjOedaS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5128689
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650971; cv=none; b=UGHoCabhO9n6CGjpaiiPXKB2XcKfqZ0TlmWi7KKZ1e0sykfQ/5Zcgv2zEWvF0gNuoznNS5aIkI75vptG8co7m214cgzg4JhSEfWtqJ1JLB8V5rxI3JV0A1Zt44OFTIOhkAMvuiDN/Vpbnw1rTJCnh/pVOEJsS/Fsoc8aUCujFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650971; c=relaxed/simple;
	bh=X/AQq8mVu8rCEUPmThFn6L/sYQVwjIB1aDNhGc5HyeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ+wMRfX7eAzFOi1OJImk9Z/tVpf190A+PLAhL+XDOuRRPzj5roPvPfKG/IIDYfM5F+BUK2gwg/6C4BUd7S/q99rroBS4p5EmINg3l5guiCjJDZGqa+zOMU7QqkeCx6WDE2F0ePKKw0Kp3Z6kIbba/p6ST/7Fg+rtbdQMhUaiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtjOedaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7026AC4CECF;
	Tue, 26 Nov 2024 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732650970;
	bh=X/AQq8mVu8rCEUPmThFn6L/sYQVwjIB1aDNhGc5HyeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtjOedaSOMIHzpD1HQMnovWxSjq6tx5v87gZ9QthLdPdZw0N7IDEjoHcs6qMBLXo6
	 uYDz1ZSo4j8XwbGn6aLBH/wYWbCCxwMnLXIh/Xbjc8SN/dhTBo70xYZ4qibcgFSxwr
	 ot77yrIE5uu3Z8gk8cy0huCekxNoBh5UgQGJepCJRoAsEIl7Nku3NsSYnvojhToXZv
	 X08buK58CXn0wlFtnZJNACGaqhfTTh83ar2/FsR/zvXtnKM6jXk0CZiKEmm+BiXwGj
	 fmTQbRqlv3Atei0RvsQYhmiF7NURi8ljMZEc96j9Hl/XpboShfIDrLDXfAHV2d89z7
	 KWaw27KFUN8DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ziwei Xiao <ziweixiao@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] gve: Fixes for napi_poll when budget is 0
Date: Tue, 26 Nov 2024 14:56:09 -0500
Message-ID: <20241126144949-7ec7ce3db1b874e7@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126184731.2497956-1-ziweixiao@google.com>
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
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ff33be9cecee)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 14:46:00.728480326 -0500
+++ /tmp/tmp.OFZu4s6rk5	2024-11-26 14:46:00.726235127 -0500
@@ -1,40 +1,33 @@
-Netpoll will explicilty pass the polling call with a budget of 0 to
-indicate it's clearing the Tx path only. For the gve_rx_poll and
-gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
-to do all the work. Add check to avoid the rx path and xdp path being
-called when budget is 0. And also avoid napi_complete_done being called
-when budget is 0 for netpoll.
+The original fix was merged here:
+https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
+Resend it since the original one was not cleanly applied to 6.1 kernel.
 
 Fixes: f5cedc84a30d ("gve: Add transmit and receive support")
 Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
-Link: https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
-Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
+Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
 ---
- drivers/net/ethernet/google/gve/gve_main.c | 8 +++++++-
+ drivers/net/ethernet/google/gve/gve_main.c | 7 +++++++
  drivers/net/ethernet/google/gve/gve_rx.c   | 4 ----
  drivers/net/ethernet/google/gve/gve_tx.c   | 4 ----
- 3 files changed, 7 insertions(+), 9 deletions(-)
+ 3 files changed, 7 insertions(+), 8 deletions(-)
 
 diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
-index 276f996f95dcc..2d42e733837b0 100644
+index d3f6ad586ba1..8771ccfc69b4 100644
 --- a/drivers/net/ethernet/google/gve/gve_main.c
 +++ b/drivers/net/ethernet/google/gve/gve_main.c
-@@ -254,10 +254,13 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
- 	if (block->tx) {
- 		if (block->tx->q_num < priv->tx_cfg.num_queues)
- 			reschedule |= gve_tx_poll(block, budget);
--		else
-+		else if (budget)
- 			reschedule |= gve_xdp_poll(block, budget);
- 	}
+@@ -202,6 +202,10 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
  
+ 	if (block->tx)
+ 		reschedule |= gve_tx_poll(block, budget);
++
 +	if (!budget)
 +		return 0;
 +
  	if (block->rx) {
  		work_done = gve_rx_poll(block, budget);
  		reschedule |= work_done == budget;
-@@ -298,6 +301,9 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
+@@ -242,6 +246,9 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
  	if (block->tx)
  		reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
  
@@ -45,10 +38,10 @@
  		work_done = gve_rx_poll_dqo(block, budget);
  		reschedule |= work_done == budget;
 diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
-index e84a066aa1a40..73655347902d2 100644
+index 021bbf308d68..639eb6848c7d 100644
 --- a/drivers/net/ethernet/google/gve/gve_rx.c
 +++ b/drivers/net/ethernet/google/gve/gve_rx.c
-@@ -1007,10 +1007,6 @@ int gve_rx_poll(struct gve_notify_block *block, int budget)
+@@ -778,10 +778,6 @@ int gve_rx_poll(struct gve_notify_block *block, int budget)
  
  	feat = block->napi.dev->features;
  
@@ -60,17 +53,20 @@
  		work_done = gve_clean_rx_done(rx, budget, feat);
  
 diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
-index 6957a865cff37..9f6ffc4a54f0b 100644
+index 5e11b8236754..bf1ac0d1dc6f 100644
 --- a/drivers/net/ethernet/google/gve/gve_tx.c
 +++ b/drivers/net/ethernet/google/gve/gve_tx.c
-@@ -925,10 +925,6 @@ bool gve_xdp_poll(struct gve_notify_block *block, int budget)
- 	bool repoll;
+@@ -725,10 +725,6 @@ bool gve_tx_poll(struct gve_notify_block *block, int budget)
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
+-- 
+2.47.0.338.g60cca15819-goog
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

