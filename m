Return-Path: <stable+bounces-72906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F796A929
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18991F257FA
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBE1E492D;
	Tue,  3 Sep 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipIYGQWD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8B01E4916;
	Tue,  3 Sep 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396343; cv=none; b=joP88nFD4R31+tZ0opRSXIni1OcEwYmwGyTRSKOtXguw6cBxBC87ZN79HrfS7Q9xTobwj+qWJcO5Cu6kDsf3tOaWnX0LcwfH6M2qMWauGzwo7H1UkU6BxmIIdRC0ue0Q/M7aKHn/kXW8mARvXLr8qq34asvd6qXHcM117UL7j8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396343; c=relaxed/simple;
	bh=kpJplojsU6EmxCoH3la5iBDny/Ylbyp8MZ8UpSROfQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/62UzRugVrlTJPzi6gd30CLiK7DPy1bk8xPUq8kV7AEBvlo/DwPWjDCi60BPf5OmCKw8s/H4yQoTwNCebABpBagUBCkSY2NyZzzNmAtF4ZEdOhn/iOnKw/NYgdK0VSkux4eFEJqj1Jbk6HQqBk0aGegecUYUZFXrYG9h0y4q/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipIYGQWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B5EC4CEC4;
	Tue,  3 Sep 2024 20:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396342;
	bh=kpJplojsU6EmxCoH3la5iBDny/Ylbyp8MZ8UpSROfQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ipIYGQWDpmI6jNx/T/rF81kKNhulqpYY54MZN9uS+LVuQ9K0y+CBZxZVSLnSf72J7
	 uk2eo7qw9bY5k2H+NlRvc+q5PLfD4GUKOPCgMth7vlWN2PkBqMYC4lcGTN14xfMyXP
	 pliN/h6AMel6k6qHquw66dGSu2Mta5a34fWQNLjR7m91HkM0l37EW4hDx/b6H8BCFN
	 e/jipbzMmF3yLNMZi31YJgzX4fGUt2XdW9oazcBnrC4Vj5Wlz56mQ+NP1ORhOaZYPP
	 ylzu/p7FwWwF5Xqp3rTM8t0lgm8qazO0YVZsdoBIgaUIuG4tSD3sU1ln0z1GC2S/ff
	 uMKlaRrxrVTrQ==
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
Subject: [PATCH AUTOSEL 6.1 10/17] net: ftgmac100: Ensure tx descriptor updates are visible
Date: Tue,  3 Sep 2024 15:25:24 -0400
Message-ID: <20240903192600.1108046-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192600.1108046-1-sashal@kernel.org>
References: <20240903192600.1108046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.107
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
index a03879a27b041..7adc46aa75e66 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -566,7 +566,7 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 	(*processed)++;
 	return true;
 
- drop:
+drop:
 	/* Clean rxdes0 (which resets own bit) */
 	rxdes->rxdes0 = cpu_to_le32(status & priv->rxdes0_edorr_mask);
 	priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
@@ -650,6 +650,11 @@ static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
 	ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
 	txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
 
 	return true;
@@ -803,6 +808,11 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 	first->txdes0 = cpu_to_le32(f_ctl_stat);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	/* Update next TX pointer */
 	priv->tx_pointer = pointer;
 
@@ -823,7 +833,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- dma_err:
+dma_err:
 	if (net_ratelimit())
 		netdev_err(netdev, "map tx fragment failed\n");
 
@@ -845,7 +855,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	 * last fragment, so we know ftgmac100_free_tx_packet()
 	 * hasn't freed the skb yet.
 	 */
- drop:
+drop:
 	/* Drop the packet */
 	dev_kfree_skb_any(skb);
 	netdev->stats.tx_dropped++;
@@ -1338,7 +1348,7 @@ static void ftgmac100_reset(struct ftgmac100 *priv)
 	ftgmac100_init_all(priv, true);
 
 	netdev_dbg(netdev, "Reset done !\n");
- bail:
+bail:
 	if (priv->mii_bus)
 		mutex_unlock(&priv->mii_bus->mdio_lock);
 	if (netdev->phydev)
@@ -1537,15 +1547,15 @@ static int ftgmac100_open(struct net_device *netdev)
 
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


