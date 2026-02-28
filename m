Return-Path: <stable+bounces-220244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOJ0G+c0o2kI+gQAu9opvQ
	(envelope-from <stable+bounces-220244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E41C5F20
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E42C3098E7C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA847D937;
	Sat, 28 Feb 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0ynF0Lk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A064371465;
	Sat, 28 Feb 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300148; cv=none; b=C8FHNUSzIDVyOpOjawalKVeg51W+rRKXtbqi6mUAX+qXdc3HSAu6i4fFpDHK+/MzqHnwmWMMMG7qD3cMRyUw4WuGeBBIClB/SnrGJSGTYtaUgQflIR3Oeb/0aCuJzs5++C8GgJQ3nXoFJZXUyC6yJUGWGfj9YBKMMoQXUAbBc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300148; c=relaxed/simple;
	bh=SV+RUt3egBAGzwVZAjSIayxnq11Eu6kohGuhg3MCPiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYgdRkoZdhpHI0OC12hesrs9JCbUnNTjpm3r0/l8QDuzEDiNiQehHpRO+GvLs596fHdqn0dad4xRl3GOis0WBkWk97tCleoRyPFnE4XxLD9fDvBRmg9eII/iaL5GTYigNfGWAtV1SUjlliK8V8qc7n2uwU9JzyIzciN2RlSoBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0ynF0Lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAC8C19425;
	Sat, 28 Feb 2026 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300148;
	bh=SV+RUt3egBAGzwVZAjSIayxnq11Eu6kohGuhg3MCPiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0ynF0LkUsuHE0uvnygIGJRrS/ujkQzTXpLMXpCQezMYL2827lIpdlgO/JILKQDYM
	 JHax5ZQRTnEQw2NrTtEo4Pv64pe2ykwzS+07rBuopMKu6nEMqmmFnSEqcdxz34TC/b
	 zQd7pWQlbcGflrgt21KeuAKj969iHbSqAWwhz7+x6oAo5dyfMn4o5NZURlnjm0rUCE
	 Kbmt6cNnFzyf3anTRespJCD/VGrCp6Fde/mebzXBDRxJReIDRgxzQyOXGQvtxavt4M
	 dRFIB1IU3Rsxmq4K9KQIGbPRb0n702iPguazTNY5T8cGljabbFF6GKL5UmAAAxvNve
	 zBafeF44WR5Jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 166/844] HID: pidff: Do not set out of range trigger button
Date: Sat, 28 Feb 2026 12:21:19 -0500
Message-ID: <20260228173244.1509663-167-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220244-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 928E41C5F20
X-Rspamd-Action: no action

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

[ Upstream commit e01a029654f7fb67d7151365410aa22be4e63dbe ]

Some games (mainly observed with Kylotonn's WRC Serises) set trigger
button to a random value, or always the same one, out of range.
I observed 307 and other values but, for example, my Moza R9 only
exposes 128 buttons AND it's trigger button field is 8-bit. This causes
errors to appear in dmesg.

Only set the trigger button and trigger interval in the trigger button
is in range of the field.

Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-pidff.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 95377c5f63356..a4e700b40ba9b 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -523,9 +523,19 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
 	pidff_set_duration(&pidff->set_effect[PID_DURATION],
 			   effect->replay.length);
 
-	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = effect->trigger.button;
-	pidff_set_time(&pidff->set_effect[PID_TRIGGER_REPEAT_INT],
-		       effect->trigger.interval);
+	/* Some games set this to random values that can be out of range */
+	s32 trigger_button_max =
+		pidff->set_effect[PID_TRIGGER_BUTTON].field->logical_maximum;
+	if (effect->trigger.button <= trigger_button_max) {
+		pidff->set_effect[PID_TRIGGER_BUTTON].value[0] =
+			effect->trigger.button;
+		pidff_set_time(&pidff->set_effect[PID_TRIGGER_REPEAT_INT],
+			       effect->trigger.interval);
+	} else {
+		pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = 0;
+		pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] = 0;
+	}
+
 	pidff->set_effect[PID_GAIN].value[0] =
 		pidff->set_effect[PID_GAIN].field->logical_maximum;
 
-- 
2.51.0


