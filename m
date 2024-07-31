Return-Path: <stable+bounces-64699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D09425F9
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 07:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D522B23966
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 05:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC4A75809;
	Wed, 31 Jul 2024 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="VGPVHHaR"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677819478;
	Wed, 31 Jul 2024 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404899; cv=none; b=dRUP6VJDsBv/Gf1MZpIfwRnBeQtBVQAKwY2IbDuHUZVwAFrIbSCFJdnEqspqQ2uI+V9bBst963pMf6krpxU542qPU2q/2vKrZPMJZjhRUfruB7gK2OH2HkD2qgLOHfMbpjpxgv1fZ7EQIF8iOFz+xS5AuaPm+uCefMPrE6kXKGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404899; c=relaxed/simple;
	bh=5i1diTmBKjYyCLnQOf+ri6jmBCWXGwxZ5KYGgt/oFI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iafFKG9Uu4yrd3NKTuxYM7xyFauNoj9lY5Xp9f3RP7cEnBDPVpuf8lfaoNjp+bSLlNnpYaRvxAGZscpy9hiVpcA3nc8xm9NFmapmUpiq7+9vhsLilX9oWHfBJoSR3h8Fz1x2Re3yL/SYQQRyNMaG0HU4fM7TuqIgoa06L9x+VBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=VGPVHHaR; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C0A891F9CA;
	Wed, 31 Jul 2024 07:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1722404888;
	bh=8J1RbUtAvYpjqNj4JPt8vwUV1t4mknX4y89IaxZ4hSo=; h=From:To:Subject;
	b=VGPVHHaRR6OmcuxcXvBpidOJXPFNc6Fqq4MSxtwHCjxQJcXoGQ9gVpGefQKyfW/YL
	 c28ObH8ZGyNCiUDa35dr1z73gYUzg2ONulNI5br2YsfTkaDfrzeXM0LCrbXXzqbHPQ
	 /3yAyV2f9d1GfOYsga6RR6k5ONwUGZGdcRBzkb+GKn8YF2J5vm05vFBqPi6OcyQag0
	 7RNWS8FZZwnR57xMv5cuLtXhcdJYX8SzIydlAA9w04TcmM7Qy7DNV31OMv9VbJc3e7
	 /lUSfrjdb8JffbMtNS0iz8BMaltvdfN3xX1+5dCxLjBaMoNZIw2wCPKfvg17qy7bvZ
	 fBsiTqGjURWng==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: k3-am62-verdin-dahlia: Keep CTRL_SLEEP_MOCI# regulator on
Date: Wed, 31 Jul 2024 07:48:04 +0200
Message-Id: <20240731054804.6061-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This reverts commit 3935fbc87ddebea5439f3ab6a78b1e83e976bf88.

CTRL_SLEEP_MOCI# is a signal that is defined for all the SoM
implementing the Verdin family specification, this signal is supposed to
control the power enable in the carrier board when the system is in deep
sleep mode. However this is not possible with Texas Instruments AM62
SoC, IOs output buffer is disabled in deep sleep and IOs are in
tri-state mode.

Given that we cannot properly control this pin, force it to be always
high to minimize potential issues.

Fixes: 3935fbc87dde ("arm64: dts: ti: k3-am62-verdin-dahlia: support sleep-moci")
Cc: <stable@vger.kernel.org>
Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1361669/am625-gpio-output-state-in-deep-sleep/5244802
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    | 22 -------------------
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |  6 -----
 2 files changed, 28 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
index e8f4d136e5df..9202181fbd65 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
@@ -43,15 +43,6 @@ simple-audio-card,cpu {
 			sound-dai = <&mcasp0>;
 		};
 	};
-
-	reg_usb_hub: regulator-usb-hub {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		/* Verdin CTRL_SLEEP_MOCI# (SODIMM 256) */
-		gpio = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
-		regulator-boot-on;
-		regulator-name = "HUB_PWR_EN";
-	};
 };
 
 /* Verdin ETHs */
@@ -193,11 +184,6 @@ &ospi0 {
 	status = "okay";
 };
 
-/* Do not force CTRL_SLEEP_MOCI# always enabled */
-&reg_force_sleep_moci {
-	status = "disabled";
-};
-
 /* Verdin SD_1 */
 &sdhci1 {
 	status = "okay";
@@ -218,15 +204,7 @@ &usbss1 {
 };
 
 &usb1 {
-	#address-cells = <1>;
-	#size-cells = <0>;
 	status = "okay";
-
-	usb-hub@1 {
-		compatible = "usb424,2744";
-		reg = <1>;
-		vdd-supply = <&reg_usb_hub>;
-	};
 };
 
 /* Verdin CTRL_WAKE1_MICO# */
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 359f53f3e019..5bef31b8577b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -138,12 +138,6 @@ reg_1v8_eth: regulator-1v8-eth {
 		vin-supply = <&reg_1v8>;
 	};
 
-	/*
-	 * By default we enable CTRL_SLEEP_MOCI#, this is required to have
-	 * peripherals on the carrier board powered.
-	 * If more granularity or power saving is required this can be disabled
-	 * in the carrier board device tree files.
-	 */
 	reg_force_sleep_moci: regulator-force-sleep-moci {
 		compatible = "regulator-fixed";
 		enable-active-high;
-- 
2.39.2


