Return-Path: <stable+bounces-243305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIgqLIGr+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6B4BF32F
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1099303ADE1
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3F63DE440;
	Mon,  4 May 2026 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WV6JRavJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826F1ADC83;
	Mon,  4 May 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903545; cv=none; b=vARk9q9CjH3yGe66d1uN/MldmtEEmwvNs1TJfU70xN0nKhW3nOu/hs77nk+hu78T2ENSAOmHFKBk5c4DMTi9+b9BDT2f42Voz+sS/MxhN2Lhf169zLoVtVHaRfJn3V5bz8UbdF7biaccJzw8JWpjRBFxKeZuY66Mq1gfEcLQGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903545; c=relaxed/simple;
	bh=+3afG4Fn1XZ6Xqu+7DhNJT6RNB9KDk9lGvBYcv2pC+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgIkp+TBBG4Z0EIb/TsnJ4psElJM50hXcVwnLk84s8cWTx2vcAbzRMIXdiXJipGqRdLcbmwHzk74MXtfu1Y5QHtiI897/2mzjKGdxADDRJlRLXYR7CfmRHnnVSjggORAozkSMm2kEhoACBG/onAj+DZLKfqDn7HX8nCV5rfl1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WV6JRavJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396CAC2BCB8;
	Mon,  4 May 2026 14:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903544;
	bh=+3afG4Fn1XZ6Xqu+7DhNJT6RNB9KDk9lGvBYcv2pC+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WV6JRavJkKtmmHmUU+Ume7lBv7OL05A2nVLl8tRQjW8wx/OtBUxG2rWugwIs4S1y2
	 PfePuHRLfINvO/dV+eH8SGEjymQ61Kv+7sfnmLyRVRhhYJVMmQheJ5FCSNsacAQ5E4
	 xA2iDnn4vFGxNH/W5qd503i1dVuWHTrivH47t1lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Andr=C3=A9=20Eikmeyer?= <andre.eikmeyer@gmail.com>,
	Aditya Garg <gargaditya08@live.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 7.0 243/307] HID: apple: ensure the keyboard backlight is off if suspending
Date: Mon,  4 May 2026 15:52:08 +0200
Message-ID: <20260504135151.974617406@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 1AE6B4BF32F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243305-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,live.com,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,live.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Garg <gargaditya08@live.com>

commit 1f95a6cd5ad78ed27a31a20cbd1facff6f10b33d upstream.

Some users reported that upon suspending their keyboard backlight
remained on. Fix this by adding the missing LED_CORE_SUSPENDRESUME flag.

Cc: stable@vger.kernel.org
Fixes: 394ba612f941 ("HID: apple: Add support for magic keyboard backlight on T2 Macs")
Fixes: 9018eacbe623 ("HID: apple: Add support for keyboard backlight on certain T2 Macs.")
Reported-by: André Eikmeyer <andre.eikmeyer@gmail.com>
Tested-by: André Eikmeyer <andre.eikmeyer@gmail.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-apple.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -858,6 +858,7 @@ static int apple_backlight_init(struct h
 	asc->backlight->cdev.name = "apple::kbd_backlight";
 	asc->backlight->cdev.max_brightness = rep->backlight_on_max;
 	asc->backlight->cdev.brightness_set_blocking = apple_backlight_led_set;
+	asc->backlight->cdev.flags = LED_CORE_SUSPENDRESUME;
 
 	ret = apple_backlight_set(hdev, 0, 0);
 	if (ret < 0) {
@@ -926,6 +927,7 @@ static int apple_magic_backlight_init(st
 	backlight->cdev.name = ":white:" LED_FUNCTION_KBD_BACKLIGHT;
 	backlight->cdev.max_brightness = backlight->brightness->field[0]->logical_maximum;
 	backlight->cdev.brightness_set_blocking = apple_magic_backlight_led_set;
+	backlight->cdev.flags = LED_CORE_SUSPENDRESUME;
 
 	apple_magic_backlight_set(backlight, 0, 0);
 



