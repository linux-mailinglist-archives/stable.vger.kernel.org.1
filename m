Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7165576118D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjGYKxD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjGYKvy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F530E2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E03261656
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402AAC433C8;
        Tue, 25 Jul 2023 10:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282260;
        bh=pjO8uE2kXG/UFHE5ezoHvoIg88QA1L7RW8bJLXTgPZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0jO0YCTYL0FAnWwn/JHmquRv1/9Is66BfiIQDOR5aDXqwS15VyKkofE/ornA6j1MR
         E0hxXGdNd8WhqmLOC/YvpGMxNtDaIHcRxSWfek4HW59N6hahDEpLepkz2MWaRO7Lw+
         5Gr8D2y57ZbVaDUdi0xPjZzzYKaAQm23zUExq7Ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        John Whittington <git@jbrengineering.co.uk>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.4 036/227] can: gs_usb: gs_can_open(): improve error handling
Date:   Tue, 25 Jul 2023 12:43:23 +0200
Message-ID: <20230725104516.337408912@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

commit 2603be9e8167ddc7bea95dcfab9ffc33414215aa upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/gs_usb.c |   31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -833,6 +833,7 @@ static int gs_can_open(struct net_device
 		.mode = cpu_to_le32(GS_CAN_MODE_START),
 	};
 	struct gs_host_frame *hf;
+	struct urb *urb = NULL;
 	u32 ctrlmode;
 	u32 flags = 0;
 	int rc, i;
@@ -856,13 +857,14 @@ static int gs_can_open(struct net_device
 
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
@@ -870,8 +872,8 @@ static int gs_can_open(struct net_device
 			if (!buf) {
 				netdev_err(netdev,
 					   "No memory left for USB buffer\n");
-				usb_free_urb(urb);
-				return -ENOMEM;
+				rc = -ENOMEM;
+				goto out_usb_free_urb;
 			}
 
 			/* fill, anchor, and submit rx urb */
@@ -894,9 +896,7 @@ static int gs_can_open(struct net_device
 				netdev_err(netdev,
 					   "usb_submit failed (err=%d)\n", rc);
 
-				usb_unanchor_urb(urb);
-				usb_free_urb(urb);
-				break;
+				goto out_usb_unanchor_urb;
 			}
 
 			/* Drop reference,
@@ -945,7 +945,8 @@ static int gs_can_open(struct net_device
 		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 			gs_usb_timestamp_stop(dev);
 		dev->can.state = CAN_STATE_STOPPED;
-		return rc;
+
+		goto out_usb_kill_anchored_urbs;
 	}
 
 	parent->active_channels++;
@@ -953,6 +954,18 @@ static int gs_can_open(struct net_device
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


