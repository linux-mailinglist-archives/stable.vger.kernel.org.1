Return-Path: <stable+bounces-242252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEi4FoJx9GmKBQIAu9opvQ
	(envelope-from <stable+bounces-242252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:25:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9DC4AB523
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16CE63015459
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2775237FF71;
	Fri,  1 May 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F99kdFde"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17523EA89
	for <stable@vger.kernel.org>; Fri,  1 May 2026 09:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777627291; cv=none; b=XiNNpJ+xU4WBMXdzkYVX0GwrwikgsDM8jTPUZM4/uxnyl9LRc3k7LSgksbdtJHLxOb2zvSAL2QpjxXEgmAOvJMXo/zGclAlOjQTaAW90kTpzvWmSOPMlXu1ebv9JqQi2dJx1v0vd8kNOoRwGXIyGy6MoV8bM6GxwpshwNUNIX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777627291; c=relaxed/simple;
	bh=S5WPx1hvMxujjp2uyO5Tfn0BNynCV9nrrDurhQ2C23k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nDJtMDC12gY/mw0idQLCw0jlKuid7k/i2cnVg7hxTCSYmr07uLhoLHzOWTr3M+1SWtaJKvD5pUPoFOU+46zjidM6ycLOR2HYamQ0Tn1xGzFrho9UTNF5vsYiIuwkx31lWiNJgA02iRgMKm+k3yu8g7UvuaOTsducnB/l8+BNZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F99kdFde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65001C2BCB7;
	Fri,  1 May 2026 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777627291;
	bh=S5WPx1hvMxujjp2uyO5Tfn0BNynCV9nrrDurhQ2C23k=;
	h=Subject:To:Cc:From:Date:From;
	b=F99kdFde6B6PmQnxhNarECxygICXm58WVJ0ohVbK/NFvCxT73ocANArDQmFsbui6C
	 ITNPtWY2Juvb3z6xeIHbBju3wnVe1fNsNwOf6B5IhzZvEENpveYhNOgW+gRVDPnnRO
	 wLk0OFS4JRJUWKmfiJn3FIV2QQji3YDXI0WGLrMA=
Subject: FAILED: patch "[PATCH] media: rc: ttusbir: respect DMA coherency rules" failed to apply to 6.18-stable tree
To: oneukum@suse.com,hverkuil+cisco@kernel.org,sean@mess.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 11:21:21 +0200
Message-ID: <2026050121-reverb-commodore-11f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CB9DC4AB523
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242252-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mess.org:email,suse.com:email,linuxfoundation.org:dkim,gregkh:email]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 50acaad3d202c064779db8dc3d010007347f59c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050121-reverb-commodore-11f0@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 50acaad3d202c064779db8dc3d010007347f59c7 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Wed, 11 Feb 2026 19:11:04 +0100
Subject: [PATCH] media: rc: ttusbir: respect DMA coherency rules

Buffers must not share a cache line with other data structures.
Allocate separately.

Fixes: 0938069fa0897 ("[media] rc: Add support for the TechnoTrend USB IR Receiver")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
index a2a64a860264..3848ad3a6b85 100644
--- a/drivers/media/rc/ttusbir.c
+++ b/drivers/media/rc/ttusbir.c
@@ -32,7 +32,7 @@ struct ttusbir {
 
 	struct led_classdev led;
 	struct urb *bulk_urb;
-	uint8_t bulk_buffer[5];
+	u8 *bulk_buffer;
 	int bulk_out_endp, iso_in_endp;
 	bool led_on, is_led_on;
 	atomic_t led_complete;
@@ -186,13 +186,16 @@ static int ttusbir_probe(struct usb_interface *intf,
 	struct rc_dev *rc;
 	int i, j, ret;
 	int altsetting = -1;
+	u8 *buffer;
 
 	tt = kzalloc_obj(*tt);
+	buffer = kzalloc(5, GFP_KERNEL);
 	rc = rc_allocate_device(RC_DRIVER_IR_RAW);
-	if (!tt || !rc) {
+	if (!tt || !rc || buffer) {
 		ret = -ENOMEM;
 		goto out;
 	}
+	tt->bulk_buffer = buffer;
 
 	/* find the correct alt setting */
 	for (i = 0; i < intf->num_altsetting && altsetting == -1; i++) {
@@ -281,8 +284,8 @@ static int ttusbir_probe(struct usb_interface *intf,
 	tt->bulk_buffer[3] = 0x01;
 
 	usb_fill_bulk_urb(tt->bulk_urb, tt->udev, usb_sndbulkpipe(tt->udev,
-		tt->bulk_out_endp), tt->bulk_buffer, sizeof(tt->bulk_buffer),
-						ttusbir_bulk_complete, tt);
+			  tt->bulk_out_endp), tt->bulk_buffer, 5,
+			  ttusbir_bulk_complete, tt);
 
 	tt->led.name = "ttusbir:green:power";
 	tt->led.default_trigger = "rc-feedback";
@@ -350,6 +353,7 @@ static int ttusbir_probe(struct usb_interface *intf,
 		kfree(tt);
 	}
 	rc_free_device(rc);
+	kfree(buffer);
 
 	return ret;
 }
@@ -373,6 +377,7 @@ static void ttusbir_disconnect(struct usb_interface *intf)
 	usb_kill_urb(tt->bulk_urb);
 	usb_free_urb(tt->bulk_urb);
 	rc_free_device(tt->rc);
+	kfree(tt->bulk_buffer);
 	usb_set_intfdata(intf, NULL);
 	kfree(tt);
 }


