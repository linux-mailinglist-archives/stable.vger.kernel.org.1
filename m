Return-Path: <stable+bounces-204833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 397D3CF4579
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A6A30FA9BB
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5C275AF5;
	Mon,  5 Jan 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GeQXl1n8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36316309DCB
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625840; cv=none; b=FIQMABx+0+XqdHAAIPvnL4mzH6LOcgSHKu0NBvzdpcCsQ29vSts5tZv22KhPquZJjT28+KZyqS41Jik7dXNsIRoh6nwp0LrAP3GCAxEJbwDPz1tWCgSqXJFgeZLOZ+KLmJFv+WQgcOcNxOcDujFeyW4j3zbQmGCHGv5th8StTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625840; c=relaxed/simple;
	bh=m3ewghgJ1KmdkWHQSbe7K5Zj9NkMevqIDDOVV8KEk3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbrBEwKgyCfcA4AEfaOhLj0XKznGWz8bKhvIyodOgzo+zB9+IQ/jazcOdE+B3vA4oGM70EAamcjViB39qUP1Vb6YE+0PC3M0B9ypM97yz+HNamjkiiewxtHcOxJmuiPKKLgc/dbOclDIPX1lRmvrbaCrHQVAGLC+I3d87sTUI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GeQXl1n8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2375AC19422;
	Mon,  5 Jan 2026 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767625839;
	bh=m3ewghgJ1KmdkWHQSbe7K5Zj9NkMevqIDDOVV8KEk3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GeQXl1n8RO46PGK6zONNX+jvr5YZh97brUAFKupglMe0R39OmxGw6hjx53DfRnHZX
	 I4BhD/CJfyKK5XmCHg5lGIL4oi11+nuMXDV+I0GrRiQ3xwLlqAxy+Ra6DwdWk+qyuB
	 vUzrqJV9t43ECTyCz8RbUeqwTH3IXszjz4LeAk/vZlelnbE9MblyIEh5R0dBYvzlgZ
	 n4RJvwXoizsrc5IZzo7CX4ebT8bjalb+cWPdL497zJx4jlQk22SBK2taqvo16fo1bn
	 4U6gqWnNP7OuIwy9DIvF4E9yClsfggM6Y7qtQfOSp9xFA+06HuaMdF1V6DB1cKM0cm
	 /4Gb2ZYJ6w/cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Olivier Moysan <olivier.moysan@st.com>,
	olivier moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] ASoC: stm32: sai: fix clk prepare imbalance on probe failure
Date: Mon,  5 Jan 2026 10:10:32 -0500
Message-ID: <20260105151034.2625317-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105151034.2625317-1-sashal@kernel.org>
References: <2026010551-backpedal-chatroom-a9c7@gregkh>
 <20260105151034.2625317-1-sashal@kernel.org>
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
index e4ee4c800275..6ae1c15f3439 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1484,14 +1484,21 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
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
@@ -1535,26 +1542,33 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
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


