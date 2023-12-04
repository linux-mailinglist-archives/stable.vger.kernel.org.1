Return-Path: <stable+bounces-3851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A4803032
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 11:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129761F21105
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D520B37;
	Mon,  4 Dec 2023 10:25:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD419B4
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 02:25:15 -0800 (PST)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rA68X-00AMuA-Bn; Mon, 04 Dec 2023 10:25:13 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 04 Dec 2023 10:21:46 +0000
Subject: [git:media_stage/master] media: ov13b10: Enable runtime PM before registering async sub-device
To: linuxtv-commits@linuxtv.org
Cc: stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, Bingbu Cao <bingbu.cao@intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rA68X-00AMuA-Bn@www.linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ov13b10: Enable runtime PM before registering async sub-device
Author:  Bingbu Cao <bingbu.cao@intel.com>
Date:    Wed Nov 22 17:46:08 2023 +0800

As the sensor device maybe accessible right after its async sub-device is
registered, such as ipu-bridge will try to power up sensor by sensor's
client device's runtime PM from the async notifier callback, if runtime PM
is not enabled, it will fail.

So runtime PM should be ready before its async sub-device is registered
and accessible by others.

Fixes: 7ee850546822 ("media: Add sensor driver support for the ov13b10 camera.")
Cc: stable@vger.kernel.org
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/ov13b10.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

---

diff --git a/drivers/media/i2c/ov13b10.c b/drivers/media/i2c/ov13b10.c
index c06411d5ee2b..73c844aa5697 100644
--- a/drivers/media/i2c/ov13b10.c
+++ b/drivers/media/i2c/ov13b10.c
@@ -1554,24 +1554,27 @@ static int ov13b10_probe(struct i2c_client *client)
 		goto error_handler_free;
 	}
 
-	ret = v4l2_async_register_subdev_sensor(&ov13b->sd);
-	if (ret < 0)
-		goto error_media_entity;
 
 	/*
 	 * Device is already turned on by i2c-core with ACPI domain PM.
 	 * Enable runtime PM and turn off the device.
 	 */
-
 	/* Set the device's state to active if it's in D0 state. */
 	if (full_power)
 		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
+	ret = v4l2_async_register_subdev_sensor(&ov13b->sd);
+	if (ret < 0)
+		goto error_media_entity_runtime_pm;
+
 	return 0;
 
-error_media_entity:
+error_media_entity_runtime_pm:
+	pm_runtime_disable(&client->dev);
+	if (full_power)
+		pm_runtime_set_suspended(&client->dev);
 	media_entity_cleanup(&ov13b->sd.entity);
 
 error_handler_free:
@@ -1594,6 +1597,7 @@ static void ov13b10_remove(struct i2c_client *client)
 	ov13b10_free_controls(ov13b);
 
 	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(ov13b10_pm_ops, ov13b10_suspend,

