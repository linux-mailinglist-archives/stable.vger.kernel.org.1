Return-Path: <stable+bounces-76757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8021397C949
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 14:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49521C22120
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 12:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DBB19D8BE;
	Thu, 19 Sep 2024 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CxgGwm8n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ir6SVbs6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923F1EB2F;
	Thu, 19 Sep 2024 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726749333; cv=none; b=MbRk1/84iiI5BKRO4YYGdIiivUkRx/PjM2yN2V902LX2fDCfH8YOha9/afajmmockPrQJl8K71ENu2JeROlBqLYiMuPMasu6edKc5Taf/5BA7PHqMfL8+0u3ViWxNV5imTUYIpbb1mdsu7QexjX6AFQGVB71skd6fpPdLJnpwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726749333; c=relaxed/simple;
	bh=C0qiYBjh7+JNE6dSxlKxI/K2eGBbcQXB5lUFPJMb3nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sx4LO1WhO9Bnp+bcwRLn+goIYbzhsFLT0pbfPjgN5W3DEog/CByvVqyjRP3XDwToTFxUhDc/2IlS+8AmVh5gux8qAuok74nS54BKd/GAoUHLQujWsgh5FWgN3R4tlV0d6QdAp9pyohL8ojAP5SdSRPig+f/PZSvbqRIElxVcj1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CxgGwm8n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ir6SVbs6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1D24338D2;
	Thu, 19 Sep 2024 12:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726749329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=03iIXrm2d6dZ3mz5HP9AK7PKZOvrRHH8k/30bsSSODc=;
	b=CxgGwm8nkJYm6CYU6iU5ojIwjv22TMnywi+UwUX9DXbFQcGx7GyI2HWP8XtA/Va//dfqCE
	Oy27u7aWmDIrr/yOjee0yxRFjMlvlEO5KF4VYFw7ONf+VL7G3Z+CsUAufo7Qh+SmqM6lko
	+mORCRUoHAkahsrpyp/flJHqmIdPgKI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Ir6SVbs6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726749328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=03iIXrm2d6dZ3mz5HP9AK7PKZOvrRHH8k/30bsSSODc=;
	b=Ir6SVbs6Gq/S2XQPoEb/UJFdcLES5VQxult3+ncWDxzDEzG7e07FnwBzWGQw6POGjAkykW
	tpFjoSr3VnXCgs+2cu719G0EBDhupHssvKD4/dRo3hpM6+rE0VVwOOmSapMw4uuRh4XIFT
	ZlS0DevOVM3iwwGOwHkdtIAo0KmMiZE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9649913A5F;
	Thu, 19 Sep 2024 12:35:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id okdEI5Aa7GblLAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Thu, 19 Sep 2024 12:35:28 +0000
From: Oliver Neukum <oneukum@suse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	stable@vger.kernel.org
Subject: [PATCHv3] usbnet: fix cyclical race on disconnect with work queue
Date: Thu, 19 Sep 2024 14:33:42 +0200
Message-ID: <20240919123525.688065-1-oneukum@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1D24338D2
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The work can submit URBs and the URBs can schedule the work.
This cycle needs to be broken, when a device is to be stopped.
Use a flag to do so.
This is a design issue as old as the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
CC: stable@vger.kernel.org
---

v2: fix PM reference issue
v3: drop unneeded memory ordering primitives

 drivers/net/usb/usbnet.c   | 37 ++++++++++++++++++++++++++++---------
 include/linux/usb/usbnet.h | 15 +++++++++++++++
 2 files changed, 43 insertions(+), 9 deletions(-)

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
-- 
2.46.0


