Return-Path: <stable+bounces-146299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471A5AC3375
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 11:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE058189674A
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77514A60F;
	Sun, 25 May 2025 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iL4tB/9U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4D3BBF2
	for <stable@vger.kernel.org>; Sun, 25 May 2025 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748165761; cv=none; b=HpJxM0+uaZSIb/rSRy9ewmP1XfV/weL0KHZI6rOlWVVav0FJeHm23qmgDpxEGBkp6s0zyruX3Z9DacF0ZjziulaLIKljQN1J52lQMREL1QZea4PVVS0Bu3lU3Sd+NEt17I7s7nh1+ctYFidmkDCoUBPKtUSrKzBNnIFKL/W/3+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748165761; c=relaxed/simple;
	bh=DLCBOtY0kJvBqHSON87PmV4vR2phH+LjwKxLG+02ur8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=blqrIl5o9ExE5kFbHlU0AP2E7m/ugqHolA6V5xY6y9EYfpvTnwqsnjlcoztz770LNENDdtb9z1DRg3AMSB4GB34L/m8GGH99lV/GGln0Qy7T+v9vTnhHp3ULsjcyO4AdF8Jwaa0dvSxKf3yrYwiW40Hz/xzVTnVZ7lA9NBu/y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iL4tB/9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B314CC4CEEA;
	Sun, 25 May 2025 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748165761;
	bh=DLCBOtY0kJvBqHSON87PmV4vR2phH+LjwKxLG+02ur8=;
	h=Subject:To:Cc:From:Date:From;
	b=iL4tB/9UKv2RzKDLri1k+vvETjll/Lb/cs1BCOg8WF8RtZ/52Ww5u8v3imNcDEqA6
	 V26HBif73fP1Ydlrd2OR2ScGo7ZsEv9X23QWbJ/KagFW7UG1QegbldwYr8MjpMbwvf
	 FR4yywskRPuvrO/9BqScscu0ttbnYL0GeMh3I7dg=
Subject: FAILED: patch "[PATCH] Input: synaptics-rmi - fix crash with unsupported versions of" failed to apply to 5.15-stable tree
To: dmitry.torokhov@gmail.com,hanno@hboeck.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 25 May 2025 11:34:08 +0200
Message-ID: <2025052508-annuity-untapped-8fb8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x ca39500f6af9cfe6823dc5aa8fbaed788d6e35b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052508-annuity-untapped-8fb8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ca39500f6af9cfe6823dc5aa8fbaed788d6e35b2 Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 5 May 2025 15:49:59 -0700
Subject: [PATCH] Input: synaptics-rmi - fix crash with unsupported versions of
 F34
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sysfs interface for updating firmware for RMI devices is available even
when F34 probe fails. The code checks for presence of F34 "container"
pointer and then tries to use the function data attached to the
sub-device. F34 assigns the function data early, before it knows if
probe will succeed, leaving behind a stale pointer.

Fix this by expanding checks to not only test for presence of F34
"container" but also check if there is driver data assigned to the
sub-device, and call dev_set_drvdata() only after we are certain that
probe is successful.

This is not a complete fix, since F34 will be freed during firmware
update, so there is still a race when fetching and accessing this
pointer. This race will be addressed in follow-up changes.

Reported-by: Hanno Böck <hanno@hboeck.de>
Fixes: 29fd0ec2bdbe ("Input: synaptics-rmi4 - add support for F34 device reflash")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/aBlAl6sGulam-Qcx@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index d760af4cc12e..f1947f03b06a 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2016 Zodiac Inflight Innovations
  */
 
+#include "linux/device.h"
 #include <linux/kernel.h>
 #include <linux/rmi.h>
 #include <linux/firmware.h>
@@ -289,39 +290,30 @@ static int rmi_f34_update_firmware(struct f34_data *f34,
 	return rmi_f34_flash_firmware(f34, syn_fw);
 }
 
-static int rmi_f34_status(struct rmi_function *fn)
-{
-	struct f34_data *f34 = dev_get_drvdata(&fn->dev);
-
-	/*
-	 * The status is the percentage complete, or once complete,
-	 * zero for success or a negative return code.
-	 */
-	return f34->update_status;
-}
-
 static ssize_t rmi_driver_bootloader_id_show(struct device *dev,
 					     struct device_attribute *dattr,
 					     char *buf)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
-	struct rmi_function *fn = data->f34_container;
+	struct rmi_function *fn;
 	struct f34_data *f34;
 
-	if (fn) {
-		f34 = dev_get_drvdata(&fn->dev);
+	fn = data->f34_container;
+	if (!fn)
+		return -ENODEV;
 
-		if (f34->bl_version == 5)
-			return sysfs_emit(buf, "%c%c\n",
-					  f34->bootloader_id[0],
-					  f34->bootloader_id[1]);
-		else
-			return sysfs_emit(buf, "V%d.%d\n",
-					  f34->bootloader_id[1],
-					  f34->bootloader_id[0]);
-	}
+	f34 = dev_get_drvdata(&fn->dev);
+	if (!f34)
+		return -ENODEV;
 
-	return 0;
+	if (f34->bl_version == 5)
+		return sysfs_emit(buf, "%c%c\n",
+				  f34->bootloader_id[0],
+				  f34->bootloader_id[1]);
+	else
+		return sysfs_emit(buf, "V%d.%d\n",
+				  f34->bootloader_id[1],
+				  f34->bootloader_id[0]);
 }
 
 static DEVICE_ATTR(bootloader_id, 0444, rmi_driver_bootloader_id_show, NULL);
@@ -334,13 +326,16 @@ static ssize_t rmi_driver_configuration_id_show(struct device *dev,
 	struct rmi_function *fn = data->f34_container;
 	struct f34_data *f34;
 
-	if (fn) {
-		f34 = dev_get_drvdata(&fn->dev);
+	fn = data->f34_container;
+	if (!fn)
+		return -ENODEV;
 
-		return sysfs_emit(buf, "%s\n", f34->configuration_id);
-	}
+	f34 = dev_get_drvdata(&fn->dev);
+	if (!f34)
+		return -ENODEV;
 
-	return 0;
+
+	return sysfs_emit(buf, "%s\n", f34->configuration_id);
 }
 
 static DEVICE_ATTR(configuration_id, 0444,
@@ -356,10 +351,14 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 
 	if (!data->f34_container) {
 		dev_warn(dev, "%s: No F34 present!\n", __func__);
-		return -EINVAL;
+		return -ENODEV;
 	}
 
 	f34 = dev_get_drvdata(&data->f34_container->dev);
+	if (!f34) {
+		dev_warn(dev, "%s: No valid F34 present!\n", __func__);
+		return -ENODEV;
+	}
 
 	if (f34->bl_version >= 7) {
 		if (data->pdt_props & HAS_BSR) {
@@ -485,10 +484,18 @@ static ssize_t rmi_driver_update_fw_status_show(struct device *dev,
 						char *buf)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(dev);
-	int update_status = 0;
+	struct f34_data *f34;
+	int update_status = -ENODEV;
 
-	if (data->f34_container)
-		update_status = rmi_f34_status(data->f34_container);
+	/*
+	 * The status is the percentage complete, or once complete,
+	 * zero for success or a negative return code.
+	 */
+	if (data->f34_container) {
+		f34 = dev_get_drvdata(&data->f34_container->dev);
+		if (f34)
+			update_status = f34->update_status;
+	}
 
 	return sysfs_emit(buf, "%d\n", update_status);
 }
@@ -508,33 +515,21 @@ static const struct attribute_group rmi_firmware_attr_group = {
 	.attrs = rmi_firmware_attrs,
 };
 
-static int rmi_f34_probe(struct rmi_function *fn)
+static int rmi_f34v5_probe(struct f34_data *f34)
 {
-	struct f34_data *f34;
-	unsigned char f34_queries[9];
+	struct rmi_function *fn = f34->fn;
+	u8 f34_queries[9];
 	bool has_config_id;
-	u8 version = fn->fd.function_version;
-	int ret;
-
-	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
-	if (!f34)
-		return -ENOMEM;
-
-	f34->fn = fn;
-	dev_set_drvdata(&fn->dev, f34);
-
-	/* v5 code only supported version 0, try V7 probe */
-	if (version > 0)
-		return rmi_f34v7_probe(f34);
+	int error;
 
 	f34->bl_version = 5;
 
-	ret = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
-			     f34_queries, sizeof(f34_queries));
-	if (ret) {
+	error = rmi_read_block(fn->rmi_dev, fn->fd.query_base_addr,
+			       f34_queries, sizeof(f34_queries));
+	if (error) {
 		dev_err(&fn->dev, "%s: Failed to query properties\n",
 			__func__);
-		return ret;
+		return error;
 	}
 
 	snprintf(f34->bootloader_id, sizeof(f34->bootloader_id),
@@ -560,11 +555,11 @@ static int rmi_f34_probe(struct rmi_function *fn)
 		f34->v5.config_blocks);
 
 	if (has_config_id) {
-		ret = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
-				     f34_queries, sizeof(f34_queries));
-		if (ret) {
+		error = rmi_read_block(fn->rmi_dev, fn->fd.control_base_addr,
+				       f34_queries, sizeof(f34_queries));
+		if (error) {
 			dev_err(&fn->dev, "Failed to read F34 config ID\n");
-			return ret;
+			return error;
 		}
 
 		snprintf(f34->configuration_id, sizeof(f34->configuration_id),
@@ -573,12 +568,34 @@ static int rmi_f34_probe(struct rmi_function *fn)
 			 f34_queries[2], f34_queries[3]);
 
 		rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Configuration ID: %s\n",
-			 f34->configuration_id);
+			f34->configuration_id);
 	}
 
 	return 0;
 }
 
+static int rmi_f34_probe(struct rmi_function *fn)
+{
+	struct f34_data *f34;
+	u8 version = fn->fd.function_version;
+	int error;
+
+	f34 = devm_kzalloc(&fn->dev, sizeof(struct f34_data), GFP_KERNEL);
+	if (!f34)
+		return -ENOMEM;
+
+	f34->fn = fn;
+
+	/* v5 code only supported version 0 */
+	error = version == 0 ? rmi_f34v5_probe(f34) : rmi_f34v7_probe(f34);
+	if (error)
+		return error;
+
+	dev_set_drvdata(&fn->dev, f34);
+
+	return 0;
+}
+
 int rmi_f34_create_sysfs(struct rmi_device *rmi_dev)
 {
 	return sysfs_create_group(&rmi_dev->dev.kobj, &rmi_firmware_attr_group);


