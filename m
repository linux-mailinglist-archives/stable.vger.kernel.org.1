Return-Path: <stable+bounces-261482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8p4WDd9KJWodGQIAu9opvQ
	(envelope-from <stable+bounces-261482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:41:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9F164FE99
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:41:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=TaMfT4E9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261482-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261482-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD933048DDC
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD0A31E849;
	Sun,  7 Jun 2026 10:38:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7C212564;
	Sun,  7 Jun 2026 10:38:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828724; cv=none; b=R9yQrJxmV1wiRg8/WCNDX/jm7yL4kRILYD9hhNdUkWjVlzzmTWTAGidfpGW/n3kd5M+4rGGQS3Mx1MCqtUGUHstzjUq0CKzwKPb6zY0UHetdimV2n96tsRD1ME0Ir4CftJdm46lfz9tAhTfFdKOaAPk5m2cQoHSdz4gaHNA78dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828724; c=relaxed/simple;
	bh=k4UYJ5av6Wv/UL4n87mUzI+mMxakghItkM9HXbXJoOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0mvc7Emx7pii2jigGYUF1Bhw3JRFqMW+sikAlVF37cWYxrrrXH+MRN6vgtV0vmPhjGP+tiBdGtW2UL3lhgNMSVIOW9jYKDw7u+nJmkX43TQNFupCchsNN0rwKxsDP9PsYAOn/ANSQTZiwTel9LvYrAJndNIWVvgQ0x6Ng6uJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TaMfT4E9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB01F00893;
	Sun,  7 Jun 2026 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828723;
	bh=TeU/7MDoEbqbTYeCUXX0aAX8joheBvwyWwwX8vrNCEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TaMfT4E9obQZa/VbjEF4bP7MZDkLKho+Asn0xFdh6BSSQSCvZV66Jx85pQ3amuVtW
	 Q7udFw587Ekk1CLf1lPgdgbXhz5KwlXTBY0llvFGTut5/gKZuUW0QrYTBerlX3bivf
	 y6MhfgVqtjX+V6iIREtnhZqtoRE3lRuulg/BLTrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Chaitanya Sabnis <chaitanya.msabnis@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 7.0 206/332] i2c: davinci: fix division by zero on missing clock-frequency
Date: Sun,  7 Jun 2026 11:59:35 +0200
Message-ID: <20260607095735.634458328@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-261482-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sashiko-bot@kernel.org,m:chaitanya.msabnis@gmail.com,m:bartosz.golaszewski@oss.qualcomm.com,m:andi.shyti@kernel.org,m:chaitanyamsabnis@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,qualcomm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A9F164FE99

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>

commit 030675aa54cf757769b3db65642433d626b3ed7c upstream.

When the 'clock-frequency' property is missing from the device tree,
the driver falls back to DAVINCI_I2C_DEFAULT_BUS_FREQ. However, this
macro was defined in kHz (100), whereas the device tree property is
expected in Hz.

The probe function divided the fallback value by 1000, causing
integer truncation that resulted in dev->bus_freq = 0. This triggered
a deterministic division-by-zero kernel panic when calculating clock
dividers later in the probe sequence.

Fix this by redefining DAVINCI_I2C_DEFAULT_BUS_FREQ in Hz (100000)
to match the expected device tree property unit, allowing the existing
division logic to work correctly for both cases.

Fixes: b04ce6385979 ("i2c: davinci: kill platform data")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260514044726.57297C2BCB7@smtp.kernel.org/
Signed-off-by: Chaitanya Sabnis <chaitanya.msabnis@gmail.com>
Cc: <stable@vger.kernel.org> # v6.14+
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260526102240.4949-1-chaitanya.msabnis@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-davinci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,7 +117,7 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
+#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
 
 struct davinci_i2c_dev {
 	struct device           *dev;



