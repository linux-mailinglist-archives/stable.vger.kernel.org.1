Return-Path: <stable+bounces-262322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nZebKAtGKGq2BQMAu9opvQ
	(envelope-from <stable+bounces-262322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:57:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F7662AEC
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:57:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=makarenk.ooo header.s=default header.b=iN3WSvHV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262322-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262322-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=makarenk.ooo;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 624A43097BDA
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A41371D17;
	Tue,  9 Jun 2026 16:10:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1636E493;
	Tue,  9 Jun 2026 16:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021448; cv=none; b=SUiKt4oyNsc+80qHn4vFjy8SEsXPlZwTL0Vh6l47kdbnTEE+WGSaHle1Krj9DnodfJ+95zFHwIyKYSRXx4NLQ+nD9gofpyp4j2pHpTnyuVSJBpT7jjgIp4lrLwaQWgkwVCd7vzXfEw9LPtkDlBBD6NUwQwn9bk1HsbjO3nZLbrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021448; c=relaxed/simple;
	bh=O+eLWs+OWcxYj/ZX81C3cSzRxN9E5RQJC632vb41yYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AC46y1SIchOQ0TS5z8+PlkorRAvbgK99I6qbIPBpamNOt4U4pCy3r/+zXamVxNJTVT1dE8KtbNGo+jc082MBwdqx8UBO1oOmn1sXI64y8r8r7SNuVgN9YwMAksz/amnrBLGCf8jnePdZnnPIGehBZW+NAY+j9LJ/OqAe8aVfCes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=makarenk.ooo; spf=pass smtp.mailfrom=makarenk.ooo; dkim=pass (1024-bit key) header.d=makarenk.ooo header.i=@makarenk.ooo header.b=iN3WSvHV; arc=none smtp.client-ip=35.82.102.206
Received: from home-pc (62-157-05.netrun.cytanet.com.cy [62.228.157.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: oleg@makarenk.ooo)
	by hognose1.porkbun.com (Postfix) with ESMTPSA id D2EFB485390;
	Tue,  9 Jun 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=makarenk.ooo;
	s=default; t=1781020865;
	bh=7dc5ymui68NYn6ueFqGVyMe26N+0nALw55iH7WG77r8=;
	h=From:To:Cc:Subject:Date;
	b=iN3WSvHVKesrHY4pGyQIxvHuxu/UGemqYEEyXP8ZHIYUTfwB51DRBk8cYcesMfQC3
	 ZpiUkGruCW+4IQZUccnTTnX9YR7C1ntPwiU28YYJVEBApR0E4iUaxn5z+NgumrpNjI
	 G1W9WbTUje65pmvCSzTj1u4ZSgLD8/AAt59/lhYc=
From: Oleg Makarenko <oleg@makarenk.ooo>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: Oleg Makarenko <oleg@makarenk.ooo>,
	stable@vger.kernel.org,
	Oliver Roundtree <oroundtree1@gmail.com>,
	=?UTF-8?q?Ryno=20Kotz=C3=A9?= <lemon.xah@gmail.com>,
	=?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Anssi Hannula <anssi.hannula@gmail.com>,
	Dmitry Torokhov <dtor@mail.ru>,
	linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: pidff: Use correct effect type in effect update
Date: Tue,  9 Jun 2026 19:00:27 +0300
Message-ID: <20260609160031.493353-1-oleg@makarenk.ooo>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[makarenk.ooo,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[makarenk.ooo:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262322-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jikos@kernel.org,m:bentiss@kernel.org,m:oleg@makarenk.ooo,m:stable@vger.kernel.org,m:oroundtree1@gmail.com,m:lemon.xah@gmail.com,m:tomasz.pakula.oficjalny@gmail.com,m:anssi.hannula@gmail.com,m:dtor@mail.ru,m:linux-input@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lemonxah@gmail.com,m:tomaszpakulaoficjalny@gmail.com,m:anssihannula@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[oleg@makarenk.ooo,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[makarenk.ooo:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oleg@makarenk.ooo,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[makarenk.ooo,vger.kernel.org,gmail.com,mail.ru];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,makarenk.ooo:dkim,makarenk.ooo:email,makarenk.ooo:mid,makarenk.ooo:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C92F7662AEC

When updating an existing effect, the effect type from the last created
effect was sent to the device instead of the updated one.
This caused incorrect reports when a game creates multiple different
effects and updates only one that is not the last created.

Fixes FFB in multiple games that create multiple simultaneous effects
(Forza Horizon 5/6).

Fixes: 224ee88fe395 ("Input: add force feedback driver for PID devices")
Cc: <stable@vger.kernel.org>
Tested-by: Oliver Roundtree <oroundtree1@gmail.com>
Co-developed-by: Ryno Kotzé <lemon.xah@gmail.com>
Signed-off-by: Ryno Kotzé <lemon.xah@gmail.com>
Signed-off-by: Oleg Makarenko <oleg@makarenk.ooo>
---
 drivers/hid/usbhid/hid-pidff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index c45f182d0448..5f4395f7c645 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -522,7 +522,7 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 	pidff->set_effect[PID_EFFECT_BLOCK_INDEX].value[0] =
 		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
 	pidff->set_effect_type->value[0] =
-		pidff->create_new_effect_type->value[0];
+		pidff_get_effect_type_id(pidff, effect);
 
 	pidff_set_duration(&pidff->set_effect[PID_DURATION],
 			   effect->replay.length);
-- 
2.54.0


