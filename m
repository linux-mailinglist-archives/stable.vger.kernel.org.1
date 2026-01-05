Return-Path: <stable+bounces-204820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B64CF4495
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28CDE30693FA
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85722836E;
	Mon,  5 Jan 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfolCTPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F71C3BF7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624700; cv=none; b=JrvM8KGy3sY4eyvjljHeaRU8u7dElC9oK3WsPFq6BHJOU6S7xnAU4uvqbLCbNPstr2l+4xR5zRNePsAUxTKEsiuJEsTZFOeIWRh503cTkKQ831t3o5PAXEUJaUDr6syxPOoCfY7/21nPSIy/OkWzbN1ZWrIW55pcQYUb3jH4K6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624700; c=relaxed/simple;
	bh=kDNXQJIeHchz+A0IBEa2zbGMxraiYuEidOMkLMKrCAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHkK07rC8Gok8ouB4Wsk2E2lBZvS2eXZnabo3TDYTsbsROx4leAIySFeMyily7tW1+YZntvIkhhu/LnJiFL4p6J5rgX4gk4seQ0cnalpdk46BuLzbdvHxrB9Odv1j3xqFm7U/mvRs6r3DGzuPI3vb/RcEd4vDm8Tq2tQAxYLurc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfolCTPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733BEC19422;
	Mon,  5 Jan 2026 14:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767624700;
	bh=kDNXQJIeHchz+A0IBEa2zbGMxraiYuEidOMkLMKrCAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WfolCTPPMILBUrIh8XV96rWbab+mJ2tms1fbs5HcCcB40WtwcuA4NNA3S9toF7/aT
	 edCtNhXG1iMxbwc4hClYzW3UvYWr+r+YLygYTnIwR3AGx5JLM6qBMo1gTmNpdIWhJa
	 9qtpZcxvf+YJvcANZC4YZPjAKmVXTD/+FALV1mVmDC86++v1GlgqkuVycDlR2PLF3d
	 RCraTk5vzHFv3ST1s24ZI9VoAPHLePGwuEW38gnC85O/hjwClL23f72ZJy/twdxuep
	 MEW7s40/5k6jW4Q70GPxwSSc5LWTGpZzwFO953pwv0Vu3yvIJ/Mtdj1jFgwTodY7k2
	 KBRunm375ITcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Olivier Moysan <olivier.moysan@st.com>,
	olivier moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] ASoC: stm32: sai: fix clk prepare imbalance on probe failure
Date: Mon,  5 Jan 2026 09:51:34 -0500
Message-ID: <20260105145135.2613585-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105145135.2613585-1-sashal@kernel.org>
References: <2026010551-divinity-dislodge-aca5@gregkh>
 <20260105145135.2613585-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 312ec2f0d9d1a5656f76d770bbf1d967e9289aa7 ]

Make sure to unprepare the parent clock also on probe failures (e.g.
probe deferral).

Fixes: a14bf98c045b ("ASoC: stm32: sai: fix possible circular locking")
Cc: stable@vger.kernel.org	# 5.5
Cc: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: olivier moysan <olivier.moysan@foss.st.com>
Link: https://patch.msgid.link/20251124104908.15754-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 23261f0de094 ("ASoC: stm32: sai: fix OF node leak on probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index cc0e9429fc21..c302d4de2a88 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1483,14 +1483,21 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	if (of_find_property(np, "#clock-cells", NULL)) {
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
@@ -1534,26 +1541,33 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
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
2.51.0


