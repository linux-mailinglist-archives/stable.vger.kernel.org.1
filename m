Return-Path: <stable+bounces-187972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C7ABEFD5F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0B1E4EFA0E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045142E0B69;
	Mon, 20 Oct 2025 08:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uI+6x6t9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F871DFD8B
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947970; cv=none; b=u7RVyWqROgEeFKywbuVw1d2hfkyXLNGnh4opGRw7y/oIB65poWjqMCKWG+iFyfvhCRn8R6CbYrGtHJtigAj2byDRj5mkDi588YlKDpPXYcON/xZQQxTVH74/pF0t82RarUXbbd0yodG11qePCY4jKUE8ScL9wPVMBfqOz+zHSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947970; c=relaxed/simple;
	bh=URk2ZCpOAeg5+S5uURgyOZp7nyvDaIIZ5wCt2g0cltY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SFXzBv6qgzXvWyNu0lFzs+GWzbe0OJqMhk/d9rc3wn42/E9/ez3SjnpKxMXMU18F/eUAvWKzgELfLENixf+Xfqfo84mruFEeylEmrZn0ckv9qFBrNFZT27trdsqOuP5nQX9qjBJOs54Dl5v+mPAGLu4j9iHaaQO3lYBXCvYDBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uI+6x6t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66A7C116B1;
	Mon, 20 Oct 2025 08:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947970;
	bh=URk2ZCpOAeg5+S5uURgyOZp7nyvDaIIZ5wCt2g0cltY=;
	h=Subject:To:Cc:From:Date:From;
	b=uI+6x6t9vFQ4Jwuuv5FZLAXljMSuweRuMu832S40+IdaxzJxah9drtrRhN1yhX4ls
	 FfceEMETMfkA0Wdy9XnionkXEYMc786W2lTMCb5UR+G3a5JjzPQFG2QrjF5c36FUB5
	 j/B7uUQOt4b5FUmMPYdHQ6/lmDI5Yvvzf3+S0VLI=
Subject: FAILED: patch "[PATCH] can: gs_usb: increase max interface to U8_MAX" failed to apply to 5.4-stable tree
To: uwu@coelacanthus.name,mailhol@kernel.org,mkl@pengutronix.de,runcheng.lu@hpmicro.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:12:41 +0200
Message-ID: <2025102041-mounting-pursuit-e9d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2a27f6a8fb5722223d526843040f747e9b0e8060
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102041-mounting-pursuit-e9d3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a27f6a8fb5722223d526843040f747e9b0e8060 Mon Sep 17 00:00:00 2001
From: Celeste Liu <uwu@coelacanthus.name>
Date: Tue, 30 Sep 2025 19:34:28 +0800
Subject: [PATCH] can: gs_usb: increase max interface to U8_MAX

This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
converter[1]. The original developers may have only 3 interfaces
device to test so they write 3 here and wait for future change.

During the HSCanT development, we actually used 4 interfaces, so the
limitation of 3 is not enough now. But just increase one is not
future-proofed. Since the channel index type in gs_host_frame is u8,
just make canch[] become a flexible array with a u8 index, so it
naturally constraint by U8_MAX and avoid statically allocate 256
pointer for every gs_usb device.

[1]: https://github.com/cherry-embedded/HSCanT-hardware

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
Cc: stable@vger.kernel.org
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
Link: https://patch.msgid.link/20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c9482d6e947b..9fb4cbbd6d6d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -289,11 +289,6 @@ struct gs_host_frame {
 #define GS_MAX_RX_URBS 30
 #define GS_NAPI_WEIGHT 32
 
-/* Maximum number of interfaces the driver supports per device.
- * Current hardware only supports 3 interfaces. The future may vary.
- */
-#define GS_MAX_INTF 3
-
 struct gs_tx_context {
 	struct gs_can *dev;
 	unsigned int echo_id;
@@ -324,7 +319,6 @@ struct gs_can {
 
 /* usb interface struct */
 struct gs_usb {
-	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
 
@@ -336,9 +330,11 @@ struct gs_usb {
 
 	unsigned int hf_size_rx;
 	u8 active_channels;
+	u8 channel_cnt;
 
 	unsigned int pipe_in;
 	unsigned int pipe_out;
+	struct gs_can *canch[] __counted_by(channel_cnt);
 };
 
 /* 'allocate' a tx context.
@@ -599,7 +595,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	}
 
 	/* device reports out of range channel id */
-	if (hf->channel >= GS_MAX_INTF)
+	if (hf->channel >= parent->channel_cnt)
 		goto device_detach;
 
 	dev = parent->canch[hf->channel];
@@ -699,7 +695,7 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	/* USB failure take down all interfaces */
 	if (rc == -ENODEV) {
 device_detach:
-		for (rc = 0; rc < GS_MAX_INTF; rc++) {
+		for (rc = 0; rc < parent->channel_cnt; rc++) {
 			if (parent->canch[rc])
 				netif_device_detach(parent->canch[rc]->netdev);
 		}
@@ -1460,17 +1456,19 @@ static int gs_usb_probe(struct usb_interface *intf,
 	icount = dconf.icount + 1;
 	dev_info(&intf->dev, "Configuring for %u interfaces\n", icount);
 
-	if (icount > GS_MAX_INTF) {
+	if (icount > type_max(parent->channel_cnt)) {
 		dev_err(&intf->dev,
 			"Driver cannot handle more that %u CAN interfaces\n",
-			GS_MAX_INTF);
+			type_max(parent->channel_cnt));
 		return -EINVAL;
 	}
 
-	parent = kzalloc(sizeof(*parent), GFP_KERNEL);
+	parent = kzalloc(struct_size(parent, canch, icount), GFP_KERNEL);
 	if (!parent)
 		return -ENOMEM;
 
+	parent->channel_cnt = icount;
+
 	init_usb_anchor(&parent->rx_submitted);
 
 	usb_set_intfdata(intf, parent);
@@ -1531,7 +1529,7 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
-	for (i = 0; i < GS_MAX_INTF; i++)
+	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);
 


