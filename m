Return-Path: <stable+bounces-196673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63181C7FFC7
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 975D34E405D
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676FC2F9C37;
	Mon, 24 Nov 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpFy7MdE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26B26F47D;
	Mon, 24 Nov 2025 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981368; cv=none; b=I9/YCfKD+3+xNeRNvCY1gifs9c8O5WqabN6f+hurj5YXWjaHXVdivMdAj2yWJVfU0DhY0ULiWjl3paajgSZ0vHIzmapLlSB3Oc2YfajgOx3m/EPi5tUqueq2zLjXckXmsp6zVS7gjRKesnWLiFuz/bmGKdh6IKC7YgegOw/7ysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981368; c=relaxed/simple;
	bh=i08hszhUYmm0GoaE3UJ71ASWWP8tOEqI/LV0je9kaJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/FzLF0ZGaX5dcOO+Cg/Ksih3I8O/M6xYA1GEm3OGvlWffpOW3vYXCgFY2+/sgHuC7/7xj9tZrMmOJkD7mcgMfVj2BH5Xfzk9jRCRrA2nuIXWb37E3Lo6tfv6XUNBgrwT4P4/Ji5oI7Z9qeWQWxJHd6cAJEeZ8FQtMNVgQgYUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpFy7MdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C441FC16AAE;
	Mon, 24 Nov 2025 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763981367;
	bh=i08hszhUYmm0GoaE3UJ71ASWWP8tOEqI/LV0je9kaJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpFy7MdEEqD3y9OqqGCc7Kry4luv9WQcgpzb5GtqvSNGgpotb8GEw4yhBbhHQrX/7
	 +/SVn+peiFgdHjmZS2ND5Ow2xcStZxxAhOXiBz6GZvVvMaWvpAxwIRL+r5QCDz+3jA
	 HmY5a5i9jdzkkcgvB36S27L0qKkMJwXOpvcRdENPmbhIet7WY+xNjrDiE/cXGQD+5p
	 XQTDzG3SPVoYGzX3lO2SEoQoIoNi74YpsNTAZmifsq/KdZjNq7ahBco57z//x+B4UA
	 VkH/10kmvzM8dcOv0YXqTBNws0l27I5NZvAApiR/NMNERy+92aiG9bUbWiLLBGpt6g
	 T62/tvKkX4usA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vNU8N-0000000046h-1THU;
	Mon, 24 Nov 2025 11:49:27 +0100
From: Johan Hovold <johan@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 2/4] ASoC: stm32: sai: fix clk prepare imbalance on probe failure
Date: Mon, 24 Nov 2025 11:49:06 +0100
Message-ID: <20251124104908.15754-3-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251124104908.15754-1-johan@kernel.org>
References: <20251124104908.15754-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to unprepare the parent clock also on probe failures (e.g.
probe deferral).

Fixes: a14bf98c045b ("ASoC: stm32: sai: fix possible circular locking")
Cc: stable@vger.kernel.org	# 5.5
Cc: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 0ae1eae2a59e..7a005b4ad304 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1634,14 +1634,21 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	if (of_property_present(np, "#clock-cells")) {
 		ret = stm32_sai_add_mclk_provider(sai);
 		if (ret < 0)
-			return ret;
+			goto err_unprepare_pclk;
 	} else {
 		sai->sai_mclk = devm_clk_get_optional(&pdev->dev, "MCLK");
-		if (IS_ERR(sai->sai_mclk))
-			return PTR_ERR(sai->sai_mclk);
+		if (IS_ERR(sai->sai_mclk)) {
+			ret = PTR_ERR(sai->sai_mclk);
+			goto err_unprepare_pclk;
+		}
 	}
 
 	return 0;
+
+err_unprepare_pclk:
+	clk_unprepare(sai->pdata->pclk);
+
+	return ret;
 }
 
 static int stm32_sai_sub_probe(struct platform_device *pdev)
@@ -1688,26 +1695,33 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 			       IRQF_SHARED, dev_name(&pdev->dev), sai);
 	if (ret) {
 		dev_err(&pdev->dev, "IRQ request returned %d\n", ret);
-		return ret;
+		goto err_unprepare_pclk;
 	}
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
 		conf = &stm32_sai_pcm_config_spdif;
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, conf, 0);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Could not register pcm dma\n");
+	if (ret) {
+		ret = dev_err_probe(&pdev->dev, ret, "Could not register pcm dma\n");
+		goto err_unprepare_pclk;
+	}
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_component,
 					 &sai->cpu_dai_drv, 1);
 	if (ret) {
 		snd_dmaengine_pcm_unregister(&pdev->dev);
-		return ret;
+		goto err_unprepare_pclk;
 	}
 
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
+
+err_unprepare_pclk:
+	clk_unprepare(sai->pdata->pclk);
+
+	return ret;
 }
 
 static void stm32_sai_sub_remove(struct platform_device *pdev)
-- 
2.51.2


