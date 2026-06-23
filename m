Return-Path: <stable+bounces-267962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9CZzFbOjOmqUCQgAu9opvQ
	(envelope-from <stable+bounces-267962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:18:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 045EE6B83FF
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 17:18:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A1mS2DWc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267962-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267962-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6410D309FEB5
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9897D3D7D7F;
	Tue, 23 Jun 2026 15:12:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7831E84E;
	Tue, 23 Jun 2026 15:12:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782227558; cv=none; b=j5+kFBjzRQYHPSH0CzUW0vXwDCGpsNOP0g+uEx57BHDkAl+5+IeMZAbFnaW7kSUspKGhPzZJnJZrYcOlTKd6Mllv1Pflsv9gkUi7Ovs6z/Qm70AOHa6k5i+4zhzoM4eP8UjABQ9sL9C5cBk9vCtDJNusoPOEkCyuvHQvf696CKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782227558; c=relaxed/simple;
	bh=8sgXOSJ6vtlHxBsg4CBR5epczhNhfjmOHInIuwXp4dA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIblTxYpxAXY6KwvEVguSFV+obYK2PG/oZ3sYwu8CekItnCx4q5lN5gbEhRPXUt4IiWyWhnVkuKrxZKWmpFnFZ1lBQXZXebVE/EOAT4jSkmI/8er7q1NFMqLzC/FColbs7UCXyzDjH/cM0HVzuQhHlx4Ypq5MsL+z57joQyTMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1mS2DWc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AC61F000E9;
	Tue, 23 Jun 2026 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782227557;
	bh=cVrqoqYHVIb6mlngxPsx3Rqg5kwScXHXn92OSLejVv4=;
	h=From:To:Cc:Subject:Date;
	b=A1mS2DWcxMkXjgibw1twDRKEJY9UBuoD64BIcKdS4xbrdKbSMKxzrDnNYr2bVJLlG
	 PFQ46OrynwMWCoEzGKC18gEYvKY49H7qieX/zCT4mjA53oU1BlCDSdEUOE1Zzgu8nX
	 Wyu512IOVrnadZ+sgT77P1Hy9xtydgAFp2mZhzrZ/KKPL6CK4QQXWSWuP+Q5MNDr3Q
	 xv64AmU8CxN5a/ZvKv6RyNoaP9+SbWoD5MrvpG7N+7Xj4+j66ahi/0xaQ4rmmXKAy2
	 El9xgViLOjO+N2K3pM/NE081PZ1jsVdwpgp1DlwvfH7bMb3QZJE4ZTwrDQLf64bPQe
	 9RnMYULa0MKgA==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wc2ni-00000001K0X-46QE;
	Tue, 23 Jun 2026 17:12:34 +0200
From: Johan Hovold <johan@kernel.org>
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: digi_acceleport: fix write buffer corruption
Date: Tue, 23 Jun 2026 17:12:29 +0200
Message-ID: <20260623151229.315224-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267962-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-usb@vger.kernel.org,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:johan@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 045EE6B83FF

The digi_write_inb_command() is supposed to wait for the write urb to
become available or return an error, but instead it updates the transfer
buffer and tries to resubmit the urb on timeout.

To make things worse, for commands like break control where no timeout
is used, the driver would corrupt the urb immediately due to a broken
jiffies comparison (on 32-bit machines this takes five minutes of uptime
to trigger due to INITIAL_JIFFIES).

Fix this by adding the missing return on timeout and waiting
indefinitely when no timeout has been specified as intended.

This issue was (sort of) flagged by Sashiko when reviewing an unrelated
change to the driver.

Link: https://sashiko.dev/#/patchset/20260610132232.356139-1-johan%40kernel.org?part=11
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/digi_acceleport.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 88c61030982a..fa5c3539f806 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -429,20 +429,22 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 	int len;
 	struct digi_port *priv = usb_get_serial_port_data(port);
 	unsigned char *data = port->write_urb->transfer_buffer;
+	unsigned long expire;
 	unsigned long flags;
 
 	dev_dbg(&port->dev, "digi_write_inb_command: TOP: port=%d, count=%d\n",
 		priv->dp_port_num, count);
 
 	if (timeout)
-		timeout += jiffies;
-	else
-		timeout = ULONG_MAX;
+		expire = jiffies + timeout;
 
 	spin_lock_irqsave(&priv->dp_port_lock, flags);
 	while (count > 0 && ret == 0) {
-		while (priv->dp_write_urb_in_use &&
-		       time_before(jiffies, timeout)) {
+		while (priv->dp_write_urb_in_use) {
+			if (timeout && time_after(jiffies, expire)) {
+				ret = -ETIMEDOUT;
+				break;
+			}
 			cond_wait_interruptible_timeout_irqrestore(
 				&priv->write_wait, DIGI_RETRY_TIMEOUT,
 				&priv->dp_port_lock, flags);
@@ -451,6 +453,9 @@ static int digi_write_inb_command(struct usb_serial_port *port,
 			spin_lock_irqsave(&priv->dp_port_lock, flags);
 		}
 
+		if (ret)
+			break;
+
 		/* len must be a multiple of 4 and small enough to */
 		/* guarantee the write will send buffered data first, */
 		/* so commands are in order with data and not split */
-- 
2.53.0


