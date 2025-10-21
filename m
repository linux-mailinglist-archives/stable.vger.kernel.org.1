Return-Path: <stable+bounces-188365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B3BF76FF
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BEA3AAD4B
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466432E6B4;
	Tue, 21 Oct 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7piabgI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06D36B;
	Tue, 21 Oct 2025 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061138; cv=none; b=kT0SRMTGi6WE7FkJPjzrEQ5Y/mtuIfx3DzuwDgxqGQRt+udr8h4MNdKHMUb7bFXDKLJaXGvhpdu9V7c4WSpgPY3mVAircpSnjkQqHO+yliu7lLeuUIpkz5N8k5NUSpX+9lhl5QU1xbwuVU6E6xd492h9mRyZfGQS9pFZm+Etwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061138; c=relaxed/simple;
	bh=XLeQYak413CtBI3jcHC674M9UA1GVPE1UqJrMh7w2Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvsABwajZMkwLw/g/mzyx+RfqXLrWZRIq0s/ZhzaNwjnK5TUi2MZLeb06RsF3MJ5AYmLHiPLRpfTHin2prAiVHfOopRBiP+lcl6olBjAq9+xB6FNMaoQJX/F9gxB8K2PgBhKbhkkeB00FohHQg9zp9ZOhdVjKlmf73f9w+YJH5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7piabgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFB3C4CEF1;
	Tue, 21 Oct 2025 15:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061137;
	bh=XLeQYak413CtBI3jcHC674M9UA1GVPE1UqJrMh7w2Ns=;
	h=From:To:Cc:Subject:Date:From;
	b=V7piabgI1bWhCF95A9brwFN0p4hcGLyPsPXALNZjPWF1E6zNXVvwTcCYr2FldeE/D
	 gLsoGdsOdmJo4ySXSqpTTQNZj5mmnyBB5+0EAXkLH8SCa/Bu5KuLi+OZnWd6oFacUZ
	 IejZzvSQgBKh0xL8kABVHI8NDmjeI1Vhr7o944CEj3YW6SpbRT14ccjXkKs0V2CMqV
	 by/fWEXqZhtYKU0H3H3DAYxbykSqlxoENYobVy3IVv1rcQTsS0xzxgiReSlEEj0p8Y
	 IMy2gVqGTwMO62l4J/5oiFiGcsGzignqQc1ZWSbFhEmP9wMcuX4uCkAG+v85TrDZGv
	 0gK0JUW1KP2CA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	Cyril.Jean@microchip.com,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: dts: microchip: remove BeagleV Fire fabric.dtsi
Date: Tue, 21 Oct 2025 16:38:37 +0100
Message-ID: <20251021-dastardly-washbowl-b8c4ec1745db@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4872; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=tyhyGYHv/CwA3yfRKyi9p1HyzXfeQhJxBatLuQlCYLs=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBnfV/zpXPZYImjSnd01gmdzeFWtpt/7+tpx8dHLPrdbb 8868aZFo6OUhUGMi0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQATcZjG8N9pjtpyhUmnlOJm 9c2bHdxpWNX2I6vg7kLv5JZ37ye8++TP8Fd4RtVRv2tpqgXX1Mo0RNr0sgPYTNe9Pln2PFLf55+ CJD8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

At the time of adding the fabric.dtsi for the BeagleV Fire, we thought
that the fabric nodes in the Beagle supplied images were stable. They
are not, which has lead to nodes present in the devicetree that are not
in the programmed FPGA images. This is obviously problematic, and these
nodes must be removed.

CC: stable@vger.kernel.org
Fixes: 3f41368fbfe1 ("riscv: dts: microchip: add an initial devicetree for the BeagleV Fire")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
--
CC: Valentina.FernandezAlanis@microchip.com
CC: Cyril.Jean@microchip.com
CC: Conor Dooley <conor@kernel.org>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Jamie Gibbons <jamie.gibbons@microchip.com>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 .../microchip/mpfs-beaglev-fire-fabric.dtsi   | 82 -------------------
 .../boot/dts/microchip/mpfs-beaglev-fire.dts  |  5 --
 2 files changed, 87 deletions(-)
 delete mode 100644 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi

diff --git a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi
deleted file mode 100644
index e153eaf9b90e..000000000000
--- a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi
+++ /dev/null
@@ -1,82 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-
-/ {
-	fabric_clk3: fabric-clk3 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <50000000>;
-	};
-
-	fabric_clk1: fabric-clk1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <125000000>;
-	};
-
-	fabric-bus@40000000 {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x0 0x40000000 0x0 0x40000000 0x0 0x20000000>, /* FIC3-FAB */
-			 <0x0 0x60000000 0x0 0x60000000 0x0 0x20000000>, /* FIC0, LO */
-			 <0x0 0xe0000000 0x0 0xe0000000 0x0 0x20000000>, /* FIC1, LO */
-			 <0x20 0x0 0x20 0x0 0x10 0x0>, /* FIC0,HI */
-			 <0x30 0x0 0x30 0x0 0x10 0x0>; /* FIC1,HI */
-
-		cape_gpios_p8: gpio@41100000 {
-			compatible = "microchip,coregpio-rtl-v3";
-			reg = <0x0 0x41100000 0x0 0x1000>;
-			clocks = <&fabric_clk3>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			ngpios = <16>;
-			gpio-line-names = "P8_PIN31", "P8_PIN32", "P8_PIN33", "P8_PIN34",
-					  "P8_PIN35", "P8_PIN36", "P8_PIN37", "P8_PIN38",
-					  "P8_PIN39", "P8_PIN40", "P8_PIN41", "P8_PIN42",
-					  "P8_PIN43", "P8_PIN44", "P8_PIN45", "P8_PIN46";
-		};
-
-		cape_gpios_p9: gpio@41200000 {
-			compatible = "microchip,coregpio-rtl-v3";
-			reg = <0x0 0x41200000 0x0 0x1000>;
-			clocks = <&fabric_clk3>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			ngpios = <20>;
-			gpio-line-names = "P9_PIN11", "P9_PIN12", "P9_PIN13", "P9_PIN14",
-					  "P9_PIN15", "P9_PIN16", "P9_PIN17", "P9_PIN18",
-					  "P9_PIN21", "P9_PIN22", "P9_PIN23", "P9_PIN24",
-					  "P9_PIN25", "P9_PIN26", "P9_PIN27", "P9_PIN28",
-					  "P9_PIN29", "P9_PIN31", "P9_PIN41", "P9_PIN42";
-		};
-
-		hsi_gpios: gpio@44000000 {
-			compatible = "microchip,coregpio-rtl-v3";
-			reg = <0x0 0x44000000 0x0 0x1000>;
-			clocks = <&fabric_clk3>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			ngpios = <20>;
-			gpio-line-names = "B0_HSIO70N", "B0_HSIO71N", "B0_HSIO83N",
-					  "B0_HSIO73N_C2P_CLKN", "B0_HSIO70P", "B0_HSIO71P",
-					  "B0_HSIO83P", "B0_HSIO73N_C2P_CLKP", "XCVR1_RX_VALID",
-					  "XCVR1_LOCK", "XCVR1_ERROR", "XCVR2_RX_VALID",
-					  "XCVR2_LOCK", "XCVR2_ERROR", "XCVR3_RX_VALID",
-					  "XCVR3_LOCK", "XCVR3_ERROR", "XCVR_0B_REF_CLK_PLL_LOCK",
-					  "XCVR_0C_REF_CLK_PLL_LOCK", "B0_HSIO81N";
-		};
-	};
-
-	refclk_ccc: cccrefclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-	};
-};
-
-&ccc_nw {
-	clocks = <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>, <&refclk_ccc>,
-		 <&refclk_ccc>, <&refclk_ccc>;
-	clock-names = "pll0_ref0", "pll0_ref1", "pll1_ref0", "pll1_ref1",
-		      "dll0_ref", "dll1_ref";
-	status = "okay";
-};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
index 47cf693beb68..aae239d79162 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
@@ -5,7 +5,6 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include "mpfs.dtsi"
-#include "mpfs-beaglev-fire-fabric.dtsi"
 
 /* Clock frequency (in Hz) of MTIMER */
 #define MTIMER_FREQ		1000000
@@ -183,10 +182,6 @@ &refclk {
 	clock-frequency = <125000000>;
 };
 
-&refclk_ccc {
-	clock-frequency = <50000000>;
-};
-
 &rtc {
 	status = "okay";
 };
-- 
2.51.0


