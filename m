Return-Path: <stable+bounces-204595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8ACF2B7B
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7989D30021F6
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175131354A;
	Mon,  5 Jan 2026 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SeYganJR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26128226CF7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605083; cv=none; b=JDWUUN/97GXs9K9a9xsoiA1hWnvzr/EtwH/ZoElwSy5fqvDHs5sDySqvuYQwOKtYO1KwnTqIan2q7pe/feoHvX1lssIj7pyS56eVJmRPuqC0wGsbIzh/iT85Iey0Ae2bEgxNTOva2l+rOyvxmSZgyb+5eIfEAbPkwULSoHAamB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605083; c=relaxed/simple;
	bh=02g3o3JQ7YbyrKaSRWcE078teyRI5cIaL310QHRyMFM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZJfWmBLZHLVWlKypnh4CD2K9q+dYWvNfGtCX71mSZjcAjjqUOiWueeEyrcOCzFKGJDEVKlscZXeCFFXziD4iohSIkLo5UejJ1Vhop9fFLnjjKPxl4g8gpB7PYJsvqr4vo/2yqp+8A9PtJ9Ck6slX8XxmAd8OYcyixNU40+pCw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SeYganJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C881C116D0;
	Mon,  5 Jan 2026 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605082;
	bh=02g3o3JQ7YbyrKaSRWcE078teyRI5cIaL310QHRyMFM=;
	h=Subject:To:Cc:From:Date:From;
	b=SeYganJRxAAgikI5Tst3hg4ZeX8g0ed87kn+UBR8L7nob0BScZY/uxTkK1nNj9LZ5
	 phzleZ+4PpOG3E9Gh+pF6rVpgDt1RbDJ//INZufhbGWZUr2QgnDcnMPeaan48+jT8+
	 suAv99KW1F0lyO4XBpfJSp5DOOlg17bdoiWZBfBs=
Subject: FAILED: patch "[PATCH] ASoC: stm32: sai: fix clk prepare imbalance on probe failure" failed to apply to 5.15-stable tree
To: johan@kernel.org,broonie@kernel.org,olivier.moysan@foss.st.com,olivier.moysan@st.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:24:31 +0100
Message-ID: <2026010531-vendor-unissued-6b5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 312ec2f0d9d1a5656f76d770bbf1d967e9289aa7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010531-vendor-unissued-6b5a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 312ec2f0d9d1a5656f76d770bbf1d967e9289aa7 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 24 Nov 2025 11:49:06 +0100
Subject: [PATCH] ASoC: stm32: sai: fix clk prepare imbalance on probe failure

Make sure to unprepare the parent clock also on probe failures (e.g.
probe deferral).

Fixes: a14bf98c045b ("ASoC: stm32: sai: fix possible circular locking")
Cc: stable@vger.kernel.org	# 5.5
Cc: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: olivier moysan <olivier.moysan@foss.st.com>
Link: https://patch.msgid.link/20251124104908.15754-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

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


