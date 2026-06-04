Return-Path: <stable+bounces-260422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rQPPJgVYIWqjEQEAu9opvQ
	(envelope-from <stable+bounces-260422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:48:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3193763F2F0
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:48:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="XP7c/UEj";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260422-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260422-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B00053028039
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B533B6C6;
	Thu,  4 Jun 2026 10:47:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224D255E43
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:47:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570033; cv=none; b=WQKV0mvEQyVl82kDICdrZ+3IVOI7D9VdtWdPAP/PVtDqu4Yr0DdnG91KLcNIi9KAjFVk9hs0KDUmAn6a0wMgtZZLuQPSByIo2+4N/EyjX6IhygKKLthvLl3hSVzgDSbnF3DMUD6//s6UhOFNo+2DXCX14fRktrsGdjSMIimsasU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570033; c=relaxed/simple;
	bh=X9mx4abG7MYoue1ZWpLNvsEf4YBQhdelm01cix/KDMM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n5qD3Ep57B83QqJLjpsgvVD1bqYIRJi3bfWRp/a5lN98nRl3961aFTI6yY4TqnBISqVHvr1c9sAWHqwzf0+V4NkufGoADhLRKkdTMkBB7GgmgAG/ml88Mh7Gw/jOxwgTV5CuT0ac8ELzgVF9Q4Hr1cPHYCDljkimMeO/2tBkXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XP7c/UEj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F991F00893;
	Thu,  4 Jun 2026 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570032;
	bh=xLrCy9vuGv5DMgbkwk23SH2EwA331+boAGTz9qxds1I=;
	h=Subject:To:Cc:From:Date;
	b=XP7c/UEj78QREyPLoXZvHYdEDrRazUVWiZMjAPTQfsDhPQTOxN0g+568K64ibzFw9
	 D6FjcCAs3OnFGAn6HCPD2fRCgNcsnyJnnc4LXQipd98tPglL7HOPFRlCUYQTjbCX+H
	 QTI3K68HVzJdyYV1llw//aNgQooiBi2Z8CqoaJdg=
Subject: FAILED: patch "[PATCH] USB: serial: mct_u232: fix memory corruption with small" failed to apply to 5.15-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:46:03 +0200
Message-ID: <2026060403-flypaper-wired-653e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260422-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3193763F2F0


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 915b36d701950503c4ea0f6e314b10868e59fce3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060403-flypaper-wired-653e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 915b36d701950503c4ea0f6e314b10868e59fce3 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 20 May 2026 16:27:00 +0200
Subject: [PATCH] USB: serial: mct_u232: fix memory corruption with small
 endpoint

The driver overrides the maximum transfer size for a specific device
which only accepts 16 byte packets for its 32 byte bulk-out endpoint.

Make sure to never increase the maximum transfer size to prevent slab
corruption should a malicious device report a smaller endpoint max
packet size than expected.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>

diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 18844b92bd08..ca1530da6e77 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -378,6 +378,7 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv;
+	u16 pid;
 
 	/* check first to simplify error handling */
 	if (!serial->port[1] || !serial->port[1]->interrupt_in_urb) {
@@ -385,6 +386,16 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * Compensate for a hardware bug: although the Sitecom U232-P25
+	 * device reports a maximum output packet size of 32 bytes,
+	 * it seems to be able to accept only 16 bytes (and that's what
+	 * SniffUSB says too...)
+	 */
+	pid = le16_to_cpu(serial->dev->descriptor.idProduct);
+	if (pid == MCT_U232_SITECOM_PID)
+		port->bulk_out_size = min(16, port->bulk_out_size);
+
 	priv = kzalloc_obj(*priv);
 	if (!priv)
 		return -ENOMEM;
@@ -410,7 +421,6 @@ static void mct_u232_port_remove(struct usb_serial_port *port)
 
 static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
-	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
 	int retval = 0;
 	unsigned int control_state;
@@ -418,15 +428,6 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	unsigned char last_lcr;
 	unsigned char last_msr;
 
-	/* Compensate for a hardware bug: although the Sitecom U232-P25
-	 * device reports a maximum output packet size of 32 bytes,
-	 * it seems to be able to accept only 16 bytes (and that's what
-	 * SniffUSB says too...)
-	 */
-	if (le16_to_cpu(serial->dev->descriptor.idProduct)
-						== MCT_U232_SITECOM_PID)
-		port->bulk_out_size = 16;
-
 	/* Do a defined restart: the normal serial device seems to
 	 * always turn on DTR and RTS here, so do the same. I'm not
 	 * sure if this is really necessary. But it should not harm


