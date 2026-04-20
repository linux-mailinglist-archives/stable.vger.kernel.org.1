Return-Path: <stable+bounces-239787-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N15FLlj5mkuvwEAu9opvQ
	(envelope-from <stable+bounces-239787-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:34:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5DF4317F9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD3E3313BB1F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B423BD17;
	Mon, 20 Apr 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wXMwmoe2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B27933F5BC;
	Mon, 20 Apr 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701215; cv=none; b=iR9fZGjRjBqpw8QeIyNdTd/7xMFVUfupcf0kqoVeuYc44z+sJdv7dUfQ8UCfTPjF7colc8J5+Lt2xsAcL/VbYZqJSmojwFLgVHQopKQZNXcFS0+IdIVxph92cp3GvYoi3Qt8wQPcsTiqRFSYqfgTWq8XOuIUUXvacGL/48VU0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701215; c=relaxed/simple;
	bh=vod8egGUn6RK7YPNCjB9SbkUHWnAQYGLFg+Vlvf5Lm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f04uIUnRG2ZkcXiOGEWh3bHsdNMkc3AzqhN8jLoQ2kAfHUkJQPT/ma6+Y9c/gInqiwCWlCLh59Br82UkuH0J1QG2M/JS0I48SoYQb3guS/vbREpD9LCtNf6/aC/sZbVeFTn8/xGkBP18dZF8YsBlDyFKap/V6n11iVkj4l2Ox0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wXMwmoe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B89C19425;
	Mon, 20 Apr 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701214;
	bh=vod8egGUn6RK7YPNCjB9SbkUHWnAQYGLFg+Vlvf5Lm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wXMwmoe2DoZLqevmsCBhPlxG6QTtx4Sf5EUQCVWFLwf0Oo8AtX3G9Hvv3u1ur1qrC
	 Yegjs+WGlmJTD+5u3xXSW1imMw+Pdf5hW3itedIvI+zJBs/S76xlvVYe5Bdo/u75af
	 eRBYALPljmbc/pNa/vECZ8VFpxE91otc9kZg6hMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	leo vriska <leo@60228.dev>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 027/162] HID: quirks: add HID_QUIRK_ALWAYS_POLL for 8BitDo Pro 3
Date: Mon, 20 Apr 2026 17:40:59 +0200
Message-ID: <20260420153928.004001991@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239787-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,60228.dev:email]
X-Rspamd-Queue-Id: 4C5DF4317F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: leo vriska <leo@60228.dev>

[ Upstream commit 532743944324a873bbaf8620fcabcd0e69e30c36 ]

According to a mailing list report [1], this controller's predecessor
has the same issue. However, it uses the xpad driver instead of HID, so
this quirk wouldn't apply.

[1]: https://lore.kernel.org/linux-input/unufo3$det$1@ciao.gmane.io/

Signed-off-by: leo vriska <leo@60228.dev>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 3 +++
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 25eb5cc7de70e..475e6eb4702af 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -22,6 +22,9 @@
 #define USB_DEVICE_ID_3M2256		0x0502
 #define USB_DEVICE_ID_3M3266		0x0506
 
+#define USB_VENDOR_ID_8BITDO		0x2dc8
+#define USB_DEVICE_ID_8BITDO_PRO_3	0x6009
+
 #define USB_VENDOR_ID_A4TECH		0x09da
 #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
 #define USB_DEVICE_ID_A4TECH_X5_005D	0x000a
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 7a3e0675d9ba2..d9e33dde89899 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -25,6 +25,7 @@
  */
 
 static const struct hid_device_id hid_quirks[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_8BITDO, USB_DEVICE_ID_8BITDO_PRO_3), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },
-- 
2.53.0




