Return-Path: <stable+bounces-239289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIDSKOpV5mktvAEAu9opvQ
	(envelope-from <stable+bounces-239289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:35:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4068242FB06
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C752832117B0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CE83382F4;
	Mon, 20 Apr 2026 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OukDqXCR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA5336EC9;
	Mon, 20 Apr 2026 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699868; cv=none; b=TouYY21pw242d3CTKS1JaZ5dt3iIjBqOTEEpB2QnBN9fnhy4B+Z04ZPjHd20Cx84m7RpP+yFz0LH0vL7ZfsObY3T3IPrHVJx3bO+rorITLfgjDkXTt4nBe9NHZvXjGNv7fujM+l2M6gpzywTAJUHtPruGd0IihhzhnmD2txjMXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699868; c=relaxed/simple;
	bh=hzGGv/bPj53hpsUoAvp0AgrKtAQTrlwsFgRLF5lLiQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9yf7mhIh4Z4MMre2db8OOmzBvxLDX7pK92X0gjrDFLsvz9/ENjCrn/BXIIKHA+YmA+mxhduCk/60dyEfESurAJimhBo2RROY1ZBePAx+1Y3opkzJPBlrxr4EW6oTS2G42C64jD8o/Soa9m4wtN9kRUqhnJv44nYtQlEHdeJEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OukDqXCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9C4C19425;
	Mon, 20 Apr 2026 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776699867;
	bh=hzGGv/bPj53hpsUoAvp0AgrKtAQTrlwsFgRLF5lLiQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OukDqXCRjZb63KYWVR10WnjZz9k0uMYfCSrcQY1LgVV45FM2WEg/UjsB5gt0yLqXG
	 yboguddu0gFggrEKRQSYMyu86baS2U/9ztrwsjUyurh/n41fcnWGX151AMT2q+dQMH
	 FUTDhgHffHikOL7/h2Dz65gRAIkE0hP28j3Vk6nk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Carey <carvsdriver@gmail.com>,
	stable <stable@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 7.0 28/76] USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen
Date: Mon, 20 Apr 2026 17:41:39 +0200
Message-ID: <20260420153911.847097875@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
References: <20260420153910.810034134@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239289-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4068242FB06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Carey <carvsdriver@gmail.com>

commit f58752ebcb35e156c85cd1a82d6579c7af3b9023 upstream.

The Lenovo Yoga Book 9 14IAH10 (83KJ) has a composite USB device
(17EF:6161) that controls both touchscreens via a CDC ACM interface.
Interface 0 is a standard CDC ACM control interface, but interface 1
(the data interface) incorrectly declares vendor-specific class (0xFF)
instead of USB_CLASS_CDC_DATA. cdc-acm rejects the device at probe with
-EINVAL, leaving interface 0 unbound and EP 0x82 never polled.

With no consumer polling EP 0x82, the firmware's watchdog fires every
~20 seconds and resets the USB bus, producing a continuous disconnect/
reconnect loop that prevents the touchscreens from ever initialising.

Add two new quirk flags:

VENDOR_CLASS_DATA_IFACE: Bypasses the bInterfaceClass check in
acm_probe() that would otherwise reject the vendor-class data
interface with -EINVAL.

ALWAYS_POLL_CTRL: Submits the notification URB at probe() rather than
waiting for a TTY open. This keeps EP 0x82 polled at all times,
permanently suppressing the firmware watchdog. The URB is resubmitted
after port_shutdown() and on system resume. SET_CONTROL_LINE_STATE
(DTR|RTS) is sent at probe and after port_shutdown() to complete
firmware handshake.

Note: the firmware performs exactly 4 USB connect/disconnect cycles
(~19 s each) on every cold boot before stabilising. This is a fixed
firmware property; touch is available ~75-80 s after power-on.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
Cc: stable <stable@kernel.org>
Tested-by: Dave Carey <carvsdriver@gmail.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
Link: https://patch.msgid.link/20260402182950.389016-1-carvsdriver@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-acm.c |   53 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 7 deletions(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -114,6 +114,8 @@ static int acm_ctrl_msg(struct acm *acm,
 	int retval;
 
 	retval = usb_autopm_get_interface(acm->control);
+#define VENDOR_CLASS_DATA_IFACE		BIT(9)  /* data interface uses vendor-specific class */
+#define ALWAYS_POLL_CTRL		BIT(10) /* keep ctrl URB active even without an open TTY */
 	if (retval)
 		return retval;
 
@@ -710,12 +712,14 @@ static int acm_port_activate(struct tty_
 	set_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
 	acm->control->needs_remote_wakeup = 1;
 
-	acm->ctrlurb->dev = acm->dev;
-	retval = usb_submit_urb(acm->ctrlurb, GFP_KERNEL);
-	if (retval) {
-		dev_err(&acm->control->dev,
-			"%s - usb_submit_urb(ctrl irq) failed\n", __func__);
-		goto error_submit_urb;
+	if (!(acm->quirks & ALWAYS_POLL_CTRL)) {
+		acm->ctrlurb->dev = acm->dev;
+		retval = usb_submit_urb(acm->ctrlurb, GFP_KERNEL);
+		if (retval) {
+			dev_err(&acm->control->dev,
+				"%s - usb_submit_urb(ctrl irq) failed\n", __func__);
+			goto error_submit_urb;
+		}
 	}
 
 	acm_tty_set_termios(tty, NULL);
@@ -788,6 +792,14 @@ static void acm_port_shutdown(struct tty
 
 	acm_unpoison_urbs(acm);
 
+	if (acm->quirks & ALWAYS_POLL_CTRL) {
+		acm->ctrlurb->dev = acm->dev;
+		if (usb_submit_urb(acm->ctrlurb, GFP_KERNEL))
+			dev_dbg(&acm->control->dev,
+				"ctrl polling restart failed after port close\n");
+		/* port_shutdown() cleared DTR/RTS; restore them */
+		acm_set_control(acm, USB_CDC_CTRL_DTR | USB_CDC_CTRL_RTS);
+	}
 }
 
 static void acm_tty_cleanup(struct tty_struct *tty)
@@ -1328,6 +1340,9 @@ skip_normal_probe:
 			dev_dbg(&intf->dev,
 				"Your device has switched interfaces.\n");
 			swap(control_interface, data_interface);
+		} else if (quirks & VENDOR_CLASS_DATA_IFACE) {
+			dev_dbg(&intf->dev,
+				"Vendor-specific data interface class, continuing.\n");
 		} else {
 			return -EINVAL;
 		}
@@ -1522,6 +1537,9 @@ skip_countries:
 	acm->line.bDataBits = 8;
 	acm_set_line(acm, &acm->line);
 
+	if (quirks & ALWAYS_POLL_CTRL)
+		acm_set_control(acm, USB_CDC_CTRL_DTR | USB_CDC_CTRL_RTS);
+
 	if (!acm->combined_interfaces) {
 		rv = usb_driver_claim_interface(&acm_driver, data_interface, acm);
 		if (rv)
@@ -1543,6 +1561,13 @@ skip_countries:
 
 	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
+	if (acm->quirks & ALWAYS_POLL_CTRL) {
+		acm->ctrlurb->dev = acm->dev;
+		if (usb_submit_urb(acm->ctrlurb, GFP_KERNEL))
+			dev_warn(&intf->dev,
+				 "failed to start persistent ctrl polling\n");
+	}
+
 	return 0;
 
 err_release_data_interface:
@@ -1669,7 +1694,7 @@ static int acm_resume(struct usb_interfa
 
 	acm_unpoison_urbs(acm);
 
-	if (tty_port_initialized(&acm->port)) {
+	if (tty_port_initialized(&acm->port) || (acm->quirks & ALWAYS_POLL_CTRL)) {
 		rv = usb_submit_urb(acm->ctrlurb, GFP_ATOMIC);
 
 		for (;;) {
@@ -2016,6 +2041,20 @@ static const struct usb_device_id acm_id
 	/* CH343 supports CAP_BRK, but doesn't advertise it */
 	{ USB_DEVICE(0x1a86, 0x55d3), .driver_info = MISSING_CAP_BRK, },
 
+	/*
+	 * Lenovo Yoga Book 9 14IAH10 (83KJ) — INGENIC 17EF:6161 touchscreen
+	 * composite device.  The CDC ACM control interface (0) uses a standard
+	 * Union descriptor, but the data interface (1) is declared as vendor-
+	 * specific class (0xff) with no CDC data descriptors, so cdc-acm would
+	 * normally reject it.  The firmware also requires continuous polling of
+	 * the notification endpoint (EP 0x82) to suppress a 20-second watchdog
+	 * reset; ALWAYS_POLL_CTRL keeps the ctrlurb active even when no TTY is
+	 * open.  Match only the control interface by class to avoid probing the
+	 * vendor-specific data interface.
+	 */
+	{ USB_DEVICE_INTERFACE_CLASS(0x17ef, 0x6161, USB_CLASS_COMM),
+	  .driver_info = VENDOR_CLASS_DATA_IFACE | ALWAYS_POLL_CTRL },
+
 	/* control interfaces without any protocol set */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM,
 		USB_CDC_PROTO_NONE) },



