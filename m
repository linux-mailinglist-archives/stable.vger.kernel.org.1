Return-Path: <stable+bounces-228324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDawCJNOwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 896D42F4A2F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E653314B0D0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816463B19D4;
	Mon, 23 Mar 2026 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LEYSyuKw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BB387563;
	Mon, 23 Mar 2026 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274811; cv=none; b=EUamaXcwEgOPPsA85rqR/EQVL0sNbeTu6pUhaj6mn7+3T55PF9fezFHNJAD+ViwfR0Ndg/LCf/NoOHU5F6zCZo5BvWdqS5azCqpR1f00TPB3o/c/DzbUWApRmdUCFORHxf6mJZByjnAP1qSwinTO30pHcC9viBCgHeIWrljlejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274811; c=relaxed/simple;
	bh=0ffgAKdcl4ddkhjCgpFYlqyEi/xpCq4aHZe2LgpNk6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRqKqJ1N2YBtwWDDYjZrsJwA6fzpM89VjG+2yH2SyNhMauCKFCbCak5hD9GIJI+V+AAJpCrvHwvoxaXDSdFnB6+F7ZRR3UexpR21D5ZjFkzwxDv+hAS05EWoHj7z2OIpzxoyNSXHUZKrsSA8z69n6iJXlunwv4xB91XbuX8T1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LEYSyuKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66837C2BC9E;
	Mon, 23 Mar 2026 14:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274810;
	bh=0ffgAKdcl4ddkhjCgpFYlqyEi/xpCq4aHZe2LgpNk6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LEYSyuKwtjH9TfnWXlA43+6hlTfknyrZxlMM+nmyRbJJJ9eI9F7bNYI5iivVOJwU7
	 B5NxiKOJIA8uy5G4xqYSk8moHrULgzIjfsP+Ml9wvIIiDXg/7e64I0KTaiR4y3pJI4
	 C5notF3Mcs1YbchmM/FXIo4nV/z/tA50Wj0smRJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 115/212] arm64: dts: renesas: r9a09g057: Remove wdt{0,2,3} nodes
Date: Mon, 23 Mar 2026 14:45:36 +0100
Message-ID: <20260323134507.413276335@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228324-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 896D42F4A2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

[ Upstream commit a3f34651de4287138c0da19ba321ad72622b4af3 ]

The HW user manual for the Renesas RZ/V2H(P) SoC (a.k.a r9a09g057)
states that only WDT1 is supposed to be accessed by the CA55 cores.
WDT0 is supposed to be used by the CM33 core, WDT2 is supposed
to be used by the CR8 core 0, and WDT3 is supposed to be used
by the CR8 core 1.

Remove wdt{0,2,3} from the SoC specific device tree to make it
compliant with the specification from the HW manual.

This change is harmless as there are currently no users of the
wdt{0,2,3} device tree nodes, only the wdt1 node is actually used.

Fixes: 095105496e7d ("arm64: dts: renesas: r9a09g057: Add WDT0-WDT3 nodes")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260203124247.7320-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 30 ----------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index f59c3040f536a..100d5cab9b12f 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -546,16 +546,6 @@ ostm7: timer@12c03000 {
 			status = "disabled";
 		};
 
-		wdt0: watchdog@11c00400 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x11c00400 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x4b>, <&cpg CPG_MOD 0x4c>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x75>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		wdt1: watchdog@14400000 {
 			compatible = "renesas,r9a09g057-wdt";
 			reg = <0 0x14400000 0 0x400>;
@@ -566,26 +556,6 @@ wdt1: watchdog@14400000 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@13000000 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x13000000 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x4f>, <&cpg CPG_MOD 0x50>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x77>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
-		wdt3: watchdog@13000400 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x13000400 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x51>, <&cpg CPG_MOD 0x52>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x78>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		rtc: rtc@11c00800 {
 			compatible = "renesas,r9a09g057-rtca3", "renesas,rz-rtca3";
 			reg = <0 0x11c00800 0 0x400>;
-- 
2.51.0




