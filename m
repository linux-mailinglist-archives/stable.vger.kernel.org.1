Return-Path: <stable+bounces-185499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3325CBD5F19
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 21:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F199E18A723C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7796C2D97A0;
	Mon, 13 Oct 2025 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnP4fbXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375082472BD
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760383713; cv=none; b=cUUy4NPAfvm5zUT1fHofQrrZ9ARdtT9JtQlr2DanNyyd4aEpJ0vtPQ/63A9LLi1RGTioVU0X2iL7MWE2lYWPJLMMnMD/VQz0GLpkqcpvuOhTp1QxA/1cH75s18vHw41mS/TkFTC/gF9OaiqztSU/YEhAv4nWzME3Iw5RUjdm0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760383713; c=relaxed/simple;
	bh=QHosd+eotXOFw25ylcXziVznlHoMmn5Su5tVUZoDZjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxP9vVbacUhOErxiwkscyBeDQX5tvwgCGDT7lH+1K/ys80MuTvmr0pCchhC86ZrilmGNN1U6JL0J7FVZJDAe/AQkp+NanbyiO0M8udHrjfkQM/G5cREiYU2+SrxllXOH8g61CK8mbsV5ZZaSZwTYyv1TfQdJgdfw4Zc7I0ZsQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnP4fbXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298A6C4CEF8;
	Mon, 13 Oct 2025 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760383712;
	bh=QHosd+eotXOFw25ylcXziVznlHoMmn5Su5tVUZoDZjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnP4fbXmwXQH6pceJx/tkYRDOAGzKFv+3avGVKHEPVNX/O/U8PJzticQ81c5XPoY5
	 5s/agfmZN/6ETqFdUQnnA+SbyPCewol1lS2UuM4Aspe8eVXT0uzkeXW4kD0bSh3PLV
	 oMLKwGrSgZ1Vh8JrkpKmQw4OHKiacGyiWf0TxCHE3sNVF9vkJ1fVUqdYiEDf6xLVet
	 8tCRodtxK0i9+F6hxZHnB7JR8v+4IVKeKXZz7yxd2X7NUgqgcWjGBXZpKgo0F/13Kt
	 TWo7ArZubchwSGKEUTNIlcLUgmKPJzTRV7t1FxEiONf/1yXFvkJvwn2avie7x6jSqH
	 n+qX1fD9sdQug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ma Ke <make24@iscas.ac.cn>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()
Date: Mon, 13 Oct 2025 15:28:29 -0400
Message-ID: <20251013192829.3566355-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013192829.3566355-1-sashal@kernel.org>
References: <2025101305-until-selector-fc19@gregkh>
 <20251013192829.3566355-1-sashal@kernel.org>
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
index 0fcd2b80476f7..440b6a40ba605 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5863,6 +5863,13 @@ static const struct snd_soc_component_driver wcd934x_component_drv = {
 	.set_jack = wcd934x_codec_set_jack,
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
@@ -5883,11 +5890,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
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
@@ -5931,6 +5940,10 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
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


