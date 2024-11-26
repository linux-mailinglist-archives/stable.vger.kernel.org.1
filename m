Return-Path: <stable+bounces-95567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A99D9E1E
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 20:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA22166A4A
	for <lists+stable@lfdr.de>; Tue, 26 Nov 2024 19:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDFB1DE3A3;
	Tue, 26 Nov 2024 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHBdLrWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920A28689
	for <stable@vger.kernel.org>; Tue, 26 Nov 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732650969; cv=none; b=cFbI3Y3eQRjEfGRuJb5oWIL8of1a+Vo3zvzfylcpLfAlCzQP1sKgvjHnAgUWLWYECo8f5V1pgpwKw6fxniDOK07snnBh5kWJVI4IjIOOlGJCyDUZQ5UTzAtF4/nkyUF8+bEQ04i8vWlZJckwT4FI7XG+VCS3JcZNn3Ys4UIGsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732650969; c=relaxed/simple;
	bh=ct/MoMKDqZyXPcNUyJqJ5LZFFD+J205JDk8TDLZvaJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozu1d0kAdGYbgIDyovq+2OP+KEYbag9on9EjUSVOtKEP8VscFRyQc+nw5sLJkzlTTnyBxL8i5rv644GSXGTf3graGZvDC8ERXBEHaypClGViGdLTVNNB46/SRg0lTIvh2Z3AkyJVTzHgADWU3G1AbSEZlk7YhJyUiMIg9fAioLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHBdLrWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55740C4CECF;
	Tue, 26 Nov 2024 19:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732650968;
	bh=ct/MoMKDqZyXPcNUyJqJ5LZFFD+J205JDk8TDLZvaJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHBdLrWVPHqXYLckf68EwF+6Oc/6+/uQyWZax1YElo05XYjc12XpokwUt8Qm/43EI
	 VXy0uQte3MYDfjSil1oHEiF8ZQP6taYL0Y75HHzZVml8SbUje1zvnBG33//vMpsfst
	 7dj4UYBvZ4fMRVjEqb1Diy0olGaGariUTY5Jqe4v3faxktywp8rzCVXrcK3y6PKmVY
	 gRzw83wa9UwrH8UxVSh1GZ6cct5zI9sf+D7ntGnz2zlLGiLFIawF2Pt4ZP4fWGgl94
	 AqKKE4pzwO/u07gn0XtQVEU+PfuWP59+h3PmMXLatSIwn2gLLKm0NZZ0TQtYZEeVng
	 pHT/zc7KBz5aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ziwei Xiao <ziweixiao@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] gve: Fixes for napi_poll when budget is 0
Date: Tue, 26 Nov 2024 14:56:06 -0500
Message-ID: <20241126145358-e8b00148423a2333@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241126191922.2504882-1-ziweixiao@google.com>
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
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-26 14:50:20.798246719 -0500
+++ /tmp/tmp.FS9IuZXyCo	2024-11-26 14:50:20.790552177 -0500
@@ -1,40 +1,33 @@
-Netpoll will explicilty pass the polling call with a budget of 0 to
-indicate it's clearing the Tx path only. For the gve_rx_poll and
-gve_xdp_poll, they were mistakenly taking the 0 budget as the indication
-to do all the work. Add check to avoid the rx path and xdp path being
-called when budget is 0. And also avoid napi_complete_done being called
-when budget is 0 for netpoll.
+The original fix was merged here:
+https://lore.kernel.org/r/20231114004144.2022268-1-ziweixiao@google.com
+Resend it since the original one was not cleanly applied to 5.15 kernel.
 
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
+index bf8a4a7c43f7..c3f1959533a8 100644
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
+@@ -198,6 +198,10 @@ static int gve_napi_poll(struct napi_struct *napi, int budget)
  
+ 	if (block->tx)
+ 		reschedule |= gve_tx_poll(block, budget);
++
 +	if (!budget)
 +		return 0;
 +
- 	if (block->rx) {
- 		work_done = gve_rx_poll(block, budget);
- 		reschedule |= work_done == budget;
-@@ -298,6 +301,9 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
+ 	if (block->rx)
+ 		reschedule |= gve_rx_poll(block, budget);
+ 
+@@ -246,6 +250,9 @@ static int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
  	if (block->tx)
  		reschedule |= gve_tx_poll_dqo(block, /*do_clean=*/true);
  
@@ -45,10 +38,10 @@
  		work_done = gve_rx_poll_dqo(block, budget);
  		reschedule |= work_done == budget;
 diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
-index e84a066aa1a40..73655347902d2 100644
+index 94941d4e4744..368e0e770178 100644
 --- a/drivers/net/ethernet/google/gve/gve_rx.c
 +++ b/drivers/net/ethernet/google/gve/gve_rx.c
-@@ -1007,10 +1007,6 @@ int gve_rx_poll(struct gve_notify_block *block, int budget)
+@@ -599,10 +599,6 @@ bool gve_rx_poll(struct gve_notify_block *block, int budget)
  
  	feat = block->napi.dev->features;
  
@@ -57,14 +50,14 @@
 -		budget = INT_MAX;
 -
  	if (budget > 0)
- 		work_done = gve_clean_rx_done(rx, budget, feat);
- 
+ 		repoll |= gve_clean_rx_done(rx, budget, feat);
+ 	else
 diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
-index 6957a865cff37..9f6ffc4a54f0b 100644
+index 665ac795a1ad..d56b8356f1f3 100644
 --- a/drivers/net/ethernet/google/gve/gve_tx.c
 +++ b/drivers/net/ethernet/google/gve/gve_tx.c
-@@ -925,10 +925,6 @@ bool gve_xdp_poll(struct gve_notify_block *block, int budget)
- 	bool repoll;
+@@ -691,10 +691,6 @@ bool gve_tx_poll(struct gve_notify_block *block, int budget)
+ 	u32 nic_done;
  	u32 to_do;
  
 -	/* If budget is 0, do all the work */
@@ -72,5 +65,8 @@
 -		budget = INT_MAX;
 -
  	/* Find out how much work there is to be done */
- 	nic_done = gve_tx_load_event_counter(priv, tx);
- 	to_do = min_t(u32, (nic_done - tx->done), budget);
+ 	tx->last_nic_done = gve_tx_load_event_counter(priv, tx);
+ 	nic_done = be32_to_cpu(tx->last_nic_done);
+-- 
+2.47.0.338.g60cca15819-goog
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

