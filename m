Return-Path: <stable+bounces-110665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6A0A1CB4E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9086C3A8DCB
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F954216E3C;
	Sun, 26 Jan 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3wqYE2Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EC1A7045;
	Sun, 26 Jan 2025 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903796; cv=none; b=RYFfu5mmI331spIabogj1WYXYudaYtP1lAypTgfH1GsFwk5m+sinrL2hw8tWYfASj730x948jfZWxWm39gdY6Dbc/wkaX3aSp/J0YALocdA66BOAmlPi3IXhRned3z0wydoMv0iqbmBK6BhwdkAX6fd2eg1rlQKSJcRMmy+r4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903796; c=relaxed/simple;
	bh=uyxT+VoWCeA4GL+/rNNYRKLDgLBkqYsky9vy37G7j08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=chW2dl7eRghH3OHrvnaRDGMIr9JnyMwCl6Vk3U+SDiOMcXY2avLXmJiyi3pcYBf4hPbUc2is5KX2kgLWelPIZ8KE8y+Vxoywn7RRiO99k97HW3kALxfTZuN0Nvpb1LCMlOAIDBgz2pU64Qo18NA2CfMfx0ibU+NA85giqUQcCMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3wqYE2Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A459BC4CEE2;
	Sun, 26 Jan 2025 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903794;
	bh=uyxT+VoWCeA4GL+/rNNYRKLDgLBkqYsky9vy37G7j08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3wqYE2Y5ShJm0u66cPq6b5gMmQ1MAmBfb0cTLtRO/bGEf7ss/6PZNDpgWftD2oOo
	 l2jexhYpG2abQf/OB6porpG3RxBsZ1TTfcOFtr2TCUpAKKMNK9quR3DlzR5bRZaqIx
	 LxpgS1B7XdGqHDMJf2IIZ7dNm4ViMsxOi92rZSSyWzLMF9+TlzgarkyZwo95HoUALr
	 cGO1qJD6LDdhoYjMbD7XsmBA+LLFunVmcDexXfchokrt33NmtS3u43cSuXmyhJmr95
	 CFKPLOwzC57TMWKFDAHVl63/jVu+DBEq1vsx2qpUFY8e37vmpKnpwbiq4xcYrbSyRv
	 U68kfhSl8oyag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roger Quadros <rogerq@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	alexander.sverdlin@siemens.com,
	dan.carpenter@linaro.org,
	jpanis@baylibre.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 29/29] net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path
Date: Sun, 26 Jan 2025 10:02:10 -0500
Message-Id: <20250126150210.955385-29-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150210.955385-1-sashal@kernel.org>
References: <20250126150210.955385-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Roger Quadros <rogerq@kernel.org>

[ Upstream commit 681eb2beb3efe21e630bcc4881595e3b42dd7948 ]

We are missing netif_napi_del() and am65_cpsw_nuss_free_tx/rx_chns()
in error path when am65_cpsw_nuss_init_tx/rx_chns() is used anywhere
other than at probe(). i.e. am65_cpsw_nuss_update_tx_rx_chns and
am65_cpsw_nuss_resume()

As reported, in am65_cpsw_nuss_update_tx_rx_chns(),
if am65_cpsw_nuss_init_tx_chns() partially fails then
devm_add_action(dev, am65_cpsw_nuss_free_tx_chns,..) is added
but the cleanup via am65_cpsw_nuss_free_tx_chns() will not run.

Same issue exists for am65_cpsw_nuss_init_tx/rx_chns() failures
in am65_cpsw_nuss_resume() as well.

This would otherwise require more instances of devm_add/remove_action
and is clearly more of a distraction than any benefit.

So, drop devm_add/remove_action for am65_cpsw_nuss_free_tx/rx_chns()
and call am65_cpsw_nuss_free_tx/rx_chns() and netif_napi_del()
where required.

Reported-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Closes: https://lore.kernel.org/all/m4rhkzcr7dlylxr54udyt6lal5s2q4krrvmyay6gzgzhcu4q2c@r34snfumzqxy/
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Link: https://patch.msgid.link/20250117-am65-cpsw-streamline-v2-1-91a29c97e569@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 67 ++++++++++++++++--------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index dfca13b82bdce..4e9385564917a 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2201,8 +2201,6 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 	struct device *dev = common->dev;
 	int i;
 
-	devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
-
 	common->tx_ch_rate_msk = 0;
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
@@ -2224,8 +2222,6 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
-				  am65_cpsw_nuss_tx_poll);
 		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
 
@@ -2238,9 +2234,21 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 				tx_chn->id, tx_chn->irq, ret);
 			goto err;
 		}
+
+		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
+				  am65_cpsw_nuss_tx_poll);
 	}
 
+	return 0;
+
 err:
+	for (--i ; i >= 0 ; i--) {
+		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
+
+		netif_napi_del(&tx_chn->napi_tx);
+		devm_free_irq(dev, tx_chn->irq, tx_chn);
+	}
+
 	return ret;
 }
 
@@ -2321,12 +2329,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		goto err;
 	}
 
+	return 0;
+
 err:
-	i = devm_add_action(dev, am65_cpsw_nuss_free_tx_chns, common);
-	if (i) {
-		dev_err(dev, "Failed to add free_tx_chns action %d\n", i);
-		return i;
-	}
+	am65_cpsw_nuss_free_tx_chns(common);
 
 	return ret;
 }
@@ -2354,7 +2360,6 @@ static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
 
 	rx_chn = &common->rx_chns;
 	flows = rx_chn->flows;
-	devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
 
 	for (i = 0; i < common->rx_ch_num_flows; i++) {
 		if (!(flows[i].irq < 0))
@@ -2453,7 +2458,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 						i, &rx_flow_cfg);
 		if (ret) {
 			dev_err(dev, "Failed to init rx flow%d %d\n", i, ret);
-			goto err;
+			goto err_flow;
 		}
 		if (!i)
 			fdqring_id =
@@ -2465,14 +2470,12 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			dev_err(dev, "Failed to get rx dma irq %d\n",
 				flow->irq);
 			ret = flow->irq;
-			goto err;
+			goto err_flow;
 		}
 
 		snprintf(flow->name,
 			 sizeof(flow->name), "%s-rx%d",
 			 dev_name(dev), i);
-		netif_napi_add(common->dma_ndev, &flow->napi_rx,
-			       am65_cpsw_nuss_rx_poll);
 		hrtimer_init(&flow->rx_hrtimer, CLOCK_MONOTONIC,
 			     HRTIMER_MODE_REL_PINNED);
 		flow->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
@@ -2485,20 +2488,28 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			dev_err(dev, "failure requesting rx %d irq %u, %d\n",
 				i, flow->irq, ret);
 			flow->irq = -EINVAL;
-			goto err;
+			goto err_flow;
 		}
+
+		netif_napi_add(common->dma_ndev, &flow->napi_rx,
+			       am65_cpsw_nuss_rx_poll);
 	}
 
 	/* setup classifier to route priorities to flows */
 	cpsw_ale_classifier_setup_default(common->ale, common->rx_ch_num_flows);
 
-err:
-	i = devm_add_action(dev, am65_cpsw_nuss_free_rx_chns, common);
-	if (i) {
-		dev_err(dev, "Failed to add free_rx_chns action %d\n", i);
-		return i;
+	return 0;
+
+err_flow:
+	for (--i; i >= 0 ; i--) {
+		flow = &rx_chn->flows[i];
+		netif_napi_del(&flow->napi_rx);
+		devm_free_irq(dev, flow->irq, flow);
 	}
 
+err:
+	am65_cpsw_nuss_free_rx_chns(common);
+
 	return ret;
 }
 
@@ -3324,7 +3335,7 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 		return ret;
 	ret = am65_cpsw_nuss_init_rx_chns(common);
 	if (ret)
-		return ret;
+		goto err_remove_tx;
 
 	/* The DMA Channels are not guaranteed to be in a clean state.
 	 * Reset and disable them to ensure that they are back to the
@@ -3345,7 +3356,7 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 
 	ret = am65_cpsw_nuss_register_devlink(common);
 	if (ret)
-		return ret;
+		goto err_remove_rx;
 
 	for (i = 0; i < common->port_num; i++) {
 		port = &common->ports[i];
@@ -3376,6 +3387,10 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 err_cleanup_ndev:
 	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpsw_unregister_devlink(common);
+err_remove_rx:
+	am65_cpsw_nuss_remove_rx_chns(common);
+err_remove_tx:
+	am65_cpsw_nuss_remove_tx_chns(common);
 
 	return ret;
 }
@@ -3395,6 +3410,8 @@ int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
 		return ret;
 
 	ret = am65_cpsw_nuss_init_rx_chns(common);
+	if (ret)
+		am65_cpsw_nuss_remove_tx_chns(common);
 
 	return ret;
 }
@@ -3652,6 +3669,8 @@ static void am65_cpsw_nuss_remove(struct platform_device *pdev)
 	 */
 	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpsw_unregister_devlink(common);
+	am65_cpsw_nuss_remove_rx_chns(common);
+	am65_cpsw_nuss_remove_tx_chns(common);
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
 	am65_cpsw_disable_serdes_phy(common);
@@ -3713,8 +3732,10 @@ static int am65_cpsw_nuss_resume(struct device *dev)
 	if (ret)
 		return ret;
 	ret = am65_cpsw_nuss_init_rx_chns(common);
-	if (ret)
+	if (ret) {
+		am65_cpsw_nuss_remove_tx_chns(common);
 		return ret;
+	}
 
 	/* If RX IRQ was disabled before suspend, keep it disabled */
 	for (i = 0; i < common->rx_ch_num_flows; i++) {
-- 
2.39.5


