Return-Path: <stable+bounces-267858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t8bPLIcMOmpI0gcAu9opvQ
	(envelope-from <stable+bounces-267858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 06:33:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9126B4030
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 06:33:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=GY4tF9+S;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267858-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267858-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93426302DF75
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 04:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150653A7F40;
	Tue, 23 Jun 2026 04:33:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E21552FD;
	Tue, 23 Jun 2026 04:33:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782189184; cv=none; b=nDr6K8lyjgo3wO0+vWpdMPehedx/LibUWtrRvF1vZr+lxQ/RFaOgPL5x7Fuk8XD5SEvKeIeY30RISvF38cSrLxwQeC89/niM+SucUyceO7I96ZuyAirGBOoF4+dNMc9nBhYO1sIxzl5ckW8aW+aEoTXRcvNA1Y1Cc/Rig9qMLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782189184; c=relaxed/simple;
	bh=A8M7nOSCCQRmG8upAxUFTY3lF3L2rgjh45cJOXF/dP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xx/BtcSMKhsuNoYQWgYy1TqLYCWe1lR55Cw3DpVkyu7gLY6MfbY7pbldKJSPGiHJDJ+pRVrWjgpKicQkjsZ8krc64HIQQaa85E+TieEl4eyepb1ceo6uBAnKDRdthMLRjwh9M2roKaTrFsM9NqnfdWetJQnAhhoozrw0UcjuYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GY4tF9+S; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uP
	5C+NyxTCm2+UmKRyDigIVJEcr8tQGz/pYZH5tc5XA=; b=GY4tF9+Sp2tZa0d/bY
	Zlp3ZguoNIVsuyGEV8qgwm2cLJLtX73tLJnD0f57K2k323N8b+E33clwus3mQBCW
	0sJVj9pA57V7N5Fg4IDkJwNeTqqZhWtNbpCjx5B3SSx664ZW8NwXXHQ469cYDq67
	GGq1aGdhRFa0Nesfss7SyWCTg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDXqCQ3DDpqyv2iDg--.12313S2;
	Tue, 23 Jun 2026 12:31:51 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	lethal@linux-sh.org,
	damm@igel.co.jp
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] sh: kfr2r09: Fix serial I2C adapter reference leak
Date: Tue, 23 Jun 2026 12:31:50 +0800
Message-Id: <20260623043150.1852957-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDXqCQ3DDpqyv2iDg--.12313S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18Gw43CF15Kw1rWrW3KFg_yoW8Gw4fpa
	1q9Fs8WFyjv3sYv3s7Zrs2vw15Crs2qrW3GFsrK3ZrCa9YqryUXryfXr9avF15JryI9a4x
	Cw4ktF15Za1UKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRv_MxUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7hc5p2o6DDckkgAA36
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267858-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ysato@users.sourceforge.jp,m:dalias@libc.org,m:glaubitz@physik.fu-berlin.de,m:lethal@linux-sh.org,m:damm@igel.co.jp,m:linux-sh@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:haoxiang_li2024@163.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haoxiang_li2024@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B9126B4030

kfr2r09_serial_i2c_setup() gets I2C adapter 0 with i2c_get_adapter(),
but returns without dropping the reference. Release the adapter with
i2c_put_adapter() before returning from all paths after i2c_get_adapter()
succeeds.

Fixes: e6d8460aca63 ("sh: Improve kfr2r09 serial port setup code")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/sh/boards/mach-kfr2r09/setup.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 70236859919d..56381fddbbe7 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -411,7 +411,7 @@ static int kfr2r09_serial_i2c_setup(void)
 	msg.flags = 0;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err;
 
 	buf[0] = 0;
 	msg.addr = 0x09;
@@ -420,7 +420,7 @@ static int kfr2r09_serial_i2c_setup(void)
 	msg.flags = I2C_M_RD;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err;
 
 	buf[1] = buf[0] | (1 << 6);
 	buf[0] = 0x13;
@@ -430,9 +430,14 @@ static int kfr2r09_serial_i2c_setup(void)
 	msg.flags = 0;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err;
 
+	i2c_put_adapter(a);
 	return 0;
+
+err:
+	i2c_put_adapter(a);
+	return -ENODEV;
 }
 #else
 static int kfr2r09_usb0_gadget_i2c_setup(void)
-- 
2.25.1


