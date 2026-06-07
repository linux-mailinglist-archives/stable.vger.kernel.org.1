Return-Path: <stable+bounces-261726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WK3+ChlOJWqBGgIAu9opvQ
	(envelope-from <stable+bounces-261726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:55:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7365020A
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:55:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=X38U5bNq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261726-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261726-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07D9030254A6
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ECB2E3AF1;
	Sun,  7 Jun 2026 10:53:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BA31ED93;
	Sun,  7 Jun 2026 10:53:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829609; cv=none; b=lpAfLEEk0iJ2q7zDd/FZt44XWTeAWqzYHPquPCaFh52C8TRmk81XVJfvMpr9EBEYGHLnTNwBsMtUknSfqd36jHLwLse0uOk0ZLcaO0vlW/+NgTGmguxtioQ0L6ZPpb3Isce7BDC9/9j1JxZHU4Cf6kv7m/ms/8N+HUKBrJ7Ik68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829609; c=relaxed/simple;
	bh=31XNSCMGoqoj8j/S7EnFrG0AiCD8GGvvyogQ3DUuyt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syg5HwIPtVBKj4YDfWZpxS/PwuMjofKsbpuYhix27PxISv0ESUC9j1MPYcIKGiwqEmD/OGFr8lAkWMTZ4XjOj5qrzQgYE1W3YGLB5WHV7yaCIwZ+yZh+/TVOTz9JabvbJyAgNPWMs1+0tS4iUIgISC/s8xN4VSa8AxNtMibGa5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X38U5bNq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ABF1F00893;
	Sun,  7 Jun 2026 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829608;
	bh=oGOQo9o4nIBbjdaalmox/EF5FdOGPkplF0RvLy1jjf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X38U5bNqy0gg7r0BeAxvGa3T6k5yTQo6CGj7NHAQ/tg9mHEI1bfZ6Jf3KWij666N2
	 cupE9nuZNZHBUiE6dZBv1X8MYsW3xfF/Q3JqQUedsndMTKvuxtt9i1KzDhXC8a0yRL
	 XtVtK7YI8dWgR1/uiBZy6Un4acQ4HzgNg6bwqoqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Lunn <andrew@lunn.ch>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.18 239/315] USB: serial: mxuport: fix memory corruption with small endpoint
Date: Sun,  7 Jun 2026 12:00:26 +0200
Message-ID: <20260607095736.347435396@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261726-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:andrew@lunn.ch,m:johan@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BD7365020A

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4085f0dbb1ce2251c9a5938d693de6593f0ab2bd upstream.

Make sure that the bulk-out endpoint max packet size is at least eight
bytes to avoid user-controlled slab corruption should a malicious device
report a smaller size.

Fixes: ee467a1f2066 ("USB: serial: add Moxa UPORT 12XX/14XX/16XX driver")
Cc: stable@vger.kernel.org	# 3.14
Cc: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/mxuport.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -962,6 +962,14 @@ static int mxuport_calc_num_ports(struct
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(epds->bulk_out) < 16);
 
+	/*
+	 * The bulk-out buffers must be large enough for the four-byte header
+	 * (and following data), but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	if (usb_endpoint_maxp(epds->bulk_out[0]) < 8)
+		return -EINVAL;
+
 	for (i = 1; i < num_ports; ++i)
 		epds->bulk_out[i] = epds->bulk_out[0];
 



