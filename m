Return-Path: <stable+bounces-204834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 609DFCF4537
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FF6C3044346
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB8309EF0;
	Mon,  5 Jan 2026 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiD1HzHH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D53093CB
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625841; cv=none; b=Kldpjn7BRb37wxPMhWdq8ZV0vydp2Z6Lkai7uGdXK6k6cBOIRulD/FZoRMLYbKCv9Whun2caPjYRbRh+6POVb6qW+szwMrmDj9YIPuaWuLjJiZn1RHbrQpiUFgy1lbimdmyhHnJ3LuD+jfvsGzx+olAE68TVOrigkOlsvpj8vu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625841; c=relaxed/simple;
	bh=gAM/FGIj8VpBhknBnC4tjr82Uivszjuw+2g9uiCHm5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUVCVKKNnzc8SQP1wKmQdJKooDCP3p5yw5o/n0RLXIBYaJ72qyho2UHdd7fdNt7rZ53LDgSviZxTgbGiY6jPZCnin7Uzkix6WJ+DxlQkBE+3gjC8QRsXF3l+BZ3GGU6fzQ8npyxOWGMzqaFoUfM3Aqqb4wTIaZNGTPrb06OCtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiD1HzHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6D6C19425;
	Mon,  5 Jan 2026 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767625840;
	bh=gAM/FGIj8VpBhknBnC4tjr82Uivszjuw+2g9uiCHm5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oiD1HzHHEMtmPliDl3PmrDumZXVbHFW3LMvYZmsZYMPprVMB8ngu+6Kqy/FY5/aYE
	 kQWePbHPVu2Ml/PWk8QQ5e295hW8evoGEdo+fpa8plE7nhpyTWZZ1eF12S8RX8oT40
	 3r6OewReKaTzzA5SOgudt1I0gn+85V4vegSKSR4xE70vhRAYbT0g533Z11o5ebLL6x
	 AMm8TdQgeQXAyzrmbZ8C9nCclrnpuRsHf6CxyNer+KLYDk4HknPUIqSypmnV4Wvb6+
	 5EhMZDA7NJHjIZMjQM82bb3aK98PLMOm6+j9q8sOVjxPqy/VbVsXzWJ62VtQm3Ns0s
	 hPdbSr23vuTmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Olivier Moysan <olivier.moysan@st.com>,
	olivier moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] ASoC: stm32: sai: fix OF node leak on probe
Date: Mon,  5 Jan 2026 10:10:33 -0500
Message-ID: <20260105151034.2625317-6-sashal@kernel.org>
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

[ Upstream commit 23261f0de09427367e99f39f588e31e2856a690e ]

The reference taken to the sync provider OF node when probing the
platform device is currently only dropped if the set_sync() callback
fails during DAI probe.

Make sure to drop the reference on platform probe failures (e.g. probe
deferral) and on driver unbind.

This also avoids a potential use-after-free in case the DAI is ever
reprobed without first rebinding the platform driver.

Fixes: 5914d285f6b7 ("ASoC: stm32: sai: Add synchronization support")
Fixes: d4180b4c02e7 ("ASoC: stm32: sai: fix set_sync service")
Cc: Olivier Moysan <olivier.moysan@st.com>
Cc: stable@vger.kernel.org      # 4.16: d4180b4c02e7
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: olivier moysan <olivier.moysan@foss.st.com>
Link: https://patch.msgid.link/20251124104908.15754-4-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai.c     | 12 +++---------
 sound/soc/stm/stm32_sai_sub.c | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index df167c389b98..026321620a20 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -122,7 +122,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
 			"Device not found for node %pOFn\n", np_provider);
-		of_node_put(np_provider);
 		return -ENODEV;
 	}
 
@@ -131,21 +130,16 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!sai_provider) {
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
-		ret = -EINVAL;
-		goto error;
+		return -EINVAL;
 	}
 
 	/* Configure sync client */
 	ret = stm32_sai_sync_conf_client(sai_client, synci);
 	if (ret < 0)
-		goto error;
+		return ret;
 
 	/* Configure sync provider */
-	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
-
-error:
-	of_node_put(np_provider);
-	return ret;
+	return stm32_sai_sync_conf_provider(sai_provider, synco);
 }
 
 static int stm32_sai_probe(struct platform_device *pdev)
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 6ae1c15f3439..c7930d8f9ded 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1436,7 +1436,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 				dev_err(&pdev->dev,
 					"External synchro not supported\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 			sai->sync = SAI_SYNC_EXTERNAL;
 
@@ -1445,7 +1446,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			    (sai->synci > (SAI_GCR_SYNCIN_MAX + 1))) {
 				dev_err(&pdev->dev, "Wrong SAI index\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 
 			if (of_property_match_string(args.np, "compatible",
@@ -1459,7 +1461,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			if (!sai->synco) {
 				dev_err(&pdev->dev, "Unknown SAI sub-block\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 		}
 
@@ -1469,13 +1472,15 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 	of_node_put(args.np);
 	sai->sai_ck = devm_clk_get(&pdev->dev, "sai_ck");
-	if (IS_ERR(sai->sai_ck))
-		return dev_err_probe(&pdev->dev, PTR_ERR(sai->sai_ck),
-				     "Missing kernel clock sai_ck\n");
+	if (IS_ERR(sai->sai_ck)) {
+		ret = dev_err_probe(&pdev->dev, PTR_ERR(sai->sai_ck),
+				    "Missing kernel clock sai_ck\n");
+		goto err_put_sync_provider;
+	}
 
 	ret = clk_prepare(sai->pdata->pclk);
 	if (ret < 0)
-		return ret;
+		goto err_put_sync_provider;
 
 	if (STM_SAI_IS_F4(sai->pdata))
 		return 0;
@@ -1497,6 +1502,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 err_unprepare_pclk:
 	clk_unprepare(sai->pdata->pclk);
+err_put_sync_provider:
+	of_node_put(sai->np_sync_provider);
 
 	return ret;
 }
@@ -1567,6 +1574,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 err_unprepare_pclk:
 	clk_unprepare(sai->pdata->pclk);
+	of_node_put(sai->np_sync_provider);
 
 	return ret;
 }
@@ -1579,6 +1587,7 @@ static void stm32_sai_sub_remove(struct platform_device *pdev)
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	of_node_put(sai->np_sync_provider);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0


