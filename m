Return-Path: <stable+bounces-185494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AD9BD5BC6
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029094083E1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E42D7DE5;
	Mon, 13 Oct 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl5VnUg1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D582D73A5
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380478; cv=none; b=ad5w4r1RuxM5Zch/8ttXNXFNDXD0sfNO93EekD/PQC0HFbjXgZGDLDv8Rw9x1PbHc56pWE7KfE2E6nX0m0MUSavpqQTIJD6EJ16KW6969KScBWh1PaJAi4dAMstZBkXgBYMJDDWcEEUVo2T0Llj7H1IaJukpx62fiB6PhmMUmNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380478; c=relaxed/simple;
	bh=pH+qtlqnpbbCKMQ4kucs6DzdA4HYGeTTg4Q4oGn7Iog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6yfWiAk1KmnHUb3n8iHkYwYROul4IqTkZENC2nDIXQ4ZN2LY0eq3h+1SwSYbS3/gsg0PIqBmETKfRw52jFoQMt4Bz2T7E14rToalo2Ywv4hjHPFmHfk9B6Mdvf5tjXfgSkCPtalAN173zsxrjRIT0Kd24D0dJR6gqquuI3d03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl5VnUg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272F7C4CEFE;
	Mon, 13 Oct 2025 18:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380477;
	bh=pH+qtlqnpbbCKMQ4kucs6DzdA4HYGeTTg4Q4oGn7Iog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jl5VnUg1OJDqeQAcQtrfvXLZ8B1J+wWxhqZC8I37qc2acqjaY/Td+eG6tXBHjEfl9
	 fiMiJ/3kcgklxA7aS37L1ZMf9DALplgXrA9GXtiAoUwuS56Aq1FsKcCFlyL6myTy5S
	 AFgY/o7CgkRbfrUbdFNkXK9rUhZxwOSzZHFuOyxCD1VFO9zLazca/Tw3+fHBJDozch
	 Ppm6JIus5XnJ7J+xVa7idOws/pCXk6Tjs/EuDV5XdGc5m4TMaTXlP5BD5PFd6/gXh3
	 q19WQAo9A6Baso9MhsDvJHvMDbrbeoC1A73LgTJt32i0UK84AfE667sDMiH2QAbOiI
	 VkAa9mzes8XpA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ASoC: codecs: wcd934x: Simplify with dev_err_probe
Date: Mon, 13 Oct 2025 14:34:33 -0400
Message-ID: <20251013183434.3507752-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101303-agency-job-17ce@gregkh>
References: <2025101303-agency-job-17ce@gregkh>
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
index 04c50f9acda18..8670c2512b8a4 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5884,10 +5884,9 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
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
@@ -5939,19 +5938,15 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
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
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
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


