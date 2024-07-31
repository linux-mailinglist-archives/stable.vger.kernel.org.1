Return-Path: <stable+bounces-64760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78442942CDB
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285961F24EB8
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 11:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA181B1427;
	Wed, 31 Jul 2024 11:06:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78B1B1409
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423995; cv=none; b=ua4ihpceTAaGohHMIc1K/A0T2Y91TAumAZFVr5Gbp302g8zMpQgbBb5eSaTPOmcw8v/FQx1+h5J9HasEDRmWxedmSe5FIM9NkJl/kObA516QGbzRZVOef79jDGkKDxpHbULyJikToYjhwOAFO4HIDsYBZbli+NajXuFF3EpPOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423995; c=relaxed/simple;
	bh=RNhLk+oW8//0HtE+NRoFCgOOk7dQDAhxy4qB4T3bUhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qBdned3G79M3nmgdE8CbPgxJ1jwKJZb9WPXKOWVcgf6CHe9zq3wenezUv5wAOzkEs8w8x24TFpBBNPru1MxfMs2tr/gdd3DjyuJSHKiY3xk+7ZP1tuq20maA91c3WCbOh0ET9vGFe4bSpx3lwGfV2JhY18BKAfLYwreoE8c/dlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WYq680kh6zZf4;
	Wed, 31 Jul 2024 13:06:24 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WYq6725w9zQwk;
	Wed, 31 Jul 2024 13:06:23 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Wed, 31 Jul 2024 13:05:28 +0200
Subject: [PATCH 1/2] arm64: dts: rockchip: fix eMMC/SPI corruption when
 audio has been used on RK3399 Puma
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-puma-emmc-6-v1-1-4e28eadf32d0@cherry.de>
References: <20240731-puma-emmc-6-v1-0-4e28eadf32d0@cherry.de>
In-Reply-To: <20240731-puma-emmc-6-v1-0-4e28eadf32d0@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Judy Hsiao <judyhsiao@chromium.org>, 
 Brian Norris <briannorris@chromium.org>
Cc: stable@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 foss+kernel@0leil.net
X-Mailer: b4 0.14.0
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

In commit 91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch
on rk3399"), an additional pinctrl state was added whose default pinmux
is for 8ch i2s0. However, Puma only has 2ch i2s0. It's been overriding
the pinctrl-0 property but the second property override was missed in
the aforementioned commit.

On Puma, a hardware slider called "BIOS Disable/Normal Boot" can disable
eMMC and SPI to force booting from SD card. Another software-controlled
GPIO is then configured to override this behavior to make eMMC and SPI
available without human intervention. This is currently done in U-Boot
and it was enough until the aforementioned commit.

Indeed, because of this additional not-yet-overridden property, this
software-controlled GPIO is now muxed in a state that does not override
this hardware slider anymore, rendering SPI and eMMC flashes unusable.

Let's override the property with the 2ch pinmux to fix this.

Fixes: 91419ae0420f ("arm64: dts: rockchip: use BCLK to GPIO switch on rk3399")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index ccbe3a7a1d2c2..a782e614d9bba 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -409,6 +409,7 @@ vdd_cpu_b: regulator@60 {
 
 &i2s0 {
 	pinctrl-0 = <&i2s0_2ch_bus>;
+	pinctrl-1 = <&i2s0_2ch_bus_bclk_off>;
 	rockchip,playback-channels = <2>;
 	rockchip,capture-channels = <2>;
 	status = "okay";
@@ -417,8 +418,8 @@ &i2s0 {
 /*
  * As Q7 does not specify neither a global nor a RX clock for I2S these
  * signals are not used. Furthermore I2S0_LRCK_RX is used as GPIO.
- * Therefore we have to redefine the i2s0_2ch_bus definition to prevent
- * conflicts.
+ * Therefore we have to redefine the i2s0_2ch_bus and i2s0_2ch_bus_bclk_off
+ * definitions to prevent conflicts.
  */
 &i2s0_2ch_bus {
 	rockchip,pins =
@@ -428,6 +429,14 @@ &i2s0_2ch_bus {
 		<3 RK_PD7 1 &pcfg_pull_none>;
 };
 
+&i2s0_2ch_bus_bclk_off {
+	rockchip,pins =
+		<3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_none>,
+		<3 RK_PD2 1 &pcfg_pull_none>,
+		<3 RK_PD3 1 &pcfg_pull_none>,
+		<3 RK_PD7 1 &pcfg_pull_none>;
+};
+
 &io_domains {
 	status = "okay";
 	bt656-supply = <&vcc_1v8>;

-- 
2.45.2


