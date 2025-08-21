Return-Path: <stable+bounces-172165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B625B2FDEF
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 17:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E022A1BA4D46
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820C283138;
	Thu, 21 Aug 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9fao79r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6E275B06
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788929; cv=none; b=iJi+fEEzBTfokyxY/5t9PW6Yc+PggERSrKhu3lKOYhKvzOd4k/I+90yoEnqEuXACZt78VfuuIQsyf6Cad5TbUZOLcBWfT9SMkCFNXEloowQJYQ9nX8NASSNsbHsnlBo+tNttVn1lrrh7vEbuqUcVi+5xHMdqZ6iSCprobT2E+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788929; c=relaxed/simple;
	bh=Wp4b4/gnfeijCemX1T8AiNc10D7JShOfYgyyKnEwxy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKeUDjjzq8ecrrMkjLPic/Zc2Ry+Y1Yp8JayRNHtkngPDUdGLaH0d35VSyIqaz25ACaRm8wt9RpXpyraz89Rth6grewVoEYjhDnKb3qCPSonDNT+lFU+Wp51qGl/MXHwujmQiZHi+Vv0Be3AGHEROVgZU5BPKxRCOlDM/LH9dVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9fao79r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DBDC4CEF4;
	Thu, 21 Aug 2025 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788929;
	bh=Wp4b4/gnfeijCemX1T8AiNc10D7JShOfYgyyKnEwxy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X9fao79rlxK9ELcRL8fc9xpHHBdGf72uazbU0MM38Q7gobahBu3iac2IEvnhKv3Dp
	 +nTg53bnfdff5vu2QRPKtxX2r8np0z6pP7eDWHdvpxNd4+g9c83JN7+VBXjkNeGNZI
	 Th8LPJLnX1eBP8l5aOxcJCm4F1qcaMWps/A6mLihmAQH08syvBCt5Vu8vbaSjvv1u7
	 KspilwQxbK5GglpB6mRbhPgYJZX1JRgEHqjPRfD4HBsjQtLH7cXl0f3s5VCo9O0F9P
	 de1LximHCq9Imey4pym4FuWSRmHuD5B1sAfMRSlNAWHxFgaJs9AtKrUCqQmi9dJKiS
	 aO5wuE+47R5GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] platform/chrome: cros_ec: Use per-device lockdep key
Date: Thu, 21 Aug 2025 11:08:42 -0400
Message-ID: <20250821150844.754065-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821150844.754065-1-sashal@kernel.org>
References: <2025082112-freight-pesticide-c276@gregkh>
 <20250821150844.754065-1-sashal@kernel.org>
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
index ea2296104634..c5c0b273a8d7 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -200,12 +200,14 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
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
@@ -217,7 +219,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 		if (err) {
 			dev_err(dev, "Failed to request IRQ %d: %d",
 				ec_dev->irq, err);
-			return err;
+			goto destroy_mutex;
 		}
 	}
 
@@ -228,7 +230,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	if (IS_ERR(ec_dev->ec)) {
 		dev_err(ec_dev->dev,
 			"Failed to create CrOS EC platform device\n");
-		return PTR_ERR(ec_dev->ec);
+		err = PTR_ERR(ec_dev->ec);
+		goto destroy_mutex;
 	}
 
 	if (ec_dev->max_passthru) {
@@ -294,6 +297,9 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 exit:
 	platform_device_unregister(ec_dev->ec);
 	platform_device_unregister(ec_dev->pd);
+destroy_mutex:
+	mutex_destroy(&ec_dev->lock);
+	lockdep_unregister_key(&ec_dev->lockdep_key);
 	return err;
 }
 EXPORT_SYMBOL(cros_ec_register);
@@ -311,6 +317,8 @@ void cros_ec_unregister(struct cros_ec_device *ec_dev)
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


