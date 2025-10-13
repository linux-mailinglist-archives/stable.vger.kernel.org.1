Return-Path: <stable+bounces-184143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB9BD200E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 10:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 239684EDF81
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933CD2EC0B7;
	Mon, 13 Oct 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0L9ejUtK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B162EACF9
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343736; cv=none; b=qDH0VedbMvV8+4uD/7LuBjwWcgsq/BXi0b0IYUAPgoErd8DxjBEOxbr29eQza2iISL7TriO1b5xlXjEwlrG0ipluhN2kvtcnSFzHuEuugxkVc+BRtYYW679NFoNdNpETTmmUkXK48s66R7qK3qdplnMgGI7TL8TsMqyBS5Kh/+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343736; c=relaxed/simple;
	bh=u/6shofEAzL0PVKQrm3uJi+QDl/TaP9cWj2d5wHelAo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kVcsq9rVyCfjcxcryU9ZnuCXMFgctu9bkNoIdhmDzfL1UjCE/wAiMj0s7aJ85pqTJ2EdNAQYoa8n4+yupq8VWM6K2/kUdtJqMcJF/Sp+dyo9I5dh7YXsGOBrUoJVe6y+qPzKCz6FOGOw4IqpBaue9H7doTJLPZp3d9VM5goY25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0L9ejUtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C693C4CEE7;
	Mon, 13 Oct 2025 08:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760343736;
	bh=u/6shofEAzL0PVKQrm3uJi+QDl/TaP9cWj2d5wHelAo=;
	h=Subject:To:Cc:From:Date:From;
	b=0L9ejUtKNjnnNGq9Gx0iMbbfMMHtY6R1OApuFrJD+6sjTmgYAOwU40CCHAg1RsjBn
	 xEenmh2alO4GNXQBNIcgFErpj9koIS/rJ2aFYtRsFmbX5O2WUChRYg7YTOX9Er4lUx
	 D4jZ4sXG/TtGguJC6aF0ZSQ/3s2K+0Od/xkzmZ5s=
Subject: FAILED: patch "[PATCH] ASoC: wcd934x: fix error handling in" failed to apply to 5.15-stable tree
To: make24@iscas.ac.cn,broonie@kernel.org,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Oct 2025 10:22:05 +0200
Message-ID: <2025101305-until-selector-fc19@gregkh>
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
git cherry-pick -x 4e65bda8273c938039403144730923e77916a3d7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101305-until-selector-fc19@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e65bda8273c938039403144730923e77916a3d7 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Tue, 23 Sep 2025 14:52:12 +0800
Subject: [PATCH] ASoC: wcd934x: fix error handling in
 wcd934x_codec_parse_data()

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

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 1bb7e1dc7e6b..e92939068bf7 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5831,6 +5831,13 @@ static const struct snd_soc_component_driver wcd934x_component_drv = {
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
@@ -5847,11 +5854,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 		return dev_err_probe(dev, -EINVAL, "Unable to get SLIM Interface device\n");
 
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
@@ -5893,6 +5902,10 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, wcd934x_put_device_action, &wcd->sidev->dev);
+	if (ret)
+		return ret;
+
 	/* set default rate 9P6MHz */
 	regmap_update_bits(wcd->regmap, WCD934X_CODEC_RPM_CLK_MCLK_CFG,
 			   WCD934X_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,


