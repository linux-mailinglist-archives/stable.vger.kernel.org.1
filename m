Return-Path: <stable+bounces-113660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D288A29387
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9813B0437
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F5170A13;
	Wed,  5 Feb 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SGb9jwL9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A301519BF;
	Wed,  5 Feb 2025 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767722; cv=none; b=pRe+4wZxoYXTPlRemGoZMHocwDHyBIZywiLvpGPxcAyRQM/AhVRktRfTtjnaJXUxF+67VTVm0Bs1GcQfFn6Egh8UAbzOwXmEFyROsgfcLrmYYxVdC8HJmMzsie3lpcGVrlSGed5FAjZTk5t2xvTi9Gujq5idIPQMasmH4bYIclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767722; c=relaxed/simple;
	bh=eEa7cnAFX7zRWy4bo2uyX8GwhcKl2481kLdJCDFahBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOZNhZAjWFnfHtLTuaK0DQs5WVB/Gd6avEPm8AUELeIvNqr9HJns8DNzvJ81+KpCN5rvvvHUvKlRAlYnbrMhqyOYMkvTybvlRA1qsScKWEaUXSel7ecb6G6IE2NEJbc748SUcSWyATMoypWtCafIwKpg7gnly+oQqcokqUjyXu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SGb9jwL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BDDC4CED1;
	Wed,  5 Feb 2025 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767722;
	bh=eEa7cnAFX7zRWy4bo2uyX8GwhcKl2481kLdJCDFahBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGb9jwL9OGnvK4LXVp9LOpXIErlDqP3bgUIbgmjGBkDAMoRRw/RtzV0sV6INonsNH
	 VyXyq9DH+R1BfYqKc8SPZwm0SF4naHLUthnVySZAhJpm0irr5fIMba93qI7Ex0tHQG
	 bnrLCP4Q2/9Z1H5JvM2ntv6gNOavBcAtcRLIpnFg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mitchell Ma <machuang@radxa.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 421/623] arm64: dts: rockchip: Fix PCIe3 handling for Edgeble-6TOPS Modules
Date: Wed,  5 Feb 2025 14:42:43 +0100
Message-ID: <20250205134512.332533321@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jagan Teki <jagan@edgeble.ai>

[ Upstream commit e2ee8a440869281620fbcacdca6e13cbeebcc1be ]

The Edgeble 6TOPS modules has configured the PCIe3.0 with
- 2 lanes on Port1 of pcie3x2 controller for M.2 M-Key
- 2 lanes on Port0 of pcie3x4 controller for B and E-Key

The, current DT uses opposite controller nodes that indeed uses
incorrect reset, regulator nodes.

The configuration also uses refclk oscillator that need to enable
explicitly in DT to avoid the probe hang on while reading DBI.

So, this patch fixes all these essential issues and make this PCIe work
properly.

Issues fixed are,
- Fix the associate controller nodes for M and B, E-Key
- Fix the reset gpio handlings
- Fix the regulator handlings and naming convensions
- Support pcie_refclk oscillator

Fixes: 92eaee21abbd ("arm64: dts: rockchip: Add Edgeble NCM6A-IO M.2 B-Key, E-Key")
Fixes: 5d85d4c7e03b ("arm64: dts: rockchip: Add Edgeble NCM6A-IO M.2 M-Key")
Reported-by: Mitchell Ma <machuang@radxa.com>
Co-developed-by: Mitchell Ma <machuang@radxa.com>
Signed-off-by: Jagan Teki <jagan@edgeble.ai>
Link: https://lore.kernel.org/r/20241221151758.345257-1-jagan@edgeble.ai
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/rockchip/rk3588-edgeble-neu6a-io.dtsi | 81 ++++++++++++++-----
 1 file changed, 59 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
index 05ae9bdcfbbde..7125790bbed22 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-io.dtsi
@@ -10,6 +10,15 @@
 		stdout-path = "serial2:1500000n8";
 	};
 
+	/* Unnamed gated oscillator: 100MHz,3.3V,3225 */
+	pcie30_port0_refclk: pcie30_port1_refclk: pcie-oscillator {
+		compatible = "gated-fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "pcie30_refclk";
+		vdd-supply = <&vcc3v3_pi6c_05>;
+	};
+
 	vcc3v3_pcie2x1l0: regulator-vcc3v3-pcie2x1l0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_pcie2x1l0";
@@ -19,26 +28,26 @@
 		vin-supply = <&vcc_3v3_s3>;
 	};
 
-	vcc3v3_pcie3x2: regulator-vcc3v3-pcie3x2 {
+	vcc3v3_bkey: regulator-vcc3v3-bkey {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio2 RK_PC4 GPIO_ACTIVE_HIGH>; /* PCIE_4G_PWEN */
 		pinctrl-names = "default";
-		pinctrl-0 = <&pcie3x2_vcc3v3_en>;
-		regulator-name = "vcc3v3_pcie3x2";
+		pinctrl-0 = <&pcie_4g_pwen>;
+		regulator-name = "vcc3v3_bkey";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <5000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc3v3_pcie3x4: regulator-vcc3v3-pcie3x4 {
+	vcc3v3_pcie30: vcc3v3_pi6c_05: regulator-vcc3v3-pi6c-05 {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpios = <&gpio2 RK_PC5 GPIO_ACTIVE_HIGH>; /* PCIE30x4_PWREN_H */
 		pinctrl-names = "default";
-		pinctrl-0 = <&pcie3x4_vcc3v3_en>;
-		regulator-name = "vcc3v3_pcie3x4";
+		pinctrl-0 = <&pcie30x4_pwren_h>;
+		regulator-name = "vcc3v3_pcie30";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <5000>;
@@ -98,24 +107,52 @@
 };
 
 &pcie30phy {
+	data-lanes = <1 1 2 2>;
+	/* separate clock lines from the clock generator to phy and devices */
+	rockchip,rx-common-refclk-mode = <0 0 0 0>;
 	status = "okay";
 };
 
-/* B-Key and E-Key */
+/* M-Key */
 &pcie3x2 {
+	/*
+	 * The board has a "pcie_refclk" oscillator that needs enabling,
+	 * so add it to the list of clocks.
+	 */
+	clocks = <&cru ACLK_PCIE_2L_MSTR>, <&cru ACLK_PCIE_2L_SLV>,
+		 <&cru ACLK_PCIE_2L_DBI>, <&cru PCLK_PCIE_2L>,
+		 <&cru CLK_PCIE_AUX1>, <&cru CLK_PCIE2L_PIPE>,
+		 <&pcie30_port1_refclk>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk",
+		      "aux", "pipe",
+		      "ref";
+	num-lanes = <2>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3x2_rst>;
-	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>; /* PCIE30X4_PERSTn_M1_L */
-	vpcie3v3-supply = <&vcc3v3_pcie3x2>;
+	pinctrl-0 = <&pcie30x2_perstn_m1_l>;
+	reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>; /* PCIE30X2_PERSTn_M1_L */
+	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
 };
 
-/* M-Key */
+/* B-Key and E-Key */
 &pcie3x4 {
+	/*
+	 * The board has a "pcie_refclk" oscillator that needs enabling,
+	 * so add it to the list of clocks.
+	 */
+	clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
+		 <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
+		 <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>,
+		 <&pcie30_port0_refclk>;
+	clock-names = "aclk_mst", "aclk_slv",
+		      "aclk_dbi", "pclk",
+		      "aux", "pipe",
+		      "ref";
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3x4_rst>;
-	reset-gpios = <&gpio4 RK_PB0 GPIO_ACTIVE_HIGH>; /* PCIE30X2_PERSTn_M1_L */
-	vpcie3v3-supply = <&vcc3v3_pcie3x4>;
+	pinctrl-0 = <&pcie30x4_perstn_m1_l>;
+	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>; /* PCIE30X4_PERSTn_M1_L */
+	vpcie3v3-supply = <&vcc3v3_bkey>;
 	status = "okay";
 };
 
@@ -127,20 +164,20 @@
 	};
 
 	pcie3 {
-		pcie3x2_rst: pcie3x2-rst {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie30x2_perstn_m1_l: pcie30x2-perstn-m1-l {
+			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		pcie3x2_vcc3v3_en: pcie3x2-vcc3v3-en {
-			rockchip,pins = <2 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie_4g_pwen: pcie-4g-pwen {
+			rockchip,pins = <2 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 
-		pcie3x4_rst: pcie3x4-rst {
-			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie30x4_perstn_m1_l: pcie30x4-perstn-m1-l {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
-		pcie3x4_vcc3v3_en: pcie3x4-vcc3v3-en {
-			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		pcie30x4_pwren_h: pcie30x4-pwren-h {
+			rockchip,pins = <2 RK_PC5 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 	};
 
-- 
2.39.5




