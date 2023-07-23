Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A510E75E23B
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGWOA6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGWOA6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:00:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADFCE70
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A359460D30
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0C6C433C7;
        Sun, 23 Jul 2023 14:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690120856;
        bh=vqnoNHneTkgUf4pXGMk0K8mJp2GuoFSYWxco55WOnJY=;
        h=Subject:To:Cc:From:Date:From;
        b=2OwqGQvaUMyiX1wjz7XmW8SRoctk81yKGhcTaJblkNSXjltptPGEFVahm+uyAbtvQ
         7si3m/1SppphVfEHsonHSKGevN4HlIi8gOsQNOZ0Tm2dnBwfSrRYKoEtAJ83gpc/qU
         wV9FJAxkqppjnMOtIdUa+S14CoQspfsB34GrLxHQ=
Subject: FAILED: patch "[PATCH] can: gs_usb: gs_can_open(): improve error handling" failed to apply to 5.10-stable tree
To:     mkl@pengutronix.de, git@jbrengineering.co.uk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:00:50 +0200
Message-ID: <2023072350-remorse-graduate-cd73@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2603be9e8167ddc7bea95dcfab9ffc33414215aa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072350-remorse-graduate-cd73@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
62f102c0d156 ("can: gs_usb: remove dma allocations")
5440428b3da6 ("can: gs_usb: gs_can_open(): fix race dev->can.state condition")
2bda24ef95c0 ("can: gs_usb: gs_usb_open/close(): fix memory leak")
c359931d2545 ("can: gs_usb: use union and FLEX_ARRAY for data in struct gs_host_frame")
5374d083117c ("can: gs_usb: gs_usb_probe(): introduce udev and make use of it")
c1ee72690cdd ("can: gs_usb: rewrap usb_control_msg() and usb_fill_bulk_urb()")
035b0fcf0270 ("can: gs_usb: change active_channels's type from atomic_t to u8")
108194666a3f ("can: gs_usb: use %u to print unsigned values")
5c39f26e67c9 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2603be9e8167ddc7bea95dcfab9ffc33414215aa Mon Sep 17 00:00:00 2001
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 7 Jul 2023 13:43:10 +0200
Subject: [PATCH] can: gs_usb: gs_can_open(): improve error handling

The gs_usb driver handles USB devices with more than 1 CAN channel.
The RX path for all channels share the same bulk endpoint (the
transmitted bulk data encodes the channel number). These per-device
resources are allocated and submitted by the first opened channel.

During this allocation, the resources are either released immediately
in case of a failure or the URBs are anchored. All anchored URBs are
finally killed with gs_usb_disconnect().

Currently, gs_can_open() returns with an error if the allocation of a
URB or a buffer fails. However, if usb_submit_urb() fails, the driver
continues with the URBs submitted so far, even if no URBs were
successfully submitted.

Treat every error as fatal and free all allocated resources
immediately.

Switch to goto-style error handling, to prepare the driver for more
per-device resource allocation.

Cc: stable@vger.kernel.org
Cc: John Whittington <git@jbrengineering.co.uk>
Link: https://lore.kernel.org/all/20230716-gs_usb-fix-time-stamp-counter-v1-1-9017cefcd9d5@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index d476c2884008..85b7b59c8426 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -833,6 +833,7 @@ static int gs_can_open(struct net_device *netdev)
 		.mode = cpu_to_le32(GS_CAN_MODE_START),
 	};
 	struct gs_host_frame *hf;
+	struct urb *urb = NULL;
 	u32 ctrlmode;
 	u32 flags = 0;
 	int rc, i;
@@ -856,13 +857,14 @@ static int gs_can_open(struct net_device *netdev)
 
 	if (!parent->active_channels) {
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
-			struct urb *urb;
 			u8 *buf;
 
 			/* alloc rx urb */
 			urb = usb_alloc_urb(0, GFP_KERNEL);
-			if (!urb)
-				return -ENOMEM;
+			if (!urb) {
+				rc = -ENOMEM;
+				goto out_usb_kill_anchored_urbs;
+			}
 
 			/* alloc rx buffer */
 			buf = kmalloc(dev->parent->hf_size_rx,
@@ -870,8 +872,8 @@ static int gs_can_open(struct net_device *netdev)
 			if (!buf) {
 				netdev_err(netdev,
 					   "No memory left for USB buffer\n");
-				usb_free_urb(urb);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto out_usb_free_urb;
 			}
 
 			/* fill, anchor, and submit rx urb */
@@ -894,9 +896,7 @@ static int gs_can_open(struct net_device *netdev)
 				netdev_err(netdev,
 					   "usb_submit failed (err=%d)\n", rc);
 
-				usb_unanchor_urb(urb);
-				usb_free_urb(urb);
-				break;
+				goto out_usb_unanchor_urb;
 			}
 
 			/* Drop reference,
@@ -945,7 +945,8 @@ static int gs_can_open(struct net_device *netdev)
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(dev);
 		dev->can.state = CAN_STATE_STOPPED;
-		return rc;
+
+		goto out_usb_kill_anchored_urbs;
 	}
 
 	parent->active_channels++;
@@ -953,6 +954,18 @@ static int gs_can_open(struct net_device *netdev)
 		netif_start_queue(netdev);
 
 	return 0;
+
+out_usb_unanchor_urb:
+	usb_unanchor_urb(urb);
+out_usb_free_urb:
+	usb_free_urb(urb);
+out_usb_kill_anchored_urbs:
+	if (!parent->active_channels)
+		usb_kill_anchored_urbs(&dev->tx_submitted);
+
+	close_candev(netdev);
+
+	return rc;
 }
 
 static int gs_usb_get_state(const struct net_device *netdev,

