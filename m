Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4085A7A389A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbjIQThm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbjIQTh1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:37:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CE4103
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:37:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91FEC433C7;
        Sun, 17 Sep 2023 19:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979441;
        bh=NFGLPXotMlmt/ogv0HcxmMRi+Tvf4FVY3Nf4dGmM8LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QohPknpaytKGukyOmVX66b8YkYzh87Jmgf73gm1E8d81C/pgBci12yTd58KyVsJo5
         MHz31QWJtP1d6nnr2+GnX2ncI/TThrRgL3Ef0kDfB8VHk/axnWsByMw3UsStd8E19H
         IRvnGtuaeDpCVTPbXo9u1jlYx7zerNULVsZ1wZoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.10 306/406] USB: core: Change usb_get_device_descriptor() API
Date:   Sun, 17 Sep 2023 21:12:40 +0200
Message-ID: <20230917191109.387438566@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit de28e469da75359a2bb8cd8778b78aa64b1be1f4 upstream.

The usb_get_device_descriptor() routine reads the device descriptor
from the udev device and stores it directly in udev->descriptor.  This
interface is error prone, because the USB subsystem expects in-memory
copies of a device's descriptors to be immutable once the device has
been initialized.

The interface is changed so that the device descriptor is left in a
kmalloc-ed buffer, not copied into the usb_device structure.  A
pointer to the buffer is returned to the caller, who is then
responsible for kfree-ing it.  The corresponding changes needed in the
various callers are fairly small.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/d0111bb6-56c1-4f90-adf2-6cfe152f6561@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hcd.c     |   10 +++++++---
 drivers/usb/core/hub.c     |   44 +++++++++++++++++++++++---------------------
 drivers/usb/core/message.c |   29 ++++++++++++-----------------
 drivers/usb/core/usb.h     |    4 ++--
 4 files changed, 44 insertions(+), 43 deletions(-)

--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -982,6 +982,7 @@ static int register_root_hub(struct usb_
 {
 	struct device *parent_dev = hcd->self.controller;
 	struct usb_device *usb_dev = hcd->self.root_hub;
+	struct usb_device_descriptor *descr;
 	const int devnum = 1;
 	int retval;
 
@@ -993,13 +994,16 @@ static int register_root_hub(struct usb_
 	mutex_lock(&usb_bus_idr_lock);
 
 	usb_dev->ep0.desc.wMaxPacketSize = cpu_to_le16(64);
-	retval = usb_get_device_descriptor(usb_dev, USB_DT_DEVICE_SIZE);
-	if (retval != sizeof usb_dev->descriptor) {
+	descr = usb_get_device_descriptor(usb_dev);
+	if (IS_ERR(descr)) {
+		retval = PTR_ERR(descr);
 		mutex_unlock(&usb_bus_idr_lock);
 		dev_dbg (parent_dev, "can't read %s device descriptor %d\n",
 				dev_name(&usb_dev->dev), retval);
-		return (retval < 0) ? retval : -EMSGSIZE;
+		return retval;
 	}
+	usb_dev->descriptor = *descr;
+	kfree(descr);
 
 	if (le16_to_cpu(usb_dev->descriptor.bcdUSB) >= 0x0201) {
 		retval = usb_get_bos_descriptor(usb_dev);
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2646,12 +2646,17 @@ int usb_authorize_device(struct usb_devi
 	}
 
 	if (usb_dev->wusb) {
-		result = usb_get_device_descriptor(usb_dev, sizeof(usb_dev->descriptor));
-		if (result < 0) {
+		struct usb_device_descriptor *descr;
+
+		descr = usb_get_device_descriptor(usb_dev);
+		if (IS_ERR(descr)) {
+			result = PTR_ERR(descr);
 			dev_err(&usb_dev->dev, "can't re-read device descriptor for "
 				"authorization: %d\n", result);
 			goto error_device_descriptor;
 		}
+		usb_dev->descriptor = *descr;
+		kfree(descr);
 	}
 
 	usb_dev->authorized = 1;
@@ -4680,7 +4685,7 @@ hub_port_init(struct usb_hub *hub, struc
 	const char		*driver_name;
 	bool			do_new_scheme;
 	int			maxp0;
-	struct usb_device_descriptor	*buf;
+	struct usb_device_descriptor	*buf, *descr;
 
 	buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
 	if (!buf)
@@ -4913,15 +4918,16 @@ hub_port_init(struct usb_hub *hub, struc
 		usb_ep0_reinit(udev);
 	}
 
-	retval = usb_get_device_descriptor(udev, USB_DT_DEVICE_SIZE);
-	if (retval < (signed)sizeof(udev->descriptor)) {
+	descr = usb_get_device_descriptor(udev);
+	if (IS_ERR(descr)) {
+		retval = PTR_ERR(descr);
 		if (retval != -ENODEV)
 			dev_err(&udev->dev, "device descriptor read/all, error %d\n",
 					retval);
-		if (retval >= 0)
-			retval = -ENOMSG;
 		goto fail;
 	}
+	udev->descriptor = *descr;
+	kfree(descr);
 
 	/*
 	 * Some superspeed devices have finished the link training process
@@ -5038,7 +5044,7 @@ hub_power_remaining(struct usb_hub *hub)
 
 
 static int descriptors_changed(struct usb_device *udev,
-		struct usb_device_descriptor *old_device_descriptor,
+		struct usb_device_descriptor *new_device_descriptor,
 		struct usb_host_bos *old_bos)
 {
 	int		changed = 0;
@@ -5049,8 +5055,8 @@ static int descriptors_changed(struct us
 	int		length;
 	char		*buf;
 
-	if (memcmp(&udev->descriptor, old_device_descriptor,
-			sizeof(*old_device_descriptor)) != 0)
+	if (memcmp(&udev->descriptor, new_device_descriptor,
+			sizeof(*new_device_descriptor)) != 0)
 		return 1;
 
 	if ((old_bos && !udev->bos) || (!old_bos && udev->bos))
@@ -5370,9 +5376,8 @@ static void hub_port_connect_change(stru
 {
 	struct usb_port *port_dev = hub->ports[port1 - 1];
 	struct usb_device *udev = port_dev->child;
-	struct usb_device_descriptor descriptor;
+	struct usb_device_descriptor *descr;
 	int status = -ENODEV;
-	int retval;
 
 	dev_dbg(&port_dev->dev, "status %04x, change %04x, %s\n", portstatus,
 			portchange, portspeed(hub, portstatus));
@@ -5399,23 +5404,20 @@ static void hub_port_connect_change(stru
 			 * changed device descriptors before resuscitating the
 			 * device.
 			 */
-			descriptor = udev->descriptor;
-			retval = usb_get_device_descriptor(udev,
-					sizeof(udev->descriptor));
-			if (retval < 0) {
+			descr = usb_get_device_descriptor(udev);
+			if (IS_ERR(descr)) {
 				dev_dbg(&udev->dev,
-						"can't read device descriptor %d\n",
-						retval);
+						"can't read device descriptor %ld\n",
+						PTR_ERR(descr));
 			} else {
-				if (descriptors_changed(udev, &descriptor,
+				if (descriptors_changed(udev, descr,
 						udev->bos)) {
 					dev_dbg(&udev->dev,
 							"device descriptor has changed\n");
-					/* for disconnect() calls */
-					udev->descriptor = descriptor;
 				} else {
 					status = 0; /* Nothing to do */
 				}
+				kfree(descr);
 			}
 #ifdef CONFIG_PM
 		} else if (udev->state == USB_STATE_SUSPENDED &&
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1039,39 +1039,34 @@ char *usb_cache_string(struct usb_device
 }
 
 /*
- * usb_get_device_descriptor - (re)reads the device descriptor (usbcore)
- * @dev: the device whose device descriptor is being updated
- * @size: how much of the descriptor to read
+ * usb_get_device_descriptor - read the device descriptor
+ * @udev: the device whose device descriptor should be read
  * Context: !in_interrupt ()
  *
- * Updates the copy of the device descriptor stored in the device structure,
- * which dedicates space for this purpose.
- *
  * Not exported, only for use by the core.  If drivers really want to read
  * the device descriptor directly, they can call usb_get_descriptor() with
  * type = USB_DT_DEVICE and index = 0.
  *
- * This call is synchronous, and may not be used in an interrupt context.
- *
- * Return: The number of bytes received on success, or else the status code
- * returned by the underlying usb_control_msg() call.
+ * Returns: a pointer to a dynamically allocated usb_device_descriptor
+ * structure (which the caller must deallocate), or an ERR_PTR value.
  */
-int usb_get_device_descriptor(struct usb_device *dev, unsigned int size)
+struct usb_device_descriptor *usb_get_device_descriptor(struct usb_device *udev)
 {
 	struct usb_device_descriptor *desc;
 	int ret;
 
-	if (size > sizeof(*desc))
-		return -EINVAL;
 	desc = kmalloc(sizeof(*desc), GFP_NOIO);
 	if (!desc)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+
+	ret = usb_get_descriptor(udev, USB_DT_DEVICE, 0, desc, sizeof(*desc));
+	if (ret == sizeof(*desc))
+		return desc;
 
-	ret = usb_get_descriptor(dev, USB_DT_DEVICE, 0, desc, size);
 	if (ret >= 0)
-		memcpy(&dev->descriptor, desc, size);
+		ret = -EMSGSIZE;
 	kfree(desc);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /*
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -42,8 +42,8 @@ extern bool usb_endpoint_is_ignored(stru
 		struct usb_endpoint_descriptor *epd);
 extern int usb_remove_device(struct usb_device *udev);
 
-extern int usb_get_device_descriptor(struct usb_device *dev,
-		unsigned int size);
+extern struct usb_device_descriptor *usb_get_device_descriptor(
+		struct usb_device *udev);
 extern int usb_set_isoch_delay(struct usb_device *dev);
 extern int usb_get_bos_descriptor(struct usb_device *dev);
 extern void usb_release_bos_descriptor(struct usb_device *dev);


