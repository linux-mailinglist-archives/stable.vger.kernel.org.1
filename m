Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4FD7E22FD
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjKFNHi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjKFNHh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:07:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7B2F3
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:07:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD611C433C9;
        Mon,  6 Nov 2023 13:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276052;
        bh=MmZZKdUtxwHt8WDF079NoMezPrTlKQPh/ELQPRsUXCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wDgiONAGLHqMVBX1JvRuLGV1sXJjLFPWBHXbf8kxNtPd/hMmygVXdGiQGefI4mruk
         kQImyaKKu4lZi0uqml/gNrBe7ZwPeTazJ4G6QCahCbi+TC5tkVTDCvsoeaeMfFyYdm
         8sQRS6GrKu7b/CwR20tMSq0SR3l/SiyxbvZvm/WE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, lee@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4.14 25/48] rpmsg: Fix calling device_lock() on non-initialized device
Date:   Mon,  6 Nov 2023 14:03:16 +0100
Message-ID: <20231106130258.722050623@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
References: <20231106130257.862199836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit bb17d110cbf270d5247a6e261c5ad50e362d1675 upstream.

driver_set_override() helper uses device_lock() so it should not be
called before rpmsg_register_device() (which calls device_register()).
Effect can be seen with CONFIG_DEBUG_MUTEXES:

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  WARNING: CPU: 3 PID: 57 at kernel/locking/mutex.c:582 __mutex_lock+0x1ec/0x430
  ...
  Call trace:
   __mutex_lock+0x1ec/0x430
   mutex_lock_nested+0x44/0x50
   driver_set_override+0x124/0x150
   qcom_glink_native_probe+0x30c/0x3b0
   glink_rpm_probe+0x274/0x350
   platform_probe+0x6c/0xe0
   really_probe+0x17c/0x3d0
   __driver_probe_device+0x114/0x190
   driver_probe_device+0x3c/0xf0
   ...

Refactor the rpmsg_register_device() function to use two-step device
registering (initialization + add) and call driver_set_override() in
proper moment.

This moves the code around, so while at it also NULL-ify the
rpdev->driver_override in error path to be sure it won't be kfree()
second time.

Fixes: 42cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20220429195946.1061725-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit bb17d110cbf270d5247a6e261c5ad50e362d1675)
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rpmsg/rpmsg_core.c     |   33 ++++++++++++++++++++++++++++++---
 drivers/rpmsg/rpmsg_internal.h |   14 +-------------
 include/linux/rpmsg.h          |    8 ++++++++
 3 files changed, 39 insertions(+), 16 deletions(-)

--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -474,24 +474,51 @@ static struct bus_type rpmsg_bus = {
 	.remove		= rpmsg_dev_remove,
 };
 
-int rpmsg_register_device(struct rpmsg_device *rpdev)
+/*
+ * A helper for registering rpmsg device with driver override and name.
+ * Drivers should not be using it, but instead rpmsg_register_device().
+ */
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override)
 {
 	struct device *dev = &rpdev->dev;
 	int ret;
 
+	if (driver_override)
+		strcpy(rpdev->id.name, driver_override);
+
 	dev_set_name(&rpdev->dev, "%s.%s.%d.%d", dev_name(dev->parent),
 		     rpdev->id.name, rpdev->src, rpdev->dst);
 
 	rpdev->dev.bus = &rpmsg_bus;
 
-	ret = device_register(&rpdev->dev);
+	device_initialize(dev);
+	if (driver_override) {
+		ret = driver_set_override(dev, &rpdev->driver_override,
+					  driver_override,
+					  strlen(driver_override));
+		if (ret) {
+			dev_err(dev, "device_set_override failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = device_add(dev);
 	if (ret) {
-		dev_err(dev, "device_register failed: %d\n", ret);
+		dev_err(dev, "device_add failed: %d\n", ret);
+		kfree(rpdev->driver_override);
+		rpdev->driver_override = NULL;
 		put_device(&rpdev->dev);
 	}
 
 	return ret;
 }
+EXPORT_SYMBOL(rpmsg_register_device_override);
+
+int rpmsg_register_device(struct rpmsg_device *rpdev)
+{
+	return rpmsg_register_device_override(rpdev, NULL);
+}
 EXPORT_SYMBOL(rpmsg_register_device);
 
 /*
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -91,19 +91,7 @@ struct device *rpmsg_find_device(struct
  */
 static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 {
-	int ret;
-
-	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
-				  rpdev->id.name, strlen(rpdev->id.name));
-	if (ret)
-		return ret;
-
-	ret = rpmsg_register_device(rpdev);
-	if (ret)
-		kfree(rpdev->driver_override);
-
-	return ret;
+	return rpmsg_register_device_override(rpdev, "rpmsg_ctrl");
 }
 
 #endif
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -140,6 +140,8 @@ struct rpmsg_driver {
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override);
 int register_rpmsg_device(struct rpmsg_device *dev);
 void unregister_rpmsg_device(struct rpmsg_device *dev);
 int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
@@ -164,6 +166,12 @@ unsigned int rpmsg_poll(struct rpmsg_end
 
 #else
 
+static inline int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+						 const char *driver_override)
+{
+	return -ENXIO;
+}
+
 static inline int register_rpmsg_device(struct rpmsg_device *dev)
 {
 	return -ENXIO;


