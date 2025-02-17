Return-Path: <stable+bounces-115663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31027A3455B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380313AD59F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350B8145A11;
	Thu, 13 Feb 2025 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Py6W8T34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43C426B0BA;
	Thu, 13 Feb 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458821; cv=none; b=g6wBcTWEPdD6R2m4pkaLejLeA0oXdkoYIeeTokcS5TxzhKMIgj3br/IQESVthG1iLA1XXJCo2cpb4f3LfiDmJV1eY0ihz9oyNSlcMp4cpPTOwqs54T8TiBCrZ1Gf9fWiYbTL+F8JUzF8p1s4tywyORyPMoI6UQS6CZjJCmO8tJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458821; c=relaxed/simple;
	bh=3+MZylOLHsDkvEuCmkITB7mrOF27HWlfKJFi0ueYiDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIF6Qv6gTuULQgbgzss6Nsd9T+KsciCGl+/RWRmXFR94qcvat1+X+t9Bly32gpIT67z78xm2hIFlbjxLtRyKKhyMy/SLxjIFcjtlQaSsJKYFBWureNt06jvTWMB+4AJBpZb1tzQ+OcdJujplmh41PzpZXphFMdnE4V3U/7Jw0pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Py6W8T34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36FCC4CED1;
	Thu, 13 Feb 2025 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458820;
	bh=3+MZylOLHsDkvEuCmkITB7mrOF27HWlfKJFi0ueYiDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Py6W8T34g7Rxr/owX9zA61OFEZZmXYsozFWyeR26UC6rIRnoo8NRGpyzmXoeIB609
	 O3c6yUxmyjT6+b24Jqm4ly5Gs/EIxvbnFf2l0y/13G9Uu+7k3U476b+1ZuTFEJ0n0M
	 f2BrRCw7wiGAwWaqcnwsgHhh74nsIkP9qYj3oBwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 086/443] net: ethernet: ti: am65-cpsw: ensure proper channel cleanup in error path
Date: Thu, 13 Feb 2025 15:24:11 +0100
Message-ID: <20250213142443.929677689@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index e1de45fb18aee..2be2889d0646b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2242,8 +2242,6 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 	struct device *dev = common->dev;
 	int i;
 
-	devm_remove_action(dev, am65_cpsw_nuss_free_tx_chns, common);
-
 	common->tx_ch_rate_msk = 0;
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
@@ -2265,8 +2263,6 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
-				  am65_cpsw_nuss_tx_poll);
 		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
 
@@ -2279,9 +2275,21 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
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
 
@@ -2362,12 +2370,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
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
@@ -2395,7 +2401,6 @@ static void am65_cpsw_nuss_remove_rx_chns(struct am65_cpsw_common *common)
 
 	rx_chn = &common->rx_chns;
 	flows = rx_chn->flows;
-	devm_remove_action(dev, am65_cpsw_nuss_free_rx_chns, common);
 
 	for (i = 0; i < common->rx_ch_num_flows; i++) {
 		if (!(flows[i].irq < 0))
@@ -2494,7 +2499,7 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 						i, &rx_flow_cfg);
 		if (ret) {
 			dev_err(dev, "Failed to init rx flow%d %d\n", i, ret);
-			goto err;
+			goto err_flow;
 		}
 		if (!i)
 			fdqring_id =
@@ -2506,14 +2511,12 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
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
@@ -2526,20 +2529,28 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
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
 
@@ -3349,7 +3360,7 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 		return ret;
 	ret = am65_cpsw_nuss_init_rx_chns(common);
 	if (ret)
-		return ret;
+		goto err_remove_tx;
 
 	/* The DMA Channels are not guaranteed to be in a clean state.
 	 * Reset and disable them to ensure that they are back to the
@@ -3370,7 +3381,7 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 
 	ret = am65_cpsw_nuss_register_devlink(common);
 	if (ret)
-		return ret;
+		goto err_remove_rx;
 
 	for (i = 0; i < common->port_num; i++) {
 		port = &common->ports[i];
@@ -3401,6 +3412,10 @@ static int am65_cpsw_nuss_register_ndevs(struct am65_cpsw_common *common)
 err_cleanup_ndev:
 	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpsw_unregister_devlink(common);
+err_remove_rx:
+	am65_cpsw_nuss_remove_rx_chns(common);
+err_remove_tx:
+	am65_cpsw_nuss_remove_tx_chns(common);
 
 	return ret;
 }
@@ -3420,6 +3435,8 @@ int am65_cpsw_nuss_update_tx_rx_chns(struct am65_cpsw_common *common,
 		return ret;
 
 	ret = am65_cpsw_nuss_init_rx_chns(common);
+	if (ret)
+		am65_cpsw_nuss_remove_tx_chns(common);
 
 	return ret;
 }
@@ -3678,6 +3695,8 @@ static void am65_cpsw_nuss_remove(struct platform_device *pdev)
 	 */
 	am65_cpsw_nuss_cleanup_ndev(common);
 	am65_cpsw_unregister_devlink(common);
+	am65_cpsw_nuss_remove_rx_chns(common);
+	am65_cpsw_nuss_remove_tx_chns(common);
 	am65_cpsw_nuss_phylink_cleanup(common);
 	am65_cpts_release(common->cpts);
 	am65_cpsw_disable_serdes_phy(common);
@@ -3739,8 +3758,10 @@ static int am65_cpsw_nuss_resume(struct device *dev)
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




