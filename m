Return-Path: <stable+bounces-248707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLLVAX1TB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:10:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B55548AF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7373A31EDAA4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6B34DBD7F;
	Fri, 15 May 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tiuk4Edl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409893E0082;
	Fri, 15 May 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862422; cv=none; b=jsasE1CxdMmfOMb15T58Kzulw1sIUeOhYtSiXCOcJkeUm8HQ4SdjaWKUfwagYSXVfcH5QcpSGwKCQsyFYRy8W7APr70pFT9a6n7c4P0kiE4HxlP1Kz6MtZuHGgqrDNDBqP2MUSxZwSecFPa94QEj6+Du+SR1+ILG7rR4mWjUdjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862422; c=relaxed/simple;
	bh=zFgTT1PG3/bq1IP5EbsaIvfaj1b3/NsJmsvLDOxHsCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rV5U67vnmnouV0nAf0qwIv70kfImq9PVebTtBQKV9yJROss/cJx+maCexcjwek9XX0KCoJ1v0jkP3M1rYTY1mSCxYO9sj3MCv7d+y4yg/eLiEuL5DQo3PahqmC5cVecA6WTORmY7LvkgWnr68hsT8zZpbAUozlm26kAmuOdxc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tiuk4Edl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B51C2BCB0;
	Fri, 15 May 2026 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862422;
	bh=zFgTT1PG3/bq1IP5EbsaIvfaj1b3/NsJmsvLDOxHsCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tiuk4EdlCI710v6o0R7/ut1UCEcUPd5qbJfYs/rTtHdEYCiZWbBR1RHgeXjIP1OGa
	 6lfkcpZVTc8LKPBuoyz4H6XB/jNsKzvyro8lJ0qXjtBYNjiqqsdV52zhTpTmMlvxaM
	 4aO0UkSQv1ifOuF+ZbwFUtsuF6GYgDXpdJmszJQQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 7.0 006/201] HID: pidff: Fix integer overflow in pidff_rescale
Date: Fri, 15 May 2026 17:47:04 +0200
Message-ID: <20260515154658.677564914@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5F8B55548AF
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
	TAGGED_FROM(0.00)[bounces-248707-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

commit 48d1677779ad6816978ad4a4f7588aec5ec960fe upstream.

Rescaling values close to the max (U16_MAX) temporarily creates values
that exceed the s32 range. This caused value overflow in case when, for
example, a periodic effect phase was higer than 180 degrees. In turn,
rescale function could return values outised of the logical range of the
HID field.

Fix by using 64 bit signed integer to store the value during calculation
but still return only 32 bit integer.

Closes: https://github.com/JacKeTUs/universal-pidff/issues/116
Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
Cc: stable@vger.kernel.org
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/usbhid/hid-pidff.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -11,6 +11,7 @@
 #include "hid-pidff.h"
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -325,8 +326,10 @@ static s32 pidff_clamp(s32 i, struct hid
  */
 static int pidff_rescale(int i, int max, struct hid_field *field)
 {
-	return i * (field->logical_maximum - field->logical_minimum) / max +
-	       field->logical_minimum;
+	/* 64 bits needed for big values during rescale */
+	s64 result = field->logical_maximum - field->logical_minimum;
+
+	return div_s64(result * i, max) + field->logical_minimum;
 }
 
 /*



