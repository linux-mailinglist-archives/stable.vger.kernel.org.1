Return-Path: <stable+bounces-227022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDf+FkGEumnrXQIAu9opvQ
	(envelope-from <stable+bounces-227022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:53:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8C2BA463
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 11:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D76312B4EE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1EC395244;
	Wed, 18 Mar 2026 10:51:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2D396589
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831098; cv=none; b=fd1s/qQ3px7pK+nJQQV0P+go2DX/Kgraf0fLUkLPnn3uUQbdUyKaMjfP+RqcxhP8dmSmeIZoV+J/4tGcJeR/1bS/OjL6m3PJ72tbLFhR8uYBkCyt4ne3pLYC4LTTOnPjwkuqQ07DLdz/hS789+Wn4P4ihoc1tE87gHsbBOhYCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831098; c=relaxed/simple;
	bh=sXHeTCFrpD90P88yW7lbek8HGJ62ZnhzE1iwIXxHDi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oo9o97c0ER3x2PaNzljKPATiT2QgYpve5bkTMiJOwJx8G/Ia4s0vi8OfMWJGk/WYNmfVLhoxtGoPIpXRbVO9KQpcu01bATDe5BLhU70sgW4Y2fuho/3ujkqwfQvnYv5GmnVf1i2gDXimDau0EHrreF28wfzB3CSZJOKEH/28soY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-0001WN-F1; Wed, 18 Mar 2026 11:51:25 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-000tSU-0P;
	Wed, 18 Mar 2026 11:51:25 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-00000003RIw-07Gb;
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
Subject: [PATCH v1 5/7] ARM: dts: stm32: stm32mp15x-mecio1-io: Move gpio-line-names to board files
Date: Wed, 18 Mar 2026 11:51:21 +0100
Message-ID: <20260318105123.819807-6-o.rempel@pengutronix.de>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,foss.st.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227022-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.8:email,protonic.nl:email,pengutronix.de:email,pengutronix.de:mid]
X-Rspamd-Queue-Id: C1A8C2BA463
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Jander <david@protonic.nl>

Move the gpio-line-names properties out of the common mecio1-io.dtsi file
and into the specific board dts files.

The pinout originally defined in the common include file belonged to the
mecio1r0 (Revision 0) hardware. This is moved 1:1 into the
stm32mp151c-mecio1r0.dts file without any modifications.

A large number of GPIO pins are swapped on the mecio1r1 (Revision 1)
hardware, so a new, board-specific gpio-line-names mapping is added to
stm32mp153c-mecio1r1.dts to reflect those hardware changes.

Fixes: 8267753c891c ("ARM: dts: stm32: Add MECIO1 and MECT1S board variants")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Jander <david@protonic.nl>
Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts | 64 +++++++++++++++
 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts | 80 +++++++++++++++++++
 .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 63 ---------------
 3 files changed, 144 insertions(+), 63 deletions(-)

diff --git a/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts b/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
index 4e795ad42928..06ab77465816 100644
--- a/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
+++ b/arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts
@@ -96,3 +96,67 @@ &ethernet0 {
 	assigned-clock-rates = <125000000>; /* Clock PLL3 to 625Mhz in tf-a. */
 	st,eth-clk-sel;
 };
+
+&gpiod {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "STP_RESETN", "STP_ENABLEN", "HPOUT0", "HPOUT0_ALERTN";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_d_mecsbc>;
+};
+
+&gpioe {
+	gpio-line-names = "HPOUT0_RESETN", "HPOUT1", "HPOUT1_ALERTN", "",
+			  "", "", "HPOUT1_RESETN",
+			  "LPOUT0", "LPOUT0_ALERTN", "LPOUT0_RESETN",
+			  "LPOUT1", "LPOUT1_ALERTN", "LPOUT1_RESETN",
+			  "LPOUT2", "LPOUT2_ALERTN", "LPOUT2_RESETN";
+};
+
+&gpiof {
+	gpio-line-names = "LPOUT3", "LPOUT3_ALERTN", "LPOUT3_RESETN",
+			  "LPOUT4", "LPOUT4_ALERTN", "LPOUT4_RESETN",
+			  "", "",
+			  "", "", "", "",
+			  "", "", "", "";
+};
+
+&gpiog {
+	gpio-line-names = "LPOUT5", "LPOUT5_ALERTN", "", "LPOUT5_RESETN",
+			  "", "", "", "",
+			  "", "", "", "",
+			  "", "", "", "";
+};
+
+&gpioh {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "GPIO0_RESETN", "", "", "",
+			  "", "", "", "";
+};
+
+&gpioi {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "HPDCM0_SLEEPN", "HPDCM1_SLEEPN", "GPIO1_RESETN", "",
+			  "", "", "", "";
+};
+
+&gpioj {
+	gpio-line-names = "HSIN10", "HSIN11", "HSIN12", "HSIN13",
+			  "HSIN14", "HSIN15", "", "",
+			  "", "", "", "",
+			  "", "RTD_RESETN", "", "";
+};
+
+&gpiok {
+	gpio-line-names = "", "", "HSIN0", "HSIN1",
+			  "HSIN2", "HSIN3", "HSIN4", "HSIN5";
+};
+
+&gpioz {
+	gpio-line-names = "", "", "", "HSIN6",
+			  "HSIN7", "HSIN8", "HSIN9", "";
+};
+
diff --git a/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts b/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
index d32816093e47..2b3989303cd1 100644
--- a/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
+++ b/arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts
@@ -90,6 +90,86 @@ &clk_hse {
 	clock-frequency = <24000000>;
 };
 
+&gpioa {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "", "GPIO1_RESETN", "",
+			  "", "", "", "LPOUT5";
+};
+
+&gpiob {
+	gpio-line-names = "", "", "", "",
+			  "LPOUT4_RESETN", "", "", "",
+			  "", "LPOUT4_ALERTN", "", "",
+			  "", "", "", "";
+};
+
+&gpioc {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "LPOUT4", "", "",
+			  "", "", "", "";
+};
+
+&gpiod {
+	gpio-line-names = "LPOUT2", "", "LPOUT3_RESETN", "",
+			  "LPOUT2_ALERTN", "", "MECIO_ADDR0", "",
+			  "HPOUT1_ALERTN", "HPOUT1_RESETN", "", "",
+			  "", "", "HPOUT0", "HPOUT1";
+};
+
+&gpioe {
+	gpio-line-names = "LPOUT0_RESETN", "", "", "",
+			  "", "LPOUT3", "LPOUT5_ALERTN", "",
+			  "", "", "", "",
+			  "", "", "", "HSIN_RESETN";
+};
+
+&gpiof {
+	gpio-line-names = "LPOUT5_RESETN", "", "", "HPOUT0_ALERTN",
+			  "", "LPOUT1", "", "",
+			  "", "", "", "",
+			  "", "", "", "";
+};
+
+&gpiog {
+	gpio-line-names = "", "", "", "HPOUT0_RESETN",
+			  "", "", "LPOUT3_ALERTN", "",
+			  "", "", "GPIO0_RESETN", "",
+			  "", "", "", "LPOUT2_RESETN";
+};
+
+&gpioh {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "LPOUT0", "", "",
+			  "", "LPOUT0_ALERTN", "STP_ENABLEN", "STP_RESETN";
+};
+
+&gpioi {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "",
+			  "", "", "SPE_RESETN", "",
+			  "HPDCM0_SLEEPN", "", "", "";
+};
+
+&gpioj {
+	gpio-line-names = "", "", "", "",
+			  "", "", "", "MECIO_ADDR1",
+			  "", "", "", "",
+			  "", "", "", "LPOUT1_RESETN";
+};
+
+&gpiok {
+	gpio-line-names = "", "", "RTD_RESETN", "",
+			  "", "LPOUT1_ALERTN", "", "";
+};
+
+&gpioz {
+	gpio-line-names = "", "", "", "",
+			  "HPDCM1_SLEEPN", "", "", "";
+};
+
 &m_can1 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&m_can1_pins_b>;
diff --git a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
index e50e9ae085e8..69a502ec36d4 100644
--- a/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi
@@ -173,69 +173,6 @@ phy0: ethernet-phy@8 {
 	};
 };
 
-&gpiod {
-	gpio-line-names = "", "", "", "",
-			  "", "", "", "",
-			  "", "", "", "",
-			  "STP_RESETN", "STP_ENABLEN", "HPOUT0", "HPOUT0_ALERTN";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hog_d_mecsbc>;
-};
-
-&gpioe {
-	gpio-line-names = "HPOUT0_RESETN", "HPOUT1", "HPOUT1_ALERTN", "",
-			  "", "", "HPOUT1_RESETN",
-			  "LPOUT0", "LPOUT0_ALERTN", "LPOUT0_RESETN",
-			  "LPOUT1", "LPOUT1_ALERTN", "LPOUT1_RESETN",
-			  "LPOUT2", "LPOUT2_ALERTN", "LPOUT2_RESETN";
-};
-
-&gpiof {
-	gpio-line-names = "LPOUT3", "LPOUT3_ALERTN", "LPOUT3_RESETN",
-			  "LPOUT4", "LPOUT4_ALERTN", "LPOUT4_RESETN",
-			  "", "",
-			  "", "", "", "",
-			  "", "", "", "";
-};
-
-&gpiog {
-	gpio-line-names = "LPOUT5", "LPOUT5_ALERTN", "", "LPOUT5_RESETN",
-			  "", "", "", "",
-			  "", "", "", "",
-			  "", "", "", "";
-};
-
-&gpioh {
-	gpio-line-names = "", "", "", "",
-			  "", "", "", "",
-			  "GPIO0_RESETN", "", "", "",
-			  "", "", "", "";
-};
-
-&gpioi {
-	gpio-line-names = "", "", "", "",
-			  "", "", "", "",
-			  "HPDCM0_SLEEPN", "HPDCM1_SLEEPN", "GPIO1_RESETN", "",
-			  "", "", "", "";
-};
-
-&gpioj {
-	gpio-line-names = "HSIN10", "HSIN11", "HSIN12", "HSIN13",
-			  "HSIN14", "HSIN15", "", "",
-			  "", "", "", "",
-			  "", "RTD_RESETN", "", "";
-};
-
-&gpiok {
-	gpio-line-names = "", "", "HSIN0", "HSIN1",
-			  "HSIN2", "HSIN3", "HSIN4", "HSIN5";
-};
-
-&gpioz {
-	gpio-line-names = "", "", "", "HSIN6",
-			  "HSIN7", "HSIN8", "HSIN9", "";
-};
-
 &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
-- 
2.47.3


