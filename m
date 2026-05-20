Return-Path: <stable+bounces-250734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDKrOsMTDmot6AUAu9opvQ
	(envelope-from <stable+bounces-250734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E69599142
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C6D38022DD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CA63D8138;
	Wed, 20 May 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XnYyJmqA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC353F23A1;
	Wed, 20 May 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296177; cv=none; b=EnMkzbm4ntjwQM/hFvXZhIHblFR3BnBVHMxMc4T1pU9THIlhlhKY/qMiUoq8h/03OyIrG1eNjAoKU4G7tSyQ8NkFcpttEItiNlgcO0H3411ZE20Hz/3rczjl2gf6trq0iOB4tAfZAtCVDajHvu8PqDcoj0wi7dZSUWqzXxB/Dqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296177; c=relaxed/simple;
	bh=4wXeA+rXQ8GsWv63iLcHnpGhE6sIG1dPFUVmPp5DJkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIG0Xgb7gt3FuxKhh0jYM6cZ+hachf6yLQz1qC89F4W9gGCdz1XqwIlCfoCg/02wnkhXeQxpgHDRhyGzIxZqESwbHiA/CSLqkt4+eb96cayJ/fFG2zqsN8xbwSMT+AThJ6dLzMn1PkwptGEiOVfbtknpauZcTo/N8ZjC/lWm73U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XnYyJmqA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD8A1F000E9;
	Wed, 20 May 2026 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296176;
	bh=MAMo+eaYSGF3j3q9jVP7esCUq9H1emaKqeAq0DheWzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XnYyJmqAFehN5pqnsaFZmuI2ZPMwcvnng4/84ewcY35ef8hRAdeFrv0t9MkRaX2UY
	 wnJI92uRTDI02l+P2vSqt/rcDELyfk542qhZCNxaIadrtP/5S8aVBPTpmLdckDgK/B
	 2S14BtTSB70tjuelk36mce5/FVI7J/1XdGYiFZ9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0701/1146] clk: sunxi-ng: sun55i-a523-r: Add missing r-spi module clock
Date: Wed, 20 May 2026 18:15:51 +0200
Message-ID: <20260520162204.056175778@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,arm.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250734-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,arm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 54E69599142
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wens@kernel.org>

[ Upstream commit fb20ccf70cf695f178d7c32e2d33b376560df0ff ]

When the PRCM clk driver was added, somehow the r-spi module clock
was skipped over.

Add it so that r-spi can actually work.

Fixes: 8cea339cfb81 ("clk: sunxi-ng: add support for the A523/T527 PRCM CCU")
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Link: https://patch.msgid.link/20260217093004.3239051-1-wens@kernel.org
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
index 0339c4af0fe5b..db0e36d8838e7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
@@ -83,9 +83,22 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(r_pwmctrl_clk, "r-pwmctrl",
 static SUNXI_CCU_GATE_HW(bus_r_pwmctrl_clk, "bus-r-pwmctrl",
 			 &r_apb0_clk.common.hw, 0x13c, BIT(0), 0);
 
-/* SPI clock is /M/N (same as new MMC?) */
+static const struct clk_parent_data r_spi_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "pll-periph" },
+	{ .name = "pll-periph0-300M" },
+	{ .name = "pll-periph1-300M" },
+	{ .name = "pll-audio" },
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(r_spi_clk, "r-spi", r_spi_parents, 0x150,
+				  0, 5,		/* M */
+				  8, 5,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
 static SUNXI_CCU_GATE_HW(bus_r_spi_clk, "bus-r-spi",
 			 &r_ahb_clk.common.hw, 0x15c, BIT(0), 0);
+
 static SUNXI_CCU_GATE_HW(bus_r_spinlock_clk, "bus-r-spinlock",
 			 &r_ahb_clk.common.hw, 0x16c, BIT(0), 0);
 static SUNXI_CCU_GATE_HW(bus_r_msgbox_clk, "bus-r-msgbox",
@@ -138,6 +151,7 @@ static struct ccu_common *sun55i_a523_r_ccu_clks[] = {
 	&bus_r_twd_clk.common,
 	&r_pwmctrl_clk.common,
 	&bus_r_pwmctrl_clk.common,
+	&r_spi_clk.common,
 	&bus_r_spi_clk.common,
 	&bus_r_spinlock_clk.common,
 	&bus_r_msgbox_clk.common,
@@ -169,6 +183,7 @@ static struct clk_hw_onecell_data sun55i_a523_r_hw_clks = {
 		[CLK_BUS_R_TWD]		= &bus_r_twd_clk.common.hw,
 		[CLK_R_PWMCTRL]		= &r_pwmctrl_clk.common.hw,
 		[CLK_BUS_R_PWMCTRL]	= &bus_r_pwmctrl_clk.common.hw,
+		[CLK_R_SPI]		= &r_spi_clk.common.hw,
 		[CLK_BUS_R_SPI]		= &bus_r_spi_clk.common.hw,
 		[CLK_BUS_R_SPINLOCK]	= &bus_r_spinlock_clk.common.hw,
 		[CLK_BUS_R_MSGBOX]	= &bus_r_msgbox_clk.common.hw,
-- 
2.53.0




