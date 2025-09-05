Return-Path: <stable+bounces-177848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7AB45E05
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA655C6F37
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 16:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAC137428F;
	Fri,  5 Sep 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7JS3m1Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0896374283
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089322; cv=none; b=rQN2Chzf0VOXY2yuxsM14P8CBKImcL03R8VidT2ZqY5Abp6V/XdYMuRdGc7cvQO73PLDLzJz6N52gNfMxpu+YJ7vbYA2+v6MBHqCiVgUjskr/54cNTm05FPU/q2gCY6h8wh5pJuS8ejb9gLO+5GTBzk8BtFmpy4NK3nWxIvVNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089322; c=relaxed/simple;
	bh=OchZs+UwklXwMBF3ww6hSZ0I+IaWJiQ/bm93TeKbxZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4Xa2R4XYGFtoNzDvnOtt3db5j28qtx1vUVBJlRslMXX3kWVQ+i++rB0SHfhWPr5YmCFtHZdSoSVMm4QvIxGJ/n9Nh1ltPi36Xwl54eGCL2WOH+CkQCl2ARvZOlNkYgXYe1jcNIBiig02GOn/1SNR716q27tFdNHOtT9AnCxQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7JS3m1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECA4C4CEF1;
	Fri,  5 Sep 2025 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757089322;
	bh=OchZs+UwklXwMBF3ww6hSZ0I+IaWJiQ/bm93TeKbxZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7JS3m1Q0aipO7VMdjsTe2brvFvnrwXiexpUA6tgu7+nCx6GBLMaOJqiDa8p7kfib
	 kLVRRQeKn36+4GhOmuB5cO/LGuC7n2BnRDEoAUvhxjVPmWLYgCrtNT6oPkJuYQPOGz
	 ff20gN0zGOtrRiON8M2reBa8P6w6ttrMsXcUHCMLxcBsn+5BervX+5e/4nnwAVUbp5
	 Qc1pyL21xy7Ntymk04DaG5ksuWrA9yVh4TOz288GXhB+m2q5B3jezPOxBAUXM6e+Qi
	 +k+l194bKxvZEpdF0jih2SelC2Kz5qfNx5b2GqRG/ux8QFmXiAwAut4UrrwpNxzfGi
	 GaRYEuv6FCOww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gabor Juhos <j4g8y7@gmail.com>,
	Imre Kaloz <kaloz@openwrt.org>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] arm64: dts: marvell: uDPU: define pinctrl state for alarm LEDs
Date: Fri,  5 Sep 2025 12:21:58 -0400
Message-ID: <20250905162158.1742420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025052401-unbiased-designate-2089@gregkh>
References: <2025052401-unbiased-designate-2089@gregkh>
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


