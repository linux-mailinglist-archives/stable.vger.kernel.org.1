Return-Path: <stable+bounces-261270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C5mOJSZHJWpMFwIAu9opvQ
	(envelope-from <stable+bounces-261270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:25:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4864FA4B
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:25:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=1NKUH3pa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261270-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261270-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCB7F30073E7
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE313254A9;
	Sun,  7 Jun 2026 10:25:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F900202C46;
	Sun,  7 Jun 2026 10:25:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827910; cv=none; b=dVEsVJA/jY2DyIlrAjKiB0axAe3ykHvzyyVEmj+sDUJ50s7A8uobrJd9HqjOGvF19KzNj0O6rlZ0cwIP3nWlTVBptWuYyeO2qduxgk9PQ2w1/kXo2apl50Qw30LLkSVFKm9/UCmc6J9IZcaCghI7i9vHdoozUoIXBcXTVOPghn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827910; c=relaxed/simple;
	bh=LeHhIHcwZnqje1NpehLAN8w5D5rrQ+E37LFDgjUJtaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3Wym5HUYMRKVh3fC0hVUTJ+AMxOPEFTNwvd0HZ9bXLNCf6ca+bZBJ1LcCveiv2DykpySNAdGx1ZvX9ht0/W2ZPM71bokJD1KVrfPldT7yCO5wizbECoUeeNhj26wG5M3HZUQee9j41rRV8DOVPwZfQaG5rBFI9Khg/9X6JGeNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1NKUH3pa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97591F00893;
	Sun,  7 Jun 2026 10:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827909;
	bh=ljSiUK1/fKXUnSSXpj1e85oOc9nHwjlrbZiexA0hr1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1NKUH3paGCBoraoUy6Cwd7ADm366Uuk15x5/us5+PG675AAPPO8U9eNnR1Q0L7TDo
	 j8DkRKwAC+Pd7GOGHTMXimo9Rm9JtyKGjngKX2jE/FcHaYo0clSacJwlId6R6jPrcm
	 OvxT8EwBoTBswcmr0UMz0YmYR6WvDZksccaVC0o8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 7.0 129/332] USB: serial: safe_serial: fix memory corruption with small endpoint
Date: Sun,  7 Jun 2026 11:58:18 +0200
Message-ID: <20260607095732.843110755@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261270-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johan@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FA4864FA4B

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 438061ed1ad85e6743e2dce826671772d81089ec upstream.

Make sure that the bulk-out buffer size is at least eight bytes to avoid
user-controlled slab corruption in "safe" mode should a malicious device
report a smaller size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/safe_serial.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/serial/safe_serial.c
+++ b/drivers/usb/serial/safe_serial.c
@@ -259,6 +259,7 @@ static int safe_prepare_write_buffer(str
 static int safe_startup(struct usb_serial *serial)
 {
 	struct usb_interface_descriptor	*desc;
+	int bulk_out_size;
 
 	if (serial->dev->descriptor.bDeviceClass != CDC_DEVICE_CLASS)
 		return -ENODEV;
@@ -279,6 +280,16 @@ static int safe_startup(struct usb_seria
 	default:
 		return -EINVAL;
 	}
+
+	/*
+	 * The bulk-out buffer needs to be large enough for the two-byte
+	 * trailer in safe mode, but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	bulk_out_size = serial->port[0]->bulk_out_size;
+	if (bulk_out_size > 0 && bulk_out_size < 8)
+		return -EINVAL;
+
 	return 0;
 }
 



