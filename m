Return-Path: <stable+bounces-72888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989D996A8F9
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443371F24B68
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B81E1A36;
	Tue,  3 Sep 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAeIbSDj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F71E1A2D;
	Tue,  3 Sep 2024 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396253; cv=none; b=IYpW3FV9AuGw5zs8YXRQNgZd5xHFrMjIXlYriczZZgUirpAVVmtqqi49kaQkbiTObolKQo4+impjH/BY9Ux9bBQ7WTGR4OooLiRGIZ5dBMk6Vt4XMaj3xROQdYKn5Km+L7KImf+krnWgZWKaNTzlydbXUAZRPNqIgxBETd62rRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396253; c=relaxed/simple;
	bh=F+4OrwZxjWWjq1MSc2g4l0z4qr4wyms+G514YBypbQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUgkkwV6JPz4mf1uSZIuwMM55cDWfWiFgGBQX5kdPVAVG1GFlL+8Glm15/51hFDn0E02QDmykoYbA4HZWF4k4OSLcBNEq4KBtVng8OVImz7EUwQ9nM4bTOlHaI6Nf7wDAEL3v7zjsP/eWa90W6BXZjQE2YuDzCTIZ6mVRlW+7oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAeIbSDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD68C4CEC5;
	Tue,  3 Sep 2024 20:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396253;
	bh=F+4OrwZxjWWjq1MSc2g4l0z4qr4wyms+G514YBypbQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rAeIbSDjo2ninNrIZb4rcZ4DaUjfoSXx50z8nKfMi4xcSx3dukYzdWQGGCb9AYHqo
	 nxqFJ7mYDvLldzo/BKBn3ceD+68xCH9TCsGKVA8njlQC0m7E56iaYvsP1tYHryp7f3
	 ZUM8hfeu2FJgfDDmiNVX3EbJCFDCF7M7SX6foS3oRooVB75lefju+FMllO0Aui1rJr
	 JXggp+ckl0s9DOUgzWxZXZHmegBkASEkZvFv94lPxKF+GFlhIMd/Xke95hAwv5McSn
	 Qed5SoO5KVYhsGwVWYrMQSbqpk3rVO87SscaOwLaXQYdBe9+rf9nRhDs6FbA3e5A5H
	 WjKu9tLzjpz+A==
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
Subject: [PATCH AUTOSEL 6.6 12/20] net: ftgmac100: Ensure tx descriptor updates are visible
Date: Tue,  3 Sep 2024 15:23:44 -0400
Message-ID: <20240903192425.1107562-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
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
index 9135b918dd490..848e41a4b1dbb 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -572,7 +572,7 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 	(*processed)++;
 	return true;
 
- drop:
+drop:
 	/* Clean rxdes0 (which resets own bit) */
 	rxdes->rxdes0 = cpu_to_le32(status & priv->rxdes0_edorr_mask);
 	priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
@@ -656,6 +656,11 @@ static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
 	ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
 	txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
 
 	return true;
@@ -809,6 +814,11 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 	first->txdes0 = cpu_to_le32(f_ctl_stat);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	/* Update next TX pointer */
 	priv->tx_pointer = pointer;
 
@@ -829,7 +839,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- dma_err:
+dma_err:
 	if (net_ratelimit())
 		netdev_err(netdev, "map tx fragment failed\n");
 
@@ -851,7 +861,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	 * last fragment, so we know ftgmac100_free_tx_packet()
 	 * hasn't freed the skb yet.
 	 */
- drop:
+drop:
 	/* Drop the packet */
 	dev_kfree_skb_any(skb);
 	netdev->stats.tx_dropped++;
@@ -1344,7 +1354,7 @@ static void ftgmac100_reset(struct ftgmac100 *priv)
 	ftgmac100_init_all(priv, true);
 
 	netdev_dbg(netdev, "Reset done !\n");
- bail:
+bail:
 	if (priv->mii_bus)
 		mutex_unlock(&priv->mii_bus->mdio_lock);
 	if (netdev->phydev)
@@ -1543,15 +1553,15 @@ static int ftgmac100_open(struct net_device *netdev)
 
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


