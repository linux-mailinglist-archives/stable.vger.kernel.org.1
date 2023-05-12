Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D369E7008EE
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 15:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbjELNPq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbjELNPn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 09:15:43 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB314351;
        Fri, 12 May 2023 06:15:01 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id AD82E206FC;
        Fri, 12 May 2023 15:14:42 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, stable@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v1 2/2] Revert "usb: gadget: udc: core: Invoke usb_gadget_connect only when started"
Date:   Fri, 12 May 2023 15:14:35 +0200
Message-Id: <20230512131435.205464-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512131435.205464-1-francesco@dolcini.it>
References: <20230512131435.205464-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This reverts commit 0db213ea8eed5534a5169e807f28103cbc9d23df.

It introduces an issues with configuring the USB gadget hangs forever
on multiple Qualcomm and NXP i.MX SoC at least.

Cc: stable@vger.kernel.org
Fixes: 0db213ea8eed ("usb: gadget: udc: core: Invoke usb_gadget_connect only when started")
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Link: https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/usb/gadget/udc/core.c | 148 ++++++++++------------------------
 1 file changed, 44 insertions(+), 104 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 583c339876ab..52e6d2e84e35 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -37,10 +37,6 @@ static const struct bus_type gadget_bus_type;
  * @vbus: for udcs who care about vbus status, this value is real vbus status;
  * for udcs who do not care about vbus status, this value is always true
  * @started: the UDC's started state. True if the UDC had started.
- * @connect_lock: protects udc->vbus, udc->started, gadget->connect, gadget->deactivate related
- * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
- * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are
- * called with this lock held.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -52,7 +48,6 @@ struct usb_udc {
 	struct list_head		list;
 	bool				vbus;
 	bool				started;
-	struct mutex			connect_lock;
 };
 
 static struct class *udc_class;
@@ -692,9 +687,17 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
 
-/* Internal version of usb_gadget_connect needs to be called with connect_lock held. */
-static int usb_gadget_connect_locked(struct usb_gadget *gadget)
-	__must_hold(&gadget->udc->connect_lock)
+/**
+ * usb_gadget_connect - software-controlled connect to USB host
+ * @gadget:the peripheral being connected
+ *
+ * Enables the D+ (or potentially D-) pullup.  The host will start
+ * enumerating this gadget when the pullup is active and a VBUS session
+ * is active (the link is powered).
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_connect(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
@@ -703,12 +706,10 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 		goto out;
 	}
 
-	if (gadget->deactivated || !gadget->udc->started) {
+	if (gadget->deactivated) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will be connected automatically after activation.
-		 *
-		 * udc first needs to be started before gadget can be pulled up.
 		 */
 		gadget->connected = true;
 		goto out;
@@ -723,32 +724,22 @@ static int usb_gadget_connect_locked(struct usb_gadget *gadget)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(usb_gadget_connect);
 
 /**
- * usb_gadget_connect - software-controlled connect to USB host
- * @gadget:the peripheral being connected
+ * usb_gadget_disconnect - software-controlled disconnect from USB host
+ * @gadget:the peripheral being disconnected
  *
- * Enables the D+ (or potentially D-) pullup.  The host will start
- * enumerating this gadget when the pullup is active and a VBUS session
- * is active (the link is powered).
+ * Disables the D+ (or potentially D-) pullup, which the host may see
+ * as a disconnect (when a VBUS session is active).  Not all systems
+ * support software pullup controls.
+ *
+ * Following a successful disconnect, invoke the ->disconnect() callback
+ * for the current gadget driver so that UDC drivers don't need to.
  *
  * Returns zero on success, else negative errno.
  */
-int usb_gadget_connect(struct usb_gadget *gadget)
-{
-	int ret;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_gadget_connect);
-
-/* Internal version of usb_gadget_disconnect needs to be called with connect_lock held. */
-static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
-	__must_hold(&gadget->udc->connect_lock)
+int usb_gadget_disconnect(struct usb_gadget *gadget)
 {
 	int ret = 0;
 
@@ -760,12 +751,10 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
 	if (!gadget->connected)
 		goto out;
 
-	if (gadget->deactivated || !gadget->udc->started) {
+	if (gadget->deactivated) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will stay disconnected after activation.
-		 *
-		 * udc should have been started before gadget being pulled down.
 		 */
 		gadget->connected = false;
 		goto out;
@@ -785,30 +774,6 @@ static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
 
 	return ret;
 }
-
-/**
- * usb_gadget_disconnect - software-controlled disconnect from USB host
- * @gadget:the peripheral being disconnected
- *
- * Disables the D+ (or potentially D-) pullup, which the host may see
- * as a disconnect (when a VBUS session is active).  Not all systems
- * support software pullup controls.
- *
- * Following a successful disconnect, invoke the ->disconnect() callback
- * for the current gadget driver so that UDC drivers don't need to.
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_disconnect(struct usb_gadget *gadget)
-{
-	int ret;
-
-	mutex_lock(&gadget->udc->connect_lock);
-	ret = usb_gadget_disconnect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
-
-	return ret;
-}
 EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
 /**
@@ -829,11 +794,10 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 	if (gadget->deactivated)
 		goto out;
 
-	mutex_lock(&gadget->udc->connect_lock);
 	if (gadget->connected) {
-		ret = usb_gadget_disconnect_locked(gadget);
+		ret = usb_gadget_disconnect(gadget);
 		if (ret)
-			goto unlock;
+			goto out;
 
 		/*
 		 * If gadget was being connected before deactivation, we want
@@ -843,8 +807,6 @@ int usb_gadget_deactivate(struct usb_gadget *gadget)
 	}
 	gadget->deactivated = true;
 
-unlock:
-	mutex_unlock(&gadget->udc->connect_lock);
 out:
 	trace_usb_gadget_deactivate(gadget, ret);
 
@@ -868,7 +830,6 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	if (!gadget->deactivated)
 		goto out;
 
-	mutex_lock(&gadget->udc->connect_lock);
 	gadget->deactivated = false;
 
 	/*
@@ -876,8 +837,7 @@ int usb_gadget_activate(struct usb_gadget *gadget)
 	 * while it was being deactivated, we call usb_gadget_connect().
 	 */
 	if (gadget->connected)
-		ret = usb_gadget_connect_locked(gadget);
-	mutex_unlock(&gadget->udc->connect_lock);
+		ret = usb_gadget_connect(gadget);
 
 out:
 	trace_usb_gadget_activate(gadget, ret);
@@ -1118,13 +1078,12 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
-/* Acquire connect_lock before calling this function. */
-static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
+static void usb_udc_connect_control(struct usb_udc *udc)
 {
-	if (udc->vbus && udc->started)
-		usb_gadget_connect_locked(udc->gadget);
+	if (udc->vbus)
+		usb_gadget_connect(udc->gadget);
 	else
-		usb_gadget_disconnect_locked(udc->gadget);
+		usb_gadget_disconnect(udc->gadget);
 }
 
 /**
@@ -1140,12 +1099,10 @@ void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
 {
 	struct usb_udc *udc = gadget->udc;
 
-	mutex_lock(&udc->connect_lock);
 	if (udc) {
 		udc->vbus = status;
-		usb_udc_connect_control_locked(udc);
+		usb_udc_connect_control(udc);
 	}
-	mutex_unlock(&udc->connect_lock);
 }
 EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
 
@@ -1167,7 +1124,7 @@ void usb_gadget_udc_reset(struct usb_gadget *gadget,
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
 
 /**
- * usb_gadget_udc_start_locked - tells usb device controller to start up
+ * usb_gadget_udc_start - tells usb device controller to start up
  * @udc: The UDC to be started
  *
  * This call is issued by the UDC Class driver when it's about
@@ -1178,11 +1135,8 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  * necessary to have it powered on.
  *
  * Returns zero on success, else negative errno.
- *
- * Caller should acquire connect_lock before invoking this function.
  */
-static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
-	__must_hold(&udc->connect_lock)
+static inline int usb_gadget_udc_start(struct usb_udc *udc)
 {
 	int ret;
 
@@ -1199,7 +1153,7 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
 }
 
 /**
- * usb_gadget_udc_stop_locked - tells usb device controller we don't need it anymore
+ * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
  * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
@@ -1208,11 +1162,8 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
  * The details are implementation specific, but it can go as
  * far as powering off UDC completely and disable its data
  * line pullups.
- *
- * Caller should acquire connect lock before invoking this function.
  */
-static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
-	__must_hold(&udc->connect_lock)
+static inline void usb_gadget_udc_stop(struct usb_udc *udc)
 {
 	if (!udc->started) {
 		dev_err(&udc->dev, "UDC had already stopped\n");
@@ -1371,7 +1322,6 @@ int usb_add_gadget(struct usb_gadget *gadget)
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
-	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
 
@@ -1573,15 +1523,11 @@ static int gadget_bind_driver(struct device *dev)
 	if (ret)
 		goto err_bind;
 
-	mutex_lock(&udc->connect_lock);
-	ret = usb_gadget_udc_start_locked(udc);
-	if (ret) {
-		mutex_unlock(&udc->connect_lock);
+	ret = usb_gadget_udc_start(udc);
+	if (ret)
 		goto err_start;
-	}
 	usb_gadget_enable_async_callbacks(udc);
-	usb_udc_connect_control_locked(udc);
-	mutex_unlock(&udc->connect_lock);
+	usb_udc_connect_control(udc);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -1612,14 +1558,12 @@ static void gadget_unbind_driver(struct device *dev)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 
-	mutex_lock(&udc->connect_lock);
-	usb_gadget_disconnect_locked(gadget);
+	usb_gadget_disconnect(gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)
 		synchronize_irq(gadget->irq);
 	udc->driver->unbind(gadget);
-	usb_gadget_udc_stop_locked(udc);
-	mutex_unlock(&udc->connect_lock);
+	usb_gadget_udc_stop(udc);
 
 	mutex_lock(&udc_lock);
 	driver->is_bound = false;
@@ -1705,15 +1649,11 @@ static ssize_t soft_connect_store(struct device *dev,
 	}
 
 	if (sysfs_streq(buf, "connect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_udc_start_locked(udc);
-		usb_gadget_connect_locked(udc->gadget);
-		mutex_unlock(&udc->connect_lock);
+		usb_gadget_udc_start(udc);
+		usb_gadget_connect(udc->gadget);
 	} else if (sysfs_streq(buf, "disconnect")) {
-		mutex_lock(&udc->connect_lock);
-		usb_gadget_disconnect_locked(udc->gadget);
-		usb_gadget_udc_stop_locked(udc);
-		mutex_unlock(&udc->connect_lock);
+		usb_gadget_disconnect(udc->gadget);
+		usb_gadget_udc_stop(udc);
 	} else {
 		dev_err(dev, "unsupported command '%s'\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

