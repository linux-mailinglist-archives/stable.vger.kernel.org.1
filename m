Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3802873529B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFSKgm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjFSKgT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A4F102
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7242960B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8112DC433C8;
        Mon, 19 Jun 2023 10:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170974;
        bh=8ejJOWUamRHU1/OEKL9bsi7lvEqEHq8w3OWHYGXMIhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6f3v9F62N9K2kQO+8xEkP4GsHM+kxQv6/W7XWlHDfALp5uVVYQU2tE/NzczpnkAA
         +ZorSFtT39V6j1Fa8/6diSYj6e7vWUlPgKHYJZucyGgBn1jzDVw2eBn28VXUXUBZbA
         9asXNTjrqkCjTHRrOWAtYdRmtxWlhftGBxncgBRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Badhri Jagan Sridharan <badhri@google.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6.3 103/187] usb: gadget: udc: core: Prevent soft_connect_store() race
Date:   Mon, 19 Jun 2023 12:28:41 +0200
Message-ID: <20230619102202.562325527@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Badhri Jagan Sridharan <badhri@google.com>

commit 286d9975a838d0a54da049765fa1d1fb96b89682 upstream.

usb_udc_connect_control(), soft_connect_store() and
usb_gadget_deactivate() can potentially race against each other to invoke
usb_gadget_connect()/usb_gadget_disconnect(). To prevent this, guard
udc->started, gadget->allow_connect, gadget->deactivate and
gadget->connect with connect_lock so that ->pullup() is only invoked when
the gadget is bound, started and not deactivated. The routines
usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
usb_udc_connect_control_locked(), usb_gadget_udc_start_locked(),
usb_gadget_udc_stop_locked() are called with this lock held.

An earlier version of this commit was reverted due to the crash reported in
https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/.
commit 16737e78d190 ("usb: gadget: udc: core: Offload usb_udc_vbus_handler processing")
addresses the crash reported.

Cc: stable@vger.kernel.org
Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Message-ID: <20230609010227.978661-2-badhri@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/core.c |  155 ++++++++++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 49 deletions(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -40,6 +40,11 @@ static struct bus_type gadget_bus_type;
  * @allow_connect: Indicates whether UDC is allowed to be pulled up.
  * Set/cleared by gadget_(un)bind_driver() after gadget driver is bound or
  * unbound.
+ * @connect_lock: protects udc->started, gadget->connect,
+ * gadget->allow_connect and gadget->deactivate. The routines
+ * usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
+ * usb_udc_connect_control_locked(), usb_gadget_udc_start_locked() and
+ * usb_gadget_udc_stop_locked() are called with this lock held.
  *
  * This represents the internal data structure which is used by the UDC-class
  * to hold information about udc driver and gadget together.
@@ -53,6 +58,7 @@ struct usb_udc {
 	bool				started;
 	bool				allow_connect;
 	struct work_struct		vbus_work;
+	struct mutex			connect_lock;
 };
 
 static struct class *udc_class;
@@ -665,17 +671,8 @@ out:
 }
 EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
 
-/**
- * usb_gadget_connect - software-controlled connect to USB host
- * @gadget:the peripheral being connected
- *
- * Enables the D+ (or potentially D-) pullup.  The host will start
- * enumerating this gadget when the pullup is active and a VBUS session
- * is active (the link is powered).
- *
- * Returns zero on success, else negative errno.
- */
-int usb_gadget_connect(struct usb_gadget *gadget)
+static int usb_gadget_connect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
 
@@ -684,10 +681,12 @@ int usb_gadget_connect(struct usb_gadget
 		goto out;
 	}
 
-	if (gadget->deactivated || !gadget->udc->allow_connect) {
+	if (gadget->deactivated || !gadget->udc->allow_connect || !gadget->udc->started) {
 		/*
-		 * If gadget is deactivated we only save new state.
-		 * Gadget will be connected automatically after activation.
+		 * If the gadget isn't usable (because it is deactivated,
+		 * unbound, or not yet started), we only save the new state.
+		 * The gadget will be connected automatically when it is
+		 * activated/bound/started.
 		 */
 		gadget->connected = true;
 		goto out;
@@ -702,22 +701,31 @@ out:
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(usb_gadget_connect);
 
 /**
- * usb_gadget_disconnect - software-controlled disconnect from USB host
- * @gadget:the peripheral being disconnected
- *
- * Disables the D+ (or potentially D-) pullup, which the host may see
- * as a disconnect (when a VBUS session is active).  Not all systems
- * support software pullup controls.
+ * usb_gadget_connect - software-controlled connect to USB host
+ * @gadget:the peripheral being connected
  *
- * Following a successful disconnect, invoke the ->disconnect() callback
- * for the current gadget driver so that UDC drivers don't need to.
+ * Enables the D+ (or potentially D-) pullup.  The host will start
+ * enumerating this gadget when the pullup is active and a VBUS session
+ * is active (the link is powered).
  *
  * Returns zero on success, else negative errno.
  */
-int usb_gadget_disconnect(struct usb_gadget *gadget)
+int usb_gadget_connect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	ret = usb_gadget_connect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_connect);
+
+static int usb_gadget_disconnect_locked(struct usb_gadget *gadget)
+	__must_hold(&gadget->udc->connect_lock)
 {
 	int ret = 0;
 
@@ -729,7 +737,7 @@ int usb_gadget_disconnect(struct usb_gad
 	if (!gadget->connected)
 		goto out;
 
-	if (gadget->deactivated) {
+	if (gadget->deactivated || !gadget->udc->started) {
 		/*
 		 * If gadget is deactivated we only save new state.
 		 * Gadget will stay disconnected after activation.
@@ -752,6 +760,30 @@ out:
 
 	return ret;
 }
+
+/**
+ * usb_gadget_disconnect - software-controlled disconnect from USB host
+ * @gadget:the peripheral being disconnected
+ *
+ * Disables the D+ (or potentially D-) pullup, which the host may see
+ * as a disconnect (when a VBUS session is active).  Not all systems
+ * support software pullup controls.
+ *
+ * Following a successful disconnect, invoke the ->disconnect() callback
+ * for the current gadget driver so that UDC drivers don't need to.
+ *
+ * Returns zero on success, else negative errno.
+ */
+int usb_gadget_disconnect(struct usb_gadget *gadget)
+{
+	int ret;
+
+	mutex_lock(&gadget->udc->connect_lock);
+	ret = usb_gadget_disconnect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
 
 /**
@@ -769,13 +801,14 @@ int usb_gadget_deactivate(struct usb_gad
 {
 	int ret = 0;
 
+	mutex_lock(&gadget->udc->connect_lock);
 	if (gadget->deactivated)
-		goto out;
+		goto unlock;
 
 	if (gadget->connected) {
-		ret = usb_gadget_disconnect(gadget);
+		ret = usb_gadget_disconnect_locked(gadget);
 		if (ret)
-			goto out;
+			goto unlock;
 
 		/*
 		 * If gadget was being connected before deactivation, we want
@@ -785,7 +818,8 @@ int usb_gadget_deactivate(struct usb_gad
 	}
 	gadget->deactivated = true;
 
-out:
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
 	trace_usb_gadget_deactivate(gadget, ret);
 
 	return ret;
@@ -805,8 +839,9 @@ int usb_gadget_activate(struct usb_gadge
 {
 	int ret = 0;
 
+	mutex_lock(&gadget->udc->connect_lock);
 	if (!gadget->deactivated)
-		goto out;
+		goto unlock;
 
 	gadget->deactivated = false;
 
@@ -815,9 +850,11 @@ int usb_gadget_activate(struct usb_gadge
 	 * while it was being deactivated, we call usb_gadget_connect().
 	 */
 	if (gadget->connected)
-		ret = usb_gadget_connect(gadget);
+		ret = usb_gadget_connect_locked(gadget);
+	mutex_unlock(&gadget->udc->connect_lock);
 
-out:
+unlock:
+	mutex_unlock(&gadget->udc->connect_lock);
 	trace_usb_gadget_activate(gadget, ret);
 
 	return ret;
@@ -1056,19 +1093,22 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
 /* ------------------------------------------------------------------------- */
 
-static void usb_udc_connect_control(struct usb_udc *udc)
+/* Acquire connect_lock before calling this function. */
+static void usb_udc_connect_control_locked(struct usb_udc *udc) __must_hold(&udc->connect_lock)
 {
 	if (udc->vbus)
-		usb_gadget_connect(udc->gadget);
+		usb_gadget_connect_locked(udc->gadget);
 	else
-		usb_gadget_disconnect(udc->gadget);
+		usb_gadget_disconnect_locked(udc->gadget);
 }
 
 static void vbus_event_work(struct work_struct *work)
 {
 	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
 
-	usb_udc_connect_control(udc);
+	mutex_lock(&udc->connect_lock);
+	usb_udc_connect_control_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 }
 
 /**
@@ -1117,7 +1157,7 @@ void usb_gadget_udc_reset(struct usb_gad
 EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
 
 /**
- * usb_gadget_udc_start - tells usb device controller to start up
+ * usb_gadget_udc_start_locked - tells usb device controller to start up
  * @udc: The UDC to be started
  *
  * This call is issued by the UDC Class driver when it's about
@@ -1128,8 +1168,11 @@ EXPORT_SYMBOL_GPL(usb_gadget_udc_reset);
  * necessary to have it powered on.
  *
  * Returns zero on success, else negative errno.
+ *
+ * Caller should acquire connect_lock before invoking this function.
  */
-static inline int usb_gadget_udc_start(struct usb_udc *udc)
+static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
+	__must_hold(&udc->connect_lock)
 {
 	int ret;
 
@@ -1146,7 +1189,7 @@ static inline int usb_gadget_udc_start(s
 }
 
 /**
- * usb_gadget_udc_stop - tells usb device controller we don't need it anymore
+ * usb_gadget_udc_stop_locked - tells usb device controller we don't need it anymore
  * @udc: The UDC to be stopped
  *
  * This call is issued by the UDC Class driver after calling
@@ -1155,8 +1198,11 @@ static inline int usb_gadget_udc_start(s
  * The details are implementation specific, but it can go as
  * far as powering off UDC completely and disable its data
  * line pullups.
+ *
+ * Caller should acquire connect lock before invoking this function.
  */
-static inline void usb_gadget_udc_stop(struct usb_udc *udc)
+static inline void usb_gadget_udc_stop_locked(struct usb_udc *udc)
+	__must_hold(&udc->connect_lock)
 {
 	if (!udc->started) {
 		dev_err(&udc->dev, "UDC had already stopped\n");
@@ -1315,6 +1361,7 @@ int usb_add_gadget(struct usb_gadget *ga
 
 	udc->gadget = gadget;
 	gadget->udc = udc;
+	mutex_init(&udc->connect_lock);
 
 	udc->started = false;
 
@@ -1518,12 +1565,16 @@ static int gadget_bind_driver(struct dev
 	if (ret)
 		goto err_bind;
 
-	ret = usb_gadget_udc_start(udc);
-	if (ret)
+	mutex_lock(&udc->connect_lock);
+	ret = usb_gadget_udc_start_locked(udc);
+	if (ret) {
+		mutex_unlock(&udc->connect_lock);
 		goto err_start;
+	}
 	usb_gadget_enable_async_callbacks(udc);
 	udc->allow_connect = true;
-	usb_udc_connect_control(udc);
+	usb_udc_connect_control_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 	return 0;
@@ -1556,12 +1607,14 @@ static void gadget_unbind_driver(struct
 
 	udc->allow_connect = false;
 	cancel_work_sync(&udc->vbus_work);
-	usb_gadget_disconnect(gadget);
+	mutex_lock(&udc->connect_lock);
+	usb_gadget_disconnect_locked(gadget);
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)
 		synchronize_irq(gadget->irq);
 	udc->driver->unbind(gadget);
-	usb_gadget_udc_stop(udc);
+	usb_gadget_udc_stop_locked(udc);
+	mutex_unlock(&udc->connect_lock);
 
 	mutex_lock(&udc_lock);
 	driver->is_bound = false;
@@ -1647,11 +1700,15 @@ static ssize_t soft_connect_store(struct
 	}
 
 	if (sysfs_streq(buf, "connect")) {
-		usb_gadget_udc_start(udc);
-		usb_gadget_connect(udc->gadget);
+		mutex_lock(&udc->connect_lock);
+		usb_gadget_udc_start_locked(udc);
+		usb_gadget_connect_locked(udc->gadget);
+		mutex_unlock(&udc->connect_lock);
 	} else if (sysfs_streq(buf, "disconnect")) {
-		usb_gadget_disconnect(udc->gadget);
-		usb_gadget_udc_stop(udc);
+		mutex_lock(&udc->connect_lock);
+		usb_gadget_disconnect_locked(udc->gadget);
+		usb_gadget_udc_stop_locked(udc);
+		mutex_unlock(&udc->connect_lock);
 	} else {
 		dev_err(dev, "unsupported command '%s'\n", buf);
 		ret = -EINVAL;


