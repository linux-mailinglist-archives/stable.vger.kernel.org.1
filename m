Return-Path: <stable+bounces-155736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BC1AE438B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E53A8C42
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D9F2528F3;
	Mon, 23 Jun 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NwzRYFIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282F248191;
	Mon, 23 Jun 2025 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685203; cv=none; b=NpA2NWepLDC1SJCYGwyZQln1nt0b1FR+F1r7euFDT6tpEt9SpeJc1RXITMz2ki95zo9OhARaISed7CqDlbZ0tuHKaIsd72mOvOfJVT2o24CWwrhhh94nFCtHs4hnADQ6HG2ZXcCjbL/qYn8jlEN0h2UprA0a4xc7Gp7gNyY7FGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685203; c=relaxed/simple;
	bh=tNkCXn0h6aTk0oRYz3sKShWYGG5XK/stNlQEPvHsZtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXrj3lzQAwzD8SqCwYwZItqugs7et7LQnk0IoJBlu3CBHY4iEHa1M1s+JehHxID1oYGVkSAZ0UHChqwJl1eAB5Wnpbcc4PNGDmzJHn5Pb5Ru0easJ4GxoZQF0Mn4Q8H6M/YGO8Ah5wL/1NpwszLqHmNICxIgMQq+ivMZgFSG3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NwzRYFIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55199C4CEEA;
	Mon, 23 Jun 2025 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685203;
	bh=tNkCXn0h6aTk0oRYz3sKShWYGG5XK/stNlQEPvHsZtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NwzRYFIjqF2ut7J7ZHxAE9wyBUpFqMhfTBcKdYOft57CFHmO6fCUG3nmvJ7VKPoCa
	 Nsm8CfEbFh9vo6e8bf96EOxRc/d0HM1YB+ERgLBQFaHuNI6jijLDHIm1yWju/pSyNE
	 BpWg6bf0FKCd8A0y11F6WDGMvmrlhKeQgE+DOkrM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Hanno=20B=C3=B6ck?= <hanno@hboeck.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 074/222] Input: synaptics-rmi - fix crash with unsupported versions of F34
Date: Mon, 23 Jun 2025 15:06:49 +0200
Message-ID: <20250623130614.326943320@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit ca39500f6af9cfe6823dc5aa8fbaed788d6e35b2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/rmi4/rmi_f34.c | 135 ++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 59 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index c26808f10827a..c93a8ccd87c73 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2016 Zodiac Inflight Innovations
  */
 
+#include "linux/device.h"
 #include <linux/kernel.h>
 #include <linux/rmi.h>
 #include <linux/firmware.h>
@@ -298,39 +299,30 @@ static int rmi_f34_update_firmware(struct f34_data *f34,
 	return ret;
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
-
-		if (f34->bl_version == 5)
-			return sysfs_emit(buf, "%c%c\n",
-					  f34->bootloader_id[0],
-					  f34->bootloader_id[1]);
-		else
-			return sysfs_emit(buf, "V%d.%d\n",
-					  f34->bootloader_id[1],
-					  f34->bootloader_id[0]);
-	}
+	fn = data->f34_container;
+	if (!fn)
+		return -ENODEV;
 
-	return 0;
+	f34 = dev_get_drvdata(&fn->dev);
+	if (!f34)
+		return -ENODEV;
+
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
@@ -343,13 +335,16 @@ static ssize_t rmi_driver_configuration_id_show(struct device *dev,
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
@@ -365,10 +360,14 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 
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
 
 	if (f34->bl_version == 7) {
 		if (data->pdt_props & HAS_BSR) {
@@ -494,10 +493,18 @@ static ssize_t rmi_driver_update_fw_status_show(struct device *dev,
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
@@ -517,33 +524,21 @@ static const struct attribute_group rmi_firmware_attr_group = {
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
@@ -569,11 +564,11 @@ static int rmi_f34_probe(struct rmi_function *fn)
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
@@ -582,12 +577,34 @@ static int rmi_f34_probe(struct rmi_function *fn)
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
-- 
2.39.5




