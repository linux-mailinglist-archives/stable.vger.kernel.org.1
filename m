Return-Path: <stable+bounces-172421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA490B31B31
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9799DB24B94
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40071301476;
	Fri, 22 Aug 2025 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqgyW+u2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F285B305E31
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872181; cv=none; b=MItxPc0oOhD01wRrGPdiehJGr55r1djGYitgkNmC34zzSqH4QVsDQF+snHTfPYyGzDDUQzPCkfg6f3opzr3fTRJ+EomIkBvGD66SnUmKU0PZw4CP+Mdo4Pipszs440oh3bxPjjX9aXr+GmRNyVOx1sqyNfsEgCy4V4usQPwYGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872181; c=relaxed/simple;
	bh=NDUg4LV0Rs0ov4RtHT3cXRCP5VsuhCkVlPu3C3bQhA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt5plDn2yMpV6KpuYqZXCDSo7A7jqZkc2nOW8DvUwC7V6D43fu+T2QxGffx71RGYHA2i6IAdCCow5hnhR4GCATSWKKeCPwXC5BA1CptDq3PzwwBKddoUVzUTzxwPVcTeaQr3U4jmiqWeEUxZOUs6dBEiM+nS8TCTITweL7kzR1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqgyW+u2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E5EC4CEED;
	Fri, 22 Aug 2025 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872180;
	bh=NDUg4LV0Rs0ov4RtHT3cXRCP5VsuhCkVlPu3C3bQhA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TqgyW+u2utDed5GqkzE3MYo07bzUkGFHZoAgU25/0ELLziNRkC8f9sjUpC8r9hvhW
	 GOGWiyPr30shdFkGyWdsnjbJuUez1Iihfou+gXKLnXKszihPLHf5E5tmg56vSi3BdN
	 OC2ie+FVuHYhLMbXS48VYzC1Qs49R6LR8LbOutvH1FL3rahS5xxTxMU97rZ5hQVTgA
	 uy3fLTc+9K0+0GEilJV53FSRSTfxlPkHlF2gjh8nYnUdn1L5QczYEePQUBnYzUpu0/
	 WLL+JDcAenEpoofwQctAC/GH3H2ZhgOTgM7WyJagTuhPC1jIedNvBgXvH6xkp3u/Hi
	 snULNYBfu1f9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Moteen Shah <m-shah@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] arm64: dts: ti: k3-am6*: Remove disable-wp for eMMC
Date: Fri, 22 Aug 2025 10:16:14 -0400
Message-ID: <20250822141615.1255693-3-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822141615.1255693-1-sashal@kernel.org>
References: <2025082104-undermost-dispute-929c@gregkh>
 <20250822141615.1255693-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Judith Mendez <jm@ti.com>

[ Upstream commit ef839ba8142f14513ba396a033110526b7008096 ]

Remove disable-wp flag for eMMC nodes since this flag is
only applicable to SD according to the binding doc
(mmc/mmc-controller-common.yaml).

For eMMC, this flag should be ignored but lets remove
anyways to cleanup sdhci nodes.

Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429151454.4160506-4-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Stable-dep-of: a0b8da04153e ("arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi               | 1 -
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                | 1 -
 arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi              | 1 -
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                       | 1 -
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts                       | 1 -
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                | 1 -
 arch/arm64/boot/dts/ti/k3-am642-evm.dts                       | 1 -
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts                | 1 -
 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi | 1 -
 arch/arm64/boot/dts/ti/k3-am69-sk.dts                         | 1 -
 10 files changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index 43488cc8bcb1..ec87d18568fa 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -317,7 +317,6 @@ serial_flash: flash@0 {
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 163dca41e23c..f6ef1549801b 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -821,7 +821,6 @@ &sdhci0 {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
-	disable-wp;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index a5aceaa39670..960a409d6fea 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -324,7 +324,6 @@ serial_flash: flash@0 {
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 212119959dfd..a3b349093ad6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -603,7 +603,6 @@ &sdhci0 {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index df989a5260c5..b94093a7a392 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -446,7 +446,6 @@ &sdhci0 {
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 56d4584b7e24..3314955a9499 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -419,7 +419,6 @@ &sdhci0 {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 };
 
 &sdhci1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 97ca16f00cd2..95c20e39342c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -584,7 +584,6 @@ &sdhci0 {
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index aa7139cc8a92..c30425960398 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -456,7 +456,6 @@ &sdhci0 {
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 /*
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index ae842b85b70d..12af6cb7f65c 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -50,5 +50,4 @@ &sdhci0 {
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 1e36965a1403..3238dd17016a 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -926,7 +926,6 @@ &main_sdhci0 {
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 &main_sdhci1 {
-- 
2.50.1


