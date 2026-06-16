Return-Path: <stable+bounces-264680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xLO+LbB7MWoHkgUAu9opvQ
	(envelope-from <stable+bounces-264680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:37:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EE3692436
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:37:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="vl/7cl5t";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264680-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264680-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17143318EA59
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47546AF11;
	Tue, 16 Jun 2026 16:27:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7242146AF21;
	Tue, 16 Jun 2026 16:27:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627252; cv=none; b=hfhf0BGnQiSJmfSXb3LLBSX7GJahMjJexCFN/0j8znfSDZw1hoeO6iePez08RxtXYUzWcND4VoIAi4xIGukLcsLjtBPS3qsfUek1aTtf3N0/3skH8EhmwS5eMA1iYywJB2k1+MFbp+5Mhikrcj8FxNSzSfHZ5VTUfhrvXuCM0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627252; c=relaxed/simple;
	bh=afdMyJ2DnpReYAfMAekQBQ5ixNZ/UC78Hcm7vfd3PGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7wS2PjKDZIGlNkqZpFGedNh1YhxMndinA201HT9Q+6YBZxqNklR8d33waR0c4MsQDutMivb3yjtk7SVzVRtCjaOgYh0z9TnCMyXzjqw/s0rX8oucnwz5Owya7om+vL1kVvmpNbfHd70pL+U2+BNhdieL/pK2dlJBe7monlLg+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vl/7cl5t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B3B1F000E9;
	Tue, 16 Jun 2026 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781627251;
	bh=7KPEWd/AsL6yo8MX+ds3jkyPcIkyRjfz/j0awT5rbSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vl/7cl5tRkCR4SULGKCqSHNUjOkxhDKo8d47aIcfO9qmisj4mkjLpmgkGvkw9zI4Q
	 B2ZnFxeV6KLlH+VJV9f+SeIUMJFXXZgdnNyntvPqDinXYvUzW8237KBkIFUst3wlPh
	 Zl2nheRm2Zd/dXiAXer3Oya83q47TgqjEnIBdZoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Judith Mendez <jm@ti.com>,
	Linus Walleij <linusw@kernel.org>
Subject: [PATCH 6.12 136/261] pinctrl: mcp23s08: Initialize mcp->dev and mcp->addr before regmap init
Date: Tue, 16 Jun 2026 20:29:34 +0530
Message-ID: <20260616145051.386200958@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264680-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jm@ti.com,m:linusw@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ti.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07EE3692436

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Judith Mendez <jm@ti.com>

commit 8473c3a197b57ff01396f7a2ec6ddf65383820d4 upstream.

Regmap initialization triggers regcache_maple_populate() which attempts
SPI read to populate cache. SPI read requires mcp->dev and mcp->addr to
be set, without them, NULL pointer dereference occurs during probe.

Move initialization before mcp23s08_spi_regmap_init() call.

Cc: stable@vger.kernel.org
Fixes: f9f4fda15e72 ("pinctrl: mcp23s08: init reg_defaults from HW at probe and switch cache type")
Signed-off-by: Judith Mendez <jm@ti.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pinctrl/pinctrl-mcp23s08_spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08_spi.c b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
index 54f61c8cb1c0..5ed368772adb 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08_spi.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08_spi.c
@@ -10,6 +10,7 @@
 #include "pinctrl-mcp23s08.h"
 
 #define MCP_MAX_DEV_PER_CS	8
+#define MCP23S08_SPI_BASE	0x40
 
 /*
  * A given spi_device can represent up to eight mcp23sxx chips
@@ -173,6 +174,8 @@ static int mcp23s08_probe(struct spi_device *spi)
 	for_each_set_bit(addr, &spi_present_mask, MCP_MAX_DEV_PER_CS) {
 		data->mcp[addr] = &data->chip[--chips];
 		data->mcp[addr]->irq = spi->irq;
+		data->mcp[addr]->dev = dev;
+		data->mcp[addr]->addr = MCP23S08_SPI_BASE | (addr << 1);
 
 		ret = mcp23s08_spi_regmap_init(data->mcp[addr], dev, addr, info);
 		if (ret)
@@ -184,7 +187,7 @@ static int mcp23s08_probe(struct spi_device *spi)
 		if (!data->mcp[addr]->pinctrl_desc.name)
 			return -ENOMEM;
 
-		ret = mcp23s08_probe_one(data->mcp[addr], dev, 0x40 | (addr << 1),
+		ret = mcp23s08_probe_one(data->mcp[addr], dev, MCP23S08_SPI_BASE | (addr << 1),
 					 info->type, -1);
 		if (ret < 0)
 			return ret;
-- 
2.54.0




