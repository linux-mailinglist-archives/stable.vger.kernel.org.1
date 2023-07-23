Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F180A75E23F
	for <lists+stable@lfdr.de>; Sun, 23 Jul 2023 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGWOBN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 10:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGWOBN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 10:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2961BE
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 07:01:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5115260D29
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 14:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4B8C433C8;
        Sun, 23 Jul 2023 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690120870;
        bh=q/P2z8JdgBMh4vCPVZgxxe7FrPRxlC1aHUXPRtwGF6Y=;
        h=Subject:To:Cc:From:Date:From;
        b=Hid3LDp/ElVglpIf4HAxuZS7R2vJyy+5bWftsdMg5jidY43paJYQYEher6rVKap3M
         4NsNBc/5oZpXZwhBBHe5tBICWGQ9b77IK+8xi6A70eeCuNvB7qGTzemndg2RvMzGaB
         wvevnFQFUG9ybqFRlqaGeJQwUKJwqdfIWDny5LfA=
Subject: FAILED: patch "[PATCH] can: gs_usb: fix time stamp counter initialization" failed to apply to 6.1-stable tree
To:     mkl@pengutronix.de, git@jbrengineering.co.uk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 23 Jul 2023 16:01:03 +0200
Message-ID: <2023072302-hasty-mocker-848a@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5886e4d5ecec3e22844efed90b2dd383ef804b3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072302-hasty-mocker-848a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5886e4d5ecec ("can: gs_usb: fix time stamp counter initialization")
2603be9e8167 ("can: gs_usb: gs_can_open(): improve error handling")
56c56a309e79 ("can: gs_usb: remove gs_can::iface")
0c9f92a4b795 ("can: gs_usb: add support for reading error counters")
2f3cdad1c616 ("can: gs_usb: add ability to enable / disable berr reporting")
ac3f25824e4f ("can: gs_usb: gs_can_open(): merge setting of timestamp flags and init")
f6adf410f70b ("can: gs_usb: gs_can_open(): sort checks for ctrlmode")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5886e4d5ecec3e22844efed90b2dd383ef804b3a Mon Sep 17 00:00:00 2001
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 7 Jul 2023 18:44:23 +0200
Subject: [PATCH] can: gs_usb: fix time stamp counter initialization

If the gs_usb device driver is unloaded (or unbound) before the
interface is shut down, the USB stack first calls the struct
usb_driver::disconnect and then the struct net_device_ops::ndo_stop
callback.

In gs_usb_disconnect() all pending bulk URBs are killed, i.e. no more
RX'ed CAN frames are send from the USB device to the host. Later in
gs_can_close() a reset control message is send to each CAN channel to
remove the controller from the CAN bus. In this race window the USB
device can still receive CAN frames from the bus and internally queue
them to be send to the host.

At least in the current version of the candlelight firmware, the queue
of received CAN frames is not emptied during the reset command. After
loading (or binding) the gs_usb driver, new URBs are submitted during
the struct net_device_ops::ndo_open callback and the candlelight
firmware starts sending its already queued CAN frames to the host.

However, this scenario was not considered when implementing the
hardware timestamp function. The cycle counter/time counter
infrastructure is set up (gs_usb_timestamp_init()) after the USBs are
submitted, resulting in a NULL pointer dereference if
timecounter_cyc2time() (via the call chain:
gs_usb_receive_bulk_callback() -> gs_usb_set_timestamp() ->
gs_usb_skb_set_timestamp()) is called too early.

Move the gs_usb_timestamp_init() function before the URBs are
submitted to fix this problem.

For a comprehensive solution, we need to consider gs_usb devices with
more than 1 channel. The cycle counter/time counter infrastructure is
setup per channel, but the RX URBs are per device. Once gs_can_open()
of _a_ channel has been called, and URBs have been submitted, the
gs_usb_receive_bulk_callback() can be called for _all_ available
channels, even for channels that are not running, yet. As cycle
counter/time counter has not set up, this will again lead to a NULL
pointer dereference.

Convert the cycle counter/time counter from a "per channel" to a "per
device" functionality. Also set it up, before submitting any URBs to
the device.

Further in gs_usb_receive_bulk_callback(), don't process any URBs for
not started CAN channels, only resubmit the URB.

Fixes: 45dfa45f52e6 ("can: gs_usb: add RX and TX hardware timestamp support")
Closes: https://github.com/candle-usb/candleLight_fw/issues/137#issuecomment-1623532076
Cc: stable@vger.kernel.org
Cc: John Whittington <git@jbrengineering.co.uk>
Link: https://lore.kernel.org/all/20230716-gs_usb-fix-time-stamp-counter-v1-2-9017cefcd9d5@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 85b7b59c8426..f418066569fc 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -303,12 +303,6 @@ struct gs_can {
 	struct can_bittiming_const bt_const, data_bt_const;
 	unsigned int channel;	/* channel number */
 
-	/* time counter for hardware timestamps */
-	struct cyclecounter cc;
-	struct timecounter tc;
-	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
-	struct delayed_work timestamp;
-
 	u32 feature;
 	unsigned int hf_size_tx;
 
@@ -325,6 +319,13 @@ struct gs_usb {
 	struct gs_can *canch[GS_MAX_INTF];
 	struct usb_anchor rx_submitted;
 	struct usb_device *udev;
+
+	/* time counter for hardware timestamps */
+	struct cyclecounter cc;
+	struct timecounter tc;
+	spinlock_t tc_lock; /* spinlock to guard access tc->cycle_last */
+	struct delayed_work timestamp;
+
 	unsigned int hf_size_rx;
 	u8 active_channels;
 };
@@ -388,15 +389,15 @@ static int gs_cmd_reset(struct gs_can *dev)
 				    GFP_KERNEL);
 }
 
-static inline int gs_usb_get_timestamp(const struct gs_can *dev,
+static inline int gs_usb_get_timestamp(const struct gs_usb *parent,
 				       u32 *timestamp_p)
 {
 	__le32 timestamp;
 	int rc;
 
-	rc = usb_control_msg_recv(dev->udev, 0, GS_USB_BREQ_TIMESTAMP,
+	rc = usb_control_msg_recv(parent->udev, 0, GS_USB_BREQ_TIMESTAMP,
 				  USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
-				  dev->channel, 0,
+				  0, 0,
 				  &timestamp, sizeof(timestamp),
 				  USB_CTRL_GET_TIMEOUT,
 				  GFP_KERNEL);
@@ -410,20 +411,20 @@ static inline int gs_usb_get_timestamp(const struct gs_can *dev,
 
 static u64 gs_usb_timestamp_read(const struct cyclecounter *cc) __must_hold(&dev->tc_lock)
 {
-	struct gs_can *dev = container_of(cc, struct gs_can, cc);
+	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
 	u32 timestamp = 0;
 	int err;
 
-	lockdep_assert_held(&dev->tc_lock);
+	lockdep_assert_held(&parent->tc_lock);
 
 	/* drop lock for synchronous USB transfer */
-	spin_unlock_bh(&dev->tc_lock);
-	err = gs_usb_get_timestamp(dev, &timestamp);
-	spin_lock_bh(&dev->tc_lock);
+	spin_unlock_bh(&parent->tc_lock);
+	err = gs_usb_get_timestamp(parent, &timestamp);
+	spin_lock_bh(&parent->tc_lock);
 	if (err)
-		netdev_err(dev->netdev,
-			   "Error %d while reading timestamp. HW timestamps may be inaccurate.",
-			   err);
+		dev_err(&parent->udev->dev,
+			"Error %d while reading timestamp. HW timestamps may be inaccurate.",
+			err);
 
 	return timestamp;
 }
@@ -431,14 +432,14 @@ static u64 gs_usb_timestamp_read(const struct cyclecounter *cc) __must_hold(&dev
 static void gs_usb_timestamp_work(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
-	struct gs_can *dev;
+	struct gs_usb *parent;
 
-	dev = container_of(delayed_work, struct gs_can, timestamp);
-	spin_lock_bh(&dev->tc_lock);
-	timecounter_read(&dev->tc);
-	spin_unlock_bh(&dev->tc_lock);
+	parent = container_of(delayed_work, struct gs_usb, timestamp);
+	spin_lock_bh(&parent->tc_lock);
+	timecounter_read(&parent->tc);
+	spin_unlock_bh(&parent->tc_lock);
 
-	schedule_delayed_work(&dev->timestamp,
+	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
@@ -446,37 +447,38 @@ static void gs_usb_skb_set_timestamp(struct gs_can *dev,
 				     struct sk_buff *skb, u32 timestamp)
 {
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+	struct gs_usb *parent = dev->parent;
 	u64 ns;
 
-	spin_lock_bh(&dev->tc_lock);
-	ns = timecounter_cyc2time(&dev->tc, timestamp);
-	spin_unlock_bh(&dev->tc_lock);
+	spin_lock_bh(&parent->tc_lock);
+	ns = timecounter_cyc2time(&parent->tc, timestamp);
+	spin_unlock_bh(&parent->tc_lock);
 
 	hwtstamps->hwtstamp = ns_to_ktime(ns);
 }
 
-static void gs_usb_timestamp_init(struct gs_can *dev)
+static void gs_usb_timestamp_init(struct gs_usb *parent)
 {
-	struct cyclecounter *cc = &dev->cc;
+	struct cyclecounter *cc = &parent->cc;
 
 	cc->read = gs_usb_timestamp_read;
 	cc->mask = CYCLECOUNTER_MASK(32);
 	cc->shift = 32 - bits_per(NSEC_PER_SEC / GS_USB_TIMESTAMP_TIMER_HZ);
 	cc->mult = clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
 
-	spin_lock_init(&dev->tc_lock);
-	spin_lock_bh(&dev->tc_lock);
-	timecounter_init(&dev->tc, &dev->cc, ktime_get_real_ns());
-	spin_unlock_bh(&dev->tc_lock);
+	spin_lock_init(&parent->tc_lock);
+	spin_lock_bh(&parent->tc_lock);
+	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
+	spin_unlock_bh(&parent->tc_lock);
 
-	INIT_DELAYED_WORK(&dev->timestamp, gs_usb_timestamp_work);
-	schedule_delayed_work(&dev->timestamp,
+	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
+	schedule_delayed_work(&parent->timestamp,
 			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
-static void gs_usb_timestamp_stop(struct gs_can *dev)
+static void gs_usb_timestamp_stop(struct gs_usb *parent)
 {
-	cancel_delayed_work_sync(&dev->timestamp);
+	cancel_delayed_work_sync(&parent->timestamp);
 }
 
 static void gs_update_state(struct gs_can *dev, struct can_frame *cf)
@@ -560,6 +562,9 @@ static void gs_usb_receive_bulk_callback(struct urb *urb)
 	if (!netif_device_present(netdev))
 		return;
 
+	if (!netif_running(netdev))
+		goto resubmit_urb;
+
 	if (hf->echo_id == -1) { /* normal rx */
 		if (hf->flags & GS_CAN_FLAG_FD) {
 			skb = alloc_canfd_skb(dev->netdev, &cfd);
@@ -856,6 +861,9 @@ static int gs_can_open(struct net_device *netdev)
 	}
 
 	if (!parent->active_channels) {
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			gs_usb_timestamp_init(parent);
+
 		for (i = 0; i < GS_MAX_RX_URBS; i++) {
 			u8 *buf;
 
@@ -926,13 +934,9 @@ static int gs_can_open(struct net_device *netdev)
 		flags |= GS_CAN_MODE_FD;
 
 	/* if hardware supports timestamps, enable it */
-	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP) {
+	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
 		flags |= GS_CAN_MODE_HW_TIMESTAMP;
 
-		/* start polling timestamp */
-		gs_usb_timestamp_init(dev);
-	}
-
 	/* finally start device */
 	dev->can.state = CAN_STATE_ERROR_ACTIVE;
 	dm.flags = cpu_to_le32(flags);
@@ -942,8 +946,6 @@ static int gs_can_open(struct net_device *netdev)
 				  GFP_KERNEL);
 	if (rc) {
 		netdev_err(netdev, "Couldn't start device (err=%d)\n", rc);
-		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-			gs_usb_timestamp_stop(dev);
 		dev->can.state = CAN_STATE_STOPPED;
 
 		goto out_usb_kill_anchored_urbs;
@@ -960,9 +962,13 @@ static int gs_can_open(struct net_device *netdev)
 out_usb_free_urb:
 	usb_free_urb(urb);
 out_usb_kill_anchored_urbs:
-	if (!parent->active_channels)
+	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&dev->tx_submitted);
 
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			gs_usb_timestamp_stop(parent);
+	}
+
 	close_candev(netdev);
 
 	return rc;
@@ -1011,14 +1017,13 @@ static int gs_can_close(struct net_device *netdev)
 
 	netif_stop_queue(netdev);
 
-	/* stop polling timestamp */
-	if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
-		gs_usb_timestamp_stop(dev);
-
 	/* Stop polling */
 	parent->active_channels--;
 	if (!parent->active_channels) {
 		usb_kill_anchored_urbs(&parent->rx_submitted);
+
+		if (dev->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
+			gs_usb_timestamp_stop(parent);
 	}
 
 	/* Stop sending URBs */

