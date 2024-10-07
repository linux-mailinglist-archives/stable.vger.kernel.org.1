Return-Path: <stable+bounces-81375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C49933D0
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD281C23B77
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C83B1DBB3C;
	Mon,  7 Oct 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kfr7JBaj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6661DBB3A
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319718; cv=none; b=e6OwBEty1AtW5f2fTr5NkcHDIf3/4BPHK9kR9fu4SoKbs3KnXGQfNGO3jvp2Jm4uVC7BsiUqgds2w/qDdFew6d6pgi3RaovMQoWEWmnQT/BaPsK8oaekhHvgNpJRHbBMzKZ5DMdra14tT3Y7ffa5W/pm3Z6HKwmHyPJy1KXu2ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319718; c=relaxed/simple;
	bh=kiSqRR/52qAQWuZUuh/u3/gwdSdjCx+NHVn0gAJu9hU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V3uxZXE2hl+4AAZwTVeNiLArAhoYoCsSFUe28YqICJMXfMN6SybCf/j3diVxFNfuxwURmYgGHBkih+epEokvLBIC3is0ijsQuLxlx+9ovVX/gvLdNxO3Ko+eR4SmPsTXBUeNxb3ueagtIKXEL19qfuNA0A04RqMpLigZyfY3P6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kfr7JBaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572B4C4CECC;
	Mon,  7 Oct 2024 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319717;
	bh=kiSqRR/52qAQWuZUuh/u3/gwdSdjCx+NHVn0gAJu9hU=;
	h=Subject:To:Cc:From:Date:From;
	b=kfr7JBajo0Law6/IS7e+br6wdVcvPrGaw2MnQqNzA1JsTT8yJu52foMADAE9/xGhc
	 ot4TUUgP/QgfhUfQx2fQzC2MQN1usgbjUWELnuPTfOmpQPLyZyUi2lmAkt8qKesUfG
	 W0NBfeqeGUFGE06APRpFSqm0mdBOpWwcmBBYCuUI=
Subject: FAILED: patch "[PATCH] media: imx335: Fix reset-gpio handling" failed to apply to 6.1-stable tree
To: umang.jain@ideasonboard.com,hverkuil-cisco@xs4all.nl,laurent.pinchart@ideasonboard.com,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:48:26 +0200
Message-ID: <2024100726-joylessly-clammy-2b47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 99d30e2fdea4086be4e66e2deb10de854b547ab8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100726-joylessly-clammy-2b47@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

99d30e2fdea4 ("media: imx335: Fix reset-gpio handling")
fea91ee73b7c ("media: i2c: imx335: Enable regulator supplies")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 99d30e2fdea4086be4e66e2deb10de854b547ab8 Mon Sep 17 00:00:00 2001
From: Umang Jain <umang.jain@ideasonboard.com>
Date: Fri, 30 Aug 2024 11:41:52 +0530
Subject: [PATCH] media: imx335: Fix reset-gpio handling

Rectify the logical value of reset-gpio so that it is set to
0 (disabled) during power-on and to 1 (enabled) during power-off.

Set the reset-gpio to GPIO_OUT_HIGH at initialization time to make
sure it starts off in reset. Also drop the "Set XCLR" comment which
is not-so-informative.

The existing usage of imx335 had reset-gpios polarity inverted
(GPIO_ACTIVE_HIGH) in their device-tree sources. With this patch
included, those DTS will not be able to stream imx335 anymore. The
reset-gpio polarity will need to be rectified in the device-tree
sources as shown in [1] example, in order to get imx335 functional
again (as it remains in reset prior to this fix).

Cc: stable@vger.kernel.org
Fixes: 45d19b5fb9ae ("media: i2c: Add imx335 camera sensor driver")
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/linux-media/20240729110437.199428-1-umang.jain@ideasonboard.com/
Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 990d74214cc2..54a1de53d497 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -997,7 +997,7 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
 
 	/* Request optional reset pin */
 	imx335->reset_gpio = devm_gpiod_get_optional(imx335->dev, "reset",
-						     GPIOD_OUT_LOW);
+						     GPIOD_OUT_HIGH);
 	if (IS_ERR(imx335->reset_gpio)) {
 		dev_err(imx335->dev, "failed to get reset gpio %ld\n",
 			PTR_ERR(imx335->reset_gpio));
@@ -1110,8 +1110,7 @@ static int imx335_power_on(struct device *dev)
 
 	usleep_range(500, 550); /* Tlow */
 
-	/* Set XCLR */
-	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
+	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
 
 	ret = clk_prepare_enable(imx335->inclk);
 	if (ret) {
@@ -1124,7 +1123,7 @@ static int imx335_power_on(struct device *dev)
 	return 0;
 
 error_reset:
-	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
+	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(imx335_supply_name), imx335->supplies);
 
 	return ret;
@@ -1141,7 +1140,7 @@ static int imx335_power_off(struct device *dev)
 	struct v4l2_subdev *sd = dev_get_drvdata(dev);
 	struct imx335 *imx335 = to_imx335(sd);
 
-	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
+	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
 	clk_disable_unprepare(imx335->inclk);
 	regulator_bulk_disable(ARRAY_SIZE(imx335_supply_name), imx335->supplies);
 


