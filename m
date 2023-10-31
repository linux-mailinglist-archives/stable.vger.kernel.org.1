Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A347DCC06
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344020AbjJaLmL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344024AbjJaLmL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:42:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B47D8
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:42:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEFFC433C8;
        Tue, 31 Oct 2023 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752528;
        bh=TiqL667P4dLAgXK2W2WtYVC89OM0I6B0MKVuQ5xnV6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REWYhsK7uikWiYE4M9mtT75chmLIxerP7EhmTv3gcDHqR0wg331BBVwqdHWcTbhug
         uqTyy3aKmP0lWxP0TsTZ92dAiBzpk1BWa0WPRK30afeENYG4/rFy0yvHsdUorDMbvw
         fnL7KzPXPZOwK++TjliixIdfYmz9atLxUQrkMbQXN3yLt/ZMEjMVUPFWDUrfU+Da3i
         Y8UCq0Gdu8X41tfVGO5pKmF7GJtMpIAKNsCYX52D1f0NSc3PBBtUcWzG7b4aqdtzdP
         +XeaBl7ETHLXxOW/4HNZI19OsL3gCiSYeyam/wObt8F8vZiOQOp2hwJyy7pEleHTrL
         aHBZ0PZAjcJhw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4.14.y 3/5] rpmsg: Fix calling device_lock() on non-initialized device
Date:   Tue, 31 Oct 2023 11:41:48 +0000
Message-ID: <20231031114155.2289410-3-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031114155.2289410-1-lee@kernel.org>
References: <20231031114155.2289410-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
 drivers/rpmsg/rpmsg_core.c     | 33 ++++++++++++++++++++++++++++++---
 drivers/rpmsg/rpmsg_internal.h | 14 +-------------
 include/linux/rpmsg.h          |  8 ++++++++
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index dffa3aab71782..af1a50a799aa8 100644
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
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index e1522caadbc8a..868698a3d4c2a 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -91,19 +91,7 @@ struct device *rpmsg_find_device(struct device *parent,
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
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index fdbb7814cfbe8..650ebbd35b0c3 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -140,6 +140,8 @@ struct rpmsg_driver {
 
 #if IS_ENABLED(CONFIG_RPMSG)
 
+int rpmsg_register_device_override(struct rpmsg_device *rpdev,
+				   const char *driver_override);
 int register_rpmsg_device(struct rpmsg_device *dev);
 void unregister_rpmsg_device(struct rpmsg_device *dev);
 int __register_rpmsg_driver(struct rpmsg_driver *drv, struct module *owner);
@@ -164,6 +166,12 @@ unsigned int rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 
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
-- 
2.42.0.820.g83a721a137-goog

