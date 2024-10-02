Return-Path: <stable+bounces-79801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD5798DA50
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED132818D0
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8601D0BA5;
	Wed,  2 Oct 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FT6uFa3S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BF1D27BD;
	Wed,  2 Oct 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878505; cv=none; b=Gsys7DWyRPvi8hhwVjYPbWnlTlZOaEkeGRQP4oy6FQ+LzLmpo5tYcFKrnaBsFKZSoCr+aasXiap2PBZ2Zk/BSwlywh4WY9dDDwTLy68tVnFliCndtuPhqNNwF/cGGo3e/Lw1gujobE4c06DPmFJ8ecRA1l2ecdvcMwlIejvcnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878505; c=relaxed/simple;
	bh=6207k04Jb8ZpJ35hEdGGiU4fPhWJ8MuCvselOKb3oKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thgVOslUzwJzInOIsZaHheC+5MUi8GNER9lNgmbL/J8eiKMvoWo9DFgCReeD2mKdr4dPrX5gNNSsGxlfkK3OKgTy52lKtM7prEhZZdLh7g2562mTLRfhThdLAgg4SMQSRCw3UMeyuHJ1s2sZm9wZ3pUKcFaqAUImfjzGsUg0hLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FT6uFa3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81BBC4CEC2;
	Wed,  2 Oct 2024 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878505;
	bh=6207k04Jb8ZpJ35hEdGGiU4fPhWJ8MuCvselOKb3oKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FT6uFa3SA8IUUWm2q6XbiL4Zjq2bbI7v2/T8OvMZJGvOWSak5bxHNSaKbVBFw66NB
	 sp7tJrmobHvhyc6mhlEiSA09anvuPKD2bHEiWQng8W0afsqILdMjVXdaY8QG2AVW7m
	 N08fVhRtFd2eJA8YkWzmerAuLW3tmibI4CtiP5Yw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Anderson <sean.anderson@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 435/634] net: xilinx: axienet: Fix packet counting
Date: Wed,  2 Oct 2024 14:58:55 +0200
Message-ID: <20241002125828.272337288@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit 5a6caa2cfabb559309b5ce29ee7c8e9ce1a9a9df ]

axienet_free_tx_chain returns the number of DMA descriptors it's
handled. However, axienet_tx_poll treats the return as the number of
packets. When scatter-gather SKBs are enabled, a single packet may use
multiple DMA descriptors, which causes incorrect packet counts. Fix this
by explicitly keepting track of the number of packets processed as
separate from the DMA descriptors.

Budget does not affect the number of Tx completions we can process for
NAPI, so we use the ring size as the limit instead of budget. As we no
longer return the number of descriptors processed to axienet_tx_poll, we
now update tx_bd_ci in axienet_free_tx_chain.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Link: https://patch.msgid.link/20240913145156.2283067-1-sean.anderson@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 00b1a4cf7c4be..f1d928644b824 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -674,15 +674,15 @@ static int axienet_device_reset(struct net_device *ndev)
  *
  * Would either be called after a successful transmit operation, or after
  * there was an error when setting up the chain.
- * Returns the number of descriptors handled.
+ * Returns the number of packets handled.
  */
 static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 int nr_bds, bool force, u32 *sizep, int budget)
 {
 	struct axidma_bd *cur_p;
 	unsigned int status;
+	int i, packets = 0;
 	dma_addr_t phys;
-	int i;
 
 	for (i = 0; i < nr_bds; i++) {
 		cur_p = &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
@@ -701,8 +701,10 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 				 (cur_p->cntrl & XAXIDMA_BD_CTRL_LENGTH_MASK),
 				 DMA_TO_DEVICE);
 
-		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK))
+		if (cur_p->skb && (status & XAXIDMA_BD_STS_COMPLETE_MASK)) {
 			napi_consume_skb(cur_p->skb, budget);
+			packets++;
+		}
 
 		cur_p->app0 = 0;
 		cur_p->app1 = 0;
@@ -718,7 +720,13 @@ static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
 			*sizep += status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
 	}
 
-	return i;
+	if (!force) {
+		lp->tx_bd_ci += i;
+		if (lp->tx_bd_ci >= lp->tx_bd_num)
+			lp->tx_bd_ci %= lp->tx_bd_num;
+	}
+
+	return packets;
 }
 
 /**
@@ -891,13 +899,10 @@ static int axienet_tx_poll(struct napi_struct *napi, int budget)
 	u32 size = 0;
 	int packets;
 
-	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, budget, false, &size, budget);
+	packets = axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num, false,
+					&size, budget);
 
 	if (packets) {
-		lp->tx_bd_ci += packets;
-		if (lp->tx_bd_ci >= lp->tx_bd_num)
-			lp->tx_bd_ci %= lp->tx_bd_num;
-
 		u64_stats_update_begin(&lp->tx_stat_sync);
 		u64_stats_add(&lp->tx_packets, packets);
 		u64_stats_add(&lp->tx_bytes, size);
-- 
2.43.0




