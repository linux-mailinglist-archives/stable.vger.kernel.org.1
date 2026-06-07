Return-Path: <stable+bounces-261260-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zDcSNuJGJWojFwIAu9opvQ
	(envelope-from <stable+bounces-261260-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:24:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2F664F9E8
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:24:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VGGHV1d0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261260-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-261260-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F25C3003604
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9653246F4;
	Sun,  7 Jun 2026 10:24:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC23202C46;
	Sun,  7 Jun 2026 10:24:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827870; cv=none; b=Lb37/czisC7v1vCIZcmOiqs9/B6+x2fbUJA9PYWiRutrwSFQBrCa4+6WiftDbHPJCGwJXYe+5qFdG29ktsPbaY2vbXf4fGd2NcnsKN871IF4p+XmQd55qBIqGGLBKyPk7F9+lXPfvD5s5fxjN8UX0dSjeTBvQWBddTdoyI61/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827870; c=relaxed/simple;
	bh=99m5acwf1WELISFNW8gV1+RsPRJJsyNty1KVsUGyJ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwjYrMlxHntTpUdYtqQ2irsB3Q+hkH60jBtSoceZGIeqM5i4NDRZxGmpnKpepNNS9uvciURv4q6Ps+WjmRYwhBqzuCy6Ga4SIn/tjlfgRbj9adNH/hLQyHCFfH5LyQbM3GYJhts1mN43e5g04WemmLQ03YFuRbhh6n9k2ifc7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGGHV1d0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFA11F00893;
	Sun,  7 Jun 2026 10:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827869;
	bh=WshG5bw2xOA9y9/2ALey8wfq9KU/eVBwZGhIR+U2KSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGGHV1d0JxGsQs6cl2//w+aBETfNh+ZgcAAINlGYKyDezTRGnFKKYDZ8j8S3AO2oy
	 zsYGeQEfQu5d8hnyVWWcNHgNAmRNZL+qJ7klKKZTqkBkdmZbOHA4Xrki0DFt4YGrzq
	 I768OEYk2TvEvP/++I7xPYaiwJlLFxeTYcUZ+//o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	hlleng <a909204013@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 7.0 133/332] HID: quirks: Add ALWAYS_POLL quirk for SIGMACHIP USB mouse
Date: Sun,  7 Jun 2026 11:58:22 +0200
Message-ID: <20260607095732.981450404@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-261260-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:a909204013@gmail.com,m:bentiss@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B2F664F9E8

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: hlleng <a909204013@gmail.com>

commit 07466fc91c55532edcfb5c6a7ccd2ea52728d6bd upstream.

The SIGMACHIP USB mouse with VID/PID 1c4f:0034 can disconnect and
re-enumerate repeatedly after it has been enumerated if its interrupt
endpoint is not continuously polled.

This was observed with the device reporting itself as "SIGMACHIP Usb
Mouse". Keeping the input event device open avoids the disconnects.

Add HID_QUIRK_ALWAYS_POLL for this device so the HID core keeps polling
it even when there is no userspace input consumer.

Cc: stable@vger.kernel.org
Signed-off-by: hlleng <a909204013@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-ids.h    |    1 +
 drivers/hid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1261,6 +1261,7 @@
 
 #define USB_VENDOR_ID_SIGMA_MICRO	0x1c4f
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
+#define USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE	0x0034
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2	0x0059
 
 #define USB_VENDOR_ID_SIGMATEL		0x066F
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -186,6 +186,7 @@ static const struct hid_device_id hid_qu
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH), HID_QUIRK_NOGET },



