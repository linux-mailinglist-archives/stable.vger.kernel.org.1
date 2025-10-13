Return-Path: <stable+bounces-185503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6766BD5FC0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DEA24EA505
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D592D7DDC;
	Mon, 13 Oct 2025 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+486C3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850D1D5141
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384543; cv=none; b=pFoR0Sl7xBWNsE/3/Hp5DUAK2FQhN8bLr6YkPbwjfRxfi9RlmbVpTxubsFYNvemD2/M65CJ888uilyBYJnrFL5V9Asqg2+CMA54iMYd7nrTAyJ1MAcrkW3zaQwbXO2EQ2xzaolrQtT8G6APDjgQzmJTE+hm4AIil783+qPP1zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384543; c=relaxed/simple;
	bh=P3G4ncXJ+rWz4wE1ufUOdgBabZHnrjJXQI5pxMPqoIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNqEATS8pHwhqGaSlUZE7GiMI/46t/AqTijeawWQVaV9OMJ5vQvOBouqd1PRCT6CBMYJW5I+7k2Es6gXAJqnUutTtuEHpWSziMpZs7IyduKyDBpq3YDIpsqaKfoEemCI7dErnZYsyhRYRuUaR9umOM+FhUCLDtV1Z27E6HpsCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+486C3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2CDC4CEE7;
	Mon, 13 Oct 2025 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760384543;
	bh=P3G4ncXJ+rWz4wE1ufUOdgBabZHnrjJXQI5pxMPqoIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+486C3dxPBBbHCc8/fVgLLjWekMECdqtt6RFdKrcPMxzDBoy8MMp57Bsl5QcWm2X
	 rYvJxt3voK7uHcuqriyeSdIY2/20o1MAemHobnmalpzZ/3+U7Ov7PQ2bL5VHHTt1Et
	 gOG0W5ht8v+E2Sf4Oi93QsLFWAlezRGjGGfeBCHtVaECAb92UZOlBAM1rwsyNMDiiW
	 16T37HsnnuLnnPQJDjAbKLzIkawauvuopBgBBZtQ5TiSaWWf1EhJ331klOuqaMbmQ9
	 ITsiuxptUGikuGGDsbSCxxvjT0No3YZPmTgc90rTQoYCC5fLqE8B3in4uXSqhVyh2F
	 AS4bH3IFQb3lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Date: Mon, 13 Oct 2025 15:42:17 -0400
Message-ID: <20251013194218.3571206-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101306-ploy-alkalize-b950@gregkh>
References: <2025101306-ploy-alkalize-b950@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit fa92f4294283cc7d1f29151420be9e9336182518 ]

Replace dev_err() in probe() path with dev_err_probe() to:
1. Make code a bit simpler and easier to read,
2. Do not print messages on deferred probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230418074630.8681-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 4e65bda8273c ("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 8580f5e95ccf6..965ae7b7e8d83 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5032,10 +5032,9 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 	slim_get_logical_addr(wcd->sidev);
 	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
 				  &wcd934x_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap)) {
-		dev_err(dev, "Failed to allocate ifc register map\n");
-		return PTR_ERR(wcd->if_regmap);
-	}
+	if (IS_ERR(wcd->if_regmap))
+		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
+				     "Failed to allocate ifc register map\n");
 
 	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
 			     &wcd->dmic_sample_rate);
@@ -5074,19 +5073,15 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 	memcpy(wcd->tx_chs, wcd934x_tx_chs, sizeof(wcd934x_tx_chs));
 
 	irq = regmap_irq_get_virq(data->irq_data, WCD934X_IRQ_SLIMBUS);
-	if (irq < 0) {
-		dev_err(wcd->dev, "Failed to get SLIM IRQ\n");
-		return irq;
-	}
+	if (irq < 0)
+		return dev_err_probe(wcd->dev, irq, "Failed to get SLIM IRQ\n");
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					wcd934x_slim_irq_handler,
 					IRQF_TRIGGER_RISING,
 					"slim", wcd);
-	if (ret) {
-		dev_err(dev, "Failed to request slimbus irq\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request slimbus irq\n");
 
 	wcd934x_register_mclk_output(wcd);
 	platform_set_drvdata(pdev, wcd);
-- 
2.51.0


