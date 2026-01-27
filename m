Return-Path: <stable+bounces-211805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLuMF4+8eGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:24:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3D994DE9
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7081303389F
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BF34FF64;
	Tue, 27 Jan 2026 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tdxcCjWM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30541C6B4
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520214; cv=none; b=HbAHUZ8FdH8VIe9btrg7qtgQwxwePHpFhEJVgssQHgJk0hNOzU1qsgfG4II2I6BdD8YoDTKfYUeNIuLJuFp9hjxMKqcdn+TOPGmB7JB1/BzF4uZkVjAs/NyBKt0Mj2D5JbfFC0vHroFD64MvecVJyn5P92KQWTPdhTyXvxrDt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520214; c=relaxed/simple;
	bh=RXa2MjvQvIW9ycXgvedYv7cz8L7yh5WZleaafxalZn0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=G9ci8Xl0W7cKOyeidpJwez68Gv0f1ztSz17L6j0GJpZGLJU2IbVmt4thm2SSjKXf/mySfxmTvjqlaEHSDUIQvM3f2Aet3DGgUX29Z56gb29ukE807qgJH2+3TAgL78auDtvqlpxYD3UfRoOw21Htd910vnqK0Y0DoFBFYe5x1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tdxcCjWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6356C116C6;
	Tue, 27 Jan 2026 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769520213;
	bh=RXa2MjvQvIW9ycXgvedYv7cz8L7yh5WZleaafxalZn0=;
	h=Subject:To:Cc:From:Date:From;
	b=tdxcCjWMM4WD32FohnkV1TzPPQSPtjuSFVSrf8MzntPhpCalCZN0ET4jIFoAB8PaG
	 RIEaq4kqtxTwz2hAP9wV1zwfyKkl/RAdPZ9oS3SLy3uJT4rO7xqJh+b9SO4hbWZXvM
	 z91Y/kAqXaAcRLlgmGp8RkiHHD9Gp/5dwU/vtp2s=
Subject: FAILED: patch "[PATCH] can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory" failed to apply to 6.1-stable tree
To: mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:23:16 +0100
Message-ID: <2026012716-condense-unblended-43b9@gregkh>
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
	TAGGED_FROM(0.00)[bounces-211805-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,pengutronix.de:email,gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BD3D994DE9
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5a4391bdc6c8357242f62f22069c865b792406b3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012716-condense-unblended-43b9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


