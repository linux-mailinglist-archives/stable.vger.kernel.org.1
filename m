Return-Path: <stable+bounces-261683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VSKlGWhNJWo/GgIAu9opvQ
	(envelope-from <stable+bounces-261683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:52:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3E650129
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:52:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Evjgkhqp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261683-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261683-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EFCC3017F85
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878F319851;
	Sun,  7 Jun 2026 10:51:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68A2E3AF1;
	Sun,  7 Jun 2026 10:51:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829461; cv=none; b=Zhw5VhqP7835xD5Ff/WRWHmJaofRi63mJ7EtUPX2A/INwXHmlmLN//y/pcWFmPD6gcwSYnwZ/ZVUkWc7biJbeeEFrk6l7LOLwiY9bVkvIPK9Z2vczmxcHethvCBSc1A2ZZKwy9sgOXBx6R5QRVE98qOtvrzEgdXbpmWsWTrBZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829461; c=relaxed/simple;
	bh=aeLGvbsQ9PBpQeTMDvn2Fw0uWxCA9viIfr0Ineka0PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1Bqz4roO5V5wWk6pnBIdsK/YgjD1wNNOGccnidkl5h2btnYD+K62Jr/QUnBLPd6F3thEcinEruWOFNxUmjGTD7/YDc1iWyrzdHHSEPC4ylkyPRx3mUiChhcbu8OVt/5tDvYhrPnppGyMLqpGW9Uvs5FpUmB2IZ68iv5nzYFc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Evjgkhqp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4CD1F00893;
	Sun,  7 Jun 2026 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829460;
	bh=aQLvWD/H2VcWSROBwG7pXfvUCx4jcc+qmfsLiDgRFV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EvjgkhqpcnJ5XmxoPwzWNMJ0MKHJKIsInnPmebZjipA2Ob7TO1T95XguPIgkGL6OV
	 bej4XWozUzJK0UAih8XeQaX0tF2B9Q9rlhUnYY5xwA8bpYnbG6sEC5MH+bG2mgc18U
	 FQkIm7k9lugXfRpGj6Q0Qjv6i75Ioex2cOwktDjk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Cen <rollkingzzc@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.18 237/315] USB: serial: cypress_m8: validate interrupt packet headers
Date: Sun,  7 Jun 2026 12:00:24 +0200
Message-ID: <20260607095736.271560879@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261683-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rollkingzzc@gmail.com,m:johan@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7B3E650129

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Cen <rollkingzzc@gmail.com>

commit 9f9bfc80c67f35a275820da7e83a35dface08281 upstream.

cypress_read_int_callback() parses the interrupt-in buffer according to
the selected Cypress packet format. Format 1 has a two-byte status/count
header and format 2 has a one-byte combined status/count header. The
usb-serial core sizes the interrupt-in buffer from the endpoint
descriptor's wMaxPacketSize, and successful interrupt transfers can
complete short when URB_SHORT_NOT_OK is not set.

Check that the completed packet contains the selected header before
reading it. Malformed short reports are ignored and the interrupt URB is
resubmitted through the existing retry path, preventing out-of-bounds
header-byte reads.

KASAN report as below:
KASAN slab-out-of-bounds in cypress_read_int_callback+0x240/0x7f0
Read of size 1
Call trace:
  cypress_read_int_callback() (drivers/usb/serial/cypress_m8.c:1009)
  __usb_hcd_giveback_urb()
  dummy_timer()

Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from characteristic size")
Assisted-by: Codex:gpt-5.5
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
Fixes: 3416eaa1f8f8 ("USB: cypress_m8: Packet format is separate from characteristic size")
Cc: stable@vger.kernel.org	# 2.6.26
[ johan: use constants in header length sanity checks ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/cypress_m8.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -1017,8 +1017,8 @@ static void cypress_read_int_callback(st
 	char tty_flag = TTY_NORMAL;
 	int bytes = 0;
 	int result;
-	int i = 0;
 	int status = urb->status;
+	int i;
 
 	switch (status) {
 	case 0: /* success */
@@ -1056,22 +1056,32 @@ static void cypress_read_int_callback(st
 
 	spin_lock_irqsave(&priv->lock, flags);
 	result = urb->actual_length;
+	i = 0;
 	switch (priv->pkt_fmt) {
 	default:
 	case packet_format_1:
 		/* This is for the CY7C64013... */
+		if (result < 2)
+			break;
 		priv->current_status = data[0] & 0xF8;
 		bytes = data[1] + 2;
 		i = 2;
 		break;
 	case packet_format_2:
 		/* This is for the CY7C63743... */
+		if (result < 1)
+			break;
 		priv->current_status = data[0] & 0xF8;
 		bytes = (data[0] & 0x07) + 1;
 		i = 1;
 		break;
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
+	if (i == 0) {
+		dev_dbg(dev, "%s - short packet received: %d bytes\n",
+			__func__, result);
+		goto continue_read;
+	}
 	if (result < bytes) {
 		dev_dbg(dev,
 			"%s - wrong packet size - received %d bytes but packet said %d bytes\n",



