Return-Path: <stable+bounces-227016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILyGM7qDumnrXQIAu9opvQ
	(envelope-from <stable+bounces-227016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:51:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA882BA378
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7126301F318
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB03932EB;
	Wed, 18 Mar 2026 10:51:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F44213AD26
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831095; cv=none; b=YiQWovL0cJx+XL9EYxL5sct+NSQdIlWdspDOulFjuIn/MNv3JQQRtPl14kpqnc9jl3ASGPyuqKGd10pgnv7oPRpDh97Usf19Qx/csKqXSkyXzOk86Eejyhsaz/jpf/r5LmF/z7JrPufazLLSSpTUr0MaGBuyH4Gq9lfuAzD8tZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831095; c=relaxed/simple;
	bh=UE8DLg0OmVNUS8QhDZnhmGITW1Sio+cYfmRHHPQL4sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aff0CPL0EoBGUUnx1uRFmg92is0O/2su7EfOQPkArY37sQ/R5dggwbqp1NGhxt38al5ixDm+7klZme7UFdpBO+hKXvIrt5PnoEVhudVaak1uMxrQan3oPXYvfFIHG427d4MGATGhA7ZRkHOsNj8OCfH/8ZzAreSe8ucnoNXpdTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-0001WP-Ey; Wed, 18 Mar 2026 11:51:25 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-000tSY-0X;
	Wed, 18 Mar 2026 11:51:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-00000003RJI-0IbV;
	Wed, 18 Mar 2026 11:51:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: David Jander <david@protonic.nl>,
	stable@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 7/7] ARM: dts: stm32: stm32mp15x-mecio1-io: Move expander gpio-line-names to board files
Date: Wed, 18 Mar 2026 11:51:23 +0100
Message-ID: <20260318105123.819807-8-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318105123.819807-1-o.rempel@pengutronix.de>
References: <20260318105123.819807-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227016-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	DBL_PROHIBIT(0.00)[0.0.0.20:email,0.0.0.21:email];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,protonic.nl:email]
X-Rspamd-Queue-Id: 1AA882BA378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Jander <david@protonic.nl>

Move the gpio-line-names properties for the I2C GPIO expanders (gpio0
and gpio1) out of the common mecio1-io.dtsi file and into the specific
board dts files.

The layout originally defined in the common include file belonged to the
mecio1r1 (Revision 1) hardware. This layout is moved 1:1 into the
stm32mp153c-mecio1r1.dts file.

The mecio1r0 (Revision 0) hardware utilizes a completely different
pinout for these expanders. A new, accurate mapping reflecting the
Revision 0 schematics is added to stm32mp151c-mecio1r0.dts.

Fixes: 8267753c891c ("ARM: dts: stm32: Add MECIO1 and MECT1S board variants")
Cc: stable@vger.kernel.org
Signed-off-by: David Jander <david@protonic.nl>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts  | 14 ++++++++++++++
 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts  | 14 ++++++++++++++
 arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi |  8 --------
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts b/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
index 06ab77465816..862782d20d10 100644
--- a/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
+++ b/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
@@ -97,6 +97,20 @@ &ethernet0 {
 	st,eth-clk-sel;
 };
 
+&gpio0 {
+	gpio-line-names = "HSIN0_BIAS", "HSIN1_BIAS", "HSIN2_BIAS", "HSIN3_BIAS",
+			  "HSIN4_BIAS", "", "STP_VREF0_LVL", "HSIN_VREF0_LVL",
+			  "STP0_FB_BIAS", "STP1_FB_BIAS", "STP2_FB_BIAS", "STP3_FB_BIAS",
+			  "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names = "HSIN5_BIAS", "HSIN6_BIAS", "HSIN7_BIAS", "HSIN8_BIAS",
+			  "HSIN9_BIAS", "", "STP_VREF1_LVL", "HSIN_VREF1_LVL",
+			  "STP4_FB_BIAS", "STP5_FB_BIAS", "STP6_FB_BIAS", "",
+			  "", "", "LSIN8_BIAS", "LSIN9_BIAS";
+};
+
 &gpiod {
 	gpio-line-names = "", "", "", "",
 			  "", "", "", "",
diff --git a/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts b/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
index 2b3989303cd1..739cc18c3d3a 100644
--- a/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
+++ b/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
@@ -90,6 +90,20 @@ &clk_hse {
 	clock-frequency = <24000000>;
 };
 
+&gpio0 {
+	gpio-line-names = "HSIN0_BIAS", "HSIN1_BIAS", "HSIN2_BIAS", "HSIN3_BIAS",
+			  "", "", "HSIN_VREF0_LVL", "HSIN_VREF1_LVL",
+			  "HSIN4_BIAS", "HSIN5_BIAS", "HSIN6_BIAS", "HSIN7_BIAS",
+			  "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names = "HSIN8_BIAS", "HSIN9_BIAS", "HSIN10_BIAS", "HSIN11_BIAS",
+			  "", "", "HSIN_VREF2_LVL", "HSIN_VREF3_LVL",
+			  "HSIN12_BIAS", "HSIN13_BIAS", "HSIN14_BIAS", "HSIN15_BIAS",
+			  "", "", "LSIN8_BIAS", "LSIN9_BIAS";
+};
+
 &gpioa {
 	gpio-line-names = "", "", "", "",
 			  "", "", "", "",
diff --git a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
index 1808289f8193..1a4f5a523eb3 100644
--- a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
@@ -184,10 +184,6 @@ gpio0: gpio@20 {
 		reg = <0x20>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		gpio-line-names = "HSIN0_BIAS", "HSIN1_BIAS", "HSIN2_BIAS", "HSIN3_BIAS",
-				  "", "", "HSIN_VREF0_LVL", "HSIN_VREF1_LVL",
-				  "HSIN4_BIAS", "HSIN5_BIAS", "HSIN6_BIAS", "HSIN7_BIAS",
-				  "", "", "", "";
 	};
 
 	gpio1: gpio@21 {
@@ -195,10 +191,6 @@ gpio1: gpio@21 {
 		reg = <0x21>;
 		gpio-controller;
 		#gpio-cells = <2>;
-		gpio-line-names = "HSIN8_BIAS", "HSIN9_BIAS", "HSIN10_BIAS", "HSIN11_BIAS",
-				  "", "", "HSIN_VREF2_LVL", "HSIN_VREF3_LVL",
-				  "HSIN12_BIAS", "HSIN13_BIAS", "HSIN14_BIAS", "HSIN15_BIAS",
-				  "", "", "LSIN8_BIAS", "LSIN9_BIAS";
 	};
 };
 
-- 
2.47.3


