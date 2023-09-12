Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611EB79BF8D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjIKWsU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbjIKOZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:25:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4353DDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:25:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89980C433C9;
        Mon, 11 Sep 2023 14:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442319;
        bh=bghmLmgsxnEnmbiJiC9KqDXs/ixVqMVE6Gv1aSBYiLw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4FFes9Y01GUnmYIw045PaXgEtzJVF8I0K4My0bjeG2eWxtvG215tP70KsA6kDbKh
         d111Rd/mpgutmzzy4W7AmuhebtelrPO0fUOlFLuxfRr5wOSE543O1qn6G6fHq9HMjN
         n3E01bQN5+zjvMdNerqDOkxrkM8F+Uz/sDdu95g8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.5 723/739] USB: core: Fix oversight in SuperSpeed initialization
Date:   Mon, 11 Sep 2023 15:48:42 +0200
Message-ID: <20230911134711.275502682@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit 59cf445754566984fd55af19ba7146c76e6627bc upstream.

Commit 85d07c556216 ("USB: core: Unite old scheme and new scheme
descriptor reads") altered the way USB devices are enumerated
following detection, and in the process it messed up the
initialization of SuperSpeed (or faster) devices:

[   31.650759] usb 2-1: new SuperSpeed Plus Gen 2x1 USB device number 2 using xhci_hcd
[   31.663107] usb 2-1: device descriptor read/8, error -71
[   31.952697] usb 2-1: new SuperSpeed Plus Gen 2x1 USB device number 3 using xhci_hcd
[   31.965122] usb 2-1: device descriptor read/8, error -71
[   32.080991] usb usb2-port1: attempt power cycle
...

The problem was caused by the commit forgetting that in SuperSpeed or
faster devices, the device descriptor uses a logarithmic encoding of
the bMaxPacketSize0 value.  (For some reason I thought the 255 case in
the switch statement was meant for these devices, but it isn't -- it
was meant for Wireless USB and is no longer needed.)

We can fix the oversight by testing for buf->bMaxPacketSize0 = 9
(meaning 512, the actual maxpacket size for ep0 on all SuperSpeed
devices) and straightening out the logic that checks and adjusts our
initial guesses of the maxpacket value.

Reported-and-tested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Closes: https://lore.kernel.org/linux-usb/20230810002257.nadxmfmrobkaxgnz@synopsys.com/
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: 85d07c556216 ("USB: core: Unite old scheme and new scheme descriptor reads")
Link: https://lore.kernel.org/r/8809e6c5-59d5-4d2d-ac8f-6d106658ad73@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4757,7 +4757,7 @@ static int get_bMaxPacketSize0(struct us
 				buf, size,
 				initial_descriptor_timeout);
 		switch (buf->bMaxPacketSize0) {
-		case 8: case 16: case 32: case 64: case 255:
+		case 8: case 16: case 32: case 64: case 9:
 			if (buf->bDescriptorType == USB_DT_DEVICE) {
 				rc = buf->bMaxPacketSize0;
 				break;
@@ -5056,23 +5056,35 @@ hub_port_init(struct usb_hub *hub, struc
 	if (retval)
 		goto fail;
 
-	if (maxp0 == 0xff || udev->speed >= USB_SPEED_SUPER)
-		i = 512;
-	else
-		i = maxp0;
-	if (usb_endpoint_maxp(&udev->ep0.desc) != i) {
-		if (udev->speed == USB_SPEED_LOW ||
-				!(i == 8 || i == 16 || i == 32 || i == 64)) {
-			dev_err(&udev->dev, "Invalid ep0 maxpacket: %d\n", i);
-			retval = -EMSGSIZE;
-			goto fail;
-		}
+	/*
+	 * Check the ep0 maxpacket guess and correct it if necessary.
+	 * maxp0 is the value stored in the device descriptor;
+	 * i is the value it encodes (logarithmic for SuperSpeed or greater).
+	 */
+	i = maxp0;
+	if (udev->speed >= USB_SPEED_SUPER) {
+		if (maxp0 <= 16)
+			i = 1 << maxp0;
+		else
+			i = 0;		/* Invalid */
+	}
+	if (usb_endpoint_maxp(&udev->ep0.desc) == i) {
+		;	/* Initial ep0 maxpacket guess is right */
+	} else if ((udev->speed == USB_SPEED_FULL ||
+				udev->speed == USB_SPEED_HIGH) &&
+			(i == 8 || i == 16 || i == 32 || i == 64)) {
+		/* Initial guess is wrong; use the descriptor's value */
 		if (udev->speed == USB_SPEED_FULL)
 			dev_dbg(&udev->dev, "ep0 maxpacket = %d\n", i);
 		else
 			dev_warn(&udev->dev, "Using ep0 maxpacket: %d\n", i);
 		udev->ep0.desc.wMaxPacketSize = cpu_to_le16(i);
 		usb_ep0_reinit(udev);
+	} else {
+		/* Initial guess is wrong and descriptor's value is invalid */
+		dev_err(&udev->dev, "Invalid ep0 maxpacket: %d\n", maxp0);
+		retval = -EMSGSIZE;
+		goto fail;
 	}
 
 	descr = usb_get_device_descriptor(udev);


