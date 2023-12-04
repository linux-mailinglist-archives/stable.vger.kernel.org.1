Return-Path: <stable+bounces-3854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5236803036
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 11:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDE91F210EC
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 10:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4FE219E1;
	Mon,  4 Dec 2023 10:25:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2A119B7
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 02:25:15 -0800 (PST)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rA68X-00AMud-KQ; Mon, 04 Dec 2023 10:25:13 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 04 Dec 2023 10:21:46 +0000
Subject: [git:media_stage/master] media: ov01a10: Enable runtime PM before registering async sub-device
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, Bingbu Cao <bingbu.cao@intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rA68X-00AMud-KQ@www.linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: ov01a10: Enable runtime PM before registering async sub-device
Author:  Bingbu Cao <bingbu.cao@intel.com>
Date:    Wed Nov 22 17:46:07 2023 +0800

As the sensor device maybe accessible right after its async sub-device is
registered, such as ipu-bridge will try to power up sensor by sensor's
client device's runtime PM from the async notifier callback, if runtime PM
is not enabled, it will fail.

So runtime PM should be ready before its async sub-device is registered
and accessible by others.

It also sets the runtime PM status to active as the sensor was turned
on by i2c-core.

Fixes: 0827b58dabff ("media: i2c: add ov01a10 image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/i2c/ov01a10.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

---

diff --git a/drivers/media/i2c/ov01a10.c b/drivers/media/i2c/ov01a10.c
index 7cca9294ea31..5606437f37d0 100644
--- a/drivers/media/i2c/ov01a10.c
+++ b/drivers/media/i2c/ov01a10.c
@@ -862,6 +862,7 @@ static void ov01a10_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(sd->ctrl_handler);
 
 	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 }
 
 static int ov01a10_probe(struct i2c_client *client)
@@ -909,17 +910,26 @@ static int ov01a10_probe(struct i2c_client *client)
 		goto err_media_entity_cleanup;
 	}
 
+	/*
+	 * Device is already turned on by i2c-core with ACPI domain PM.
+	 * Enable runtime PM and turn off the device.
+	 */
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_idle(dev);
+
 	ret = v4l2_async_register_subdev_sensor(&ov01a10->sd);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register subdev: %d\n", ret);
-		goto err_media_entity_cleanup;
+		goto err_pm_disable;
 	}
 
-	pm_runtime_enable(dev);
-	pm_runtime_idle(dev);
-
 	return 0;
 
+err_pm_disable:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(&client->dev);
+
 err_media_entity_cleanup:
 	media_entity_cleanup(&ov01a10->sd.entity);
 

