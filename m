Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7809879ADD8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344525AbjIKVOV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjIKPAG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:00:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78B91B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:00:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ABBC433C9;
        Mon, 11 Sep 2023 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444400;
        bh=VjLRPGSpCVU8SbzpsxOS/+r3pd7dU0fvmi7WiDKvZo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+FLDsWHRegs6QhLAPa/h4Xq6Wv/la9oBNS76Q77Bfs9WCV66rqPHG5OQZIMgysQO
         h7iG14nxNXs7Ljf3pyu7y/EXJpHJIPBJULDH0P4T/Bxy8i5BucPMEhsq3HsHdW6/RN
         CIUdinB74ljmgjn//O2QpWLGPsSFEq2qJ9wHcC4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 6.4 717/737] USB: core: Unite old scheme and new scheme descriptor reads
Date:   Mon, 11 Sep 2023 15:49:36 +0200
Message-ID: <20230911134710.544039315@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 85d07c55621676d47d873d2749b88f783cd4d5a1 upstream.

In preparation for reworking the usb_get_device_descriptor() routine,
it is desirable to unite the two different code paths responsible for
initially determining endpoint 0's maximum packet size in a newly
discovered USB device.  Making this determination presents a
chicken-and-egg sort of problem, in that the only way to learn the
maxpacket value is to get it from the device descriptor retrieved from
the device, but communicating with the device to retrieve a descriptor
requires us to know beforehand the ep0 maxpacket size.

In practice this problem is solved in two different ways, referred to
in hub.c as the "old scheme" and the "new scheme".  The old scheme
(which is the approach recommended by the USB-2 spec) involves asking
the device to send just the first eight bytes of its device
descriptor.  Such a transfer uses packets containing no more than
eight bytes each, and every USB device must have an ep0 maxpacket size
>= 8, so this should succeed.  Since the bMaxPacketSize0 field of the
device descriptor lies within the first eight bytes, this is all we
need.

The new scheme is an imitation of the technique used in an early
Windows USB implementation, giving it the happy advantage of working
with a wide variety of devices (some of them at the time would not
work with the old scheme, although that's probably less true now).  It
involves making an initial guess of the ep0 maxpacket size, asking the
device to send up to 64 bytes worth of its device descriptor (which is
only 18 bytes long), and then resetting the device to clear any error
condition that might have resulted from the guess being wrong.  The
initial guess is determined by the connection speed; it should be
correct in all cases other than full speed, for which the allowed
values are 8, 16, 32, and 64 (in this case the initial guess is 64).

The reason for this patch is that the old- and new-scheme parts of
hub_port_init() use different code paths, one involving
usb_get_device_descriptor() and one not, for their initial reads of
the device descriptor.  Since these reads have essentially the same
purpose and are made under essentially the same circumstances, this is
illogical.  It makes more sense to have both of them use a common
subroutine.

This subroutine does basically what the new scheme's code did, because
that approach is more general than the one used by the old scheme.  It
only needs to know how many bytes to transfer and whether or not it is
being called for the first iteration of a retry loop (in case of
certain time-out errors).  There are two main differences from the
former code:

	We initialize the bDescriptorType field of the transfer buffer
	to 0 before performing the transfer, to avoid possibly
	accessing an uninitialized value afterward.

	We read the device descriptor into a temporary buffer rather
	than storing it directly into udev->descriptor, which the old
	scheme implementation used to do.

Since the whole point of this first read of the device descriptor is
to determine the bMaxPacketSize0 value, that is what the new routine
returns (or an error code).  The value is stored in a local variable
rather than in udev->descriptor.  As a side effect, this necessitates
moving a section of code that checks the bcdUSB field for SuperSpeed
devices until after the full device descriptor has been retrieved.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/495cb5d4-f956-4f4a-a875-1e67e9489510@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c |  173 ++++++++++++++++++++++++++-----------------------
 1 file changed, 94 insertions(+), 79 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4703,6 +4703,67 @@ static int hub_enable_device(struct usb_
 	return hcd->driver->enable_device(hcd, udev);
 }
 
+/*
+ * Get the bMaxPacketSize0 value during initialization by reading the
+ * device's device descriptor.  Since we don't already know this value,
+ * the transfer is unsafe and it ignores I/O errors, only testing for
+ * reasonable received values.
+ *
+ * For "old scheme" initialization, size will be 8 so we read just the
+ * start of the device descriptor, which should work okay regardless of
+ * the actual bMaxPacketSize0 value.  For "new scheme" initialization,
+ * size will be 64 (and buf will point to a sufficiently large buffer),
+ * which might not be kosher according to the USB spec but it's what
+ * Windows does and what many devices expect.
+ *
+ * Returns: bMaxPacketSize0 or a negative error code.
+ */
+static int get_bMaxPacketSize0(struct usb_device *udev,
+		struct usb_device_descriptor *buf, int size, bool first_time)
+{
+	int i, rc;
+
+	/*
+	 * Retry on all errors; some devices are flakey.
+	 * 255 is for WUSB devices, we actually need to use
+	 * 512 (WUSB1.0[4.8.1]).
+	 */
+	for (i = 0; i < GET_MAXPACKET0_TRIES; ++i) {
+		/* Start with invalid values in case the transfer fails */
+		buf->bDescriptorType = buf->bMaxPacketSize0 = 0;
+		rc = usb_control_msg(udev, usb_rcvaddr0pipe(),
+				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
+				USB_DT_DEVICE << 8, 0,
+				buf, size,
+				initial_descriptor_timeout);
+		switch (buf->bMaxPacketSize0) {
+		case 8: case 16: case 32: case 64: case 255:
+			if (buf->bDescriptorType == USB_DT_DEVICE) {
+				rc = buf->bMaxPacketSize0;
+				break;
+			}
+			fallthrough;
+		default:
+			if (rc >= 0)
+				rc = -EPROTO;
+			break;
+		}
+
+		/*
+		 * Some devices time out if they are powered on
+		 * when already connected. They need a second
+		 * reset, so return early. But only on the first
+		 * attempt, lest we get into a time-out/reset loop.
+		 */
+		if (rc > 0 || (rc == -ETIMEDOUT && first_time &&
+				udev->speed > USB_SPEED_FULL))
+			break;
+	}
+	return rc;
+}
+
+#define GET_DESCRIPTOR_BUFSIZE	64
+
 /* Reset device, (re)assign address, get device descriptor.
  * Device connection must be stable, no more debouncing needed.
  * Returns device in USB_STATE_ADDRESS, except on error.
@@ -4727,6 +4788,12 @@ hub_port_init(struct usb_hub *hub, struc
 	int			devnum = udev->devnum;
 	const char		*driver_name;
 	bool			do_new_scheme;
+	int			maxp0;
+	struct usb_device_descriptor	*buf;
+
+	buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
+	if (!buf)
+		return -ENOMEM;
 
 	/* root hub ports have a slightly longer reset period
 	 * (from USB 2.0 spec, section 7.1.7.5)
@@ -4846,9 +4913,6 @@ hub_port_init(struct usb_hub *hub, struc
 		}
 
 		if (do_new_scheme) {
-			struct usb_device_descriptor *buf;
-			int r = 0;
-
 			retval = hub_enable_device(udev);
 			if (retval < 0) {
 				dev_err(&udev->dev,
@@ -4857,52 +4921,8 @@ hub_port_init(struct usb_hub *hub, struc
 				goto fail;
 			}
 
-#define GET_DESCRIPTOR_BUFSIZE	64
-			buf = kmalloc(GET_DESCRIPTOR_BUFSIZE, GFP_NOIO);
-			if (!buf) {
-				retval = -ENOMEM;
-				continue;
-			}
-
-			/* Retry on all errors; some devices are flakey.
-			 * 255 is for WUSB devices, we actually need to use
-			 * 512 (WUSB1.0[4.8.1]).
-			 */
-			for (operations = 0; operations < GET_MAXPACKET0_TRIES;
-					++operations) {
-				buf->bMaxPacketSize0 = 0;
-				r = usb_control_msg(udev, usb_rcvaddr0pipe(),
-					USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
-					USB_DT_DEVICE << 8, 0,
-					buf, GET_DESCRIPTOR_BUFSIZE,
-					initial_descriptor_timeout);
-				switch (buf->bMaxPacketSize0) {
-				case 8: case 16: case 32: case 64: case 255:
-					if (buf->bDescriptorType ==
-							USB_DT_DEVICE) {
-						r = 0;
-						break;
-					}
-					fallthrough;
-				default:
-					if (r == 0)
-						r = -EPROTO;
-					break;
-				}
-				/*
-				 * Some devices time out if they are powered on
-				 * when already connected. They need a second
-				 * reset. But only on the first attempt,
-				 * lest we get into a time out/reset loop
-				 */
-				if (r == 0 || (r == -ETIMEDOUT &&
-						retries == 0 &&
-						udev->speed > USB_SPEED_FULL))
-					break;
-			}
-			udev->descriptor.bMaxPacketSize0 =
-					buf->bMaxPacketSize0;
-			kfree(buf);
+			maxp0 = get_bMaxPacketSize0(udev, buf,
+					GET_DESCRIPTOR_BUFSIZE, retries == 0);
 
 			retval = hub_port_reset(hub, port1, udev, delay, false);
 			if (retval < 0)		/* error or disconnect */
@@ -4913,14 +4933,13 @@ hub_port_init(struct usb_hub *hub, struc
 				retval = -ENODEV;
 				goto fail;
 			}
-			if (r) {
-				if (r != -ENODEV)
+			if (maxp0 < 0) {
+				if (maxp0 != -ENODEV)
 					dev_err(&udev->dev, "device descriptor read/64, error %d\n",
-							r);
-				retval = -EMSGSIZE;
+							maxp0);
+				retval = maxp0;
 				continue;
 			}
-#undef GET_DESCRIPTOR_BUFSIZE
 		}
 
 		/*
@@ -4966,19 +4985,17 @@ hub_port_init(struct usb_hub *hub, struc
 				break;
 		}
 
-		retval = usb_get_device_descriptor(udev, 8);
-		if (retval < 8) {
+		/* !do_new_scheme || wusb */
+		maxp0 = get_bMaxPacketSize0(udev, buf, 8, retries == 0);
+		if (maxp0 < 0) {
+			retval = maxp0;
 			if (retval != -ENODEV)
 				dev_err(&udev->dev,
 					"device descriptor read/8, error %d\n",
 					retval);
-			if (retval >= 0)
-				retval = -EMSGSIZE;
 		} else {
 			u32 delay;
 
-			retval = 0;
-
 			delay = udev->parent->hub_delay;
 			udev->hub_delay = min_t(u32, delay,
 						USB_TP_TRANSMISSION_DELAY_MAX);
@@ -4995,27 +5012,10 @@ hub_port_init(struct usb_hub *hub, struc
 	if (retval)
 		goto fail;
 
-	/*
-	 * Some superspeed devices have finished the link training process
-	 * and attached to a superspeed hub port, but the device descriptor
-	 * got from those devices show they aren't superspeed devices. Warm
-	 * reset the port attached by the devices can fix them.
-	 */
-	if ((udev->speed >= USB_SPEED_SUPER) &&
-			(le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) {
-		dev_err(&udev->dev, "got a wrong device descriptor, "
-				"warm reset device\n");
-		hub_port_reset(hub, port1, udev,
-				HUB_BH_RESET_TIME, true);
-		retval = -EINVAL;
-		goto fail;
-	}
-
-	if (udev->descriptor.bMaxPacketSize0 == 0xff ||
-			udev->speed >= USB_SPEED_SUPER)
+	if (maxp0 == 0xff || udev->speed >= USB_SPEED_SUPER)
 		i = 512;
 	else
-		i = udev->descriptor.bMaxPacketSize0;
+		i = maxp0;
 	if (usb_endpoint_maxp(&udev->ep0.desc) != i) {
 		if (udev->speed == USB_SPEED_LOW ||
 				!(i == 8 || i == 16 || i == 32 || i == 64)) {
@@ -5041,6 +5041,20 @@ hub_port_init(struct usb_hub *hub, struc
 		goto fail;
 	}
 
+	/*
+	 * Some superspeed devices have finished the link training process
+	 * and attached to a superspeed hub port, but the device descriptor
+	 * got from those devices show they aren't superspeed devices. Warm
+	 * reset the port attached by the devices can fix them.
+	 */
+	if ((udev->speed >= USB_SPEED_SUPER) &&
+			(le16_to_cpu(udev->descriptor.bcdUSB) < 0x0300)) {
+		dev_err(&udev->dev, "got a wrong device descriptor, warm reset device\n");
+		hub_port_reset(hub, port1, udev, HUB_BH_RESET_TIME, true);
+		retval = -EINVAL;
+		goto fail;
+	}
+
 	usb_detect_quirks(udev);
 
 	if (udev->wusb == 0 && le16_to_cpu(udev->descriptor.bcdUSB) >= 0x0201) {
@@ -5063,6 +5077,7 @@ fail:
 		hub_port_disable(hub, port1, 0);
 		update_devnum(udev, devnum);	/* for disconnect processing */
 	}
+	kfree(buf);
 	return retval;
 }
 


