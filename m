Return-Path: <stable+bounces-57119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF46925ABB
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32D81C209BD
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8F17BB3B;
	Wed,  3 Jul 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="StCKqghq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C682142E8E;
	Wed,  3 Jul 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003905; cv=none; b=cprlSBEsYQOZ6NDd0PasLNE9J+DcJRamAyYjRJLL5l/+Y++HlisvOcHQyASPxtenHVCUimxw88mJ+nKzPY1M5yafm1mtyD13z4lQHaYiugCgYC4kfWwXEhzkhjZt5PR4hjXE0I2NHcvf1rvb+rsq5Q52+bg2z5cUWzS2VrxgsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003905; c=relaxed/simple;
	bh=J5afECYH1joYCVyyToY3Sgyjer1ldIS+THwKFzIBxX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNHq1B3Y0nxk4Fy/AigKMOSGYp+TmBTRsvCFJbHXU3fUFWJGQQnTPcfY0UN4kQ5I3rIMobu8gXS1XaEwPTT/aW+UyRwkGqIUu+KKZjVYRltH0CmXw/5gqaQ2Q2lZopqiK8kkTjCdFtOX/VGrwqmAQG/0JqkFTDqb3bT6yMJ4mv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=StCKqghq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8008C2BD10;
	Wed,  3 Jul 2024 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720003905;
	bh=J5afECYH1joYCVyyToY3Sgyjer1ldIS+THwKFzIBxX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StCKqghqtIy2qS4dUEcCiw/eusd1zpNsK7z1A2av5tf095I4kiYTkJYKVdoJCY+hm
	 rlyGxEKS0zZ+lLDS/mOJilWGvAg5HwG5cAJCk7UPpApgS3bed0A5+mD8rtMB6lRaK3
	 0JU+svqw/dEtCKs7D94mdX1cFb3rHIxa1rucn/gs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 028/189] ASoC: ti: davinci-mcasp: Simplify the configuration parameter handling
Date: Wed,  3 Jul 2024 12:38:09 +0200
Message-ID: <20240703102842.569518516@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 1125d925990b8d8166c45396c9281e2a705c97f8 ]

Replace the davinci_mcasp_set_pdata_from_of() function which returned a
pdata pointer with davinci_mcasp_get_config() to return an actual error
code and handle all pdata validation and private mcasp struct setup in
there.

Drop the unused ram-size-playback and sram-size-capture query from DT at
the same time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20201106072551.689-4-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: d18ca8635db2 ("ASoC: ti: davinci-mcasp: Fix race condition during probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 164 +++++++++++++----------------------
 1 file changed, 60 insertions(+), 104 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index e2e272d653480..637c26cad2e6e 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -75,6 +75,7 @@ struct davinci_mcasp_ruledata {
 
 struct davinci_mcasp {
 	struct snd_dmaengine_dai_dma_data dma_data[2];
+	struct davinci_mcasp_pdata *pdata;
 	void __iomem *base;
 	u32 fifo_base;
 	struct device *dev;
@@ -1722,44 +1723,37 @@ static int mcasp_reparent_fck(struct platform_device *pdev)
 	return ret;
 }
 
-static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
-						struct platform_device *pdev)
+static int davinci_mcasp_get_config(struct davinci_mcasp *mcasp,
+				    struct platform_device *pdev)
 {
+	const struct of_device_id *match = of_match_device(mcasp_dt_ids, &pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct davinci_mcasp_pdata *pdata = NULL;
-	const struct of_device_id *match =
-			of_match_device(mcasp_dt_ids, &pdev->dev);
-
 	const u32 *of_serial_dir32;
 	u32 val;
-	int i, ret = 0;
+	int i;
 
 	if (pdev->dev.platform_data) {
 		pdata = pdev->dev.platform_data;
 		pdata->dismod = DISMOD_LOW;
-		return pdata;
+		goto out;
 	} else if (match) {
 		pdata = devm_kmemdup(&pdev->dev, match->data, sizeof(*pdata),
 				     GFP_KERNEL);
 		if (!pdata)
-			return NULL;
+			return -ENOMEM;
 	} else {
-		/* control shouldn't reach here. something is wrong */
-		ret = -EINVAL;
-		goto nodata;
+		dev_err(&pdev->dev, "No compatible match found\n");
+		return -EINVAL;
 	}
 
-	ret = of_property_read_u32(np, "op-mode", &val);
-	if (ret >= 0)
+	if (of_property_read_u32(np, "op-mode", &val) == 0)
 		pdata->op_mode = val;
 
-	ret = of_property_read_u32(np, "tdm-slots", &val);
-	if (ret >= 0) {
+	if (of_property_read_u32(np, "tdm-slots", &val) == 0) {
 		if (val < 2 || val > 32) {
-			dev_err(&pdev->dev,
-				"tdm-slots must be in rage [2-32]\n");
-			ret = -EINVAL;
-			goto nodata;
+			dev_err(&pdev->dev, "tdm-slots must be in rage [2-32]\n");
+			return -EINVAL;
 		}
 
 		pdata->tdm_slots = val;
@@ -1771,10 +1765,8 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 		u8 *of_serial_dir = devm_kzalloc(&pdev->dev,
 						 (sizeof(*of_serial_dir) * val),
 						 GFP_KERNEL);
-		if (!of_serial_dir) {
-			ret = -ENOMEM;
-			goto nodata;
-		}
+		if (!of_serial_dir)
+			return -ENOMEM;
 
 		for (i = 0; i < val; i++)
 			of_serial_dir[i] = be32_to_cpup(&of_serial_dir32[i]);
@@ -1783,24 +1775,16 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 		pdata->serial_dir = of_serial_dir;
 	}
 
-	ret = of_property_read_u32(np, "tx-num-evt", &val);
-	if (ret >= 0)
+	if (of_property_read_u32(np, "tx-num-evt", &val) == 0)
 		pdata->txnumevt = val;
 
-	ret = of_property_read_u32(np, "rx-num-evt", &val);
-	if (ret >= 0)
+	if (of_property_read_u32(np, "rx-num-evt", &val) == 0)
 		pdata->rxnumevt = val;
 
-	ret = of_property_read_u32(np, "sram-size-playback", &val);
-	if (ret >= 0)
-		pdata->sram_size_playback = val;
-
-	ret = of_property_read_u32(np, "sram-size-capture", &val);
-	if (ret >= 0)
-		pdata->sram_size_capture = val;
+	if (of_property_read_u32(np, "auxclk-fs-ratio", &val) == 0)
+		mcasp->auxclk_fs_ratio = val;
 
-	ret = of_property_read_u32(np, "dismod", &val);
-	if (ret >= 0) {
+	if (of_property_read_u32(np, "dismod", &val) == 0) {
 		if (val == 0 || val == 2 || val == 3) {
 			pdata->dismod = DISMOD_VAL(val);
 		} else {
@@ -1811,15 +1795,40 @@ static struct davinci_mcasp_pdata *davinci_mcasp_set_pdata_from_of(
 		pdata->dismod = DISMOD_LOW;
 	}
 
-	return  pdata;
+out:
+	mcasp->pdata = pdata;
 
-nodata:
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error populating platform data, err %d\n",
-			ret);
-		pdata = NULL;
+	mcasp->op_mode = pdata->op_mode;
+	/* sanity check for tdm slots parameter */
+	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
+		if (pdata->tdm_slots < 2) {
+			dev_warn(&pdev->dev, "invalid tdm slots: %d\n",
+				 pdata->tdm_slots);
+			mcasp->tdm_slots = 2;
+		} else if (pdata->tdm_slots > 32) {
+			dev_warn(&pdev->dev, "invalid tdm slots: %d\n",
+				 pdata->tdm_slots);
+			mcasp->tdm_slots = 32;
+		} else {
+			mcasp->tdm_slots = pdata->tdm_slots;
+		}
 	}
-	return  pdata;
+
+	mcasp->num_serializer = pdata->num_serializer;
+#ifdef CONFIG_PM
+	mcasp->context.xrsr_regs = devm_kcalloc(&pdev->dev,
+						mcasp->num_serializer, sizeof(u32),
+						GFP_KERNEL);
+	if (!mcasp->context.xrsr_regs)
+		return -ENOMEM;
+#endif
+	mcasp->serial_dir = pdata->serial_dir;
+	mcasp->version = pdata->version;
+	mcasp->txnumevt = pdata->txnumevt;
+	mcasp->rxnumevt = pdata->rxnumevt;
+	mcasp->dismod = pdata->dismod;
+
+	return 0;
 }
 
 enum {
@@ -2055,25 +2064,10 @@ static inline int davinci_mcasp_init_gpiochip(struct davinci_mcasp *mcasp)
 }
 #endif /* CONFIG_GPIOLIB */
 
-static void davinci_mcasp_get_dt_params(struct davinci_mcasp *mcasp)
-{
-	struct device_node *np = mcasp->dev->of_node;
-	int ret;
-	u32 val;
-
-	if (!np)
-		return;
-
-	ret = of_property_read_u32(np, "auxclk-fs-ratio", &val);
-	if (ret >= 0)
-		mcasp->auxclk_fs_ratio = val;
-}
-
 static int davinci_mcasp_probe(struct platform_device *pdev)
 {
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct resource *mem, *dat;
-	struct davinci_mcasp_pdata *pdata;
 	struct davinci_mcasp *mcasp;
 	char *irq_name;
 	int irq;
@@ -2089,11 +2083,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (!mcasp)
 		return	-ENOMEM;
 
-	pdata = davinci_mcasp_set_pdata_from_of(pdev);
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		return -EINVAL;
-	}
+	mcasp->dev = &pdev->dev;
+	ret = davinci_mcasp_get_config(mcasp, pdev);
+	if (ret)
+		return ret;
 
 	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
 	if (!mem) {
@@ -2112,40 +2105,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	mcasp->op_mode = pdata->op_mode;
-	/* sanity check for tdm slots parameter */
-	if (mcasp->op_mode == DAVINCI_MCASP_IIS_MODE) {
-		if (pdata->tdm_slots < 2) {
-			dev_err(&pdev->dev, "invalid tdm slots: %d\n",
-				pdata->tdm_slots);
-			mcasp->tdm_slots = 2;
-		} else if (pdata->tdm_slots > 32) {
-			dev_err(&pdev->dev, "invalid tdm slots: %d\n",
-				pdata->tdm_slots);
-			mcasp->tdm_slots = 32;
-		} else {
-			mcasp->tdm_slots = pdata->tdm_slots;
-		}
-	}
-
-	mcasp->num_serializer = pdata->num_serializer;
-#ifdef CONFIG_PM
-	mcasp->context.xrsr_regs = devm_kcalloc(&pdev->dev,
-					mcasp->num_serializer, sizeof(u32),
-					GFP_KERNEL);
-	if (!mcasp->context.xrsr_regs) {
-		ret = -ENOMEM;
-		goto err;
-	}
-#endif
-	mcasp->serial_dir = pdata->serial_dir;
-	mcasp->version = pdata->version;
-	mcasp->txnumevt = pdata->txnumevt;
-	mcasp->rxnumevt = pdata->rxnumevt;
-	mcasp->dismod = pdata->dismod;
-
-	mcasp->dev = &pdev->dev;
-
 	irq = platform_get_irq_byname_optional(pdev, "common");
 	if (irq > 0) {
 		irq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s_common",
@@ -2214,7 +2173,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (dat)
 		dma_data->addr = dat->start;
 	else
-		dma_data->addr = mem->start + davinci_mcasp_txdma_offset(pdata);
+		dma_data->addr = mem->start + davinci_mcasp_txdma_offset(mcasp->pdata);
 
 
 	/* RX is not valid in DIT mode */
@@ -2225,7 +2184,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 			dma_data->addr = dat->start;
 		else
 			dma_data->addr =
-				mem->start + davinci_mcasp_rxdma_offset(pdata);
+				mem->start + davinci_mcasp_rxdma_offset(mcasp->pdata);
 	}
 
 	if (mcasp->version < MCASP_VERSION_3) {
@@ -2278,11 +2237,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
-	davinci_mcasp_get_dt_params(mcasp);
-
-	ret = devm_snd_soc_register_component(&pdev->dev,
-					&davinci_mcasp_component,
-					&davinci_mcasp_dai[pdata->op_mode], 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &davinci_mcasp_component,
+					      &davinci_mcasp_dai[mcasp->op_mode], 1);
 
 	if (ret != 0)
 		goto err;
-- 
2.43.0




