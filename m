Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEED775DE4
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbjHILmW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjHILmV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:42:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5971FD2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46DB9636D4
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A27C433CD;
        Wed,  9 Aug 2023 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581339;
        bh=+ywGTldusHrxS+LBtD0YMpMybeobgtHsp2IMaeeWc9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJ8pXrf4IRcj+rzNo6XDodbftk1KjaBj9xTiOSfWV9WUt8eb5H/Ek0C12iDHxBKkI
         vXsi8b14V5p5+/Ox6L4Zexwjhd6k5nW4fs4gHnqZSBOL/M1ElWEhcEgMNTC59XpB6g
         dtg6n7rBAEyEzYIX/oEwPXoU0s6lxANztWT6Xfg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 191/201] PM / wakeirq: support enabling wake-up irq after runtime_suspend called
Date:   Wed,  9 Aug 2023 12:43:13 +0200
Message-ID: <20230809103650.219770744@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

[ Upstream commit 259714100d98b50bf04d36a21bf50ca8b829fc11 ]

When the dedicated wake IRQ is level trigger, and it uses the
device's low-power status as the wakeup source, that means if the
device is not in low-power state, the wake IRQ will be triggered
if enabled; For this case, need enable the wake IRQ after running
the device's ->runtime_suspend() which make it enter low-power state.

e.g.
Assume the wake IRQ is a low level trigger type, and the wakeup
signal comes from the low-power status of the device.
The wakeup signal is low level at running time (0), and becomes
high level when the device enters low-power state (runtime_suspend
(1) is called), a wakeup event at (2) make the device exit low-power
state, then the wakeup signal also becomes low level.

                ------------------
               |           ^     ^|
----------------           |     | --------------
 |<---(0)--->|<--(1)--|   (3)   (2)    (4)

if enable the wake IRQ before running runtime_suspend during (0),
a wake IRQ will arise, it causes resume immediately;
it works if enable wake IRQ ( e.g. at (3) or (4)) after running
->runtime_suspend().

This patch introduces a new status WAKE_IRQ_DEDICATED_REVERSE to
optionally support enabling wake IRQ after running ->runtime_suspend().

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 8527beb12087 ("PM: sleep: wakeirq: fix wake irq arming")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/power.h   |   7 ++-
 drivers/base/power/runtime.c |   6 ++-
 drivers/base/power/wakeirq.c | 101 +++++++++++++++++++++++++++--------
 include/linux/pm_wakeirq.h   |   9 +++-
 4 files changed, 96 insertions(+), 27 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 54292cdd7808b..0eb7f02b3ad59 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -25,8 +25,10 @@ extern u64 pm_runtime_active_time(struct device *dev);
 
 #define WAKE_IRQ_DEDICATED_ALLOCATED	BIT(0)
 #define WAKE_IRQ_DEDICATED_MANAGED	BIT(1)
+#define WAKE_IRQ_DEDICATED_REVERSE	BIT(2)
 #define WAKE_IRQ_DEDICATED_MASK		(WAKE_IRQ_DEDICATED_ALLOCATED | \
-					 WAKE_IRQ_DEDICATED_MANAGED)
+					 WAKE_IRQ_DEDICATED_MANAGED | \
+					 WAKE_IRQ_DEDICATED_REVERSE)
 
 struct wake_irq {
 	struct device *dev;
@@ -39,7 +41,8 @@ extern void dev_pm_arm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_disarm_wake_irq(struct wake_irq *wirq);
 extern void dev_pm_enable_wake_irq_check(struct device *dev,
 					 bool can_change_status);
-extern void dev_pm_disable_wake_irq_check(struct device *dev);
+extern void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable);
+extern void dev_pm_enable_wake_irq_complete(struct device *dev);
 
 #ifdef CONFIG_PM_SLEEP
 
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 360094692d29e..fbbc3ed143f27 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -675,6 +675,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	if (retval)
 		goto fail;
 
+	dev_pm_enable_wake_irq_complete(dev);
+
  no_callback:
 	__update_runtime_status(dev, RPM_SUSPENDED);
 	pm_runtime_deactivate_timer(dev);
@@ -720,7 +722,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	return retval;
 
  fail:
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, true);
 	__update_runtime_status(dev, RPM_ACTIVE);
 	dev->power.deferred_resume = false;
 	wake_up_all(&dev->power.wait_queue);
@@ -903,7 +905,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	dev_pm_disable_wake_irq_check(dev);
+	dev_pm_disable_wake_irq_check(dev, false);
 	retval = rpm_callback(callback, dev);
 	if (retval) {
 		__update_runtime_status(dev, RPM_SUSPENDED);
diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8e021082dba8c..a6d53f0173d35 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -145,24 +145,7 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
 	return IRQ_HANDLED;
 }
 
-/**
- * dev_pm_set_dedicated_wake_irq - Request a dedicated wake-up interrupt
- * @dev: Device entry
- * @irq: Device wake-up interrupt
- *
- * Unless your hardware has separate wake-up interrupts in addition
- * to the device IO interrupts, you don't need this.
- *
- * Sets up a threaded interrupt handler for a device that has
- * a dedicated wake-up interrupt in addition to the device IO
- * interrupt.
- *
- * The interrupt starts disabled, and needs to be managed for
- * the device by the bus code or the device driver using
- * dev_pm_enable_wake_irq() and dev_pm_disable_wake_irq()
- * functions.
- */
-int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+static int __dev_pm_set_dedicated_wake_irq(struct device *dev, int irq, unsigned int flag)
 {
 	struct wake_irq *wirq;
 	int err;
@@ -200,7 +183,7 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	if (err)
 		goto err_free_irq;
 
-	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED;
+	wirq->status = WAKE_IRQ_DEDICATED_ALLOCATED | flag;
 
 	return err;
 
@@ -213,8 +196,57 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 
 	return err;
 }
+
+
+/**
+ * dev_pm_set_dedicated_wake_irq - Request a dedicated wake-up interrupt
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ *
+ * Unless your hardware has separate wake-up interrupts in addition
+ * to the device IO interrupts, you don't need this.
+ *
+ * Sets up a threaded interrupt handler for a device that has
+ * a dedicated wake-up interrupt in addition to the device IO
+ * interrupt.
+ *
+ * The interrupt starts disabled, and needs to be managed for
+ * the device by the bus code or the device driver using
+ * dev_pm_enable_wake_irq*() and dev_pm_disable_wake_irq*()
+ * functions.
+ */
+int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
+{
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, 0);
+}
 EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq);
 
+/**
+ * dev_pm_set_dedicated_wake_irq_reverse - Request a dedicated wake-up interrupt
+ *                                         with reverse enable ordering
+ * @dev: Device entry
+ * @irq: Device wake-up interrupt
+ *
+ * Unless your hardware has separate wake-up interrupts in addition
+ * to the device IO interrupts, you don't need this.
+ *
+ * Sets up a threaded interrupt handler for a device that has a dedicated
+ * wake-up interrupt in addition to the device IO interrupt. It sets
+ * the status of WAKE_IRQ_DEDICATED_REVERSE to tell rpm_suspend()
+ * to enable dedicated wake-up interrupt after running the runtime suspend
+ * callback for @dev.
+ *
+ * The interrupt starts disabled, and needs to be managed for
+ * the device by the bus code or the device driver using
+ * dev_pm_enable_wake_irq*() and dev_pm_disable_wake_irq*()
+ * functions.
+ */
+int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
+{
+	return __dev_pm_set_dedicated_wake_irq(dev, irq, WAKE_IRQ_DEDICATED_REVERSE);
+}
+EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
+
 /**
  * dev_pm_enable_wake_irq - Enable device wake-up interrupt
  * @dev: Device
@@ -285,27 +317,54 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
 	return;
 
 enable:
-	enable_irq(wirq->irq);
+	if (!can_change_status || !(wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+		enable_irq(wirq->irq);
 }
 
 /**
  * dev_pm_disable_wake_irq_check - Checks and disables wake-up interrupt
  * @dev: Device
+ * @cond_disable: if set, also check WAKE_IRQ_DEDICATED_REVERSE
  *
  * Disables wake-up interrupt conditionally based on status.
  * Should be only called from rpm_suspend() and rpm_resume() path.
  */
-void dev_pm_disable_wake_irq_check(struct device *dev)
+void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 {
 	struct wake_irq *wirq = dev->power.wakeirq;
 
 	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
 		return;
 
+	if (cond_disable && (wirq->status & WAKE_IRQ_DEDICATED_REVERSE))
+		return;
+
 	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED)
 		disable_irq_nosync(wirq->irq);
 }
 
+/**
+ * dev_pm_enable_wake_irq_complete - enable wake IRQ not enabled before
+ * @dev: Device using the wake IRQ
+ *
+ * Enable wake IRQ conditionally based on status, mainly used if want to
+ * enable wake IRQ after running ->runtime_suspend() which depends on
+ * WAKE_IRQ_DEDICATED_REVERSE.
+ *
+ * Should be only called from rpm_suspend() path.
+ */
+void dev_pm_enable_wake_irq_complete(struct device *dev)
+{
+	struct wake_irq *wirq = dev->power.wakeirq;
+
+	if (!wirq || !(wirq->status & WAKE_IRQ_DEDICATED_MASK))
+		return;
+
+	if (wirq->status & WAKE_IRQ_DEDICATED_MANAGED &&
+	    wirq->status & WAKE_IRQ_DEDICATED_REVERSE)
+		enable_irq(wirq->irq);
+}
+
 /**
  * dev_pm_arm_wake_irq - Arm device wake-up
  * @wirq: Device wake-up interrupt
diff --git a/include/linux/pm_wakeirq.h b/include/linux/pm_wakeirq.h
index cd5b62db90845..e63a63aa47a37 100644
--- a/include/linux/pm_wakeirq.h
+++ b/include/linux/pm_wakeirq.h
@@ -17,8 +17,8 @@
 #ifdef CONFIG_PM
 
 extern int dev_pm_set_wake_irq(struct device *dev, int irq);
-extern int dev_pm_set_dedicated_wake_irq(struct device *dev,
-					 int irq);
+extern int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq);
+extern int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq);
 extern void dev_pm_clear_wake_irq(struct device *dev);
 extern void dev_pm_enable_wake_irq(struct device *dev);
 extern void dev_pm_disable_wake_irq(struct device *dev);
@@ -35,6 +35,11 @@ static inline int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
 	return 0;
 }
 
+static inline int dev_pm_set_dedicated_wake_irq_reverse(struct device *dev, int irq)
+{
+	return 0;
+}
+
 static inline void dev_pm_clear_wake_irq(struct device *dev)
 {
 }
-- 
2.40.1



