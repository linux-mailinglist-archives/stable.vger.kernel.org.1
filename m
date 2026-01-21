Return-Path: <stable+bounces-210885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPsLH0c2cWnffQAAu9opvQ
	(envelope-from <stable+bounces-210885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:25:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE65D285
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6218984019D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46963A8FF4;
	Wed, 21 Jan 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x2Z06cRa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B551DE4E0;
	Wed, 21 Jan 2026 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019714; cv=none; b=QypQF8Jna+7W2Kf/lce5gZkJU+m9tnmAw1fpnswyHSyqHNgXEr6kGDOK+JXrSTDFhhoD/onwViqKlMLfg/CiLqzZFcI0MnZoI+wf+mIHKrGS81DXknYzfjLG8AUh+me3bBeC8T885bMh39KM2Jgcfa5mARsnrqJFXX4gKzAXK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019714; c=relaxed/simple;
	bh=H8runNuahfbUESzK0UmrmRFZQN4MvP4CLRIZot+bN9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GthmNZsqNMu+FvAVMDIodHt+nZlPlii8xD1adSJhwUmjabA51I16V7XUcbvCjVbPXHDk8kiprDG8oigPVJM2XPwESdbCqxri3dvj8s6R7P7QZGfmC7dtYcmBoFel128j/cJEpbZZU45oDp3m0ALT4ElZgadpXqrdLvZsXeS8Ckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x2Z06cRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6300AC4CEF1;
	Wed, 21 Jan 2026 18:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019714;
	bh=H8runNuahfbUESzK0UmrmRFZQN4MvP4CLRIZot+bN9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x2Z06cRa5JlM75hxHhBbcRbPLApwTjg1YtZ8Cl1G1ERje0+pYs5O6WwUsYiGwvNgc
	 5QzoNBC54sQPSyibL28ClGwKiFrb19cGFEoQQeKFDDzBXFqZi0gqM/JvTxSxKyZiFG
	 SRMR8Qwo5jhKsSxcrpFm0uo5fD+SF+kRjjXMpSNY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Tissoires <bentiss@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>
Subject: [PATCH 6.12 059/139] HID: usbhid: paper over wrong bNumDescriptor field
Date: Wed, 21 Jan 2026 19:15:07 +0100
Message-ID: <20260121181413.578336736@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-210885-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1ADE65D285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <bentiss@kernel.org>

commit f28beb69c51517aec7067dfb2074e7c751542384 upstream.

Some faulty devices (ZWO EFWmini) have a wrong optional HID class
descriptor count compared to the provided length.

Given that we plainly ignore those optional descriptor, we can attempt
to fix the provided number so we do not lock out those devices.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/usbhid/hid-core.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -985,6 +985,7 @@ static int usbhid_parse(struct hid_devic
 	struct usb_device *dev = interface_to_usbdev (intf);
 	struct hid_descriptor *hdesc;
 	struct hid_class_descriptor *hcdesc;
+	__u8 fixed_opt_descriptors_size;
 	u32 quirks = 0;
 	unsigned int rsize = 0;
 	char *rdesc;
@@ -1015,7 +1016,21 @@ static int usbhid_parse(struct hid_devic
 			      (hdesc->bNumDescriptors - 1) * sizeof(*hcdesc)) {
 		dbg_hid("hid descriptor invalid, bLen=%hhu bNum=%hhu\n",
 			hdesc->bLength, hdesc->bNumDescriptors);
-		return -EINVAL;
+
+		/*
+		 * Some devices may expose a wrong number of descriptors compared
+		 * to the provided length.
+		 * However, we ignore the optional hid class descriptors entirely
+		 * so we can safely recompute the proper field.
+		 */
+		if (hdesc->bLength >= sizeof(*hdesc)) {
+			fixed_opt_descriptors_size = hdesc->bLength - sizeof(*hdesc);
+
+			hid_warn(intf, "fixing wrong optional hid class descriptors count\n");
+			hdesc->bNumDescriptors = fixed_opt_descriptors_size / sizeof(*hcdesc) + 1;
+		} else {
+			return -EINVAL;
+		}
 	}
 
 	hid->version = le16_to_cpu(hdesc->bcdHID);



