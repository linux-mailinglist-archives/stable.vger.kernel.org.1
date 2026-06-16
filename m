Return-Path: <stable+bounces-263960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gIR1I25tMWpGjAUAu9opvQ
	(envelope-from <stable+bounces-263960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:36:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCA691324
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:36:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=15bVgA8P;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263960-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263960-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 752BF310F1CA
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5844A71C;
	Tue, 16 Jun 2026 15:23:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C544CF4E;
	Tue, 16 Jun 2026 15:23:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623403; cv=none; b=hh3dsYNt6HvRTsniu5fWnSe8d3zAfDUhm9H8FUyoulyx0HTFAA19/jrp+8nf7WYJaRp0zeBDT649aUBeLvIxfaF0GSPOi8hQc3lSpWzPm3L6GQeo8e/TgnsYExYUaXl08k9yhqe2xTeSq6Tqdt6r7x5yCg60ZGiZL+isizY6HNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623403; c=relaxed/simple;
	bh=Lh9A2WXB47La7tdLzXw7GaIT8CPFq3L+2LbbHHi6OC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sv1h0hoIa8iTWZnl8+wPKlF8iTC52pQofEIzgFoXxErwZBWiKXtyir8YI3NmjoGZ8JtvKlWktxAsc8jSGWb3ne09olwBxRMI4vwAAC99N5azg8N9PYzsxgEJ+yxNI14mWAQXV7qF4X6SP3fBYlxVdz4g7WuJjwwh3SgvD54lgs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=15bVgA8P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857B31F000E9;
	Tue, 16 Jun 2026 15:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623402;
	bh=MBV0it6997MHVUpHzMW2IXLAR8mgcLHwZuE6RzDwovE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=15bVgA8PZOWF8mP0zEooJFZPV0BRoyoccgI77kFwFSH4secv/TW1qSqobDOpzWLbt
	 MMbLU5MrNudfu4WELImfOxpW6QZ2or6U6294UBSC5JuT6UqmQj7BZ8zqs/TPag8Pjz
	 GsRiZToug9ztmoZ093t+4gMEkTlXxA53au3bfUao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Felix Gu <ustc.gu@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 140/378] spi: rzv2h-rspi: Fix SPDR read access width for 16-bit RX
Date: Tue, 16 Jun 2026 20:26:11 +0530
Message-ID: <20260616145117.644200505@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-m68k.org,gmail.com,glider.be,renesas.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-263960-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:geert@linux-m68k.org,m:ustc.gu@gmail.com,m:geert+renesas@glider.be,m:fabrizio.castro.jz@renesas.com,m:broonie@kernel.org,m:sashal@kernel.org,m:ustcgu@gmail.com,m:geert@glider.be,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,renesas.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linux-m68k.org:email,glider.be:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7DCA691324

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 310628484ef06f95c5589374fade917a5689787b ]

The RZ/V2H hardware manual (section 7.5.2.2.1) specifies that read access
size for the SPI Data Register (SPDR) are fixed at 32 bits. The
RZV2H_RSPI_RX macro for the 16-bit data path used readw(), violating
this requirement.

Switch to readl() for the 16-bit RX path to conform to the hardware
specification.

Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://patch.msgid.link/20260610-rzv2h-rspi-v2-1-40c80b4a2c90@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-rzv2h-rspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 53c44799fab71d..6fc81ccbcad5a2 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -133,8 +133,9 @@ static inline void rzv2h_rspi_rx_##type(struct rzv2h_rspi_priv *rspi,	\
 RZV2H_RSPI_TX(writel, u32)
 RZV2H_RSPI_TX(writew, u16)
 RZV2H_RSPI_TX(writeb, u8)
+/* The read access size for RSPI_SPDR is fixed at 32 bits */
 RZV2H_RSPI_RX(readl, u32)
-RZV2H_RSPI_RX(readw, u16)
+RZV2H_RSPI_RX(readl, u16)
 RZV2H_RSPI_RX(readl, u8)
 
 static void rzv2h_rspi_reg_rmw(const struct rzv2h_rspi_priv *rspi,
-- 
2.53.0




