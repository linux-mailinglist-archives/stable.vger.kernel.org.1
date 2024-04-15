Return-Path: <stable+bounces-39501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E82A48A51E2
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB391F236D8
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB8976046;
	Mon, 15 Apr 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtFMQuaR"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6681C69D
	for <Stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188306; cv=none; b=lESt9EPmQBiST9LuEtYnp2VDd+meBQOTdMLdifqdCksLO5D05S9IeX/5OTYS789855N8zOWfeY/7AO/MAImRcbVD76ZtXng9I/vb2Otp84yS4AqdaZn2ArAmIVGv+mE4ZJ/xAsNc+Dqe2UFx3Yb73qkAwoQ32M1W4OpXBiLdtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188306; c=relaxed/simple;
	bh=sSj9MAjjhhMmWYRNQdBoR0gOMWN8jAQ2xrau7skEub0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl30AS1g7B/ji8ZL+mFmpL5ffrR8xnLK6DvtMFYXPsB0M/ejclMt21LAyB76rEZXmEkDpYnChVKmd7aqO2SyqGjpfvWsG3IzPLNrMX4bQVX6GCv7EFsy9HhVnjqSDBanjl9Yoa3kIHwtC1bR4bUi6qJ2Ogfbhq3e2namKHq1AKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtFMQuaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FA9C2BD11;
	Mon, 15 Apr 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188306;
	bh=sSj9MAjjhhMmWYRNQdBoR0gOMWN8jAQ2xrau7skEub0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtFMQuaRNB7e/bKKaISs8ljOc5V11uz5ygjoN/EBaV9TXQ80XOt6FldVQzVwsAC31
	 gp6k1SFGXpN9+eEJrMWVc74YMQJvLkey5TsyD3lcijuC/ku+q8ULryScXgiEG6TTp+
	 q/Nj+Yem74C381Cm7R/MfHoD9rkEbseFvFvkHhDfHhfWFvUsoUBhgBZQuKxPArV+ZQ
	 XJtffKeJrLZ/HmFltG4jBN+z94gle02eONZEzxbIZqghAMaVkZ+7OvfTjB/SnJk/Xy
	 dhEynvTlv1heeYJTEHPzlLjBmnLqYb3DkIRFAk0AIbsYAfjioE4/gm5LiZcFGvQ7rU
	 zcedRXTyNdf6A==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 013/190] iio: exynos-adc: request second interupt only when touchscreen mode is used
Date: Mon, 15 Apr 2024 06:49:03 -0400
Message-ID: <20240415105208.3137874-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 865b080e3229102f160889328ce2e8e97aa65ea0 ]

Second interrupt is needed only when touchscreen mode is used, so don't
request it unconditionally. This removes the following annoying warning
during boot:

exynos-adc 14d10000.adc: error -ENXIO: IRQ index 1 not found

Fixes: 2bb8ad9b44c5 ("iio: exynos-adc: add experimental touchscreen support")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20231009101412.916922-1-m.szyprowski@samsung.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/exynos_adc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 019153882e700..f8324261e74d4 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -787,6 +787,12 @@ static int exynos_adc_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* leave out any TS related code if unreachable */
+	if (IS_REACHABLE(CONFIG_INPUT)) {
+		has_ts = of_property_read_bool(pdev->dev.of_node,
+					       "has-touchscreen") || pdata;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
@@ -794,11 +800,15 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	}
 	info->irq = irq;
 
-	irq = platform_get_irq(pdev, 1);
-	if (irq == -EPROBE_DEFER)
-		return irq;
+	if (has_ts) {
+		irq = platform_get_irq(pdev, 1);
+		if (irq == -EPROBE_DEFER)
+			return irq;
 
-	info->tsirq = irq;
+		info->tsirq = irq;
+	} else {
+		info->tsirq = -1;
+	}
 
 	info->dev = &pdev->dev;
 
@@ -865,12 +875,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	/* leave out any TS related code if unreachable */
-	if (IS_REACHABLE(CONFIG_INPUT)) {
-		has_ts = of_property_read_bool(pdev->dev.of_node,
-					       "has-touchscreen") || pdata;
-	}
-
 	if (pdata)
 		info->delay = pdata->delay;
 	else
-- 
2.43.0


