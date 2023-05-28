Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EB3713E02
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjE1TbA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjE1Ta7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:30:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B5A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:30:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5858E61D57
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75362C433D2;
        Sun, 28 May 2023 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302257;
        bh=x1p+YrBH41T01P2D/oQylsO7bcb7MlE7vKDFLUN4ytk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzC/2BlJOF2kHhG33pErw/x7wMMO0UKh4MeqhgVaLZ6PRojeXImNb2aPLVakcsIs+
         rECSsjQlKUJeKAfthiPAdSsuQDJV13JcGPlVcXf4XoImPfJny4ZdLoII4hAaTr33Qk
         YY2/+Lf/S9PXlEaB+qDxKsJxRINLwlTJzIOAmFnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Helge Deller <deller@gmx.de>,
        syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmail.com
Subject: [PATCH 6.3 061/127] fbdev: udlfb: Fix endpoint check
Date:   Sun, 28 May 2023 20:10:37 +0100
Message-Id: <20230528190838.375519738@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit ed9de4ed39875706607fb08118a58344ae6c5f42 upstream.

The syzbot fuzzer detected a problem in the udlfb driver, caused by an
endpoint not having the expected type:

usb 1-1: Read EDID byte 0 failed: -71
usb 1-1: Unable to get valid EDID from device/display
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 9 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880
drivers/usb/core/urb.c:504
Modules linked in:
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted
6.4.0-rc1-syzkaller-00016-ga4422ff22142 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google
04/28/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
...
Call Trace:
 <TASK>
 dlfb_submit_urb+0x92/0x180 drivers/video/fbdev/udlfb.c:1980
 dlfb_set_video_mode+0x21f0/0x2950 drivers/video/fbdev/udlfb.c:315
 dlfb_ops_set_par+0x2a7/0x8d0 drivers/video/fbdev/udlfb.c:1111
 dlfb_usb_probe+0x149a/0x2710 drivers/video/fbdev/udlfb.c:1743

The current approach for this issue failed to catch the problem
because it only checks for the existence of a bulk-OUT endpoint; it
doesn't check whether this endpoint is the one that the driver will
actually use.

We can fix the problem by instead checking that the endpoint used by
the driver does exist and is bulk-OUT.

Reported-and-tested-by: syzbot+0e22d63dcebb802b9bc8@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Pavel Skripkin <paskripkin@gmail.com>
Fixes: aaf7dbe07385 ("video: fbdev: udlfb: properly check endpoint type")
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/udlfb.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -27,6 +27,8 @@
 #include <video/udlfb.h>
 #include "edid.h"
 
+#define OUT_EP_NUM	1	/* The endpoint number we will use */
+
 static const struct fb_fix_screeninfo dlfb_fix = {
 	.id =           "udlfb",
 	.type =         FB_TYPE_PACKED_PIXELS,
@@ -1652,7 +1654,7 @@ static int dlfb_usb_probe(struct usb_int
 	struct fb_info *info;
 	int retval;
 	struct usb_device *usbdev = interface_to_usbdev(intf);
-	struct usb_endpoint_descriptor *out;
+	static u8 out_ep[] = {OUT_EP_NUM + USB_DIR_OUT, 0};
 
 	/* usb initialization */
 	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
@@ -1666,9 +1668,9 @@ static int dlfb_usb_probe(struct usb_int
 	dlfb->udev = usb_get_dev(usbdev);
 	usb_set_intfdata(intf, dlfb);
 
-	retval = usb_find_common_endpoints(intf->cur_altsetting, NULL, &out, NULL, NULL);
-	if (retval) {
-		dev_err(&intf->dev, "Device should have at lease 1 bulk endpoint!\n");
+	if (!usb_check_bulk_endpoints(intf, out_ep)) {
+		dev_err(&intf->dev, "Invalid DisplayLink device!\n");
+		retval = -EINVAL;
 		goto error;
 	}
 
@@ -1927,7 +1929,8 @@ retry:
 		}
 
 		/* urb->transfer_buffer_length set to actual before submit */
-		usb_fill_bulk_urb(urb, dlfb->udev, usb_sndbulkpipe(dlfb->udev, 1),
+		usb_fill_bulk_urb(urb, dlfb->udev,
+			usb_sndbulkpipe(dlfb->udev, OUT_EP_NUM),
 			buf, size, dlfb_urb_completion, unode);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 


