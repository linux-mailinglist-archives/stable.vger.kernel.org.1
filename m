Return-Path: <stable+bounces-228099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHyiOYxGwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-228099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:56:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8F22F3742
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7087301A79A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA63AE1AD;
	Mon, 23 Mar 2026 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T7JUcU29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61543AE70F;
	Mon, 23 Mar 2026 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274121; cv=none; b=aMc0/43OKqUprpQ7txH06mr6Ar0ht+SqrADXLlLJX30xA4Sm78DdFRMehsHmz47a8GGsrv5VxQeIJqUE+LFrhvJvmX1KmcdtY9RLhfVYxINYPOuQ3pq78x9CLs6EvjIxdc2QIB4A0/W8ktE4+ggDrgGDzJZkcnMtSs33ABOM77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274121; c=relaxed/simple;
	bh=GyibNyFa/r9RKCbkH/h70eU81vvBxCwLSbBgmZPE510=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oULOn8iH53sdQyQtHYTzEH2odSh/I2r2fC4bOsSbXTlKQdcMttVfuduU1NZg/xDqkFn8QgSigtGU5xiDbuzPYM6ERIZvcNVN3SZHM1mukz3/HtrQOJAZrc9ic/Gy22QTLYKY09Ow3nUZGx4box293k9bvDQkeIz2EnCs5sUlZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T7JUcU29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E616C2BCB1;
	Mon, 23 Mar 2026 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274121;
	bh=GyibNyFa/r9RKCbkH/h70eU81vvBxCwLSbBgmZPE510=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7JUcU29JrO366Mw8Spq0L/NbyG4sCin3310xmwvh/1YJepJW+7pxExu7OwWiPTIr
	 xvMdzvsHksIbtFHGjCGbkFt7uAhxrtlDsCk9xE8adSFT4ULN7MOPH0HQg1wcX1qJe1
	 yw32yYeJqOIhg3orHs/G7sBGqvzS24Y4e1Bj8oSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 114/220] arm64: dts: renesas: r8a78000: Fix out-of-range SPI interrupt numbers
Date: Mon, 23 Mar 2026 14:44:51 +0100
Message-ID: <20260323134508.204292451@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228099-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C8F22F3742
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 85c2601e2c2feb60980c7ca23de28c49472f61f1 ]

SPI interrupts are in the range 0-987.  Extended SPI interrupts should
use GIC_ESPI, instead of abusing GIC_SPI with a manual offset of 4064.

Fixes: 63500d12cf76d003 ("arm64: dts: renesas: Add R8A78000 SoC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/1f9dd274720ea1b66617a5dd84f76c3efc829dc8.1772641415.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a78000.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a78000.dtsi b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
index 4c97298fa7634..3e1c98903cea0 100644
--- a/arch/arm64/boot/dts/renesas/r8a78000.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a78000.dtsi
@@ -698,7 +698,7 @@ scif0: serial@c0700000 {
 			compatible = "renesas,scif-r8a78000",
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0700000 0 0x40>;
-			interrupts = <GIC_SPI 4074 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -708,7 +708,7 @@ scif1: serial@c0704000 {
 			compatible = "renesas,scif-r8a78000",
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0704000 0 0x40>;
-			interrupts = <GIC_SPI 4075 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -718,7 +718,7 @@ scif3: serial@c0708000 {
 			compatible = "renesas,scif-r8a78000",
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc0708000 0 0x40>;
-			interrupts = <GIC_SPI 4076 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 12 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -728,7 +728,7 @@ scif4: serial@c070c000 {
 			compatible = "renesas,scif-r8a78000",
 				     "renesas,rcar-gen5-scif", "renesas,scif";
 			reg = <0 0xc070c000 0 0x40>;
-			interrupts = <GIC_SPI 4077 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 13 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd16>, <&dummy_clk_sgasyncd16>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -738,7 +738,7 @@ hscif0: serial@c0710000 {
 			compatible = "renesas,hscif-r8a78000",
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0710000 0 0x60>;
-			interrupts = <GIC_SPI 4078 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 14 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -748,7 +748,7 @@ hscif1: serial@c0714000 {
 			compatible = "renesas,hscif-r8a78000",
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0714000 0 0x60>;
-			interrupts = <GIC_SPI 4079 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 15 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -758,7 +758,7 @@ hscif2: serial@c0718000 {
 			compatible = "renesas,hscif-r8a78000",
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc0718000 0 0x60>;
-			interrupts = <GIC_SPI 4080 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
@@ -768,7 +768,7 @@ hscif3: serial@c071c000 {
 			compatible = "renesas,hscif-r8a78000",
 				     "renesas,rcar-gen5-hscif", "renesas,hscif";
 			reg = <0 0xc071c000 0 0x60>;
-			interrupts = <GIC_SPI 4081 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_ESPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dummy_clk_sgasyncd4>, <&dummy_clk_sgasyncd4>, <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
 			status = "disabled";
-- 
2.51.0




