Return-Path: <stable+bounces-196675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2004AC7FFCD
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 11:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D793A8163
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 10:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5432F9DA0;
	Mon, 24 Nov 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZK5ATOf4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2145B27702D;
	Mon, 24 Nov 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981368; cv=none; b=eR9OFP1z0wMsBFDGHja+5AMDCqZXE8ZTnoV66v0tnuif7neKmzam+R/nmSJyO2Ls1TSA7QUUmIJ56ahGW6udtVO0WIhimYCY9fwHlOiuE5X/ZCXZpAZ4N/XrtR+dW0UfTd3lnAnSU1C4FcrThTXyS+rCAXiX4poqC5V4XHmGYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981368; c=relaxed/simple;
	bh=5iSe2rv+mleqW+6rQz8jqeld4WFOCbzH4sbioHRhi8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApvtugieJUyOl/dSFl7oD50goGSuI1aYeG5FfQ2oT7sV+eRlah2KuUUZHtD4IFC+106FcDrkwDnq8pwb/uDGK7GcMVpGZhkc9N4FvqMwtSRhuYJZ4+isoGCx/MArDZ4+mVwWO8MSELVbF60uYBzNxKx0oKMyp2KpJj2vNkd5Qwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZK5ATOf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE988C19424;
	Mon, 24 Nov 2025 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763981368;
	bh=5iSe2rv+mleqW+6rQz8jqeld4WFOCbzH4sbioHRhi8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZK5ATOf4yawGCL9nxPY6SfowDcnHOh3/6szfxbC7j/ZUP3i2U0RBiYxmUrhMA+CQd
	 j3UJD4eU+WO0qU26V5yw6Oc4KeFFys+T8CIsQ1ZSJq8G/kz80Uay8jDH8s6kZYQnlM
	 wEAfSqbrf3wqOnX8kSx89Qcb1rjMlYOdgK75Mtrwmel7SJ6uZEbo4/h1rzKY4Mdp4t
	 65ODLHnLgnyk+4Izoyz/M5lwTz9NfD2Pl2tf36XW2OPDM5RSk2Oup+fMAyZ33c8GUP
	 LPS1ldbel0vSfw8HRfmlhLkhGPgqpz4AopY3zri5bfnL6v+nXPNhXPjsqRXA6fVVGO
	 mx+0+i3vPBOiA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vNU8N-0000000046j-1tep;
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
	Olivier Moysan <olivier.moysan@st.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ASoC: stm32: sai: fix OF node leak on probe
Date: Mon, 24 Nov 2025 11:49:07 +0100
Message-ID: <20251124104908.15754-4-johan@kernel.org>
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
---
 sound/soc/stm/stm32_sai.c     | 12 +++---------
 sound/soc/stm/stm32_sai_sub.c | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 7065aeb0e524..00cf24ceca2d 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -138,7 +138,6 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!pdev) {
 		dev_err(&sai_client->pdev->dev,
 			"Device not found for node %pOFn\n", np_provider);
-		of_node_put(np_provider);
 		return -ENODEV;
 	}
 
@@ -147,21 +146,16 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
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
 
 static int stm32_sai_get_parent_clk(struct stm32_sai_data *sai)
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 7a005b4ad304..5ae4d2577f28 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1586,7 +1586,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 				dev_err(&pdev->dev,
 					"External synchro not supported\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 			sai->sync = SAI_SYNC_EXTERNAL;
 
@@ -1595,7 +1596,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			    (sai->synci > (SAI_GCR_SYNCIN_MAX + 1))) {
 				dev_err(&pdev->dev, "Wrong SAI index\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 
 			if (of_property_match_string(args.np, "compatible",
@@ -1609,7 +1611,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			if (!sai->synco) {
 				dev_err(&pdev->dev, "Unknown SAI sub-block\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 		}
 
@@ -1619,13 +1622,15 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
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
@@ -1647,6 +1652,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 err_unprepare_pclk:
 	clk_unprepare(sai->pdata->pclk);
+err_put_sync_provider:
+	of_node_put(sai->np_sync_provider);
 
 	return ret;
 }
@@ -1720,6 +1727,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 err_unprepare_pclk:
 	clk_unprepare(sai->pdata->pclk);
+	of_node_put(sai->np_sync_provider);
 
 	return ret;
 }
@@ -1732,6 +1740,7 @@ static void stm32_sai_sub_remove(struct platform_device *pdev)
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	of_node_put(sai->np_sync_provider);
 }
 
 static int stm32_sai_sub_suspend(struct device *dev)
-- 
2.51.2


