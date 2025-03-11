Return-Path: <stable+bounces-123485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A75A5C570
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6689F7A1CBC
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027025DD06;
	Tue, 11 Mar 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0JJES1t4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA32405F9;
	Tue, 11 Mar 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706093; cv=none; b=MG7bgZB90LP6De6uZe0smYHhilUeHla4NTgTEGrZg2tNADpN4T+vouJ4gvltO/OQU2P612Ifk0pCEtKpJIveXVMFXZFI2Ch+NETsRkR/H5RCDFit48vLnmiQ5nNK2zPgRLldICYfc81FktDhoEY8n4em5mB6Ll+/YMA358RT6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706093; c=relaxed/simple;
	bh=V5AMt6MUNNeeQujYqtVWUObYTuItePT0+Ko6wiya7Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpD1fbXym/qHXO/UfK4TKj1nLCgPa8lbNMCEOIExUJVg9HLpB7s5BydQNoID0G6rzhwnDCW3hCvjTHG9OQ2e/+fVYEcJz5rq9QbSxoF1Yt3T9hsPjifykDW/aaY6pJS1XFBouaRI239Z7yjeq7RireFlbmuoyWluRHjSFg11PvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0JJES1t4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D15C4CEE9;
	Tue, 11 Mar 2025 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741706093;
	bh=V5AMt6MUNNeeQujYqtVWUObYTuItePT0+Ko6wiya7Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0JJES1t4YRzzLS7yAZz7CI5/60zILBvvythnKGw5IInm460gMOrzI+QTF6D2A64L0
	 hee3NPga/ZaA5P8X7yChjJAWz4/EwQwt9LNT3EAvNouAhbBP+/zbkmfYrSY7AKVepF
	 YEjwobIEJud92XCnq8NvutARs32MP37ZdneOe1xI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sean Anderson <sean.anderson@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 260/328] net: cadence: macb: Synchronize stats calculations
Date: Tue, 11 Mar 2025 16:00:30 +0100
Message-ID: <20250311145725.240781525@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Anderson <sean.anderson@linux.dev>

[ Upstream commit fa52f15c745ce55261b92873676f64f7348cfe82 ]

Stats calculations involve a RMW to add the stat update to the existing
value. This is currently not protected by any synchronization mechanism,
so data races are possible. Add a spinlock to protect the update. The
reader side could be protected using u64_stats, but we would still need
a spinlock for the update side anyway. And we always do an update
immediately before reading the stats anyway.

Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Link: https://patch.msgid.link/20250220162950.95941-1-sean.anderson@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb.h      |  2 ++
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 03983bd46eef4..bf864b2d0cac4 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1177,6 +1177,8 @@ struct macb {
 	struct clk		*rx_clk;
 	struct clk		*tsu_clk;
 	struct net_device	*dev;
+	/* Protects hw_stats and ethtool_stats */
+	spinlock_t		stats_lock;
 	union {
 		struct macb_stats	macb;
 		struct gem_stats	gem;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 12dd18cbdba34..a750c752846cf 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1483,10 +1483,12 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 		if (status & MACB_BIT(ISR_ROVR)) {
 			/* We missed at least one packet */
+			spin_lock(&bp->stats_lock);
 			if (macb_is_gem(bp))
 				bp->hw_stats.gem.rx_overruns++;
 			else
 				bp->hw_stats.macb.rx_overruns++;
+			spin_unlock(&bp->stats_lock);
 
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, MACB_BIT(ISR_ROVR));
@@ -2567,6 +2569,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	if (!netif_running(bp->dev))
 		return nstat;
 
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 
 	nstat->rx_errors = (hwstat->rx_frame_check_sequence_errors +
@@ -2596,6 +2599,7 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 	nstat->tx_aborted_errors = hwstat->tx_excessive_collisions;
 	nstat->tx_carrier_errors = hwstat->tx_carrier_sense_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underrun;
+	spin_unlock_irq(&bp->stats_lock);
 
 	return nstat;
 }
@@ -2603,12 +2607,13 @@ static struct net_device_stats *gem_get_stats(struct macb *bp)
 static void gem_get_ethtool_stats(struct net_device *dev,
 				  struct ethtool_stats *stats, u64 *data)
 {
-	struct macb *bp;
+	struct macb *bp = netdev_priv(dev);
 
-	bp = netdev_priv(dev);
+	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
 			* (GEM_STATS_LEN + QUEUE_STATS_LEN * MACB_MAX_QUEUES));
+	spin_unlock_irq(&bp->stats_lock);
 }
 
 static int gem_get_sset_count(struct net_device *dev, int sset)
@@ -2658,6 +2663,7 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 		return gem_get_stats(bp);
 
 	/* read stats from hardware */
+	spin_lock_irq(&bp->stats_lock);
 	macb_update_stats(bp);
 
 	/* Convert HW stats into netdevice stats */
@@ -2691,6 +2697,7 @@ static struct net_device_stats *macb_get_stats(struct net_device *dev)
 	nstat->tx_carrier_errors = hwstat->tx_carrier_errors;
 	nstat->tx_fifo_errors = hwstat->tx_underruns;
 	/* Don't know about heartbeat or window errors... */
+	spin_unlock_irq(&bp->stats_lock);
 
 	return nstat;
 }
@@ -4306,6 +4313,7 @@ static int macb_probe(struct platform_device *pdev)
 	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
 
 	spin_lock_init(&bp->lock);
+	spin_lock_init(&bp->stats_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
-- 
2.39.5




