Return-Path: <stable+bounces-177850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8822B45E47
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E13717B6A0
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA92D47E9;
	Fri,  5 Sep 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2tx5eaY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B631D72C
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090212; cv=none; b=XocMLAcl81jOjHEkXm4t2j30FwAvDW3Z8u+IuCe71MaoU5tcCh23aWRkQ9NHH6SplTcJLuETUwEWcUcfJygXSlIBTpK0LvX+2b9ndsEbQ2THpZfTSmTfaci/r4AyhyY+/4ZM5H65SjorY7peIwbN9W0FZmqoZPsNp1hw4ftChe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090212; c=relaxed/simple;
	bh=OchZs+UwklXwMBF3ww6hSZ0I+IaWJiQ/bm93TeKbxZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLo2g/iLT31zj5sKWw7BUM8drqbmS+epIN2faMrRB7XqtesJo93FcKD0nRorcsbPhXShM9injbIn7DhMEsr5p53PZ+83WuybMPT/kfnaZ1byUdAqZpfPeoCjrWLY10QtcnbM8sG/c5kAF3LADFICnd0TRCHa7ZyH7CokWMFb6J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2tx5eaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A37C4CEF1;
	Fri,  5 Sep 2025 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757090212;
	bh=OchZs+UwklXwMBF3ww6hSZ0I+IaWJiQ/bm93TeKbxZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2tx5eaYY6Yc9fWp6bKG34qRX4hkFJnmVJEPplqZaDqEiAF0NZeoZlLPbbmz2C+E8
	 yeLXLS/pw4ADwqBWZs3nxtFewAbsRXTdj/ns8PO316blaPq6TFhNWP88sHNMl5C4zW
	 Sm9RP7hjaaXuSr/xwOanIK7nSnF5nSVEsfMD5kgDFYQH/jMvn+d/TBjgTSNHeediNV
	 D15LmCctotdky1+mjJ5rJ2H3+0NIhnaKTmPgKMcdPIo/L/jVHH5fKqfTIRs18QlIvD
	 fqQ2kRLNoIF8bWe7z45gZvzDxlPyO22NKyGiYL15rv0YZs5un48lFjN5U+wgukQXEj
	 cjhdQATIaomVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Imre Kaloz <kaloz@openwrt.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] arm64: dts: marvell: uDPU: define pinctrl state for alarm LEDs
Date: Fri,  5 Sep 2025 12:36:49 -0400
Message-ID: <20250905163649.1746184-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052402-pantomime-relative-1605@gregkh>
References: <2025052402-pantomime-relative-1605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabor Juhos <j4g8y7@gmail.com>

[ Upstream commit b04f0d89e880bc2cca6a5c73cf287082c91878da ]

The two alarm LEDs of on the uDPU board are stopped working since
commit 78efa53e715e ("leds: Init leds class earlier").

The LEDs are driven by the GPIO{15,16} pins of the North Bridge
GPIO controller. These pins are part of the 'spi_quad' pin group
for which the 'spi' function is selected via the default pinctrl
state of the 'spi' node. This is wrong however, since in order to
allow controlling the LEDs, the pins should use the 'gpio' function.

Before the commit mentined above, the 'spi' function is selected
first by the pinctrl core before probing the spi driver, but then
it gets overridden to 'gpio' implicitly via the
devm_gpiod_get_index_optional() call from the 'leds-gpio' driver.

After the commit, the LED subsystem gets initialized before the
SPI subsystem, so the function of the pin group remains 'spi'
which in turn prevents controlling of the LEDs.

Despite the change of the initialization order, the root cause is
that the pinctrl state definition is wrong since its initial commit
0d45062cfc89 ("arm64: dts: marvell: Add device tree for uDPU board"),

To fix the problem, override the function in the 'spi_quad_pins'
node to 'gpio' and move the pinctrl state definition from the
'spi' node into the 'leds' node.

Cc: stable@vger.kernel.org # needs adjustment for < 6.1
Fixes: 0d45062cfc89 ("arm64: dts: marvell: Add device tree for uDPU board")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
[ Applied to .dts instead of .dtsi ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 95d46e8d081c1..d16200a323c50 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -28,8 +28,9 @@ memory@0 {
 	};
 
 	leds {
-		pinctrl-names = "default";
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_quad_pins>;
 
 		power1 {
 			label = "udpu:green:power";
@@ -96,8 +97,6 @@ &sdhci0 {
 
 &spi0 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi_quad_pins>;
 
 	m25p80@0 {
 		compatible = "jedec,spi-nor";
@@ -117,6 +116,10 @@ partition@0 {
 	};
 };
 
+&spi_quad_pins {
+	function = "gpio";
+};
+
 &pinctrl_nb {
 	i2c1_recovery_pins: i2c1-recovery-pins {
 		groups = "i2c1";
-- 
2.50.1


