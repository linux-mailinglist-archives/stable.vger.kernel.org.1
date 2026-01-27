Return-Path: <stable+bounces-211804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOX+E428eGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:24:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE8E94DE2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF31A302F735
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCC5341AC1;
	Tue, 27 Jan 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gXq/XL9U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56730AD1D
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520210; cv=none; b=Tf4NcKAsiYKfOEoGu4LeXd+H/3IBVTmu1kssfYn+2FlJZ3J6GIOd5tsVXZiooPJkO36Orz53ugOJaHulcTKGkKwAvb8wEVymmv11iG/jFPXMWKrHvQdCjFXuvcPJxIt4SOmj2nLHRcZbquQOhTcxIIpYs3ZXhYYWgGVvBTdbLkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520210; c=relaxed/simple;
	bh=S65sN4qeZV9l5BKsY9NBjUsEMNIzALYZMTmaWXxLpCc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=js6u7B/7LdI6tEutTEXgs4FVpiYxEGJZCloY2E6xnyY78F92DvuFp1uHTpFNiQKN85V2LAJ805EgUSSbc7wbbavo52FrW9J3AcUnFJ83fUjvkIGQd4nEQm7p7LKZabslmGBHhsYbaCYNDU0G5lmAcKR3oSYq+3EEoCwSRy059i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gXq/XL9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B23EC116C6;
	Tue, 27 Jan 2026 13:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769520209;
	bh=S65sN4qeZV9l5BKsY9NBjUsEMNIzALYZMTmaWXxLpCc=;
	h=Subject:To:Cc:From:Date:From;
	b=gXq/XL9UIoZ6uSzJjsuHbOrNYYJ7h3NfRTn4RPenU6jmClSZoP8ybTxLUsefo5Gun
	 TRDylddjiWKHMfe8r0HiNkxpWwze1BXnBGw5bgwj8uy9ZJzUO750xzJ5MBL5HwJNjg
	 0MqCWEl95NyH/CgtCGKcIzEPzlzFKIMlYg6VDsWA=
Subject: FAILED: patch "[PATCH] can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory" failed to apply to 5.15-stable tree
To: mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:23:16 +0100
Message-ID: <2026012716-freight-preteen-bff5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211804-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,pengutronix.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: CEE8E94DE2
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5a4391bdc6c8357242f62f22069c865b792406b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012716-freight-preteen-bff5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a4391bdc6c8357242f62f22069c865b792406b3 Mon Sep 17 00:00:00 2001
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 10 Jan 2026 12:52:27 +0100
Subject: [PATCH] can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory
 leak

Fix similar memory leak as in commit 7352e1d5932a ("can: gs_usb:
gs_usb_receive_bulk_callback(): fix URB memory leak").

In esd_usb_open(), the URBs for USB-in transfers are allocated, added to
the dev->rx_submitted anchor and submitted. In the complete callback
esd_usb_read_bulk_callback(), the URBs are processed and resubmitted. In
esd_usb_close() the URBs are freed by calling
usb_kill_anchored_urbs(&dev->rx_submitted).

However, this does not take into account that the USB framework unanchors
the URB before the complete function is called. This means that once an
in-URB has been completed, it is no longer anchored and is ultimately not
released in esd_usb_close().

Fix the memory leak by anchoring the URB in the
esd_usb_read_bulk_callback() to the dev->rx_submitted anchor.

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260116-can_usb-fix-memory-leak-v2-2-4b8cb2915571@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index 08da507faef4..8cc924c47042 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -541,13 +541,20 @@ static void esd_usb_read_bulk_callback(struct urb *urb)
 			  urb->transfer_buffer, ESD_USB_RX_BUFFER_SIZE,
 			  esd_usb_read_bulk_callback, dev);
 
+	usb_anchor_urb(urb, &dev->rx_submitted);
+
 	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!err)
+		return;
+
+	usb_unanchor_urb(urb);
+
 	if (err == -ENODEV) {
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i])
 				netif_device_detach(dev->nets[i]->netdev);
 		}
-	} else if (err) {
+	} else {
 		dev_err(dev->udev->dev.parent,
 			"failed resubmitting read bulk urb: %pe\n", ERR_PTR(err));
 	}


