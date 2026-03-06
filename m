Return-Path: <stable+bounces-223367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC0mIDYJq2k/ZgEAu9opvQ
	(envelope-from <stable+bounces-223367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:04:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D4225A2B
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 18:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 836553037188
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAF53EFD14;
	Fri,  6 Mar 2026 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/Ex87t0"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C453EDABE
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816691; cv=none; b=oIsx+hih+ycii8PqMO58huH0AfE2Iu5aCNcx4TqjWdqQHHCiSo1Te3xIAfW2YaCFmVU57+mTbzgQuNWS2ndKKdxy2r6PoP15xw91Pmfu2WtKdEg8GVmbt9HlsJS5Pivz+Pl6l9rEXEzDJdwoKdSGkbM50JEMQmq0LSK9L3FbjUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816691; c=relaxed/simple;
	bh=3i0lS/jOLHvh97zTu+WpGgYG0i1iba6kUtOX/wFfAgA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j4diS4zX1485yf7N0UrDYJqL4vcurCOJPHnTuHwaXeDVzRS1qTXijSnluVwtejwnBbmxSAH6lfKp2rbzGo6Em6qXlaPy4Co75h16EN1WAB0ktrYcVFrcMKHa7+Xvp7BM8buyAI5pDjaOgqahFlrTY5Yw0jNY0abRjhdkesF2Nrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/Ex87t0; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5673804da95so3885081e0c.0
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 09:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772816688; x=1773421488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BuxO1nSghzb98GxKgSltIqgao3JhVu7jRzBHBXc7f4Y=;
        b=e/Ex87t0CsX/rHY7FzS5dF2Fs9+JEX1saLx3Mv6bGr6ffpVrW4uc0luMt2uz/grdPc
         PgZcahKtMuzNYzxyzQVKw0ohGefRv9B9foUMu5gqMbt0spO0exs1MWo/rtsqXdIIjqhJ
         kBx9K4hjbjYhE4joZuVss3nVU06P+DW7uGAZWABxV+kjiuYOKhDwEovpb5UmNA0I8Dr9
         wBPRpAbmQoJvgjei2gE0usH86/9cn9efNWA7pYSfBGax/uS/X0TasNa00+KyE7mqmJ7L
         qXnxycP3RjaFCK4ovxmMU7IsGqFwy2Iipxnp8KDfLuzkpMgEa55ssgwyVqCJ0HYYlF+8
         HqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772816688; x=1773421488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuxO1nSghzb98GxKgSltIqgao3JhVu7jRzBHBXc7f4Y=;
        b=lS7EpC6L5n+dpoF3Smo+ipxcB4dCdoAY5VypE/gwcA0MrTKWCVXiMod24zxIhyTpUz
         lk3efOLTALxkPNN/N5yN9VLt66BvTc2lpazSyLObyveBiB6qOQid1ln2ekzJHosjcYj2
         l9e/nZNM1/1YljXW5jc5ho013PY2GH1dWwlFu5dGhzw1G/QJWRvEI0hpeMTrSa6l9vaC
         KhJ7fVUgyq8M6F1CHcYnnk0wRobLyu2YfZV9qV2WpJScXEEoOBJ2Sq9DD0MhnaSUeb6h
         kHNt05ZY48WWgEZMy2w0ShAUQ/MQw9PUH5dArI6AyQ90rTYKLRv8jkUS+3bvXBLkMw+t
         2ZHw==
X-Gm-Message-State: AOJu0YwvzTVzrSf9H84U0s0Kr9Q66P+RjksPICr/Eh9EWahpeOkLdjwu
	HuXMq2IzN4WXrsYAnwe8a+QvthuaVp0zF/OQYD8qPwxZMp2HHaGU8hTijltRuA==
X-Gm-Gg: ATEYQzxuuOGvRbV5DRFM39o/kPrt/pclufDlDymnI+oYr7n6MTSN9oCjgg5SgV9j4xX
	NjEDqkbG5f5bRw+YqvgUY1YJDeq4z2zyj/+Ml5kS0sykxq31kUS1dDslsrvUGAPWXxH1+FbSQFU
	gwWyLE4NOU0lyORMhpZ1yi0ywPyihQLCcXRMU5R7SPeafwNHtFVQpFHa7+B8gCW6HBWLj5bLW95
	/mMrdJm/z9aDM4MpAHuLUJFnDfQHtNNkHyAlJV3k+J9RO+nKjPp+rzNRgnENIiZguGJf2T/265e
	9LD/12VfASBZhOZbEiS1/o3blVeGl9uwKpHhq3SbQGbETG7bZE7aDUOwY7g1MiDnIGbtoAsnP1C
	GNnpZVxD/7vFB521nlPuMlnAfglRA4rHDRKmnPtVF3dq7WAc/8Bie3vWFuyUsS+5hIieCH1WLUO
	1hEy3Umu3yogxm1ky+nzS1YQ+PnZJO1Q07T2Moj7ElpSnmCt4pIC4IPqtYAr3+UYAUF2w7
X-Received: by 2002:a05:6122:6e05:b0:56a:ef89:34fc with SMTP id 71dfb90a1353d-56b07d7aebbmr953603e0c.6.1772816688042;
        Fri, 06 Mar 2026 09:04:48 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:1b3:a802:8875:ddd6:ede8:90d6:abeb])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b0f889ed2sm332967e0c.13.2026.03.06.09.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 09:04:46 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: broonie@kernel.org,
	alexander.stein@ew.tq-group.com,
	linux-sound@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 stable-6.18 1/2] ASoC: fsl_xcvr: use dev_err_probe() replacing dev_err() + return
Date: Fri,  6 Mar 2026 14:04:20 -0300
Message-Id: <20260306170421.1430704-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 224D4225A2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,ew.tq-group.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-223367-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[festevam@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.987];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Action: no action

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit 8ae28d04593a5fdddb16d3edcdabb8d1e4330d0b upstream.

Use dev_err_probe() to simplify the code. This also silences -517 errors.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Link: https://patch.msgid.link/20251125101334.1596381-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Also include it as part of the series as it fixes a storm of:

 [   3.217646] fsl-xcvr 30cc0000.r: failed to pcm register
 [    4.450639] fsl-xcvr 30cc0000vr: failed t pcm register
 [    4.485499] fsl-xcvr 30cc0000vr: failed to pcm register
 [    4.508775 fsl-xcvr 30cc0000.r: failed to pcm register
 [    4.624521] fsl-xcvr 30cc0000vr: failed to pcm reister
 [    4.783004] fsl-xcvr 30cc0000vr: failed to pcm register
 [    4.823300] fsl-xcv 30cc0000.r: failed to pcm register
 [    4.863936] fsl-xcvr 30cc0000vr: failed to pcm register
 [    4.907075] fsl-xcvr 30cc0000vr: failed to pcm register

 sound/soc/fsl/fsl_xcvr.c | 86 ++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 52 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 58db4906a01d..06434b2c9a0f 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1548,28 +1548,24 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 	xcvr->soc_data = of_device_get_match_data(&pdev->dev);
 
 	xcvr->ipg_clk = devm_clk_get(dev, "ipg");
-	if (IS_ERR(xcvr->ipg_clk)) {
-		dev_err(dev, "failed to get ipg clock\n");
-		return PTR_ERR(xcvr->ipg_clk);
-	}
+	if (IS_ERR(xcvr->ipg_clk))
+		return dev_err_probe(dev, PTR_ERR(xcvr->ipg_clk),
+				     "failed to get ipg clock\n");
 
 	xcvr->phy_clk = devm_clk_get(dev, "phy");
-	if (IS_ERR(xcvr->phy_clk)) {
-		dev_err(dev, "failed to get phy clock\n");
-		return PTR_ERR(xcvr->phy_clk);
-	}
+	if (IS_ERR(xcvr->phy_clk))
+		return dev_err_probe(dev, PTR_ERR(xcvr->phy_clk),
+				     "failed to get phy clock\n");
 
 	xcvr->spba_clk = devm_clk_get(dev, "spba");
-	if (IS_ERR(xcvr->spba_clk)) {
-		dev_err(dev, "failed to get spba clock\n");
-		return PTR_ERR(xcvr->spba_clk);
-	}
+	if (IS_ERR(xcvr->spba_clk))
+		return dev_err_probe(dev, PTR_ERR(xcvr->spba_clk),
+				     "failed to get spba clock\n");
 
 	xcvr->pll_ipg_clk = devm_clk_get(dev, "pll_ipg");
-	if (IS_ERR(xcvr->pll_ipg_clk)) {
-		dev_err(dev, "failed to get pll_ipg clock\n");
-		return PTR_ERR(xcvr->pll_ipg_clk);
-	}
+	if (IS_ERR(xcvr->pll_ipg_clk))
+		return dev_err_probe(dev, PTR_ERR(xcvr->pll_ipg_clk),
+				     "failed to get pll_ipg clock\n");
 
 	fsl_asoc_get_pll_clocks(dev, &xcvr->pll8k_clk,
 				&xcvr->pll11k_clk);
@@ -1593,51 +1589,42 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 
 	xcvr->regmap = devm_regmap_init_mmio_clk(dev, NULL, regs,
 						 &fsl_xcvr_regmap_cfg);
-	if (IS_ERR(xcvr->regmap)) {
-		dev_err(dev, "failed to init XCVR regmap: %ld\n",
-			PTR_ERR(xcvr->regmap));
-		return PTR_ERR(xcvr->regmap);
-	}
+	if (IS_ERR(xcvr->regmap))
+		return dev_err_probe(dev, PTR_ERR(xcvr->regmap), "failed to init XCVR regmap\n");
 
 	if (xcvr->soc_data->use_phy) {
 		xcvr->regmap_phy = devm_regmap_init(dev, NULL, xcvr,
 						    &fsl_xcvr_regmap_phy_cfg);
-		if (IS_ERR(xcvr->regmap_phy)) {
-			dev_err(dev, "failed to init XCVR PHY regmap: %ld\n",
-				PTR_ERR(xcvr->regmap_phy));
-			return PTR_ERR(xcvr->regmap_phy);
-		}
+		if (IS_ERR(xcvr->regmap_phy))
+			return dev_err_probe(dev, PTR_ERR(xcvr->regmap_phy),
+					     "failed to init XCVR PHY regmap\n");
 
 		switch (xcvr->soc_data->pll_ver) {
 		case PLL_MX8MP:
 			xcvr->regmap_pll = devm_regmap_init(dev, NULL, xcvr,
 							    &fsl_xcvr_regmap_pllv0_cfg);
-			if (IS_ERR(xcvr->regmap_pll)) {
-				dev_err(dev, "failed to init XCVR PLL regmap: %ld\n",
-					PTR_ERR(xcvr->regmap_pll));
-				return PTR_ERR(xcvr->regmap_pll);
-			}
+			if (IS_ERR(xcvr->regmap_pll))
+				return dev_err_probe(dev, PTR_ERR(xcvr->regmap_pll),
+						     "failed to init XCVR PLL regmap\n");
 			break;
 		case PLL_MX95:
 			xcvr->regmap_pll = devm_regmap_init(dev, NULL, xcvr,
 							    &fsl_xcvr_regmap_pllv1_cfg);
-			if (IS_ERR(xcvr->regmap_pll)) {
-				dev_err(dev, "failed to init XCVR PLL regmap: %ld\n",
-					PTR_ERR(xcvr->regmap_pll));
-				return PTR_ERR(xcvr->regmap_pll);
-			}
+			if (IS_ERR(xcvr->regmap_pll))
+				return dev_err_probe(dev, PTR_ERR(xcvr->regmap_pll),
+						     "failed to init XCVR PLL regmap\n");
 			break;
 		default:
-			dev_err(dev, "Error for PLL version %d\n", xcvr->soc_data->pll_ver);
-			return -EINVAL;
+			return dev_err_probe(dev, -EINVAL,
+					     "Error for PLL version %d\n",
+					     xcvr->soc_data->pll_ver);
 		}
 	}
 
 	xcvr->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
-	if (IS_ERR(xcvr->reset)) {
-		dev_err(dev, "failed to get XCVR reset control\n");
-		return PTR_ERR(xcvr->reset);
-	}
+	if (IS_ERR(xcvr->reset))
+		return dev_err_probe(dev, PTR_ERR(xcvr->reset),
+				     "failed to get XCVR reset control\n");
 
 	/* get IRQs */
 	irq = platform_get_irq(pdev, 0);
@@ -1645,17 +1632,13 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 		return irq;
 
 	ret = devm_request_irq(dev, irq, irq0_isr, 0, pdev->name, xcvr);
-	if (ret) {
-		dev_err(dev, "failed to claim IRQ0: %i\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to claim IRQ0\n");
 
 	rx_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rxfifo");
 	tx_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "txfifo");
-	if (!rx_res || !tx_res) {
-		dev_err(dev, "could not find rxfifo or txfifo resource\n");
-		return -EINVAL;
-	}
+	if (!rx_res || !tx_res)
+		return dev_err_probe(dev, -EINVAL, "could not find rxfifo or txfifo resource\n");
 	xcvr->dma_prms_rx.chan_name = "rx";
 	xcvr->dma_prms_tx.chan_name = "tx";
 	xcvr->dma_prms_rx.addr = rx_res->start;
@@ -1678,8 +1661,7 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 	ret = devm_snd_dmaengine_pcm_register(dev, NULL, 0);
 	if (ret) {
 		pm_runtime_disable(dev);
-		dev_err(dev, "failed to pcm register\n");
-		return ret;
+		return dev_err_probe(dev, ret, "failed to pcm register\n");
 	}
 
 	ret = devm_snd_soc_register_component(dev, &fsl_xcvr_comp,
-- 
2.34.1


