Return-Path: <stable+bounces-234439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACyHCz+i1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:45:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2EE3C1710
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EC733088F71
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0212C3B0ADA;
	Wed,  8 Apr 2026 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZaoZ7Vm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD9324B1F;
	Wed,  8 Apr 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672862; cv=none; b=QvwD+PhObFWgugsHiRXY+SbMxCozxSZwjNtBBMYS9jJKdiwx69PXvMV0Z8bOaXJnrICLFzYiOmnUw3mEN9iWEsdYVhpls8cMNG9kine0k0rt+nGJx25qmLHtaUm88sHsCf2+yDuKPRS9LLowRr1mKEoO0ZMtGP9dl20ei/G0UkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672862; c=relaxed/simple;
	bh=O/Cr1B7TSn8rhgV2fmeD2asi8YTCD8Exx1g7JqSikZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCDeAIN5nanj5drNEF58F2tIuprNOqEFr7LmjGVKyH9N9R1CiDDBlHh1OQX3pFnn6rxv/tI/CvLslypKQUDpatBdPTY5bvcvqKTnl7SqmmOj7kAB3V9yAmBNB+oNxJiSr5r3cTKeRfAuReAo26BVX+JuztyQN6b/rW2Ei+QJuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZaoZ7Vm0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F829C19421;
	Wed,  8 Apr 2026 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672862;
	bh=O/Cr1B7TSn8rhgV2fmeD2asi8YTCD8Exx1g7JqSikZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaoZ7Vm0DAsgXjW6TIt+bHX6TLzWQmKDkL+ukb+3EjzQQarNYocCiJi0FDxajW30z
	 5p883611Fnj6i25Imu7hkeqxwsrHHmfDUO23V2WuaS+iKjWwYi0hYgy/vdM2wwSqrY
	 bV3UmE7sH/REo5ITKl4UFZQgPmcwzYKuEv/9cOHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Freund <adrian@freund.io>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 002/277] HID: logitech-hidpp: Enable MX Master 4 over bluetooth
Date: Wed,  8 Apr 2026 19:59:47 +0200
Message-ID: <20260408175933.933485251@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234439-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,freund.io:email]
X-Rspamd-Queue-Id: AF2EE3C1710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Freund <adrian@freund.io>

[ Upstream commit 70031e70ca15ede6a39db4d978e53a6cc720d454 ]

The Logitech MX Master 4 can be connected over bluetooth or through a
Logitech Bolt receiver. This change adds support for non-standard HID
features, such as high resolution scrolling when the mouse is connected
over bluetooth.
Because no Logitech Bolt receiver driver exists yet those features
won't be available when the mouse is connected through the receiver.

Signed-off-by: Adrian Freund <adrian@freund.io>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 6b463ce112a3c..3522e69da78d7 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4667,6 +4667,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
 	{ /* Slim Solar+ K980 Keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb391) },
+	{ /* MX Master 4 mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb042) },
 	{}
 };
 
-- 
2.53.0




