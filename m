Return-Path: <stable+bounces-220470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFjTMOQ4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBDF1C64F0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 741E531282D5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B513BFD9F;
	Sat, 28 Feb 2026 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io5+URdy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272953BFD96;
	Sat, 28 Feb 2026 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300357; cv=none; b=FgHHaKnhpxUoeRZtYejE8u19Xu/vQ5gZMR5QmYiYycICTvgyHTfMMQTzNoosBpVl9IhA/0Ay9zdl8r0VGncnym7kaMn+IswFvHCZ3r3FPRR+qnOmQu10cHMc9cQvkNz3kdm+0jrSqBozGtXSQp2wIEnDqgwk0NxzeP5jTGpUQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300357; c=relaxed/simple;
	bh=VVnje+7+SfWBlrdLKBwQdRyCvKyAE8CdhiGHg4l/OXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHKgTh8qzIA7FmtAinikmwUeXcKbdU0QxzU4S9wSCLSgtIGpHJ9ryFhFkJTZEqIyltVvrKFpvr028sc3SyvGn0F7B2DrpJ9p/4A7pNhGHGn9F5LszLadeuv1jtSEHSHeYqNZO1f+dxG+YjUNVkPeKjncSm+p8XlRiSaAPgKLQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io5+URdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0DCC116D0;
	Sat, 28 Feb 2026 17:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300357;
	bh=VVnje+7+SfWBlrdLKBwQdRyCvKyAE8CdhiGHg4l/OXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=io5+URdyfmLVOXqIL8VcWX5gPPBQh3u6YDc3vGCwYytXUM4Jyew+yqJEY8EDOn7AX
	 hK3De0h8pyIEzqz9wWPyd9pt98aJ/1SVb4TT5HdU2+Nlf4VoxzCzb6QRXNGUsJSWKX
	 PjvG1abwNq0gz5t52kSDpLw9NRrAFME1jo1NYYYAs7z8COBCsdViGoz7FSahUdr4KA
	 9fpOEI2kMhkl4AsV/6PioEfBB2VxCSCBQzJxjQU2kni1QAL/YXSqTvSXJK/uqIMXVw
	 wgiTn755xrcLGc04yIpvZQB+UevZ3CJ248Nks4vqwHdobvyR6pUQYImGD+A/MdWPuK
	 WXekBqUBP0l2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 391/844] fix it87_wdt early reboot by reporting running timer
Date: Sat, 28 Feb 2026 12:25:04 -0500
Message-ID: <20260228173244.1509663-392-sashal@kernel.org>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220470-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 8CBDF1C64F0
X-Rspamd-Action: no action

From: René Rebe <rene@exactco.de>

[ Upstream commit 88b2ab346436f799b99894a3e9518a3ffa344524 ]

Some products, such as the Ugreen DXP4800 Plus NAS, ship with the it87
wdt enabled by the firmware and a broken BIOS option that does not
allow to change the time or turn it off. As this makes installing
Linux rather difficult, change the it87_wdt to report it running to
the watchdog core.

Signed-off-by: René Rebe <rene@exactco.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/it87_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 3b8488c86a2f3..1d9f8591f38d8 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -188,6 +188,12 @@ static void _wdt_update_timeout(unsigned int t)
 		superio_outb(t >> 8, WDTVALMSB);
 }
 
+/* Internal function, should be called after superio_select(GPIO) */
+static bool _wdt_running(void)
+{
+	return superio_inb(WDTVALLSB) || (max_units > 255 && superio_inb(WDTVALMSB));
+}
+
 static int wdt_update_timeout(unsigned int t)
 {
 	int ret;
@@ -374,6 +380,12 @@ static int __init it87_wdt_init(void)
 		}
 	}
 
+	/* wdt already left running by firmware? */
+	if (_wdt_running()) {
+		pr_info("Left running by firmware.\n");
+		set_bit(WDOG_HW_RUNNING, &wdt_dev.status);
+	}
+
 	superio_exit();
 
 	if (timeout < 1 || timeout > max_units * 60) {
-- 
2.51.0


