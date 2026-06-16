Return-Path: <stable+bounces-264103-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n4mAAUhvMWoCjQUAu9opvQ
	(envelope-from <stable+bounces-264103-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6ED691589
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:44:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=JJgzkTEB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264103-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264103-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B05030A2226
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67B34418FF;
	Tue, 16 Jun 2026 15:35:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095D44BC94;
	Tue, 16 Jun 2026 15:35:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624137; cv=none; b=kWZxeOfhbZbvZhDSCpIh5RBkWfCgOPpvm4/lJzfs2cMAfgCBjnFRQGv0expwsY0uflbwANfZmx/JnP1Ao7K5U0nbhA92AOvhRMPIo3xcu3a3VHvJerZDBo0+n82lRikxbBw7WYq4Udj9iK90rRqBg74GBcV5I5JmKsVz/pIrNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624137; c=relaxed/simple;
	bh=rfwsQpjYVFX1KQacJTzVjWQWAEihAWci1JMlRo2Bfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIg/GcRsthFGdVB+nc+COgFJP5/y5yFhnj3kY84q5U90fCXHQQuRhcVpInu+/cqRmrWard3Uh01c7r9yXV8OOeZBXJyXoY1c5sTRUH6nbjotCYRk2IHh3356aDpLXxERQW6qUdzCTZ9l/X4ugo1gMaO84t8r10IDNR0tohWxwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JJgzkTEB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EF71F000E9;
	Tue, 16 Jun 2026 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624136;
	bh=v14IlF8yd/kxWzSGeplMgh5nH5lbHvJBLrYiIWVIpGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JJgzkTEBbtxnHCxSysR0MFU9ukvaVquQ9FStbts/Vg3vZAVpg3DTrI4xZT3DPebXs
	 dN/dOY3X45SntzihSyLMpWQziKfrSZRd1ipBeQnJFut6cDf4crGAW5szoRnFj9tMcf
	 ozj2xfJwYWDWMlYYMKkA8jaln/n0xUTgwDp/7IhM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Alexander Dahl <ada@thorsis.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 7.0 281/378] memory: atmel-ebi: Allow deferred probing
Date: Tue, 16 Jun 2026 20:28:32 +0530
Message-ID: <20260616145124.901118143@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264103-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:miquel.raynal@bootlin.com,m:ada@thorsis.com,m:krzk@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,bootlin.com:email,msgid.link:url,vger.kernel.org:from_smtp,thorsis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B6ED691589

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Dahl <ada@thorsis.com>

commit 754d60ad1c91895be0bc7d771fbf9fb3c9448640 upstream.

After removing of_platform_default_populate() calls the atmel-ebi driver
was affected by deferred probing.  platform_driver_probe() is
incompatible with deferred probing.  This led to atmel-ebi driver
eventually not being probed on at91 sam9x60-curiosity and other sam9x60
based boards.  Subsequently the nand-controller driver (nand-controller
being a child node of ebi) on that platform was not probed and thus raw
NAND flash was inaccessible, preventing devices to boot with rootfs on
raw NAND flash (e.g. with UBI/UBIFS).

Fixes: 0b0f7e6539a7 ("ARM: at91: remove unnecessary of_platform_default_populate calls")
Cc: stable@vger.kernel.org
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
Link: https://patch.msgid.link/20260429125930.844790-1-ada@thorsis.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/memory/atmel-ebi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 8db970da9af9..1e8e8aba2542 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -628,10 +628,11 @@ static __maybe_unused int atmel_ebi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(atmel_ebi_pm_ops, NULL, atmel_ebi_resume);
 
 static struct platform_driver atmel_ebi_driver = {
+	.probe = atmel_ebi_probe,
 	.driver = {
 		.name = "atmel-ebi",
 		.of_match_table	= atmel_ebi_id_table,
 		.pm = &atmel_ebi_pm_ops,
 	},
 };
-builtin_platform_driver_probe(atmel_ebi_driver, atmel_ebi_probe);
+builtin_platform_driver(atmel_ebi_driver);
-- 
2.54.0




