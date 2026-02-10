Return-Path: <stable+bounces-215650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GmRGFgei2n7QAAAu9opvQ
	(envelope-from <stable+bounces-215650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:02:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB43611A829
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 125273003BC2
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 12:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C572D322DB7;
	Tue, 10 Feb 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Pz/kwafX"
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159631B80B;
	Tue, 10 Feb 2026 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724942; cv=none; b=EgTqu02Z3VGOC28gsQXbEV4S1mQ0CdrPAaDpkG2nQCmzTl5h1EIvPbxdOHsyU7sntT1SbhEJrSqDiBZdjYmS13hESzIHQLMWAvzIU1m+qErjuMFYdN72prZgUYeTGQm0F5QJSNIUnIYhUqRCdXfKy/NK10hNG3OkIbpo7CbSTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724942; c=relaxed/simple;
	bh=e40v1gUy96BXqFR6hjWKMIDAHRVEqR0kayxwtpCeB5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6e/svsSsgSV/0JVcEXm7ZZFAfgQ+5676SlsJlvafVeDZcUcmuRYqf2Er4HV130a0YWo+JNF7Vaq30jCd82TYEvgBlPobQsYqKbCWuvWjnk46uDwMA+rRt+mmWPCr5jPh/cMbXZQumPfTfBduigbe/cz1QCWD8S/5nbEojqP6nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Pz/kwafX; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=MA8XtkyTeXl7r9NYADWLTbBNblgwxWj94nMGkruZhVo=; b=Pz/kwafXMpzn18HUjhM6RMkhj6
	L52/VJwnl7fwM/YF93KhyrTRBjSOkP5odXCCUy0ymCtlyynt+8hd5xGgByI9BJjWL2gd6/aLtZPVV
	N8APRQ1nVr0MYDw86JVuT3t1zK9cKE6/AHnlUNbF493OIkM2mefUYPiON/vMw34/mYVIPf8BTxwso
	BjhvlIMEIEU6RPlLJWQlAMrzZ36j3Wlaq5UKD0CMNB3LgEELABTxsAZrd6Edhyzwp5BsyNh/akF3c
	rSX8cn2kzH2eJyVPFFDd0eulKChVb8uL7qFw7WleQmFQNpwiRQftP+h1YkjKI5eexSTPM8QVx2DeP
	f9HdBcMA==;
Received: from i53875a81.versanet.de ([83.135.90.129] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vpmRY-007wxR-CX; Tue, 10 Feb 2026 13:02:12 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jan Palus <jpalus@fastmail.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "arm64: dts: rockchip: Further describe the WiFi for the Pinebook Pro"
Date: Tue, 10 Feb 2026 13:01:42 +0100
Message-ID: <20260210120142.698512-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,fastmail.com,gmail.com,leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215650-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[sntech.de:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	RSPAMD_EMAILBL_FAIL(0.00)[heiko.sntech.de:query timed out,pbrobinson.gmail.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sntech.de:mid,sntech.de:dkim,sntech.de:email]
X-Rspamd-Queue-Id: BB43611A829
X-Rspamd-Action: no action

This reverts commit 6d54d935062e2d4a7d3f779ceb9eeff108d0535d.

It seems there are different variants of the Wifi chipset in use on the
Pinebook Pro. And according to the reported regression - see Closes
below, the reverted change causes issues with one Wifi chipset.

The original commit message indicates a "further description" only and
does not indicate this would fix an actual problem, so a revert should
not cause further problems.

Fixes: 6d54d935062e ("arm64: dts: rockchip: Further describe the WiFi for the Pinebook Pro")
Cc: Jan Palus <jpalus@fastmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/aUKOlj-RvTYlrpiS@rock.grzadka/
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts  | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 810ab6ff4e67..7c23971920f0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -883,12 +883,6 @@ vcc5v0_host_en_pin: vcc5v0-host-en-pin {
 		};
 	};
 
-	wifi {
-		wifi_host_wake_l: wifi-host-wake-l {
-			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
-
 	wireless-bluetooth {
 		bt_wake_pin: bt-wake-pin {
 			rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -946,19 +940,7 @@ &sdio0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
 	sd-uhs-sdr104;
-	#address-cells = <1>;
-	#size-cells = <0>;
 	status = "okay";
-
-	brcmf: wifi@1 {
-		compatible = "brcm,bcm4329-fmac";
-		reg = <1>;
-		interrupt-parent = <&gpio0>;
-		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "host-wake";
-		pinctrl-names = "default";
-		pinctrl-0 = <&wifi_host_wake_l>;
-	};
 };
 
 &sdhci {
-- 
2.47.2


