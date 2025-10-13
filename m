Return-Path: <stable+bounces-185495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7E1BD5BC7
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 088A535152E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472E52D660D;
	Mon, 13 Oct 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryV3xuEf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D92D661E
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380479; cv=none; b=aBTZM6QuY820IMt5wgUcgWtkIy0S+YRuPTgGTuF2Ag0lzHzlCrPfcN9aEV/MBXLeOyb+SaE7hgMNLGKI/SVAZ4D6JwWION14KQMIEuD+OKqEGfUY0Ag0nk6WdKsUyFjxOpWW8D84cTW/e8y/fNrUyjwStgwjtWM6lGWXH7gOMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380479; c=relaxed/simple;
	bh=WTM/FQgxEG1I5K323vlTnSlhxm3VYWR1N5oNaTp8M60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDwJrIzG9eo46TgWs/P/wqyB0n+JjZqbMXEU2j3aqTrKNcwyN/ofGyTnNf3LRNpmrppsONyvUXmSw3kF5TO8RMDmkhRA5QdJtwmI2W2eLaH8NaDfvr9dPZ2HT4QHtuLfMRyJOD8jdVE2dyE7qPHIMYdh8YA4ivfhGbNlVhV0D/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryV3xuEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025C5C116C6;
	Mon, 13 Oct 2025 18:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380478;
	bh=WTM/FQgxEG1I5K323vlTnSlhxm3VYWR1N5oNaTp8M60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ryV3xuEf7PwcWn2scps22Sl14ZAUzdTYtxu9q6XtyU0xBoWQkVL5f5dijUKIIFEsu
	 +Qk60S5WliwrVu/hgz8TcULCchhyWEBfV+W4wCX52DaM1JYBX04TzuTBkj4R2BtY3K
	 lXQN//KCONSqmhx8fmKUkyNeTQUSlxXMqtQsj47je9AzCB+DKHiHcWizz3l5N3VYL1
	 MinLFsWaTHS18GPbj2aT1C9gbKuMqjf+14oqgwtyWzlkw8a7i3Ztk5YaUE8+HcXp0F
	 ta0MTWOdFoEv1b9ToJKzG4tnPf87VvZ8ZZKni7JFdhfxL8kNz8pcCQnjxJemdAlDtK
	 oCIe7XeNQ1DVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()
Date: Mon, 13 Oct 2025 14:34:34 -0400
Message-ID: <20251013183434.3507752-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013183434.3507752-1-sashal@kernel.org>
References: <2025101303-agency-job-17ce@gregkh>
 <20251013183434.3507752-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ma Ke <make24@iscas.ac.cn>

[ Upstream commit 4e65bda8273c938039403144730923e77916a3d7 ]

wcd934x_codec_parse_data() contains a device reference count leak in
of_slim_get_device() where device_find_child() increases the reference
count of the device but this reference is not properly decreased in
the success path. Add put_device() in wcd934x_codec_parse_data() and
add devm_add_action_or_reset() in the probe function, which ensures
that the reference count of the device is correctly managed.

Memory leak in regmap_init_slimbus() as the allocated regmap is not
released when the device is removed. Using devm_regmap_init_slimbus()
instead of regmap_init_slimbus() to ensure automatic regmap cleanup on
device removal.

Calling path: of_slim_get_device() -> of_find_slim_device() ->
device_find_child(). As comment of device_find_child() says, 'NOTE:
you will need to drop the reference with put_device() after use.'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://patch.msgid.link/20250923065212.26660-1-make24@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 8670c2512b8a4..90fb774e59866 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5862,6 +5862,13 @@ static const struct snd_soc_component_driver wcd934x_component_drv = {
 	.endianness = 1,
 };
 
+static void wcd934x_put_device_action(void *data)
+{
+	struct device *dev = data;
+
+	put_device(dev);
+}
+
 static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 {
 	struct device *dev = &wcd->sdev->dev;
@@ -5882,11 +5889,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 	}
 
 	slim_get_logical_addr(wcd->sidev);
-	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
+	wcd->if_regmap = devm_regmap_init_slimbus(wcd->sidev,
 				  &wcd934x_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap))
+	if (IS_ERR(wcd->if_regmap)) {
+		put_device(&wcd->sidev->dev);
 		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
 				     "Failed to allocate ifc register map\n");
+	}
 
 	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
 			     &wcd->dmic_sample_rate);
@@ -5930,6 +5939,10 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(dev, wcd934x_put_device_action, &wcd->sidev->dev);
+	if (ret)
+		return ret;
+
 	/* set default rate 9P6MHz */
 	regmap_update_bits(wcd->regmap, WCD934X_CODEC_RPM_CLK_MCLK_CFG,
 			   WCD934X_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
-- 
2.51.0


