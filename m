Return-Path: <stable+bounces-204812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22478CF4269
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 744E63008195
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E229B217;
	Mon,  5 Jan 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEEPvk4k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6315CD7E
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623790; cv=none; b=iCGQQrhCWCoSMropLOcOibANB0OXP0OllezbcZ0x01LPQrsfzJKctKvE5R/L/9xapVYHqZWuRU9CiR2In0ud8SfaOIF90CUQtLRqVI+3XLGVry4Zat/4JlGIJZLOriQq4t7V+NLK8oRsIlXP069JFBZ95B2bCM4UUPK/QQAPBlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623790; c=relaxed/simple;
	bh=HYS3K6ITFLQ6lxwr1wZf8/cw0XWtSA5oczbtWg6wgn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7OFNFvZdpXWU6RJaOtBO9HdpatWZxEAm4QmdXEcnpxZ8NcRtMNA9ZvJNo/MxcttYi2rlemOAzCSVeT0Kob226PBNlkMxNiWyQ1Ovhq30cyvXtAs6k/YY7+0lAYrjMAYhau2kfG8Gd0mzzTgbB/65gxN2p7Px4Ixif8m28GdE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEEPvk4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC828C116D0;
	Mon,  5 Jan 2026 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767623789;
	bh=HYS3K6ITFLQ6lxwr1wZf8/cw0XWtSA5oczbtWg6wgn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EEEPvk4kDTV7Hi6quJ32FO7ROqwKn+K/YOM8GpKn3eBFZyvF63n4EyzBUWjGetk6h
	 XJW799bgM++k/YM3QrbwifWMU+7g9PaniBUOx7cybXXMIM+RnQrxX99hG32OdnVO9A
	 d8SfEtN0Z1RgTFw/e0/7RYhLPxY81UD9mRfDtKXEVo2q87LZPavl3spY3r4wIk0i1Z
	 OclQhpBfYcKtg0iUp1SRvC/sZhjwEHkKilY/p6Q9c/ToUANTTvAccsIeJa1lC4gsa1
	 bAqvPKSgBV0NL6MrAeEJr4EwRchMlNCiJpLVv95fBlGEAmIEdGRRZvDrxeUTov20DA
	 q2Cj+JpDtYg/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] ASoC: stm: Use dev_err_probe() helper
Date: Mon,  5 Jan 2026 09:36:24 -0500
Message-ID: <20260105143626.2605607-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010531-relapse-parcel-11e0@gregkh>
References: <2026010531-relapse-parcel-11e0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ Upstream commit efc162cbd480f1fb47d439c193ec9731bcc6c749 ]

Use the dev_err_probe() helper, instead of open-coding the same
operation.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20211214020843.2225831-22-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 312ec2f0d9d1 ("ASoC: stm32: sai: fix clk prepare imbalance on probe failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_i2s.c     | 62 ++++++++++++-----------------------
 sound/soc/stm/stm32_sai.c     | 37 ++++++++-------------
 sound/soc/stm/stm32_sai_sub.c | 25 +++++---------
 sound/soc/stm/stm32_spdifrx.c | 44 +++++++++----------------
 4 files changed, 57 insertions(+), 111 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 7c4d63c33f15..bc369d064e48 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -830,36 +830,24 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	/* Get clocks */
 	i2s->pclk = devm_clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(i2s->pclk)) {
-		if (PTR_ERR(i2s->pclk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get pclk: %ld\n",
-				PTR_ERR(i2s->pclk));
-		return PTR_ERR(i2s->pclk);
-	}
+	if (IS_ERR(i2s->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->pclk),
+				     "Could not get pclk\n");
 
 	i2s->i2sclk = devm_clk_get(&pdev->dev, "i2sclk");
-	if (IS_ERR(i2s->i2sclk)) {
-		if (PTR_ERR(i2s->i2sclk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get i2sclk: %ld\n",
-				PTR_ERR(i2s->i2sclk));
-		return PTR_ERR(i2s->i2sclk);
-	}
+	if (IS_ERR(i2s->i2sclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->i2sclk),
+				     "Could not get i2sclk\n");
 
 	i2s->x8kclk = devm_clk_get(&pdev->dev, "x8k");
-	if (IS_ERR(i2s->x8kclk)) {
-		if (PTR_ERR(i2s->x8kclk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get x8k parent clock: %ld\n",
-				PTR_ERR(i2s->x8kclk));
-		return PTR_ERR(i2s->x8kclk);
-	}
+	if (IS_ERR(i2s->x8kclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->x8kclk),
+				     "Could not get x8k parent clock\n");
 
 	i2s->x11kclk = devm_clk_get(&pdev->dev, "x11k");
-	if (IS_ERR(i2s->x11kclk)) {
-		if (PTR_ERR(i2s->x11kclk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get x11k parent clock: %ld\n",
-				PTR_ERR(i2s->x11kclk));
-		return PTR_ERR(i2s->x11kclk);
-	}
+	if (IS_ERR(i2s->x11kclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->x11kclk),
+				     "Could not get x11k parent clock\n");
 
 	/* Get irqs */
 	irq = platform_get_irq(pdev, 0);
@@ -875,12 +863,10 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(rst)) {
-		if (PTR_ERR(rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Reset controller error %ld\n",
-				PTR_ERR(rst));
-		return PTR_ERR(rst);
-	}
+	if (IS_ERR(rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
+				     "Reset controller error\n");
+
 	reset_control_assert(rst);
 	udelay(2);
 	reset_control_deassert(rst);
@@ -922,19 +908,13 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 	i2s->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "pclk",
 						i2s->base, i2s->regmap_conf);
-	if (IS_ERR(i2s->regmap)) {
-		if (PTR_ERR(i2s->regmap) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Regmap init error %ld\n",
-				PTR_ERR(i2s->regmap));
-		return PTR_ERR(i2s->regmap);
-	}
+	if (IS_ERR(i2s->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2s->regmap),
+				     "Regmap init error\n");
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "PCM DMA register error %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "PCM DMA register error\n");
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					 i2s->dai_drv, 1);
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 058757c721f0..8e21e6f886fc 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -173,29 +173,20 @@ static int stm32_sai_probe(struct platform_device *pdev)
 
 	if (!STM_SAI_IS_F4(sai)) {
 		sai->pclk = devm_clk_get(&pdev->dev, "pclk");
-		if (IS_ERR(sai->pclk)) {
-			if (PTR_ERR(sai->pclk) != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "missing bus clock pclk: %ld\n",
-					PTR_ERR(sai->pclk));
-			return PTR_ERR(sai->pclk);
-		}
+		if (IS_ERR(sai->pclk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(sai->pclk),
+					     "missing bus clock pclk\n");
 	}
 
 	sai->clk_x8k = devm_clk_get(&pdev->dev, "x8k");
-	if (IS_ERR(sai->clk_x8k)) {
-		if (PTR_ERR(sai->clk_x8k) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "missing x8k parent clock: %ld\n",
-				PTR_ERR(sai->clk_x8k));
-		return PTR_ERR(sai->clk_x8k);
-	}
+	if (IS_ERR(sai->clk_x8k))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sai->clk_x8k),
+				     "missing x8k parent clock\n");
 
 	sai->clk_x11k = devm_clk_get(&pdev->dev, "x11k");
-	if (IS_ERR(sai->clk_x11k)) {
-		if (PTR_ERR(sai->clk_x11k) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "missing x11k parent clock: %ld\n",
-				PTR_ERR(sai->clk_x11k));
-		return PTR_ERR(sai->clk_x11k);
-	}
+	if (IS_ERR(sai->clk_x11k))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sai->clk_x11k),
+				     "missing x11k parent clock\n");
 
 	/* init irqs */
 	sai->irq = platform_get_irq(pdev, 0);
@@ -204,12 +195,10 @@ static int stm32_sai_probe(struct platform_device *pdev)
 
 	/* reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(rst)) {
-		if (PTR_ERR(rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Reset controller error %ld\n",
-				PTR_ERR(rst));
-		return PTR_ERR(rst);
-	}
+	if (IS_ERR(rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
+				     "Reset controller error\n");
+
 	reset_control_assert(rst);
 	udelay(2);
 	reset_control_deassert(rst);
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 90e4757f76b0..0deaeb3d3c13 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1380,12 +1380,9 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	 */
 	sai->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					    sai->regmap_config);
-	if (IS_ERR(sai->regmap)) {
-		if (PTR_ERR(sai->regmap) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Regmap init error %ld\n",
-				PTR_ERR(sai->regmap));
-		return PTR_ERR(sai->regmap);
-	}
+	if (IS_ERR(sai->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sai->regmap),
+				     "Regmap init error\n");
 
 	/* Get direction property */
 	if (of_property_match_string(np, "dma-names", "tx") >= 0) {
@@ -1473,12 +1470,9 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 	of_node_put(args.np);
 	sai->sai_ck = devm_clk_get(&pdev->dev, "sai_ck");
-	if (IS_ERR(sai->sai_ck)) {
-		if (PTR_ERR(sai->sai_ck) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Missing kernel clock sai_ck: %ld\n",
-				PTR_ERR(sai->sai_ck));
-		return PTR_ERR(sai->sai_ck);
-	}
+	if (IS_ERR(sai->sai_ck))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sai->sai_ck),
+				     "Missing kernel clock sai_ck\n");
 
 	ret = clk_prepare(sai->pdata->pclk);
 	if (ret < 0)
@@ -1552,11 +1546,8 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 		conf = &stm32_sai_pcm_config_spdif;
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not register pcm dma\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Could not register pcm dma\n");
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_component,
 					 &sai->cpu_dai_drv, 1);
diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index ef518cff84f2..2bf834800cc0 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -405,12 +405,9 @@ static int stm32_spdifrx_dma_ctrl_register(struct device *dev,
 	int ret;
 
 	spdifrx->ctrl_chan = dma_request_chan(dev, "rx-ctrl");
-	if (IS_ERR(spdifrx->ctrl_chan)) {
-		if (PTR_ERR(spdifrx->ctrl_chan) != -EPROBE_DEFER)
-			dev_err(dev, "dma_request_slave_channel error %ld\n",
-				PTR_ERR(spdifrx->ctrl_chan));
-		return PTR_ERR(spdifrx->ctrl_chan);
-	}
+	if (IS_ERR(spdifrx->ctrl_chan))
+		return dev_err_probe(dev, PTR_ERR(spdifrx->ctrl_chan),
+				     "dma_request_slave_channel error\n");
 
 	spdifrx->dmab = devm_kzalloc(dev, sizeof(struct snd_dma_buffer),
 				     GFP_KERNEL);
@@ -930,12 +927,9 @@ static int stm32_spdifrx_parse_of(struct platform_device *pdev,
 	spdifrx->phys_addr = res->start;
 
 	spdifrx->kclk = devm_clk_get(&pdev->dev, "kclk");
-	if (IS_ERR(spdifrx->kclk)) {
-		if (PTR_ERR(spdifrx->kclk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get kclk: %ld\n",
-				PTR_ERR(spdifrx->kclk));
-		return PTR_ERR(spdifrx->kclk);
-	}
+	if (IS_ERR(spdifrx->kclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(spdifrx->kclk),
+				     "Could not get kclk\n");
 
 	spdifrx->irq = platform_get_irq(pdev, 0);
 	if (spdifrx->irq < 0)
@@ -986,12 +980,9 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	spdifrx->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "kclk",
 						    spdifrx->base,
 						    spdifrx->regmap_conf);
-	if (IS_ERR(spdifrx->regmap)) {
-		if (PTR_ERR(spdifrx->regmap) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Regmap init error %ld\n",
-				PTR_ERR(spdifrx->regmap));
-		return PTR_ERR(spdifrx->regmap);
-	}
+	if (IS_ERR(spdifrx->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(spdifrx->regmap),
+				     "Regmap init error\n");
 
 	ret = devm_request_irq(&pdev->dev, spdifrx->irq, stm32_spdifrx_isr, 0,
 			       dev_name(&pdev->dev), spdifrx);
@@ -1001,23 +992,18 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	}
 
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(rst)) {
-		if (PTR_ERR(rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Reset controller error %ld\n",
-				PTR_ERR(rst));
-		return PTR_ERR(rst);
-	}
+	if (IS_ERR(rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rst),
+				     "Reset controller error\n");
+
 	reset_control_assert(rst);
 	udelay(2);
 	reset_control_deassert(rst);
 
 	pcm_config = &stm32_spdifrx_pcm_config;
 	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config, 0);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "PCM DMA register error %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "PCM DMA register error\n");
 
 	ret = snd_soc_register_component(&pdev->dev,
 					 &stm32_spdifrx_component,
-- 
2.51.0


