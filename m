Return-Path: <stable+bounces-204821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (unknown [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF22CF449B
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63877316C726
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 14:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E71C3BF7;
	Mon,  5 Jan 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9pY3BE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C83FF1
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767624701; cv=none; b=hSU2T+pE2p3fl7f+oZfGu4vob8u6G/kJ2EUggGRDxMKI2p2KdDulAxUxnWcA27Lf6krU8qlSmQtDFqWxEjQKPUw2+uR/vVkEvvxb07I6cUGXF2cYvSNE0FUScOX2FXIhQsbEzHgDiQxK6Dnj3dbfyBmMzEf+nEo4nC7HcrjhG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767624701; c=relaxed/simple;
	bh=P8JkFbA4nt1c8blMeUls6YtBj5/r/IQHPN3CrjAROYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B39XIcQkdbYOuTgKsXLnTP3wcNnZ50pVx6HVSSyTOE9xYgyE0SdVObmzx3KhsNCwR7Sh7NTWhVokBU9QByOzmU7fK42ylBySdsKorLLQPorkNurPVlHGsX/CndLX9dEReWMKCmwU9gjdhgpcARcQ6XKyP9b6fs5q+CSk3uOZyd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9pY3BE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6114FC19421;
	Mon,  5 Jan 2026 14:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767624701;
	bh=P8JkFbA4nt1c8blMeUls6YtBj5/r/IQHPN3CrjAROYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9pY3BE+MM3yg7p6rNFRRdQcjrVWBEilujujaIuFnZZ/myX413XniR6klcTKNdxjr
	 MGX4bFWyHDnClAFtNYRLh38K8K5L2r/MjvYSU9n8/nkFJaTTh8JMmFP1DDsX+XfKEt
	 LcUNc7FFGGazpgwF1djS+p4OMifVWeLx2jo5zH4gx/Nk88eMRoqUK9FCZnDWELOu8d
	 ICpYW2ajk0RaHqpa3iuQDjGQbXOkccJd3oim+DUvw0eB9r4L39SdJCCSg6dA0O0dTq
	 NsAgZViGFM0KHDp88n6LkSiuxHYLYAZNjURx60+oOjeOVUAV7rz/jZfAKJH/+DW2n0
	 nCQRxZrJN6tiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Olivier Moysan <olivier.moysan@st.com>,
	olivier moysan <olivier.moysan@foss.st.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] ASoC: stm32: sai: fix OF node leak on probe
Date: Mon,  5 Jan 2026 09:51:35 -0500
Message-ID: <20260105145135.2613585-5-sashal@kernel.org>
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
index c302d4de2a88..8653be3c206e 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -1435,7 +1435,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 				dev_err(&pdev->dev,
 					"External synchro not supported\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 			sai->sync = SAI_SYNC_EXTERNAL;
 
@@ -1444,7 +1445,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			    (sai->synci > (SAI_GCR_SYNCIN_MAX + 1))) {
 				dev_err(&pdev->dev, "Wrong SAI index\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 
 			if (of_property_match_string(args.np, "compatible",
@@ -1458,7 +1460,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			if (!sai->synco) {
 				dev_err(&pdev->dev, "Unknown SAI sub-block\n");
 				of_node_put(args.np);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto err_put_sync_provider;
 			}
 		}
 
@@ -1468,13 +1471,15 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
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
@@ -1496,6 +1501,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 
 err_unprepare_pclk:
 	clk_unprepare(sai->pdata->pclk);
+err_put_sync_provider:
+	of_node_put(sai->np_sync_provider);
 
 	return ret;
 }
@@ -1566,6 +1573,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 err_unprepare_pclk:
 	clk_unprepare(sai->pdata->pclk);
+	of_node_put(sai->np_sync_provider);
 
 	return ret;
 }
@@ -1578,6 +1586,7 @@ static void stm32_sai_sub_remove(struct platform_device *pdev)
 	snd_dmaengine_pcm_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	of_node_put(sai->np_sync_provider);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0


