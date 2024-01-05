Return-Path: <stable+bounces-9769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362798250CB
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C083B21806
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B64A22F0C;
	Fri,  5 Jan 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1wBGjbv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C1C22EF0
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A39EC433C8;
	Fri,  5 Jan 2024 09:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446637;
	bh=CNxNhZTuaH2PwzJFQOP8lEbYsPsqJd7NPlrdEe0T4N8=;
	h=Subject:To:From:Date:From;
	b=W1wBGjbvIc1E7ySdB1IZnexFzmSBbCQ9mjdjfsV8vYOCyRP+fCvbCCP2E13o7aw5u
	 gi+lOKavnVmD7f8VsVMSSs1bzUOaL8gxgtknTBYPw+uuFGcEvFCa//ewzBYOHD/yTc
	 ZzLcPoBEzcCIffHLrhrq0/HuDFlVkZTPjg2FQJn0=
Subject: patch "Revert "usb: gadget: f_uvc: change endpoint allocation in" added to usb-next
To: Frank.Li@nxp.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:22:03 +0100
Message-ID: <2024010503-strive-headset-50ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    Revert "usb: gadget: f_uvc: change endpoint allocation in

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 895ee5aefb7e24203de5dffae7ce9a02d78fa3d1 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Sun, 24 Dec 2023 10:38:16 -0500
Subject: Revert "usb: gadget: f_uvc: change endpoint allocation in
 uvc_function_bind()"

This reverts commit 3c5b006f3ee800b4bd9ed37b3a8f271b8560126e.

gadget_is_{super|dual}speed() API check UDC controller capitblity. It
should pass down highest speed endpoint descriptor to UDC controller. So
UDC controller driver can reserve enough resource at check_config(),
especially mult and maxburst. So UDC driver (such as cdns3) can know need
at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal memory for
this uvc functions.

Cc:  <stable@vger.kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20231224153816.1664687-5-Frank.Li@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_uvc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index da5f28e471b0..929666805bd2 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -721,13 +721,29 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 	uvc->enable_interrupt_ep = opts->enable_interrupt_ep;
 
-	ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
+	/*
+	 * gadget_is_{super|dual}speed() API check UDC controller capitblity. It should pass down
+	 * highest speed endpoint descriptor to UDC controller. So UDC controller driver can reserve
+	 * enough resource at check_config(), especially mult and maxburst. So UDC driver (such as
+	 * cdns3) can know need at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal
+	 * memory for this uvc functions. This is the only straightforward method to resolve the UDC
+	 * resource allocation issue in the current gadget framework.
+	 */
+	if (gadget_is_superspeed(c->cdev->gadget))
+		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
+					  &uvc_ss_streaming_comp);
+	else if (gadget_is_dualspeed(cdev->gadget))
+		ep = usb_ep_autoconfig(cdev->gadget, &uvc_hs_streaming_ep);
+	else
+		ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
+
 	if (!ep) {
 		uvcg_info(f, "Unable to allocate streaming EP\n");
 		goto error;
 	}
 	uvc->video.ep = ep;
 
+	uvc_fs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 
-- 
2.43.0



