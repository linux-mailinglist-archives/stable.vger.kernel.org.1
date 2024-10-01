Return-Path: <stable+bounces-78400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF898B92B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C2628456A
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB5919D08C;
	Tue,  1 Oct 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xf2crwOc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0513209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778052; cv=none; b=ADeIP+/ApcExZpxi5rG6FrTw4rnDEFWj2GlUUh/CzwAkyOZFXa4HvINwsFOGb6K0tklL3b91cDNKF9qsU6d8x/1wR1KsR0FYIqXVjp4jym63zAEN5piHVnc7CPNjqBDGrgMDFS10U8kibAP8Hqz4A1SkUbECmPwxsj0BUfXQf7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778052; c=relaxed/simple;
	bh=2q1e/06t+4IH8U0JonPI++PQ+9iK75l7wr+uqFC50iU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SbrJefviMdvryEhjoVIzU7WkbRj+aUaU3iHLamFMezH8j/5EMxxZt5LbIUNLY4o/xcdusB6Ipu9iK00iW02jSNQP7rplNBScisS6z3+s64jSQU7ynQ3G97LpIocM60E6ertkqqZNetajj1URLcjaRh3RErmIc8qqqu1TYJ3XdnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xf2crwOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1DCC4CEC6;
	Tue,  1 Oct 2024 10:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778052;
	bh=2q1e/06t+4IH8U0JonPI++PQ+9iK75l7wr+uqFC50iU=;
	h=Subject:To:Cc:From:Date:From;
	b=Xf2crwOcN17bVM5MPBHUjSquWASax6VaCtqutes55tnUV/cZfkg/CmVhMnkjliutR
	 IEskaQQgeHgYo3dlJPOYrtGdWVD/pVRJUlNC0Yn5VIiAesrW6VJnwCFh87QqVA1/CK
	 7F/tpw6beyq7UNp8oOiAIHg5ADNUmJR402rsKKQQ=
Subject: FAILED: patch "[PATCH] usbnet: fix cyclical race on disconnect with work queue" failed to apply to 4.19-stable tree
To: oneukum@suse.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:20:39 +0200
Message-ID: <2024100138-unkempt-varying-9971@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 04e906839a053f092ef53f4fb2d610983412b904
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100138-unkempt-varying-9971@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

04e906839a05 ("usbnet: fix cyclical race on disconnect with work queue")
a69e617e533e ("usbnet: Fix linkwatch use-after-free on disconnect")
478890682ff7 ("usbnet: add usbnet_event_names[] for kevent")
956baa99571b ("usbnet: add method for reporting speed without MII")
77651900cede ("usbnet: add _mii suffix to usbnet_set/get_link_ksettings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 04e906839a053f092ef53f4fb2d610983412b904 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Thu, 19 Sep 2024 14:33:42 +0200
Subject: [PATCH] usbnet: fix cyclical race on disconnect with work queue

The work can submit URBs and the URBs can schedule the work.
This cycle needs to be broken, when a device is to be stopped.
Use a flag to do so.
This is a design issue as old as the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/20240919123525.688065-1-oneukum@suse.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 18eb5ba436df..2506aa8c603e 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -464,10 +464,15 @@ static enum skb_state defer_bh(struct usbnet *dev, struct sk_buff *skb,
 void usbnet_defer_kevent (struct usbnet *dev, int work)
 {
 	set_bit (work, &dev->flags);
-	if (!schedule_work (&dev->kevent))
-		netdev_dbg(dev->net, "kevent %s may have been dropped\n", usbnet_event_names[work]);
-	else
-		netdev_dbg(dev->net, "kevent %s scheduled\n", usbnet_event_names[work]);
+	if (!usbnet_going_away(dev)) {
+		if (!schedule_work(&dev->kevent))
+			netdev_dbg(dev->net,
+				   "kevent %s may have been dropped\n",
+				   usbnet_event_names[work]);
+		else
+			netdev_dbg(dev->net,
+				   "kevent %s scheduled\n", usbnet_event_names[work]);
+	}
 }
 EXPORT_SYMBOL_GPL(usbnet_defer_kevent);
 
@@ -535,7 +540,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 			tasklet_schedule (&dev->bh);
 			break;
 		case 0:
-			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
+			if (!usbnet_going_away(dev))
+				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
 		}
 	} else {
 		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
@@ -843,9 +849,18 @@ int usbnet_stop (struct net_device *net)
 
 	/* deferred work (timer, softirq, task) must also stop */
 	dev->flags = 0;
-	del_timer_sync (&dev->delay);
-	tasklet_kill (&dev->bh);
+	del_timer_sync(&dev->delay);
+	tasklet_kill(&dev->bh);
 	cancel_work_sync(&dev->kevent);
+
+	/* We have cyclic dependencies. Those calls are needed
+	 * to break a cycle. We cannot fall into the gaps because
+	 * we have a flag
+	 */
+	tasklet_kill(&dev->bh);
+	del_timer_sync(&dev->delay);
+	cancel_work_sync(&dev->kevent);
+
 	if (!pm)
 		usb_autopm_put_interface(dev->intf);
 
@@ -1171,7 +1186,8 @@ usbnet_deferred_kevent (struct work_struct *work)
 					   status);
 		} else {
 			clear_bit (EVENT_RX_HALT, &dev->flags);
-			tasklet_schedule (&dev->bh);
+			if (!usbnet_going_away(dev))
+				tasklet_schedule(&dev->bh);
 		}
 	}
 
@@ -1196,7 +1212,8 @@ usbnet_deferred_kevent (struct work_struct *work)
 			usb_autopm_put_interface(dev->intf);
 fail_lowmem:
 			if (resched)
-				tasklet_schedule (&dev->bh);
+				if (!usbnet_going_away(dev))
+					tasklet_schedule(&dev->bh);
 		}
 	}
 
@@ -1559,6 +1576,7 @@ static void usbnet_bh (struct timer_list *t)
 	} else if (netif_running (dev->net) &&
 		   netif_device_present (dev->net) &&
 		   netif_carrier_ok(dev->net) &&
+		   !usbnet_going_away(dev) &&
 		   !timer_pending(&dev->delay) &&
 		   !test_bit(EVENT_RX_PAUSED, &dev->flags) &&
 		   !test_bit(EVENT_RX_HALT, &dev->flags)) {
@@ -1606,6 +1624,7 @@ void usbnet_disconnect (struct usb_interface *intf)
 	usb_set_intfdata(intf, NULL);
 	if (!dev)
 		return;
+	usbnet_mark_going_away(dev);
 
 	xdev = interface_to_usbdev (intf);
 
diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
index 9f08a584d707..0b9f1e598e3a 100644
--- a/include/linux/usb/usbnet.h
+++ b/include/linux/usb/usbnet.h
@@ -76,8 +76,23 @@ struct usbnet {
 #		define EVENT_LINK_CHANGE	11
 #		define EVENT_SET_RX_MODE	12
 #		define EVENT_NO_IP_ALIGN	13
+/* This one is special, as it indicates that the device is going away
+ * there are cyclic dependencies between tasklet, timer and bh
+ * that must be broken
+ */
+#		define EVENT_UNPLUG		31
 };
 
+static inline bool usbnet_going_away(struct usbnet *ubn)
+{
+	return test_bit(EVENT_UNPLUG, &ubn->flags);
+}
+
+static inline void usbnet_mark_going_away(struct usbnet *ubn)
+{
+	set_bit(EVENT_UNPLUG, &ubn->flags);
+}
+
 static inline struct usb_driver *driver_of(struct usb_interface *intf)
 {
 	return to_usb_driver(intf->dev.driver);


