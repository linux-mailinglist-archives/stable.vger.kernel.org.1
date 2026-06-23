Return-Path: <stable+bounces-267857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6sgnAMYLOmoX0gcAu9opvQ
	(envelope-from <stable+bounces-267857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 06:29:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0596B3FFD
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 06:29:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=cgOIxT+S;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267857-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267857-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EBDB3035EB3
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 04:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B19A3A7F69;
	Tue, 23 Jun 2026 04:29:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCB3A7F45;
	Tue, 23 Jun 2026 04:29:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782188987; cv=none; b=S+YMbx2233Gqa6JahqeYDgpvY03EHn8uj4/uOl7Chq3Km6vRdTn5EPhXSeAk39dCP3jXyl5xfHWWnJlMP2OVX3nOZA/voGS4BozLRJLUep6wq0gRz9+P6OY1sO6prs1n3slccvcoqBKuvonalbgrmhVgRnPh1J0GfYCUDq1rIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782188987; c=relaxed/simple;
	bh=bmpLJSgX+RIY1ri9NWuJ6HCMJlhYQM2bPINuA4Vurow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gtn1ww8um9gSjGFyMF24bArA2fOr6nQJJNL6DUDjWybJr363+20hgB3eRbXZKIkZl80UkSrKlb4C7AtwQ1/j8WGr9L7F+bCBdLhLv+rEYABpPhdZxmHD+QxY+2eLvLeggGePzNE1AMzWzRHonpx/tpMhzQy38dtfus3u1vKcJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cgOIxT+S; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cz
	DA/l/r6tobiENhQQytmV9iR2dM6o13JMKGj1WvYFs=; b=cgOIxT+SnF//zAk16C
	EeTxkkW3K5IvEI9UIdWV9NXDbcdD8VFoUM+sl1icGZGVl08kshfg8qmatNMcr2Xc
	DEtGzFCAk6dgmpSuwwrmnM+XP/cKlYWjQ1KejfSNLrRI+hDXrSR1JIxwxTZFFkAy
	aSeNjJT2jt1rOd5wT8me11AtQ=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAH7ElRCzpqavWXDA--.46123S2;
	Tue, 23 Jun 2026 12:28:03 +0800 (CST)
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
Subject: [PATCH] sh: kfr2r09: Fix USB gadget I2C adapter reference leak
Date: Tue, 23 Jun 2026 12:28:00 +0800
Message-Id: <20260623042800.1848398-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAH7ElRCzpqavWXDA--.46123S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try3Gr45tw4kKr13JFWrZrb_yoW8Xr45pa
	yDuFs5CFyjvr9Yyr48Zrs2vw45urs7trW3CFsrKasrC3ZYq34UXw1rXr9avF15JryIva48
	Gw4DKr1rXa1jkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRBnm_UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7RMAbmo6C1MLPgAA3t
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267857-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D0596B3FFD

kfr2r09_usb0_gadget_i2c_setup() gets I2C adapter 0 with
i2c_get_adapter(), but returns without dropping the reference.
Release the adapter with i2c_put_adapter() before returning
from all paths after i2c_get_adapter() succeeds.

Fixes: 5a1c4cb5bc22 ("sh: add r8a66597 usb0 gadget to the kfr2r09 board")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 arch/sh/boards/mach-kfr2r09/setup.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index 70236859919d..66c0015ec726 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -368,7 +368,7 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
 	msg.flags = 0;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err;
 
 	buf[0] = 0;
 	msg.addr = 0x09;
@@ -377,7 +377,7 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
 	msg.flags = I2C_M_RD;
 	ret = i2c_transfer(a, &msg, 1);
 	if (ret != 1)
-		return -ENODEV;
+		goto err;
 
 	buf[1] = buf[0] | (1 << 1);
 	buf[0] = 0x13;
@@ -387,9 +387,14 @@ static int kfr2r09_usb0_gadget_i2c_setup(void)
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
 
 static int kfr2r09_serial_i2c_setup(void)
-- 
2.25.1


