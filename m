Return-Path: <stable+bounces-172186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3879AB2FFC1
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA417BED01
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3162A2D46C6;
	Thu, 21 Aug 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upNcgYQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53752D0C98
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792881; cv=none; b=snPpwldZ30HUXWmqvNDfWsEFUtjXBYRxSZJOdorsu72abtx+nlu0ph+9H/Dn0Cdnf1TRL9TiHGAb7/3Z9Kg847q6owh+f4RgdUscWPaCweCZoHQkhNE1dLWDYXmxIp/XETnxfutZ3uYcdsN5o9mypRYyYb8yzwhS2h9Zh1Nx7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792881; c=relaxed/simple;
	bh=FLOeYT/ABeasN5Nx5unPSxRuvl8JEPY7H05rRyLGOd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrwmZT/NVx8VWh/D0MkUnR55x+AT/PYnjFTEiDllAG7jTQ5yUyqNN6tGwXOqYZ5eAixRavJ/R062SDpzA9KxhXLo2k+MNqDROuUfd+UN8ugtG7RS+LKkluAK9m1wxM64OXkn6CbVl0kC3wU88Hmhe5JlrCcczrKaSwMTJl4bXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upNcgYQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF60C4CEED;
	Thu, 21 Aug 2025 16:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792880;
	bh=FLOeYT/ABeasN5Nx5unPSxRuvl8JEPY7H05rRyLGOd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=upNcgYQVg+LbJpwyN6coezpP3qL3Bre4xgXE6FxtQRP/th6S821eUZptj1gJjvUVo
	 Zgo5EjJc6Yl0sgX/xMkIxEx8XLSB8+6P1UJHC94uL1uy6u2lhW9+UkZflwD0t92EL0
	 HxuhQ7uOi8bIHBEBTNjJGNft5dpPCLMfMS0n5qCS6K1h+GKx+bJz8K5JhKmhFqsCAR
	 VaexIAhiU8ybKABALhnvEh53FiouhZp9OFkNSAHLoXy7xkwHkblQS+8GC/Gp/i+asd
	 XKPOHyqtMP0S1nL38g981oxn2g3m5rXK5d7mVyou+N2mBNI7SW/oCoMpWbqCpoXUIy
	 FNx2b1nYScFNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] platform/chrome: cros_ec: Use per-device lockdep key
Date: Thu, 21 Aug 2025 12:14:35 -0400
Message-ID: <20250821161437.775522-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821161437.775522-1-sashal@kernel.org>
References: <2025082112-segment-delta-e613@gregkh>
 <20250821161437.775522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 961a325becd9a142ae5c8b258e5c2f221f8bfac8 ]

Lockdep reports a bogus possible deadlock on MT8192 Chromebooks due to
the following lock sequences:

1. lock(i2c_register_adapter) [1]; lock(&ec_dev->lock)
2. lock(&ec_dev->lock); lock(prepare_lock);

The actual dependency chains are much longer. The shortened version
looks somewhat like:

1. cros-ec-rpmsg on mtk-scp
   ec_dev->lock -> prepare_lock
2. In rt5682_i2c_probe() on native I2C bus:
   prepare_lock -> regmap->lock -> (possibly) i2c_adapter->bus_lock
3. In rt5682_i2c_probe() on native I2C bus:
   regmap->lock -> i2c_adapter->bus_lock
4. In sbs_probe() on i2c-cros-ec-tunnel I2C bus attached on cros-ec:
   i2c_adapter->bus_lock -> ec_dev->lock

While lockdep is correct that the shared lockdep classes have a circular
dependency, it is bogus because

  a) 2+3 happen on a native I2C bus
  b) 4 happens on the actual EC on ChromeOS devices
  c) 1 happens on the SCP coprocessor on MediaTek Chromebooks that just
     happens to expose a cros-ec interface, but does not have an
     i2c-cros-ec-tunnel I2C bus

In short, the "dependencies" are actually on different devices.

Setup a per-device lockdep key for cros_ec devices so lockdep can tell
the two instances apart. This helps with getting rid of the bogus
lockdep warning. For ChromeOS devices that only have one cros-ec
instance this doesn't change anything.

Also add a missing mutex_destroy, just to make the teardown complete.

[1] This is likely the per I2C bus lock with shared lockdep class

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20230111074146.2624496-1-wenst@chromium.org
Stable-dep-of: e23749534619 ("platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec.c           | 14 +++++++++++---
 include/linux/platform_data/cros_ec_proto.h |  4 ++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 826ca3a4feb8..8cac78b6f0ac 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -186,12 +186,14 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	if (!ec_dev->dout)
 		return -ENOMEM;
 
+	lockdep_register_key(&ec_dev->lockdep_key);
 	mutex_init(&ec_dev->lock);
+	lockdep_set_class(&ec_dev->lock, &ec_dev->lockdep_key);
 
 	err = cros_ec_query_all(ec_dev);
 	if (err) {
 		dev_err(dev, "Cannot identify the EC: error %d\n", err);
-		return err;
+		goto destroy_mutex;
 	}
 
 	if (ec_dev->irq > 0) {
@@ -203,7 +205,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d",
 				ec_dev->irq, err);
-			return err;
+			goto destroy_mutex;
 		}
 	}
 
@@ -214,7 +216,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	if (IS_ERR(ec_dev->ec)) {
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
-		return PTR_ERR(ec_dev->ec);
+		err = PTR_ERR(ec_dev->ec);
+		goto destroy_mutex;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -273,6 +276,9 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 exit:
 	platform_device_unregister(ec_dev->ec);
 	platform_device_unregister(ec_dev->pd);
+destroy_mutex:
+	mutex_destroy(&ec_dev->lock);
+	lockdep_unregister_key(&ec_dev->lockdep_key);
 	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
@@ -290,6 +296,8 @@ void cros_ec_unregister(struct cros_ec_device *ec_dev)
 	if (ec_dev->pd)
 		platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
+	mutex_destroy(&ec_dev->lock);
+	lockdep_unregister_key(&ec_dev->lockdep_key);
 }
 EXPORT_SYMBOL(cros_ec_unregister);
 
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 7f03e02c48cd..4e78365bad83 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -9,6 +9,7 @@
 #define __LINUX_CROS_EC_PROTO_H
 
 #include <linux/device.h>
+#include <linux/lockdep_types.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
@@ -114,6 +115,8 @@ struct cros_ec_command {
  *            command. The caller should check msg.result for the EC's result
  *            code.
  * @pkt_xfer: Send packet to EC and get response.
+ * @lockdep_key: Lockdep class for each instance. Unused if CONFIG_LOCKDEP is
+ *		 not enabled.
  * @lock: One transaction at a time.
  * @mkbp_event_supported: 0 if MKBP not supported. Otherwise its value is
  *                        the maximum supported version of the MKBP host event
@@ -159,6 +162,7 @@ struct cros_ec_device {
 			struct cros_ec_command *msg);
 	int (*pkt_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
+	struct lock_class_key lockdep_key;
 	struct mutex lock;
 	u8 mkbp_event_supported;
 	bool host_sleep_v1;
-- 
2.50.1


