Return-Path: <stable+bounces-174690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB46B364AB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112468A74E0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F5730AAD2;
	Tue, 26 Aug 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2sqomB9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD930146D;
	Tue, 26 Aug 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215059; cv=none; b=dgFPvb2wtMx3xk79Tyim5ZQ37U/WY7uXvOGLqt7cFzJc7+zwUVT6+7AUi8C7o7sApwli5/CCoBbDDSpS0fxvkXG/Ikns/AVwK+XQLL3FVbozJ13TNMRooL9UfTUxO44eDCe6/mIoH1hMi4phFAyCgYAgI9gwcoktu/akhsMQdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215059; c=relaxed/simple;
	bh=YLHAWYNlGK7l9GjU5Td2KGiPveUd8sLKr4sA6eFC6s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYzYsj3fQUrPQs2/qEzqrxqS1ZtHOGzgbU5Ye4k3zg2c5Yn4BHKQ3Pa2CjeHDyJmrXUW4K+wpAB5Ys1ja6N/ID92s+wzFrtRJlKxTdQRHr2p/Odz6yg5iLKtlk9SakdkYa/nJlgpxDYxu6hS9WxHP3pL0L38mEAgBW0dM8YtJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y2sqomB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8AFC4CEF1;
	Tue, 26 Aug 2025 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215058;
	bh=YLHAWYNlGK7l9GjU5Td2KGiPveUd8sLKr4sA6eFC6s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2sqomB9T9vRbstg5Kx+oOAwuFUhjI5lHPMxrFzPCfaDars936r6yZnhVTVREHh57
	 /KBlJKKRJcacUIq968wf888AXwoQ/iWGe0wDjGy6EFENzpuEK0qOWyQi+pb9JLGLex
	 8QoyD7yf1aE2opA84loB0PvQwWyS4uQfFKNErY4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 371/482] platform/chrome: cros_ec: Use per-device lockdep key
Date: Tue, 26 Aug 2025 13:10:24 +0200
Message-ID: <20250826110939.999484853@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_ec.c           |   14 +++++++++++---
 include/linux/platform_data/cros_ec_proto.h |    4 ++++
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -198,12 +198,14 @@ int cros_ec_register(struct cros_ec_devi
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
@@ -215,7 +217,7 @@ int cros_ec_register(struct cros_ec_devi
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d\n",
 				ec_dev->irq, err);
-			return err;
+			goto destroy_mutex;
 		}
 	}
 
@@ -226,7 +228,8 @@ int cros_ec_register(struct cros_ec_devi
 	if (IS_ERR(ec_dev->ec)) {
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
-		return PTR_ERR(ec_dev->ec);
+		err = PTR_ERR(ec_dev->ec);
+		goto destroy_mutex;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -292,6 +295,9 @@ int cros_ec_register(struct cros_ec_devi
 exit:
 	platform_device_unregister(ec_dev->ec);
 	platform_device_unregister(ec_dev->pd);
+destroy_mutex:
+	mutex_destroy(&ec_dev->lock);
+	lockdep_unregister_key(&ec_dev->lockdep_key);
 	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
@@ -309,6 +315,8 @@ void cros_ec_unregister(struct cros_ec_d
 	if (ec_dev->pd)
 		platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
+	mutex_destroy(&ec_dev->lock);
+	lockdep_unregister_key(&ec_dev->lockdep_key);
 }
 EXPORT_SYMBOL(cros_ec_unregister);
 
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -9,6 +9,7 @@
 #define __LINUX_CROS_EC_PROTO_H
 
 #include <linux/device.h>
+#include <linux/lockdep_types.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
@@ -116,6 +117,8 @@ struct cros_ec_command {
  *            command. The caller should check msg.result for the EC's result
  *            code.
  * @pkt_xfer: Send packet to EC and get response.
+ * @lockdep_key: Lockdep class for each instance. Unused if CONFIG_LOCKDEP is
+ *		 not enabled.
  * @lock: One transaction at a time.
  * @mkbp_event_supported: 0 if MKBP not supported. Otherwise its value is
  *                        the maximum supported version of the MKBP host event
@@ -160,6 +163,7 @@ struct cros_ec_device {
 			struct cros_ec_command *msg);
 	int (*pkt_xfer)(struct cros_ec_device *ec,
 			struct cros_ec_command *msg);
+	struct lock_class_key lockdep_key;
 	struct mutex lock;
 	u8 mkbp_event_supported;
 	bool host_sleep_v1;



