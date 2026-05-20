Return-Path: <stable+bounces-251764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIKHCv4ADmo95QUAu9opvQ
	(envelope-from <stable+bounces-251764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:44:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C327597203
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D6DC3090AD5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852F43E9C3D;
	Wed, 20 May 2026 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4rsXIhq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445AC36D9EA;
	Wed, 20 May 2026 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298831; cv=none; b=O16hKIFB7jdG7U7HkbCs+cAM73NNQWRBPHvqKROjq9ibq3QgGGUbBD7kfUjlkWwNqc7NwEm822DzpzQ3p9haHkOtpUDRJBMUTQ2FNagAOcQvAsZXMDMuKdqujMtVaR29mgfDOSmSjacK5CYfFndHwrbQKivIwqhjszVBe0bFN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298831; c=relaxed/simple;
	bh=01kQ6Aqsal/jZ8RqSaKIPgxi4cQZ9QVDNGfdQ2D+FrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBk1VIYy3LXHdTwR8RQAG8C5YRp7L/Nbs9bwHiA7Q+ggjd7SISvsev1Vi30+VQY8MBNv+FwtbnPwJ21KqdSvoCO74nYsER+EF5mkEX5YmrzqgwOhZXuOYASd7spwGaJT9TQ/i9PQ5kJvT17IgtgHravllA8jx18XKtrAve1F49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4rsXIhq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D247E1F00893;
	Wed, 20 May 2026 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298830;
	bh=g+4MxEWO8AzMUJBTzwWjktkqBr3B+A3aAGKTv2Z2WC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L4rsXIhqXng3sEirpxVSi6/6HyLkeJyr8hVZnAX4r+K/KFnJnqPYWzfS7KcP9BHZz
	 jHf3GZHFsmPFTcc2aSqEtwWRixt38To6QP937A8p2OIxLIzChwFx5jEAyIhAzjhGjg
	 MpG0Y2fErpAXlz1BTGoHqYY1pzEeT3TC6kRQ8UvY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 559/957] clk: renesas: r9a09g057: Add clock and reset entries for RTC
Date: Wed, 20 May 2026 18:17:22 +0200
Message-ID: <20260520162146.654966467@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251764-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,glider.be:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4C327597203
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

[ Upstream commit 7a03ef9f8223434f19e19a37acc32dcb581ab475 ]

Add module clock and reset entries for the RTC module on the Renesas RZ/V2H
(R9A09G057) SoC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251021080705.18116-2-ovidiu.panait.rb@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Stable-dep-of: 1b4f047dc401 ("clk: renesas: r9a09g057: Remove entries for WDT{0,2,3}")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a09g057-cpg.c
index 6389c4b6a5231..4e47fea3f8946 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -239,6 +239,8 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst = {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
 						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("rtc_0_clk_rtc",		CLK_PLLCM33_DIV16, 5, 3, 2, 19,
+						BUS_MSTOP(3, BIT(11) | BIT(12))),
 	DEF_MOD("rspi_0_pclk",			CLK_PLLCLN_DIV8, 5, 4, 2, 20,
 						BUS_MSTOP(11, BIT(0))),
 	DEF_MOD("rspi_0_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 5, 2, 21,
@@ -401,6 +403,8 @@ static const struct rzv2h_reset r9a09g057_resets[] __initconst = {
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
+	DEF_RST(7, 9, 3, 10),		/* RTC_0_RST_RTC */
+	DEF_RST(7, 10, 3, 11),		/* RTC_0_RST_RTC_V */
 	DEF_RST(7, 11, 3, 12),		/* RSPI_0_PRESETN */
 	DEF_RST(7, 12, 3, 13),		/* RSPI_0_TRESETN */
 	DEF_RST(7, 13, 3, 14),		/* RSPI_1_PRESETN */
-- 
2.53.0




