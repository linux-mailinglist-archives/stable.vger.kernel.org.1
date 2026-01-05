Return-Path: <stable+bounces-204804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86419CF40BB
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 15:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87EAB3027A41
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B4261B8C;
	Mon,  5 Jan 2026 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3LERSk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A652F88
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767621976; cv=none; b=FRpeeY+ReVTiP7PAgmasyD8HsrXD6yEnzGBdjF0iKX8RDS9js/ZsyxBPy4SJu1xI7vNR2nTMQMf7JA7OPIutBAJu4ZXdk8Tra+sSQML1X+3i7iqVzJW1D9v98XNJqBt8cnURmENGVAAa3HZPYDtwm0kD7cRrRMZUOx9EJPitjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767621976; c=relaxed/simple;
	bh=xJOzuTIDhb3ygQMz8WU+0FFNxToIYJ1BxatmXhMwAk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W996xpdM5/fv5p0hsDOLDBO7AxAqj/f3kyhBphuR3x3or0jcW5b+rEomy/tS5MOJDANHrQ7+eUxfq0wkCSzQiBPKc/7nLNHcQofzNRhNsbjqPupCs85UBhQjZgaY6qQgzm7iMaKeruiuWXULrBXWKkhz5hroErf0QiI5WM7nrDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3LERSk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6721C16AAE;
	Mon,  5 Jan 2026 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767621976;
	bh=xJOzuTIDhb3ygQMz8WU+0FFNxToIYJ1BxatmXhMwAk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3LERSk/OnKlWLjK/upbuEp/8JvvaPv+RLnIe2pQlPTMr13d5ZzcCG8H5gmvPZ1dj
	 1TCoXHEZIsUFeuyMk1lLKkV2qhviJiSU8n+2HoHkLrF1pIHqg1VFGpr2K/JWnwXsh4
	 jjz4sQ8YDkOlXXkibJ2XDU4e3vt4pIIBHeInCAcLCueQH876gHFhUYL7gNTtK204B5
	 IShtseoPUKHorpMMz4x0VTf8XaJPa+u/kU4GhwM6yANgFQxVCPgny04wic6OAXBcRu
	 PRcEPcCb7DTQB4Pwn/IZsbmahrz3T5EcmlKmVffnxzwq7BcwfVoHBYmri9dM0lLta9
	 BRQwp8whSFWFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Olivier Moysan <olivier.moysan@st.com>,
	olivier moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ASoC: stm32: sai: fix clk prepare imbalance on probe failure
Date: Mon,  5 Jan 2026 09:06:13 -0500
Message-ID: <20260105140613.2598547-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105140613.2598547-1-sashal@kernel.org>
References: <2026010531-parole-sharpie-8fc0@gregkh>
 <20260105140613.2598547-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index a740ee6a3ca7..3eab8480a081 100644
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
 
 static int stm32_sai_sub_remove(struct platform_device *pdev)
-- 
2.51.0


