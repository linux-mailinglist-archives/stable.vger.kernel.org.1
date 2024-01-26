Return-Path: <stable+bounces-15942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCCD83E4DC
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4951C23506
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379BA41C99;
	Fri, 26 Jan 2024 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q+XKnMdn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED450A8E
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307062; cv=none; b=AInBHfMrisQah2GbmzDzUmq3702FZus+rfb2Pm6iw7F0fPD/hukHCvUkoVwoxt9G3eSVsINjz27RxMNVJy6zlLbWo8iyZk7G/lpCKEfBs6Uz48GKFHhi6hl38VvX9oD3LN57iynqfeXMQQPWxHhvmSkxO1CpUo7L0SM/1QdgN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307062; c=relaxed/simple;
	bh=b5OaXxR+/6XQgN8iFKRSVKHAKWuBqLc5Jcg26vhQ7m8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=APdzf582KrNRqeBDbIWVOU+8F5BT9v2zH/nEN05YK/8Z8ra0Gqoh+HHFKlq3RVnrkBx8OIwzdfi11EVR5T0wiO2LoTMCPD50V30EOeZ7hexQqGhoFZWgMbXpBb8byPWBdDvtbmGM7Rqlai65pBQeyjvMfb6gX9VnwYsMz0K7C/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q+XKnMdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6135CC433F1;
	Fri, 26 Jan 2024 22:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706307061;
	bh=b5OaXxR+/6XQgN8iFKRSVKHAKWuBqLc5Jcg26vhQ7m8=;
	h=Subject:To:Cc:From:Date:From;
	b=Q+XKnMdn7VS3Q/KD91sQH6zPe3jRdvHuP0TL/EEQlA+BW0amRKkhMEBgDGAMFtxR2
	 gn+2B9fgMZtRWdVIMfoSI3Hjb19QYCRMBVUkRdRRjxue1uXhAY5IpvOfzFUw+CEjvz
	 iZ627YWT9o5nQ9UWpW6U5/dYm64fASxAAl2ZjqSw=
Subject: FAILED: patch "[PATCH] media: imx355: Enable runtime PM before registering async" failed to apply to 5.10-stable tree
To: bingbu.cao@intel.com,hverkuil-cisco@xs4all.nl,sakari.ailus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:11:00 -0800
Message-ID: <2024012600-slain-sloping-b06b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x efa5fe19c0a9199f49e36e1f5242ed5c88da617d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012600-slain-sloping-b06b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

efa5fe19c0a9 ("media: imx355: Enable runtime PM before registering async sub-device")
15786f7b564e ("media: v4l: fwnode: Rename v4l2_async_register_subdev_sensor_common")
9746b11715c3 ("media: i2c: Add imx334 camera sensor driver")
41b3e23376e9 ("media: dt-bindings: media: Add bindings for imx334")
3e90e5ad9497 ("media: Clarify v4l2-async subdevice addition API")
11c0d8fdccc5 ("media: i2c: Add support for the OV8865 image sensor")
e43ccb0a045f ("media: i2c: Add support for the OV5648 image sensor")
b24cc2a18c50 ("media: smiapp: Rename as "ccs"")
161cc847370a ("media: smiapp: Internal rename to CCS")
47ff2ff267ee ("media: smiapp: Rename register access functions")
235ac9a4b36c ("media: smiapp: Remove quirk function for writing a single 8-bit register")
42aab58f456a ("media: smiapp: Use CCS registers")
3e158e1f1ec2 ("media: smiapp: Switch to CCS limits")
ca296a11156a ("media: smiapp: Read CCS limit values")
503a88422fb0 ("media: smiapp: Use MIPI CCS version and manufacturer ID information")
e66a7c849086 ("media: smiapp: Add macros for accessing CCS registers")
cb50351be662 ("media: smiapp: Remove macros for defining registers, merge definitions")
ab47d5cd8253 ("media: smiapp: Calculate CCS limit offsets and limit buffer size")
82731a194fc1 ("media: smiapp: Use CCS register flags")
6493c4b777c2 ("media: smiapp: Import CCS definitions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From efa5fe19c0a9199f49e36e1f5242ed5c88da617d Mon Sep 17 00:00:00 2001
From: Bingbu Cao <bingbu.cao@intel.com>
Date: Wed, 22 Nov 2023 17:46:06 +0800
Subject: [PATCH] media: imx355: Enable runtime PM before registering async
 sub-device

As the sensor device maybe accessible right after its async sub-device is
registered, such as ipu-bridge will try to power up sensor by sensor's
client device's runtime PM from the async notifier callback, if runtime PM
is not enabled, it will fail.

So runtime PM should be ready before its async sub-device is registered
and accessible by others.

Fixes: df0b5c4a7ddd ("media: add imx355 camera sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

diff --git a/drivers/media/i2c/imx355.c b/drivers/media/i2c/imx355.c
index e1b1d2fc79dd..8c995c58743a 100644
--- a/drivers/media/i2c/imx355.c
+++ b/drivers/media/i2c/imx355.c
@@ -1747,10 +1747,6 @@ static int imx355_probe(struct i2c_client *client)
 		goto error_handler_free;
 	}
 
-	ret = v4l2_async_register_subdev_sensor(&imx355->sd);
-	if (ret < 0)
-		goto error_media_entity;
-
 	/*
 	 * Device is already turned on by i2c-core with ACPI domain PM.
 	 * Enable runtime PM and turn off the device.
@@ -1759,9 +1755,15 @@ static int imx355_probe(struct i2c_client *client)
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
+	ret = v4l2_async_register_subdev_sensor(&imx355->sd);
+	if (ret < 0)
+		goto error_media_entity_runtime_pm;
+
 	return 0;
 
-error_media_entity:
+error_media_entity_runtime_pm:
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&imx355->sd.entity);
 
 error_handler_free:


