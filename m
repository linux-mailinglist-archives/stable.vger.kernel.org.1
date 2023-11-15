Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA77ECBF8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjKOTZj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjKOTZe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:25:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000FB1A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4B3C433CA;
        Wed, 15 Nov 2023 19:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076330;
        bh=iileZQtYK2Yx4isq9wHAg2j9AHY0nIt5jelxtZGMg3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wMgG9DCzczR9jWnuX/ld5/RKAe5HnEIfLWpZV7P2RYRXmuGjypnmKKg3mk8dnDklV
         I5KgPjD3rKYl6+TiZVWOuhaQbP0FUHXK5yuofj547e1kZpl19sgDgN1Vo+DaLo9i6B
         /k6ASeCEZKdrYa4Bq/nDszCNU89lAAEY1o7lcKUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Lalith Rajendran <lalithkraj@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 198/550] platform/chrome: cros_ec_lpc: Separate host command and irq disable
Date:   Wed, 15 Nov 2023 14:13:02 -0500
Message-ID: <20231115191614.496484097@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lalith Rajendran <lalithkraj@chromium.org>

[ Upstream commit 47ea0ddb1f5604ba3496baa19110aec6a3151f2e ]

Both cros host command and irq disable were moved to suspend
prepare stage from late suspend recently. This is causing EC
to report MKBP event timeouts during suspend stress testing.
When the MKBP event timeouts happen during suspend, subsequent
wakeup of AP by EC using MKBP doesn't happen properly. Move the
irq disabling part back to late suspend stage which is a general
suggestion from the suspend kernel documentaiton to do irq
disable as late as possible.

Fixes: 4b9abbc132b8 ("platform/chrome: cros_ec_lpc: Move host command to prepare/complete")
Signed-off-by: Lalith Rajendran <lalithkraj@chromium.org>
Link: https://lore.kernel.org/r/20231027160221.v4.1.I1725c3ed27eb7cd9836904e49e8bfa9fb0200a97@changeid
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec.c     | 116 +++++++++++++++++++++-----
 drivers/platform/chrome/cros_ec.h     |   4 +
 drivers/platform/chrome/cros_ec_lpc.c |  22 ++++-
 3 files changed, 116 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 8b79492203825..f61f4c7a7b82b 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -320,17 +320,8 @@ void cros_ec_unregister(struct cros_ec_device *ec_dev)
 EXPORT_SYMBOL(cros_ec_unregister);
 
 #ifdef CONFIG_PM_SLEEP
-/**
- * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
- * @ec_dev: Device to suspend.
- *
- * This can be called by drivers to handle a suspend event.
- *
- * Return: 0 on success or negative error code.
- */
-int cros_ec_suspend(struct cros_ec_device *ec_dev)
+static void cros_ec_send_suspend_event(struct cros_ec_device *ec_dev)
 {
-	struct device *dev = ec_dev->dev;
 	int ret;
 	u8 sleep_event;
 
@@ -342,7 +333,26 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 	if (ret < 0)
 		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec\n",
 			ret);
+}
 
+/**
+ * cros_ec_suspend_prepare() - Handle a suspend prepare operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend prepare stage of suspend.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_suspend_prepare(struct cros_ec_device *ec_dev)
+{
+	cros_ec_send_suspend_event(ec_dev);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_suspend_prepare);
+
+static void cros_ec_disable_irq(struct cros_ec_device *ec_dev)
+{
+	struct device *dev = ec_dev->dev;
 	if (device_may_wakeup(dev))
 		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
 	else
@@ -350,7 +360,35 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	disable_irq(ec_dev->irq);
 	ec_dev->suspended = true;
+}
 
+/**
+ * cros_ec_suspend_late() - Handle a suspend late operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend late stage of suspend.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_suspend_late(struct cros_ec_device *ec_dev)
+{
+	cros_ec_disable_irq(ec_dev);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_suspend_late);
+
+/**
+ * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend event.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_suspend(struct cros_ec_device *ec_dev)
+{
+	cros_ec_send_suspend_event(ec_dev);
+	cros_ec_disable_irq(ec_dev);
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_suspend);
@@ -369,22 +407,11 @@ static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 	}
 }
 
-/**
- * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
- * @ec_dev: Device to resume.
- *
- * This can be called by drivers to handle a resume event.
- *
- * Return: 0 on success or negative error code.
- */
-int cros_ec_resume(struct cros_ec_device *ec_dev)
+static void cros_ec_send_resume_event(struct cros_ec_device *ec_dev)
 {
 	int ret;
 	u8 sleep_event;
 
-	ec_dev->suspended = false;
-	enable_irq(ec_dev->irq);
-
 	sleep_event = (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware()) ?
 		      HOST_SLEEP_EVENT_S3_RESUME :
 		      HOST_SLEEP_EVENT_S0IX_RESUME;
@@ -393,6 +420,24 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 	if (ret < 0)
 		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec\n",
 			ret);
+}
+
+/**
+ * cros_ec_resume_complete() - Handle a resume complete operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume complete stage of resume.
+ */
+void cros_ec_resume_complete(struct cros_ec_device *ec_dev)
+{
+	cros_ec_send_resume_event(ec_dev);
+}
+EXPORT_SYMBOL(cros_ec_resume_complete);
+
+static void cros_ec_enable_irq(struct cros_ec_device *ec_dev)
+{
+	ec_dev->suspended = false;
+	enable_irq(ec_dev->irq);
 
 	if (ec_dev->wake_enabled)
 		disable_irq_wake(ec_dev->irq);
@@ -402,8 +447,35 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 	 * suspend. This way the clients know what to do with them.
 	 */
 	cros_ec_report_events_during_suspend(ec_dev);
+}
 
+/**
+ * cros_ec_resume_early() - Handle a resume early operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume early stage of resume.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_resume_early(struct cros_ec_device *ec_dev)
+{
+	cros_ec_enable_irq(ec_dev);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_resume_early);
 
+/**
+ * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume event.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_resume(struct cros_ec_device *ec_dev)
+{
+	cros_ec_enable_irq(ec_dev);
+	cros_ec_send_resume_event(ec_dev);
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_resume);
diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cros_ec.h
index bbca0096868ac..566332f487892 100644
--- a/drivers/platform/chrome/cros_ec.h
+++ b/drivers/platform/chrome/cros_ec.h
@@ -14,7 +14,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev);
 void cros_ec_unregister(struct cros_ec_device *ec_dev);
 
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
+int cros_ec_suspend_late(struct cros_ec_device *ec_dev);
+int cros_ec_suspend_prepare(struct cros_ec_device *ec_dev);
 int cros_ec_resume(struct cros_ec_device *ec_dev);
+int cros_ec_resume_early(struct cros_ec_device *ec_dev);
+void cros_ec_resume_complete(struct cros_ec_device *ec_dev);
 
 irqreturn_t cros_ec_irq_thread(int irq, void *data);
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 356572452898d..42e1770887fb0 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -549,22 +549,36 @@ MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
 static int cros_ec_lpc_prepare(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
-
-	return cros_ec_suspend(ec_dev);
+	return cros_ec_suspend_prepare(ec_dev);
 }
 
 static void cros_ec_lpc_complete(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
-	cros_ec_resume(ec_dev);
+	cros_ec_resume_complete(ec_dev);
+}
+
+static int cros_ec_lpc_suspend_late(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_suspend_late(ec_dev);
+}
+
+static int cros_ec_lpc_resume_early(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_resume_early(ec_dev);
 }
 #endif
 
 static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
 	.prepare = cros_ec_lpc_prepare,
-	.complete = cros_ec_lpc_complete
+	.complete = cros_ec_lpc_complete,
 #endif
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend_late, cros_ec_lpc_resume_early)
 };
 
 static struct platform_driver cros_ec_lpc_driver = {
-- 
2.42.0



