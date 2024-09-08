Return-Path: <stable+bounces-73882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A03C97074E
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8867B21475
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F8C1531F3;
	Sun,  8 Sep 2024 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vrti2kFj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966D52F6F
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797733; cv=none; b=Zny+HsZEavGqhIaLLT4TNz8WPKT62utyKUYQIo+Qd5qHU8nFnEIOG/L3pxzkR4ojgkn6i4uNI/PysraKkR1ajOQy7IdrnMPuBuxbNG0fQvsL7tTRc4N8CX+CBZfNpa8QNykWSQUJOg8HOaPD9p8w8UY7+rLe83elRIpHLeFSMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797733; c=relaxed/simple;
	bh=xvBf+/Tjx3p/jbbv/6+YwFJh+3K2D8zCVvBH36u3bFE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q5zhN9I8EQWgmzm0sOKa/gcgeW7Idun2dLVROdnB/DpMAHSEkYA8DOuQ63pkfNNlt4BXiQ95AUzTgdEjO8VyIbfN29a8ibhjzFsi5mvTXEANe2luvLZ7UhlvFy/bYnV56f/r3g90R9ak/2WHq4V9rTQuolTZUoZWQ+g6TRZHeF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vrti2kFj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFE8C4CEC3;
	Sun,  8 Sep 2024 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725797733;
	bh=xvBf+/Tjx3p/jbbv/6+YwFJh+3K2D8zCVvBH36u3bFE=;
	h=Subject:To:Cc:From:Date:From;
	b=vrti2kFjDTyF3nHukmDlzUPbkGdnyayUvuO4hP9hZNx9UDWIGsHzvq177MoGuDDQ+
	 NhQFOvF5uRctsCYBkrvEApSzlJM0stHtW0Ai6Dkc8+SVrXTZK4ZhHQkKrnVPhoN3an
	 uB+WAgxpDa95kXvRL1Mtp/uNEbXTsiax2JHOsLCc=
Subject: FAILED: patch "[PATCH] net: mana: Fix error handling in mana_create_txq/rxq's NAPI" failed to apply to 5.15-stable tree
To: schakrabarti@linux.microsoft.com,davem@davemloft.net,haiyangz@microsoft.com,shradhagupta@linux.microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:15:22 +0200
Message-ID: <2024090822-freeload-remission-9952@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b6ecc662037694488bfff7c9fd21c405df8411f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090822-freeload-remission-9952@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b6ecc6620376 ("net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup")
f90f84201edd ("net: mana: Add counter for packet dropped by XDP")
ed5356b53f07 ("net: mana: Add XDP support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b6ecc662037694488bfff7c9fd21c405df8411f2 Mon Sep 17 00:00:00 2001
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Date: Mon, 2 Sep 2024 05:43:47 -0700
Subject: [PATCH] net: mana: Fix error handling in mana_create_txq/rxq's NAPI
 cleanup

Currently napi_disable() gets called during rxq and txq cleanup,
even before napi is enabled and hrtimer is initialized. It causes
kernel panic.

? page_fault_oops+0x136/0x2b0
  ? page_counter_cancel+0x2e/0x80
  ? do_user_addr_fault+0x2f2/0x640
  ? refill_obj_stock+0xc4/0x110
  ? exc_page_fault+0x71/0x160
  ? asm_exc_page_fault+0x27/0x30
  ? __mmdrop+0x10/0x180
  ? __mmdrop+0xec/0x180
  ? hrtimer_active+0xd/0x50
  hrtimer_try_to_cancel+0x2c/0xf0
  hrtimer_cancel+0x15/0x30
  napi_disable+0x65/0x90
  mana_destroy_rxq+0x4c/0x2f0
  mana_create_rxq.isra.0+0x56c/0x6d0
  ? mana_uncfg_vport+0x50/0x50
  mana_alloc_queues+0x21b/0x320
  ? skb_dequeue+0x5f/0x80

Cc: stable@vger.kernel.org
Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 39f56973746d..3d151700f658 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1872,10 +1872,12 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 
 	for (i = 0; i < apc->num_queues; i++) {
 		napi = &apc->tx_qp[i].tx_cq.napi;
-		napi_synchronize(napi);
-		napi_disable(napi);
-		netif_napi_del(napi);
-
+		if (apc->tx_qp[i].txq.napi_initialized) {
+			napi_synchronize(napi);
+			napi_disable(napi);
+			netif_napi_del(napi);
+			apc->tx_qp[i].txq.napi_initialized = false;
+		}
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
@@ -1931,6 +1933,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 		txq->ndev = net;
 		txq->net_txq = netdev_get_tx_queue(net, i);
 		txq->vp_offset = apc->tx_vp_offset;
+		txq->napi_initialized = false;
 		skb_queue_head_init(&txq->pending_skbs);
 
 		memset(&spec, 0, sizeof(spec));
@@ -1997,6 +2000,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 		netif_napi_add_tx(net, &cq->napi, mana_poll);
 		napi_enable(&cq->napi);
+		txq->napi_initialized = true;
 
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 	}
@@ -2008,7 +2012,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 }
 
 static void mana_destroy_rxq(struct mana_port_context *apc,
-			     struct mana_rxq *rxq, bool validate_state)
+			     struct mana_rxq *rxq, bool napi_initialized)
 
 {
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
@@ -2023,15 +2027,15 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 
 	napi = &rxq->rx_cq.napi;
 
-	if (validate_state)
+	if (napi_initialized) {
 		napi_synchronize(napi);
 
-	napi_disable(napi);
+		napi_disable(napi);
 
+		netif_napi_del(napi);
+	}
 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
-	netif_napi_del(napi);
-
 	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
 	mana_deinit_cq(apc, &rxq->rx_cq);
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 7caa334f4888..b8a6c7504ee1 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -98,6 +98,8 @@ struct mana_txq {
 
 	atomic_t pending_sends;
 
+	bool napi_initialized;
+
 	struct mana_stats_tx stats;
 };
 


