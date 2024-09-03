Return-Path: <stable+bounces-72945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9337A96A993
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 23:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257E728A363
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A7C1EB947;
	Tue,  3 Sep 2024 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkSxFZDM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3509D1EB92D;
	Tue,  3 Sep 2024 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396540; cv=none; b=RjuUxUWnJzTUY2HXutpm4xnQV4Rt/706sfvyH2tIb6eExnzhaxHSGY64WP2fGrNmhBdIBfbyNxwWDnT2kE15CAEukqCwS+p2pyTlLqNsRG02G5Tx448Ro23sj4r3NzkvC3z4INtW5v6cmybE6d3uiiAeMp6rwmTRhfIaClsgz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396540; c=relaxed/simple;
	bh=5dGQXYgwaL/nIaqNLzT7zvFRYHO6hfBf1vx3MMVjnZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cL2bMA0VJqEc4uULDoLxUyECy0dvXIU8XULtXyG1fOZHVH7QYAMbzyTAk7GDCVKRXzbq9+DFFWBOX1f2TNP0L9qRxvqGt4zs8gaPSdE0ijxX6ADldAFjnIxjImBWi0IWzRvmOxHpoux8WROLjexUqtunwJIkvCoRwIprKWRGOi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkSxFZDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84722C4CEC4;
	Tue,  3 Sep 2024 20:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396539;
	bh=5dGQXYgwaL/nIaqNLzT7zvFRYHO6hfBf1vx3MMVjnZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkSxFZDMJkZkpSJy6P1HCd9izqj1Kq5qRQuSbbY4CMpW+5YnL5RmrV2ws6Qan4hnD
	 r/fW5ET0w8yHQuYvEVSt3K0i4R+nb6FeDNAeHD0vGJkD95SklXf20kYe4lJEbs8nsS
	 I7IIxRD6rRK/unjPonwReekmofzkfpdzP4bxcQ7W+RQXMXc+78K+GM8mDsHQ0/X7WO
	 n9jCNuRMu/PeePcoQ5Zhq/dOwU7r62p9ixBodI+mqNs0ObpiP5P/AUTN+dFZdgwgwC
	 vaAwjOJYwZxXhzZz283JlqizR7vPGMjpioCcPdMWDOH7hSbEksmy1K948l5gqa0o7V
	 VsdnF4Qi2xYWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	u.kleine-koenig@pengutronix.de,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 4/6] net: ftgmac100: Ensure tx descriptor updates are visible
Date: Tue,  3 Sep 2024 15:29:24 -0400
Message-ID: <20240903192937.1109185-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192937.1109185-1-sashal@kernel.org>
References: <20240903192937.1109185-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.320
Content-Transfer-Encoding: 8bit

From: Jacky Chou <jacky_chou@aspeedtech.com>

[ Upstream commit 4186c8d9e6af57bab0687b299df10ebd47534a0a ]

The driver must ensure TX descriptor updates are visible
before updating TX pointer and TX clear pointer.

This resolves TX hangs observed on AST2600 when running
iperf3.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 26 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 23c019d1278cd..f6ed8d167d53c 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -579,7 +579,7 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 	(*processed)++;
 	return true;
 
- drop:
+drop:
 	/* Clean rxdes0 (which resets own bit) */
 	rxdes->rxdes0 = cpu_to_le32(status & priv->rxdes0_edorr_mask);
 	priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
@@ -663,6 +663,11 @@ static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
 	ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
 	txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
 
 	return true;
@@ -816,6 +821,11 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 	first->txdes0 = cpu_to_le32(f_ctl_stat);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	/* Update next TX pointer */
 	priv->tx_pointer = pointer;
 
@@ -836,7 +846,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- dma_err:
+dma_err:
 	if (net_ratelimit())
 		netdev_err(netdev, "map tx fragment failed\n");
 
@@ -858,7 +868,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	 * last fragment, so we know ftgmac100_free_tx_packet()
 	 * hasn't freed the skb yet.
 	 */
- drop:
+drop:
 	/* Drop the packet */
 	dev_kfree_skb_any(skb);
 	netdev->stats.tx_dropped++;
@@ -1444,7 +1454,7 @@ static void ftgmac100_reset_task(struct work_struct *work)
 	ftgmac100_init_all(priv, true);
 
 	netdev_dbg(netdev, "Reset done !\n");
- bail:
+bail:
 	if (priv->mii_bus)
 		mutex_unlock(&priv->mii_bus->mdio_lock);
 	if (netdev->phydev)
@@ -1515,15 +1525,15 @@ static int ftgmac100_open(struct net_device *netdev)
 
 	return 0;
 
- err_ncsi:
+err_ncsi:
 	napi_disable(&priv->napi);
 	netif_stop_queue(netdev);
- err_alloc:
+err_alloc:
 	ftgmac100_free_buffers(priv);
 	free_irq(netdev->irq, netdev);
- err_irq:
+err_irq:
 	netif_napi_del(&priv->napi);
- err_hw:
+err_hw:
 	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
 	ftgmac100_free_rings(priv);
 	return err;
-- 
2.43.0


