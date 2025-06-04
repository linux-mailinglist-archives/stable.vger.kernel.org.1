Return-Path: <stable+bounces-151397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DBBACDE89
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784C33A3A3D
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A23928FABD;
	Wed,  4 Jun 2025 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jtvQDxHd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E628FAAA;
	Wed,  4 Jun 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749042441; cv=none; b=avktIbIu7rcRufPi7z2p6NXXhXZ093+BLgoyPH67q1F3jOwfcgh9ib4m05stDq4Y/oMQ/7bh+38EFmDDh1/6i9pZsOmFl7ks0ionqj515hOTuhEnMrnO2nOtxKJ4yJ8tt/ZweyOIFhfOtnFzClLoesZGRwZaj3ui6dM4xKXTEUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749042441; c=relaxed/simple;
	bh=uElf6KYnyw6Y2WJgt1NyJdbBMKJhipcJgxoNi4ztXJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOO/7dzrlbl9IU9MRsnp4YbhKiyCjjZIvEPhB0sUzZXgdFM8Wmqm8uLrXowX8KHoO6pyVjgQUZMBzXd8iEoq0xXJeDmbaZnQzZNv1Hz5JXWxuUkeHFbS/yRmBOti9IvUslSM7z1nivIhReFPlLYrypbokGx7nd8rNNOjYl4TqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jtvQDxHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C83C4CEE7;
	Wed,  4 Jun 2025 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749042440;
	bh=uElf6KYnyw6Y2WJgt1NyJdbBMKJhipcJgxoNi4ztXJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtvQDxHdrpieO9t5QMQAEn2FAsCgF2UqIJbpUbpDdA6RzScsjJo7/k8zxt28P2Qsb
	 lvRUxXTUCisoyt1QNaZ2M1qr6Jvta68lQwAogIrbP3QsuyQnf3rENMKlHU9MzYvH5M
	 Osff0XvQCeqhZTOGlvDy9yeE0aCL+9V+bfXubqH0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.141
Date: Wed,  4 Jun 2025 15:07:10 +0200
Message-ID: <2025060410-ravishing-yiddish-bd79@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025060410-directory-replace-61df@gregkh>
References: <2025060410-directory-replace-61df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6938c8cd7a6f..15e40774e9bc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5780,6 +5780,8 @@
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
+			Selecting specific mitigation does not force enable
+			user mitigations.
 
 			Selecting 'off' will disable both the kernel and
 			the user space protections.
diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 23c6b956cd90..9436f7c11306 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -100,4 +100,4 @@ Some helpers are provided in order to set/get modem control lines via GPIO.
 .. kernel-doc:: drivers/tty/serial/serial_mctrl_gpio.c
    :identifiers: mctrl_gpio_init mctrl_gpio_free mctrl_gpio_to_gpiod
            mctrl_gpio_set mctrl_gpio_get mctrl_gpio_enable_ms
-           mctrl_gpio_disable_ms
+           mctrl_gpio_disable_ms_sync mctrl_gpio_disable_ms_no_sync
diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
index d8f1d6859b96..1c12fbba440b 100644
--- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -32,12 +32,12 @@ Temperature sensors and fans can be queried and set via the standard
 =============================== ======= =======================================
 Name				Perm	Description
 =============================== ======= =======================================
-fan[1-3]_input                  RO      Fan speed in RPM.
-fan[1-3]_label                  RO      Fan label.
-fan[1-3]_min                    RO      Minimal Fan speed in RPM
-fan[1-3]_max                    RO      Maximal Fan speed in RPM
-fan[1-3]_target                 RO      Expected Fan speed in RPM
-pwm[1-3]                        RW      Control the fan PWM duty-cycle.
+fan[1-4]_input                  RO      Fan speed in RPM.
+fan[1-4]_label                  RO      Fan label.
+fan[1-4]_min                    RO      Minimal Fan speed in RPM
+fan[1-4]_max                    RO      Maximal Fan speed in RPM
+fan[1-4]_target                 RO      Expected Fan speed in RPM
+pwm[1-4]                        RW      Control the fan PWM duty-cycle.
 pwm1_enable                     WO      Enable or disable automatic BIOS fan
                                         control (not supported on all laptops,
                                         see below for details).
@@ -93,7 +93,7 @@ Again, when you find new codes, we'd be happy to have your patches!
 ---------------------------
 
 The driver also exports the fans as thermal cooling devices with
-``type`` set to ``dell-smm-fan[1-3]``. This allows for easy fan control
+``type`` set to ``dell-smm-fan[1-4]``. This allows for easy fan control
 using one of the thermal governors.
 
 Module parameters
diff --git a/Makefile b/Makefile
index f86e26fa0b31..70969a997a7f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 140
+SUBLEVEL = 141
 EXTRAVERSION =
 NAME = Curry Ramen
 
@@ -875,6 +875,18 @@ ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
 # The kernel builds with '-std=gnu11' so use of GNU extensions is acceptable.
 KBUILD_CFLAGS += -Wno-gnu
+
+# Clang may emit a warning when a const variable, such as the dummy variables
+# in typecheck(), or const member of an aggregate type are not initialized,
+# which can result in unexpected behavior. However, in many audited cases of
+# the "field" variant of the warning, this is intentional because the field is
+# never used within a particular call path, the field is within a union with
+# other non-const members, or the containing object is not const so the field
+# can be modified via memcpy() / memset(). While the variable warning also gets
+# disabled with this same switch, there should not be too much coverage lost
+# because -Wuninitialized will still flag when an uninitialized const variable
+# is used.
+KBUILD_CFLAGS += $(call cc-disable-warning, default-const-init-unsafe)
 else
 
 # gcc inanely warns about local variables called 'main'
diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 09996acad639..bb23bb39dd5b 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -139,7 +139,7 @@ dsib: dsi@54400000 {
 			reg = <0x54400000 0x00040000>;
 			clocks = <&tegra_car TEGRA114_CLK_DSIB>,
 				 <&tegra_car TEGRA114_CLK_DSIBLP>,
-				 <&tegra_car TEGRA114_CLK_PLL_D2_OUT0>;
+				 <&tegra_car TEGRA114_CLK_PLL_D_OUT0>;
 			clock-names = "dsi", "lp", "parent";
 			resets = <&tegra_car 82>;
 			reset-names = "dsi";
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 4d0d0d49a744..77aec670f635 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -537,11 +537,12 @@ extern u32 at91_pm_suspend_in_sram_sz;
 
 static int at91_suspend_finish(unsigned long val)
 {
-	unsigned char modified_gray_code[] = {
-		0x00, 0x01, 0x02, 0x03, 0x06, 0x07, 0x04, 0x05, 0x0c, 0x0d,
-		0x0e, 0x0f, 0x0a, 0x0b, 0x08, 0x09, 0x18, 0x19, 0x1a, 0x1b,
-		0x1e, 0x1f, 0x1c, 0x1d, 0x14, 0x15, 0x16, 0x17, 0x12, 0x13,
-		0x10, 0x11,
+	/* SYNOPSYS workaround to fix a bug in the calibration logic */
+	unsigned char modified_fix_code[] = {
+		0x00, 0x01, 0x01, 0x06, 0x07, 0x0c, 0x06, 0x07, 0x0b, 0x18,
+		0x0a, 0x0b, 0x0c, 0x0d, 0x0d, 0x0a, 0x13, 0x13, 0x12, 0x13,
+		0x14, 0x15, 0x15, 0x12, 0x18, 0x19, 0x19, 0x1e, 0x1f, 0x14,
+		0x1e, 0x1f,
 	};
 	unsigned int tmp, index;
 	int i;
@@ -552,25 +553,25 @@ static int at91_suspend_finish(unsigned long val)
 		 * restore the ZQ0SR0 with the value saved here. But the
 		 * calibration is buggy and restoring some values from ZQ0SR0
 		 * is forbidden and risky thus we need to provide processed
-		 * values for these (modified gray code values).
+		 * values for these.
 		 */
 		tmp = readl(soc_pm.data.ramc_phy + DDR3PHY_ZQ0SR0);
 
 		/* Store pull-down output impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PDO_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] = modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] = modified_fix_code[index] << DDR3PHY_ZQ0SR0_PDO_OFF;
 
 		/* Store pull-up output impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PUO_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SR0_PUO_OFF;
 
 		/* Store pull-down on-die termination impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SR0_PDODT_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SR0_PDODT_OFF;
 
 		/* Store pull-up on-die termination impedance select. */
 		index = (tmp >> DDR3PHY_ZQ0SRO_PUODT_OFF) & 0x1f;
-		soc_pm.bu->ddr_phy_calibration[0] |= modified_gray_code[index];
+		soc_pm.bu->ddr_phy_calibration[0] |= modified_fix_code[index] << DDR3PHY_ZQ0SRO_PUODT_OFF;
 
 		/*
 		 * The 1st 8 words of memory might get corrupted in the process
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 381d58cea092..c854c7e31051 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -151,28 +151,12 @@ &pio {
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
-&r_ir {
-	linux,rc-map-name = "rc-beelink-gs1";
-	status = "okay";
-};
-
-&r_pio {
-	/*
-	 * FIXME: We can't add that supply for now since it would
-	 * create a circular dependency between pinctrl, the regulator
-	 * and the RSB Bus.
-	 *
-	 * vcc-pl-supply = <&reg_aldo1>;
-	 */
-	vcc-pm-supply = <&reg_aldo1>;
-};
-
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp805: pmic@745 {
+	axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
-		reg = <0x745>;
+		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
@@ -290,6 +274,22 @@ sw {
 	};
 };
 
+&r_ir {
+	linux,rc-map-name = "rc-beelink-gs1";
+	status = "okay";
+};
+
+&r_pio {
+	/*
+	 * PL0 and PL1 are used for PMIC I2C
+	 * don't enable the pl-supply else
+	 * it will fail at boot
+	 *
+	 * vcc-pl-supply = <&reg_aldo1>;
+	 */
+	vcc-pm-supply = <&reg_aldo1>;
+};
+
 &spdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spdif_tx_pin>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 6fc65e8db220..8c476e089185 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -175,16 +175,12 @@ &pio {
 	vcc-pg-supply = <&reg_vcc_wifi_io>;
 };
 
-&r_ir {
-	status = "okay";
-};
-
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp805: pmic@745 {
+	axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
-		reg = <0x745>;
+		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
@@ -295,6 +291,10 @@ sw {
 	};
 };
 
+&r_ir {
+	status = "okay";
+};
+
 &rtc {
 	clocks = <&ext_osc32k>;
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 92745128fcfe..4ec4996592be 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -112,20 +112,12 @@ &pio {
 	vcc-pg-supply = <&reg_aldo1>;
 };
 
-&r_ir {
-	status = "okay";
-};
-
-&r_pio {
-	vcc-pm-supply = <&reg_bldo3>;
-};
-
-&r_rsb {
+&r_i2c {
 	status = "okay";
 
-	axp805: pmic@745 {
+	axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
-		reg = <0x745>;
+		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
@@ -240,6 +232,14 @@ sw {
 	};
 };
 
+&r_ir {
+	status = "okay";
+};
+
+&r_pio {
+	vcc-pm-supply = <&reg_bldo3>;
+};
+
 &rtc {
 	clocks = <&ext_osc32k>;
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
index 634373a423ef..481a88d83a65 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
@@ -1631,7 +1631,7 @@ vdd_1v8_dis: regulator-vdd-1v8-dis {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		regulator-always-on;
-		gpio = <&exp1 14 GPIO_ACTIVE_HIGH>;
+		gpio = <&exp1 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		vin-supply = <&vdd_1v8>;
 	};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 5a4972afc977..75292ec3ee77 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -421,7 +421,7 @@ cdsp_secure_heap: memory@80c00000 {
 			no-map;
 		};
 
-		pil_camera_mem: mmeory@85200000 {
+		pil_camera_mem: memory@85200000 {
 			reg = <0x0 0x85200000 0x0 0x500000>;
 			no-map;
 		};
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index fe022fe2d4f6..41612b03af63 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -132,6 +132,7 @@
 #define FUJITSU_CPU_PART_A64FX		0x001
 
 #define HISI_CPU_PART_TSV110		0xD01
+#define HISI_CPU_PART_HIP09			0xD02
 
 #define APPLE_CPU_PART_M1_ICESTORM	0x022
 #define APPLE_CPU_PART_M1_FIRESTORM	0x023
@@ -201,6 +202,7 @@
 #define MIDR_NVIDIA_CARMEL MIDR_CPU_MODEL(ARM_CPU_IMP_NVIDIA, NVIDIA_CPU_PART_CARMEL)
 #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
 #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
+#define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
 #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
 #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
 #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 1d713cfb0af1..426c3cb3e3bb 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -677,7 +677,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
 #define pud_none(pud)		(!pud_val(pud))
-#define pud_bad(pud)		(!pud_table(pud))
+#define pud_bad(pud)		((pud_val(pud) & PUD_TYPE_MASK) != \
+				 PUD_TYPE_TABLE)
 #define pud_present(pud)	pte_present(pud_pte(pud))
 #define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
 #define pud_valid(pud)		pte_valid(pud_pte(pud))
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index fcc641f30c93..4978c466e325 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -916,6 +916,7 @@ static u8 spectre_bhb_loop_affected(void)
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
 		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
+		MIDR_ALL_VERSIONS(MIDR_HISI_HIP09),
 		{},
 	};
 	static const struct midr_range spectre_bhb_k11_list[] = {
diff --git a/arch/mips/include/asm/ftrace.h b/arch/mips/include/asm/ftrace.h
index db497a8167da..e3212f44446f 100644
--- a/arch/mips/include/asm/ftrace.h
+++ b/arch/mips/include/asm/ftrace.h
@@ -87,4 +87,20 @@ struct dyn_arch_ftrace {
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
+
+#ifdef CONFIG_FTRACE_SYSCALLS
+#ifndef __ASSEMBLY__
+/*
+ * Some syscall entry functions on mips start with "__sys_" (fork and clone,
+ * for instance). We should also match the sys_ variant with those.
+ */
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+static inline bool arch_syscall_match_sym_name(const char *sym,
+					       const char *name)
+{
+	return !strcmp(sym, name) ||
+		(!strncmp(sym, "__sys_", 6) && !strcmp(sym + 6, name + 4));
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_FTRACE_SYSCALLS */
 #endif /* _ASM_MIPS_FTRACE_H */
diff --git a/arch/mips/kernel/pm-cps.c b/arch/mips/kernel/pm-cps.c
index 9bf60d7d44d3..a7bcf2b814c8 100644
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -56,10 +56,7 @@ static DEFINE_PER_CPU_ALIGNED(u32*, ready_count);
 /* Indicates online CPUs coupled with the current CPU */
 static DEFINE_PER_CPU_ALIGNED(cpumask_t, online_coupled);
 
-/*
- * Used to synchronize entry to deep idle states. Actually per-core rather
- * than per-CPU.
- */
+/* Used to synchronize entry to deep idle states */
 static DEFINE_PER_CPU_ALIGNED(atomic_t, pm_barrier);
 
 /* Saved CPU state across the CPS_PM_POWER_GATED state */
@@ -118,9 +115,10 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	cps_nc_entry_fn entry;
 	struct core_boot_config *core_cfg;
 	struct vpe_boot_config *vpe_cfg;
+	atomic_t *barrier;
 
 	/* Check that there is an entry function for this state */
-	entry = per_cpu(nc_asm_enter, core)[state];
+	entry = per_cpu(nc_asm_enter, cpu)[state];
 	if (!entry)
 		return -EINVAL;
 
@@ -156,7 +154,7 @@ int cps_pm_enter_state(enum cps_pm_state state)
 	smp_mb__after_atomic();
 
 	/* Create a non-coherent mapping of the core ready_count */
-	core_ready_count = per_cpu(ready_count, core);
+	core_ready_count = per_cpu(ready_count, cpu);
 	nc_addr = kmap_noncoherent(virt_to_page(core_ready_count),
 				   (unsigned long)core_ready_count);
 	nc_addr += ((unsigned long)core_ready_count & ~PAGE_MASK);
@@ -164,7 +162,8 @@ int cps_pm_enter_state(enum cps_pm_state state)
 
 	/* Ensure ready_count is zero-initialised before the assembly runs */
 	WRITE_ONCE(*nc_core_ready_count, 0);
-	coupled_barrier(&per_cpu(pm_barrier, core), online);
+	barrier = &per_cpu(pm_barrier, cpumask_first(&cpu_sibling_map[cpu]));
+	coupled_barrier(barrier, online);
 
 	/* Run the generated entry code */
 	left = entry(online, nc_core_ready_count);
@@ -635,12 +634,14 @@ static void *cps_gen_entry_code(unsigned cpu, enum cps_pm_state state)
 
 static int cps_pm_online_cpu(unsigned int cpu)
 {
-	enum cps_pm_state state;
-	unsigned core = cpu_core(&cpu_data[cpu]);
+	unsigned int sibling, core;
 	void *entry_fn, *core_rc;
+	enum cps_pm_state state;
+
+	core = cpu_core(&cpu_data[cpu]);
 
 	for (state = CPS_PM_NC_WAIT; state < CPS_PM_STATE_COUNT; state++) {
-		if (per_cpu(nc_asm_enter, core)[state])
+		if (per_cpu(nc_asm_enter, cpu)[state])
 			continue;
 		if (!test_bit(state, state_support))
 			continue;
@@ -652,16 +653,19 @@ static int cps_pm_online_cpu(unsigned int cpu)
 			clear_bit(state, state_support);
 		}
 
-		per_cpu(nc_asm_enter, core)[state] = entry_fn;
+		for_each_cpu(sibling, &cpu_sibling_map[cpu])
+			per_cpu(nc_asm_enter, sibling)[state] = entry_fn;
 	}
 
-	if (!per_cpu(ready_count, core)) {
+	if (!per_cpu(ready_count, cpu)) {
 		core_rc = kmalloc(sizeof(u32), GFP_KERNEL);
 		if (!core_rc) {
 			pr_err("Failed allocate core %u ready_count\n", core);
 			return -ENOMEM;
 		}
-		per_cpu(ready_count, core) = core_rc;
+
+		for_each_cpu(sibling, &cpu_sibling_map[cpu])
+			per_cpu(ready_count, sibling) = core_rc;
 	}
 
 	return 0;
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a6090896f749..ac669e58e202 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2974,11 +2974,11 @@ static void __init fixup_device_tree_pmac(void)
 	char type[8];
 	phandle node;
 
-	// Some pmacs are missing #size-cells on escc nodes
+	// Some pmacs are missing #size-cells on escc or i2s nodes
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = '\0';
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (prom_strcmp(type, "escc"))
+		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s"))
 			continue;
 
 		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index e3c31c771ce9..470d7715ecf4 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2229,6 +2229,10 @@ static struct pmu power_pmu = {
 #define PERF_SAMPLE_ADDR_TYPE  (PERF_SAMPLE_ADDR |		\
 				PERF_SAMPLE_PHYS_ADDR |		\
 				PERF_SAMPLE_DATA_PAGE_SIZE)
+
+#define SIER_TYPE_SHIFT	15
+#define SIER_TYPE_MASK	(0x7ull << SIER_TYPE_SHIFT)
+
 /*
  * A counter has overflowed; update its count and record
  * things if requested.  Note that interrupts are hard-disabled
@@ -2297,6 +2301,22 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	    is_kernel_addr(mfspr(SPRN_SIAR)))
 		record = 0;
 
+	/*
+	 * SIER[46-48] presents instruction type of the sampled instruction.
+	 * In ISA v3.0 and before values "0" and "7" are considered reserved.
+	 * In ISA v3.1, value "7" has been used to indicate "larx/stcx".
+	 * Drop the sample if "type" has reserved values for this field with a
+	 * ISA version check.
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
+			ppmu->get_mem_data_src) {
+		val = (regs->dar & SIER_TYPE_MASK) >> SIER_TYPE_SHIFT;
+		if (val == 0 || (val == 7 && !cpu_has_feature(CPU_FTR_ARCH_31))) {
+			record = 0;
+			atomic64_inc(&event->lost_samples);
+		}
+	}
+
 	/*
 	 * Finally record data if requested.
 	 */
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 56301b2bc8ae..031a2b63c171 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -321,8 +321,10 @@ void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
 
 	sier = mfspr(SPRN_SIER);
 	val = (sier & ISA207_SIER_TYPE_MASK) >> ISA207_SIER_TYPE_SHIFT;
-	if (val != 1 && val != 2 && !(val == 7 && cpu_has_feature(CPU_FTR_ARCH_31)))
+	if (val != 1 && val != 2 && !(val == 7 && cpu_has_feature(CPU_FTR_ARCH_31))) {
+		dsrc->val = 0;
 		return;
+	}
 
 	idx = (sier & ISA207_SIER_LDST_MASK) >> ISA207_SIER_LDST_SHIFT;
 	sub_idx = (sier & ISA207_SIER_DATA_SRC_MASK) >> ISA207_SIER_DATA_SRC_SHIFT;
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 778c50f27399..25d0501549f5 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -155,5 +155,6 @@ MRPROPER_FILES += $(HOST_DIR)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -f $(srctree)/Makefile ARCH=$(HEADER_ARCH) clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 38d5a71a579b..f6c766b2bdf5 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -68,6 +68,7 @@ void __init mem_init(void)
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
+	min_low_pfn = PFN_UP(__pa(uml_reserved));
 
 	/* this will put all low memory onto the freelists */
 	memblock_free_all();
diff --git a/arch/x86/boot/genimage.sh b/arch/x86/boot/genimage.sh
index c9299aeb7333..3882ead513f7 100644
--- a/arch/x86/boot/genimage.sh
+++ b/arch/x86/boot/genimage.sh
@@ -22,6 +22,7 @@
 # This script requires:
 #   bash
 #   syslinux
+#   genisoimage
 #   mtools (for fdimage* and hdimage)
 #   edk2/OVMF (for hdimage)
 #
@@ -251,7 +252,9 @@ geniso() {
 	cp "$isolinux" "$ldlinux" "$tmp_dir"
 	cp "$FBZIMAGE" "$tmp_dir"/linux
 	echo default linux "$KCMDLINE" > "$tmp_dir"/isolinux.cfg
-	cp "${FDINITRDS[@]}" "$tmp_dir"/
+	if [ ${#FDINITRDS[@]} -gt 0 ]; then
+		cp "${FDINITRDS[@]}" "$tmp_dir"/
+	fi
 	genisoimage -J -r -appid 'LINUX_BOOT' -input-charset=utf-8 \
 		    -quiet -o "$FIMAGE" -b isolinux.bin \
 		    -c boot.cat -no-emul-boot -boot-load-size 4 \
diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 37cbbc5c659a..8c385e231e07 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1216,7 +1216,8 @@ static __init int perf_ibs_op_init(void)
 	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
 		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
 		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
-		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= (IBS_OP_MAX_CNT_EXT_MASK |
+					    IBS_OP_CUR_CNT_EXT_MASK);
 	}
 
 	if (ibs_caps & IBS_CAPS_ZEN4)
diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 5c5f1e56c404..6f3d145670a9 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -59,6 +59,8 @@ int __register_nmi_handler(unsigned int, struct nmiaction *);
 
 void unregister_nmi_handler(unsigned int, const char *);
 
+void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler);
+
 void stop_nmi(void);
 void restart_nmi(void);
 void local_touch_nmi(void);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 4d810b9478a4..fa3576ef19da 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -456,6 +456,7 @@ struct pebs_xmm {
  */
 #define IBS_OP_CUR_CNT		(0xFFF80ULL<<32)
 #define IBS_OP_CUR_CNT_RAND	(0x0007FULL<<32)
+#define IBS_OP_CUR_CNT_EXT_MASK	(0x7FULL<<52)
 #define IBS_OP_CNT_CTL		(1ULL<<19)
 #define IBS_OP_VAL		(1ULL<<18)
 #define IBS_OP_ENABLE		(1ULL<<17)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 766cee7fa905..7233474c798f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1382,9 +1382,13 @@ static __ro_after_init enum spectre_v2_mitigation_cmd spectre_v2_cmd;
 static enum spectre_v2_user_cmd __init
 spectre_v2_parse_user_cmdline(void)
 {
+	enum spectre_v2_user_cmd mode;
 	char arg[20];
 	int ret, i;
 
+	mode = IS_ENABLED(CONFIG_MITIGATION_SPECTRE_V2) ?
+		SPECTRE_V2_USER_CMD_AUTO : SPECTRE_V2_USER_CMD_NONE;
+
 	switch (spectre_v2_cmd) {
 	case SPECTRE_V2_CMD_NONE:
 		return SPECTRE_V2_USER_CMD_NONE;
@@ -1397,7 +1401,7 @@ spectre_v2_parse_user_cmdline(void)
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
 	if (ret < 0)
-		return SPECTRE_V2_USER_CMD_AUTO;
+		return mode;
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -1407,8 +1411,8 @@ spectre_v2_parse_user_cmdline(void)
 		}
 	}
 
-	pr_err("Unknown user space protection option (%s). Switching to AUTO select\n", arg);
-	return SPECTRE_V2_USER_CMD_AUTO;
+	pr_err("Unknown user space protection option (%s). Switching to default\n", arg);
+	return mode;
 }
 
 static inline bool spectre_v2_in_eibrs_mode(enum spectre_v2_mitigation mode)
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index ed6cce6c3950..b9a128546970 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -38,8 +38,12 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
 
+/*
+ * An emergency handler can be set in any context including NMI
+ */
 struct nmi_desc {
 	raw_spinlock_t lock;
+	nmi_handler_t emerg_handler;
 	struct list_head head;
 };
 
@@ -121,9 +125,22 @@ static void nmi_check_duration(struct nmiaction *action, u64 duration)
 static int nmi_handle(unsigned int type, struct pt_regs *regs)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
+	nmi_handler_t ehandler;
 	struct nmiaction *a;
 	int handled=0;
 
+	/*
+	 * Call the emergency handler, if set
+	 *
+	 * In the case of crash_nmi_callback() emergency handler, it will
+	 * return in the case of the crashing CPU to enable it to complete
+	 * other necessary crashing actions ASAP. Other handlers in the
+	 * linked list won't need to be run.
+	 */
+	ehandler = desc->emerg_handler;
+	if (ehandler)
+		return ehandler(type, regs);
+
 	rcu_read_lock();
 
 	/*
@@ -213,6 +230,31 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 }
 EXPORT_SYMBOL_GPL(unregister_nmi_handler);
 
+/**
+ * set_emergency_nmi_handler - Set emergency handler
+ * @type:    NMI type
+ * @handler: the emergency handler to be stored
+ *
+ * Set an emergency NMI handler which, if set, will preempt all the other
+ * handlers in the linked list. If a NULL handler is passed in, it will clear
+ * it. It is expected that concurrent calls to this function will not happen
+ * or the system is screwed beyond repair.
+ */
+void set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler)
+{
+	struct nmi_desc *desc = nmi_to_desc(type);
+
+	if (WARN_ON_ONCE(desc->emerg_handler == handler))
+		return;
+	desc->emerg_handler = handler;
+
+	/*
+	 * Ensure the emergency handler is visible to other CPUs before
+	 * function return
+	 */
+	smp_wmb();
+}
+
 static void
 pci_serr_error(unsigned char reason, struct pt_regs *regs)
 {
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 299b970e5f82..d9dbcd1cf75f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -896,15 +896,11 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	shootdown_callback = callback;
 
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-	/* Would it be better to replace the trap vector here? */
-	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
-				 NMI_FLAG_FIRST, "crash"))
-		return;		/* Return what? */
+
 	/*
-	 * Ensure the new callback function is set before sending
-	 * out the NMI
+	 * Set emergency handler to preempt other handlers.
 	 */
-	wmb();
+	set_emergency_nmi_handler(NMI_LOCAL, crash_nmi_callback);
 
 	apic_send_IPI_allbutself(NMI_VECTOR);
 
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index ab697ee64528..446bf7fbc325 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -654,8 +654,13 @@ static void __init memory_map_top_down(unsigned long map_start,
 	 */
 	addr = memblock_phys_alloc_range(PMD_SIZE, PMD_SIZE, map_start,
 					 map_end);
-	memblock_phys_free(addr, PMD_SIZE);
-	real_end = addr + PMD_SIZE;
+	if (!addr) {
+		pr_warn("Failed to release memory for alloc_low_pages()");
+		real_end = max(map_start, ALIGN_DOWN(map_end, PMD_SIZE));
+	} else {
+		memblock_phys_free(addr, PMD_SIZE);
+		real_end = addr + PMD_SIZE;
+	}
 
 	/* step_size need to be small so pgt_buf from BRK could cover it */
 	step_size = PMD_SIZE;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 851711509d38..9d75b89fa257 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -959,9 +959,18 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	ret = __add_pages(nid, start_pfn, nr_pages, params);
 	WARN_ON_ONCE(ret);
 
-	/* update max_pfn, max_low_pfn and high_memory */
-	update_end_of_memory_vars(start_pfn << PAGE_SHIFT,
-				  nr_pages << PAGE_SHIFT);
+	/*
+	 * Special case: add_pages() is called by memremap_pages() for adding device
+	 * private pages. Do not bump up max_pfn in the device private path,
+	 * because max_pfn changes affect dma_addressing_limited().
+	 *
+	 * dma_addressing_limited() returning true when max_pfn is the device's
+	 * addressable memory can force device drivers to use bounce buffers
+	 * and impact their performance negatively:
+	 */
+	if (!params->pgmap)
+		/* update max_pfn, max_low_pfn and high_memory */
+		update_end_of_memory_vars(start_pfn << PAGE_SHIFT, nr_pages << PAGE_SHIFT);
 
 	return ret;
 }
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 230f1dee4f09..e0b0ec0f8245 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -109,8 +109,14 @@ void __init kernel_randomize_memory(void)
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
 		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 
-	/* Adapt physical memory region size based on available memory */
-	if (memory_tb < kaslr_regions[0].size_tb)
+	/*
+	 * Adapt physical memory region size based on available memory,
+	 * except when CONFIG_PCI_P2PDMA is enabled. P2PDMA exposes the
+	 * device BAR space assuming the direct map space is large enough
+	 * for creating a ZONE_DEVICE mapping in the direct map corresponding
+	 * to the physical BAR address.
+	 */
+	if (!IS_ENABLED(CONFIG_PCI_P2PDMA) && (memory_tb < kaslr_regions[0].size_tb))
 		kaslr_regions[0].size_tb = memory_tb;
 
 	/*
diff --git a/arch/x86/um/os-Linux/mcontext.c b/arch/x86/um/os-Linux/mcontext.c
index 49c3744cac37..81b9d1f9f4e6 100644
--- a/arch/x86/um/os-Linux/mcontext.c
+++ b/arch/x86/um/os-Linux/mcontext.c
@@ -26,7 +26,6 @@ void get_regs_from_mc(struct uml_pt_regs *regs, mcontext_t *mc)
 	COPY(RIP);
 	COPY2(EFLAGS, EFL);
 	COPY2(CS, CSGSFS);
-	regs->gp[CS / sizeof(unsigned long)] &= 0xffff;
-	regs->gp[CS / sizeof(unsigned long)] |= 3;
+	regs->gp[SS / sizeof(unsigned long)] = mc->gregs[REG_CSGSFS] >> 48;
 #endif
 }
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index 1d017ec5c63c..84f4e9c2b5d9 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -263,10 +263,6 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
 		return err;
 
 	err = crypto_ahash_import(&ctx2->req, state);
-	if (err) {
-		sock_orphan(sk2);
-		sock_put(sk2);
-	}
 
 	return err;
 }
diff --git a/crypto/lzo-rle.c b/crypto/lzo-rle.c
index 0631d975bfac..0abc2d87f042 100644
--- a/crypto/lzo-rle.c
+++ b/crypto/lzo-rle.c
@@ -55,7 +55,7 @@ static int __lzorle_compress(const u8 *src, unsigned int slen,
 	size_t tmp_len = *dlen; /* size_t(ulong) <-> uint on 64 bit */
 	int err;
 
-	err = lzorle1x_1_compress(src, slen, dst, &tmp_len, ctx);
+	err = lzorle1x_1_compress_safe(src, slen, dst, &tmp_len, ctx);
 
 	if (err != LZO_E_OK)
 		return -EINVAL;
diff --git a/crypto/lzo.c b/crypto/lzo.c
index ebda132dd22b..8338851c7406 100644
--- a/crypto/lzo.c
+++ b/crypto/lzo.c
@@ -55,7 +55,7 @@ static int __lzo_compress(const u8 *src, unsigned int slen,
 	size_t tmp_len = *dlen; /* size_t(ulong) <-> uint on 64 bit */
 	int err;
 
-	err = lzo1x_1_compress(src, slen, dst, &tmp_len, ctx);
+	err = lzo1x_1_compress_safe(src, slen, dst, &tmp_len, ctx);
 
 	if (err != LZO_E_OK)
 		return -EINVAL;
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 473241b5193f..596e96d3b3bd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -438,7 +438,7 @@ config ACPI_SBS
 	  the modules will be called sbs and sbshc.
 
 config ACPI_HED
-	tristate "Hardware Error Device"
+	bool "Hardware Error Device"
 	help
 	  This driver supports the Hardware Error Device (PNP0C33),
 	  which is used to report some hardware errors notified via
diff --git a/drivers/acpi/hed.c b/drivers/acpi/hed.c
index 60a2939cde6c..e8e9b1ac06b8 100644
--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -72,7 +72,12 @@ static struct acpi_driver acpi_hed_driver = {
 		.notify = acpi_hed_notify,
 	},
 };
-module_acpi_driver(acpi_hed_driver);
+
+static int __init acpi_hed_driver_init(void)
+{
+	return acpi_bus_register_driver(&acpi_hed_driver);
+}
+subsys_initcall(acpi_hed_driver_init);
 
 MODULE_AUTHOR("Huang Ying");
 MODULE_DESCRIPTION("ACPI Hardware Error Device Driver");
diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 6d309e4971b6..e243291a7e77 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -594,18 +594,19 @@ static int charlcd_init(struct charlcd *lcd)
 	return 0;
 }
 
-struct charlcd *charlcd_alloc(void)
+struct charlcd *charlcd_alloc(unsigned int drvdata_size)
 {
 	struct charlcd_priv *priv;
 	struct charlcd *lcd;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = kzalloc(sizeof(*priv) + drvdata_size, GFP_KERNEL);
 	if (!priv)
 		return NULL;
 
 	priv->esc_seq.len = -1;
 
 	lcd = &priv->lcd;
+	lcd->drvdata = priv->drvdata;
 
 	return lcd;
 }
diff --git a/drivers/auxdisplay/charlcd.h b/drivers/auxdisplay/charlcd.h
index eed80063a6d2..4bbf106b2dd8 100644
--- a/drivers/auxdisplay/charlcd.h
+++ b/drivers/auxdisplay/charlcd.h
@@ -49,7 +49,7 @@ struct charlcd {
 		unsigned long y;
 	} addr;
 
-	void *drvdata;
+	void *drvdata;			/* Set by charlcd_alloc() */
 };
 
 /**
@@ -93,7 +93,8 @@ struct charlcd_ops {
 };
 
 void charlcd_backlight(struct charlcd *lcd, enum charlcd_onoff on);
-struct charlcd *charlcd_alloc(void);
+
+struct charlcd *charlcd_alloc(unsigned int drvdata_size);
 void charlcd_free(struct charlcd *lcd);
 
 int charlcd_register(struct charlcd *lcd);
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 8b690f59df27..ebaf0ff518f4 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -226,7 +226,7 @@ static int hd44780_probe(struct platform_device *pdev)
 	if (!hdc)
 		return -ENOMEM;
 
-	lcd = charlcd_alloc();
+	lcd = charlcd_alloc(0);
 	if (!lcd)
 		goto fail1;
 
diff --git a/drivers/auxdisplay/lcd2s.c b/drivers/auxdisplay/lcd2s.c
index 135831a16514..2b597f226c0c 100644
--- a/drivers/auxdisplay/lcd2s.c
+++ b/drivers/auxdisplay/lcd2s.c
@@ -307,7 +307,7 @@ static int lcd2s_i2c_probe(struct i2c_client *i2c)
 	if (err < 0)
 		return err;
 
-	lcd = charlcd_alloc();
+	lcd = charlcd_alloc(0);
 	if (!lcd)
 		return -ENOMEM;
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index eba04c0de7eb..0f3999b665e7 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -835,7 +835,7 @@ static void lcd_init(void)
 	if (!hdc)
 		return;
 
-	charlcd = charlcd_alloc();
+	charlcd = charlcd_alloc(0);
 	if (!charlcd) {
 		kfree(hdc);
 		return;
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 444dfd6adfe6..a74b73cd243e 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/units.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -405,11 +406,151 @@ static const char * const imx8mp_clkout_sels[] = {"audio_pll1_out", "audio_pll2_
 static struct clk_hw **hws;
 static struct clk_hw_onecell_data *clk_hw_data;
 
+struct imx8mp_clock_constraints {
+	unsigned int clkid;
+	u32 maxrate;
+};
+
+/*
+ * Below tables are taken from IMX8MPCEC Rev. 2.1, 07/2023
+ * Table 13. Maximum frequency of modules.
+ * Probable typos fixed are marked with a comment.
+ */
+static const struct imx8mp_clock_constraints imx8mp_clock_common_constraints[] = {
+	{ IMX8MP_CLK_A53_DIV,             1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_AXI,             266666667 }, /* Datasheet claims 266MHz */
+	{ IMX8MP_CLK_NAND_USDHC_BUS,       266666667 }, /* Datasheet claims 266MHz */
+	{ IMX8MP_CLK_MEDIA_APB,            200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HDMI_APB,             133333333 }, /* Datasheet claims 133MHz */
+	{ IMX8MP_CLK_ML_AXI,               800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_AHB,                  133333333 },
+	{ IMX8MP_CLK_IPG_ROOT,              66666667 },
+	{ IMX8MP_CLK_AUDIO_AHB,            400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_DISP2_PIX,      170 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_DRAM_ALT,             666666667 },
+	{ IMX8MP_CLK_DRAM_APB,             200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_CAN1,                  80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_CAN2,                  80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_PCIE_AUX,              10 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_I2C5,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_I2C6,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI1,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI2,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI3,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI5,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_SAI6,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_ENET_QOS,             125 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_QOS_TIMER,       200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_REF,             125 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_TIMER,           125 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ENET_PHY_REF,         125 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NAND,                 500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_QSPI,                 400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_USDHC1,               400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_USDHC2,               400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_I2C1,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_I2C2,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_I2C3,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_I2C4,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_UART1,                 80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_UART2,                 80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_UART3,                 80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_UART4,                 80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ECSPI1,                80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ECSPI2,                80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_PWM1,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_PWM2,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_PWM3,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_PWM4,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_GPT1,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT2,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT3,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT4,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT5,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPT6,                 100 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_WDOG,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_IPP_DO_CLKO1,         200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_IPP_DO_CLKO2,         200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HDMI_REF_266M,        266 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_USDHC3,               400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_MIPI_PHY1_REF,  300 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_DISP1_PIX,      250 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_CAM2_PIX,       277 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_LDB,            595 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE, 200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ECSPI3,                80 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_PDM,                  200 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_SAI7,                  66666667 }, /* Datasheet claims 66MHz */
+	{ IMX8MP_CLK_MAIN_AXI,             400 * HZ_PER_MHZ },
+	{ /* Sentinel */ }
+};
+
+static const struct imx8mp_clock_constraints imx8mp_clock_nominal_constraints[] = {
+	{ IMX8MP_CLK_M7_CORE,           600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ML_CORE,           800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU3D_CORE,        800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU3D_SHADER_CORE, 800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU2D_CORE,        800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_AUDIO_AXI_SRC,     600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HSIO_AXI,          400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_ISP,         400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_BUS,           600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_AXI,         400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HDMI_AXI,          400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU_AXI,           600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU_AHB,           300 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NOC,               800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NOC_IO,            600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ML_AHB,            300 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_G1,            600 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_G2,            500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_CAM1_PIX,    400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_VC8000E,       400 * HZ_PER_MHZ }, /* Datasheet claims 500MHz */
+	{ IMX8MP_CLK_DRAM_CORE,         800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GIC,               400 * HZ_PER_MHZ },
+	{ /* Sentinel */ }
+};
+
+static const struct imx8mp_clock_constraints imx8mp_clock_overdrive_constraints[] = {
+	{ IMX8MP_CLK_M7_CORE,            800 * HZ_PER_MHZ},
+	{ IMX8MP_CLK_ML_CORE,           1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU3D_CORE,        1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU3D_SHADER_CORE, 1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU2D_CORE,        1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_AUDIO_AXI_SRC,      800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HSIO_AXI,           500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_ISP,          500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_BUS,            800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_AXI,          500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_HDMI_AXI,           500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU_AXI,            800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GPU_AHB,            400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NOC,               1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_NOC_IO,             800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_ML_AHB,             400 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_G1,             800 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_G2,             700 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_MEDIA_CAM1_PIX,     500 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_VPU_VC8000E,        500 * HZ_PER_MHZ }, /* Datasheet claims 400MHz */
+	{ IMX8MP_CLK_DRAM_CORE,         1000 * HZ_PER_MHZ },
+	{ IMX8MP_CLK_GIC,                500 * HZ_PER_MHZ },
+	{ /* Sentinel */ }
+};
+
+static void imx8mp_clocks_apply_constraints(const struct imx8mp_clock_constraints constraints[])
+{
+	const struct imx8mp_clock_constraints *constr;
+
+	for (constr = constraints; constr->clkid; constr++)
+		clk_hw_set_rate_range(hws[constr->clkid], 0, constr->maxrate);
+}
+
 static int imx8mp_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
 	void __iomem *anatop_base, *ccm_base;
+	const char *opmode;
 	int err;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
@@ -704,6 +845,16 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_check_clk_hws(hws, IMX8MP_CLK_END);
 
+	imx8mp_clocks_apply_constraints(imx8mp_clock_common_constraints);
+
+	err = of_property_read_string(np, "fsl,operating-mode", &opmode);
+	if (!err) {
+		if (!strcmp(opmode, "nominal"))
+			imx8mp_clocks_apply_constraints(imx8mp_clock_nominal_constraints);
+		else if (!strcmp(opmode, "overdrive"))
+			imx8mp_clocks_apply_constraints(imx8mp_clock_overdrive_constraints);
+	}
+
 	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 	if (err < 0) {
 		dev_err(dev, "failed to register hws for i.MX8MP\n");
diff --git a/drivers/clk/qcom/camcc-sm8250.c b/drivers/clk/qcom/camcc-sm8250.c
index 9b32c56a5bc5..e29706d78287 100644
--- a/drivers/clk/qcom/camcc-sm8250.c
+++ b/drivers/clk/qcom/camcc-sm8250.c
@@ -411,7 +411,7 @@ static struct clk_rcg2 cam_cc_bps_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -433,7 +433,7 @@ static struct clk_rcg2 cam_cc_camnoc_axi_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -454,7 +454,7 @@ static struct clk_rcg2 cam_cc_cci_0_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -469,7 +469,7 @@ static struct clk_rcg2 cam_cc_cci_1_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -490,7 +490,7 @@ static struct clk_rcg2 cam_cc_cphy_rx_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -511,7 +511,7 @@ static struct clk_rcg2 cam_cc_csi0phytimer_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -526,7 +526,7 @@ static struct clk_rcg2 cam_cc_csi1phytimer_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -556,7 +556,7 @@ static struct clk_rcg2 cam_cc_csi3phytimer_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -571,7 +571,7 @@ static struct clk_rcg2 cam_cc_csi4phytimer_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -586,7 +586,7 @@ static struct clk_rcg2 cam_cc_csi5phytimer_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -611,7 +611,7 @@ static struct clk_rcg2 cam_cc_fast_ahb_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -634,7 +634,7 @@ static struct clk_rcg2 cam_cc_fd_core_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -649,7 +649,7 @@ static struct clk_rcg2 cam_cc_icp_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -673,7 +673,7 @@ static struct clk_rcg2 cam_cc_ife_0_clk_src = {
 		.parent_data = cam_cc_parent_data_2,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_2),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -710,7 +710,7 @@ static struct clk_rcg2 cam_cc_ife_0_csid_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -734,7 +734,7 @@ static struct clk_rcg2 cam_cc_ife_1_clk_src = {
 		.parent_data = cam_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -749,7 +749,7 @@ static struct clk_rcg2 cam_cc_ife_1_csid_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -771,7 +771,7 @@ static struct clk_rcg2 cam_cc_ife_lite_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -786,7 +786,7 @@ static struct clk_rcg2 cam_cc_ife_lite_csid_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -810,7 +810,7 @@ static struct clk_rcg2 cam_cc_ipe_0_clk_src = {
 		.parent_data = cam_cc_parent_data_4,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_4),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -825,7 +825,7 @@ static struct clk_rcg2 cam_cc_jpeg_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -847,7 +847,7 @@ static struct clk_rcg2 cam_cc_mclk0_clk_src = {
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -862,7 +862,7 @@ static struct clk_rcg2 cam_cc_mclk1_clk_src = {
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -877,7 +877,7 @@ static struct clk_rcg2 cam_cc_mclk2_clk_src = {
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -892,7 +892,7 @@ static struct clk_rcg2 cam_cc_mclk3_clk_src = {
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -907,7 +907,7 @@ static struct clk_rcg2 cam_cc_mclk4_clk_src = {
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -922,7 +922,7 @@ static struct clk_rcg2 cam_cc_mclk5_clk_src = {
 		.parent_data = cam_cc_parent_data_1,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_1),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
@@ -993,7 +993,7 @@ static struct clk_rcg2 cam_cc_slow_ahb_clk_src = {
 		.parent_data = cam_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(cam_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_shared_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index e63a90db1505..c591fa1ad802 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -561,14 +561,19 @@ clk_alpha_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 alpha_width = pll_alpha_width(pll);
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
 
-	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
 	if (ctl & PLL_ALPHA_EN) {
-		regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &low);
+		if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &low))
+			return 0;
 		if (alpha_width > 32) {
-			regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
-				    &high);
+			if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
+					&high))
+				return 0;
 			a = (u64)high << 32 | low;
 		} else {
 			a = low & GENMASK(alpha_width - 1, 0);
@@ -760,8 +765,11 @@ alpha_pll_huayra_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, alpha = 0, ctl, alpha_m, alpha_n;
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
-	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
 
 	if (ctl & PLL_ALPHA_EN) {
 		regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &alpha);
@@ -955,8 +963,11 @@ clk_trion_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, frac, alpha_width = pll_alpha_width(pll);
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
-	regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &frac);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &frac))
+		return 0;
 
 	return alpha_pll_calc_rate(parent_rate, l, frac, alpha_width);
 }
@@ -1014,7 +1025,8 @@ clk_alpha_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
 	u32 ctl;
 
-	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
 
 	ctl >>= PLL_POST_DIV_SHIFT;
 	ctl &= PLL_POST_DIV_MASK(pll);
@@ -1230,8 +1242,11 @@ static unsigned long alpha_pll_fabia_recalc_rate(struct clk_hw *hw,
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l, frac, alpha_width = pll_alpha_width(pll);
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
-	regmap_read(pll->clkr.regmap, PLL_FRAC(pll), &frac);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_FRAC(pll), &frac))
+		return 0;
 
 	return alpha_pll_calc_rate(parent_rate, l, frac, alpha_width);
 }
@@ -1381,7 +1396,8 @@ clk_trion_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	struct regmap *regmap = pll->clkr.regmap;
 	u32 i, div = 1, val;
 
-	regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (regmap_read(regmap, PLL_USER_CTL(pll), &val))
+		return 0;
 
 	val >>= pll->post_div_shift;
 	val &= PLL_POST_DIV_MASK(pll);
@@ -2254,9 +2270,12 @@ static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
 	struct regmap *regmap = pll->clkr.regmap;
 	u32 l, frac;
 
-	regmap_read(regmap, PLL_L_VAL(pll), &l);
+	if (regmap_read(regmap, PLL_L_VAL(pll), &l))
+		return 0;
 	l &= LUCID_EVO_PLL_L_VAL_MASK;
-	regmap_read(regmap, PLL_ALPHA_VAL(pll), &frac);
+
+	if (regmap_read(regmap, PLL_ALPHA_VAL(pll), &frac))
+		return 0;
 
 	return alpha_pll_calc_rate(parent_rate, l, frac, pll_alpha_width(pll));
 }
@@ -2331,7 +2350,8 @@ static unsigned long clk_rivian_evo_pll_recalc_rate(struct clk_hw *hw,
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 l;
 
-	regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l);
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
 
 	return parent_rate * l;
 }
diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
index cb4bf038e17f..89d8bf4a30a2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
@@ -412,19 +412,23 @@ static const struct clk_parent_data mmc0_mmc1_parents[] = {
 	{ .hw = &pll_periph0_2x_clk.common.hw },
 	{ .hw = &pll_audio1_div2_clk.common.hw },
 };
-static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(mmc0_clk, "mmc0", mmc0_mmc1_parents, 0x830,
-				       0, 4,	/* M */
-				       8, 2,	/* P */
-				       24, 3,	/* mux */
-				       BIT(31),	/* gate */
-				       0);
-
-static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(mmc1_clk, "mmc1", mmc0_mmc1_parents, 0x834,
-				       0, 4,	/* M */
-				       8, 2,	/* P */
-				       24, 3,	/* mux */
-				       BIT(31),	/* gate */
-				       0);
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_POSTDIV(mmc0_clk, "mmc0",
+					       mmc0_mmc1_parents, 0x830,
+					       0, 4,		/* M */
+					       8, 2,		/* P */
+					       24, 3,		/* mux */
+					       BIT(31),		/* gate */
+					       2,		/* post-div */
+					       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_POSTDIV(mmc1_clk, "mmc1",
+					       mmc0_mmc1_parents, 0x834,
+					       0, 4,		/* M */
+					       8, 2,		/* P */
+					       24, 3,		/* mux */
+					       BIT(31),		/* gate */
+					       2,		/* post-div */
+					       0);
 
 static const struct clk_parent_data mmc2_parents[] = {
 	{ .fw_name = "hosc" },
@@ -433,12 +437,14 @@ static const struct clk_parent_data mmc2_parents[] = {
 	{ .hw = &pll_periph0_800M_clk.common.hw },
 	{ .hw = &pll_audio1_div2_clk.common.hw },
 };
-static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(mmc2_clk, "mmc2", mmc2_parents, 0x838,
-				       0, 4,	/* M */
-				       8, 2,	/* P */
-				       24, 3,	/* mux */
-				       BIT(31),	/* gate */
-				       0);
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_POSTDIV(mmc2_clk, "mmc2", mmc2_parents,
+					       0x838,
+					       0, 4,		/* M */
+					       8, 2,		/* P */
+					       24, 3,		/* mux */
+					       BIT(31),		/* gate */
+					       2,		/* post-div */
+					       0);
 
 static SUNXI_CCU_GATE_HWS(bus_mmc0_clk, "bus-mmc0", psi_ahb_hws,
 			  0x84c, BIT(0), 0);
diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
index 6e50f3728fb5..7d836a9fb3db 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.h
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -52,6 +52,28 @@ struct ccu_mp {
 		}							\
 	}
 
+#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE_POSTDIV(_struct, _name, _parents, \
+						_reg,			\
+						_mshift, _mwidth,	\
+						_pshift, _pwidth,	\
+						_muxshift, _muxwidth,	\
+						_gate, _postdiv, _flags)\
+	struct ccu_mp _struct = {					\
+		.enable	= _gate,					\
+		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.p	= _SUNXI_CCU_DIV(_pshift, _pwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.fixed_post_div	= _postdiv,				\
+		.common	= {						\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_FIXED_POSTDIV,	\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
+							_parents,	\
+							&ccu_mp_ops,	\
+							_flags),	\
+		}							\
+	}
+
 #define SUNXI_CCU_MP_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
 				   _mshift, _mwidth,			\
 				   _pshift, _pwidth,			\
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index b3ae38f36720..39c70b5ac44c 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -114,6 +114,9 @@ static void gic_update_frequency(void *data)
 
 static int gic_starting_cpu(unsigned int cpu)
 {
+	/* Ensure the GIC counter is running */
+	clear_gic_config(GIC_CONFIG_COUNTSTOP);
+
 	gic_clockevent_cpu_init(cpu, this_cpu_ptr(&gic_clockevent_device));
 	return 0;
 }
@@ -248,9 +251,6 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 			pr_warn("Unable to register clock notifier\n");
 	}
 
-	/* And finally start the counter */
-	clear_gic_config(GIC_CONFIG_COUNTSTOP);
-
 	/*
 	 * It's safe to use the MIPS GIC timer as a sched clock source only if
 	 * its ticks are stable, which is true on either the platforms with
diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index 6c88827f4e62..1d6b54303723 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
+	u32 cpu;
 
 	policy->freq_table = data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency = 300 * 1000;
 	policy->driver_data = NULL;
 
+	/* set same policy for all cpus in a cluster */
+	for (cpu = 0; cpu < ARRAY_SIZE(tegra186_cpus); cpu++) {
+		if (data->cpus[cpu].bpmp_cluster_id == cluster)
+			cpumask_set_cpu(cpu, policy->cpus);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index c4922684f305..4edac724983a 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -249,8 +249,19 @@ static unsigned int get_typical_interval(struct menu_device *data,
 	 * This can deal with workloads that have long pauses interspersed
 	 * with sporadic activity with a bunch of short pauses.
 	 */
-	if ((divisor * 4) <= INTERVALS * 3)
+	if (divisor * 4 <= INTERVALS * 3) {
+		/*
+		 * If there are sufficiently many data points still under
+		 * consideration after the outliers have been eliminated,
+		 * returning without a prediction would be a mistake because it
+		 * is likely that the next interval will not exceed the current
+		 * maximum, so return the latter in that case.
+		 */
+		if (divisor >= INTERVALS / 2)
+			return max;
+
 		return UINT_MAX;
+	}
 
 	thresh = max - 1;
 	goto again;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
index 811ded72ce5f..798bb40fed68 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
@@ -410,9 +410,10 @@ static int cpt_process_ccode(struct otx2_cptlfs_info *lfs,
 				break;
 			}
 
-			dev_err(&pdev->dev,
-				"Request failed with software error code 0x%x\n",
-				cpt_status->s.uc_compcode);
+			pr_debug("Request failed with software error code 0x%x: algo = %s driver = %s\n",
+				 cpt_status->s.uc_compcode,
+				 info->req->areq->tfm->__crt_alg->cra_name,
+				 info->req->areq->tfm->__crt_alg->cra_driver_name);
 			otx2_cpt_dump_sg_list(pdev, info->req);
 			break;
 		}
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 9f8adb7013eb..9b07474f450b 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -12,7 +12,9 @@
 #include <linux/fs.h>
 #include <linux/poll.h>
 #include <linux/iommu.h>
+#include <linux/highmem.h>
 #include <uapi/linux/idxd.h>
+#include <linux/xarray.h>
 #include "registers.h"
 #include "idxd.h"
 
@@ -35,6 +37,7 @@ struct idxd_user_context {
 	struct idxd_wq *wq;
 	struct task_struct *task;
 	unsigned int pasid;
+	struct mm_struct *mm;
 	unsigned int flags;
 	struct iommu_sva *sva;
 };
@@ -69,6 +72,19 @@ static inline struct idxd_wq *inode_wq(struct inode *inode)
 	return idxd_cdev->wq;
 }
 
+static void idxd_xa_pasid_remove(struct idxd_user_context *ctx)
+{
+	struct idxd_wq *wq = ctx->wq;
+	void *ptr;
+
+	mutex_lock(&wq->uc_lock);
+	ptr = xa_cmpxchg(&wq->upasid_xa, ctx->pasid, ctx, NULL, GFP_KERNEL);
+	if (ptr != (void *)ctx)
+		dev_warn(&wq->idxd->pdev->dev, "xarray cmpxchg failed for pasid %u\n",
+			 ctx->pasid);
+	mutex_unlock(&wq->uc_lock);
+}
+
 static int idxd_cdev_open(struct inode *inode, struct file *filp)
 {
 	struct idxd_user_context *ctx;
@@ -109,20 +125,25 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 
 		pasid = iommu_sva_get_pasid(sva);
 		if (pasid == IOMMU_PASID_INVALID) {
-			iommu_sva_unbind_device(sva);
 			rc = -EINVAL;
-			goto failed;
+			goto failed_get_pasid;
 		}
 
 		ctx->sva = sva;
 		ctx->pasid = pasid;
+		ctx->mm = current->mm;
+
+		mutex_lock(&wq->uc_lock);
+		rc = xa_insert(&wq->upasid_xa, pasid, ctx, GFP_KERNEL);
+		mutex_unlock(&wq->uc_lock);
+		if (rc < 0)
+			dev_warn(dev, "PASID entry already exist in xarray.\n");
 
 		if (wq_dedicated(wq)) {
 			rc = idxd_wq_set_pasid(wq, pasid);
 			if (rc < 0) {
-				iommu_sva_unbind_device(sva);
 				dev_err(dev, "wq set pasid failed: %d\n", rc);
-				goto failed;
+				goto failed_set_pasid;
 			}
 		}
 	}
@@ -131,7 +152,13 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
 	mutex_unlock(&wq->wq_lock);
 	return 0;
 
- failed:
+failed_set_pasid:
+	if (device_user_pasid_enabled(idxd))
+		idxd_xa_pasid_remove(ctx);
+failed_get_pasid:
+	if (device_user_pasid_enabled(idxd))
+		iommu_sva_unbind_device(sva);
+failed:
 	mutex_unlock(&wq->wq_lock);
 	kfree(ctx);
 	return rc;
@@ -162,8 +189,10 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
 		}
 	}
 
-	if (ctx->sva)
+	if (ctx->sva) {
 		iommu_sva_unbind_device(ctx->sva);
+		idxd_xa_pasid_remove(ctx);
+	}
 	kfree(ctx);
 	mutex_lock(&wq->wq_lock);
 	idxd_wq_put(wq);
@@ -210,6 +239,9 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (!idxd->user_submission_safe && !capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
+	if (current->mm != ctx->mm)
+		return -EPERM;
+
 	rc = check_vma(wq, vma, __func__);
 	if (rc < 0)
 		return rc;
@@ -276,6 +308,9 @@ static ssize_t idxd_cdev_write(struct file *filp, const char __user *buf, size_t
 	ssize_t written = 0;
 	int i;
 
+	if (current->mm != ctx->mm)
+		return -EPERM;
+
 	for (i = 0; i < len/sizeof(struct dsa_hw_desc); i++) {
 		int rc = idxd_submit_user_descriptor(ctx, udesc + i);
 
@@ -296,6 +331,9 @@ static __poll_t idxd_cdev_poll(struct file *filp,
 	struct idxd_device *idxd = wq->idxd;
 	__poll_t out = 0;
 
+	if (current->mm != ctx->mm)
+		return POLLNVAL;
+
 	poll_wait(filp, &wq->err_queue, wait);
 	spin_lock(&idxd->dev_lock);
 	if (idxd->sw_err.valid)
@@ -408,6 +446,13 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	mutex_lock(&wq->wq_lock);
+
+	wq->wq = create_workqueue(dev_name(wq_confdev(wq)));
+	if (!wq->wq) {
+		rc = -ENOMEM;
+		goto wq_err;
+	}
+
 	wq->type = IDXD_WQT_USER;
 	rc = drv_enable_wq(wq);
 	if (rc < 0)
@@ -426,7 +471,9 @@ static int idxd_user_drv_probe(struct idxd_dev *idxd_dev)
 err_cdev:
 	drv_disable_wq(wq);
 err:
+	destroy_workqueue(wq->wq);
 	wq->type = IDXD_WQT_NONE;
+wq_err:
 	mutex_unlock(&wq->wq_lock);
 	return rc;
 }
@@ -439,6 +486,8 @@ static void idxd_user_drv_remove(struct idxd_dev *idxd_dev)
 	idxd_wq_del_cdev(wq);
 	drv_disable_wq(wq);
 	wq->type = IDXD_WQT_NONE;
+	destroy_workqueue(wq->wq);
+	wq->wq = NULL;
 	mutex_unlock(&wq->wq_lock);
 }
 
@@ -485,3 +534,70 @@ void idxd_cdev_remove(void)
 		ida_destroy(&ictx[i].minor_ida);
 	}
 }
+
+/**
+ * idxd_copy_cr - copy completion record to user address space found by wq and
+ *		  PASID
+ * @wq:		work queue
+ * @pasid:	PASID
+ * @addr:	user fault address to write
+ * @cr:		completion record
+ * @len:	number of bytes to copy
+ *
+ * This is called by a work that handles completion record fault.
+ *
+ * Return: number of bytes copied.
+ */
+int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
+		 void *cr, int len)
+{
+	struct device *dev = &wq->idxd->pdev->dev;
+	int left = len, status_size = 1;
+	struct idxd_user_context *ctx;
+	struct mm_struct *mm;
+
+	mutex_lock(&wq->uc_lock);
+
+	ctx = xa_load(&wq->upasid_xa, pasid);
+	if (!ctx) {
+		dev_warn(dev, "No user context\n");
+		goto out;
+	}
+
+	mm = ctx->mm;
+	/*
+	 * The completion record fault handling work is running in kernel
+	 * thread context. It temporarily switches to the mm to copy cr
+	 * to addr in the mm.
+	 */
+	kthread_use_mm(mm);
+	left = copy_to_user((void __user *)addr + status_size, cr + status_size,
+			    len - status_size);
+	/*
+	 * Copy status only after the rest of completion record is copied
+	 * successfully so that the user gets the complete completion record
+	 * when a non-zero status is polled.
+	 */
+	if (!left) {
+		u8 status;
+
+		/*
+		 * Ensure that the completion record's status field is written
+		 * after the rest of the completion record has been written.
+		 * This ensures that the user receives the correct completion
+		 * record information once polling for a non-zero status.
+		 */
+		wmb();
+		status = *(u8 *)cr;
+		if (put_user(status, (u8 __user *)addr))
+			left += status_size;
+	} else {
+		left += status_size;
+	}
+	kthread_unuse_mm(mm);
+
+out:
+	mutex_unlock(&wq->uc_lock);
+
+	return len - left;
+}
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 14c6ef987fed..c3ace4aed0fc 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -185,6 +185,7 @@ struct idxd_wq {
 	struct idxd_dev idxd_dev;
 	struct idxd_cdev *idxd_cdev;
 	struct wait_queue_head err_queue;
+	struct workqueue_struct *wq;
 	struct idxd_device *idxd;
 	int id;
 	struct idxd_irq_entry ie;
@@ -214,6 +215,10 @@ struct idxd_wq {
 	char name[WQ_NAME_SIZE + 1];
 	u64 max_xfer_bytes;
 	u32 max_batch_size;
+
+	/* Lock to protect upasid_xa access. */
+	struct mutex uc_lock;
+	struct xarray upasid_xa;
 };
 
 struct idxd_engine {
@@ -665,6 +670,8 @@ void idxd_cdev_remove(void);
 int idxd_cdev_get_major(struct idxd_device *idxd);
 int idxd_wq_add_cdev(struct idxd_wq *wq);
 void idxd_wq_del_cdev(struct idxd_wq *wq);
+int idxd_copy_cr(struct idxd_wq *wq, ioasid_t pasid, unsigned long addr,
+		 void *buf, int len);
 
 /* perfmon */
 #if IS_ENABLED(CONFIG_INTEL_IDXD_PERFMON)
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 7cb76db5ad60..ea651d5cf332 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -218,6 +218,8 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
 			}
 			bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
 		}
+		mutex_init(&wq->uc_lock);
+		xa_init(&wq->upasid_xa);
 		idxd->wqs[i] = wq;
 	}
 
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index c811757d0f97..0689464c4816 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1315,6 +1315,7 @@ static void idxd_conf_wq_release(struct device *dev)
 
 	bitmap_free(wq->opcap_bmap);
 	kfree(wq->wqcfg);
+	xa_destroy(&wq->upasid_xa);
 	kfree(wq);
 }
 
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 56be8ef40f37..e3635fba63b4 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -405,10 +405,9 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	int i, j, ret;
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
-	struct dimm_data dimm_info[IE31200_CHANNELS][IE31200_DIMMS_PER_CHANNEL];
 	void __iomem *window;
 	struct ie31200_priv *priv;
-	u32 addr_decode, mad_offset;
+	u32 addr_decode[IE31200_CHANNELS], mad_offset;
 
 	/*
 	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
@@ -466,19 +465,10 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 		mad_offset = IE31200_MAD_DIMM_0_OFFSET;
 	}
 
-	/* populate DIMM info */
 	for (i = 0; i < IE31200_CHANNELS; i++) {
-		addr_decode = readl(window + mad_offset +
+		addr_decode[i] = readl(window + mad_offset +
 					(i * 4));
-		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode);
-		for (j = 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
-			populate_dimm_info(&dimm_info[i][j], addr_decode, j,
-					   skl);
-			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
-				 dimm_info[i][j].size,
-				 dimm_info[i][j].dual_rank,
-				 dimm_info[i][j].x16_width);
-		}
+		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode[i]);
 	}
 
 	/*
@@ -489,14 +479,22 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	 */
 	for (i = 0; i < IE31200_DIMMS_PER_CHANNEL; i++) {
 		for (j = 0; j < IE31200_CHANNELS; j++) {
+			struct dimm_data dimm_info;
 			struct dimm_info *dimm;
 			unsigned long nr_pages;
 
-			nr_pages = IE31200_PAGES(dimm_info[j][i].size, skl);
+			populate_dimm_info(&dimm_info, addr_decode[j], i,
+					   skl);
+			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
+				 dimm_info.size,
+				 dimm_info.dual_rank,
+				 dimm_info.x16_width);
+
+			nr_pages = IE31200_PAGES(dimm_info.size, skl);
 			if (nr_pages == 0)
 				continue;
 
-			if (dimm_info[j][i].dual_rank) {
+			if (dimm_info.dual_rank) {
 				nr_pages = nr_pages / 2;
 				dimm = edac_get_dimm(mci, (i * 2) + 1, j, 0);
 				dimm->nr_pages = nr_pages;
diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 248594b59c64..5bda5d7ade42 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -191,6 +191,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4ffb9da537d8..5295ff90482b 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -52,7 +52,7 @@
 /* V2 Defines */
 #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
 
-#define V2_CREDIT_TIMEOUT_US		20000
+#define V2_CREDIT_TIMEOUT_US		40000
 #define V2_CHECK_CREDIT_US		10
 #define V2_POLL_TIMEOUT_US		1000000
 #define V2_USER_TIMEOUT_US		500000
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 262b3d276df7..f81d79a297a5 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -10,8 +10,9 @@
 
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
-#include <linux/gpio/driver.h>
+#include <linux/cleanup.h>
 #include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -20,6 +21,7 @@
 #include <linux/platform_data/pca953x.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 
 #include <asm/unaligned.h>
@@ -522,12 +524,10 @@ static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
 	u8 dirreg = chip->recalc_addr(chip, chip->regs->direction, off);
 	u8 bit = BIT(off % BANK_SZ);
-	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = regmap_write_bits(chip->regmap, dirreg, bit, bit);
-	mutex_unlock(&chip->i2c_lock);
-	return ret;
+	guard(mutex)(&chip->i2c_lock);
+
+	return regmap_write_bits(chip->regmap, dirreg, bit, bit);
 }
 
 static int pca953x_gpio_direction_output(struct gpio_chip *gc,
@@ -539,17 +539,15 @@ static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 	u8 bit = BIT(off % BANK_SZ);
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
+
 	/* set output level */
 	ret = regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
 	if (ret)
-		goto exit;
+		return ret;
 
 	/* then direction */
-	ret = regmap_write_bits(chip->regmap, dirreg, bit, 0);
-exit:
-	mutex_unlock(&chip->i2c_lock);
-	return ret;
+	return regmap_write_bits(chip->regmap, dirreg, bit, 0);
 }
 
 static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
@@ -560,9 +558,8 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
 	u32 reg_val;
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = regmap_read(chip->regmap, inreg, &reg_val);
-	mutex_unlock(&chip->i2c_lock);
+	scoped_guard(mutex, &chip->i2c_lock)
+		ret = regmap_read(chip->regmap, inreg, &reg_val);
 	if (ret < 0)
 		return ret;
 
@@ -575,9 +572,9 @@ static void pca953x_gpio_set_value(struct gpio_chip *gc, unsigned off, int val)
 	u8 outreg = chip->recalc_addr(chip, chip->regs->output, off);
 	u8 bit = BIT(off % BANK_SZ);
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
+
 	regmap_write_bits(chip->regmap, outreg, bit, val ? bit : 0);
-	mutex_unlock(&chip->i2c_lock);
 }
 
 static int pca953x_gpio_get_direction(struct gpio_chip *gc, unsigned off)
@@ -588,9 +585,8 @@ static int pca953x_gpio_get_direction(struct gpio_chip *gc, unsigned off)
 	u32 reg_val;
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = regmap_read(chip->regmap, dirreg, &reg_val);
-	mutex_unlock(&chip->i2c_lock);
+	scoped_guard(mutex, &chip->i2c_lock)
+		ret = regmap_read(chip->regmap, dirreg, &reg_val);
 	if (ret < 0)
 		return ret;
 
@@ -607,9 +603,8 @@ static int pca953x_gpio_get_multiple(struct gpio_chip *gc,
 	DECLARE_BITMAP(reg_val, MAX_LINE);
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
-	ret = pca953x_read_regs(chip, chip->regs->input, reg_val);
-	mutex_unlock(&chip->i2c_lock);
+	scoped_guard(mutex, &chip->i2c_lock)
+		ret = pca953x_read_regs(chip, chip->regs->input, reg_val);
 	if (ret)
 		return ret;
 
@@ -624,16 +619,15 @@ static void pca953x_gpio_set_multiple(struct gpio_chip *gc,
 	DECLARE_BITMAP(reg_val, MAX_LINE);
 	int ret;
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
+
 	ret = pca953x_read_regs(chip, chip->regs->output, reg_val);
 	if (ret)
-		goto exit;
+		return;
 
 	bitmap_replace(reg_val, reg_val, bits, mask, gc->ngpio);
 
 	pca953x_write_regs(chip, chip->regs->output, reg_val);
-exit:
-	mutex_unlock(&chip->i2c_lock);
 }
 
 static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
@@ -641,7 +635,6 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 					 unsigned long config)
 {
 	enum pin_config_param param = pinconf_to_config_param(config);
-
 	u8 pull_en_reg = chip->recalc_addr(chip, PCAL953X_PULL_EN, offset);
 	u8 pull_sel_reg = chip->recalc_addr(chip, PCAL953X_PULL_SEL, offset);
 	u8 bit = BIT(offset % BANK_SZ);
@@ -654,7 +647,7 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 	if (!(chip->driver_data & PCA_PCAL))
 		return -ENOTSUPP;
 
-	mutex_lock(&chip->i2c_lock);
+	guard(mutex)(&chip->i2c_lock);
 
 	/* Configure pull-up/pull-down */
 	if (param == PIN_CONFIG_BIAS_PULL_UP)
@@ -664,17 +657,13 @@ static int pca953x_gpio_set_pull_up_down(struct pca953x_chip *chip,
 	else
 		ret = 0;
 	if (ret)
-		goto exit;
+		return ret;
 
 	/* Disable/Enable pull-up/pull-down */
 	if (param == PIN_CONFIG_BIAS_DISABLE)
-		ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, 0);
+		return regmap_write_bits(chip->regmap, pull_en_reg, bit, 0);
 	else
-		ret = regmap_write_bits(chip->regmap, pull_en_reg, bit, bit);
-
-exit:
-	mutex_unlock(&chip->i2c_lock);
-	return ret;
+		return regmap_write_bits(chip->regmap, pull_en_reg, bit, bit);
 }
 
 static int pca953x_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
@@ -887,10 +876,8 @@ static irqreturn_t pca953x_irq_handler(int irq, void *devid)
 
 	bitmap_zero(pending, MAX_LINE);
 
-	mutex_lock(&chip->i2c_lock);
-	ret = pca953x_irq_pending(chip, pending);
-	mutex_unlock(&chip->i2c_lock);
-
+	scoped_guard(mutex, &chip->i2c_lock)
+		ret = pca953x_irq_pending(chip, pending);
 	if (ret) {
 		ret = 0;
 
@@ -1199,9 +1186,9 @@ static void pca953x_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int pca953x_regcache_sync(struct device *dev)
+static int pca953x_regcache_sync(struct pca953x_chip *chip)
 {
-	struct pca953x_chip *chip = dev_get_drvdata(dev);
+	struct device *dev = &chip->client->dev;
 	int ret;
 	u8 regaddr;
 
@@ -1248,13 +1235,38 @@ static int pca953x_regcache_sync(struct device *dev)
 	return 0;
 }
 
+static int pca953x_restore_context(struct pca953x_chip *chip)
+{
+	int ret;
+
+	guard(mutex)(&chip->i2c_lock);
+
+	if (chip->client->irq > 0)
+		enable_irq(chip->client->irq);
+	regcache_cache_only(chip->regmap, false);
+	regcache_mark_dirty(chip->regmap);
+	ret = pca953x_regcache_sync(chip);
+	if (ret)
+		return ret;
+
+	return regcache_sync(chip->regmap);
+}
+
+static void pca953x_save_context(struct pca953x_chip *chip)
+{
+	guard(mutex)(&chip->i2c_lock);
+
+	/* Disable IRQ to prevent early triggering while regmap "cache only" is on */
+	if (chip->client->irq > 0)
+		disable_irq(chip->client->irq);
+	regcache_cache_only(chip->regmap, true);
+}
+
 static int pca953x_suspend(struct device *dev)
 {
 	struct pca953x_chip *chip = dev_get_drvdata(dev);
 
-	mutex_lock(&chip->i2c_lock);
-	regcache_cache_only(chip->regmap, true);
-	mutex_unlock(&chip->i2c_lock);
+	pca953x_save_context(chip);
 
 	if (atomic_read(&chip->wakeup_path))
 		device_set_wakeup_path(dev);
@@ -1277,17 +1289,7 @@ static int pca953x_resume(struct device *dev)
 		}
 	}
 
-	mutex_lock(&chip->i2c_lock);
-	regcache_cache_only(chip->regmap, false);
-	regcache_mark_dirty(chip->regmap);
-	ret = pca953x_regcache_sync(dev);
-	if (ret) {
-		mutex_unlock(&chip->i2c_lock);
-		return ret;
-	}
-
-	ret = regcache_sync(chip->regmap);
-	mutex_unlock(&chip->i2c_lock);
+	ret = pca953x_restore_context(chip);
 	if (ret) {
 		dev_err(dev, "Failed to restore register map: %d\n", ret);
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index ab06cb4d7b35..4dcc7de961d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -42,6 +42,29 @@
 #include <linux/pci-p2pdma.h>
 #include <linux/pm_runtime.h>
 
+static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
+
+/**
+ * dma_buf_attach_adev - Helper to get adev of an attachment
+ *
+ * @attach: attachment
+ *
+ * Returns:
+ * A struct amdgpu_device * if the attaching device is an amdgpu device or
+ * partition, NULL otherwise.
+ */
+static struct amdgpu_device *dma_buf_attach_adev(struct dma_buf_attachment *attach)
+{
+	if (attach->importer_ops == &amdgpu_dma_buf_attach_ops) {
+		struct drm_gem_object *obj = attach->importer_priv;
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+		return amdgpu_ttm_adev(bo->tbo.bdev);
+	}
+
+	return NULL;
+}
+
 /**
  * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
  *
@@ -53,12 +76,14 @@
 static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 				 struct dma_buf_attachment *attach)
 {
+	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
 	struct drm_gem_object *obj = dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	int r;
 
-	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
+	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
+	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
@@ -479,6 +504,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
 	struct drm_gem_object *obj = &bo->tbo.base;
 	struct drm_gem_object *gobj;
 
+	if (!adev)
+		return false;
+
 	if (obj->import_attach) {
 		struct dma_buf *dma_buf = obj->import_attach->dmabuf;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f8740ad08af4..ae6643c8ade6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -43,7 +43,7 @@
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
-#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
+#define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*16)
 
 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
@@ -484,7 +484,6 @@ static int psp_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct psp_context *psp = &adev->psp;
-	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
 	psp_memory_training_fini(psp);
 	if (psp->sos_fw) {
@@ -511,8 +510,8 @@ static int psp_sw_fini(void *handle)
 	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7))
 		psp_sysfs_fini(adev);
 
-	kfree(cmd);
-	cmd = NULL;
+	kfree(psp->cmd);
+	psp->cmd = NULL;
 
 	psp_free_shared_bufs(psp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index ec4d5e15b766..de74686cb1db 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -92,12 +92,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
-	/* Program the AGP BAR */
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
-	WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
-
 	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
+		/* Program the AGP BAR */
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BASE, 0);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+		WREG32_SOC15_RLC(GC, 0, mmMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
+
 		/* Program the system aperture low logical page number. */
 		WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
 			min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index bc01c5173ab9..fd7fecaa9254 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -813,6 +813,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (thread->group_leader->mm != thread->mm)
 		return ERR_PTR(-EINVAL);
 
+	/* If the process just called exec(3), it is possible that the
+	 * cleanup of the kfd_process (following the release of the mm
+	 * of the old process image) is still in the cleanup work queue.
+	 * Make sure to drain any job before trying to recreate any
+	 * resource for this process.
+	 */
+	flush_workqueue(kfd_process_wq);
+
 	/*
 	 * take kfd processes mutex before starting of process creation
 	 * so there won't be a case where two threads of the same process
@@ -825,14 +833,6 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
-		/* If the process just called exec(3), it is possible that the
-		 * cleanup of the kfd_process (following the release of the mm
-		 * of the old process image) is still in the cleanup work queue.
-		 * Make sure to drain any job before trying to recreate any
-		 * resource for this process.
-		 */
-		flush_workqueue(kfd_process_wq);
-
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d8c020cd121..64f626cc7913 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2897,11 +2897,6 @@ static int dm_resume(void *handle)
 
 		return 0;
 	}
-
-	/* leave display off for S4 sequence */
-	if (adev->in_s4)
-		return 0;
-
 	/* Recreate dc_state - DC invalidates it when setting power state to S3. */
 	dc_release_state(dm_state->context);
 	dm_state->context = dc_create_state(dm->dc);
@@ -7281,7 +7276,7 @@ static int amdgpu_dm_i2c_xfer(struct i2c_adapter *i2c_adap,
 	int i;
 	int result = -EIO;
 
-	if (!ddc_service->ddc_pin || !ddc_service->ddc_pin->hw_info.hw_supported)
+	if (!ddc_service->ddc_pin)
 		return result;
 
 	cmd.payloads = kcalloc(num, sizeof(struct i2c_payload), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 09eb1bc9aa03..9549f9c15229 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -116,7 +116,7 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -192,15 +192,19 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
-		/* No need to apply the w/a if we haven't taken over from bios yet */
-		if (clk_mgr_base->clks.dispclk_khz)
-			dcn315_disable_otg_wa(clk_mgr_base, context, true);
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
 
+		dcn315_disable_otg_wa(clk_mgr_base, context, true);
+
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
+
+		dcn315_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn315_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
-		if (clk_mgr_base->clks.dispclk_khz)
-			dcn315_disable_otg_wa(clk_mgr_base, context, false);
+		dcn315_disable_otg_wa(clk_mgr_base, context, false);
 
 		update_dispclk = true;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
index 29d2003fb712..afce15aa2ff1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
@@ -153,7 +153,7 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count;
+	int display_count = 0;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -226,11 +226,18 @@ static void dcn316_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dppclk = true;
 	}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
+	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz) &&
+	    (new_clocks->dispclk_khz > 0 || (safe_to_lower && display_count == 0))) {
+		int requested_dispclk_khz = new_clocks->dispclk_khz;
+
 		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, true);
 
+		/* Clamp the requested clock to PMFW based on their limit. */
+		if (dc->debug.min_disp_clk_khz > 0 && requested_dispclk_khz < dc->debug.min_disp_clk_khz)
+			requested_dispclk_khz = dc->debug.min_disp_clk_khz;
+
+		dcn316_smu_set_dispclk(clk_mgr, requested_dispclk_khz);
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn316_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
 		dcn316_disable_otg_wa(clk_mgr_base, context, safe_to_lower, false);
 
 		update_dispclk = true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2721842af806..10672bb90a02 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -267,6 +267,7 @@ static bool create_links(
 		link->link_id.type = OBJECT_TYPE_CONNECTOR;
 		link->link_id.id = CONNECTOR_ID_VIRTUAL;
 		link->link_id.enum_id = ENUM_ID_1;
+		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 		link->link_enc = kzalloc(sizeof(*link->link_enc), GFP_KERNEL);
 
 		if (!link->link_enc) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
index 50dc83404644..4ce45f1bdac0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c
@@ -392,11 +392,6 @@ bool dpp3_get_optimal_number_of_taps(
 	int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 
-	if (scl_data->viewport.width > scl_data->h_active &&
-		dpp->ctx->dc->debug.max_downscale_src_width != 0 &&
-		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
-		return false;
-
 	/*
 	 * Set default taps if none are provided
 	 * From programming guide: taps = min{ ceil(2*H_RATIO,1), 8} for downscaling
@@ -434,6 +429,12 @@ bool dpp3_get_optimal_number_of_taps(
 	else
 		scl_data->taps.h_taps_c = in_taps->h_taps_c;
 
+	// Avoid null data in the scl data with this early return, proceed non-adaptive calcualtion first
+	if (scl_data->viewport.width > scl_data->h_active &&
+		dpp->ctx->dc->debug.max_downscale_src_width != 0 &&
+		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
+		return false;
+
 	/*Ensure we can support the requested number of vtaps*/
 	min_taps_y = dc_fixpt_ceil(scl_data->ratios.vert);
 	min_taps_c = dc_fixpt_ceil(scl_data->ratios.vert_c);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 958170fbfece..9d643c79afea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1717,7 +1717,7 @@ static int dcn315_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 		DC_FP_START();
 		dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
-		if (pixel_rate_crb && !pipe->top_pipe && !pipe->prev_odm_pipe) {
+		if (pixel_rate_crb) {
 			int bpp = source_format_to_bpp(pipes[pipe_cnt].pipe.src.source_format);
 			/* Ceil to crb segment size */
 			int approx_det_segs_required_for_pstate = dcn_get_approx_det_segs_required_for_pstate(
@@ -1768,28 +1768,26 @@ static int dcn315_populate_dml_pipes_from_context(
 				continue;
 			}
 
-			if (!pipe->top_pipe && !pipe->prev_odm_pipe) {
-				bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
-						|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
-
-				if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
-					pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
-							(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
-				if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
-					/* Clamp to 2 pipe split max det segments */
-					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
-					pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
-				}
-				if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
-					/* If we are splitting we must have an even number of segments */
-					remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
-					pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
-				}
-				/* Convert segments into size for DML use */
-				pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
-
-				crb_idx++;
+			bool split_required = pipe->stream->timing.pix_clk_100hz >= dcn_get_max_non_odm_pix_rate_100hz(&dc->dml.soc)
+					|| (pipe->plane_state && pipe->plane_state->src_rect.width > 5120);
+
+			if (remaining_det_segs > MIN_RESERVED_DET_SEGS && crb_pipes != 0)
+				pipes[pipe_cnt].pipe.src.det_size_override += (remaining_det_segs - MIN_RESERVED_DET_SEGS) / crb_pipes +
+						(crb_idx < (remaining_det_segs - MIN_RESERVED_DET_SEGS) % crb_pipes ? 1 : 0);
+			if (pipes[pipe_cnt].pipe.src.det_size_override > 2 * DCN3_15_MAX_DET_SEGS) {
+				/* Clamp to 2 pipe split max det segments */
+				remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override - 2 * (DCN3_15_MAX_DET_SEGS);
+				pipes[pipe_cnt].pipe.src.det_size_override = 2 * DCN3_15_MAX_DET_SEGS;
+			}
+			if (pipes[pipe_cnt].pipe.src.det_size_override > DCN3_15_MAX_DET_SEGS || split_required) {
+				/* If we are splitting we must have an even number of segments */
+				remaining_det_segs += pipes[pipe_cnt].pipe.src.det_size_override % 2;
+				pipes[pipe_cnt].pipe.src.det_size_override -= pipes[pipe_cnt].pipe.src.det_size_override % 2;
 			}
+			/* Convert segments into size for DML use */
+			pipes[pipe_cnt].pipe.src.det_size_override *= DCN3_15_CRB_SEGMENT_SIZE_KB;
+
+			crb_idx++;
 			pipe_cnt++;
 		}
 	}
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 1bc0220e6783..9fe856fd8a84 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -103,7 +103,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		return false;
 	}
 
-	switch (mode->crtc_hdisplay) {
+	switch (mode->hdisplay) {
 	case 640:
 		vbios_mode->enh_table = &res_640x480[refresh_rate_index];
 		break;
@@ -117,7 +117,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1152x864[refresh_rate_index];
 		break;
 	case 1280:
-		if (mode->crtc_vdisplay == 800)
+		if (mode->vdisplay == 800)
 			vbios_mode->enh_table = &res_1280x800[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1280x1024[refresh_rate_index];
@@ -129,7 +129,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1440x900[refresh_rate_index];
 		break;
 	case 1600:
-		if (mode->crtc_vdisplay == 900)
+		if (mode->vdisplay == 900)
 			vbios_mode->enh_table = &res_1600x900[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1600x1200[refresh_rate_index];
@@ -138,7 +138,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 		vbios_mode->enh_table = &res_1680x1050[refresh_rate_index];
 		break;
 	case 1920:
-		if (mode->crtc_vdisplay == 1080)
+		if (mode->vdisplay == 1080)
 			vbios_mode->enh_table = &res_1920x1080[refresh_rate_index];
 		else
 			vbios_mode->enh_table = &res_1920x1200[refresh_rate_index];
@@ -182,6 +182,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 	hborder = (vbios_mode->enh_table->flags & HBorder) ? 8 : 0;
 	vborder = (vbios_mode->enh_table->flags & VBorder) ? 8 : 0;
 
+	adjusted_mode->crtc_hdisplay = vbios_mode->enh_table->hde;
 	adjusted_mode->crtc_htotal = vbios_mode->enh_table->ht;
 	adjusted_mode->crtc_hblank_start = vbios_mode->enh_table->hde + hborder;
 	adjusted_mode->crtc_hblank_end = vbios_mode->enh_table->ht - hborder;
@@ -191,6 +192,7 @@ static bool ast_get_vbios_mode_info(const struct drm_format_info *format,
 					 vbios_mode->enh_table->hfp +
 					 vbios_mode->enh_table->hsync);
 
+	adjusted_mode->crtc_vdisplay = vbios_mode->enh_table->vde;
 	adjusted_mode->crtc_vtotal = vbios_mode->enh_table->vt;
 	adjusted_mode->crtc_vblank_start = vbios_mode->enh_table->vde + vborder;
 	adjusted_mode->crtc_vblank_end = vbios_mode->enh_table->vt - vborder;
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 66d223c2d9ab..e737e45a3a70 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -573,6 +573,30 @@ mode_valid(struct drm_atomic_state *state)
 	return 0;
 }
 
+static int drm_atomic_check_valid_clones(struct drm_atomic_state *state,
+					 struct drm_crtc *crtc)
+{
+	struct drm_encoder *drm_enc;
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
+									  crtc);
+
+	drm_for_each_encoder_mask(drm_enc, crtc->dev, crtc_state->encoder_mask) {
+		if (!drm_enc->possible_clones) {
+			DRM_DEBUG("enc%d possible_clones is 0\n", drm_enc->base.id);
+			continue;
+		}
+
+		if ((crtc_state->encoder_mask & drm_enc->possible_clones) !=
+		    crtc_state->encoder_mask) {
+			DRM_DEBUG("crtc%d failed valid clone check for mask 0x%x\n",
+				  crtc->base.id, crtc_state->encoder_mask);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * drm_atomic_helper_check_modeset - validate state object for modeset changes
  * @dev: DRM device
@@ -744,6 +768,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
 		ret = drm_atomic_add_affected_planes(state, crtc);
 		if (ret != 0)
 			return ret;
+
+		ret = drm_atomic_check_valid_clones(state, crtc);
+		if (ret != 0)
+			return ret;
 	}
 
 	/*
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 5ed77e3361fd..fc6028aae9bd 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6164,6 +6164,7 @@ static void drm_reset_display_info(struct drm_connector *connector)
 	info->has_hdmi_infoframe = false;
 	info->rgb_quant_range_selectable = false;
 	memset(&info->hdmi, 0, sizeof(info->hdmi));
+	memset(&connector->hdr_sink_metadata, 0, sizeof(connector->hdr_sink_metadata));
 
 	info->edid_hdmi_rgb444_dc_modes = 0;
 	info->edid_hdmi_ycbcr444_dc_modes = 0;
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 1fa958e8c40a..5ad9c384046c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -406,12 +406,13 @@ static void mtk_dpi_config_swap_input(struct mtk_dpi *dpi, bool enable)
 
 static void mtk_dpi_config_2n_h_fre(struct mtk_dpi *dpi)
 {
-	mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
+	if (dpi->conf->reg_h_fre_con)
+		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, H_FRE_2N, H_FRE_2N);
 }
 
 static void mtk_dpi_config_disable_edge(struct mtk_dpi *dpi)
 {
-	if (dpi->conf->edge_sel_en)
+	if (dpi->conf->edge_sel_en && dpi->conf->reg_h_fre_con)
 		mtk_dpi_mask(dpi, dpi->conf->reg_h_fre_con, 0, EDGE_SEL_EN);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2c14779a39e8..1ef1b4c966d2 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1944,6 +1944,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &sharp_lq140m1jw46.delay, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 
+	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0004, &delay_200_500_e200, "116KHD024006"),
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
 
 	{ /* sentinal */ }
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 955ef2caac89..6efa0a51b7d6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1289,10 +1289,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 
 	rb_swap = vop2_win_rb_swap(fb->format->format);
 	vop2_win_write(win, VOP2_WIN_RB_SWAP, rb_swap);
-	if (!vop2_cluster_window(win)) {
-		uv_swap = vop2_win_uv_swap(fb->format->format);
-		vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
-	}
+	uv_swap = vop2_win_uv_swap(fb->format->format);
+	vop2_win_write(win, VOP2_WIN_UV_SWAP, uv_swap);
 
 	if (fb->format->is_yuv) {
 		vop2_win_write(win, VOP2_WIN_UV_VIR, DIV_ROUND_UP(fb->pitches[1], 4));
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 4187d890bcc1..e078d2ac92c8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -41,6 +41,10 @@
 #define USB_VENDOR_ID_ACTIONSTAR	0x2101
 #define USB_DEVICE_ID_ACTIONSTAR_1011	0x1011
 
+#define USB_VENDOR_ID_ADATA_XPG 0x125f
+#define USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE 0x7505
+#define USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE_DONGLE 0x7506
+
 #define USB_VENDOR_ID_ADS_TECH		0x06e1
 #define USB_DEVICE_ID_ADS_TECH_RADIO_SI470X	0xa155
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 875c44e5cf6c..d8c5c7d451ef 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -27,6 +27,8 @@
 static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR), HID_QUIRK_BADPAD },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE), HID_QUIRK_ALWAYS_POLL },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ADATA_XPG, USB_VENDOR_ID_ADATA_XPG_WL_GAMING_MOUSE_DONGLE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016), HID_QUIRK_FULLSPEED_INTERVAL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AKAI_09E8, USB_DEVICE_ID_AKAI_09E8_MIDIMIX), HID_QUIRK_NO_INIT_REPORTS },
diff --git a/drivers/hid/usbhid/usbkbd.c b/drivers/hid/usbhid/usbkbd.c
index c439ed2f16db..af6bc76dbf64 100644
--- a/drivers/hid/usbhid/usbkbd.c
+++ b/drivers/hid/usbhid/usbkbd.c
@@ -160,7 +160,7 @@ static int usb_kbd_event(struct input_dev *dev, unsigned int type,
 		return -1;
 
 	spin_lock_irqsave(&kbd->leds_lock, flags);
-	kbd->newleds = (!!test_bit(LED_KANA,    dev->led) << 3) | (!!test_bit(LED_COMPOSE, dev->led) << 3) |
+	kbd->newleds = (!!test_bit(LED_KANA,    dev->led) << 4) | (!!test_bit(LED_COMPOSE, dev->led) << 3) |
 		       (!!test_bit(LED_SCROLLL, dev->led) << 2) | (!!test_bit(LED_CAPSL,   dev->led) << 1) |
 		       (!!test_bit(LED_NUML,    dev->led));
 
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 1572b5416015..dbcb8f362061 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -67,7 +67,7 @@
 #define I8K_POWER_BATTERY	0x01
 
 #define DELL_SMM_NO_TEMP	10
-#define DELL_SMM_NO_FANS	3
+#define DELL_SMM_NO_FANS	4
 
 struct dell_smm_data {
 	struct mutex i8k_mutex; /* lock for sensors writes */
@@ -940,11 +940,14 @@ static const struct hwmon_channel_info *dell_smm_info[] = {
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
 			   HWMON_F_TARGET,
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
+			   HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
 			   HWMON_F_TARGET
 			   ),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT
 			   ),
 	NULL
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index ba408942dbe7..f1926b9171e0 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -392,7 +392,12 @@ static int gpio_fan_set_cur_state(struct thermal_cooling_device *cdev,
 	if (state >= fan_data->num_speed)
 		return -EINVAL;
 
+	mutex_lock(&fan_data->lock);
+
 	set_fan_speed(fan_data, state);
+
+	mutex_unlock(&fan_data->lock);
+
 	return 0;
 }
 
@@ -488,7 +493,11 @@ MODULE_DEVICE_TABLE(of, of_gpio_fan_match);
 
 static void gpio_fan_stop(void *data)
 {
+	struct gpio_fan_data *fan_data = data;
+
+	mutex_lock(&fan_data->lock);
 	set_fan_speed(data, 0);
+	mutex_unlock(&fan_data->lock);
 }
 
 static int gpio_fan_probe(struct platform_device *pdev)
@@ -561,7 +570,9 @@ static int gpio_fan_suspend(struct device *dev)
 
 	if (fan_data->gpios) {
 		fan_data->resume_speed = fan_data->speed_index;
+		mutex_lock(&fan_data->lock);
 		set_fan_speed(fan_data, 0);
+		mutex_unlock(&fan_data->lock);
 	}
 
 	return 0;
@@ -571,8 +582,11 @@ static int gpio_fan_resume(struct device *dev)
 {
 	struct gpio_fan_data *fan_data = dev_get_drvdata(dev);
 
-	if (fan_data->gpios)
+	if (fan_data->gpios) {
+		mutex_lock(&fan_data->lock);
 		set_fan_speed(fan_data, fan_data->resume_speed);
+		mutex_unlock(&fan_data->lock);
+	}
 
 	return 0;
 }
diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 207084d55044..6768dbf39039 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -111,7 +111,7 @@ struct xgene_hwmon_dev {
 
 	phys_addr_t		comm_base_addr;
 	void			*pcc_comm_addr;
-	u64			usecs_lat;
+	unsigned int		usecs_lat;
 };
 
 /*
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index ade3f0ea5955..8263e017577d 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1508,7 +1508,10 @@ static int i2c_pxa_probe(struct platform_device *dev)
 				i2c->adap.name);
 	}
 
-	clk_prepare_enable(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
+	if (ret)
+		return dev_err_probe(&dev->dev, ret,
+				     "failed to enable clock\n");
 
 	if (i2c->use_pio) {
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 78682388e02e..82de4651d18f 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -14,6 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -150,6 +151,8 @@
 /* TAG length for DATA READ in RX FIFO  */
 #define READ_RX_TAGS_LEN		2
 
+#define QUP_BUS_WIDTH			8
+
 static unsigned int scl_freq;
 module_param_named(scl_freq, scl_freq, uint, 0444);
 MODULE_PARM_DESC(scl_freq, "SCL frequency override");
@@ -227,6 +230,7 @@ struct qup_i2c_dev {
 	int			irq;
 	struct clk		*clk;
 	struct clk		*pclk;
+	struct icc_path		*icc_path;
 	struct i2c_adapter	adap;
 
 	int			clk_ctl;
@@ -255,6 +259,10 @@ struct qup_i2c_dev {
 	/* To configure when bus is in run state */
 	u32			config_run;
 
+	/* bandwidth votes */
+	u32			src_clk_freq;
+	u32			cur_bw_clk_freq;
+
 	/* dma parameters */
 	bool			is_dma;
 	/* To check if the current transfer is using DMA */
@@ -453,6 +461,23 @@ static int qup_i2c_bus_active(struct qup_i2c_dev *qup, int len)
 	return ret;
 }
 
+static int qup_i2c_vote_bw(struct qup_i2c_dev *qup, u32 clk_freq)
+{
+	u32 needed_peak_bw;
+	int ret;
+
+	if (qup->cur_bw_clk_freq == clk_freq)
+		return 0;
+
+	needed_peak_bw = Bps_to_icc(clk_freq * QUP_BUS_WIDTH);
+	ret = icc_set_bw(qup->icc_path, 0, needed_peak_bw);
+	if (ret)
+		return ret;
+
+	qup->cur_bw_clk_freq = clk_freq;
+	return 0;
+}
+
 static void qup_i2c_write_tx_fifo_v1(struct qup_i2c_dev *qup)
 {
 	struct qup_i2c_block *blk = &qup->blk;
@@ -840,6 +865,10 @@ static int qup_i2c_bam_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 	int ret = 0;
 	int idx = 0;
 
+	ret = qup_i2c_vote_bw(qup, qup->src_clk_freq);
+	if (ret)
+		return ret;
+
 	enable_irq(qup->irq);
 	ret = qup_i2c_req_dma(qup);
 
@@ -1645,6 +1674,7 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 	config = readl(qup->base + QUP_CONFIG);
 	config |= QUP_CLOCK_AUTO_GATE;
 	writel(config, qup->base + QUP_CONFIG);
+	qup_i2c_vote_bw(qup, 0);
 	clk_disable_unprepare(qup->pclk);
 }
 
@@ -1745,6 +1775,11 @@ static int qup_i2c_probe(struct platform_device *pdev)
 			goto fail_dma;
 		}
 		qup->is_dma = true;
+
+		qup->icc_path = devm_of_icc_get(&pdev->dev, NULL);
+		if (IS_ERR(qup->icc_path))
+			return dev_err_probe(&pdev->dev, PTR_ERR(qup->icc_path),
+					     "failed to get interconnect path\n");
 	}
 
 nodma:
@@ -1793,6 +1828,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		qup_i2c_enable_clocks(qup);
 		src_clk_freq = clk_get_rate(qup->clk);
 	}
+	qup->src_clk_freq = src_clk_freq;
 
 	/*
 	 * Bootloaders might leave a pending interrupt on certain QUP's,
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 38095649ed27..9b287f92d078 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -495,6 +495,8 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 			queue_work(master->base.wq, &master->hj_work);
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_emit_stop(master);
+		break;
 	default:
 		break;
 	}
@@ -832,6 +834,8 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 	u32 reg;
 	int ret, i;
 
+	svc_i3c_master_flush_fifo(master);
+
 	while (true) {
 		/* Enter/proceed with DAA */
 		writel(SVC_I3C_MCTRL_REQUEST_PROC_DAA |
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 8ce569bf7525..1d154055a335 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -80,9 +80,12 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 				     unsigned long pgsz_bitmap,
 				     unsigned long virt)
 {
-	struct scatterlist *sg;
+	unsigned long curr_len = 0;
+	dma_addr_t curr_base = ~0;
 	unsigned long va, pgoff;
+	struct scatterlist *sg;
 	dma_addr_t mask;
+	dma_addr_t end;
 	int i;
 
 	umem->iova = va = virt;
@@ -107,17 +110,30 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	pgoff = umem->address & ~PAGE_MASK;
 
 	for_each_sgtable_dma_sg(&umem->sgt_append.sgt, sg, i) {
-		/* Walk SGL and reduce max page size if VA/PA bits differ
-		 * for any address.
+		/* If the current entry is physically contiguous with the previous
+		 * one, no need to take its start addresses into consideration.
 		 */
-		mask |= (sg_dma_address(sg) + pgoff) ^ va;
+		if (check_add_overflow(curr_base, curr_len, &end) ||
+		    end != sg_dma_address(sg)) {
+
+			curr_base = sg_dma_address(sg);
+			curr_len = 0;
+
+			/* Reduce max page size if VA/PA bits differ */
+			mask |= (curr_base + pgoff) ^ va;
+
+			/* The alignment of any VA matching a discontinuity point
+			* in the physical memory sets the maximum possible page
+			* size as this must be a starting point of a new page that
+			* needs to be aligned.
+			*/
+			if (i != 0)
+				mask |= va;
+		}
+
+		curr_len += sg_dma_len(sg);
 		va += sg_dma_len(sg) - pgoff;
-		/* Except for the last entry, the ending iova alignment sets
-		 * the maximum possible page size as the low bits of the iova
-		 * must be zero when starting the next chunk.
-		 */
-		if (i != (umem->sgt_append.sgt.nents - 1))
-			mask |= va;
+
 		pgoff = 0;
 	}
 
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index c6053e82ecf6..33e2fe0facd5 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -718,8 +718,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 		goto err_free;
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err_free;
 	}
 
@@ -809,8 +809,8 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	if (cmd.flags & IB_MR_REREG_PD) {
 		new_pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle,
 					   attrs);
-		if (!new_pd) {
-			ret = -EINVAL;
+		if (IS_ERR(new_pd)) {
+			ret = PTR_ERR(new_pd);
 			goto put_uobjs;
 		}
 	} else {
@@ -919,8 +919,8 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 		return PTR_ERR(uobj);
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err_free;
 	}
 
@@ -1127,8 +1127,8 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq)
-		return -EINVAL;
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
 
 	ret = cq->device->ops.resize_cq(cq, cmd.cqe, &attrs->driver_udata);
 	if (ret)
@@ -1189,8 +1189,8 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq)
-		return -EINVAL;
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
 
 	/* we copy a struct ib_uverbs_poll_cq_resp to user space */
 	header_ptr = attrs->ucore.outbuf;
@@ -1238,8 +1238,8 @@ static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq)
-		return -EINVAL;
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
 
 	ib_req_notify_cq(cq, cmd.solicited_only ?
 			 IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
@@ -1321,8 +1321,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		ind_tbl = uobj_get_obj_read(rwq_ind_table,
 					    UVERBS_OBJECT_RWQ_IND_TBL,
 					    cmd->rwq_ind_tbl_handle, attrs);
-		if (!ind_tbl) {
-			ret = -EINVAL;
+		if (IS_ERR(ind_tbl)) {
+			ret = PTR_ERR(ind_tbl);
 			goto err_put;
 		}
 
@@ -1360,8 +1360,10 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 			if (cmd->is_srq) {
 				srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ,
 							cmd->srq_handle, attrs);
-				if (!srq || srq->srq_type == IB_SRQT_XRC) {
-					ret = -EINVAL;
+				if (IS_ERR(srq) ||
+				    srq->srq_type == IB_SRQT_XRC) {
+					ret = IS_ERR(srq) ? PTR_ERR(srq) :
+								  -EINVAL;
 					goto err_put;
 				}
 			}
@@ -1371,23 +1373,29 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 					rcq = uobj_get_obj_read(
 						cq, UVERBS_OBJECT_CQ,
 						cmd->recv_cq_handle, attrs);
-					if (!rcq) {
-						ret = -EINVAL;
+					if (IS_ERR(rcq)) {
+						ret = PTR_ERR(rcq);
 						goto err_put;
 					}
 				}
 			}
 		}
 
-		if (has_sq)
+		if (has_sq) {
 			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
 						cmd->send_cq_handle, attrs);
+			if (IS_ERR(scq)) {
+				ret = PTR_ERR(scq);
+				goto err_put;
+			}
+		}
+
 		if (!ind_tbl && cmd->qp_type != IB_QPT_XRC_INI)
 			rcq = rcq ?: scq;
 		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle,
 				       attrs);
-		if (!pd || (!scq && has_sq)) {
-			ret = -EINVAL;
+		if (IS_ERR(pd)) {
+			ret = PTR_ERR(pd);
 			goto err_put;
 		}
 
@@ -1482,18 +1490,18 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 err_put:
 	if (!IS_ERR(xrcd_uobj))
 		uobj_put_read(xrcd_uobj);
-	if (pd)
+	if (!IS_ERR_OR_NULL(pd))
 		uobj_put_obj_read(pd);
-	if (scq)
+	if (!IS_ERR_OR_NULL(scq))
 		rdma_lookup_put_uobject(&scq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
-	if (rcq && rcq != scq)
+	if (!IS_ERR_OR_NULL(rcq) && rcq != scq)
 		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
-	if (srq)
+	if (!IS_ERR_OR_NULL(srq))
 		rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
-	if (ind_tbl)
+	if (!IS_ERR_OR_NULL(ind_tbl))
 		uobj_put_obj_read(ind_tbl);
 
 	uobj_alloc_abort(&obj->uevent.uobject, attrs);
@@ -1655,8 +1663,8 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 	}
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp) {
-		ret = -EINVAL;
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
 		goto out;
 	}
 
@@ -1761,8 +1769,8 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd->base.qp_handle,
 			       attrs);
-	if (!qp) {
-		ret = -EINVAL;
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
 		goto out;
 	}
 
@@ -2027,8 +2035,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 		return -ENOMEM;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp) {
-		ret = -EINVAL;
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
 		goto out;
 	}
 
@@ -2065,9 +2073,9 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 
 			ud->ah = uobj_get_obj_read(ah, UVERBS_OBJECT_AH,
 						   user_wr->wr.ud.ah, attrs);
-			if (!ud->ah) {
+			if (IS_ERR(ud->ah)) {
+				ret = PTR_ERR(ud->ah);
 				kfree(ud);
-				ret = -EINVAL;
 				goto out_put;
 			}
 			ud->remote_qpn = user_wr->wr.ud.remote_qpn;
@@ -2304,8 +2312,8 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 		return PTR_ERR(wr);
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp) {
-		ret = -EINVAL;
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
 		goto out;
 	}
 
@@ -2355,8 +2363,8 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 		return PTR_ERR(wr);
 
 	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
-	if (!srq) {
-		ret = -EINVAL;
+	if (IS_ERR(srq)) {
+		ret = PTR_ERR(srq);
 		goto out;
 	}
 
@@ -2412,8 +2420,8 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	}
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err;
 	}
 
@@ -2482,8 +2490,8 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp)
-		return -EINVAL;
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
 
 	obj = qp->uobject;
 
@@ -2532,8 +2540,8 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp)
-		return -EINVAL;
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
 
 	obj = qp->uobject;
 	mutex_lock(&obj->mcast_lock);
@@ -2667,8 +2675,8 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 							UVERBS_OBJECT_FLOW_ACTION,
 							kern_spec->action.handle,
 							attrs);
-		if (!ib_spec->action.act)
-			return -EINVAL;
+		if (IS_ERR(ib_spec->action.act))
+			return PTR_ERR(ib_spec->action.act);
 		ib_spec->action.size =
 			sizeof(struct ib_flow_spec_action_handle);
 		flow_resources_add(uflow_res,
@@ -2685,8 +2693,8 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 					  UVERBS_OBJECT_COUNTERS,
 					  kern_spec->flow_count.handle,
 					  attrs);
-		if (!ib_spec->flow_count.counters)
-			return -EINVAL;
+		if (IS_ERR(ib_spec->flow_count.counters))
+			return PTR_ERR(ib_spec->flow_count.counters);
 		ib_spec->flow_count.size =
 				sizeof(struct ib_flow_spec_action_count);
 		flow_resources_add(uflow_res,
@@ -2904,14 +2912,14 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 		return PTR_ERR(obj);
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		err = -EINVAL;
+	if (IS_ERR(pd)) {
+		err = PTR_ERR(pd);
 		goto err_uobj;
 	}
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq) {
-		err = -EINVAL;
+	if (IS_ERR(cq)) {
+		err = PTR_ERR(cq);
 		goto err_put_pd;
 	}
 
@@ -3012,8 +3020,8 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 		return -EINVAL;
 
 	wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ, cmd.wq_handle, attrs);
-	if (!wq)
-		return -EINVAL;
+	if (IS_ERR(wq))
+		return PTR_ERR(wq);
 
 	if (cmd.attr_mask & IB_WQ_FLAGS) {
 		wq_attr.flags = cmd.flags;
@@ -3096,8 +3104,8 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 			num_read_wqs++) {
 		wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ,
 				       wqs_handles[num_read_wqs], attrs);
-		if (!wq) {
-			err = -EINVAL;
+		if (IS_ERR(wq)) {
+			err = PTR_ERR(wq);
 			goto put_wqs;
 		}
 
@@ -3252,8 +3260,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	}
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp) {
-		err = -EINVAL;
+	if (IS_ERR(qp)) {
+		err = PTR_ERR(qp);
 		goto err_uobj;
 	}
 
@@ -3399,15 +3407,15 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	if (ib_srq_has_cq(cmd->srq_type)) {
 		attr.ext.cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
 						cmd->cq_handle, attrs);
-		if (!attr.ext.cq) {
-			ret = -EINVAL;
+		if (IS_ERR(attr.ext.cq)) {
+			ret = PTR_ERR(attr.ext.cq);
 			goto err_put_xrcd;
 		}
 	}
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err_put_cq;
 	}
 
@@ -3514,8 +3522,8 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
-	if (!srq)
-		return -EINVAL;
+	if (IS_ERR(srq))
+		return PTR_ERR(srq);
 
 	attr.max_wr    = cmd.max_wr;
 	attr.srq_limit = cmd.srq_limit;
@@ -3542,8 +3550,8 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
-	if (!srq)
-		return -EINVAL;
+	if (IS_ERR(srq))
+		return PTR_ERR(srq);
 
 	ret = ib_query_srq(srq, &attr);
 
@@ -3668,8 +3676,8 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 		return -EOPNOTSUPP;
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq)
-		return -EINVAL;
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
 
 	ret = rdma_set_cq_moderation(cq, cmd.attr.cq_count, cmd.attr.cq_period);
 
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index b99b3cc283b6..97a116960f31 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2959,22 +2959,23 @@ EXPORT_SYMBOL(__rdma_block_iter_start);
 bool __rdma_block_iter_next(struct ib_block_iter *biter)
 {
 	unsigned int block_offset;
-	unsigned int sg_delta;
+	unsigned int delta;
 
 	if (!biter->__sg_nents || !biter->__sg)
 		return false;
 
 	biter->__dma_addr = sg_dma_address(biter->__sg) + biter->__sg_advance;
 	block_offset = biter->__dma_addr & (BIT_ULL(biter->__pg_bit) - 1);
-	sg_delta = BIT_ULL(biter->__pg_bit) - block_offset;
+	delta = BIT_ULL(biter->__pg_bit) - block_offset;
 
-	if (sg_dma_len(biter->__sg) - biter->__sg_advance > sg_delta) {
-		biter->__sg_advance += sg_delta;
-	} else {
+	while (biter->__sg_nents && biter->__sg &&
+	       sg_dma_len(biter->__sg) - biter->__sg_advance <= delta) {
+		delta -= sg_dma_len(biter->__sg) - biter->__sg_advance;
 		biter->__sg_advance = 0;
 		biter->__sg = sg_next(biter->__sg);
 		biter->__sg_nents--;
 	}
+	biter->__sg_advance += delta;
 
 	return true;
 }
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 232d17bd941f..c86cbbc21e88 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -264,7 +264,7 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 		map_size = get_alloc_page_size(pgsize);
 		pte = v2_alloc_pte(pdom->iop.pgd, iova, map_size, &updated);
 		if (!pte) {
-			ret = -EINVAL;
+			ret = -ENOMEM;
 			goto out;
 		}
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 3fa66dba0a32..cbf9ec320691 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1661,7 +1661,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
 	if (!domain || !domain->iova_cookie) {
-		desc->iommu_cookie = NULL;
+		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
 
@@ -1673,11 +1673,12 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 	mutex_lock(&msi_prepare_lock);
 	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	mutex_unlock(&msi_prepare_lock);
-
-	msi_desc_set_iommu_cookie(desc, msi_page);
-
 	if (!msi_page)
 		return -ENOMEM;
+
+	msi_desc_set_iommu_msi_iova(
+		desc, msi_page->iova,
+		ilog2(cookie_msi_granule(domain->iova_cookie)));
 	return 0;
 }
 
@@ -1688,18 +1689,15 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
  */
 void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
-	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	const struct iommu_dma_msi_page *msi_page;
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	if (desc->iommu_msi_shift) {
+		u64 msi_iova = desc->iommu_msi_iova << desc->iommu_msi_shift;
 
-	msi_page = msi_desc_get_iommu_cookie(desc);
-
-	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
-		return;
-
-	msg->address_hi = upper_32_bits(msi_page->iova);
-	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
-	msg->address_lo += lower_32_bits(msi_page->iova);
+		msg->address_hi = upper_32_bits(msi_iova);
+		msg->address_lo = lower_32_bits(msi_iova) |
+				  (msg->address_lo & ((1 << desc->iommu_msi_shift) - 1));
+	}
+#endif
 }
 
 static int iommu_dma_init(void)
diff --git a/drivers/leds/rgb/leds-pwm-multicolor.c b/drivers/leds/rgb/leds-pwm-multicolor.c
index da9d2218ae18..97aa06e2ff60 100644
--- a/drivers/leds/rgb/leds-pwm-multicolor.c
+++ b/drivers/leds/rgb/leds-pwm-multicolor.c
@@ -135,8 +135,11 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 
 	/* init the multicolor's LED class device */
 	cdev = &priv->mc_cdev.led_cdev;
-	fwnode_property_read_u32(mcnode, "max-brightness",
+	ret = fwnode_property_read_u32(mcnode, "max-brightness",
 				 &cdev->max_brightness);
+	if (ret)
+		goto release_mcnode;
+
 	cdev->flags = LED_CORE_SUSPENDRESUME;
 	cdev->brightness_set_blocking = led_pwm_mc_set;
 
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 4229b9b5da98..6f54501dc776 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -350,11 +350,12 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 
 	mutex_lock(&con_mutex);
 
-	if (of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", index, &spec)) {
+	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
+					 index, &spec);
+	if (ret) {
 		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
 		mutex_unlock(&con_mutex);
-		return ERR_PTR(-ENODEV);
+		return ERR_PTR(ret);
 	}
 
 	chan = ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index e714114d495a..66608b42ee1a 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2875,6 +2875,27 @@ static dm_cblock_t get_cache_dev_size(struct cache *cache)
 	return to_cblock(size);
 }
 
+static bool can_resume(struct cache *cache)
+{
+	/*
+	 * Disallow retrying the resume operation for devices that failed the
+	 * first resume attempt, as the failure leaves the policy object partially
+	 * initialized. Retrying could trigger BUG_ON when loading cache mappings
+	 * into the incomplete policy object.
+	 */
+	if (cache->sized && !cache->loaded_mappings) {
+		if (get_cache_mode(cache) != CM_WRITE)
+			DMERR("%s: unable to resume a failed-loaded cache, please check metadata.",
+			      cache_device_name(cache));
+		else
+			DMERR("%s: unable to resume cache due to missing proper cache table reload",
+			      cache_device_name(cache));
+		return false;
+	}
+
+	return true;
+}
+
 static bool can_resize(struct cache *cache, dm_cblock_t new_size)
 {
 	if (from_cblock(new_size) > from_cblock(cache->cache_size)) {
@@ -2923,6 +2944,9 @@ static int cache_preresume(struct dm_target *ti)
 	struct cache *cache = ti->private;
 	dm_cblock_t csize = get_cache_dev_size(cache);
 
+	if (!can_resume(cache))
+		return -EINVAL;
+
 	/*
 	 * Check to see if the cache has resized.
 	 */
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index a20cf54d12dc..8b23b8bc5a03 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -671,6 +671,10 @@ int dm_table_add_target(struct dm_table *t, const char *type,
 		DMERR("%s: zero-length target", dm_device_name(t->md));
 		return -EINVAL;
 	}
+	if (start + len < start || start + len > LLONG_MAX >> SECTOR_SHIFT) {
+		DMERR("%s: too large device", dm_device_name(t->md));
+		return -EINVAL;
+	}
 
 	ti->type = dm_get_target_type(type);
 	if (!ti->type) {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index f70129bc703b..4767265793de 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1523,14 +1523,18 @@ static void __send_empty_flush(struct clone_info *ci)
 {
 	struct dm_table *t = ci->map;
 	struct bio flush_bio;
+	blk_opf_t opf = REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC;
+
+	if ((ci->io->orig_bio->bi_opf & (REQ_IDLE | REQ_SYNC)) ==
+	    (REQ_IDLE | REQ_SYNC))
+		opf |= REQ_IDLE;
 
 	/*
 	 * Use an on-stack bio for this, it's safe since we don't
 	 * need to reference it after submit. It's just used as
 	 * the basis for the clone(s).
 	 */
-	bio_init(&flush_bio, ci->io->md->disk->part0, NULL, 0,
-		 REQ_OP_WRITE | REQ_PREFLUSH | REQ_SYNC);
+	bio_init(&flush_bio, ci->io->md->disk->part0, NULL, 0, opf);
 
 	ci->bio = &flush_bio;
 	ci->sector_count = 0;
diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
index 216fe396973f..46912a7b671a 100644
--- a/drivers/media/i2c/adv7180.c
+++ b/drivers/media/i2c/adv7180.c
@@ -194,6 +194,7 @@ struct adv7180_state;
 #define ADV7180_FLAG_V2			BIT(1)
 #define ADV7180_FLAG_MIPI_CSI2		BIT(2)
 #define ADV7180_FLAG_I2P		BIT(3)
+#define ADV7180_FLAG_TEST_PATTERN	BIT(4)
 
 struct adv7180_chip_info {
 	unsigned int flags;
@@ -673,11 +674,15 @@ static int adv7180_init_controls(struct adv7180_state *state)
 			  ADV7180_HUE_MAX, 1, ADV7180_HUE_DEF);
 	v4l2_ctrl_new_custom(&state->ctrl_hdl, &adv7180_ctrl_fast_switch, NULL);
 
-	v4l2_ctrl_new_std_menu_items(&state->ctrl_hdl, &adv7180_ctrl_ops,
-				      V4L2_CID_TEST_PATTERN,
-				      ARRAY_SIZE(test_pattern_menu) - 1,
-				      0, ARRAY_SIZE(test_pattern_menu) - 1,
-				      test_pattern_menu);
+	if (state->chip_info->flags & ADV7180_FLAG_TEST_PATTERN) {
+		v4l2_ctrl_new_std_menu_items(&state->ctrl_hdl,
+					     &adv7180_ctrl_ops,
+					     V4L2_CID_TEST_PATTERN,
+					     ARRAY_SIZE(test_pattern_menu) - 1,
+					     0,
+					     ARRAY_SIZE(test_pattern_menu) - 1,
+					     test_pattern_menu);
+	}
 
 	state->sd.ctrl_handler = &state->ctrl_hdl;
 	if (state->ctrl_hdl.error) {
@@ -1209,7 +1214,7 @@ static const struct adv7180_chip_info adv7182_info = {
 };
 
 static const struct adv7180_chip_info adv7280_info = {
-	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_I2P,
+	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_I2P | ADV7180_FLAG_TEST_PATTERN,
 	.valid_input_mask = BIT(ADV7182_INPUT_CVBS_AIN1) |
 		BIT(ADV7182_INPUT_CVBS_AIN2) |
 		BIT(ADV7182_INPUT_CVBS_AIN3) |
@@ -1223,7 +1228,8 @@ static const struct adv7180_chip_info adv7280_info = {
 };
 
 static const struct adv7180_chip_info adv7280_m_info = {
-	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2 | ADV7180_FLAG_I2P,
+	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2 | ADV7180_FLAG_I2P |
+		ADV7180_FLAG_TEST_PATTERN,
 	.valid_input_mask = BIT(ADV7182_INPUT_CVBS_AIN1) |
 		BIT(ADV7182_INPUT_CVBS_AIN2) |
 		BIT(ADV7182_INPUT_CVBS_AIN3) |
@@ -1244,7 +1250,8 @@ static const struct adv7180_chip_info adv7280_m_info = {
 };
 
 static const struct adv7180_chip_info adv7281_info = {
-	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2,
+	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2 |
+		ADV7180_FLAG_TEST_PATTERN,
 	.valid_input_mask = BIT(ADV7182_INPUT_CVBS_AIN1) |
 		BIT(ADV7182_INPUT_CVBS_AIN2) |
 		BIT(ADV7182_INPUT_CVBS_AIN7) |
@@ -1259,7 +1266,8 @@ static const struct adv7180_chip_info adv7281_info = {
 };
 
 static const struct adv7180_chip_info adv7281_m_info = {
-	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2,
+	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2 |
+		ADV7180_FLAG_TEST_PATTERN,
 	.valid_input_mask = BIT(ADV7182_INPUT_CVBS_AIN1) |
 		BIT(ADV7182_INPUT_CVBS_AIN2) |
 		BIT(ADV7182_INPUT_CVBS_AIN3) |
@@ -1279,7 +1287,8 @@ static const struct adv7180_chip_info adv7281_m_info = {
 };
 
 static const struct adv7180_chip_info adv7281_ma_info = {
-	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2,
+	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2 |
+		ADV7180_FLAG_TEST_PATTERN,
 	.valid_input_mask = BIT(ADV7182_INPUT_CVBS_AIN1) |
 		BIT(ADV7182_INPUT_CVBS_AIN2) |
 		BIT(ADV7182_INPUT_CVBS_AIN3) |
@@ -1304,7 +1313,7 @@ static const struct adv7180_chip_info adv7281_ma_info = {
 };
 
 static const struct adv7180_chip_info adv7282_info = {
-	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_I2P,
+	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_I2P | ADV7180_FLAG_TEST_PATTERN,
 	.valid_input_mask = BIT(ADV7182_INPUT_CVBS_AIN1) |
 		BIT(ADV7182_INPUT_CVBS_AIN2) |
 		BIT(ADV7182_INPUT_CVBS_AIN7) |
@@ -1319,7 +1328,8 @@ static const struct adv7180_chip_info adv7282_info = {
 };
 
 static const struct adv7180_chip_info adv7282_m_info = {
-	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2 | ADV7180_FLAG_I2P,
+	.flags = ADV7180_FLAG_V2 | ADV7180_FLAG_MIPI_CSI2 | ADV7180_FLAG_I2P |
+		ADV7180_FLAG_TEST_PATTERN,
 	.valid_input_mask = BIT(ADV7182_INPUT_CVBS_AIN1) |
 		BIT(ADV7182_INPUT_CVBS_AIN2) |
 		BIT(ADV7182_INPUT_CVBS_AIN3) |
diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 6360314f04a6..b90e2e690f3a 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -239,11 +239,13 @@ static int csid_set_stream(struct v4l2_subdev *sd, int enable)
 	int ret;
 
 	if (enable) {
-		ret = v4l2_ctrl_handler_setup(&csid->ctrls);
-		if (ret < 0) {
-			dev_err(csid->camss->dev,
-				"could not sync v4l2 controls: %d\n", ret);
-			return ret;
+		if (csid->testgen.nmodes != CSID_PAYLOAD_MODE_DISABLED) {
+			ret = v4l2_ctrl_handler_setup(&csid->ctrls);
+			if (ret < 0) {
+				dev_err(csid->camss->dev,
+					"could not sync v4l2 controls: %d\n", ret);
+				return ret;
+			}
 		}
 
 		if (!csid->testgen.enabled &&
@@ -318,7 +320,8 @@ static void csid_try_format(struct csid_device *csid,
 		break;
 
 	case MSM_CSID_PAD_SRC:
-		if (csid->testgen_mode->cur.val == 0) {
+		if (csid->testgen.nmodes == CSID_PAYLOAD_MODE_DISABLED ||
+		    csid->testgen_mode->cur.val == 0) {
 			/* Test generator is disabled, */
 			/* keep pad formats in sync */
 			u32 code = fmt->code;
@@ -368,7 +371,8 @@ static int csid_enum_mbus_code(struct v4l2_subdev *sd,
 
 		code->code = csid->formats[code->index].code;
 	} else {
-		if (csid->testgen_mode->cur.val == 0) {
+		if (csid->testgen.nmodes == CSID_PAYLOAD_MODE_DISABLED ||
+		    csid->testgen_mode->cur.val == 0) {
 			struct v4l2_mbus_framefmt *sink_fmt;
 
 			sink_fmt = __csid_get_format(csid, sd_state,
@@ -750,7 +754,8 @@ static int csid_link_setup(struct media_entity *entity,
 
 		/* If test generator is enabled */
 		/* do not allow a link from CSIPHY to CSID */
-		if (csid->testgen_mode->cur.val != 0)
+		if (csid->testgen.nmodes != CSID_PAYLOAD_MODE_DISABLED &&
+		    csid->testgen_mode->cur.val != 0)
 			return -EBUSY;
 
 		sd = media_entity_to_v4l2_subdev(remote->entity);
@@ -843,24 +848,27 @@ int msm_csid_register_entity(struct csid_device *csid,
 		 MSM_CSID_NAME, csid->id);
 	v4l2_set_subdevdata(sd, csid);
 
-	ret = v4l2_ctrl_handler_init(&csid->ctrls, 1);
-	if (ret < 0) {
-		dev_err(dev, "Failed to init ctrl handler: %d\n", ret);
-		return ret;
-	}
+	if (csid->testgen.nmodes != CSID_PAYLOAD_MODE_DISABLED) {
+		ret = v4l2_ctrl_handler_init(&csid->ctrls, 1);
+		if (ret < 0) {
+			dev_err(dev, "Failed to init ctrl handler: %d\n", ret);
+			return ret;
+		}
 
-	csid->testgen_mode = v4l2_ctrl_new_std_menu_items(&csid->ctrls,
-				&csid_ctrl_ops, V4L2_CID_TEST_PATTERN,
-				csid->testgen.nmodes, 0, 0,
-				csid->testgen.modes);
+		csid->testgen_mode =
+			v4l2_ctrl_new_std_menu_items(&csid->ctrls,
+						     &csid_ctrl_ops, V4L2_CID_TEST_PATTERN,
+						     csid->testgen.nmodes, 0, 0,
+						     csid->testgen.modes);
 
-	if (csid->ctrls.error) {
-		dev_err(dev, "Failed to init ctrl: %d\n", csid->ctrls.error);
-		ret = csid->ctrls.error;
-		goto free_ctrl;
-	}
+		if (csid->ctrls.error) {
+			dev_err(dev, "Failed to init ctrl: %d\n", csid->ctrls.error);
+			ret = csid->ctrls.error;
+			goto free_ctrl;
+		}
 
-	csid->subdev.ctrl_handler = &csid->ctrls;
+		csid->subdev.ctrl_handler = &csid->ctrls;
+	}
 
 	ret = csid_init_formats(sd, NULL);
 	if (ret < 0) {
@@ -891,7 +899,8 @@ int msm_csid_register_entity(struct csid_device *csid,
 media_cleanup:
 	media_entity_cleanup(&sd->entity);
 free_ctrl:
-	v4l2_ctrl_handler_free(&csid->ctrls);
+	if (csid->testgen.nmodes != CSID_PAYLOAD_MODE_DISABLED)
+		v4l2_ctrl_handler_free(&csid->ctrls);
 
 	return ret;
 }
@@ -904,5 +913,6 @@ void msm_csid_unregister_entity(struct csid_device *csid)
 {
 	v4l2_device_unregister_subdev(&csid->subdev);
 	media_entity_cleanup(&csid->subdev.entity);
-	v4l2_ctrl_handler_free(&csid->ctrls);
+	if (csid->testgen.nmodes != CSID_PAYLOAD_MODE_DISABLED)
+		v4l2_ctrl_handler_free(&csid->ctrls);
 }
diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index 1dbb89f0ddb8..b2a977f1ec18 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -802,13 +802,12 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 		}
 		tsin->i2c_adapter =
 			of_find_i2c_adapter_by_node(i2c_bus);
+		of_node_put(i2c_bus);
 		if (!tsin->i2c_adapter) {
 			dev_err(&pdev->dev, "No i2c adapter found\n");
-			of_node_put(i2c_bus);
 			ret = -ENODEV;
 			goto err_node_put;
 		}
-		of_node_put(i2c_bus);
 
 		tsin->rst_gpio = of_get_named_gpio(child, "reset-gpios", 0);
 
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
index 690daada7db4..54e6a6772035 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
@@ -894,9 +894,14 @@ static int vivid_thread_vid_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
-		       !kthread_should_stop())
-			schedule();
+		if (!time_is_after_jiffies(cur_jiffies + wait_jiffies))
+			continue;
+
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+		wait_event_interruptible_timeout(wait, kthread_should_stop(),
+					cur_jiffies + wait_jiffies - jiffies);
 	}
 	dprintk(dev, 1, "Video Capture Thread End\n");
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-out.c b/drivers/media/test-drivers/vivid/vivid-kthread-out.c
index 0833e021bb11..8a17a01e6e42 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-out.c
@@ -235,9 +235,14 @@ static int vivid_thread_vid_out(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
-		       !kthread_should_stop())
-			schedule();
+		if (!time_is_after_jiffies(cur_jiffies + wait_jiffies))
+			continue;
+
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+		wait_event_interruptible_timeout(wait, kthread_should_stop(),
+					cur_jiffies + wait_jiffies - jiffies);
 	}
 	dprintk(dev, 1, "Video Output Thread End\n");
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-touch.c b/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
index fa711ee36a3f..c862689786b6 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
@@ -135,9 +135,14 @@ static int vivid_thread_touch_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
-		       !kthread_should_stop())
-			schedule();
+		if (!time_is_after_jiffies(cur_jiffies + wait_jiffies))
+			continue;
+
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+		wait_event_interruptible_timeout(wait, kthread_should_stop(),
+					cur_jiffies + wait_jiffies - jiffies);
 	}
 	dprintk(dev, 1, "Touch Capture Thread End\n");
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-sdr-cap.c b/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
index 0ae5628b86c9..abccd1d0109e 100644
--- a/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
@@ -206,9 +206,14 @@ static int vivid_thread_sdr_cap(void *data)
 			next_jiffies_since_start = jiffies_since_start;
 
 		wait_jiffies = next_jiffies_since_start - jiffies_since_start;
-		while (time_is_after_jiffies(cur_jiffies + wait_jiffies) &&
-		       !kthread_should_stop())
-			schedule();
+		if (!time_is_after_jiffies(cur_jiffies + wait_jiffies))
+			continue;
+
+		wait_queue_head_t wait;
+
+		init_waitqueue_head(&wait);
+		wait_event_interruptible_timeout(wait, kthread_should_stop(),
+					cur_jiffies + wait_jiffies - jiffies);
 	}
 	dprintk(dev, 1, "SDR Capture Thread End\n");
 	return 0;
diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index c5e21785fafe..02343e88cc61 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1722,6 +1722,8 @@ static void cx231xx_video_dev_init(
 	vfd->lock = &dev->lock;
 	vfd->release = video_device_release_empty;
 	vfd->ctrl_handler = &dev->mpeg_ctrl_handler.hdl;
+	vfd->device_caps = V4L2_CAP_READWRITE | V4L2_CAP_STREAMING |
+			   V4L2_CAP_VIDEO_CAPTURE;
 	video_set_drvdata(vfd, dev);
 	if (dev->tuner_type == TUNER_ABSENT) {
 		v4l2_disable_ioctl(vfd, VIDIOC_G_FREQUENCY);
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index bd4677a6e653..0aaa4fce61da 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -36,6 +36,12 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 	unsigned int size;
 	int ret;
 
+	if (xmap->data_type > UVC_CTRL_DATA_TYPE_BITMASK) {
+		uvc_dbg(chain->dev, CONTROL,
+			"Unsupported UVC data type %u\n", xmap->data_type);
+		return -EINVAL;
+	}
+
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (map == NULL)
 		return -ENOMEM;
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 9f20ac524c8b..2a5c3c822f6a 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -28,6 +28,8 @@ enum dw_mci_exynos_type {
 	DW_MCI_TYPE_EXYNOS5420_SMU,
 	DW_MCI_TYPE_EXYNOS7,
 	DW_MCI_TYPE_EXYNOS7_SMU,
+	DW_MCI_TYPE_EXYNOS7870,
+	DW_MCI_TYPE_EXYNOS7870_SMU,
 	DW_MCI_TYPE_ARTPEC8,
 };
 
@@ -70,6 +72,12 @@ static struct dw_mci_exynos_compatible {
 	}, {
 		.compatible	= "samsung,exynos7-dw-mshc-smu",
 		.ctrl_type	= DW_MCI_TYPE_EXYNOS7_SMU,
+	}, {
+		.compatible	= "samsung,exynos7870-dw-mshc",
+		.ctrl_type	= DW_MCI_TYPE_EXYNOS7870,
+	}, {
+		.compatible	= "samsung,exynos7870-dw-mshc-smu",
+		.ctrl_type	= DW_MCI_TYPE_EXYNOS7870_SMU,
 	}, {
 		.compatible	= "axis,artpec8-dw-mshc",
 		.ctrl_type	= DW_MCI_TYPE_ARTPEC8,
@@ -86,6 +94,8 @@ static inline u8 dw_mci_exynos_get_ciu_div(struct dw_mci *host)
 		return EXYNOS4210_FIXED_CIU_CLK_DIV;
 	else if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 			priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL64)) + 1;
 	else
@@ -101,7 +111,8 @@ static void dw_mci_exynos_config_smu(struct dw_mci *host)
 	 * set for non-ecryption mode at this time.
 	 */
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU ||
-		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU) {
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU) {
 		mci_writel(host, MPSBEGIN0, 0);
 		mci_writel(host, MPSEND0, SDMMC_ENDING_SEC_NR_MAX);
 		mci_writel(host, MPSCTRL0, SDMMC_MPSCTRL_SECURE_WRITE_BIT |
@@ -127,6 +138,12 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
 				DQS_CTRL_GET_RD_DELAY(priv->saved_strobe_ctrl);
 	}
 
+	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU) {
+		/* Quirk needed for certain Exynos SoCs */
+		host->quirks |= DW_MMC_QUIRK_FIFO64_32;
+	}
+
 	if (priv->ctrl_type == DW_MCI_TYPE_ARTPEC8) {
 		/* Quirk needed for the ARTPEC-8 SoC */
 		host->quirks |= DW_MMC_QUIRK_EXTENDED_TMOUT;
@@ -144,6 +161,8 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		clksel = mci_readl(host, CLKSEL64);
 	else
@@ -153,6 +172,8 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		mci_writel(host, CLKSEL64, clksel);
 	else
@@ -223,6 +244,8 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		clksel = mci_readl(host, CLKSEL64);
 	else
@@ -231,6 +254,8 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
 	if (clksel & SDMMC_CLKSEL_WAKEUP_INT) {
 		if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+			priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 			priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 			mci_writel(host, CLKSEL64, clksel);
 		else
@@ -410,6 +435,8 @@ static inline u8 dw_mci_exynos_get_clksmpl(struct dw_mci *host)
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		return SDMMC_CLKSEL_CCLK_SAMPLE(mci_readl(host, CLKSEL64));
 	else
@@ -423,6 +450,8 @@ static inline void dw_mci_exynos_set_clksmpl(struct dw_mci *host, u8 sample)
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		clksel = mci_readl(host, CLKSEL64);
 	else
@@ -430,6 +459,8 @@ static inline void dw_mci_exynos_set_clksmpl(struct dw_mci *host, u8 sample)
 	clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		mci_writel(host, CLKSEL64, clksel);
 	else
@@ -444,6 +475,8 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		clksel = mci_readl(host, CLKSEL64);
 	else
@@ -454,6 +487,8 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
 
 	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
 		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7_SMU ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870 ||
+		priv->ctrl_type == DW_MCI_TYPE_EXYNOS7870_SMU ||
 		priv->ctrl_type == DW_MCI_TYPE_ARTPEC8)
 		mci_writel(host, CLKSEL64, clksel);
 	else
@@ -633,6 +668,10 @@ static const struct of_device_id dw_mci_exynos_match[] = {
 			.data = &exynos_drv_data, },
 	{ .compatible = "samsung,exynos7-dw-mshc-smu",
 			.data = &exynos_drv_data, },
+	{ .compatible = "samsung,exynos7870-dw-mshc",
+			.data = &exynos_drv_data, },
+	{ .compatible = "samsung,exynos7870-dw-mshc-smu",
+			.data = &exynos_drv_data, },
 	{ .compatible = "axis,artpec8-dw-mshc",
 			.data = &artpec_drv_data, },
 	{},
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5a5cc40d4bc3..c71d9956b398 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -613,8 +613,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 
 	sdhci_set_power(host, mode, vdd);
 
-	if (mode == MMC_POWER_OFF)
+	if (mode == MMC_POWER_OFF) {
+		if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
+		    slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
+			usleep_range(15000, 17500);
 		return;
+	}
 
 	/*
 	 * Bus power might not enable after D3 -> D0 transition due to the
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 536d21028a11..6822a3249286 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2049,10 +2049,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	host->mmc->actual_clock = 0;
 
-	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (clk & SDHCI_CLOCK_CARD_EN)
+		sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
+			SDHCI_CLOCK_CONTROL);
 
-	if (clock == 0)
+	if (clock == 0) {
+		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 		return;
+	}
 
 	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
 	sdhci_enable_clk(host, clk);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ded9e369e403..3cedadef9c8a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2431,7 +2431,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
 
-	if (!all && (!bond->params.fail_over_mac ||
+	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
 		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
 		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
 		    bond_has_slaves(bond))
diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index c5d7093d5413..c29862b3bb1f 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -334,7 +334,7 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		/* Check if we need custom RAMINIT via syscon. Mostly for TI
 		 * platforms. Only supported with DT boot.
 		 */
-		if (np && of_property_read_bool(np, "syscon-raminit")) {
+		if (np && of_property_present(np, "syscon-raminit")) {
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index f4db77007c13..982637f8ea2f 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -71,12 +71,21 @@ MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
 #define SLCAN_CMD_LEN 1
 #define SLCAN_SFF_ID_LEN 3
 #define SLCAN_EFF_ID_LEN 8
+#define SLCAN_DATA_LENGTH_LEN 1
+#define SLCAN_ERROR_LEN 1
 #define SLCAN_STATE_LEN 1
 #define SLCAN_STATE_BE_RXCNT_LEN 3
 #define SLCAN_STATE_BE_TXCNT_LEN 3
-#define SLCAN_STATE_FRAME_LEN       (1 + SLCAN_CMD_LEN + \
-				     SLCAN_STATE_BE_RXCNT_LEN + \
-				     SLCAN_STATE_BE_TXCNT_LEN)
+#define SLCAN_STATE_MSG_LEN     (SLCAN_CMD_LEN +		\
+                                 SLCAN_STATE_LEN +		\
+                                 SLCAN_STATE_BE_RXCNT_LEN +	\
+                                 SLCAN_STATE_BE_TXCNT_LEN)
+#define SLCAN_ERROR_MSG_LEN_MIN (SLCAN_CMD_LEN +	\
+                                 SLCAN_ERROR_LEN +	\
+                                 SLCAN_DATA_LENGTH_LEN)
+#define SLCAN_FRAME_MSG_LEN_MIN (SLCAN_CMD_LEN +	\
+                                 SLCAN_SFF_ID_LEN +	\
+                                 SLCAN_DATA_LENGTH_LEN)
 struct slcan {
 	struct can_priv         can;
 
@@ -176,6 +185,9 @@ static void slcan_bump_frame(struct slcan *sl)
 	u32 tmpid;
 	char *cmd = sl->rbuff;
 
+	if (sl->rcount < SLCAN_FRAME_MSG_LEN_MIN)
+		return;
+
 	skb = alloc_can_skb(sl->dev, &cf);
 	if (unlikely(!skb)) {
 		sl->dev->stats.rx_dropped++;
@@ -281,7 +293,7 @@ static void slcan_bump_state(struct slcan *sl)
 		return;
 	}
 
-	if (state == sl->can.state || sl->rcount < SLCAN_STATE_FRAME_LEN)
+	if (state == sl->can.state || sl->rcount != SLCAN_STATE_MSG_LEN)
 		return;
 
 	cmd += SLCAN_STATE_BE_RXCNT_LEN + SLCAN_CMD_LEN + 1;
@@ -328,6 +340,9 @@ static void slcan_bump_err(struct slcan *sl)
 	bool rx_errors = false, tx_errors = false, rx_over_errors = false;
 	int i, len;
 
+	if (sl->rcount < SLCAN_ERROR_MSG_LEN_MIN)
+		return;
+
 	/* get len from sanitized ASCII value */
 	len = cmd[1];
 	if (len >= '0' && len < '9')
@@ -456,8 +471,7 @@ static void slcan_bump(struct slcan *sl)
 static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
-		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    sl->rcount > 4)
+		if (!test_and_clear_bit(SLF_ERROR, &sl->flags))
 			slcan_bump(sl);
 
 		sl->rcount = 0;
diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 379d19d18dbe..5808e3c73a8f 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -9,8 +9,6 @@
 
 #include "main.h"
 
-static const struct acpi_device_id xge_acpi_match[];
-
 static int xge_get_resources(struct xge_pdata *pdata)
 {
 	struct platform_device *pdev;
@@ -733,7 +731,7 @@ MODULE_DEVICE_TABLE(acpi, xge_acpi_match);
 static struct platform_driver xge_driver = {
 	.driver = {
 		   .name = "xgene-enet-v2",
-		   .acpi_match_table = ACPI_PTR(xge_acpi_match),
+		   .acpi_match_table = xge_acpi_match,
 	},
 	.probe = xge_probe,
 	.remove = xge_remove,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 230b317d93da..bf49c07c8b51 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1536,6 +1536,16 @@ static void enetc_xdp_drop(struct enetc_bdr *rx_ring, int rx_ring_first,
 	}
 }
 
+static void enetc_bulk_flip_buff(struct enetc_bdr *rx_ring, int rx_ring_first,
+				 int rx_ring_last)
+{
+	while (rx_ring_first != rx_ring_last) {
+		enetc_flip_rx_buff(rx_ring,
+				   &rx_ring->rx_swbd[rx_ring_first]);
+		enetc_bdr_idx_inc(rx_ring, &rx_ring_first);
+	}
+}
+
 static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				   struct napi_struct *napi, int work_limit,
 				   struct bpf_prog *prog)
@@ -1659,11 +1669,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				enetc_xdp_drop(rx_ring, orig_i, i);
 				rx_ring->stats.xdp_redirect_failures++;
 			} else {
-				while (orig_i != i) {
-					enetc_flip_rx_buff(rx_ring,
-							   &rx_ring->rx_swbd[orig_i]);
-					enetc_bdr_idx_inc(rx_ring, &orig_i);
-				}
+				enetc_bulk_flip_buff(rx_ring, orig_i, i);
 				xdp_redirect_frm_cnt++;
 				rx_ring->stats.xdp_redirect++;
 			}
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a163e7717a53..1f62d1183156 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3373,8 +3373,7 @@ static u32 ice_get_combined_cnt(struct ice_vsi *vsi)
 	ice_for_each_q_vector(vsi, q_idx) {
 		struct ice_q_vector *q_vector = vsi->q_vectors[q_idx];
 
-		if (q_vector->rx.rx_ring && q_vector->tx.tx_ring)
-			combined++;
+		combined += min(q_vector->num_ring_tx, q_vector->num_ring_rx);
 	}
 
 	return combined;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 42d8e5e771b7..fa9d928081d6 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3551,7 +3551,6 @@ static int ice_vc_repr_add_mac(struct ice_vf *vf, u8 *msg)
 		}
 
 		ice_vfhw_mac_add(vf, &al->list[i]);
-		vf->num_mac++;
 		break;
 	}
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
index 993ac180a5db..a32d85d6f599 100644
--- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
+++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
@@ -32,6 +32,7 @@ config OCTEONTX2_PF
 	tristate "Marvell OcteonTX2 NIC Physical Function driver"
 	select OCTEONTX2_MBOX
 	select NET_DEVLINK
+	select PAGE_POOL
 	depends on (64BIT && COMPILE_TEST) || ARM64
 	select DIMLIB
 	depends on PCI
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
index f9faa5b23bb9..5cd45846237e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cn10k.c
@@ -13,19 +13,26 @@
 /* RVU LMTST */
 #define LMT_TBL_OP_READ		0
 #define LMT_TBL_OP_WRITE	1
-#define LMT_MAP_TABLE_SIZE	(128 * 1024)
 #define LMT_MAPTBL_ENTRY_SIZE	16
+#define LMT_MAX_VFS		256
+
+#define LMT_MAP_ENTRY_ENA      BIT_ULL(20)
+#define LMT_MAP_ENTRY_LINES    GENMASK_ULL(18, 16)
 
 /* Function to perform operations (read/write) on lmtst map table */
 static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 			       int lmt_tbl_op)
 {
 	void __iomem *lmt_map_base;
-	u64 tbl_base;
+	u64 tbl_base, cfg;
+	int pfs, vfs;
 
 	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
+	cfg  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
+	vfs = 1 << (cfg & 0xF);
+	pfs = 1 << ((cfg >> 4) & 0x7);
 
-	lmt_map_base = ioremap_wc(tbl_base, LMT_MAP_TABLE_SIZE);
+	lmt_map_base = ioremap_wc(tbl_base, pfs * vfs * LMT_MAPTBL_ENTRY_SIZE);
 	if (!lmt_map_base) {
 		dev_err(rvu->dev, "Failed to setup lmt map table mapping!!\n");
 		return -ENOMEM;
@@ -35,6 +42,13 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 		*val = readq(lmt_map_base + index);
 	} else {
 		writeq((*val), (lmt_map_base + index));
+
+		cfg = FIELD_PREP(LMT_MAP_ENTRY_ENA, 0x1);
+		/* 2048 LMTLINES */
+		cfg |= FIELD_PREP(LMT_MAP_ENTRY_LINES, 0x6);
+
+		writeq(cfg, (lmt_map_base + (index + 8)));
+
 		/* Flushing the AP interceptor cache to make APR_LMT_MAP_ENTRY_S
 		 * changes effective. Write 1 for flush and read is being used as a
 		 * barrier and sets up a data dependency. Write to 0 after a write
@@ -52,7 +66,7 @@ static int lmtst_map_table_ops(struct rvu *rvu, u32 index, u64 *val,
 #define LMT_MAP_TBL_W1_OFF  8
 static u32 rvu_get_lmtst_tbl_index(struct rvu *rvu, u16 pcifunc)
 {
-	return ((rvu_get_pf(pcifunc) * rvu->hw->total_vfs) +
+	return ((rvu_get_pf(pcifunc) * LMT_MAX_VFS) +
 		(pcifunc & RVU_PFVF_FUNC_MASK)) * LMT_MAPTBL_ENTRY_SIZE;
 }
 
@@ -69,7 +83,7 @@ static int rvu_get_lmtaddr(struct rvu *rvu, u16 pcifunc,
 
 	mutex_lock(&rvu->rsrc_lock);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_ADDR_REQ, iova);
-	pf = rvu_get_pf(pcifunc) & 0x1F;
+	pf = rvu_get_pf(pcifunc) & RVU_PFVF_PF_MASK;
 	val = BIT_ULL(63) | BIT_ULL(14) | BIT_ULL(13) | pf << 8 |
 	      ((pcifunc & RVU_PFVF_FUNC_MASK) & 0xFF);
 	rvu_write64(rvu, BLKADDR_RVUM, RVU_AF_SMMU_TXN_REQ, val);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index a3c1d82032f5..aa2ab987eb75 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -580,6 +580,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 	u64 lmt_addr, val, tbl_base;
 	int pf, vf, num_vfs, hw_vfs;
 	void __iomem *lmt_map_base;
+	int apr_pfs, apr_vfs;
 	int buf_size = 10240;
 	size_t off = 0;
 	int index = 0;
@@ -595,8 +596,12 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 		return -ENOMEM;
 
 	tbl_base = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_MAP_BASE);
+	val  = rvu_read64(rvu, BLKADDR_APR, APR_AF_LMT_CFG);
+	apr_vfs = 1 << (val & 0xF);
+	apr_pfs = 1 << ((val >> 4) & 0x7);
 
-	lmt_map_base = ioremap_wc(tbl_base, 128 * 1024);
+	lmt_map_base = ioremap_wc(tbl_base, apr_pfs * apr_vfs *
+				  LMT_MAPTBL_ENTRY_SIZE);
 	if (!lmt_map_base) {
 		dev_err(rvu->dev, "Failed to setup lmt map table mapping!!\n");
 		kfree(buf);
@@ -618,7 +623,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 		off += scnprintf(&buf[off], buf_size - 1 - off, "PF%d  \t\t\t",
 				    pf);
 
-		index = pf * rvu->hw->total_vfs * LMT_MAPTBL_ENTRY_SIZE;
+		index = pf * apr_vfs * LMT_MAPTBL_ENTRY_SIZE;
 		off += scnprintf(&buf[off], buf_size - 1 - off, " 0x%llx\t\t",
 				 (tbl_base + index));
 		lmt_addr = readq(lmt_map_base + index);
@@ -631,7 +636,7 @@ static ssize_t rvu_dbg_lmtst_map_table_display(struct file *filp,
 		/* Reading num of VFs per PF */
 		rvu_get_pf_numvfs(rvu, pf, &num_vfs, &hw_vfs);
 		for (vf = 0; vf < num_vfs; vf++) {
-			index = (pf * rvu->hw->total_vfs * 16) +
+			index = (pf * apr_vfs * LMT_MAPTBL_ENTRY_SIZE) +
 				((vf + 1)  * LMT_MAPTBL_ENTRY_SIZE);
 			off += scnprintf(&buf[off], buf_size - 1 - off,
 					    "PF%d:VF%d  \t\t", pf, vf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index 8663bdf014d8..7417087b6db5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -107,12 +107,13 @@ int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
 }
 
 #define NPA_MAX_BURST 16
-void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
+int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 {
 	struct otx2_nic *pfvf = dev;
+	int cnt = cq->pool_ptrs;
 	u64 ptrs[NPA_MAX_BURST];
-	int num_ptrs = 1;
 	dma_addr_t bufptr;
+	int num_ptrs = 1;
 
 	/* Refill pool with new buffers */
 	while (cq->pool_ptrs) {
@@ -131,6 +132,7 @@ void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 			num_ptrs = 1;
 		}
 	}
+	return cnt - cq->pool_ptrs;
 }
 
 void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq, int size, int qidx)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
index 8ae96815865e..c1861f7de254 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
@@ -24,7 +24,7 @@ static inline int mtu_to_dwrr_weight(struct otx2_nic *pfvf, int mtu)
 	return weight;
 }
 
-void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
+int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
 void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq, int size, int qidx);
 int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
 int cn10k_lmtst_init(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index d05f91f97a9a..4fc73ac721b0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -513,11 +513,32 @@ void otx2_config_irq_coalescing(struct otx2_nic *pfvf, int qidx)
 		     (pfvf->hw.cq_ecount_wait - 1));
 }
 
+static int otx2_alloc_pool_buf(struct otx2_nic *pfvf, struct otx2_pool *pool,
+			       dma_addr_t *dma)
+{
+	unsigned int offset = 0;
+	struct page *page;
+	size_t sz;
+
+	sz = SKB_DATA_ALIGN(pool->rbsize);
+	sz = ALIGN(sz, OTX2_ALIGN);
+
+	page = page_pool_alloc_frag(pool->page_pool, &offset, sz, GFP_ATOMIC);
+	if (unlikely(!page))
+		return -ENOMEM;
+
+	*dma = page_pool_get_dma_addr(page) + offset;
+	return 0;
+}
+
 static int __otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 			     dma_addr_t *dma)
 {
 	u8 *buf;
 
+	if (pool->page_pool)
+		return otx2_alloc_pool_buf(pfvf, pool, dma);
+
 	buf = napi_alloc_frag_align(pool->rbsize, OTX2_ALIGN);
 	if (unlikely(!buf))
 		return -ENOMEM;
@@ -546,20 +567,8 @@ int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 int otx2_alloc_buffer(struct otx2_nic *pfvf, struct otx2_cq_queue *cq,
 		      dma_addr_t *dma)
 {
-	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma))) {
-		struct refill_work *work;
-		struct delayed_work *dwork;
-
-		work = &pfvf->refill_wrk[cq->cq_idx];
-		dwork = &work->pool_refill_work;
-		/* Schedule a task if no other task is running */
-		if (!cq->refill_task_sched) {
-			cq->refill_task_sched = true;
-			schedule_delayed_work(dwork,
-					      msecs_to_jiffies(100));
-		}
+	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma)))
 		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -967,6 +976,7 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 	int err, pool_id, non_xdp_queues;
 	struct nix_aq_enq_req *aq;
 	struct otx2_cq_queue *cq;
+	struct otx2_pool *pool;
 
 	cq = &qset->cq[qidx];
 	cq->cq_idx = qidx;
@@ -975,8 +985,13 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 		cq->cq_type = CQ_RX;
 		cq->cint_idx = qidx;
 		cq->cqe_cnt = qset->rqe_cnt;
-		if (pfvf->xdp_prog)
+		if (pfvf->xdp_prog) {
+			pool = &qset->pool[qidx];
 			xdp_rxq_info_reg(&cq->xdp_rxq, pfvf->netdev, qidx, 0);
+			xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
+						   MEM_TYPE_PAGE_POOL,
+						   pool->page_pool);
+		}
 	} else if (qidx < non_xdp_queues) {
 		cq->cq_type = CQ_TX;
 		cq->cint_idx = qidx - pfvf->hw.rx_queues;
@@ -1054,39 +1069,20 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 static void otx2_pool_refill_task(struct work_struct *work)
 {
 	struct otx2_cq_queue *cq;
-	struct otx2_pool *rbpool;
 	struct refill_work *wrk;
-	int qidx, free_ptrs = 0;
 	struct otx2_nic *pfvf;
-	dma_addr_t bufptr;
+	int qidx;
 
 	wrk = container_of(work, struct refill_work, pool_refill_work.work);
 	pfvf = wrk->pf;
 	qidx = wrk - pfvf->refill_wrk;
 	cq = &pfvf->qset.cq[qidx];
-	rbpool = cq->rbpool;
-	free_ptrs = cq->pool_ptrs;
 
-	while (cq->pool_ptrs) {
-		if (otx2_alloc_rbuf(pfvf, rbpool, &bufptr)) {
-			/* Schedule a WQ if we fails to free atleast half of the
-			 * pointers else enable napi for this RQ.
-			 */
-			if (!((free_ptrs - cq->pool_ptrs) > free_ptrs / 2)) {
-				struct delayed_work *dwork;
-
-				dwork = &wrk->pool_refill_work;
-				schedule_delayed_work(dwork,
-						      msecs_to_jiffies(100));
-			} else {
-				cq->refill_task_sched = false;
-			}
-			return;
-		}
-		pfvf->hw_ops->aura_freeptr(pfvf, qidx, bufptr + OTX2_HEAD_ROOM);
-		cq->pool_ptrs--;
-	}
 	cq->refill_task_sched = false;
+
+	local_bh_disable();
+	napi_schedule(wrk->napi);
+	local_bh_enable();
 }
 
 int otx2_config_nix_queues(struct otx2_nic *pfvf)
@@ -1206,10 +1202,31 @@ void otx2_sq_free_sqbs(struct otx2_nic *pfvf)
 	}
 }
 
+void otx2_free_bufs(struct otx2_nic *pfvf, struct otx2_pool *pool,
+		    u64 iova, int size)
+{
+	struct page *page;
+	u64 pa;
+
+	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
+	page = virt_to_head_page(phys_to_virt(pa));
+
+	if (pool->page_pool) {
+		page_pool_put_full_page(pool->page_pool, page, true);
+	} else {
+		dma_unmap_page_attrs(pfvf->dev, iova, size,
+				     DMA_FROM_DEVICE,
+				     DMA_ATTR_SKIP_CPU_SYNC);
+
+		put_page(page);
+	}
+}
+
 void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
 {
 	int pool_id, pool_start = 0, pool_end = 0, size = 0;
-	u64 iova, pa;
+	struct otx2_pool *pool;
+	u64 iova;
 
 	if (type == AURA_NIX_SQ) {
 		pool_start = otx2_get_pool_idx(pfvf, type, 0);
@@ -1225,15 +1242,13 @@ void otx2_free_aura_ptr(struct otx2_nic *pfvf, int type)
 	/* Free SQB and RQB pointers from the aura pool */
 	for (pool_id = pool_start; pool_id < pool_end; pool_id++) {
 		iova = otx2_aura_allocptr(pfvf, pool_id);
+		pool = &pfvf->qset.pool[pool_id];
 		while (iova) {
 			if (type == AURA_NIX_RQ)
 				iova -= OTX2_HEAD_ROOM;
 
-			pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
-			dma_unmap_page_attrs(pfvf->dev, iova, size,
-					     DMA_FROM_DEVICE,
-					     DMA_ATTR_SKIP_CPU_SYNC);
-			put_page(virt_to_page(phys_to_virt(pa)));
+			otx2_free_bufs(pfvf, pool, iova, size);
+
 			iova = otx2_aura_allocptr(pfvf, pool_id);
 		}
 	}
@@ -1251,6 +1266,8 @@ void otx2_aura_pool_free(struct otx2_nic *pfvf)
 		pool = &pfvf->qset.pool[pool_id];
 		qmem_free(pfvf->dev, pool->stack);
 		qmem_free(pfvf->dev, pool->fc_addr);
+		page_pool_destroy(pool->page_pool);
+		pool->page_pool = NULL;
 	}
 	devm_kfree(pfvf->dev, pfvf->qset.pool);
 	pfvf->qset.pool = NULL;
@@ -1334,8 +1351,9 @@ int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
 }
 
 int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
-		   int stack_pages, int numptrs, int buf_size)
+		   int stack_pages, int numptrs, int buf_size, int type)
 {
+	struct page_pool_params pp_params = { 0 };
 	struct npa_aq_enq_req *aq;
 	struct otx2_pool *pool;
 	int err;
@@ -1379,6 +1397,23 @@ int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
 	aq->ctype = NPA_AQ_CTYPE_POOL;
 	aq->op = NPA_AQ_INSTOP_INIT;
 
+	if (type != AURA_NIX_RQ) {
+		pool->page_pool = NULL;
+		return 0;
+	}
+
+	pp_params.order = get_order(buf_size);
+	pp_params.flags = PP_FLAG_PAGE_FRAG | PP_FLAG_DMA_MAP;
+	pp_params.pool_size = min(OTX2_PAGE_POOL_SZ, numptrs);
+	pp_params.nid = NUMA_NO_NODE;
+	pp_params.dev = pfvf->dev;
+	pp_params.dma_dir = DMA_FROM_DEVICE;
+	pool->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(pool->page_pool)) {
+		netdev_err(pfvf->netdev, "Creation of page pool failed\n");
+		return PTR_ERR(pool->page_pool);
+	}
+
 	return 0;
 }
 
@@ -1413,7 +1448,7 @@ int otx2_sq_aura_pool_init(struct otx2_nic *pfvf)
 
 		/* Initialize pool context */
 		err = otx2_pool_init(pfvf, pool_id, stack_pages,
-				     num_sqbs, hw->sqb_size);
+				     num_sqbs, hw->sqb_size, AURA_NIX_SQ);
 		if (err)
 			goto fail;
 	}
@@ -1476,7 +1511,7 @@ int otx2_rq_aura_pool_init(struct otx2_nic *pfvf)
 	}
 	for (pool_id = 0; pool_id < hw->rqpool_cnt; pool_id++) {
 		err = otx2_pool_init(pfvf, pool_id, stack_pages,
-				     num_ptrs, pfvf->rbsize);
+				     num_ptrs, pfvf->rbsize, AURA_NIX_RQ);
 		if (err)
 			goto fail;
 	}
@@ -1660,7 +1695,6 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable)
 	req->bpid_per_chan = 0;
 #endif
 
-
 	return otx2_sync_mbox_msg(&pfvf->mbox);
 }
 EXPORT_SYMBOL(otx2_nix_config_bp);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index c15d1864a637..1d3c4180d341 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -280,6 +280,7 @@ struct flr_work {
 struct refill_work {
 	struct delayed_work pool_refill_work;
 	struct otx2_nic *pf;
+	struct napi_struct *napi;
 };
 
 /* PTPv2 originTimestamp structure */
@@ -347,7 +348,7 @@ struct dev_hw_ops {
 	int	(*sq_aq_init)(void *dev, u16 qidx, u16 sqb_aura);
 	void	(*sqe_flush)(void *dev, struct otx2_snd_queue *sq,
 			     int size, int qidx);
-	void	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
+	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
 };
 
@@ -934,7 +935,7 @@ int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 int otx2_rxtx_enable(struct otx2_nic *pfvf, bool enable);
 void otx2_ctx_disable(struct mbox *mbox, int type, bool npa);
 int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable);
-void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq);
+void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq, int qidx);
 void otx2_cleanup_tx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq);
 int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura);
 int otx2_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
@@ -942,7 +943,7 @@ int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
 int otx2_alloc_buffer(struct otx2_nic *pfvf, struct otx2_cq_queue *cq,
 		      dma_addr_t *dma);
 int otx2_pool_init(struct otx2_nic *pfvf, u16 pool_id,
-		   int stack_pages, int numptrs, int buf_size);
+		   int stack_pages, int numptrs, int buf_size, int type);
 int otx2_aura_init(struct otx2_nic *pfvf, int aura_id,
 		   int pool_id, int numptrs);
 
@@ -1012,6 +1013,8 @@ u16 otx2_get_max_mtu(struct otx2_nic *pfvf);
 int otx2_handle_ntuple_tc_features(struct net_device *netdev,
 				   netdev_features_t features);
 int otx2_smq_flush(struct otx2_nic *pfvf, int smq);
+void otx2_free_bufs(struct otx2_nic *pfvf, struct otx2_pool *pool,
+		    u64 iova, int size);
 
 /* tc support */
 int otx2_init_tc(struct otx2_nic *nic);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6b7fb324e756..c29cb56caf08 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1591,7 +1591,9 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	struct nix_lf_free_req *free_req;
 	struct mbox *mbox = &pf->mbox;
 	struct otx2_cq_queue *cq;
+	struct otx2_pool *pool;
 	struct msg_req *req;
+	int pool_id;
 	int qidx;
 
 	/* Ensure all SQE are processed */
@@ -1618,7 +1620,7 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	for (qidx = 0; qidx < qset->cq_cnt; qidx++) {
 		cq = &qset->cq[qidx];
 		if (cq->cq_type == CQ_RX)
-			otx2_cleanup_rx_cqes(pf, cq);
+			otx2_cleanup_rx_cqes(pf, cq, qidx);
 		else
 			otx2_cleanup_tx_cqes(pf, cq);
 	}
@@ -1629,6 +1631,13 @@ static void otx2_free_hw_resources(struct otx2_nic *pf)
 	/* Free RQ buffer pointers*/
 	otx2_free_aura_ptr(pf, AURA_NIX_RQ);
 
+	for (qidx = 0; qidx < pf->hw.rx_queues; qidx++) {
+		pool_id = otx2_get_pool_idx(pf, AURA_NIX_RQ, qidx);
+		pool = &pf->qset.pool[pool_id];
+		page_pool_destroy(pool->page_pool);
+		pool->page_pool = NULL;
+	}
+
 	otx2_free_cq_res(pf);
 
 	/* Free all ingress bandwidth profiles allocated */
@@ -1996,6 +2005,10 @@ int otx2_stop(struct net_device *netdev)
 
 	netif_tx_disable(netdev);
 
+	for (wrk = 0; wrk < pf->qset.cq_cnt; wrk++)
+		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
+	devm_kfree(pf->dev, pf->refill_wrk);
+
 	otx2_free_hw_resources(pf);
 	otx2_free_cints(pf, pf->hw.cint_cnt);
 	otx2_disable_napi(pf);
@@ -2003,9 +2016,6 @@ int otx2_stop(struct net_device *netdev)
 	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
 
-	for (wrk = 0; wrk < pf->qset.cq_cnt; wrk++)
-		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
-	devm_kfree(pf->dev, pf->refill_wrk);
 
 	kfree(qset->sq);
 	kfree(qset->cq);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index e579183e5239..31caf7a7a3ad 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -218,9 +218,6 @@ static bool otx2_skb_add_frag(struct otx2_nic *pfvf, struct sk_buff *skb,
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 				va - page_address(page) + off,
 				len - off, pfvf->rbsize);
-
-		otx2_dma_unmap_page(pfvf, iova - OTX2_HEAD_ROOM,
-				    pfvf->rbsize, DMA_FROM_DEVICE);
 		return true;
 	}
 
@@ -383,6 +380,8 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	if (pfvf->netdev->features & NETIF_F_RXCSUM)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
+	skb_mark_for_recycle(skb);
+
 	napi_gro_frags(napi);
 }
 
@@ -429,9 +428,10 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
 	return processed_cqe;
 }
 
-void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
+int otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 {
 	struct otx2_nic *pfvf = dev;
+	int cnt = cq->pool_ptrs;
 	dma_addr_t bufptr;
 
 	while (cq->pool_ptrs) {
@@ -440,6 +440,8 @@ void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 		otx2_aura_freeptr(pfvf, cq->cq_idx, bufptr + OTX2_HEAD_ROOM);
 		cq->pool_ptrs--;
 	}
+
+	return cnt - cq->pool_ptrs;
 }
 
 static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
@@ -533,6 +535,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	struct otx2_cq_queue *cq;
 	struct otx2_qset *qset;
 	struct otx2_nic *pfvf;
+	int filled_cnt = -1;
 
 	cq_poll = container_of(napi, struct otx2_cq_poll, napi);
 	pfvf = (struct otx2_nic *)cq_poll->dev;
@@ -553,7 +556,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	}
 
 	if (rx_cq && rx_cq->pool_ptrs)
-		pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
+		filled_cnt = pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
 	/* Clear the IRQ */
 	otx2_write64(pfvf, NIX_LF_CINTX_INT(cq_poll->cint_idx), BIT_ULL(0));
 
@@ -566,9 +569,25 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 		if (pfvf->flags & OTX2_FLAG_ADPTV_INT_COAL_ENABLED)
 			otx2_adjust_adaptive_coalese(pfvf, cq_poll);
 
-		/* Re-enable interrupts */
-		otx2_write64(pfvf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
-			     BIT_ULL(0));
+		if (unlikely(!filled_cnt)) {
+			struct refill_work *work;
+			struct delayed_work *dwork;
+
+			work = &pfvf->refill_wrk[cq->cq_idx];
+			dwork = &work->pool_refill_work;
+			/* Schedule a task if no other task is running */
+			if (!cq->refill_task_sched) {
+				work->napi = napi;
+				cq->refill_task_sched = true;
+				schedule_delayed_work(dwork,
+						      msecs_to_jiffies(100));
+			}
+		} else {
+			/* Re-enable interrupts */
+			otx2_write64(pfvf,
+				     NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
+				     BIT_ULL(0));
+		}
 	}
 	return workdone;
 }
@@ -1191,11 +1210,13 @@ bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
 }
 EXPORT_SYMBOL(otx2_sq_append_skb);
 
-void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
+void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq, int qidx)
 {
 	struct nix_cqe_rx_s *cqe;
+	struct otx2_pool *pool;
 	int processed_cqe = 0;
-	u64 iova, pa;
+	u16 pool_id;
+	u64 iova;
 
 	if (pfvf->xdp_prog)
 		xdp_rxq_info_unreg(&cq->xdp_rxq);
@@ -1203,6 +1224,9 @@ void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 	if (otx2_nix_cq_op_status(pfvf, cq) || !cq->pend_cqe)
 		return;
 
+	pool_id = otx2_get_pool_idx(pfvf, AURA_NIX_RQ, qidx);
+	pool = &pfvf->qset.pool[pool_id];
+
 	while (cq->pend_cqe) {
 		cqe = (struct nix_cqe_rx_s *)otx2_get_next_cqe(cq);
 		processed_cqe++;
@@ -1215,9 +1239,8 @@ void otx2_cleanup_rx_cqes(struct otx2_nic *pfvf, struct otx2_cq_queue *cq)
 			continue;
 		}
 		iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;
-		pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
-		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize, DMA_FROM_DEVICE);
-		put_page(virt_to_page(phys_to_virt(pa)));
+
+		otx2_free_bufs(pfvf, pool, iova, pfvf->rbsize);
 	}
 
 	/* Free CQEs to HW */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 7ab6db9a986f..a82ffca8ce1b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -23,6 +23,8 @@
 #define	OTX2_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN)
 #define	OTX2_MIN_MTU		60
 
+#define OTX2_PAGE_POOL_SZ	2048
+
 #define OTX2_MAX_GSO_SEGS	255
 #define OTX2_MAX_FRAGS_IN_SQE	9
 
@@ -118,6 +120,7 @@ struct otx2_cq_poll {
 struct otx2_pool {
 	struct qmem		*stack;
 	struct qmem		*fc_addr;
+	struct page_pool	*page_pool;
 	u16			rbsize;
 };
 
@@ -167,6 +170,6 @@ void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		     int size, int qidx);
 void otx2_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		    int size, int qidx);
-void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
-void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
+int otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
+int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
 #endif /* OTX2_TXRX_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
index e142d43f5a62..95a2c8e616bd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c
@@ -63,7 +63,7 @@ static int otx2_qos_sq_aura_pool_init(struct otx2_nic *pfvf, int qidx)
 
 	/* Initialize pool context */
 	err = otx2_pool_init(pfvf, pool_id, stack_pages,
-			     num_sqbs, hw->sqb_size);
+			     num_sqbs, hw->sqb_size, AURA_NIX_SQ);
 	if (err)
 		goto aura_free;
 
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index 6a72687d5b83..8cb8d47227f5 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -34,8 +34,10 @@ struct mtk_flow_data {
 	u16 vlan_in;
 
 	struct {
-		u16 id;
-		__be16 proto;
+		struct {
+			u16 id;
+			__be16 proto;
+		} vlans[2];
 		u8 num;
 	} vlan;
 	struct {
@@ -321,18 +323,19 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f)
 		case FLOW_ACTION_CSUM:
 			break;
 		case FLOW_ACTION_VLAN_PUSH:
-			if (data.vlan.num == 1 ||
+			if (data.vlan.num + data.pppoe.num == 2 ||
 			    act->vlan.proto != htons(ETH_P_8021Q))
 				return -EOPNOTSUPP;
 
-			data.vlan.id = act->vlan.vid;
-			data.vlan.proto = act->vlan.proto;
+			data.vlan.vlans[data.vlan.num].id = act->vlan.vid;
+			data.vlan.vlans[data.vlan.num].proto = act->vlan.proto;
 			data.vlan.num++;
 			break;
 		case FLOW_ACTION_VLAN_POP:
 			break;
 		case FLOW_ACTION_PPPOE_PUSH:
-			if (data.pppoe.num == 1)
+			if (data.pppoe.num == 1 ||
+			    data.vlan.num == 2)
 				return -EOPNOTSUPP;
 
 			data.pppoe.sid = act->pppoe.sid;
@@ -422,12 +425,9 @@ mtk_flow_offload_replace(struct mtk_eth *eth, struct flow_cls_offload *f)
 	if (offload_type == MTK_PPE_PKT_TYPE_BRIDGE)
 		foe.bridge.vlan = data.vlan_in;
 
-	if (data.vlan.num == 1) {
-		if (data.vlan.proto != htons(ETH_P_8021Q))
-			return -EOPNOTSUPP;
+	for (i = 0; i < data.vlan.num; i++)
+		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.vlans[i].id);
 
-		mtk_foe_entry_set_vlan(eth, &foe, data.vlan.id);
-	}
 	if (data.pppoe.num == 1)
 		mtk_foe_entry_set_pppoe(eth, &foe, data.pppoe.sid);
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/alloc.c b/drivers/net/ethernet/mellanox/mlx4/alloc.c
index b330020dc0d6..f2bded847e61 100644
--- a/drivers/net/ethernet/mellanox/mlx4/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx4/alloc.c
@@ -682,9 +682,9 @@ static struct mlx4_db_pgdir *mlx4_alloc_db_pgdir(struct device *dma_device)
 }
 
 static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
-				    struct mlx4_db *db, int order)
+				    struct mlx4_db *db, unsigned int order)
 {
-	int o;
+	unsigned int o;
 	int i;
 
 	for (o = order; o <= 1; ++o) {
@@ -712,7 +712,7 @@ static int mlx4_alloc_db_from_pgdir(struct mlx4_db_pgdir *pgdir,
 	return 0;
 }
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order)
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
 	struct mlx4_db_pgdir *pgdir;
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 7fccf1a79f09..95eae224bbb4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -446,6 +446,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 5aeca9534f15..b4980245b50b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -61,6 +61,7 @@
 #define MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE \
 	max(0x7, MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE)
 #define MLX5E_REP_PARAMS_DEF_NUM_CHANNELS 1
+#define MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE 0x8
 
 static const char mlx5e_rep_driver_name[] = "mlx5e_rep";
 
@@ -705,6 +706,8 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* RQ */
 	mlx5e_build_rq_params(mdev, params);
+	if (!mlx5e_is_uplink_rep(priv) && mlx5_core_is_ecpf(mdev))
+		params->log_rq_mtu_frames = MLX5E_REP_PARAMS_DEF_LOG_RQ_SIZE;
 
 	/* CQ moderation params */
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
@@ -726,6 +729,8 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev,
 	netdev->ethtool_ops = &mlx5e_rep_ethtool_ops;
 
 	netdev->watchdog_timeo    = 15 * HZ;
+	if (mlx5_core_is_ecpf(mdev))
+		netdev->tx_queue_len = 1 << MLX5E_REP_PARAMS_DEF_LOG_SQ_SIZE;
 
 #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
 	netdev->hw_features    |= NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index 08a75654f5f1..c170503b3aac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -165,6 +165,9 @@ mlx5e_test_loopback_validate(struct sk_buff *skb,
 	struct udphdr *udph;
 	struct iphdr *iph;
 
+	if (skb_linearize(skb))
+		goto out;
+
 	/* We are only going to peek, no need to clone the SKB */
 	if (MLX5E_TEST_PKT_SIZE - ETH_HLEN > skb_headlen(skb))
 		goto out;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 9459e56ee90a..6aa96d33c210 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -163,11 +163,16 @@ static int temp_warn(struct notifier_block *nb, unsigned long type, void *data)
 	u64 value_msb;
 
 	value_lsb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_lsb);
+	/* bit 1-63 are not supported for NICs,
+	 * hence read only bit 0 (asic) from lsb.
+	 */
+	value_lsb &= 0x1;
 	value_msb = be64_to_cpu(eqe->data.temp_warning.sensor_warning_msb);
 
-	mlx5_core_warn(events->dev,
-		       "High temperature on sensors with bit set %llx %llx",
-		       value_msb, value_lsb);
+	if (net_ratelimit())
+		mlx5_core_warn(events->dev,
+			       "High temperature on sensors with bit set %llx %llx",
+			       value_msb, value_lsb);
 
 	return NOTIFY_OK;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 65483dab9057..b4faac12789d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -850,6 +850,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 2e69ba0143b1..fd3555419179 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3253,6 +3253,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 				 struct pci_dev *pdev)
 {
 	struct lan743x_tx *tx;
+	u32 sgmii_ctl;
 	int index;
 	int ret;
 
@@ -3265,6 +3266,15 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 		spin_lock_init(&adapter->eth_syslock_spinlock);
 		mutex_init(&adapter->sgmii_rw_lock);
 		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
+		sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+		if (adapter->is_sgmii_en) {
+			sgmii_ctl |= SGMII_CTL_SGMII_ENABLE_;
+			sgmii_ctl &= ~SGMII_CTL_SGMII_POWER_DN_;
+		} else {
+			sgmii_ctl &= ~SGMII_CTL_SGMII_ENABLE_;
+			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
+		}
+		lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
 	} else {
 		adapter->max_tx_channels = LAN743X_MAX_TX_CHANNELS;
 		adapter->used_tx_channels = LAN743X_USED_TX_CHANNELS;
@@ -3313,7 +3323,6 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 
 static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 {
-	u32 sgmii_ctl;
 	int ret;
 
 	adapter->mdiobus = devm_mdiobus_alloc(&adapter->pdev->dev);
@@ -3325,10 +3334,6 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 	adapter->mdiobus->priv = (void *)adapter;
 	if (adapter->is_pci11x1x) {
 		if (adapter->is_sgmii_en) {
-			sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
-			sgmii_ctl |= SGMII_CTL_SGMII_ENABLE_;
-			sgmii_ctl &= ~SGMII_CTL_SGMII_POWER_DN_;
-			lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "SGMII operation\n");
 			adapter->mdiobus->probe_capabilities = MDIOBUS_C22_C45;
@@ -3338,10 +3343,6 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "lan743x-mdiobus-c45\n");
 		} else {
-			sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
-			sgmii_ctl &= ~SGMII_CTL_SGMII_ENABLE_;
-			sgmii_ctl |= SGMII_CTL_SGMII_POWER_DN_;
-			lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "RGMII operation\n");
 			// Only C22 support when RGMII I/F
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index d674ebda2053..9e55679796d9 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -995,7 +995,7 @@ static u32 mana_gd_write_client_oob(const struct gdma_wqe_request *wqe_req,
 	header->inline_oob_size_div4 = client_oob_size / sizeof(u32);
 
 	if (oob_in_sgl) {
-		WARN_ON_ONCE(!pad_data || wqe_req->num_sge < 2);
+		WARN_ON_ONCE(wqe_req->num_sge < 2);
 
 		header->client_oob_in_sgl = 1;
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4b461e93ffe9..6346821d480b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5156,6 +5156,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index f834472599f7..0921b78c6244 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -948,7 +948,7 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		/* of_mdio_parse_addr returns a valid (0 ~ 31) PHY
 		 * address. No need to mask it again.
 		 */
-		reg |= 1 << H3_EPHY_ADDR_SHIFT;
+		reg |= ret << H3_EPHY_ADDR_SHIFT;
 	} else {
 		/* For SoCs without internal PHY the PHY selection bit should be
 		 * set to 0 (external PHY).
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 32828d4ac64c..a0a9e4e13e77 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1918,7 +1918,7 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 							port->slave.mac_addr);
 			if (!is_valid_ether_addr(port->slave.mac_addr)) {
 				eth_random_addr(port->slave.mac_addr);
-				dev_err(dev, "Use random MAC address\n");
+				dev_info(dev, "Use random MAC address\n");
 			}
 		}
 	}
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 6e70aa1cc7bf..42684cb83606 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1411,6 +1411,7 @@ static int cpsw_create_ports(struct cpsw_common *cpsw)
 		ndev->netdev_ops = &cpsw_netdev_ops;
 		ndev->ethtool_ops = &cpsw_ethtool_ops;
 		SET_NETDEV_DEV(ndev, dev);
+		ndev->dev.of_node = slave_data->slave_node;
 
 		if (!napi_ndev) {
 			/* CPSW Host port CPDMA interface is shared between
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index 1659bbffdb91..463be34a4ca4 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -1446,8 +1446,7 @@ static u8 mcps_data_request(
 	command.pdata.data_req.src_addr_mode = src_addr_mode;
 	command.pdata.data_req.dst.mode = dst_address_mode;
 	if (dst_address_mode != MAC_MODE_NO_ADDR) {
-		command.pdata.data_req.dst.pan_id[0] = LS_BYTE(dst_pan_id);
-		command.pdata.data_req.dst.pan_id[1] = MS_BYTE(dst_pan_id);
+		put_unaligned_le16(dst_pan_id, command.pdata.data_req.dst.pan_id);
 		if (dst_address_mode == MAC_MODE_SHORT_ADDR) {
 			command.pdata.data_req.dst.address[0] = LS_BYTE(
 				dst_addr->short_address
@@ -1795,12 +1794,12 @@ static int ca8210_skb_rx(
 	}
 	hdr.source.mode = data_ind[0];
 	dev_dbg(&priv->spi->dev, "srcAddrMode: %#03x\n", hdr.source.mode);
-	hdr.source.pan_id = *(u16 *)&data_ind[1];
+	hdr.source.pan_id = cpu_to_le16(get_unaligned_le16(&data_ind[1]));
 	dev_dbg(&priv->spi->dev, "srcPanId: %#06x\n", hdr.source.pan_id);
 	memcpy(&hdr.source.extended_addr, &data_ind[3], 8);
 	hdr.dest.mode = data_ind[11];
 	dev_dbg(&priv->spi->dev, "dstAddrMode: %#03x\n", hdr.dest.mode);
-	hdr.dest.pan_id = *(u16 *)&data_ind[12];
+	hdr.dest.pan_id = cpu_to_le16(get_unaligned_le16(&data_ind[12]));
 	dev_dbg(&priv->spi->dev, "dstPanId: %#06x\n", hdr.dest.pan_id);
 	memcpy(&hdr.dest.extended_addr, &data_ind[14], 8);
 
@@ -1927,7 +1926,7 @@ static int ca8210_skb_tx(
 	status =  mcps_data_request(
 		header.source.mode,
 		header.dest.mode,
-		header.dest.pan_id,
+		le16_to_cpu(header.dest.pan_id),
 		(union macaddr *)&header.dest.extended_addr,
 		skb->len - mac_len,
 		&skb->data[mac_len],
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index fc58e4afb38d..3069a7df25d3 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1566,7 +1566,7 @@ bool phylink_expects_phy(struct phylink *pl)
 {
 	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
 	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_config.interface)))
+	     phy_interface_mode_is_8023z(pl->link_interface)))
 		return false;
 	return true;
 }
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 061a7a9afad0..c2b715541989 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9880,6 +9880,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff) },
 	{ USB_DEVICE(VENDOR_ID_TPLINK,  0x0601) },
 	{ USB_DEVICE(VENDOR_ID_DLINK,   0xb301) },
+	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{}
 };
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 50be5a3c4779..ef61eab81707 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -274,9 +274,9 @@ static int vxlan_fdb_info(struct sk_buff *skb, struct vxlan_dev *vxlan,
 			be32_to_cpu(fdb->vni)))
 		goto nla_put_failure;
 
-	ci.ndm_used	 = jiffies_to_clock_t(now - fdb->used);
+	ci.ndm_used	 = jiffies_to_clock_t(now - READ_ONCE(fdb->used));
 	ci.ndm_confirmed = 0;
-	ci.ndm_updated	 = jiffies_to_clock_t(now - fdb->updated);
+	ci.ndm_updated	 = jiffies_to_clock_t(now - READ_ONCE(fdb->updated));
 	ci.ndm_refcnt	 = 0;
 
 	if (nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
@@ -482,8 +482,8 @@ static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 
 	f = __vxlan_find_mac(vxlan, mac, vni);
-	if (f && f->used != jiffies)
-		f->used = jiffies;
+	if (f && READ_ONCE(f->used) != jiffies)
+		WRITE_ONCE(f->used, jiffies);
 
 	return f;
 }
@@ -1057,12 +1057,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	    !(f->flags & NTF_VXLAN_ADDED_BY_USER)) {
 		if (f->state != state) {
 			f->state = state;
-			f->updated = jiffies;
+			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 		if (f->flags != fdb_flags) {
 			f->flags = fdb_flags;
-			f->updated = jiffies;
+			WRITE_ONCE(f->updated, jiffies);
 			notify = 1;
 		}
 	}
@@ -1096,7 +1096,7 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	}
 
 	if (ndm_flags & NTF_USE)
-		f->used = jiffies;
+		WRITE_ONCE(f->used, jiffies);
 
 	if (notify) {
 		if (rd == NULL)
@@ -1525,7 +1525,7 @@ static bool vxlan_snoop(struct net_device *dev,
 				    src_mac, &rdst->remote_ip.sa, &src_ip->sa);
 
 		rdst->remote_ip = *src_ip;
-		f->updated = jiffies;
+		WRITE_ONCE(f->updated, jiffies);
 		vxlan_fdb_notify(vxlan, f, rdst, RTM_NEWNEIGH, true, NULL);
 	} else {
 		u32 hash_index = fdb_head_index(vxlan, src_mac, vni);
@@ -2936,7 +2936,7 @@ static void vxlan_cleanup(struct timer_list *t)
 			if (f->flags & NTF_EXT_LEARNED)
 				continue;
 
-			timeout = f->used + vxlan->cfg.age_interval * HZ;
+			timeout = READ_ONCE(f->used) + vxlan->cfg.age_interval * HZ;
 			if (time_before_eq(timeout, jiffies)) {
 				netdev_dbg(vxlan->dev,
 					   "garbage collect %pM\n",
@@ -4231,6 +4231,7 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 			    struct netlink_ext_ack *extack)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
+	bool rem_ip_changed, change_igmp;
 	struct net_device *lowerdev;
 	struct vxlan_config conf;
 	struct vxlan_rdst *dst;
@@ -4254,8 +4255,13 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	rem_ip_changed = !vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip);
+	change_igmp = vxlan->dev->flags & IFF_UP &&
+		      (rem_ip_changed ||
+		       dst->remote_ifindex != conf.remote_ifindex);
+
 	/* handle default dst entry */
-	if (!vxlan_addr_equal(&conf.remote_ip, &dst->remote_ip)) {
+	if (rem_ip_changed) {
 		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac, conf.vni);
 
 		spin_lock_bh(&vxlan->hash_lock[hash_index]);
@@ -4299,6 +4305,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 	}
 
+	if (change_igmp && vxlan_addr_multicast(&dst->remote_ip))
+		err = vxlan_multicast_leave(vxlan);
+
 	if (conf.age_interval != vxlan->cfg.age_interval)
 		mod_timer(&vxlan->age_timer, jiffies);
 
@@ -4306,7 +4315,12 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (lowerdev && lowerdev != dst->remote_dev)
 		dst->remote_dev = lowerdev;
 	vxlan_config_apply(dev, &conf, lowerdev, vxlan->net, true);
-	return 0;
+
+	if (!err && change_igmp &&
+	    vxlan_addr_multicast(&dst->remote_ip))
+		err = vxlan_multicast_join(vxlan);
+
+	return err;
 }
 
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index 4f00400c7ffb..58386906598a 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -691,7 +691,9 @@ static int ath9k_of_init(struct ath_softc *sc)
 		ah->ah_flags |= AH_NO_EEP_SWAP;
 	}
 
-	of_get_mac_address(np, common->macaddr);
+	ret = of_get_mac_address(np, common->macaddr);
+	if (ret == -EPROBE_DEFER)
+		return ret;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7f30e6add993..39ac9d81d10d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -552,6 +552,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7AF0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x7AF0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7F70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7F70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma_a0_gf4_a0, iwl_ax411_killer_1690s_name),
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 9ccf8550a067..cd22c756acc6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -798,9 +798,10 @@ rtl8xxxu_writeN(struct rtl8xxxu_priv *priv, u16 addr, u8 *buf, u16 len)
 	return len;
 
 write_error:
-	dev_info(&udev->dev,
-		 "%s: Failed to write block at addr: %04x size: %04x\n",
-		 __func__, addr, blocksize);
+	if (rtl8xxxu_debug & RTL8XXXU_DEBUG_REG_WRITE)
+		dev_info(&udev->dev,
+			 "%s: Failed to write block at addr: %04x size: %04x\n",
+			 __func__, addr, blocksize);
 	return -EAGAIN;
 }
 
@@ -3920,8 +3921,14 @@ static int rtl8xxxu_init_device(struct ieee80211_hw *hw)
 	 */
 	rtl8xxxu_write16(priv, REG_TRXFF_BNDY + 2, fops->trxff_boundary);
 
-	ret = rtl8xxxu_download_firmware(priv);
-	dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+	for (int retry = 5; retry >= 0 ; retry--) {
+		ret = rtl8xxxu_download_firmware(priv);
+		dev_dbg(dev, "%s: download_firmware %i\n", __func__, ret);
+		if (ret != -EAGAIN)
+			break;
+		if (retry)
+			dev_dbg(dev, "%s: retry firmware download\n", __func__);
+	}
 	if (ret)
 		goto exit;
 	ret = rtl8xxxu_start_firmware(priv);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 7c390c2c608d..0a913cf6a615 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1516,6 +1516,7 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	int i;
 
 	ht_cap->ht_supported = true;
 	ht_cap->cap = 0;
@@ -1535,25 +1536,20 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
 	ht_cap->ampdu_density = chip->ampdu_density;
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
-	if (efuse->hw_cap.nss > 1) {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0xFF;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(300);
-	} else {
-		ht_cap->mcs.rx_mask[0] = 0xFF;
-		ht_cap->mcs.rx_mask[1] = 0x00;
-		ht_cap->mcs.rx_mask[4] = 0x01;
-		ht_cap->mcs.rx_highest = cpu_to_le16(150);
-	}
+
+	for (i = 0; i < efuse->hw_cap.nss; i++)
+		ht_cap->mcs.rx_mask[i] = 0xFF;
+	ht_cap->mcs.rx_mask[4] = 0x01;
+	ht_cap->mcs.rx_highest = cpu_to_le16(150 * efuse->hw_cap.nss);
 }
 
 static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 			     struct ieee80211_sta_vht_cap *vht_cap)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u16 mcs_map;
+	u16 mcs_map = 0;
 	__le16 highest;
+	int i;
 
 	if (efuse->hw_cap.ptcl != EFUSE_HW_CAP_IGNORE &&
 	    efuse->hw_cap.ptcl != EFUSE_HW_CAP_PTCL_VHT)
@@ -1576,21 +1572,15 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 	if (rtw_chip_has_rx_ldpc(rtwdev))
 		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
 
-	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
-		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 14;
-	if (efuse->hw_cap.nss > 1) {
-		highest = cpu_to_le16(780);
-		mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
-	} else {
-		highest = cpu_to_le16(390);
-		mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << 2;
+	for (i = 0; i < 8; i++) {
+		if (i < efuse->hw_cap.nss)
+			mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << (i * 2);
+		else
+			mcs_map |= IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2);
 	}
 
+	highest = cpu_to_le16(390 * efuse->hw_cap.nss);
+
 	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(mcs_map);
 	vht_cap->vht_mcs.rx_highest = highest;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 03bd8dc53f72..08628ba3419d 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -107,6 +107,7 @@
 #define BIT_SHIFT_ROM_PGE	16
 #define BIT_FW_INIT_RDY		BIT(15)
 #define BIT_FW_DW_RDY		BIT(14)
+#define BIT_CPU_CLK_SEL		(BIT(12) | BIT(13))
 #define BIT_RPWM_TOGGLE		BIT(7)
 #define BIT_RAM_DL_SEL		BIT(7)	/* legacy only */
 #define BIT_DMEM_CHKSUM_OK	BIT(6)
@@ -124,7 +125,7 @@
 				 BIT_CHECK_SUM_OK)
 #define FW_READY_LEGACY		(BIT_MCUFWDL_RDY | BIT_FWDL_CHK_RPT |	       \
 				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
-#define FW_READY_MASK		0xffff
+#define FW_READY_MASK		(0xffff & ~BIT_CPU_CLK_SEL)
 
 #define REG_MCU_TST_CFG		0x84
 #define VAL_FW_TRIGGER		0x1
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 690e35c98f6e..0b071a116c58 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -957,11 +957,11 @@ static void rtw8822b_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
 }
 
 static void
-rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
+rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path,
+				    u8 rs, u32 *phy_pwr_idx)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	static const u32 offset_txagc[2] = {0x1d00, 0x1d80};
-	static u32 phy_pwr_idx;
 	u8 rate, rate_idx, pwr_index, shift;
 	int j;
 
@@ -969,12 +969,12 @@ rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 		rate = rtw_rate_section[rs][j];
 		pwr_index = hal->tx_pwr_tbl[path][rate];
 		shift = rate & 0x3;
-		phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
+		*phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
 		if (shift == 0x3) {
 			rate_idx = rate & 0xfc;
 			rtw_write32(rtwdev, offset_txagc[path] + rate_idx,
-				    phy_pwr_idx);
-			phy_pwr_idx = 0;
+				    *phy_pwr_idx);
+			*phy_pwr_idx = 0;
 		}
 	}
 }
@@ -982,11 +982,13 @@ rtw8822b_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
 static void rtw8822b_set_tx_power_index(struct rtw_dev *rtwdev)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	u32 phy_pwr_idx = 0;
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
 		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
-			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs);
+			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs,
+							    &phy_pwr_idx);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index cdfd66a85075..43cd06aa39b1 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -101,7 +101,8 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 		*nss = 4;
 		*mcs = rate - DESC_RATEVHT4SS_MCS0;
 	} else if (rate >= DESC_RATEMCS0 &&
-		   rate <= DESC_RATEMCS15) {
+		   rate <= DESC_RATEMCS31) {
+		*nss = 0;
 		*mcs = rate - DESC_RATEMCS0;
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1d57a8c5e97d..0f022a5192ac 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -373,7 +373,6 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 l
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-		ret = -1;
 		goto fail;
 	}
 
@@ -434,7 +433,6 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 		ret = rtw89_h2c_tx(rtwdev, skb, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to send h2c\n");
-			ret = -1;
 			goto fail;
 		}
 
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 6e5a740b128f..2d31193fcc87 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -334,6 +334,7 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct rtw89_dev *rtwdev = hw->priv;
 
+	wiphy_lock(wiphy);
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 
@@ -350,4 +351,5 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 
 exit:
 	mutex_unlock(&rtwdev->mutex);
+	wiphy_unlock(wiphy);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index afb1b41e1a9a..f5dacdc4d11a 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -153,9 +153,11 @@ static void ser_state_run(struct rtw89_ser *ser, u8 evt)
 	rtw89_debug(rtwdev, RTW89_DBG_SER, "ser: %s receive %s\n",
 		    ser_st_name(ser), ser_ev_name(ser, evt));
 
+	wiphy_lock(rtwdev->hw->wiphy);
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_lps(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
+	wiphy_unlock(rtwdev->hw->wiphy);
 
 	ser->st_tbl[ser->state].st_func(ser, evt);
 }
@@ -624,9 +626,11 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 
 	switch (evt) {
 	case SER_EV_STATE_IN:
+		wiphy_lock(rtwdev->hw->wiphy);
 		mutex_lock(&rtwdev->mutex);
 		ser_l2_reset_st_pre_hdl(ser);
 		mutex_unlock(&rtwdev->mutex);
+		wiphy_unlock(rtwdev->hw->wiphy);
 
 		ieee80211_restart_hw(rtwdev->hw);
 		ser_set_alarm(ser, SER_RECFG_TIMEOUT, SER_EV_L2_RECFG_TIMEOUT);
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 082253a3a956..04f4a049599a 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -442,7 +442,8 @@ int nd_label_data_init(struct nvdimm_drvdata *ndd)
 	if (ndd->data)
 		return 0;
 
-	if (ndd->nsarea.status || ndd->nsarea.max_xfer == 0) {
+	if (ndd->nsarea.status || ndd->nsarea.max_xfer == 0 ||
+	    ndd->nsarea.config_size == 0) {
 		dev_dbg(ndd->dev, "failed to init config data area: (%u:%u)\n",
 			ndd->nsarea.max_xfer, ndd->nsarea.config_size);
 		return -ENXIO;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 49a3cb8f1f10..218c1d69090e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3592,6 +3592,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 125e22bd34e2..eee052dbf80c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1417,6 +1417,9 @@ static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 
+	if (!queue->state_change)
+		return;
+
 	write_lock_bh(&sock->sk->sk_callback_lock);
 	sock->sk->sk_data_ready =  queue->data_ready;
 	sock->sk->sk_state_change = queue->state_change;
diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 55c028af4bd9..c4f9ac5c00c1 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -184,6 +184,12 @@ config PCI_P2PDMA
 	  P2P DMA transactions must be between devices behind the same root
 	  port.
 
+	  Enabling this option will reduce the entropy of x86 KASLR memory
+	  regions. For example - on a 46 bit system, the entropy goes down
+	  from 16 bits to 15 bits. The actual reduction in entropy depends
+	  on the physical address bits, on processor features, kernel config
+	  (5 level page table) and physical memory present on the system.
+
 	  If unsure, say N.
 
 config PCI_LABEL
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 449ad709495d..3b3f079d0d2d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -283,7 +283,7 @@ static int dw_pcie_find_index(struct dw_pcie_ep *ep, phys_addr_t addr,
 	u32 index;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	for (index = 0; index < pci->num_ob_windows; index++) {
+	for_each_set_bit(index, ep->ob_window_map, pci->num_ob_windows) {
 		if (ep->outbound_addr[index] != addr)
 			continue;
 		*atu_index = index;
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 425db793080d..c89ad1f92a07 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -281,8 +281,8 @@ static int brcm_pcie_encode_ibar_size(u64 size)
 	if (log2_in >= 12 && log2_in <= 15)
 		/* Covers 4KB to 32KB (inclusive) */
 		return (log2_in - 12) + 0x1c;
-	else if (log2_in >= 16 && log2_in <= 35)
-		/* Covers 64KB to 32GB, (inclusive) */
+	else if (log2_in >= 16 && log2_in <= 36)
+		/* Covers 64KB to 64GB, (inclusive) */
 		return log2_in - 15;
 	/* Something is awry so disable */
 	return 0;
@@ -1619,3 +1619,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 09995b6e73bc..771ff0f6971f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -17,6 +17,8 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+#include <xen/xen.h>
+
 #include <asm/irqdomain.h>
 
 #define VMD_CFGBAR	0
@@ -919,6 +921,24 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int err;
 
+	if (xen_domain()) {
+		/*
+		 * Xen doesn't have knowledge about devices in the VMD bus
+		 * because the config space of devices behind the VMD bridge is
+		 * not known to Xen, and hence Xen cannot discover or configure
+		 * them in any way.
+		 *
+		 * Bypass of MSI remapping won't work in that case as direct
+		 * write by Linux to the MSI entries won't result in functional
+		 * interrupts, as Xen is the entity that manages the host
+		 * interrupt controller and must configure interrupts.  However
+		 * multiplexing of interrupts by the VMD bridge will work under
+		 * Xen, so force the usage of that mode which must always be
+		 * supported by VMD bridges.
+		 */
+		features &= ~VMD_FEAT_CAN_BYPASS_MSI_REMAP;
+	}
+
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8c1ad20a21ec..3ce68adda9b7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -806,11 +806,9 @@ static resource_size_t calculate_iosize(resource_size_t size,
 	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
 	size = size + size1;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 static resource_size_t calculate_memsize(resource_size_t size,
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 4445cae427b2..b2e0a79254f1 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -675,8 +675,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 
 		if ((chan == 5 && cmn->rsp_vc_num < 2) ||
 		    (chan == 6 && cmn->dat_vc_num < 2) ||
-		    (chan == 7 && cmn->snp_vc_num < 2) ||
-		    (chan == 8 && cmn->req_vc_num < 2))
+		    (chan == 7 && cmn->req_vc_num < 2) ||
+		    (chan == 8 && cmn->snp_vc_num < 2))
 			return 0;
 	}
 
@@ -794,8 +794,8 @@ static umode_t arm_cmn_event_attr_is_visible(struct kobject *kobj,
 	_CMN_EVENT_XP(pub_##_name, (_event) | (4 << 5)),	\
 	_CMN_EVENT_XP(rsp2_##_name, (_event) | (5 << 5)),	\
 	_CMN_EVENT_XP(dat2_##_name, (_event) | (6 << 5)),	\
-	_CMN_EVENT_XP(snp2_##_name, (_event) | (7 << 5)),	\
-	_CMN_EVENT_XP(req2_##_name, (_event) | (8 << 5))
+	_CMN_EVENT_XP(req2_##_name, (_event) | (7 << 5)),	\
+	_CMN_EVENT_XP(snp2_##_name, (_event) | (8 << 5))
 
 
 static struct attribute *arm_cmn_event_attrs[] = {
@@ -2313,6 +2313,7 @@ static int arm_cmn_probe(struct platform_device *pdev)
 
 	cmn->dev = &pdev->dev;
 	cmn->part = (unsigned long)device_get_match_data(cmn->dev);
+	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	platform_set_drvdata(pdev, cmn);
 
 	if (cmn->part == PART_CMN600 && has_acpi_companion(cmn->dev)) {
@@ -2340,7 +2341,6 @@ static int arm_cmn_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	cmn->cpu = cpumask_local_spread(0, dev_to_node(cmn->dev));
 	cmn->pmu = (struct pmu) {
 		.module = THIS_MODULE,
 		.attr_groups = arm_cmn_attr_groups,
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 0730fe80dc3c..069bcf49ee8f 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -398,13 +398,14 @@ EXPORT_SYMBOL_GPL(phy_power_off);
 
 int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
 {
-	int ret;
+	int ret = 0;
 
-	if (!phy || !phy->ops->set_mode)
+	if (!phy)
 		return 0;
 
 	mutex_lock(&phy->mutex);
-	ret = phy->ops->set_mode(phy, mode, submode);
+	if (phy->ops->set_mode)
+		ret = phy->ops->set_mode(phy, mode, submode);
 	if (!ret)
 		phy->attrs.mode = mode;
 	mutex_unlock(&phy->mutex);
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 3824e338b61e..024cc5ce68a3 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -9,6 +9,7 @@
  * Copyright (C) 2014 Cogent Embedded, Inc.
  */
 
+#include <linux/cleanup.h>
 #include <linux/extcon-provider.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -21,12 +22,14 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/string.h>
 #include <linux/usb/of.h>
 #include <linux/workqueue.h>
 
 /******* USB2.0 Host registers (original offset is +0x200) *******/
 #define USB2_INT_ENABLE		0x000
+#define USB2_AHB_BUS_CTR	0x008
 #define USB2_USBCTR		0x00c
 #define USB2_SPD_RSM_TIMSET	0x10c
 #define USB2_OC_TIMSET		0x110
@@ -42,6 +45,10 @@
 #define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)	/* For EHCI */
 #define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)	/* For OHCI */
 
+/* AHB_BUS_CTR */
+#define USB2_AHB_BUS_CTR_MBL_MASK	GENMASK(1, 0)
+#define USB2_AHB_BUS_CTR_MBL_INCR4	2
+
 /* USBCTR */
 #define USB2_USBCTR_DIRPD	BIT(2)
 #define USB2_USBCTR_PLL_RST	BIT(1)
@@ -112,10 +119,10 @@ struct rcar_gen3_chan {
 	struct extcon_dev *extcon;
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
+	struct reset_control *rstc;
 	struct work_struct work;
-	struct mutex lock;	/* protects rphys[...].powered */
+	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
-	int irq;
 	u32 obint_enable_bits;
 	bool extcon_host;
 	bool is_otg_channel;
@@ -126,6 +133,7 @@ struct rcar_gen3_chan {
 struct rcar_gen3_phy_drv_data {
 	const struct phy_ops *phy_usb2_ops;
 	bool no_adp_ctrl;
+	bool init_bus;
 };
 
 /*
@@ -340,6 +348,8 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
+	guard(spinlock_irqsave)(&ch->lock);
+
 	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
@@ -407,7 +417,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 		val = readl(usb2_base + USB2_ADPCTRL);
 		writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 	}
-	msleep(20);
+	mdelay(20);
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(ch->obint_enable_bits, usb2_base + USB2_OBINTEN);
@@ -419,16 +429,27 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 {
 	struct rcar_gen3_chan *ch = _ch;
 	void __iomem *usb2_base = ch->base;
-	u32 status = readl(usb2_base + USB2_OBINTSTA);
+	struct device *dev = ch->dev;
 	irqreturn_t ret = IRQ_NONE;
+	u32 status;
+
+	pm_runtime_get_noresume(dev);
+
+	if (pm_runtime_suspended(dev))
+		goto rpm_put;
 
-	if (status & ch->obint_enable_bits) {
-		dev_vdbg(ch->dev, "%s: %08x\n", __func__, status);
-		writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
-		rcar_gen3_device_recognition(ch);
-		ret = IRQ_HANDLED;
+	scoped_guard(spinlock, &ch->lock) {
+		status = readl(usb2_base + USB2_OBINTSTA);
+		if (status & ch->obint_enable_bits) {
+			dev_vdbg(dev, "%s: %08x\n", __func__, status);
+			writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
+			rcar_gen3_device_recognition(ch);
+			ret = IRQ_HANDLED;
+		}
 	}
 
+rpm_put:
+	pm_runtime_put_noidle(dev);
 	return ret;
 }
 
@@ -438,17 +459,8 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
 	u32 val;
-	int ret;
 
-	if (!rcar_gen3_is_any_rphy_initialized(channel) && channel->irq >= 0) {
-		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
-		ret = request_irq(channel->irq, rcar_gen3_phy_usb2_irq,
-				  IRQF_SHARED, dev_name(channel->dev), channel);
-		if (ret < 0) {
-			dev_err(channel->dev, "No irq handler (%d)\n", channel->irq);
-			return ret;
-		}
-	}
+	guard(spinlock_irqsave)(&channel->lock);
 
 	/* Initialize USB2 part */
 	val = readl(usb2_base + USB2_INT_ENABLE);
@@ -476,6 +488,8 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 	void __iomem *usb2_base = channel->base;
 	u32 val;
 
+	guard(spinlock_irqsave)(&channel->lock);
+
 	rphy->initialized = false;
 
 	val = readl(usb2_base + USB2_INT_ENABLE);
@@ -484,9 +498,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 		val &= ~USB2_INT_ENABLE_UCOM_INTEN;
 	writel(val, usb2_base + USB2_INT_ENABLE);
 
-	if (channel->irq >= 0 && !rcar_gen3_is_any_rphy_initialized(channel))
-		free_irq(channel->irq, channel);
-
 	return 0;
 }
 
@@ -498,16 +509,17 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 	u32 val;
 	int ret = 0;
 
-	mutex_lock(&channel->lock);
-	if (!rcar_gen3_are_all_rphys_power_off(channel))
-		goto out;
-
 	if (channel->vbus) {
 		ret = regulator_enable(channel->vbus);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
+	guard(spinlock_irqsave)(&channel->lock);
+
+	if (!rcar_gen3_are_all_rphys_power_off(channel))
+		goto out;
+
 	val = readl(usb2_base + USB2_USBCTR);
 	val |= USB2_USBCTR_PLL_RST;
 	writel(val, usb2_base + USB2_USBCTR);
@@ -517,7 +529,6 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 out:
 	/* The powered flag should be set for any other phys anyway */
 	rphy->powered = true;
-	mutex_unlock(&channel->lock);
 
 	return 0;
 }
@@ -528,18 +539,20 @@ static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 	struct rcar_gen3_chan *channel = rphy->ch;
 	int ret = 0;
 
-	mutex_lock(&channel->lock);
-	rphy->powered = false;
+	scoped_guard(spinlock_irqsave, &channel->lock) {
+		rphy->powered = false;
 
-	if (!rcar_gen3_are_all_rphys_power_off(channel))
-		goto out;
+		if (rcar_gen3_are_all_rphys_power_off(channel)) {
+			u32 val = readl(channel->base + USB2_USBCTR);
+
+			val |= USB2_USBCTR_PLL_RST;
+			writel(val, channel->base + USB2_USBCTR);
+		}
+	}
 
 	if (channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
-out:
-	mutex_unlock(&channel->lock);
-
 	return ret;
 }
 
@@ -647,13 +660,42 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
 	return candidate;
 }
 
+static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
+{
+	struct device *dev = channel->dev;
+	int ret;
+	u32 val;
+
+	channel->rstc = devm_reset_control_array_get_shared(dev);
+	if (IS_ERR(channel->rstc))
+		return PTR_ERR(channel->rstc);
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_deassert(channel->rstc);
+	if (ret)
+		goto rpm_put;
+
+	val = readl(channel->base + USB2_AHB_BUS_CTR);
+	val &= ~USB2_AHB_BUS_CTR_MBL_MASK;
+	val |= USB2_AHB_BUS_CTR_MBL_INCR4;
+	writel(val, channel->base + USB2_AHB_BUS_CTR);
+
+rpm_put:
+	pm_runtime_put(dev);
+
+	return ret;
+}
+
 static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 {
 	const struct rcar_gen3_phy_drv_data *phy_data;
 	struct device *dev = &pdev->dev;
 	struct rcar_gen3_chan *channel;
 	struct phy_provider *provider;
-	int ret = 0, i;
+	int ret = 0, i, irq;
 
 	if (!dev->of_node) {
 		dev_err(dev, "This driver needs device tree\n");
@@ -669,8 +711,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		return PTR_ERR(channel->base);
 
 	channel->obint_enable_bits = USB2_OBINT_BITS;
-	/* get irq number here and request_irq for OTG in phy_init */
-	channel->irq = platform_get_irq_optional(pdev, 0);
 	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
 		channel->is_otg_channel = true;
@@ -700,11 +740,20 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	platform_set_drvdata(pdev, channel);
+	channel->dev = dev;
+
+	if (phy_data->init_bus) {
+		ret = rcar_gen3_phy_usb2_init_bus(channel);
+		if (ret)
+			goto error;
+	}
+
 	channel->soc_no_adp_ctrl = phy_data->no_adp_ctrl;
 	if (phy_data->no_adp_ctrl)
 		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
 
-	mutex_init(&channel->lock);
+	spin_lock_init(&channel->lock);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
 							phy_data->phy_usb2_ops);
@@ -727,8 +776,19 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		channel->vbus = NULL;
 	}
 
-	platform_set_drvdata(pdev, channel);
-	channel->dev = dev;
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO) {
+		ret = irq;
+		goto error;
+	} else if (irq > 0) {
+		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
+		ret = devm_request_irq(dev, irq, rcar_gen3_phy_usb2_irq,
+				       IRQF_SHARED, dev_name(dev), channel);
+		if (ret < 0) {
+			dev_err(dev, "Failed to request irq (%d)\n", irq);
+			goto error;
+		}
+	}
 
 	provider = devm_of_phy_provider_register(dev, rcar_gen3_phy_usb2_xlate);
 	if (IS_ERR(provider)) {
@@ -756,6 +816,7 @@ static int rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
 	if (channel->is_otg_channel)
 		device_remove_file(&pdev->dev, &dev_attr_role);
 
+	reset_control_assert(channel->rstc);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index bba5496335ee..c313f0178957 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -69,7 +69,7 @@ static enum bcm281xx_pin_type hdmi_pin = BCM281XX_PIN_TYPE_HDMI;
 struct bcm281xx_pin_function {
 	const char *name;
 	const char * const *groups;
-	const unsigned ngroups;
+	const unsigned int ngroups;
 };
 
 /*
@@ -81,10 +81,10 @@ struct bcm281xx_pinctrl_data {
 
 	/* List of all pins */
 	const struct pinctrl_pin_desc *pins;
-	const unsigned npins;
+	const unsigned int npins;
 
 	const struct bcm281xx_pin_function *functions;
-	const unsigned nfunctions;
+	const unsigned int nfunctions;
 
 	struct regmap *regmap;
 };
@@ -938,7 +938,7 @@ static struct bcm281xx_pinctrl_data bcm281xx_pinctrl = {
 };
 
 static inline enum bcm281xx_pin_type pin_type_get(struct pinctrl_dev *pctldev,
-						  unsigned pin)
+						  unsigned int pin)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -982,7 +982,7 @@ static int bcm281xx_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
 }
 
 static const char *bcm281xx_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
-						   unsigned group)
+						   unsigned int group)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -990,9 +990,9 @@ static const char *bcm281xx_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
 }
 
 static int bcm281xx_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
-					   unsigned group,
+					   unsigned int group,
 					   const unsigned **pins,
-					   unsigned *num_pins)
+					   unsigned int *num_pins)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1004,7 +1004,7 @@ static int bcm281xx_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
 
 static void bcm281xx_pinctrl_pin_dbg_show(struct pinctrl_dev *pctldev,
 					  struct seq_file *s,
-					  unsigned offset)
+					  unsigned int offset)
 {
 	seq_printf(s, " %s", dev_name(pctldev->dev));
 }
@@ -1026,7 +1026,7 @@ static int bcm281xx_pinctrl_get_fcns_count(struct pinctrl_dev *pctldev)
 }
 
 static const char *bcm281xx_pinctrl_get_fcn_name(struct pinctrl_dev *pctldev,
-						 unsigned function)
+						 unsigned int function)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1034,9 +1034,9 @@ static const char *bcm281xx_pinctrl_get_fcn_name(struct pinctrl_dev *pctldev,
 }
 
 static int bcm281xx_pinctrl_get_fcn_groups(struct pinctrl_dev *pctldev,
-					   unsigned function,
+					   unsigned int function,
 					   const char * const **groups,
-					   unsigned * const num_groups)
+					   unsigned int * const num_groups)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 
@@ -1047,8 +1047,8 @@ static int bcm281xx_pinctrl_get_fcn_groups(struct pinctrl_dev *pctldev,
 }
 
 static int bcm281xx_pinmux_set(struct pinctrl_dev *pctldev,
-			       unsigned function,
-			       unsigned group)
+			       unsigned int function,
+			       unsigned int group)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 	const struct bcm281xx_pin_function *f = &pdata->functions[function];
@@ -1079,7 +1079,7 @@ static const struct pinmux_ops bcm281xx_pinctrl_pinmux_ops = {
 };
 
 static int bcm281xx_pinctrl_pin_config_get(struct pinctrl_dev *pctldev,
-					   unsigned pin,
+					   unsigned int pin,
 					   unsigned long *config)
 {
 	return -ENOTSUPP;
@@ -1088,9 +1088,9 @@ static int bcm281xx_pinctrl_pin_config_get(struct pinctrl_dev *pctldev,
 
 /* Goes through the configs and update register val/mask */
 static int bcm281xx_std_pin_update(struct pinctrl_dev *pctldev,
-				   unsigned pin,
+				   unsigned int pin,
 				   unsigned long *configs,
-				   unsigned num_configs,
+				   unsigned int num_configs,
 				   u32 *val,
 				   u32 *mask)
 {
@@ -1204,9 +1204,9 @@ static const u16 bcm281xx_pullup_map[] = {
 
 /* Goes through the configs and update register val/mask */
 static int bcm281xx_i2c_pin_update(struct pinctrl_dev *pctldev,
-				   unsigned pin,
+				   unsigned int pin,
 				   unsigned long *configs,
-				   unsigned num_configs,
+				   unsigned int num_configs,
 				   u32 *val,
 				   u32 *mask)
 {
@@ -1274,9 +1274,9 @@ static int bcm281xx_i2c_pin_update(struct pinctrl_dev *pctldev,
 
 /* Goes through the configs and update register val/mask */
 static int bcm281xx_hdmi_pin_update(struct pinctrl_dev *pctldev,
-				    unsigned pin,
+				    unsigned int pin,
 				    unsigned long *configs,
-				    unsigned num_configs,
+				    unsigned int num_configs,
 				    u32 *val,
 				    u32 *mask)
 {
@@ -1318,9 +1318,9 @@ static int bcm281xx_hdmi_pin_update(struct pinctrl_dev *pctldev,
 }
 
 static int bcm281xx_pinctrl_pin_config_set(struct pinctrl_dev *pctldev,
-					   unsigned pin,
+					   unsigned int pin,
 					   unsigned long *configs,
-					   unsigned num_configs)
+					   unsigned int num_configs)
 {
 	struct bcm281xx_pinctrl_data *pdata = pinctrl_dev_get_drvdata(pctldev);
 	enum bcm281xx_pin_type pin_type;
diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index 5ee746cb81f5..6520b88db110 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -143,10 +143,14 @@ static int dt_to_map_one_config(struct pinctrl *p,
 		pctldev = get_pinctrl_dev_from_of_node(np_pctldev);
 		if (pctldev)
 			break;
-		/* Do not defer probing of hogs (circular loop) */
+		/*
+		 * Do not defer probing of hogs (circular loop)
+		 *
+		 * Return 1 to let the caller catch the case.
+		 */
 		if (np_pctldev == p->dev->of_node) {
 			of_node_put(np_pctldev);
-			return -ENODEV;
+			return 1;
 		}
 	}
 	of_node_put(np_pctldev);
@@ -265,6 +269,8 @@ int pinctrl_dt_to_map(struct pinctrl *p, struct pinctrl_dev *pctldev)
 			ret = dt_to_map_one_config(p, pctldev, statename,
 						   np_config);
 			of_node_put(np_config);
+			if (ret == 1)
+				continue;
 			if (ret < 0)
 				goto err;
 		}
diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 530f3f934e19..1f05f7f1a9ae 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -487,7 +487,7 @@ static int meson_pinconf_get(struct pinctrl_dev *pcdev, unsigned int pin,
 	case PIN_CONFIG_BIAS_PULL_DOWN:
 	case PIN_CONFIG_BIAS_PULL_UP:
 		if (meson_pinconf_get_pull(pc, pin) == param)
-			arg = 1;
+			arg = 60000;
 		else
 			return -EINVAL;
 		break;
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.c b/drivers/pinctrl/tegra/pinctrl-tegra.c
index 30341c43da59..78de32666d56 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.c
@@ -278,8 +278,8 @@ static int tegra_pinctrl_set_mux(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-static const struct tegra_pingroup *tegra_pinctrl_get_group(struct pinctrl_dev *pctldev,
-					unsigned int offset)
+static int tegra_pinctrl_get_group_index(struct pinctrl_dev *pctldev,
+					 unsigned int offset)
 {
 	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 	unsigned int group, num_pins, j;
@@ -292,12 +292,35 @@ static const struct tegra_pingroup *tegra_pinctrl_get_group(struct pinctrl_dev *
 			continue;
 		for (j = 0; j < num_pins; j++) {
 			if (offset == pins[j])
-				return &pmx->soc->groups[group];
+				return group;
 		}
 	}
 
-	dev_err(pctldev->dev, "Pingroup not found for pin %u\n", offset);
-	return NULL;
+	return -EINVAL;
+}
+
+static const struct tegra_pingroup *tegra_pinctrl_get_group(struct pinctrl_dev *pctldev,
+							    unsigned int offset,
+							    int group_index)
+{
+	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (group_index < 0 || group_index >= pmx->soc->ngroups)
+		return NULL;
+
+	return &pmx->soc->groups[group_index];
+}
+
+static struct tegra_pingroup_config *tegra_pinctrl_get_group_config(struct pinctrl_dev *pctldev,
+								    unsigned int offset,
+								    int group_index)
+{
+	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	if (group_index < 0)
+		return NULL;
+
+	return &pmx->pingroup_configs[group_index];
 }
 
 static int tegra_pinctrl_gpio_request_enable(struct pinctrl_dev *pctldev,
@@ -306,12 +329,15 @@ static int tegra_pinctrl_gpio_request_enable(struct pinctrl_dev *pctldev,
 {
 	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 	const struct tegra_pingroup *group;
+	struct tegra_pingroup_config *config;
+	int group_index;
 	u32 value;
 
 	if (!pmx->soc->sfsel_in_mux)
 		return 0;
 
-	group = tegra_pinctrl_get_group(pctldev, offset);
+	group_index = tegra_pinctrl_get_group_index(pctldev, offset);
+	group = tegra_pinctrl_get_group(pctldev, offset, group_index);
 
 	if (!group)
 		return -EINVAL;
@@ -319,7 +345,11 @@ static int tegra_pinctrl_gpio_request_enable(struct pinctrl_dev *pctldev,
 	if (group->mux_reg < 0 || group->sfsel_bit < 0)
 		return -EINVAL;
 
+	config = tegra_pinctrl_get_group_config(pctldev, offset, group_index);
+	if (!config)
+		return -EINVAL;
 	value = pmx_readl(pmx, group->mux_bank, group->mux_reg);
+	config->is_sfsel = (value & BIT(group->sfsel_bit)) != 0;
 	value &= ~BIT(group->sfsel_bit);
 	pmx_writel(pmx, value, group->mux_bank, group->mux_reg);
 
@@ -332,12 +362,15 @@ static void tegra_pinctrl_gpio_disable_free(struct pinctrl_dev *pctldev,
 {
 	struct tegra_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
 	const struct tegra_pingroup *group;
+	struct tegra_pingroup_config *config;
+	int group_index;
 	u32 value;
 
 	if (!pmx->soc->sfsel_in_mux)
 		return;
 
-	group = tegra_pinctrl_get_group(pctldev, offset);
+	group_index = tegra_pinctrl_get_group_index(pctldev, offset);
+	group = tegra_pinctrl_get_group(pctldev, offset, group_index);
 
 	if (!group)
 		return;
@@ -345,8 +378,12 @@ static void tegra_pinctrl_gpio_disable_free(struct pinctrl_dev *pctldev,
 	if (group->mux_reg < 0 || group->sfsel_bit < 0)
 		return;
 
+	config = tegra_pinctrl_get_group_config(pctldev, offset, group_index);
+	if (!config)
+		return;
 	value = pmx_readl(pmx, group->mux_bank, group->mux_reg);
-	value |= BIT(group->sfsel_bit);
+	if (config->is_sfsel)
+		value |= BIT(group->sfsel_bit);
 	pmx_writel(pmx, value, group->mux_bank, group->mux_reg);
 }
 
@@ -799,6 +836,12 @@ int tegra_pinctrl_probe(struct platform_device *pdev,
 	pmx->dev = &pdev->dev;
 	pmx->soc = soc_data;
 
+	pmx->pingroup_configs = devm_kcalloc(&pdev->dev,
+					     pmx->soc->ngroups, sizeof(*pmx->pingroup_configs),
+					     GFP_KERNEL);
+	if (!pmx->pingroup_configs)
+		return -ENOMEM;
+
 	/*
 	 * Each mux group will appear in 4 functions' list of groups.
 	 * This over-allocates slightly, since not all groups are mux groups.
diff --git a/drivers/pinctrl/tegra/pinctrl-tegra.h b/drivers/pinctrl/tegra/pinctrl-tegra.h
index f8269858eb78..ec5198d391ea 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra.h
+++ b/drivers/pinctrl/tegra/pinctrl-tegra.h
@@ -8,6 +8,10 @@
 #ifndef __PINMUX_TEGRA_H__
 #define __PINMUX_TEGRA_H__
 
+struct tegra_pingroup_config {
+	bool is_sfsel;
+};
+
 struct tegra_pmx {
 	struct device *dev;
 	struct pinctrl_dev *pctl;
@@ -18,6 +22,8 @@ struct tegra_pmx {
 	int nbanks;
 	void __iomem **regs;
 	u32 *backup_regs;
+	/* Array of size soc->ngroups */
+	struct tegra_pingroup_config *pingroup_configs;
 };
 
 enum tegra_pinconf_param {
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
index 230e6ee96636..d8f1bf5e58a0 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
@@ -45,7 +45,7 @@ static ssize_t current_password_store(struct kobject *kobj,
 	int length;
 
 	length = strlen(buf);
-	if (buf[length-1] == '\n')
+	if (length && buf[length - 1] == '\n')
 		length--;
 
 	/* firmware does verifiation of min/max password length,
diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index b543d117b12c..259eb2a2858f 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -17,13 +17,13 @@
 /*
  * fujitsu-laptop.c - Fujitsu laptop support, providing access to additional
  * features made available on a range of Fujitsu laptops including the
- * P2xxx/P5xxx/S6xxx/S7xxx series.
+ * P2xxx/P5xxx/S2xxx/S6xxx/S7xxx series.
  *
  * This driver implements a vendor-specific backlight control interface for
  * Fujitsu laptops and provides support for hotkeys present on certain Fujitsu
  * laptops.
  *
- * This driver has been tested on a Fujitsu Lifebook S6410, S7020 and
+ * This driver has been tested on a Fujitsu Lifebook S2110, S6410, S7020 and
  * P8010.  It should work on most P-series and S-series Lifebooks, but
  * YMMV.
  *
@@ -102,7 +102,11 @@
 #define KEY2_CODE			0x411
 #define KEY3_CODE			0x412
 #define KEY4_CODE			0x413
-#define KEY5_CODE			0x420
+#define KEY5_CODE			0x414
+#define KEY6_CODE			0x415
+#define KEY7_CODE			0x416
+#define KEY8_CODE			0x417
+#define KEY9_CODE			0x420
 
 /* Hotkey ringbuffer limits */
 #define MAX_HOTKEY_RINGBUFFER_SIZE	100
@@ -450,7 +454,7 @@ static const struct key_entry keymap_default[] = {
 	{ KE_KEY, KEY2_CODE,            { KEY_PROG2 } },
 	{ KE_KEY, KEY3_CODE,            { KEY_PROG3 } },
 	{ KE_KEY, KEY4_CODE,            { KEY_PROG4 } },
-	{ KE_KEY, KEY5_CODE,            { KEY_RFKILL } },
+	{ KE_KEY, KEY9_CODE,            { KEY_RFKILL } },
 	/* Soft keys read from status flags */
 	{ KE_KEY, FLAG_RFKILL,          { KEY_RFKILL } },
 	{ KE_KEY, FLAG_TOUCHPAD_TOGGLE, { KEY_TOUCHPAD_TOGGLE } },
@@ -474,6 +478,18 @@ static const struct key_entry keymap_p8010[] = {
 	{ KE_END, 0 }
 };
 
+static const struct key_entry keymap_s2110[] = {
+	{ KE_KEY, KEY1_CODE, { KEY_PROG1 } }, /* "A" */
+	{ KE_KEY, KEY2_CODE, { KEY_PROG2 } }, /* "B" */
+	{ KE_KEY, KEY3_CODE, { KEY_WWW } },   /* "Internet" */
+	{ KE_KEY, KEY4_CODE, { KEY_EMAIL } }, /* "E-mail" */
+	{ KE_KEY, KEY5_CODE, { KEY_STOPCD } },
+	{ KE_KEY, KEY6_CODE, { KEY_PLAYPAUSE } },
+	{ KE_KEY, KEY7_CODE, { KEY_PREVIOUSSONG } },
+	{ KE_KEY, KEY8_CODE, { KEY_NEXTSONG } },
+	{ KE_END, 0 }
+};
+
 static const struct key_entry *keymap = keymap_default;
 
 static int fujitsu_laptop_dmi_keymap_override(const struct dmi_system_id *id)
@@ -511,6 +527,15 @@ static const struct dmi_system_id fujitsu_laptop_dmi_table[] = {
 		},
 		.driver_data = (void *)keymap_p8010
 	},
+	{
+		.callback = fujitsu_laptop_dmi_keymap_override,
+		.ident = "Fujitsu LifeBook S2110",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S2110"),
+		},
+		.driver_data = (void *)keymap_s2110
+	},
 	{}
 };
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 26ca9c453a59..17d74434e604 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -211,6 +211,7 @@ enum tpacpi_hkey_event_t {
 	/* Thermal events */
 	TP_HKEY_EV_ALARM_BAT_HOT	= 0x6011, /* battery too hot */
 	TP_HKEY_EV_ALARM_BAT_XHOT	= 0x6012, /* battery critically hot */
+	TP_HKEY_EV_ALARM_BAT_LIM_CHANGE	= 0x6013, /* battery charge limit changed*/
 	TP_HKEY_EV_ALARM_SENSOR_HOT	= 0x6021, /* sensor too hot */
 	TP_HKEY_EV_ALARM_SENSOR_XHOT	= 0x6022, /* sensor critically hot */
 	TP_HKEY_EV_THM_TABLE_CHANGED	= 0x6030, /* windows; thermal table changed */
@@ -3948,6 +3949,10 @@ static bool hotkey_notify_6xxx(const u32 hkey,
 		pr_alert("THERMAL EMERGENCY: battery is extremely hot!\n");
 		/* recommended action: immediate sleep/hibernate */
 		break;
+	case TP_HKEY_EV_ALARM_BAT_LIM_CHANGE:
+		pr_debug("Battery Info: battery charge threshold changed\n");
+		/* User changed charging threshold. No action needed */
+		return true;
 	case TP_HKEY_EV_ALARM_SENSOR_HOT:
 		pr_crit("THERMAL ALARM: a sensor reports something is too hot!\n");
 		/* recommended action: warn user through gui, that */
@@ -11517,6 +11522,8 @@ static int __must_check __init get_thinkpad_model_data(
 		tp->vendor = PCI_VENDOR_ID_IBM;
 	else if (dmi_name_in_vendors("LENOVO"))
 		tp->vendor = PCI_VENDOR_ID_LENOVO;
+	else if (dmi_name_in_vendors("NEC"))
+		tp->vendor = PCI_VENDOR_ID_LENOVO;
 	else
 		return 0;
 
diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
index 75f432f61e91..f4d6e62bd963 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 
 #define AD5398_CURRENT_EN_MASK	0x8000
 
@@ -221,15 +222,20 @@ static int ad5398_probe(struct i2c_client *client,
 	const struct ad5398_current_data_format *df =
 			(struct ad5398_current_data_format *)id->driver_data;
 
-	if (!init_data)
-		return -EINVAL;
-
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
 	config.dev = &client->dev;
+	if (client->dev.of_node)
+		init_data = of_get_regulator_init_data(&client->dev,
+						       client->dev.of_node,
+						       &ad5398_reg);
+	if (!init_data)
+		return -EINVAL;
+
 	config.init_data = init_data;
+	config.of_node = client->dev.of_node;
 	config.driver_data = chip;
 
 	chip->client = client;
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 68f37296b151..af96541c9b69 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -117,10 +117,10 @@ static const struct wcnss_data pronto_v1_data = {
 	.pmu_offset = 0x1004,
 	.spare_offset = 0x1088,
 
-	.pd_names = { "mx", "cx" },
+	.pd_names = { "cx", "mx" },
 	.vregs = (struct wcnss_vreg_info[]) {
-		{ "vddmx", 950000, 1150000, 0 },
 		{ "vddcx", .super_turbo = true},
+		{ "vddmx", 950000, 1150000, 0 },
 		{ "vddpx", 1800000, 1800000, 0 },
 	},
 	.num_pd_vregs = 2,
@@ -131,10 +131,10 @@ static const struct wcnss_data pronto_v2_data = {
 	.pmu_offset = 0x1004,
 	.spare_offset = 0x1088,
 
-	.pd_names = { "mx", "cx" },
+	.pd_names = { "cx", "mx" },
 	.vregs = (struct wcnss_vreg_info[]) {
-		{ "vddmx", 1287500, 1287500, 0 },
 		{ "vddcx", .super_turbo = true },
+		{ "vddmx", 1287500, 1287500, 0 },
 		{ "vddpx", 1800000, 1800000, 0 },
 	},
 	.num_pd_vregs = 2,
@@ -386,8 +386,17 @@ static irqreturn_t wcnss_stop_ack_interrupt(int irq, void *dev)
 static int wcnss_init_pds(struct qcom_wcnss *wcnss,
 			  const char * const pd_names[WCNSS_MAX_PDS])
 {
+	struct device *dev = wcnss->dev;
 	int i, ret;
 
+	/* Handle single power domain */
+	if (dev->pm_domain) {
+		wcnss->pds[0] = dev;
+		wcnss->num_pds = 1;
+		pm_runtime_enable(dev);
+		return 0;
+	}
+
 	for (i = 0; i < WCNSS_MAX_PDS; i++) {
 		if (!pd_names[i])
 			break;
@@ -407,8 +416,15 @@ static int wcnss_init_pds(struct qcom_wcnss *wcnss,
 
 static void wcnss_release_pds(struct qcom_wcnss *wcnss)
 {
+	struct device *dev = wcnss->dev;
 	int i;
 
+	/* Handle single power domain */
+	if (wcnss->num_pds == 1 && dev->pm_domain) {
+		pm_runtime_disable(dev);
+		return;
+	}
+
 	for (i = 0; i < wcnss->num_pds; i++)
 		dev_pm_domain_detach(wcnss->pds[i], false);
 }
@@ -426,10 +442,14 @@ static int wcnss_init_regulators(struct qcom_wcnss *wcnss,
 	 * the regulators for the power domains. For old device trees we need to
 	 * reserve extra space to manage them through the regulator interface.
 	 */
-	if (wcnss->num_pds)
-		info += num_pd_vregs;
-	else
+	if (wcnss->num_pds) {
+		info += wcnss->num_pds;
+		/* Handle single power domain case */
+		if (wcnss->num_pds < num_pd_vregs)
+			num_vregs += num_pd_vregs - wcnss->num_pds;
+	} else {
 		num_vregs += num_pd_vregs;
+	}
 
 	bulk = devm_kcalloc(wcnss->dev,
 			    num_vregs, sizeof(struct regulator_bulk_data),
diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index d51565bcc189..b7f8b3f9b059 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1802,10 +1802,8 @@ static int ds1307_probe(struct i2c_client *client,
 		 * For some variants, be sure alarms can trigger when we're
 		 * running on Vbackup (BBSQI/BBSQW)
 		 */
-		if (want_irq || ds1307_can_wakeup_device) {
+		if (want_irq || ds1307_can_wakeup_device)
 			regs[0] |= DS1337_BIT_INTCN | chip->bbsqi_bit;
-			regs[0] &= ~(DS1337_BIT_A2IE | DS1337_BIT_A1IE);
-		}
 
 		regmap_write(ds1307->regmap, DS1337_REG_CONTROL,
 			     regs[0]);
diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index c3bee305eacc..9c85ecd9afb8 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -69,7 +69,7 @@
 #define RV3032_CLKOUT2_FD_MSK		GENMASK(6, 5)
 #define RV3032_CLKOUT2_OS		BIT(7)
 
-#define RV3032_CTRL1_EERD		BIT(3)
+#define RV3032_CTRL1_EERD		BIT(2)
 #define RV3032_CTRL1_WADA		BIT(5)
 
 #define RV3032_CTRL2_STOP		BIT(0)
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 86a8bd532489..11fe917fbd9d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -789,48 +789,66 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)
 	vfio_put_device(&matrix_mdev->vdev);
 }
 
-#define MDEV_SHARING_ERR "Userspace may not re-assign queue %02lx.%04lx " \
-			 "already assigned to %s"
+#define MDEV_SHARING_ERR "Userspace may not assign queue %02lx.%04lx to mdev: already assigned to %s"
 
-static void vfio_ap_mdev_log_sharing_err(struct ap_matrix_mdev *matrix_mdev,
-					 unsigned long *apm,
-					 unsigned long *aqm)
+#define MDEV_IN_USE_ERR "Can not reserve queue %02lx.%04lx for host driver: in use by mdev"
+
+static void vfio_ap_mdev_log_sharing_err(struct ap_matrix_mdev *assignee,
+					 struct ap_matrix_mdev *assigned_to,
+					 unsigned long *apm, unsigned long *aqm)
 {
 	unsigned long apid, apqi;
-	const struct device *dev = mdev_dev(matrix_mdev->mdev);
-	const char *mdev_name = dev_name(dev);
 
-	for_each_set_bit_inv(apid, apm, AP_DEVICES)
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+			dev_warn(mdev_dev(assignee->mdev), MDEV_SHARING_ERR,
+				 apid, apqi, dev_name(mdev_dev(assigned_to->mdev)));
+		}
+	}
+}
+
+static void vfio_ap_mdev_log_in_use_err(struct ap_matrix_mdev *assignee,
+					unsigned long *apm, unsigned long *aqm)
+{
+	unsigned long apid, apqi;
+
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
 		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS)
-			dev_warn(dev, MDEV_SHARING_ERR, apid, apqi, mdev_name);
+			dev_warn(mdev_dev(assignee->mdev), MDEV_IN_USE_ERR, apid, apqi);
+	}
 }
 
 /**
  * vfio_ap_mdev_verify_no_sharing - verify APQNs are not shared by matrix mdevs
  *
+ * @assignee: the matrix mdev to which @mdev_apm and @mdev_aqm are being
+ *	      assigned; or, NULL if this function was called by the AP bus
+ *	      driver in_use callback to verify none of the APQNs being reserved
+ *	      for the host device driver are in use by a vfio_ap mediated device
  * @mdev_apm: mask indicating the APIDs of the APQNs to be verified
  * @mdev_aqm: mask indicating the APQIs of the APQNs to be verified
  *
- * Verifies that each APQN derived from the Cartesian product of a bitmap of
- * AP adapter IDs and AP queue indexes is not configured for any matrix
- * mediated device. AP queue sharing is not allowed.
+ * Verifies that each APQN derived from the Cartesian product of APIDs
+ * represented by the bits set in @mdev_apm and the APQIs of the bits set in
+ * @mdev_aqm is not assigned to a mediated device other than the mdev to which
+ * the APQN is being assigned (@assignee). AP queue sharing is not allowed.
  *
  * Return: 0 if the APQNs are not shared; otherwise return -EADDRINUSE.
  */
-static int vfio_ap_mdev_verify_no_sharing(unsigned long *mdev_apm,
+static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *assignee,
+					  unsigned long *mdev_apm,
 					  unsigned long *mdev_aqm)
 {
-	struct ap_matrix_mdev *matrix_mdev;
+	struct ap_matrix_mdev *assigned_to;
 	DECLARE_BITMAP(apm, AP_DEVICES);
 	DECLARE_BITMAP(aqm, AP_DOMAINS);
 
-	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+	list_for_each_entry(assigned_to, &matrix_dev->mdev_list, node) {
 		/*
-		 * If the input apm and aqm are fields of the matrix_mdev
-		 * object, then move on to the next matrix_mdev.
+		 * If the mdev to which the mdev_apm and mdev_aqm is being
+		 * assigned is the same as the mdev being verified
 		 */
-		if (mdev_apm == matrix_mdev->matrix.apm &&
-		    mdev_aqm == matrix_mdev->matrix.aqm)
+		if (assignee == assigned_to)
 			continue;
 
 		memset(apm, 0, sizeof(apm));
@@ -840,15 +858,16 @@ static int vfio_ap_mdev_verify_no_sharing(unsigned long *mdev_apm,
 		 * We work on full longs, as we can only exclude the leftover
 		 * bits in non-inverse order. The leftover is all zeros.
 		 */
-		if (!bitmap_and(apm, mdev_apm, matrix_mdev->matrix.apm,
-				AP_DEVICES))
+		if (!bitmap_and(apm, mdev_apm, assigned_to->matrix.apm,	AP_DEVICES))
 			continue;
 
-		if (!bitmap_and(aqm, mdev_aqm, matrix_mdev->matrix.aqm,
-				AP_DOMAINS))
+		if (!bitmap_and(aqm, mdev_aqm, assigned_to->matrix.aqm,	AP_DOMAINS))
 			continue;
 
-		vfio_ap_mdev_log_sharing_err(matrix_mdev, apm, aqm);
+		if (assignee)
+			vfio_ap_mdev_log_sharing_err(assignee, assigned_to, apm, aqm);
+		else
+			vfio_ap_mdev_log_in_use_err(assigned_to, apm, aqm);
 
 		return -EADDRINUSE;
 	}
@@ -877,7 +896,8 @@ static int vfio_ap_mdev_validate_masks(struct ap_matrix_mdev *matrix_mdev)
 					       matrix_mdev->matrix.aqm))
 		return -EADDRNOTAVAIL;
 
-	return vfio_ap_mdev_verify_no_sharing(matrix_mdev->matrix.apm,
+	return vfio_ap_mdev_verify_no_sharing(matrix_mdev,
+					      matrix_mdev->matrix.apm,
 					      matrix_mdev->matrix.aqm);
 }
 
@@ -1945,7 +1965,7 @@ int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
 
 	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
-	ret = vfio_ap_mdev_verify_no_sharing(apm, aqm);
+	ret = vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_dev->guests_lock);
 
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 57be02f8d5c1..b04112c77fcd 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -5619,6 +5619,7 @@ static struct lpfc_nodelist *
 __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 {
 	struct lpfc_nodelist *ndlp;
+	struct lpfc_nodelist *np = NULL;
 	uint32_t data1;
 
 	list_for_each_entry(ndlp, &vport->fc_nodes, nlp_listp) {
@@ -5633,14 +5634,20 @@ __lpfc_findnode_did(struct lpfc_vport *vport, uint32_t did)
 					 ndlp, ndlp->nlp_DID,
 					 ndlp->nlp_flag, data1, ndlp->nlp_rpi,
 					 ndlp->active_rrqs_xri_bitmap);
-			return ndlp;
+
+			/* Check for new or potentially stale node */
+			if (ndlp->nlp_state != NLP_STE_UNUSED_NODE)
+				return ndlp;
+			np = ndlp;
 		}
 	}
 
-	/* FIND node did <did> NOT FOUND */
-	lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
-			 "0932 FIND node did x%x NOT FOUND.\n", did);
-	return NULL;
+	if (!np)
+		/* FIND node did <did> NOT FOUND */
+		lpfc_printf_vlog(vport, KERN_INFO, LOG_NODE,
+				 "0932 FIND node did x%x NOT FOUND.\n", did);
+
+	return np;
 }
 
 struct lpfc_nodelist *
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 1a0bafde34d8..97f3c5240d57 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13204,6 +13204,7 @@ lpfc_sli4_enable_msi(struct lpfc_hba *phba)
 	eqhdl = lpfc_get_eq_hdl(0);
 	rc = pci_irq_vector(phba->pcidev, 0);
 	if (rc < 0) {
+		free_irq(phba->pcidev->irq, phba);
 		pci_free_irq_vectors(phba->pcidev);
 		lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
 				"0496 MSI pci_irq_vec failed (%d)\n", rc);
@@ -13284,6 +13285,7 @@ lpfc_sli4_enable_intr(struct lpfc_hba *phba, uint32_t cfg_mode)
 			eqhdl = lpfc_get_eq_hdl(0);
 			retval = pci_irq_vector(phba->pcidev, 0);
 			if (retval < 0) {
+				free_irq(phba->pcidev->irq, phba);
 				lpfc_printf_log(phba, KERN_WARNING, LOG_INIT,
 					"0502 INTR pci_irq_vec failed (%d)\n",
 					 retval);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 41636c4c43af..015a875a46a1 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -174,6 +174,9 @@ static void mpi3mr_print_event_data(struct mpi3mr_ioc *mrioc,
 	char *desc = NULL;
 	u16 event;
 
+	if (!(mrioc->logging_level & MPI3_DEBUG_EVENT))
+		return;
+
 	event = event_reply->event;
 
 	switch (event) {
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index fc5af6a5114e..863503e8a4d1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -679,6 +679,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	size_t data_in_sz = 0;
 	long ret;
 	u16 device_handle = MPT3SAS_INVALID_DEVICE_HANDLE;
+	int tm_ret;
 
 	issue_reset = 0;
 
@@ -1120,18 +1121,25 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 			if (pcie_device && (!ioc->tm_custom_handling) &&
 			    (!(mpt3sas_scsih_is_pcie_scsi_device(
 			    pcie_device->device_info))))
-				mpt3sas_scsih_issue_locked_tm(ioc,
+				tm_ret = mpt3sas_scsih_issue_locked_tm(ioc,
 				  le16_to_cpu(mpi_request->FunctionDependent1),
 				  0, 0, 0,
 				  MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET, 0,
 				  0, pcie_device->reset_timeout,
 			MPI26_SCSITASKMGMT_MSGFLAGS_PROTOCOL_LVL_RST_PCIE);
 			else
-				mpt3sas_scsih_issue_locked_tm(ioc,
+				tm_ret = mpt3sas_scsih_issue_locked_tm(ioc,
 				  le16_to_cpu(mpi_request->FunctionDependent1),
 				  0, 0, 0,
 				  MPI2_SCSITASKMGMT_TASKTYPE_TARGET_RESET, 0,
 				  0, 30, MPI2_SCSITASKMGMT_MSGFLAGS_LINK_RESET);
+
+			if (tm_ret != SUCCESS) {
+				ioc_info(ioc,
+					 "target reset failed, issue hard reset: handle (0x%04x)\n",
+					 le16_to_cpu(mpi_request->FunctionDependent1));
+				mpt3sas_base_hard_reset_handler(ioc, FORCE_BIG_HAMMER);
+			}
 		} else
 			mpt3sas_base_hard_reset_handler(ioc, FORCE_BIG_HAMMER);
 	}
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 7f107be34423..9ba5ad106b65 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -950,7 +950,6 @@ static void reset_state(struct scsi_tape *STp)
 		STp->partition = find_partition(STp);
 		if (STp->partition < 0)
 			STp->partition = 0;
-		STp->new_partition = STp->partition;
 	}
 }
 
@@ -2887,7 +2886,6 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 			timeout = STp->long_timeout * 8;
 
 		DEBC_printk(STp, "Erasing tape.\n");
-		fileno = blkno = at_sm = 0;
 		break;
 	case MTSETBLK:		/* Set block length */
 	case MTSETDENSITY:	/* Set tape density */
@@ -2920,14 +2918,17 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 		if (cmd_in == MTSETDENSITY) {
 			(STp->buffer)->b_data[4] = arg;
 			STp->density_changed = 1;	/* At least we tried ;-) */
+			STp->changed_density = arg;
 		} else if (cmd_in == SET_DENS_AND_BLK)
 			(STp->buffer)->b_data[4] = arg >> 24;
 		else
 			(STp->buffer)->b_data[4] = STp->density;
 		if (cmd_in == MTSETBLK || cmd_in == SET_DENS_AND_BLK) {
 			ltmp = arg & MT_ST_BLKSIZE_MASK;
-			if (cmd_in == MTSETBLK)
+			if (cmd_in == MTSETBLK) {
 				STp->blksize_changed = 1; /* At least we tried ;-) */
+				STp->changed_blksize = arg;
+			}
 		} else
 			ltmp = STp->block_size;
 		(STp->buffer)->b_data[9] = (ltmp >> 16);
@@ -3074,7 +3075,9 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
 			   cmd_in == MTSETDRVBUFFER ||
 			   cmd_in == SET_DENS_AND_BLK) {
 			if (cmdstatp->sense_hdr.sense_key == ILLEGAL_REQUEST &&
-			    !(STp->use_pf & PF_TESTED)) {
+				cmdstatp->sense_hdr.asc == 0x24 &&
+				(STp->device)->scsi_level <= SCSI_2 &&
+				!(STp->use_pf & PF_TESTED)) {
 				/* Try the other possible state of Page Format if not
 				   already tried */
 				STp->use_pf = (STp->use_pf ^ USE_PF) | PF_TESTED;
@@ -3626,9 +3629,25 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 				retval = (-EIO);
 				goto out;
 			}
-			reset_state(STp);
+			reset_state(STp); /* Clears pos_unknown */
 			/* remove this when the midlevel properly clears was_reset */
 			STp->device->was_reset = 0;
+
+			/* Fix the device settings after reset, ignore errors */
+			if (mtc.mt_op == MTREW || mtc.mt_op == MTSEEK ||
+				mtc.mt_op == MTEOM) {
+				if (STp->can_partitions) {
+					/* STp->new_partition contains the
+					 *  latest partition set
+					 */
+					STp->partition = 0;
+					switch_partition(STp);
+				}
+				if (STp->density_changed)
+					st_int_ioctl(STp, MTSETDENSITY, STp->changed_density);
+				if (STp->blksize_changed)
+					st_int_ioctl(STp, MTSETBLK, STp->changed_blksize);
+			}
 		}
 
 		if (mtc.mt_op != MTNOP && mtc.mt_op != MTSETBLK &&
diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
index 7a68eaba7e81..2105c6a5b458 100644
--- a/drivers/scsi/st.h
+++ b/drivers/scsi/st.h
@@ -165,12 +165,14 @@ struct scsi_tape {
 	unsigned char compression_changed;
 	unsigned char drv_buffer;
 	unsigned char density;
+	unsigned char changed_density;
 	unsigned char door_locked;
 	unsigned char autorew_dev;   /* auto-rewind device */
 	unsigned char rew_at_close;  /* rewind necessary at close */
 	unsigned char inited;
 	unsigned char cleaning_req;  /* cleaning requested? */
 	int block_size;
+	int changed_blksize;
 	int min_block;
 	int max_block;
 	int recover_count;     /* From tape opening */
diff --git a/drivers/soc/apple/rtkit-internal.h b/drivers/soc/apple/rtkit-internal.h
index 24bd619ec5e4..1da1dfd9cb19 100644
--- a/drivers/soc/apple/rtkit-internal.h
+++ b/drivers/soc/apple/rtkit-internal.h
@@ -48,6 +48,7 @@ struct apple_rtkit {
 
 	struct apple_rtkit_shmem ioreport_buffer;
 	struct apple_rtkit_shmem crashlog_buffer;
+	struct apple_rtkit_shmem oslog_buffer;
 
 	struct apple_rtkit_shmem syslog_buffer;
 	char *syslog_msg_buffer;
diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index 8ec74d7539eb..968f9f633393 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -65,8 +65,9 @@ enum {
 #define APPLE_RTKIT_SYSLOG_MSG_SIZE  GENMASK_ULL(31, 24)
 
 #define APPLE_RTKIT_OSLOG_TYPE GENMASK_ULL(63, 56)
-#define APPLE_RTKIT_OSLOG_INIT	1
-#define APPLE_RTKIT_OSLOG_ACK	3
+#define APPLE_RTKIT_OSLOG_BUFFER_REQUEST 1
+#define APPLE_RTKIT_OSLOG_SIZE GENMASK_ULL(55, 36)
+#define APPLE_RTKIT_OSLOG_IOVA GENMASK_ULL(35, 0)
 
 #define APPLE_RTKIT_MIN_SUPPORTED_VERSION 11
 #define APPLE_RTKIT_MAX_SUPPORTED_VERSION 12
@@ -255,15 +256,21 @@ static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
 					    struct apple_rtkit_shmem *buffer,
 					    u8 ep, u64 msg)
 {
-	size_t n_4kpages = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg);
 	u64 reply;
 	int err;
 
+	/* The different size vs. IOVA shifts look odd but are indeed correct this way */
+	if (ep == APPLE_RTKIT_EP_OSLOG) {
+		buffer->size = FIELD_GET(APPLE_RTKIT_OSLOG_SIZE, msg);
+		buffer->iova = FIELD_GET(APPLE_RTKIT_OSLOG_IOVA, msg) << 12;
+	} else {
+		buffer->size = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_SIZE, msg) << 12;
+		buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
+	}
+
 	buffer->buffer = NULL;
 	buffer->iomem = NULL;
 	buffer->is_mapped = false;
-	buffer->iova = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg);
-	buffer->size = n_4kpages << 12;
 
 	dev_dbg(rtk->dev, "RTKit: buffer request for 0x%zx bytes at %pad\n",
 		buffer->size, &buffer->iova);
@@ -288,11 +295,21 @@ static int apple_rtkit_common_rx_get_buffer(struct apple_rtkit *rtk,
 	}
 
 	if (!buffer->is_mapped) {
-		reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
-				   APPLE_RTKIT_BUFFER_REQUEST);
-		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE, n_4kpages);
-		reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA,
-				    buffer->iova);
+		/* oslog uses different fields and needs a shifted IOVA instead of size */
+		if (ep == APPLE_RTKIT_EP_OSLOG) {
+			reply = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE,
+					   APPLE_RTKIT_OSLOG_BUFFER_REQUEST);
+			reply |= FIELD_PREP(APPLE_RTKIT_OSLOG_SIZE, buffer->size);
+			reply |= FIELD_PREP(APPLE_RTKIT_OSLOG_IOVA,
+					    buffer->iova >> 12);
+		} else {
+			reply = FIELD_PREP(APPLE_RTKIT_SYSLOG_TYPE,
+					   APPLE_RTKIT_BUFFER_REQUEST);
+			reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_SIZE,
+					    buffer->size >> 12);
+			reply |= FIELD_PREP(APPLE_RTKIT_BUFFER_REQUEST_IOVA,
+					    buffer->iova);
+		}
 		apple_rtkit_send_message(rtk, ep, reply, NULL, false);
 	}
 
@@ -474,25 +491,18 @@ static void apple_rtkit_syslog_rx(struct apple_rtkit *rtk, u64 msg)
 	}
 }
 
-static void apple_rtkit_oslog_rx_init(struct apple_rtkit *rtk, u64 msg)
-{
-	u64 ack;
-
-	dev_dbg(rtk->dev, "RTKit: oslog init: msg: 0x%llx\n", msg);
-	ack = FIELD_PREP(APPLE_RTKIT_OSLOG_TYPE, APPLE_RTKIT_OSLOG_ACK);
-	apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_OSLOG, ack, NULL, false);
-}
-
 static void apple_rtkit_oslog_rx(struct apple_rtkit *rtk, u64 msg)
 {
 	u8 type = FIELD_GET(APPLE_RTKIT_OSLOG_TYPE, msg);
 
 	switch (type) {
-	case APPLE_RTKIT_OSLOG_INIT:
-		apple_rtkit_oslog_rx_init(rtk, msg);
+	case APPLE_RTKIT_OSLOG_BUFFER_REQUEST:
+		apple_rtkit_common_rx_get_buffer(rtk, &rtk->oslog_buffer,
+						 APPLE_RTKIT_EP_OSLOG, msg);
 		break;
 	default:
-		dev_warn(rtk->dev, "RTKit: Unknown oslog message: %llx\n", msg);
+		dev_warn(rtk->dev, "RTKit: Unknown oslog message: %llx\n",
+			 msg);
 	}
 }
 
@@ -731,7 +741,7 @@ static struct apple_rtkit *apple_rtkit_init(struct device *dev, void *cookie,
 	rtk->mbox_cl.rx_callback = &apple_rtkit_rx;
 	rtk->mbox_cl.tx_done = &apple_rtkit_tx_done;
 
-	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_MEM_RECLAIM,
+	rtk->wq = alloc_ordered_workqueue("rtkit-%s", WQ_HIGHPRI | WQ_MEM_RECLAIM,
 					  dev_name(rtk->dev));
 	if (!rtk->wq) {
 		ret = -ENOMEM;
@@ -773,6 +783,7 @@ int apple_rtkit_reinit(struct apple_rtkit *rtk)
 
 	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->oslog_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
 
 	kfree(rtk->syslog_msg_buffer);
@@ -935,6 +946,7 @@ static void apple_rtkit_free(void *data)
 
 	apple_rtkit_free_buffer(rtk, &rtk->ioreport_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->crashlog_buffer);
+	apple_rtkit_free_buffer(rtk, &rtk->oslog_buffer);
 	apple_rtkit_free_buffer(rtk, &rtk->syslog_buffer);
 
 	kfree(rtk->syslog_msg_buffer);
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 88aee59730e3..6d5b6ed36169 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -1347,7 +1347,7 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_LOCKDEP) &&
-	    of_property_read_bool(domain->dev->of_node, "power-domains"))
+	    of_property_present(domain->dev->of_node, "power-domains"))
 		lockdep_set_subclass(&domain->genpd.mlock, 1);
 
 	ret = of_genpd_add_provider_simple(domain->dev->of_node,
diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 91f441ee6175..5b0d8260918d 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -60,6 +60,12 @@ k3_chipinfo_partno_to_names(unsigned int partno,
 	return -EINVAL;
 }
 
+static const struct regmap_config k3_chipinfo_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static int k3_chipinfo_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -67,13 +73,18 @@ static int k3_chipinfo_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct soc_device *soc_dev;
 	struct regmap *regmap;
+	void __iomem *base;
 	u32 partno_id;
 	u32 variant;
 	u32 jtag_id;
 	u32 mfg;
 	int ret;
 
-	regmap = device_node_to_regmap(node);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = regmap_init_mmio(dev, base, &k3_chipinfo_regmap_cfg);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 01930b52c4fb..5374c6d44519 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 //
 // Copyright 2013 Freescale Semiconductor, Inc.
-// Copyright 2020 NXP
+// Copyright 2020-2025 NXP
 //
 // Freescale DSPI driver
 // This file contains a driver for the Freescale DSPI
@@ -61,6 +61,7 @@
 #define SPI_SR_TFIWF			BIT(18)
 #define SPI_SR_RFDF			BIT(17)
 #define SPI_SR_CMDFFF			BIT(16)
+#define SPI_SR_TXRXS			BIT(30)
 #define SPI_SR_CLEAR			(SPI_SR_TCFQF | \
 					SPI_SR_TFUF | SPI_SR_TFFF | \
 					SPI_SR_CMDTCF | SPI_SR_SPEF | \
@@ -907,9 +908,20 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_device *spi = message->spi;
 	struct spi_transfer *transfer;
 	int status = 0;
+	u32 val = 0;
+	bool cs_change = false;
 
 	message->actual_length = 0;
 
+	/* Put DSPI in running mode if halted. */
+	regmap_read(dspi->regmap, SPI_MCR, &val);
+	if (val & SPI_MCR_HALT) {
+		regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_HALT, 0);
+		while (regmap_read(dspi->regmap, SPI_SR, &val) >= 0 &&
+		       !(val & SPI_SR_TXRXS))
+			;
+	}
+
 	list_for_each_entry(transfer, &message->transfers, transfer_list) {
 		dspi->cur_transfer = transfer;
 		dspi->cur_msg = message;
@@ -934,6 +946,7 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				dspi->tx_cmd |= SPI_PUSHR_CMD_CONT;
 		}
 
+		cs_change = transfer->cs_change;
 		dspi->tx = transfer->tx_buf;
 		dspi->rx = transfer->rx_buf;
 		dspi->len = transfer->len;
@@ -943,6 +956,8 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF,
 				   SPI_MCR_CLR_TXF | SPI_MCR_CLR_RXF);
 
+		regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
+
 		spi_take_timestamp_pre(dspi->ctlr, dspi->cur_transfer,
 				       dspi->progress, !dspi->irq);
 
@@ -966,6 +981,15 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 		spi_transfer_delay_exec(transfer);
 	}
 
+	if (status || !cs_change) {
+		/* Put DSPI in stop mode */
+		regmap_update_bits(dspi->regmap, SPI_MCR,
+				   SPI_MCR_HALT, SPI_MCR_HALT);
+		while (regmap_read(dspi->regmap, SPI_SR, &val) >= 0 &&
+		       val & SPI_SR_TXRXS)
+			;
+	}
+
 	message->status = status;
 	spi_finalize_current_message(ctlr);
 
@@ -1128,6 +1152,20 @@ static int dspi_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(dspi_pm, dspi_suspend, dspi_resume);
 
+static const struct regmap_range dspi_yes_ranges[] = {
+	regmap_reg_range(SPI_MCR, SPI_MCR),
+	regmap_reg_range(SPI_TCR, SPI_CTAR(3)),
+	regmap_reg_range(SPI_SR, SPI_TXFR3),
+	regmap_reg_range(SPI_RXFR0, SPI_RXFR3),
+	regmap_reg_range(SPI_CTARE(0), SPI_CTARE(3)),
+	regmap_reg_range(SPI_SREX, SPI_SREX),
+};
+
+static const struct regmap_access_table dspi_access_table = {
+	.yes_ranges	= dspi_yes_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(dspi_yes_ranges),
+};
+
 static const struct regmap_range dspi_volatile_ranges[] = {
 	regmap_reg_range(SPI_MCR, SPI_TCR),
 	regmap_reg_range(SPI_SR, SPI_SR),
@@ -1145,6 +1183,8 @@ static const struct regmap_config dspi_regmap_config = {
 	.reg_stride	= 4,
 	.max_register	= 0x88,
 	.volatile_table	= &dspi_volatile_table,
+	.rd_table	= &dspi_access_table,
+	.wr_table	= &dspi_access_table,
 };
 
 static const struct regmap_range dspi_xspi_volatile_ranges[] = {
@@ -1166,6 +1206,8 @@ static const struct regmap_config dspi_xspi_regmap_config[] = {
 		.reg_stride	= 4,
 		.max_register	= 0x13c,
 		.volatile_table	= &dspi_xspi_volatile_table,
+		.rd_table	= &dspi_access_table,
+		.wr_table	= &dspi_access_table,
 	},
 	{
 		.name		= "pushr",
@@ -1188,6 +1230,8 @@ static int dspi_init(struct fsl_dspi *dspi)
 	if (!spi_controller_is_slave(dspi->ctlr))
 		mcr |= SPI_MCR_MASTER;
 
+	mcr |= SPI_MCR_HALT;
+
 	regmap_write(dspi->regmap, SPI_MCR, mcr);
 	regmap_write(dspi->regmap, SPI_SR, SPI_SR_CLEAR);
 
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 6000d0761206..6937f5c4d868 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -263,6 +263,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	else
 		reg |= SUN4I_CTL_DHB;
 
+	/* Now that the settings are correct, enable the interface */
+	reg |= SUN4I_CTL_ENABLE;
+
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
 
 	/* Ensure that we have a parent clock fast enough */
@@ -403,7 +406,7 @@ static int sun4i_spi_runtime_resume(struct device *dev)
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CTL_REG,
-			SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);
+			SUN4I_CTL_MASTER | SUN4I_CTL_TP);
 
 	return 0;
 
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c89544ae5ed9..fde7c3810359 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -698,7 +698,6 @@ static void zynqmp_process_dma_irq(struct zynqmp_qspi *xqspi)
 static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 {
 	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_id;
-	irqreturn_t ret = IRQ_NONE;
 	u32 status, mask, dma_status = 0;
 
 	status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
@@ -713,27 +712,24 @@ static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
 				   dma_status);
 	}
 
-	if (mask & GQSPI_ISR_TXNOT_FULL_MASK) {
+	if (!mask && !dma_status)
+		return IRQ_NONE;
+
+	if (mask & GQSPI_ISR_TXNOT_FULL_MASK)
 		zynqmp_qspi_filltxfifo(xqspi, GQSPI_TX_FIFO_FILL);
-		ret = IRQ_HANDLED;
-	}
 
-	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK) {
+	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK)
 		zynqmp_process_dma_irq(xqspi);
-		ret = IRQ_HANDLED;
-	} else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
-			(mask & GQSPI_IER_GENFIFOEMPTY_MASK)) {
+	else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
+			(mask & GQSPI_IER_GENFIFOEMPTY_MASK))
 		zynqmp_qspi_readrxfifo(xqspi, GQSPI_RX_FIFO_FILL);
-		ret = IRQ_HANDLED;
-	}
 
 	if (xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
 	    ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
 		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
 		complete(&xqspi->data_completion);
-		ret = IRQ_HANDLED;
 	}
-	return ret;
+	return IRQ_HANDLED;
 }
 
 /**
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 07e196b44b91..04d40e76772b 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4314,8 +4314,8 @@ int iscsit_close_connection(
 	spin_unlock(&iscsit_global->ts_bitmap_lock);
 
 	iscsit_stop_timers_for_cmds(conn);
-	iscsit_stop_nopin_response_timer(conn);
 	iscsit_stop_nopin_timer(conn);
+	iscsit_stop_nopin_response_timer(conn);
 
 	if (conn->conn_transport->iscsit_wait_conn)
 		conn->conn_transport->iscsit_wait_conn(conn);
diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d111e218f362..b33cb1d880b7 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -19,6 +19,7 @@
 #define SITES_MAX		16
 #define TMR_DISABLE		0x0
 #define TMR_ME			0x80000000
+#define TMR_CMD			BIT(29)
 #define TMR_ALPF		0x0c000000
 #define TMR_ALPF_V2		0x03000000
 #define TMTMIR_DEFAULT	0x0000000f
@@ -345,6 +346,12 @@ static int __maybe_unused qoriq_tmu_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_set_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	clk_disable_unprepare(data->clk);
 
 	return 0;
@@ -359,6 +366,12 @@ static int __maybe_unused qoriq_tmu_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (data->ver > TMU_VER1) {
+		ret = regmap_clear_bits(data->regmap, REGS_TMR, TMR_CMD);
+		if (ret)
+			return ret;
+	}
+
 	/* Enable monitoring */
 	return regmap_update_bits(data->regmap, REGS_TMR, TMR_ME, TMR_ME);
 }
diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
index 5bd5c22a5085..d2038337ea03 100644
--- a/drivers/thunderbolt/retimer.c
+++ b/drivers/thunderbolt/retimer.c
@@ -89,9 +89,11 @@ static int tb_retimer_nvm_add(struct tb_retimer *rt)
 	if (ret)
 		goto err_nvm;
 
-	ret = tb_nvm_add_non_active(nvm, nvm_write);
-	if (ret)
-		goto err_nvm;
+	if (!rt->no_nvm_upgrade) {
+		ret = tb_nvm_add_non_active(nvm, nvm_write);
+		if (ret)
+			goto err_nvm;
+	}
 
 	rt->nvm = nvm;
 	return 0;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 711de54eda98..c1917774e0bb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1694,7 +1694,7 @@ static void serial8250_disable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
-	mctrl_gpio_disable_ms(up->gpios);
+	mctrl_gpio_disable_ms_no_sync(up->gpios);
 
 	up->ier &= ~UART_IER_MSI;
 	serial_port_out(port, UART_IER, up->ier);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 6a9310379dc2..b3463cdd1d4b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -692,7 +692,7 @@ static void atmel_disable_ms(struct uart_port *port)
 
 	atmel_port->ms_irq_enabled = false;
 
-	mctrl_gpio_disable_ms(atmel_port->gpios);
+	mctrl_gpio_disable_ms_no_sync(atmel_port->gpios);
 
 	if (!mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS))
 		idr |= ATMEL_US_CTSIC;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 94e0781e00e8..fe22ca009fb3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1586,7 +1586,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 		imx_uart_dma_exit(sport);
 	}
 
-	mctrl_gpio_disable_ms(sport->gpios);
+	mctrl_gpio_disable_ms_sync(sport->gpios);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	ucr2 = imx_uart_readl(sport, UCR2);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 7d5aaa8d422b..d5fb293dd5a9 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -322,11 +322,7 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_enable_ms);
 
-/**
- * mctrl_gpio_disable_ms - disable irqs and handling of changes to the ms lines
- * @gpios: gpios to disable
- */
-void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+static void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios, bool sync)
 {
 	enum mctrl_gpio_idx i;
 
@@ -342,10 +338,34 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 		if (!gpios->irq[i])
 			continue;
 
-		disable_irq(gpios->irq[i]);
+		if (sync)
+			disable_irq(gpios->irq[i]);
+		else
+			disable_irq_nosync(gpios->irq[i]);
 	}
 }
-EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
+
+/**
+ * mctrl_gpio_disable_ms_sync - disable irqs and handling of changes to the ms
+ * lines, and wait for any pending IRQ to be processed
+ * @gpios: gpios to disable
+ */
+void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios)
+{
+	mctrl_gpio_disable_ms(gpios, true);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms_sync);
+
+/**
+ * mctrl_gpio_disable_ms_no_sync - disable irqs and handling of changes to the
+ * ms lines, and return immediately
+ * @gpios: gpios to disable
+ */
+void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios)
+{
+	mctrl_gpio_disable_ms(gpios, false);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms_no_sync);
 
 void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios)
 {
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index fc76910fb105..79e97838ebe5 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -87,9 +87,16 @@ void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios);
 void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
 
 /*
- * Disable gpio interrupts to report status line changes.
+ * Disable gpio interrupts to report status line changes, and block until
+ * any corresponding IRQ is processed
  */
-void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
+void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios);
+
+/*
+ * Disable gpio interrupts to report status line changes, and return
+ * immediately
+ */
+void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios);
 
 /*
  * Enable gpio wakeup interrupts to enable wake up source.
@@ -148,7 +155,11 @@ static inline void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
 {
 }
 
-static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+static inline void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios)
+{
+}
+
+static inline void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios)
 {
 }
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6182ae5f6fa1..ed468b676f0b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -105,6 +105,20 @@ struct plat_sci_reg {
 	u8 offset, size;
 };
 
+struct sci_suspend_regs {
+	u16 scdl;
+	u16 sccks;
+	u16 scsmr;
+	u16 scscr;
+	u16 scfcr;
+	u16 scsptr;
+	u16 hssrr;
+	u16 scpcr;
+	u16 scpdr;
+	u8 scbrr;
+	u8 semr;
+};
+
 struct sci_port_params {
 	const struct plat_sci_reg regs[SCIx_NR_REGS];
 	unsigned int fifosize;
@@ -135,6 +149,8 @@ struct sci_port {
 	struct dma_chan			*chan_tx;
 	struct dma_chan			*chan_rx;
 
+	struct reset_control		*rstc;
+
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
 	struct dma_chan			*chan_tx_saved;
 	struct dma_chan			*chan_rx_saved;
@@ -154,6 +170,7 @@ struct sci_port {
 	int				rx_trigger;
 	struct timer_list		rx_fifo_timer;
 	int				rx_fifo_timeout;
+	struct sci_suspend_regs		suspend_regs;
 	u16				hscif_tot;
 
 	bool has_rtscts;
@@ -2182,7 +2199,7 @@ static void sci_shutdown(struct uart_port *port)
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
 	s->autorts = false;
-	mctrl_gpio_disable_ms(to_sci_port(port)->gpios);
+	mctrl_gpio_disable_ms_sync(to_sci_port(port)->gpios);
 
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
@@ -3252,6 +3269,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 	}
 
 	sp = &sci_ports[id];
+	sp->rstc = rstc;
 	*dev_id = id;
 
 	p->type = SCI_OF_TYPE(data);
@@ -3400,13 +3418,77 @@ static int sci_probe(struct platform_device *dev)
 	return 0;
 }
 
+static void sci_console_save(struct sci_port *s)
+{
+	struct sci_suspend_regs *regs = &s->suspend_regs;
+	struct uart_port *port = &s->port;
+
+	if (sci_getreg(port, SCDL)->size)
+		regs->scdl = sci_serial_in(port, SCDL);
+	if (sci_getreg(port, SCCKS)->size)
+		regs->sccks = sci_serial_in(port, SCCKS);
+	if (sci_getreg(port, SCSMR)->size)
+		regs->scsmr = sci_serial_in(port, SCSMR);
+	if (sci_getreg(port, SCSCR)->size)
+		regs->scscr = sci_serial_in(port, SCSCR);
+	if (sci_getreg(port, SCFCR)->size)
+		regs->scfcr = sci_serial_in(port, SCFCR);
+	if (sci_getreg(port, SCSPTR)->size)
+		regs->scsptr = sci_serial_in(port, SCSPTR);
+	if (sci_getreg(port, SCBRR)->size)
+		regs->scbrr = sci_serial_in(port, SCBRR);
+	if (sci_getreg(port, HSSRR)->size)
+		regs->hssrr = sci_serial_in(port, HSSRR);
+	if (sci_getreg(port, SCPCR)->size)
+		regs->scpcr = sci_serial_in(port, SCPCR);
+	if (sci_getreg(port, SCPDR)->size)
+		regs->scpdr = sci_serial_in(port, SCPDR);
+	if (sci_getreg(port, SEMR)->size)
+		regs->semr = sci_serial_in(port, SEMR);
+}
+
+static void sci_console_restore(struct sci_port *s)
+{
+	struct sci_suspend_regs *regs = &s->suspend_regs;
+	struct uart_port *port = &s->port;
+
+	if (sci_getreg(port, SCDL)->size)
+		sci_serial_out(port, SCDL, regs->scdl);
+	if (sci_getreg(port, SCCKS)->size)
+		sci_serial_out(port, SCCKS, regs->sccks);
+	if (sci_getreg(port, SCSMR)->size)
+		sci_serial_out(port, SCSMR, regs->scsmr);
+	if (sci_getreg(port, SCSCR)->size)
+		sci_serial_out(port, SCSCR, regs->scscr);
+	if (sci_getreg(port, SCFCR)->size)
+		sci_serial_out(port, SCFCR, regs->scfcr);
+	if (sci_getreg(port, SCSPTR)->size)
+		sci_serial_out(port, SCSPTR, regs->scsptr);
+	if (sci_getreg(port, SCBRR)->size)
+		sci_serial_out(port, SCBRR, regs->scbrr);
+	if (sci_getreg(port, HSSRR)->size)
+		sci_serial_out(port, HSSRR, regs->hssrr);
+	if (sci_getreg(port, SCPCR)->size)
+		sci_serial_out(port, SCPCR, regs->scpcr);
+	if (sci_getreg(port, SCPDR)->size)
+		sci_serial_out(port, SCPDR, regs->scpdr);
+	if (sci_getreg(port, SEMR)->size)
+		sci_serial_out(port, SEMR, regs->semr);
+}
+
 static __maybe_unused int sci_suspend(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
 		uart_suspend_port(&sci_uart_driver, &sport->port);
 
+		if (!console_suspend_enabled && uart_console(&sport->port))
+			sci_console_save(sport);
+		else
+			return reset_control_assert(sport->rstc);
+	}
+
 	return 0;
 }
 
@@ -3414,8 +3496,18 @@ static __maybe_unused int sci_resume(struct device *dev)
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
+	if (sport) {
+		if (!console_suspend_enabled && uart_console(&sport->port)) {
+			sci_console_restore(sport);
+		} else {
+			int ret = reset_control_deassert(sport->rstc);
+
+			if (ret)
+				return ret;
+		}
+
 		uart_resume_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 7d11511c8c12..8670bb5042c4 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -850,7 +850,7 @@ static void stm32_usart_enable_ms(struct uart_port *port)
 
 static void stm32_usart_disable_ms(struct uart_port *port)
 {
-	mctrl_gpio_disable_ms(to_stm32_port(port)->gpios);
+	mctrl_gpio_disable_ms_sync(to_stm32_port(port)->gpios);
 }
 
 /* Transmit stop */
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 7902e1ec0fef..105243d83b2d 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1806,7 +1806,8 @@ int vfio_config_init(struct vfio_pci_core_device *vdev)
 					cpu_to_le16(PCI_COMMAND_MEMORY);
 	}
 
-	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx)
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
+	    vdev->pdev->irq == IRQ_NOTCONNECTED)
 		vconfig[PCI_INTERRUPT_PIN] = 0;
 
 	ret = vfio_cap_init(vdev);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f357fd157e1e..aa362b434413 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -719,15 +719,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_finish_enable);
 static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_type)
 {
 	if (irq_type == VFIO_PCI_INTX_IRQ_INDEX) {
-		u8 pin;
-
-		if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) ||
-		    vdev->nointx || vdev->pdev->is_virtfn)
-			return 0;
-
-		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
-
-		return pin ? 1 : 0;
+		return vdev->vconfig[PCI_INTERRUPT_PIN] ? 1 : 0;
 	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX) {
 		u8 pos;
 		u16 flags;
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 5cbcde32ff79..64d78944efa5 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -207,7 +207,7 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 	if (!is_irq_none(vdev))
 		return -EINVAL;
 
-	if (!pdev->irq)
+	if (!pdev->irq || pdev->irq == IRQ_NOTCONNECTED)
 		return -ENODEV;
 
 	name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-intx(%s)", pci_name(pdev));
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 8587c9da0670..42e681a78136 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -59,12 +59,11 @@ static void bit_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		      int sx, int height, int width)
+		      int sx, int height, int width, int fg, int bg)
 {
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	struct fb_fillrect region;
 
-	region.color = attr_bgcol_ec(bgshift, vc, info);
+	region.color = bg;
 	region.dx = sx * vc->vc_font.width;
 	region.dy = sy * vc->vc_font.height;
 	region.width = width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index e6640edec155..538e932055ca 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1240,7 +1240,7 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
-
+	int fg, bg;
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	u_int y_break;
 
@@ -1261,16 +1261,18 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 		fbcon_clear_margins(vc, 0);
 	}
 
+	fg = get_color(vc, info, vc->vc_video_erase_char, 1);
+	bg = get_color(vc, info, vc->vc_video_erase_char, 0);
 	/* Split blits that cross physical y_wrap boundary */
 
 	y_break = p->vrows - p->yscroll;
 	if (sy < y_break && sy + height - 1 >= y_break) {
 		u_int b = y_break - sy;
-		ops->clear(vc, info, real_y(p, sy), sx, b, width);
+		ops->clear(vc, info, real_y(p, sy), sx, b, width, fg, bg);
 		ops->clear(vc, info, real_y(p, sy + b), sx, height - b,
-				 width);
+				 width, fg, bg);
 	} else
-		ops->clear(vc, info, real_y(p, sy), sx, height, width);
+		ops->clear(vc, info, real_y(p, sy), sx, height, width, fg, bg);
 }
 
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 0eaf54a21151..25691d4b027b 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -55,7 +55,7 @@ struct fbcon_ops {
 	void (*bmove)(struct vc_data *vc, struct fb_info *info, int sy,
 		      int sx, int dy, int dx, int height, int width);
 	void (*clear)(struct vc_data *vc, struct fb_info *info, int sy,
-		      int sx, int height, int width);
+		      int sx, int height, int width, int fb, int bg);
 	void (*putcs)(struct vc_data *vc, struct fb_info *info,
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg);
@@ -116,42 +116,6 @@ static inline int mono_col(const struct fb_info *info)
 	return (~(0xfff << max_len)) & 0xff;
 }
 
-static inline int attr_col_ec(int shift, struct vc_data *vc,
-			      struct fb_info *info, int is_fg)
-{
-	int is_mono01;
-	int col;
-	int fg;
-	int bg;
-
-	if (!vc)
-		return 0;
-
-	if (vc->vc_can_do_color)
-		return is_fg ? attr_fgcol(shift,vc->vc_video_erase_char)
-			: attr_bgcol(shift,vc->vc_video_erase_char);
-
-	if (!info)
-		return 0;
-
-	col = mono_col(info);
-	is_mono01 = info->fix.visual == FB_VISUAL_MONO01;
-
-	if (attr_reverse(vc->vc_video_erase_char)) {
-		fg = is_mono01 ? col : 0;
-		bg = is_mono01 ? 0 : col;
-	}
-	else {
-		fg = is_mono01 ? 0 : col;
-		bg = is_mono01 ? col : 0;
-	}
-
-	return is_fg ? fg : bg;
-}
-
-#define attr_bgcol_ec(bgshift, vc, info) attr_col_ec(bgshift, vc, info, 0)
-#define attr_fgcol_ec(fgshift, vc, info) attr_col_ec(fgshift, vc, info, 1)
-
     /*
      *  Scroll Method
      */
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 2789ace79634..9f4d65478554 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -78,14 +78,13 @@ static void ccw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void ccw_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vyres = GETVYRES(ops->p, info);
 
-	region.color = attr_bgcol_ec(bgshift,vc,info);
+	region.color = bg;
 	region.dx = sy * vc->vc_font.height;
 	region.dy = vyres - ((sx + width) * vc->vc_font.width);
 	region.height = width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 86a254c1b2b7..b18e31886da1 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -63,14 +63,13 @@ static void cw_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void cw_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vxres = GETVXRES(ops->p, info);
 
-	region.color = attr_bgcol_ec(bgshift,vc,info);
+	region.color = bg;
 	region.dx = vxres - ((sy + height) * vc->vc_font.height);
 	region.dy = sx *  vc->vc_font.width;
 	region.height = width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 23bc045769d0..b6b074cfd9dc 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -64,15 +64,14 @@ static void ud_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void ud_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		     int sx, int height, int width)
+		     int sx, int height, int width, int fg, int bg)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	struct fb_fillrect region;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	u32 vyres = GETVYRES(ops->p, info);
 	u32 vxres = GETVXRES(ops->p, info);
 
-	region.color = attr_bgcol_ec(bgshift,vc,info);
+	region.color = bg;
 	region.dy = vyres - ((sy + height) * vc->vc_font.height);
 	region.dx = vxres - ((sx + width) *  vc->vc_font.width);
 	region.width = width * vc->vc_font.width;
diff --git a/drivers/video/fbdev/core/tileblit.c b/drivers/video/fbdev/core/tileblit.c
index 2768eff247ba..b3aa0c6620c7 100644
--- a/drivers/video/fbdev/core/tileblit.c
+++ b/drivers/video/fbdev/core/tileblit.c
@@ -32,16 +32,14 @@ static void tile_bmove(struct vc_data *vc, struct fb_info *info, int sy,
 }
 
 static void tile_clear(struct vc_data *vc, struct fb_info *info, int sy,
-		       int sx, int height, int width)
+		       int sx, int height, int width, int fg, int bg)
 {
 	struct fb_tilerect rect;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
 
 	rect.index = vc->vc_video_erase_char &
 		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
-	rect.fg = attr_fgcol_ec(fgshift, vc, info);
-	rect.bg = attr_bgcol_ec(bgshift, vc, info);
+	rect.fg = fg;
+	rect.bg = bg;
 	rect.sx = sx;
 	rect.sy = sy;
 	rect.width = width;
@@ -76,7 +74,42 @@ static void tile_putcs(struct vc_data *vc, struct fb_info *info,
 static void tile_clear_margins(struct vc_data *vc, struct fb_info *info,
 			       int color, int bottom_only)
 {
-	return;
+	unsigned int cw = vc->vc_font.width;
+	unsigned int ch = vc->vc_font.height;
+	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
+	unsigned int bh = info->var.yres - (vc->vc_rows*ch);
+	unsigned int rs = info->var.xres - rw;
+	unsigned int bs = info->var.yres - bh;
+	unsigned int vwt = info->var.xres_virtual / cw;
+	unsigned int vht = info->var.yres_virtual / ch;
+	struct fb_tilerect rect;
+
+	rect.index = vc->vc_video_erase_char &
+		((vc->vc_hi_font_mask) ? 0x1ff : 0xff);
+	rect.fg = color;
+	rect.bg = color;
+
+	if ((int) rw > 0 && !bottom_only) {
+		rect.sx = (info->var.xoffset + rs + cw - 1) / cw;
+		rect.sy = 0;
+		rect.width = (rw + cw - 1) / cw;
+		rect.height = vht;
+		if (rect.width + rect.sx > vwt)
+			rect.width = vwt - rect.sx;
+		if (rect.sx < vwt)
+			info->tileops->fb_tilefill(info, &rect);
+	}
+
+	if ((int) bh > 0) {
+		rect.sx = info->var.xoffset / cw;
+		rect.sy = (info->var.yoffset + bs) / ch;
+		rect.width = rs / cw;
+		rect.height = (bh + ch - 1) / ch;
+		if (rect.height + rect.sy > vht)
+			rect.height = vht - rect.sy;
+		if (rect.sy < vht)
+			info->tileops->fb_tilefill(info, &rect);
+	}
 }
 
 static void tile_cursor(struct vc_data *vc, struct fb_info *info, int mode,
diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index ce3c5b0b8f4e..53be4ab374cc 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1829,6 +1829,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7d320f799ca1..06a64c4adc98 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2415,7 +2415,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	if (vq->event_triggered)
-		vq->event_triggered = false;
+		data_race(vq->event_triggered = false);
 
 	return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) :
 				 virtqueue_enable_cb_delayed_split(_vq);
diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 544d3f9010b9..1db82da56db6 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -26,6 +26,8 @@
 
 #define DRV_NAME    "xen-platform-pci"
 
+#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002
+
 static unsigned long platform_mmio;
 static unsigned long platform_mmio_alloc;
 static unsigned long platform_mmiolen;
@@ -174,6 +176,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
 static const struct pci_device_id platform_pci_tbl[] = {
 	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 25164d56c9d9..d3b6908110c6 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -966,9 +966,15 @@ static int __init xenbus_init(void)
 	if (xen_pv_domain())
 		xen_store_domain_type = XS_PV;
 	if (xen_hvm_domain())
+	{
 		xen_store_domain_type = XS_HVM;
-	if (xen_hvm_domain() && xen_initial_domain())
-		xen_store_domain_type = XS_LOCAL;
+		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
+		if (err)
+			goto out_error;
+		xen_store_evtchn = (int)v;
+		if (!v && xen_initial_domain())
+			xen_store_domain_type = XS_LOCAL;
+	}
 	if (xen_pv_domain() && !xen_start_info->store_evtchn)
 		xen_store_domain_type = XS_LOCAL;
 	if (xen_pv_domain() && xen_start_info->store_evtchn)
@@ -987,10 +993,6 @@ static int __init xenbus_init(void)
 		xen_store_interface = gfn_to_virt(xen_store_gfn);
 		break;
 	case XS_HVM:
-		err = hvm_get_parameter(HVM_PARAM_STORE_EVTCHN, &v);
-		if (err)
-			goto out_error;
-		xen_store_evtchn = (int)v;
 		err = hvm_get_parameter(HVM_PARAM_STORE_PFN, &v);
 		if (err)
 			goto out_error;
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0dcf7fecaf55..91440ef79a26 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1678,6 +1678,17 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
+
+		/*
+		 * Cache the zone_unusable value before turning the block group
+		 * to read only. As soon as the block group is read only it's
+		 * zone_unusable value gets moved to the block group's read-only
+		 * bytes and isn't available for calculations anymore. We also
+		 * cache it before unlocking the block group, to prevent races
+		 * (reports from KCSAN and such tools) with tasks updating it.
+		 */
+		zone_unusable = bg->zone_unusable;
+
 		spin_unlock(&bg->lock);
 
 		/*
@@ -1693,13 +1704,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			goto next;
 		}
 
-		/*
-		 * Cache the zone_unusable value before turning the block group
-		 * to read only. As soon as the blog group is read only it's
-		 * zone_unusable value gets moved to the block group's read-only
-		 * bytes and isn't available for calculations anymore.
-		 */
-		zone_unusable = bg->zone_unusable;
 		ret = inc_block_group_ro(bg, 0);
 		up_write(&space_info->groups_sem);
 		if (ret < 0)
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 7b2f77a8aa98..a90f3cb83c70 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -152,13 +152,7 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	block_group->discard_eligible_time = 0;
 	queued = !list_empty(&block_group->discard_list);
 	list_del_init(&block_group->discard_list);
-	/*
-	 * If the block group is currently running in the discard workfn, we
-	 * don't want to deref it, since it's still being used by the workfn.
-	 * The workfn will notice this case and deref the block group when it is
-	 * finished.
-	 */
-	if (queued && !running)
+	if (queued)
 		btrfs_put_block_group(block_group);
 
 	spin_unlock(&discard_ctl->lock);
@@ -256,9 +250,10 @@ static struct btrfs_block_group *peek_discard_list(
 			block_group->discard_cursor = block_group->start;
 			block_group->discard_state = BTRFS_DISCARD_EXTENTS;
 		}
-		discard_ctl->block_group = block_group;
 	}
 	if (block_group) {
+		btrfs_get_block_group(block_group);
+		discard_ctl->block_group = block_group;
 		*discard_state = block_group->discard_state;
 		*discard_index = block_group->discard_index;
 	}
@@ -482,9 +477,20 @@ static void btrfs_discard_workfn(struct work_struct *work)
 
 	block_group = peek_discard_list(discard_ctl, &discard_state,
 					&discard_index, now);
-	if (!block_group || !btrfs_run_discard_work(discard_ctl))
+	if (!block_group)
 		return;
+	if (!btrfs_run_discard_work(discard_ctl)) {
+		spin_lock(&discard_ctl->lock);
+		btrfs_put_block_group(block_group);
+		discard_ctl->block_group = NULL;
+		spin_unlock(&discard_ctl->lock);
+		return;
+	}
 	if (now < block_group->discard_eligible_time) {
+		spin_lock(&discard_ctl->lock);
+		btrfs_put_block_group(block_group);
+		discard_ctl->block_group = NULL;
+		spin_unlock(&discard_ctl->lock);
 		btrfs_discard_schedule_work(discard_ctl, false);
 		return;
 	}
@@ -536,15 +542,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	spin_lock(&discard_ctl->lock);
 	discard_ctl->prev_discard = trimmed;
 	discard_ctl->prev_discard_time = now;
-	/*
-	 * If the block group was removed from the discard list while it was
-	 * running in this workfn, then we didn't deref it, since this function
-	 * still owned that reference. But we set the discard_ctl->block_group
-	 * back to NULL, so we can use that condition to know that now we need
-	 * to deref the block_group.
-	 */
-	if (discard_ctl->block_group == NULL)
-		btrfs_put_block_group(block_group);
+	btrfs_put_block_group(block_group);
 	discard_ctl->block_group = NULL;
 	__btrfs_discard_schedule_work(discard_ctl, now, false);
 	spin_unlock(&discard_ctl->lock);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index de4f590fe30f..8c0da0025bc7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4641,6 +4641,14 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* clear out the rbtree of defraggable inodes */
 	btrfs_cleanup_defrag_inodes(fs_info);
 
+	/*
+	 * Handle the error fs first, as it will flush and wait for all ordered
+	 * extents.  This will generate delayed iputs, thus we want to handle
+	 * it first.
+	 */
+	if (unlikely(BTRFS_FS_ERROR(fs_info)))
+		btrfs_error_commit_super(fs_info);
+
 	/*
 	 * Wait for any fixup workers to complete.
 	 * If we don't wait for them here and they are still running by the time
@@ -4661,6 +4669,19 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_flush_workqueue(fs_info->delalloc_workers);
 
+	/*
+	 * We can have ordered extents getting their last reference dropped from
+	 * the fs_info->workers queue because for async writes for data bios we
+	 * queue a work for that queue, at btrfs_wq_submit_bio(), that runs
+	 * run_one_async_done() which calls btrfs_bio_end_io() in case the bio
+	 * has an error, and that later function can do the final
+	 * btrfs_put_ordered_extent() on the ordered extent attached to the bio,
+	 * which adds a delayed iput for the inode. So we must flush the queue
+	 * so that we don't have delayed iputs after committing the current
+	 * transaction below and stopping the cleaner and transaction kthreads.
+	 */
+	btrfs_flush_workqueue(fs_info->workers);
+
 	/*
 	 * When finishing a compressed write bio we schedule a work queue item
 	 * to finish an ordered extent - btrfs_finish_compressed_write_work()
@@ -4730,9 +4751,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 			btrfs_err(fs_info, "commit super ret %d", ret);
 	}
 
-	if (BTRFS_FS_ERROR(fs_info))
-		btrfs_error_commit_super(fs_info);
-
 	kthread_stop(fs_info->transaction_kthread);
 	kthread_stop(fs_info->cleaner_kthread);
 
@@ -4888,10 +4906,6 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
 	/* cleanup FS via transaction */
 	btrfs_cleanup_transaction(fs_info);
 
-	mutex_lock(&fs_info->cleaner_mutex);
-	btrfs_run_delayed_iputs(fs_info);
-	mutex_unlock(&fs_info->cleaner_mutex);
-
 	down_write(&fs_info->cleanup_work_sem);
 	up_write(&fs_info->cleanup_work_sem);
 }
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 72227c0b4b5a..d5552875f872 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4459,10 +4459,10 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 	return eb;
 }
 
-#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					u64 start)
 {
+#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	struct extent_buffer *eb, *exists = NULL;
 	int ret;
 
@@ -4498,8 +4498,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 free_eb:
 	btrfs_release_extent_buffer(eb);
 	return exists;
-}
+#else
+	/* Stub to avoid linker error when compiled with optimizations turned off. */
+	return NULL;
 #endif
+}
 
 static struct extent_buffer *grab_extent_buffer(
 		struct btrfs_fs_info *fs_info, struct page *page)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d6cda0b2e925..fd6ea3fcab33 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2977,6 +2977,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	int ret;
 
 	ASSERT(page_index <= last_index);
+again:
 	page = find_lock_page(inode->i_mapping, page_index);
 	if (!page) {
 		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
@@ -2998,6 +2999,11 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 			ret = -EIO;
 			goto release_page;
 		}
+		if (page->mapping != inode->i_mapping) {
+			unlock_page(page);
+			put_page(page);
+			goto again;
+		}
 	}
 
 	/*
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a2b95ccb4cf5..0735decec99b 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -431,10 +431,8 @@ static int fs_path_ensure_buf(struct fs_path *p, int len)
 	if (p->buf_len >= len)
 		return 0;
 
-	if (len > PATH_MAX) {
-		WARN_ON(1);
-		return -ENOMEM;
-	}
+	if (WARN_ON(len > PATH_MAX))
+		return -ENAMETOOLONG;
 
 	path_len = p->end - p->start;
 	old_buf_len = p->buf_len;
diff --git a/fs/coredump.c b/fs/coredump.c
index 4d332f147137..b0d782367fcc 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -42,6 +42,7 @@
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
 #include <linux/elf.h>
+#include <uapi/linux/pidfd.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -56,6 +57,13 @@
 static bool dump_vma_snapshot(struct coredump_params *cprm);
 static void free_vma_snapshot(struct coredump_params *cprm);
 
+/*
+ * File descriptor number for the pidfd for the thread-group leader of
+ * the coredumping task installed into the usermode helper's file
+ * descriptor table.
+ */
+#define COREDUMP_PIDFD_NUMBER 3
+
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
@@ -325,6 +333,27 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 				err = cn_printf(cn, "%lu",
 					      rlimit(RLIMIT_CORE));
 				break;
+			/* pidfd number */
+			case 'F': {
+				/*
+				 * Installing a pidfd only makes sense if
+				 * we actually spawn a usermode helper.
+				 */
+				if (!ispipe)
+					break;
+
+				/*
+				 * Note that we'll install a pidfd for the
+				 * thread-group leader. We know that task
+				 * linkage hasn't been removed yet and even if
+				 * this @current isn't the actual thread-group
+				 * leader we know that the thread-group leader
+				 * cannot be reaped until @current has exited.
+				 */
+				cprm->pid = task_tgid(current);
+				err = cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
+				break;
+			}
 			default:
 				break;
 			}
@@ -479,7 +508,7 @@ static void wait_for_dump_helpers(struct file *file)
 }
 
 /*
- * umh_pipe_setup
+ * umh_coredump_setup
  * helper function to customize the process used
  * to collect the core in userspace.  Specifically
  * it sets up a pipe and installs it as fd 0 (stdin)
@@ -489,21 +518,61 @@ static void wait_for_dump_helpers(struct file *file)
  * is a special value that we use to trap recursive
  * core dumps
  */
-static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
+static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 {
 	struct file *files[2];
+	struct file *pidfs_file = NULL;
 	struct coredump_params *cp = (struct coredump_params *)info->data;
-	int err = create_pipe_files(files, 0);
+	int err;
+
+	if (cp->pid) {
+		int fd;
+
+		fd = pidfd_prepare(cp->pid, 0, &pidfs_file);
+		if (fd < 0)
+			return fd;
+
+		/*
+		 * We don't care about the fd. We also cannot simply
+		 * replace it below because dup2() will refuse to close
+		 * this file descriptor if its in a larval state. So
+		 * close it!
+		 */
+		put_unused_fd(fd);
+
+		/*
+		 * Usermode helpers are childen of either
+		 * system_unbound_wq or of kthreadd. So we know that
+		 * we're starting off with a clean file descriptor
+		 * table. So we should always be able to use
+		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
+		 */
+		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
+		if (err < 0)
+			goto out_fail;
+
+		pidfs_file = NULL;
+	}
+
+	err = create_pipe_files(files, 0);
 	if (err)
-		return err;
+		goto out_fail;
 
 	cp->file = files[1];
 
 	err = replace_fd(0, files[0], 0);
 	fput(files[0]);
+	if (err < 0)
+		goto out_fail;
+
 	/* and disallow core files too */
 	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
 
+	err = 0;
+
+out_fail:
+	if (pidfs_file)
+		fput(pidfs_file);
 	return err;
 }
 
@@ -580,7 +649,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 
 		if (cprm.limit == 1) {
-			/* See umh_pipe_setup() which sets RLIMIT_CORE = 1.
+			/* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
 			 *
 			 * Normally core limits are irrelevant to pipes, since
 			 * we're not writing to the file system, but we use
@@ -625,7 +694,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		retval = -ENOMEM;
 		sub_info = call_usermodehelper_setup(helper_argv[0],
 						helper_argv, NULL, GFP_KERNEL,
-						umh_pipe_setup, NULL, &cprm);
+						umh_coredump_setup, NULL, &cprm);
 		if (sub_info)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 2c797eb519da..51a641822d6c 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1863,8 +1863,8 @@ static int dlm_tcp_listen_validate(void)
 {
 	/* We don't support multi-homed hosts */
 	if (dlm_local_count > 1) {
-		log_print("TCP protocol can't handle multi-homed hosts, try SCTP");
-		return -EINVAL;
+		log_print("Detect multi-homed hosts but use only the first IP address.");
+		log_print("Try SCTP, if you want to enable multi-link.");
 	}
 
 	return 0;
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index fbd0329cf254..9efe97f3721b 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -638,8 +638,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
 	/* Hm, nope.  Are (enough) root reserved clusters available? */
 	if (uid_eq(sbi->s_resuid, current_fsuid()) ||
 	    (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) && in_group_p(sbi->s_resgid)) ||
-	    capable(CAP_SYS_RESOURCE) ||
-	    (flags & EXT4_MB_USE_ROOT_BLOCKS)) {
+	    (flags & EXT4_MB_USE_ROOT_BLOCKS) ||
+	    capable(CAP_SYS_RESOURCE)) {
 
 		if (free_clusters >= (nclusters + dirty_clusters +
 				      resv_clusters))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 7f0231b34905..f829f989f2b5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2741,6 +2741,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 	}
 
 	if (is_remount) {
+		if (!sbi->s_journal &&
+		    ctx_test_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT)) {
+			ext4_msg(NULL, KERN_WARNING,
+				 "Remounting fs w/o journal so ignoring data_err option");
+			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT);
+		}
+
 		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS) &&
 		    (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)) {
 			ext4_msg(NULL, KERN_ERR, "can't mount with "
@@ -5318,6 +5325,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 				 "data=, fs mounted w/o journal");
 			goto failed_mount3a;
 		}
+		if (test_opt(sb, DATA_ERR_ABORT)) {
+			ext4_msg(sb, KERN_ERR,
+				 "can't mount with data_err=abort, fs mounted w/o journal");
+			goto failed_mount3a;
+		}
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index c431abbf48e6..0dbacdd7bb0d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1068,6 +1068,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	else if (err == -EINTR)
 		fuse_invalidate_attr(inode);
 
+	if (err == -ENOSYS)
+		err = -EPERM;
 	return err;
 }
 
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 6ba8460f5331..428c1db295fa 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -885,11 +885,12 @@ static void run_queue(struct gfs2_glock *gl, const int nonblock)
 __releases(&gl->gl_lockref.lock)
 __acquires(&gl->gl_lockref.lock)
 {
-	struct gfs2_holder *gh = NULL;
+	struct gfs2_holder *gh;
 
 	if (test_and_set_bit(GLF_LOCK, &gl->gl_flags))
 		return;
 
+	/* While a demote is in progress, the GLF_LOCK flag must be set. */
 	GLOCK_BUG_ON(gl, test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags));
 
 	if (test_bit(GLF_DEMOTE, &gl->gl_flags) &&
@@ -901,18 +902,22 @@ __acquires(&gl->gl_lockref.lock)
 		set_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
 		GLOCK_BUG_ON(gl, gl->gl_demote_state == LM_ST_EXCLUSIVE);
 		gl->gl_target = gl->gl_demote_state;
+		do_xmote(gl, NULL, gl->gl_target);
+		return;
 	} else {
 		if (test_bit(GLF_DEMOTE, &gl->gl_flags))
 			gfs2_demote_wake(gl);
 		if (do_promote(gl) == 0)
 			goto out_unlock;
 		gh = find_first_waiter(gl);
+		if (!gh)
+			goto out_unlock;
 		gl->gl_target = gh->gh_state;
 		if (!(gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
 			do_error(gl, 0); /* Fail queued try locks */
+		do_xmote(gl, gh, gl->gl_target);
+		return;
 	}
-	do_xmote(gl, gh, gl->gl_target);
-	return;
 
 out_sched:
 	clear_bit(GLF_LOCK, &gl->gl_flags);
diff --git a/fs/namespace.c b/fs/namespace.c
index 0dcd57a75ad4..211a81240680 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -632,12 +632,8 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 	smp_mb();		// see mntput_no_expire() and do_umount()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
-	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
-		mnt_add_count(mnt, -1);
-		return 1;
-	}
 	lock_mount_hash();
-	if (unlikely(bastard->mnt_flags & MNT_DOOMED)) {
+	if (unlikely(bastard->mnt_flags & (MNT_SYNC_UMOUNT | MNT_DOOMED))) {
 		mnt_add_count(mnt, -1);
 		unlock_mount_hash();
 		return 1;
diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index a8930e6c417f..de4ad41b14e2 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1052,6 +1052,8 @@ struct nfs_server *nfs_create_server(struct fs_context *fc)
 		if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
 			server->namelen = NFS2_MAXNAMLEN;
 	}
+	/* Linux 'subtree_check' borkenness mandates this setting */
+	server->fh_expire_type = NFS_FH_VOL_RENAME;
 
 	if (!(fattr->valid & NFS_ATTR_FATTR)) {
 		error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 6363bbc37f42..17b38da17288 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -297,7 +297,8 @@ nfs_start_delegation_return_locked(struct nfs_inode *nfsi)
 	if (delegation == NULL)
 		goto out;
 	spin_lock(&delegation->lock);
-	if (!test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
+	if (delegation->inode &&
+	    !test_and_set_bit(NFS_DELEGATION_RETURNING, &delegation->flags)) {
 		clear_bit(NFS_DELEGATION_RETURN_DELAYED, &delegation->flags);
 		/* Refcount matched in nfs_end_delegation_return() */
 		ret = nfs_get_delegation(delegation);
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 70660ff248b7..1876978107ca 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2632,6 +2632,18 @@ nfs_unblock_rename(struct rpc_task *task, struct nfs_renamedata *data)
 	unblock_revalidate(new_dentry);
 }
 
+static bool nfs_rename_is_unsafe_cross_dir(struct dentry *old_dentry,
+					   struct dentry *new_dentry)
+{
+	struct nfs_server *server = NFS_SB(old_dentry->d_sb);
+
+	if (old_dentry->d_parent != new_dentry->d_parent)
+		return false;
+	if (server->fh_expire_type & NFS_FH_RENAME_UNSAFE)
+		return !(server->fh_expire_type & NFS_FH_NOEXPIRE_WITH_OPEN);
+	return true;
+}
+
 /*
  * RENAME
  * FIXME: Some nfsds, like the Linux user space nfsd, may generate a
@@ -2719,7 +2731,8 @@ int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	}
 
-	if (S_ISREG(old_inode->i_mode))
+	if (S_ISREG(old_inode->i_mode) &&
+	    nfs_rename_is_unsafe_cross_dir(old_dentry, new_dentry))
 		nfs_sync_inode(old_inode);
 	task = nfs_async_rename(old_dir, new_dir, old_dentry, new_dentry,
 				must_unblock ? nfs_unblock_rename : NULL);
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index acf4b88889dc..d5f1fbfd9a0c 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -75,6 +75,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct page *scratch;
 	struct list_head dsaddrs;
 	struct nfs4_pnfs_ds_addr *da;
+	struct net *net = server->nfs_client->cl_net;
 
 	/* set up xdr stream */
 	scratch = alloc_page(gfp_flags);
@@ -158,8 +159,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 		mp_count = be32_to_cpup(p); /* multipath count */
 		for (j = 0; j < mp_count; j++) {
-			da = nfs4_decode_mp_ds_addr(server->nfs_client->cl_net,
-						    &stream, gfp_flags);
+			da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
 			if (da)
 				list_add_tail(&da->da_node, &dsaddrs);
 		}
@@ -169,7 +169,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			goto out_err_free_deviceid;
 		}
 
-		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
+		dsaddr->ds_list[i] = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
 		if (!dsaddr->ds_list[i])
 			goto out_err_drain_dsaddrs;
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8056b05bd8dc..07e5ea64dcd6 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1255,6 +1255,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index e028f5a0ef5f..d21c5ecfbf1c 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -49,6 +49,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct nfs4_pnfs_ds_addr *da;
 	struct nfs4_ff_layout_ds *new_ds = NULL;
 	struct nfs4_ff_ds_version *ds_versions = NULL;
+	struct net *net = server->nfs_client->cl_net;
 	u32 mp_count;
 	u32 version_count;
 	__be32 *p;
@@ -80,8 +81,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 	for (i = 0; i < mp_count; i++) {
 		/* multipath ds */
-		da = nfs4_decode_mp_ds_addr(server->nfs_client->cl_net,
-					    &stream, gfp_flags);
+		da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
 		if (da)
 			list_add_tail(&da->da_node, &dsaddrs);
 	}
@@ -149,7 +149,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	new_ds->ds_versions = ds_versions;
 	new_ds->ds_versions_cnt = version_count;
 
-	new_ds->ds = nfs4_pnfs_ds_add(&dsaddrs, gfp_flags);
+	new_ds->ds = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
 	if (!new_ds->ds)
 		goto out_err_drain_dsaddrs;
 
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 964df0725f4c..f2e66b946f4b 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -74,6 +74,8 @@ nfs_fattr_to_ino_t(struct nfs_fattr *fattr)
 
 int nfs_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
+	if (unlikely(nfs_current_task_exiting()))
+		return -EINTR;
 	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ece517ebcca0..84361674bffc 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -832,6 +832,11 @@ static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 				NFS4_STATEID_OTHER_SIZE);
 }
 
+static inline bool nfs_current_task_exiting(void)
+{
+	return (current->flags & PF_EXITING) != 0;
+}
+
 static inline bool nfs_error_is_fatal(int err)
 {
 	switch (err) {
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 2e7579626cf0..f036d30f7515 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -39,7 +39,7 @@ nfs3_rpc_wrapper(struct rpc_clnt *clnt, struct rpc_message *msg, int flags)
 		__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 		schedule_timeout(NFS_JUKEBOX_RETRY_TIME);
 		res = -ERESTARTSYS;
-	} while (!fatal_signal_pending(current));
+	} while (!fatal_signal_pending(current) && !nfs_current_task_exiting());
 	return res;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index acef50824d1a..0f28607c5747 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -422,6 +422,8 @@ static int nfs4_delay_killable(long *timeout)
 {
 	might_sleep();
 
+	if (unlikely(nfs_current_task_exiting()))
+		return -EINTR;
 	__set_current_state(TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 	schedule_timeout(nfs4_update_delay(timeout));
 	if (!__fatal_signal_pending(current))
@@ -433,6 +435,8 @@ static int nfs4_delay_interruptible(long *timeout)
 {
 	might_sleep();
 
+	if (unlikely(nfs_current_task_exiting()))
+		return -EINTR;
 	__set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE_UNSAFE);
 	schedule_timeout(nfs4_update_delay(timeout));
 	if (!signal_pending(current))
@@ -1712,7 +1716,8 @@ static void nfs_set_open_stateid_locked(struct nfs4_state *state,
 		rcu_read_unlock();
 		trace_nfs4_open_stateid_update_wait(state->inode, stateid, 0);
 
-		if (!fatal_signal_pending(current)) {
+		if (!fatal_signal_pending(current) &&
+		    !nfs_current_task_exiting()) {
 			if (schedule_timeout(5*HZ) == 0)
 				status = -EAGAIN;
 			else
@@ -3500,7 +3505,7 @@ static bool nfs4_refresh_open_old_stateid(nfs4_stateid *dst,
 		write_sequnlock(&state->seqlock);
 		trace_nfs4_close_stateid_update_wait(state->inode, dst, 0);
 
-		if (fatal_signal_pending(current))
+		if (fatal_signal_pending(current) || nfs_current_task_exiting())
 			status = -EINTR;
 		else
 			if (schedule_timeout(5*HZ) != 0)
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 48ea40660422..80a7c5bd7a47 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2737,7 +2737,15 @@ static void nfs4_state_manager(struct nfs_client *clp)
 	pr_warn_ratelimited("NFS: state manager%s%s failed on NFSv4 server %s"
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
-	ssleep(1);
+	switch (status) {
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		nfs_mark_client_ready(clp, -EIO);
+		break;
+	default:
+		ssleep(1);
+		break;
+	}
 out_drain:
 	memalloc_nofs_restore(memflags);
 	nfs4_end_drain_session(clp);
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index e3e6a41f19de..f5173c188184 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -59,6 +59,7 @@ struct nfs4_pnfs_ds {
 	struct list_head	ds_node;  /* nfs4_pnfs_dev_hlist dev_dslist */
 	char			*ds_remotestr;	/* comma sep list of addrs */
 	struct list_head	ds_addrs;
+	const struct net	*ds_net;
 	struct nfs_client	*ds_clp;
 	refcount_t		ds_count;
 	unsigned long		ds_state;
@@ -405,7 +406,8 @@ int pnfs_generic_commit_pagelist(struct inode *inode,
 int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max);
 void pnfs_generic_write_commit_done(struct rpc_task *task, void *data);
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds);
-struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(struct list_head *dsaddrs,
+struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(const struct net *net,
+				      struct list_head *dsaddrs,
 				      gfp_t gfp_flags);
 void nfs4_pnfs_v3_ds_connect_unload(void);
 int nfs4_pnfs_ds_connect(struct nfs_server *mds_srv, struct nfs4_pnfs_ds *ds,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 47a8da3f5c9f..31afa88742f6 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -651,12 +651,12 @@ _same_data_server_addrs_locked(const struct list_head *dsaddrs1,
  * Lookup DS by addresses.  nfs4_ds_cache_lock is held
  */
 static struct nfs4_pnfs_ds *
-_data_server_lookup_locked(const struct list_head *dsaddrs)
+_data_server_lookup_locked(const struct net *net, const struct list_head *dsaddrs)
 {
 	struct nfs4_pnfs_ds *ds;
 
 	list_for_each_entry(ds, &nfs4_data_server_cache, ds_node)
-		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
+		if (ds->ds_net == net && _same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
 			return ds;
 	return NULL;
 }
@@ -763,7 +763,7 @@ nfs4_pnfs_remotestr(struct list_head *dsaddrs, gfp_t gfp_flags)
  * uncached and return cached struct nfs4_pnfs_ds.
  */
 struct nfs4_pnfs_ds *
-nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
+nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_flags)
 {
 	struct nfs4_pnfs_ds *tmp_ds, *ds = NULL;
 	char *remotestr;
@@ -781,13 +781,14 @@ nfs4_pnfs_ds_add(struct list_head *dsaddrs, gfp_t gfp_flags)
 	remotestr = nfs4_pnfs_remotestr(dsaddrs, gfp_flags);
 
 	spin_lock(&nfs4_ds_cache_lock);
-	tmp_ds = _data_server_lookup_locked(dsaddrs);
+	tmp_ds = _data_server_lookup_locked(net, dsaddrs);
 	if (tmp_ds == NULL) {
 		INIT_LIST_HEAD(&ds->ds_addrs);
 		list_splice_init(dsaddrs, &ds->ds_addrs);
 		ds->ds_remotestr = remotestr;
 		refcount_set(&ds->ds_count, 1);
 		INIT_LIST_HEAD(&ds->ds_node);
+		ds->ds_net = net;
 		ds->ds_clp = NULL;
 		list_add(&ds->ds_node, &nfs4_data_server_cache);
 		dprintk("%s add new data server %s\n", __func__,
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index b3bbb5a5787a..cc81ff6ac735 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -23,9 +23,9 @@ static int orangefs_writepage_locked(struct page *page,
 	struct orangefs_write_range *wr = NULL;
 	struct iov_iter iter;
 	struct bio_vec bv;
-	size_t len, wlen;
+	size_t wlen;
 	ssize_t ret;
-	loff_t off;
+	loff_t len, off;
 
 	set_page_writeback(page);
 
@@ -94,8 +94,7 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	struct orangefs_write_range *wrp, wr;
 	struct iov_iter iter;
 	ssize_t ret;
-	size_t len;
-	loff_t off;
+	loff_t len, off;
 	int i;
 
 	len = i_size_read(inode);
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index d1fd54fb3cc1..9a30425b75a9 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -30,6 +30,9 @@ extern void cifs_small_buf_release(void *);
 extern void free_rsp_buf(int, void *);
 extern int smb_send(struct TCP_Server_Info *, struct smb_hdr *,
 			unsigned int /* length */);
+extern int smb_send_kvec(struct TCP_Server_Info *server,
+			 struct msghdr *msg,
+			 size_t *sent);
 extern unsigned int _get_xid(void);
 extern void _free_xid(unsigned int);
 #define get_xid()							\
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 6aeb25006db8..76c04c4ed45f 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2966,8 +2966,10 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 	 * sessinit is sent but no second negprot
 	 */
 	struct rfc1002_session_packet req = {};
-	struct smb_hdr *smb_buf = (struct smb_hdr *)&req;
+	struct msghdr msg = {};
+	struct kvec iov = {};
 	unsigned int len;
+	size_t sent;
 
 	req.trailer.session_req.called_len = sizeof(req.trailer.session_req.called_name);
 
@@ -2996,10 +2998,18 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 	 * As per rfc1002, @len must be the number of bytes that follows the
 	 * length field of a rfc1002 session request payload.
 	 */
-	len = sizeof(req) - offsetof(struct rfc1002_session_packet, trailer.session_req);
+	len = sizeof(req.trailer.session_req);
+	req.type = RFC1002_SESSION_REQUEST;
+	req.flags = 0;
+	req.length = cpu_to_be16(len);
+	len += offsetof(typeof(req), trailer.session_req);
+	iov.iov_base = &req;
+	iov.iov_len = len;
+	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &iov, 1, len);
+	rc = smb_send_kvec(server, &msg, &sent);
+	if (rc < 0 || len != sent)
+		return (rc == -EINTR || rc == -EAGAIN) ? rc : -ECONNABORTED;
 
-	smb_buf->smb_buf_length = cpu_to_be32((RFC1002_SESSION_REQUEST << 24) | len);
-	rc = smb_send(server, smb_buf, len);
 	/*
 	 * RFC1001 layer in at least one server requires very short break before
 	 * negprot presumably because not expecting negprot to follow so fast.
@@ -3008,7 +3018,7 @@ ip_rfc1001_connect(struct TCP_Server_Info *server)
 	 */
 	usleep_range(1000, 2000);
 
-	return rc;
+	return 0;
 }
 
 static int
@@ -4178,11 +4188,13 @@ int
 cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
 			struct TCP_Server_Info *server)
 {
+	bool in_retry = false;
 	int rc = 0;
 
 	if (!server->ops->need_neg || !server->ops->negotiate)
 		return -ENOSYS;
 
+retry:
 	/* only send once per connect */
 	spin_lock(&server->srv_lock);
 	if (server->tcpStatus != CifsGood &&
@@ -4202,6 +4214,14 @@ cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses,
 	spin_unlock(&server->srv_lock);
 
 	rc = server->ops->negotiate(xid, ses, server);
+	if (rc == -EAGAIN) {
+		/* Allow one retry attempt */
+		if (!in_retry) {
+			in_retry = true;
+			goto retry;
+		}
+		rc = -EHOSTDOWN;
+	}
 	if (rc == 0) {
 		spin_lock(&server->srv_lock);
 		if (server->tcpStatus == CifsInNegotiate)
diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
index c0f101fc1e5d..d71feb3fdbd2 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -269,7 +269,7 @@ cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_open_parms oparms;
 	struct cifs_io_parms io_parms = {0};
 	int buf_type = CIFS_NO_BUFFER;
-	FILE_ALL_INFO file_info;
+	struct cifs_open_info_data query_data;
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
@@ -281,11 +281,11 @@ cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 		.fid = &fid,
 	};
 
-	rc = CIFS_open(xid, &oparms, &oplock, &file_info);
+	rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, &query_data);
 	if (rc)
 		return rc;
 
-	if (file_info.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
+	if (query_data.fi.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
 		rc = -ENOENT;
 		/* it's not a symlink */
 		goto out;
@@ -324,7 +324,7 @@ cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 		.fid = &fid,
 	};
 
-	rc = CIFS_open(xid, &oparms, &oplock, NULL);
+	rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, NULL);
 	if (rc)
 		return rc;
 
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 9a1f1913fb59..402ac06ae9b6 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -765,7 +765,10 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 			else
 				cifs_buf_release(cfile->srch_inf.
 						ntwrk_buf_start);
+			/* Reset all pointers to the network buffer to prevent stale references */
 			cfile->srch_inf.ntwrk_buf_start = NULL;
+			cfile->srch_inf.srch_entries_start = NULL;
+			cfile->srch_inf.last_entry = NULL;
 		}
 		rc = initiate_cifs_search(xid, file, full_path);
 		if (rc) {
@@ -788,11 +791,11 @@ find_cifs_entry(const unsigned int xid, struct cifs_tcon *tcon, loff_t pos,
 		rc = server->ops->query_dir_next(xid, tcon, &cfile->fid,
 						 search_flags,
 						 &cfile->srch_inf);
+		if (rc)
+			return -ENOENT;
 		/* FindFirst/Next set last_entry to NULL on malformed reply */
 		if (cfile->srch_inf.last_entry)
 			cifs_save_resume_key(cfile->srch_inf.last_entry, cfile);
-		if (rc)
-			return -ENOENT;
 	}
 	if (index_to_find < cfile->srch_inf.index_of_last_entry) {
 		/* we found the buffer that contains the entry */
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 225cc7e0304c..1489b9d21b60 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -426,13 +426,6 @@ cifs_negotiate(const unsigned int xid,
 {
 	int rc;
 	rc = CIFSSMBNegotiate(xid, ses, server);
-	if (rc == -EAGAIN) {
-		/* retry only once on 1st time connection */
-		set_credits(server, 1);
-		rc = CIFSSMBNegotiate(xid, ses, server);
-		if (rc == -EAGAIN)
-			rc = -EHOSTDOWN;
-	}
 	return rc;
 }
 
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index a7475bc05cac..afdc78e92ee9 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -108,16 +108,25 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32
 	int err_buftype = CIFS_NO_BUFFER;
 	struct cifs_fid *fid = oparms->fid;
 	struct network_resiliency_req nr_ioctl_req;
+	bool retry_without_read_attributes = false;
 
 	smb2_path = cifs_convert_path_to_utf16(oparms->path, oparms->cifs_sb);
 	if (smb2_path == NULL)
 		return -ENOMEM;
 
-	oparms->desired_access |= FILE_READ_ATTRIBUTES;
+	if (!(oparms->desired_access & FILE_READ_ATTRIBUTES)) {
+		oparms->desired_access |= FILE_READ_ATTRIBUTES;
+		retry_without_read_attributes = true;
+	}
 	smb2_oplock = SMB2_OPLOCK_LEVEL_BATCH;
 
 	rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL, &err_iov,
 		       &err_buftype);
+	if (rc == -EACCES && retry_without_read_attributes) {
+		oparms->desired_access &= ~FILE_READ_ATTRIBUTES;
+		rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL, &err_iov,
+			       &err_buftype);
+	}
 	if (rc && data) {
 		struct smb2_hdr *hdr = err_iov.iov_base;
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a62f3e5a7689..c9b9892b510e 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -422,9 +422,6 @@ smb2_negotiate(const unsigned int xid,
 	server->CurrentMid = 0;
 	spin_unlock(&server->mid_lock);
 	rc = SMB2_negotiate(xid, ses, server);
-	/* BB we probably don't need to retry with modern servers */
-	if (rc == -EAGAIN)
-		rc = -EHOSTDOWN;
 	return rc;
 }
 
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 3fdafb9297f1..d2867bd263c5 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -178,7 +178,7 @@ delete_mid(struct mid_q_entry *mid)
  * Our basic "send data to server" function. Should be called with srv_mutex
  * held. The caller is responsible for handling the results.
  */
-static int
+int
 smb_send_kvec(struct TCP_Server_Info *server, struct msghdr *smb_msg,
 	      size_t *sent)
 {
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index cf1b241a1578..fa647b75fba8 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -423,10 +423,15 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
 		    *pos, count);
 
+	if (*pos >= XATTR_SIZE_MAX) {
+		pr_err("stream write position %lld is out of bounds\n",	*pos);
+		return -EINVAL;
+	}
+
 	size = *pos + count;
 	if (size > XATTR_SIZE_MAX) {
 		size = XATTR_SIZE_MAX;
-		count = (*pos + count) - XATTR_SIZE_MAX;
+		count = XATTR_SIZE_MAX - *pos;
 	}
 
 	v_len = ksmbd_vfs_getcasexattr(user_ns,
@@ -440,13 +445,6 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		goto out;
 	}
 
-	if (v_len <= *pos) {
-		pr_err("stream write position %lld is out of bounds (stream length: %zd)\n",
-				*pos, v_len);
-		err = -EINVAL;
-		goto out;
-	}
-
 	if (v_len < size) {
 		wbuf = kvzalloc(size, GFP_KERNEL);
 		if (!wbuf) {
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 10b1990bc1f6..36225aedf613 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -372,8 +372,27 @@ struct drm_atomic_state {
 	 *
 	 * Allow full modeset. This is used by the ATOMIC IOCTL handler to
 	 * implement the DRM_MODE_ATOMIC_ALLOW_MODESET flag. Drivers should
-	 * never consult this flag, instead looking at the output of
-	 * drm_atomic_crtc_needs_modeset().
+	 * generally not consult this flag, but instead look at the output of
+	 * drm_atomic_crtc_needs_modeset(). The detailed rules are:
+	 *
+	 * - Drivers must not consult @allow_modeset in the atomic commit path.
+	 *   Use drm_atomic_crtc_needs_modeset() instead.
+	 *
+	 * - Drivers must consult @allow_modeset before adding unrelated struct
+	 *   drm_crtc_state to this commit by calling
+	 *   drm_atomic_get_crtc_state(). See also the warning in the
+	 *   documentation for that function.
+	 *
+	 * - Drivers must never change this flag, it is under the exclusive
+	 *   control of userspace.
+	 *
+	 * - Drivers may consult @allow_modeset in the atomic check path, if
+	 *   they have the choice between an optimal hardware configuration
+	 *   which requires a modeset, and a less optimal configuration which
+	 *   can be committed without a modeset. An example would be suboptimal
+	 *   scanout FIFO allocation resulting in increased idle power
+	 *   consumption. This allows userspace to avoid flickering and delays
+	 *   for the normal composition loop at reasonable cost.
 	 */
 	bool allow_modeset : 1;
 	/**
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 08a1d3e7e46d..2b7ec58299ca 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -28,6 +28,7 @@ struct coredump_params {
 	int vma_count;
 	size_t vma_data_size;
 	struct core_vma_metadata *vma_meta;
+	struct pid *pid;
 };
 
 /*
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e13050eb9777..af3f39ecc1b8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -598,10 +598,14 @@ static inline int dma_mmap_wc(struct device *dev,
 #else
 #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
 #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
-#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
-#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
-#define dma_unmap_len(PTR, LEN_NAME)             (0)
-#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
+#define dma_unmap_addr(PTR, ADDR_NAME)           \
+	({ typeof(PTR) __p __maybe_unused = PTR; 0; })
+#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  \
+	do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
+#define dma_unmap_len(PTR, LEN_NAME)             \
+	({ typeof(PTR) __p __maybe_unused = PTR; 0; })
+#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    \
+	do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
 #endif
 
 #endif /* _LINUX_DMA_MAPPING_H */
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 8f77bb0f4ae0..05f8b7d7d1e9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -237,6 +237,7 @@ struct hrtimer_cpu_base {
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
+	call_single_data_t		csd;
 } ____cacheline_aligned;
 
 static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 9a44de45cc1f..9f27e004127b 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -199,6 +199,7 @@ struct inet6_cork {
 	struct ipv6_txoptions *opt;
 	u8 hop_limit;
 	u8 tclass;
+	u8 dontfrag:1;
 };
 
 /**
diff --git a/include/linux/lzo.h b/include/linux/lzo.h
index e95c7d1092b2..4d30e3624acd 100644
--- a/include/linux/lzo.h
+++ b/include/linux/lzo.h
@@ -24,10 +24,18 @@
 int lzo1x_1_compress(const unsigned char *src, size_t src_len,
 		     unsigned char *dst, size_t *dst_len, void *wrkmem);
 
+/* Same as above but does not write more than dst_len to dst. */
+int lzo1x_1_compress_safe(const unsigned char *src, size_t src_len,
+			  unsigned char *dst, size_t *dst_len, void *wrkmem);
+
 /* This requires 'wrkmem' of size LZO1X_1_MEM_COMPRESS */
 int lzorle1x_1_compress(const unsigned char *src, size_t src_len,
 		     unsigned char *dst, size_t *dst_len, void *wrkmem);
 
+/* Same as above but does not write more than dst_len to dst. */
+int lzorle1x_1_compress_safe(const unsigned char *src, size_t src_len,
+			     unsigned char *dst, size_t *dst_len, void *wrkmem);
+
 /* safe decompression with overrun testing */
 int lzo1x_decompress_safe(const unsigned char *src, size_t src_len,
 			  unsigned char *dst, size_t *dst_len);
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 6646634a0b9d..0cb296f0f8d1 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -1115,7 +1115,7 @@ int mlx4_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 int mlx4_buf_write_mtt(struct mlx4_dev *dev, struct mlx4_mtt *mtt,
 		       struct mlx4_buf *buf);
 
-int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, int order);
+int mlx4_db_alloc(struct mlx4_dev *dev, struct mlx4_db *db, unsigned int order);
 void mlx4_db_free(struct mlx4_dev *dev, struct mlx4_db *db);
 
 int mlx4_alloc_hwq_res(struct mlx4_dev *dev, struct mlx4_hwq_resources *wqres,
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e5dfb9cf3aa1..1bf8d126f792 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -129,6 +129,10 @@ struct pci_msi_desc {
  * @dev:	Pointer to the device which uses this descriptor
  * @msg:	The last set MSI message cached for reuse
  * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
+ * @iommu_msi_iova: Optional shifted IOVA from the IOMMU to override the msi_addr.
+ *                  Only used if iommu_msi_shift != 0
+ * @iommu_msi_shift: Indicates how many bits of the original address should be
+ *                   preserved when using iommu_msi_iova.
  * @sysfs_attr:	Pointer to sysfs device attribute
  *
  * @write_msi_msg:	Callback that may be called when the MSI message
@@ -146,7 +150,8 @@ struct msi_desc {
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
 #ifdef CONFIG_IRQ_MSI_IOMMU
-	const void			*iommu_cookie;
+	u64				iommu_msi_iova : 58;
+	u64				iommu_msi_shift : 6;
 #endif
 #ifdef CONFIG_SYSFS
 	struct device_attribute		*sysfs_attrs;
@@ -214,28 +219,14 @@ struct msi_desc *msi_next_desc(struct device *dev, enum msi_desc_filter filter);
 
 #define msi_desc_to_dev(desc)		((desc)->dev)
 
-#ifdef CONFIG_IRQ_MSI_IOMMU
-static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
-{
-	return desc->iommu_cookie;
-}
-
-static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
-					     const void *iommu_cookie)
-{
-	desc->iommu_cookie = iommu_cookie;
-}
-#else
-static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
+static inline void msi_desc_set_iommu_msi_iova(struct msi_desc *desc, u64 msi_iova,
+					       unsigned int msi_shift)
 {
-	return NULL;
-}
-
-static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
-					     const void *iommu_cookie)
-{
-}
+#ifdef CONFIG_IRQ_MSI_IOMMU
+	desc->iommu_msi_iova = msi_iova >> msi_shift;
+	desc->iommu_msi_shift = msi_shift;
 #endif
+}
 
 #ifdef CONFIG_PCI_MSI
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 9ea9f9087a71..a9671f930084 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -196,6 +196,15 @@ struct nfs_server {
 	char			*fscache_uniq;	/* Uniquifier (or NULL) */
 #endif
 
+	/* The following #defines numerically match the NFSv4 equivalents */
+#define NFS_FH_NOEXPIRE_WITH_OPEN (0x1)
+#define NFS_FH_VOLATILE_ANY (0x2)
+#define NFS_FH_VOL_MIGRATION (0x4)
+#define NFS_FH_VOL_RENAME (0x8)
+#define NFS_FH_RENAME_UNSAFE (NFS_FH_VOLATILE_ANY | NFS_FH_VOL_RENAME)
+	u32			fh_expire_type;	/* V4 bitmask representing file
+						   handle volatility type for
+						   this filesystem */
 	u32			pnfs_blksize;	/* layout_blksize attr */
 #if IS_ENABLED(CONFIG_NFS_V4)
 	u32			attr_bitmask[3];/* V4 bitmask representing the set
@@ -219,9 +228,6 @@ struct nfs_server {
 	u32			acl_bitmask;	/* V4 bitmask representing the ACEs
 						   that are supported on this
 						   filesystem */
-	u32			fh_expire_type;	/* V4 bitmask representing file
-						   handle volatility type for
-						   this filesystem */
 	struct pnfs_layoutdriver_type  *pnfs_curr_ld; /* Active layout driver */
 	struct rpc_wait_queue	roc_rpcwaitq;
 	void			*pnfs_ld_data;	/* per mount point data */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 27b694552d58..41ff70f315a9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -935,7 +935,13 @@ struct perf_output_handle {
 	struct perf_buffer		*rb;
 	unsigned long			wakeup;
 	unsigned long			size;
-	u64				aux_flags;
+	union {
+		u64			flags;		/* perf_output*() */
+		u64			aux_flags;	/* perf_aux_output*() */
+		struct {
+			u64		skip_read : 1;
+		};
+	};
 	union {
 		void			*addr;
 		unsigned long		head;
diff --git a/include/linux/pid.h b/include/linux/pid.h
index bf3af54de616..653a527574c4 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -80,6 +80,7 @@ extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
 int pidfd_create(struct pid *pid, unsigned int flags);
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index aef8c7304d45..d1c35009831b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -97,9 +97,9 @@ static inline void __rcu_read_lock(void)
 
 static inline void __rcu_read_unlock(void)
 {
-	preempt_enable();
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		rcu_read_unlock_strict();
+	preempt_enable();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 5efb51486e8a..54483d5e6f91 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -105,7 +105,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
diff --git a/include/linux/trace.h b/include/linux/trace.h
index 2a70a447184c..bb4d84f1c58c 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -72,8 +72,8 @@ static inline int unregister_ftrace_export(struct trace_export *export)
 static inline void trace_printk_init_buffers(void)
 {
 }
-static inline int trace_array_printk(struct trace_array *tr, unsigned long ip,
-				     const char *fmt, ...)
+static inline __printf(3, 4)
+int trace_array_printk(struct trace_array *tr, unsigned long ip, const char *fmt, ...)
 {
 	return 0;
 }
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 5a2c650d9e1c..c230cbd25aee 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -77,8 +77,8 @@ extern __printf(2, 3)
 void trace_seq_printf(struct trace_seq *s, const char *fmt, ...);
 extern __printf(2, 0)
 void trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args);
-extern void
-trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary);
+extern __printf(2, 0)
+void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary);
 extern int trace_print_seq(struct seq_file *m, struct trace_seq *s);
 extern int trace_seq_to_user(struct trace_seq *s, char __user *ubuf,
 			     int cnt);
@@ -100,8 +100,8 @@ extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 static inline void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 {
 }
-static inline void
-trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
+static inline __printf(2, 0)
+void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
 {
 }
 
diff --git a/include/linux/usb/r8152.h b/include/linux/usb/r8152.h
index 33a4c146dc19..2ca60828f28b 100644
--- a/include/linux/usb/r8152.h
+++ b/include/linux/usb/r8152.h
@@ -30,6 +30,7 @@
 #define VENDOR_ID_NVIDIA		0x0955
 #define VENDOR_ID_TPLINK		0x2357
 #define VENDOR_ID_DLINK			0x2001
+#define VENDOR_ID_DELL			0x413c
 #define VENDOR_ID_ASUS			0x0b05
 
 #if IS_REACHABLE(CONFIG_USB_RTL8152)
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index e7d71a516bd4..b1f82d74339e 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -8,20 +8,46 @@
 #include <linux/refcount.h>
 #include <net/sock.h>
 
-void unix_inflight(struct user_struct *user, struct file *fp);
-void unix_notinflight(struct user_struct *user, struct file *fp);
-void unix_destruct_scm(struct sk_buff *skb);
+#if IS_ENABLED(CONFIG_UNIX)
+struct unix_sock *unix_get_socket(struct file *filp);
+#else
+static inline struct unix_sock *unix_get_socket(struct file *filp)
+{
+	return NULL;
+}
+#endif
+
+extern unsigned int unix_tot_inflight;
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
+void unix_del_edges(struct scm_fp_list *fpl);
+void unix_update_edges(struct unix_sock *receiver);
+int unix_prepare_fpl(struct scm_fp_list *fpl);
+void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
-void wait_for_unix_gc(void);
-struct sock *unix_get_socket(struct file *filp);
+void wait_for_unix_gc(struct scm_fp_list *fpl);
+
+struct unix_vertex {
+	struct list_head edges;
+	struct list_head entry;
+	struct list_head scc_entry;
+	unsigned long out_degree;
+	unsigned long index;
+	unsigned long scc_index;
+};
+
+struct unix_edge {
+	struct unix_sock *predecessor;
+	struct unix_sock *successor;
+	struct list_head vertex_entry;
+	struct list_head stack_entry;
+};
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
 #define UNIX_HASH_SIZE	(256 * 2)
 #define UNIX_HASH_BITS	8
 
-extern unsigned int unix_tot_inflight;
-
 struct unix_address {
 	refcount_t	refcnt;
 	int		len;
@@ -41,6 +67,7 @@ struct unix_skb_parms {
 
 struct scm_stat {
 	atomic_t nr_fds;
+	unsigned long nr_unix_fds;
 };
 
 #define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
@@ -53,12 +80,9 @@ struct unix_sock {
 	struct path		path;
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
-	struct list_head	link;
-	unsigned long		inflight;
+	struct sock		*listener;
+	struct unix_vertex	*vertex;
 	spinlock_t		lock;
-	unsigned long		gc_flags;
-#define UNIX_GC_CANDIDATE	0
-#define UNIX_GC_MAYBE_CYCLE	1
 	struct socket_wq	peer_wq;
 	wait_queue_entry_t	peer_wake;
 	struct scm_stat		scm_stat;
diff --git a/include/net/scm.h b/include/net/scm.h
index 585adc1346bd..0be0dc3eb1dc 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -21,9 +21,20 @@ struct scm_creds {
 	kgid_t	gid;
 };
 
+#ifdef CONFIG_UNIX
+struct unix_edge;
+#endif
+
 struct scm_fp_list {
 	short			count;
+	short			count_unix;
 	short			max;
+#ifdef CONFIG_UNIX
+	bool			inflight;
+	bool			dead;
+	struct list_head	vertices;
+	struct unix_edge	*edges;
+#endif
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
 };
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index bf670929622d..64911162ab5f 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -212,7 +212,6 @@ struct xfrm_state {
 
 	/* Data for encapsulator */
 	struct xfrm_encap_tmpl	*encap;
-	struct sock __rcu	*encap_sk;
 
 	/* Data for care-of address */
 	xfrm_address_t	*coaddr;
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index fe0512116958..555ea3d142a4 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -34,7 +34,7 @@
 static inline void *_uobj_get_obj_read(struct ib_uobject *uobj)
 {
 	if (IS_ERR(uobj))
-		return NULL;
+		return ERR_CAST(uobj);
 	return uobj->object;
 }
 #define uobj_get_obj_read(_object, _type, _id, _attrs)                         \
diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index bbb7805e85d8..4ca45d5895df 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -199,6 +199,7 @@ struct hda_codec {
 	/* beep device */
 	struct hda_beep *beep;
 	unsigned int beep_mode;
+	bool beep_just_power_on;
 
 	/* widget capabilities cache */
 	u32 *wcaps;
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 27040b472a4f..51881ffbd155 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1429,6 +1429,8 @@ int snd_pcm_lib_mmap_iomem(struct snd_pcm_substream *substream, struct vm_area_s
 #define snd_pcm_lib_mmap_iomem	NULL
 #endif
 
+void snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime);
+
 /**
  * snd_pcm_limit_isa_dma_size - Get the max size fitting with ISA DMA transfer
  * @dma: DMA number
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 7a6c5a870d33..31847ccae493 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1847,7 +1847,7 @@ DECLARE_EVENT_CLASS(btrfs__prelim_ref,
 	TP_PROTO(const struct btrfs_fs_info *fs_info,
 		 const struct prelim_ref *oldref,
 		 const struct prelim_ref *newref, u64 tree_size),
-	TP_ARGS(fs_info, newref, oldref, tree_size),
+	TP_ARGS(fs_info, oldref, newref, tree_size),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  root_id		)
diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index ea2c2ded4e41..4a5053169977 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -79,11 +79,11 @@ static __cold void __io_uring_show_fdinfo(struct io_ring_ctx *ctx,
 	seq_printf(m, "SqMask:\t0x%x\n", sq_mask);
 	seq_printf(m, "SqHead:\t%u\n", sq_head);
 	seq_printf(m, "SqTail:\t%u\n", sq_tail);
-	seq_printf(m, "CachedSqHead:\t%u\n", ctx->cached_sq_head);
+	seq_printf(m, "CachedSqHead:\t%u\n", data_race(ctx->cached_sq_head));
 	seq_printf(m, "CqMask:\t0x%x\n", cq_mask);
 	seq_printf(m, "CqHead:\t%u\n", cq_head);
 	seq_printf(m, "CqTail:\t%u\n", cq_tail);
-	seq_printf(m, "CachedCqTail:\t%u\n", ctx->cached_cq_tail);
+	seq_printf(m, "CachedCqTail:\t%u\n", data_race(ctx->cached_cq_tail));
 	seq_printf(m, "SQEs:\t%u\n", sq_tail - sq_head);
 	sq_entries = min(sq_tail - sq_head, ctx->sq_entries);
 	for (i = 0; i < sq_entries; i++) {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index f39d66589180..ad462724246a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -627,6 +627,7 @@ static bool __io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 		 * to care for a non-real case.
 		 */
 		if (need_resched()) {
+			ctx->cqe_sentinel = ctx->cqe_cached;
 			io_cq_unlock_post(ctx);
 			mutex_unlock(&ctx->uring_lock);
 			cond_resched();
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index dae9ed02a75b..06bc7f26be06 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2172,7 +2172,7 @@ static int bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_f
 		b = &htab->buckets[i];
 		rcu_read_lock();
 		head = &b->head;
-		hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+		hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
 			key = elem->key;
 			if (is_percpu) {
 				/* current cpu value for percpu map */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 27fdf1b2fc46..b145f3ef3695 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4005,6 +4005,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.recursion_misses = stats.misses;
 
 	info.verified_insns = prog->aux->verified_insns;
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
@@ -4151,8 +4153,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6e54f0daebef..7997c8021b62 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -90,7 +90,7 @@
 DEFINE_MUTEX(cgroup_mutex);
 DEFINE_SPINLOCK(css_set_lock);
 
-#ifdef CONFIG_PROVE_RCU
+#if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
 EXPORT_SYMBOL_GPL(cgroup_mutex);
 EXPORT_SYMBOL_GPL(css_set_lock);
 #endif
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8fc2bc5646ee..552bb00bfceb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1180,6 +1180,12 @@ static void perf_event_ctx_deactivate(struct perf_event_context *ctx)
 	list_del_init(&ctx->active_ctx_list);
 }
 
+static inline void perf_pmu_read(struct perf_event *event)
+{
+	if (event->state == PERF_EVENT_STATE_ACTIVE)
+		event->pmu->read(event);
+}
+
 static void get_ctx(struct perf_event_context *ctx)
 {
 	refcount_inc(&ctx->refcount);
@@ -3389,8 +3395,7 @@ static void __perf_event_sync_stat(struct perf_event *event,
 	 * we know the event must be on the current CPU, therefore we
 	 * don't need to use it.
 	 */
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	perf_pmu_read(event);
 
 	perf_event_update_time(event);
 
@@ -4444,15 +4449,8 @@ static void __perf_event_read(void *info)
 
 	pmu->read(event);
 
-	for_each_sibling_event(sub, event) {
-		if (sub->state == PERF_EVENT_STATE_ACTIVE) {
-			/*
-			 * Use sibling's PMU rather than @event's since
-			 * sibling could be on different (eg: software) PMU.
-			 */
-			sub->pmu->read(sub);
-		}
-	}
+	for_each_sibling_event(sub, event)
+		perf_pmu_read(sub);
 
 	data->ret = pmu->commit_txn(pmu);
 
@@ -7101,9 +7099,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
 		values[n++] = running;
 
-	if ((leader != event) &&
-	    (leader->state == PERF_EVENT_STATE_ACTIVE))
-		leader->pmu->read(leader);
+	if ((leader != event) && !handle->skip_read)
+		perf_pmu_read(leader);
 
 	values[n++] = perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
@@ -7116,9 +7113,8 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	for_each_sibling_event(sub, leader) {
 		n = 0;
 
-		if ((sub != event) &&
-		    (sub->state == PERF_EVENT_STATE_ACTIVE))
-			sub->pmu->read(sub);
+		if ((sub != event) && !handle->skip_read)
+			perf_pmu_read(sub);
 
 		values[n++] = perf_event_count(sub);
 		if (read_format & PERF_FORMAT_ID)
@@ -7173,6 +7169,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 {
 	u64 sample_type = data->type;
 
+	if (data->sample_flags & PERF_SAMPLE_READ)
+		handle->skip_read = 1;
+
 	perf_output_put(handle, *header);
 
 	if (sample_type & PERF_SAMPLE_IDENTIFIER)
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index c3797701339c..382a3b04f6d3 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -978,9 +978,10 @@ static int hw_breakpoint_event_init(struct perf_event *bp)
 		return -ENOENT;
 
 	/*
-	 * no branch sampling for breakpoint events
+	 * Check if breakpoint type is supported before proceeding.
+	 * Also, no branch sampling for breakpoint events.
 	 */
-	if (has_branch_stack(bp))
+	if (!hw_breakpoint_slots_cached(find_slot_idx(bp->attr.bp_type)) || has_branch_stack(bp))
 		return -EOPNOTSUPP;
 
 	err = register_perf_hw_breakpoint(bp);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 3e1655374c2e..4c4894de6e5d 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -181,6 +181,7 @@ __perf_output_begin(struct perf_output_handle *handle,
 
 	handle->rb    = rb;
 	handle->event = event;
+	handle->flags = 0;
 
 	have_lost = local_read(&rb->lost);
 	if (unlikely(have_lost)) {
diff --git a/kernel/fork.c b/kernel/fork.c
index 09a935724bd9..8cc313d27188 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1943,6 +1943,91 @@ const struct file_operations pidfd_fops = {
 #endif
 };
 
+/**
+ * __pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
+ * @pid:   the struct pid for which to create a pidfd
+ * @flags: flags of the new @pidfd
+ * @pidfd: the pidfd to return
+ *
+ * Allocate a new file that stashes @pid and reserve a new pidfd number in the
+ * caller's file descriptor table. The pidfd is reserved but not installed yet.
+
+ * The helper doesn't perform checks on @pid which makes it useful for pidfds
+ * created via CLONE_PIDFD where @pid has no task attached when the pidfd and
+ * pidfd file are prepared.
+ *
+ * If this function returns successfully the caller is responsible to either
+ * call fd_install() passing the returned pidfd and pidfd file as arguments in
+ * order to install the pidfd into its file descriptor table or they must use
+ * put_unused_fd() and fput() on the returned pidfd and pidfd file
+ * respectively.
+ *
+ * This function is useful when a pidfd must already be reserved but there
+ * might still be points of failure afterwards and the caller wants to ensure
+ * that no pidfd is leaked into its file descriptor table.
+ *
+ * Return: On success, a reserved pidfd is returned from the function and a new
+ *         pidfd file is returned in the last argument to the function. On
+ *         error, a negative error code is returned from the function and the
+ *         last argument remains unchanged.
+ */
+static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
+{
+	int pidfd;
+	struct file *pidfd_file;
+
+	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
+		return -EINVAL;
+
+	pidfd = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+	if (pidfd < 0)
+		return pidfd;
+
+	pidfd_file = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
+					flags | O_RDWR | O_CLOEXEC);
+	if (IS_ERR(pidfd_file)) {
+		put_unused_fd(pidfd);
+		return PTR_ERR(pidfd_file);
+	}
+	get_pid(pid); /* held by pidfd_file now */
+	*ret = pidfd_file;
+	return pidfd;
+}
+
+/**
+ * pidfd_prepare - allocate a new pidfd_file and reserve a pidfd
+ * @pid:   the struct pid for which to create a pidfd
+ * @flags: flags of the new @pidfd
+ * @pidfd: the pidfd to return
+ *
+ * Allocate a new file that stashes @pid and reserve a new pidfd number in the
+ * caller's file descriptor table. The pidfd is reserved but not installed yet.
+ *
+ * The helper verifies that @pid is used as a thread group leader.
+ *
+ * If this function returns successfully the caller is responsible to either
+ * call fd_install() passing the returned pidfd and pidfd file as arguments in
+ * order to install the pidfd into its file descriptor table or they must use
+ * put_unused_fd() and fput() on the returned pidfd and pidfd file
+ * respectively.
+ *
+ * This function is useful when a pidfd must already be reserved but there
+ * might still be points of failure afterwards and the caller wants to ensure
+ * that no pidfd is leaked into its file descriptor table.
+ *
+ * Return: On success, a reserved pidfd is returned from the function and a new
+ *         pidfd file is returned in the last argument to the function. On
+ *         error, a negative error code is returned from the function and the
+ *         last argument remains unchanged.
+ */
+int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
+{
+	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+		return -EINVAL;
+
+	return __pidfd_prepare(pid, flags, ret);
+}
+
 static void __delayed_free_task(struct rcu_head *rhp)
 {
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
@@ -2293,21 +2378,12 @@ static __latent_entropy struct task_struct *copy_process(
 	 * if the fd table isn't shared).
 	 */
 	if (clone_flags & CLONE_PIDFD) {
-		retval = get_unused_fd_flags(O_RDWR | O_CLOEXEC);
+		/* Note that no task has been attached to @pid yet. */
+		retval = __pidfd_prepare(pid, O_RDWR | O_CLOEXEC, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
-
 		pidfd = retval;
 
-		pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
-					      O_RDWR | O_CLOEXEC);
-		if (IS_ERR(pidfile)) {
-			put_unused_fd(pidfd);
-			retval = PTR_ERR(pidfile);
-			goto bad_fork_free_pid;
-		}
-		get_pid(pid);	/* held by pidfile now */
-
 		retval = put_user(pidfd, args->pidfd);
 		if (retval)
 			goto bad_fork_put_pidfd;
diff --git a/kernel/padata.c b/kernel/padata.c
index e2bef90e6fd0..b3f79f23060c 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -350,7 +350,8 @@ static void padata_reorder(struct parallel_data *pd)
 		 * To avoid UAF issue, add pd ref here, and put pd ref after reorder_work finish.
 		 */
 		padata_get_pd(pd);
-		queue_work(pinst->serial_wq, &pd->reorder_work);
+		if (!queue_work(pinst->serial_wq, &pd->reorder_work))
+			padata_put_pd(pd);
 	}
 }
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 74834c04a081..8bce3aebc949 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -594,20 +594,15 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
  */
 int pidfd_create(struct pid *pid, unsigned int flags)
 {
-	int fd;
-
-	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
-		return -EINVAL;
+	int pidfd;
+	struct file *pidfd_file;
 
-	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
-		return -EINVAL;
-
-	fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
-			      flags | O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		put_pid(pid);
+	pidfd = pidfd_prepare(pid, flags, &pidfd_file);
+	if (pidfd < 0)
+		return pidfd;
 
-	return fd;
+	fd_install(pidfd, pidfd_file);
+	return pidfd;
 }
 
 /**
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 044026abfdd7..3929ef8148c1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -821,8 +821,17 @@ void rcu_read_unlock_strict(void)
 {
 	struct rcu_data *rdp;
 
-	if (irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+	if (irqs_disabled() || in_atomic_preempt_off() || !rcu_state.gp_kthread)
 		return;
+
+	/*
+	 * rcu_report_qs_rdp() can only be invoked with a stable rdp and
+	 * from the local CPU.
+	 *
+	 * The in_atomic_preempt_off() check ensures that we come here holding
+	 * the last preempt_count (which will get dropped once we return to
+	 * __rcu_read_unlock().
+	 */
 	rdp = this_cpu_ptr(&rcu_data);
 	rdp->cpu_no_qs.b.norm = false;
 	rcu_report_qs_rdp(rdp);
@@ -963,13 +972,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      (preempt_count() == HARDIRQ_OFFSET))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding the task preempt count
+		 * (with PREEMPT_COUNT=y). In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6665f5cd60cb..9ab5ca399a99 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -140,6 +140,18 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name			= "local_bh",
+	.key			= &bh_lock_key,
+	.wait_type_outer	= LD_WAIT_FREE,
+	.wait_type_inner	= LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type		= LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);
+#endif
+
 /**
  * local_bh_blocked() - Check for idle whether BH processing is blocked
  *
@@ -162,6 +174,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
 	WARN_ON_ONCE(in_hardirq());
 
+	lock_map_acquire_read(&bh_lock_map);
+
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
@@ -225,6 +239,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
+	lock_map_release(&bh_lock_map);
+
 	local_irq_save(flags);
 	curcnt = __this_cpu_read(softirq_ctrl.cnt);
 
@@ -275,6 +291,8 @@ static inline void ksoftirqd_run_begin(void)
 /* Counterpart to ksoftirqd_run_begin() */
 static inline void ksoftirqd_run_end(void)
 {
+	/* pairs with the lock_map_acquire_read() in ksoftirqd_run_begin() */
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable(SOFTIRQ_OFFSET, true);
 	WARN_ON_ONCE(in_interrupt());
 	local_irq_enable();
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e60863ab74b5..b3860ec12450 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -58,6 +58,8 @@
 #define HRTIMER_ACTIVE_SOFT	(HRTIMER_ACTIVE_HARD << MASK_SHIFT)
 #define HRTIMER_ACTIVE_ALL	(HRTIMER_ACTIVE_SOFT | HRTIMER_ACTIVE_HARD)
 
+static void retrigger_next_event(void *arg);
+
 /*
  * The timer bases:
  *
@@ -111,7 +113,8 @@ DEFINE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases) =
 			.clockid = CLOCK_TAI,
 			.get_time = &ktime_get_clocktai,
 		},
-	}
+	},
+	.csd = CSD_INIT(retrigger_next_event, NULL)
 };
 
 static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
@@ -124,6 +127,14 @@ static const int hrtimer_clock_to_base_table[MAX_CLOCKS] = {
 	[CLOCK_TAI]		= HRTIMER_BASE_TAI,
 };
 
+static inline bool hrtimer_base_is_online(struct hrtimer_cpu_base *base)
+{
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		return true;
+	else
+		return likely(base->online);
+}
+
 /*
  * Functions and macros which are different for UP/SMP systems are kept in a
  * single place
@@ -177,27 +188,54 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
 }
 
 /*
- * We do not migrate the timer when it is expiring before the next
- * event on the target cpu. When high resolution is enabled, we cannot
- * reprogram the target cpu hardware and we would cause it to fire
- * late. To keep it simple, we handle the high resolution enabled and
- * disabled case similar.
+ * Check if the elected target is suitable considering its next
+ * event and the hotplug state of the current CPU.
+ *
+ * If the elected target is remote and its next event is after the timer
+ * to queue, then a remote reprogram is necessary. However there is no
+ * guarantee the IPI handling the operation would arrive in time to meet
+ * the high resolution deadline. In this case the local CPU becomes a
+ * preferred target, unless it is offline.
+ *
+ * High and low resolution modes are handled the same way for simplicity.
  *
  * Called with cpu_base->lock of target cpu held.
  */
-static int
-hrtimer_check_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base)
+static bool hrtimer_suitable_target(struct hrtimer *timer, struct hrtimer_clock_base *new_base,
+				    struct hrtimer_cpu_base *new_cpu_base,
+				    struct hrtimer_cpu_base *this_cpu_base)
 {
 	ktime_t expires;
 
+	/*
+	 * The local CPU clockevent can be reprogrammed. Also get_target_base()
+	 * guarantees it is online.
+	 */
+	if (new_cpu_base == this_cpu_base)
+		return true;
+
+	/*
+	 * The offline local CPU can't be the default target if the
+	 * next remote target event is after this timer. Keep the
+	 * elected new base. An IPI will we issued to reprogram
+	 * it as a last resort.
+	 */
+	if (!hrtimer_base_is_online(this_cpu_base))
+		return true;
+
 	expires = ktime_sub(hrtimer_get_expires(timer), new_base->offset);
-	return expires < new_base->cpu_base->expires_next;
+
+	return expires >= new_base->cpu_base->expires_next;
 }
 
-static inline
-struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
-					 int pinned)
+static inline struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base, int pinned)
 {
+	if (!hrtimer_base_is_online(base)) {
+		int cpu = cpumask_any_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TIMER));
+
+		return &per_cpu(hrtimer_bases, cpu);
+	}
+
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	if (static_branch_likely(&timers_migration_enabled) && !pinned)
 		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
@@ -248,8 +286,8 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 		raw_spin_unlock(&base->cpu_base->lock);
 		raw_spin_lock(&new_base->cpu_base->lock);
 
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base, new_cpu_base,
+					     this_cpu_base)) {
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
@@ -258,8 +296,7 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 		}
 		WRITE_ONCE(timer->base, new_base);
 	} else {
-		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		if (!hrtimer_suitable_target(timer, new_base,  new_cpu_base, this_cpu_base)) {
 			new_cpu_base = this_cpu_base;
 			goto again;
 		}
@@ -718,8 +755,6 @@ static inline int hrtimer_is_hres_enabled(void)
 	return hrtimer_hres_enabled;
 }
 
-static void retrigger_next_event(void *arg);
-
 /*
  * Switch to high resolution mode
  */
@@ -1205,6 +1240,7 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 				    u64 delta_ns, const enum hrtimer_mode mode,
 				    struct hrtimer_clock_base *base)
 {
+	struct hrtimer_cpu_base *this_cpu_base = this_cpu_ptr(&hrtimer_bases);
 	struct hrtimer_clock_base *new_base;
 	bool force_local, first;
 
@@ -1216,9 +1252,15 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	 * and enforce reprogramming after it is queued no matter whether
 	 * it is the new first expiring timer again or not.
 	 */
-	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local = base->cpu_base == this_cpu_base;
 	force_local &= base->cpu_base->next_timer == timer;
 
+	/*
+	 * Don't force local queuing if this enqueue happens on a unplugged
+	 * CPU after hrtimer_cpu_dying() has been invoked.
+	 */
+	force_local &= this_cpu_base->online;
+
 	/*
 	 * Remove an active timer from the queue. In case it is not queued
 	 * on the current CPU, make sure that remove_hrtimer() updates the
@@ -1248,8 +1290,27 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	}
 
 	first = enqueue_hrtimer(timer, new_base, mode);
-	if (!force_local)
-		return first;
+	if (!force_local) {
+		/*
+		 * If the current CPU base is online, then the timer is
+		 * never queued on a remote CPU if it would be the first
+		 * expiring timer there.
+		 */
+		if (hrtimer_base_is_online(this_cpu_base))
+			return first;
+
+		/*
+		 * Timer was enqueued remote because the current base is
+		 * already offline. If the timer is the first to expire,
+		 * kick the remote CPU to reprogram the clock event.
+		 */
+		if (first) {
+			struct hrtimer_cpu_base *new_cpu_base = new_base->cpu_base;
+
+			smp_call_function_single_async(new_cpu_base->cpu, &new_cpu_base->csd);
+		}
+		return 0;
+	}
 
 	/*
 	 * Timer was forced to stay on the current CPU to avoid
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 2d6cf93ca370..fc08d4ccdeeb 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -161,6 +161,7 @@ static int posix_timer_add(struct k_itimer *timer)
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index ed7d6ad694fb..20a5e6962b69 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -46,7 +46,7 @@ static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
+	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, timer->function);
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",
@@ -98,7 +98,7 @@ print_active_timers(struct seq_file *m, struct hrtimer_clock_base *base,
 static void
 print_base(struct seq_file *m, struct hrtimer_clock_base *base, u64 now)
 {
-	SEQ_printf(m, "  .base:       %pK\n", base);
+	SEQ_printf(m, "  .base:       %p\n", base);
 	SEQ_printf(m, "  .index:      %d\n", base->index);
 
 	SEQ_printf(m, "  .resolution: %u nsecs\n", hrtimer_resolution);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9da29583dfbc..9e0b9c9a7dff 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3422,10 +3422,9 @@ int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 }
 EXPORT_SYMBOL_GPL(trace_vbprintk);
 
-__printf(3, 0)
-static int
-__trace_array_vprintk(struct trace_buffer *buffer,
-		      unsigned long ip, const char *fmt, va_list args)
+static __printf(3, 0)
+int __trace_array_vprintk(struct trace_buffer *buffer,
+			  unsigned long ip, const char *fmt, va_list args)
 {
 	struct trace_event_call *call = &event_print;
 	struct ring_buffer_event *event;
@@ -3478,7 +3477,6 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	return len;
 }
 
-__printf(3, 0)
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
@@ -3505,7 +3503,6 @@ int trace_array_vprintk(struct trace_array *tr,
  * Note, trace_array_init_printk() must be called on @tr before this
  * can be used.
  */
-__printf(3, 0)
 int trace_array_printk(struct trace_array *tr,
 		       unsigned long ip, const char *fmt, ...)
 {
@@ -3550,7 +3547,6 @@ int trace_array_init_printk(struct trace_array *tr)
 }
 EXPORT_SYMBOL_GPL(trace_array_init_printk);
 
-__printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...)
 {
@@ -3566,7 +3562,6 @@ int trace_array_printk_buf(struct trace_buffer *buffer,
 	return ret;
 }
 
-__printf(2, 0)
 int trace_vprintk(unsigned long ip, const char *fmt, va_list args)
 {
 	return trace_array_vprintk(&global_trace, ip, fmt, args);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index aad7fcd84617..49b297ca7fc7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -780,13 +780,15 @@ static inline void __init disable_tracing_selftest(const char *reason)
 
 extern void *head_page(struct trace_array_cpu *data);
 extern unsigned long long ns2usecs(u64 nsec);
-extern int
-trace_vbprintk(unsigned long ip, const char *fmt, va_list args);
-extern int
-trace_vprintk(unsigned long ip, const char *fmt, va_list args);
-extern int
-trace_array_vprintk(struct trace_array *tr,
-		    unsigned long ip, const char *fmt, va_list args);
+
+__printf(2, 0)
+int trace_vbprintk(unsigned long ip, const char *fmt, va_list args);
+__printf(2, 0)
+int trace_vprintk(unsigned long ip, const char *fmt, va_list args);
+__printf(3, 0)
+int trace_array_vprintk(struct trace_array *tr,
+			unsigned long ip, const char *fmt, va_list args);
+__printf(3, 4)
 int trace_array_printk_buf(struct trace_buffer *buffer,
 			   unsigned long ip, const char *fmt, ...);
 void trace_printk_seq(struct trace_seq *s);
diff --git a/lib/dynamic_queue_limits.c b/lib/dynamic_queue_limits.c
index fde0aa244148..a75a9ca46b59 100644
--- a/lib/dynamic_queue_limits.c
+++ b/lib/dynamic_queue_limits.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(dql_completed);
 void dql_reset(struct dql *dql)
 {
 	/* Reset all dynamic values */
-	dql->limit = 0;
+	dql->limit = dql->min_limit;
 	dql->num_queued = 0;
 	dql->num_completed = 0;
 	dql->last_obj_cnt = 0;
diff --git a/lib/lzo/Makefile b/lib/lzo/Makefile
index 2f58fafbbddd..fc7b2b7ef4b2 100644
--- a/lib/lzo/Makefile
+++ b/lib/lzo/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-lzo_compress-objs := lzo1x_compress.o
+lzo_compress-objs := lzo1x_compress.o lzo1x_compress_safe.o
 lzo_decompress-objs := lzo1x_decompress_safe.o
 
 obj-$(CONFIG_LZO_COMPRESS) += lzo_compress.o
diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 9d31e7126606..f00dff9b9d4e 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -18,11 +18,22 @@
 #include <linux/lzo.h>
 #include "lzodefs.h"
 
-static noinline size_t
-lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
-		    unsigned char *out, size_t *out_len,
-		    size_t ti, void *wrkmem, signed char *state_offset,
-		    const unsigned char bitstream_version)
+#undef LZO_UNSAFE
+
+#ifndef LZO_SAFE
+#define LZO_UNSAFE 1
+#define LZO_SAFE(name) name
+#define HAVE_OP(x) 1
+#endif
+
+#define NEED_OP(x) if (!HAVE_OP(x)) goto output_overrun
+
+static noinline int
+LZO_SAFE(lzo1x_1_do_compress)(const unsigned char *in, size_t in_len,
+			      unsigned char **out, unsigned char *op_end,
+			      size_t *tp, void *wrkmem,
+			      signed char *state_offset,
+			      const unsigned char bitstream_version)
 {
 	const unsigned char *ip;
 	unsigned char *op;
@@ -30,8 +41,9 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 	const unsigned char * const ip_end = in + in_len - 20;
 	const unsigned char *ii;
 	lzo_dict_t * const dict = (lzo_dict_t *) wrkmem;
+	size_t ti = *tp;
 
-	op = out;
+	op = *out;
 	ip = in;
 	ii = ip;
 	ip += ti < 4 ? 4 - ti : 0;
@@ -116,25 +128,32 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		if (t != 0) {
 			if (t <= 3) {
 				op[*state_offset] |= t;
+				NEED_OP(4);
 				COPY4(op, ii);
 				op += t;
 			} else if (t <= 16) {
+				NEED_OP(17);
 				*op++ = (t - 3);
 				COPY8(op, ii);
 				COPY8(op + 8, ii + 8);
 				op += t;
 			} else {
 				if (t <= 18) {
+					NEED_OP(1);
 					*op++ = (t - 3);
 				} else {
 					size_t tt = t - 18;
+					NEED_OP(1);
 					*op++ = 0;
 					while (unlikely(tt > 255)) {
 						tt -= 255;
+						NEED_OP(1);
 						*op++ = 0;
 					}
+					NEED_OP(1);
 					*op++ = tt;
 				}
+				NEED_OP(t);
 				do {
 					COPY8(op, ii);
 					COPY8(op + 8, ii + 8);
@@ -151,6 +170,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		if (unlikely(run_length)) {
 			ip += run_length;
 			run_length -= MIN_ZERO_RUN_LENGTH;
+			NEED_OP(4);
 			put_unaligned_le32((run_length << 21) | 0xfffc18
 					   | (run_length & 0x7), op);
 			op += 4;
@@ -243,10 +263,12 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		ip += m_len;
 		if (m_len <= M2_MAX_LEN && m_off <= M2_MAX_OFFSET) {
 			m_off -= 1;
+			NEED_OP(2);
 			*op++ = (((m_len - 1) << 5) | ((m_off & 7) << 2));
 			*op++ = (m_off >> 3);
 		} else if (m_off <= M3_MAX_OFFSET) {
 			m_off -= 1;
+			NEED_OP(1);
 			if (m_len <= M3_MAX_LEN)
 				*op++ = (M3_MARKER | (m_len - 2));
 			else {
@@ -254,14 +276,18 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 				*op++ = M3_MARKER | 0;
 				while (unlikely(m_len > 255)) {
 					m_len -= 255;
+					NEED_OP(1);
 					*op++ = 0;
 				}
+				NEED_OP(1);
 				*op++ = (m_len);
 			}
+			NEED_OP(2);
 			*op++ = (m_off << 2);
 			*op++ = (m_off >> 6);
 		} else {
 			m_off -= 0x4000;
+			NEED_OP(1);
 			if (m_len <= M4_MAX_LEN)
 				*op++ = (M4_MARKER | ((m_off >> 11) & 8)
 						| (m_len - 2));
@@ -282,11 +308,14 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 				m_len -= M4_MAX_LEN;
 				*op++ = (M4_MARKER | ((m_off >> 11) & 8));
 				while (unlikely(m_len > 255)) {
+					NEED_OP(1);
 					m_len -= 255;
 					*op++ = 0;
 				}
+				NEED_OP(1);
 				*op++ = (m_len);
 			}
+			NEED_OP(2);
 			*op++ = (m_off << 2);
 			*op++ = (m_off >> 6);
 		}
@@ -295,14 +324,20 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 		ii = ip;
 		goto next;
 	}
-	*out_len = op - out;
-	return in_end - (ii - ti);
+	*out = op;
+	*tp = in_end - (ii - ti);
+	return LZO_E_OK;
+
+output_overrun:
+	return LZO_E_OUTPUT_OVERRUN;
 }
 
-static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
-		     unsigned char *out, size_t *out_len,
-		     void *wrkmem, const unsigned char bitstream_version)
+static int LZO_SAFE(lzogeneric1x_1_compress)(
+	const unsigned char *in, size_t in_len,
+	unsigned char *out, size_t *out_len,
+	void *wrkmem, const unsigned char bitstream_version)
 {
+	unsigned char * const op_end = out + *out_len;
 	const unsigned char *ip = in;
 	unsigned char *op = out;
 	unsigned char *data_start;
@@ -326,14 +361,18 @@ static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 	while (l > 20) {
 		size_t ll = min_t(size_t, l, m4_max_offset + 1);
 		uintptr_t ll_end = (uintptr_t) ip + ll;
+		int err;
+
 		if ((ll_end + ((t + ll) >> 5)) <= ll_end)
 			break;
 		BUILD_BUG_ON(D_SIZE * sizeof(lzo_dict_t) > LZO1X_1_MEM_COMPRESS);
 		memset(wrkmem, 0, D_SIZE * sizeof(lzo_dict_t));
-		t = lzo1x_1_do_compress(ip, ll, op, out_len, t, wrkmem,
-					&state_offset, bitstream_version);
+		err = LZO_SAFE(lzo1x_1_do_compress)(
+			ip, ll, &op, op_end, &t, wrkmem,
+			&state_offset, bitstream_version);
+		if (err != LZO_E_OK)
+			return err;
 		ip += ll;
-		op += *out_len;
 		l  -= ll;
 	}
 	t += l;
@@ -342,20 +381,26 @@ static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 		const unsigned char *ii = in + in_len - t;
 
 		if (op == data_start && t <= 238) {
+			NEED_OP(1);
 			*op++ = (17 + t);
 		} else if (t <= 3) {
 			op[state_offset] |= t;
 		} else if (t <= 18) {
+			NEED_OP(1);
 			*op++ = (t - 3);
 		} else {
 			size_t tt = t - 18;
+			NEED_OP(1);
 			*op++ = 0;
 			while (tt > 255) {
 				tt -= 255;
+				NEED_OP(1);
 				*op++ = 0;
 			}
+			NEED_OP(1);
 			*op++ = tt;
 		}
+		NEED_OP(t);
 		if (t >= 16) do {
 			COPY8(op, ii);
 			COPY8(op + 8, ii + 8);
@@ -368,31 +413,38 @@ static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 		} while (--t > 0);
 	}
 
+	NEED_OP(3);
 	*op++ = M4_MARKER | 1;
 	*op++ = 0;
 	*op++ = 0;
 
 	*out_len = op - out;
 	return LZO_E_OK;
+
+output_overrun:
+	return LZO_E_OUTPUT_OVERRUN;
 }
 
-int lzo1x_1_compress(const unsigned char *in, size_t in_len,
-		     unsigned char *out, size_t *out_len,
-		     void *wrkmem)
+int LZO_SAFE(lzo1x_1_compress)(const unsigned char *in, size_t in_len,
+			       unsigned char *out, size_t *out_len,
+			       void *wrkmem)
 {
-	return lzogeneric1x_1_compress(in, in_len, out, out_len, wrkmem, 0);
+	return LZO_SAFE(lzogeneric1x_1_compress)(
+		in, in_len, out, out_len, wrkmem, 0);
 }
 
-int lzorle1x_1_compress(const unsigned char *in, size_t in_len,
-		     unsigned char *out, size_t *out_len,
-		     void *wrkmem)
+int LZO_SAFE(lzorle1x_1_compress)(const unsigned char *in, size_t in_len,
+				  unsigned char *out, size_t *out_len,
+				  void *wrkmem)
 {
-	return lzogeneric1x_1_compress(in, in_len, out, out_len,
-				       wrkmem, LZO_VERSION);
+	return LZO_SAFE(lzogeneric1x_1_compress)(
+		in, in_len, out, out_len, wrkmem, LZO_VERSION);
 }
 
-EXPORT_SYMBOL_GPL(lzo1x_1_compress);
-EXPORT_SYMBOL_GPL(lzorle1x_1_compress);
+EXPORT_SYMBOL_GPL(LZO_SAFE(lzo1x_1_compress));
+EXPORT_SYMBOL_GPL(LZO_SAFE(lzorle1x_1_compress));
 
+#ifndef LZO_UNSAFE
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("LZO1X-1 Compressor");
+#endif
diff --git a/lib/lzo/lzo1x_compress_safe.c b/lib/lzo/lzo1x_compress_safe.c
new file mode 100644
index 000000000000..371c9f849492
--- /dev/null
+++ b/lib/lzo/lzo1x_compress_safe.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  LZO1X Compressor from LZO
+ *
+ *  Copyright (C) 1996-2012 Markus F.X.J. Oberhumer <markus@oberhumer.com>
+ *
+ *  The full LZO package can be found at:
+ *  http://www.oberhumer.com/opensource/lzo/
+ *
+ *  Changed for Linux kernel use by:
+ *  Nitin Gupta <nitingupta910@gmail.com>
+ *  Richard Purdie <rpurdie@openedhand.com>
+ */
+
+#define LZO_SAFE(name) name##_safe
+#define HAVE_OP(x) ((size_t)(op_end - op) >= (size_t)(x))
+
+#include "lzo1x_compress.c"
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3f7cab196eb6..420efa1d2b20 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1242,7 +1242,6 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 {
 	struct mem_cgroup *iter;
 	int ret = 0;
-	int i = 0;
 
 	BUG_ON(memcg == root_mem_cgroup);
 
@@ -1252,10 +1251,9 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
 
 		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
 		while (!ret && (task = css_task_iter_next(&it))) {
-			/* Avoid potential softlockup warning */
-			if ((++i & 1023) == 0)
-				cond_resched();
 			ret = fn(task, arg);
+			/* Avoid potential softlockup warning */
+			cond_resched();
 		}
 		css_task_iter_end(&it);
 		if (ret) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 65ad214e21f3..5a2bae590ed7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5195,6 +5195,14 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	}
 
 retry:
+	/*
+	 * Deal with possible cpuset update races or zonelist updates to avoid
+	 * infinite retries.
+	 */
+	if (check_retry_cpuset(cpuset_mems_cookie, ac) ||
+	    check_retry_zonelist(zonelist_iter_cookie))
+		goto restart;
+
 	/* Ensure kswapd doesn't accidentally go to sleep as long as we loop */
 	if (alloc_flags & ALLOC_KSWAPD)
 		wake_all_kswapds(order, gfp_mask, ac);
diff --git a/net/Makefile b/net/Makefile
index 0914bea9c335..103cd8d61f68 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_NETFILTER)		+= netfilter/
 obj-$(CONFIG_INET)		+= ipv4/
 obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
-obj-$(CONFIG_UNIX_SCM)		+= unix/
+obj-$(CONFIG_UNIX)		+= unix/
 obj-y				+= ipv6/
 obj-$(CONFIG_BPFILTER)		+= bpfilter/
 obj-$(CONFIG_PACKET)		+= packet/
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 222105e24d2d..cb9b1edfcea2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1561,7 +1561,8 @@ static void l2cap_request_info(struct l2cap_conn *conn)
 		       sizeof(req), &req);
 }
 
-static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
+static bool l2cap_check_enc_key_size(struct hci_conn *hcon,
+				     struct l2cap_chan *chan)
 {
 	/* The minimum encryption key size needs to be enforced by the
 	 * host stack before establishing any L2CAP connections. The
@@ -1575,7 +1576,7 @@ static bool l2cap_check_enc_key_size(struct hci_conn *hcon)
 	int min_key_size = hcon->hdev->min_enc_key_size;
 
 	/* On FIPS security level, key size must be 16 bytes */
-	if (hcon->sec_level == BT_SECURITY_FIPS)
+	if (chan->sec_level == BT_SECURITY_FIPS)
 		min_key_size = 16;
 
 	return (!test_bit(HCI_CONN_ENCRYPT, &hcon->flags) ||
@@ -1603,7 +1604,7 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 	    !__l2cap_no_conn_pending(chan))
 		return;
 
-	if (l2cap_check_enc_key_size(conn->hcon))
+	if (l2cap_check_enc_key_size(conn->hcon, chan))
 		l2cap_start_connection(chan);
 	else
 		__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -1685,7 +1686,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				continue;
 			}
 
-			if (l2cap_check_enc_key_size(conn->hcon))
+			if (l2cap_check_enc_key_size(conn->hcon, chan))
 				l2cap_start_connection(chan);
 			else
 				l2cap_chan_close(chan, ECONNREFUSED);
@@ -4187,7 +4188,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(L2CAP_PSM_SDP) &&
 	    (!hci_conn_check_link_mode(conn->hcon) ||
-	    !l2cap_check_enc_key_size(conn->hcon))) {
+	    !l2cap_check_enc_key_size(conn->hcon, pchan))) {
 		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
@@ -8418,7 +8419,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		}
 
 		if (chan->state == BT_CONNECT) {
-			if (!status && l2cap_check_enc_key_size(hcon))
+			if (!status && l2cap_check_enc_key_size(hcon, chan))
 				l2cap_start_connection(chan);
 			else
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
@@ -8428,7 +8429,7 @@ static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			if (!status && l2cap_check_enc_key_size(hcon)) {
+			if (!status && l2cap_check_enc_key_size(hcon, chan)) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
diff --git a/net/bridge/br_nf_core.c b/net/bridge/br_nf_core.c
index 8c69f0c95a8e..b8c8deb87407 100644
--- a/net/bridge/br_nf_core.c
+++ b/net/bridge/br_nf_core.c
@@ -65,17 +65,14 @@ static struct dst_ops fake_dst_ops = {
  * ipt_REJECT needs it.  Future netfilter modules might
  * require us to fill additional fields.
  */
-static const u32 br_dst_default_metrics[RTAX_MAX] = {
-	[RTAX_MTU - 1] = 1500,
-};
-
 void br_netfilter_rtable_init(struct net_bridge *br)
 {
 	struct rtable *rt = &br->fake_rtable;
 
 	atomic_set(&rt->dst.__refcnt, 1);
 	rt->dst.dev = br->dev;
-	dst_init_metrics(&rt->dst, br_dst_default_metrics, true);
+	dst_init_metrics(&rt->dst, br->metrics, false);
+	dst_metric_set(&rt->dst, RTAX_MTU, br->dev->mtu);
 	rt->dst.flags	= DST_NOXFRM | DST_FAKE_RTABLE;
 	rt->dst.ops = &fake_dst_ops;
 }
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 940de9516768..19fb50549252 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -478,6 +478,7 @@ struct net_bridge {
 		struct rtable		fake_rtable;
 		struct rt6_info		fake_rt6_info;
 	};
+	u32				metrics[RTAX_MAX];
 #endif
 	u16				group_fwd_mask;
 	u16				group_fwd_mask_required;
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 3817692e83af..4fb5cfaf74f3 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -58,6 +58,7 @@
 #include <linux/can/skb.h>
 #include <linux/can/bcm.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <net/sock.h>
 #include <net/net_namespace.h>
 
@@ -120,6 +121,7 @@ struct bcm_op {
 	struct canfd_frame last_sframe;
 	struct sock *sk;
 	struct net_device *rx_reg_dev;
+	spinlock_t bcm_tx_lock; /* protect currframe/count in runtime updates */
 };
 
 struct bcm_sock {
@@ -205,7 +207,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
 
-	list_for_each_entry(op, &bo->rx_ops, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(op, &bo->rx_ops, list) {
 
 		unsigned long reduction;
 
@@ -261,6 +265,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 		seq_printf(m, "# sent %ld\n", op->frames_abs);
 	}
 	seq_putc(m, '\n');
+
+	rcu_read_unlock();
+
 	return 0;
 }
 #endif /* CONFIG_PROC_FS */
@@ -273,13 +280,18 @@ static void bcm_can_tx(struct bcm_op *op)
 {
 	struct sk_buff *skb;
 	struct net_device *dev;
-	struct canfd_frame *cf = op->frames + op->cfsiz * op->currframe;
+	struct canfd_frame *cf;
 	int err;
 
 	/* no target device? => exit */
 	if (!op->ifindex)
 		return;
 
+	/* read currframe under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+	cf = op->frames + op->cfsiz * op->currframe;
+	spin_unlock_bh(&op->bcm_tx_lock);
+
 	dev = dev_get_by_index(sock_net(op->sk), op->ifindex);
 	if (!dev) {
 		/* RFC: should this bcm_op remove itself here? */
@@ -300,6 +312,10 @@ static void bcm_can_tx(struct bcm_op *op)
 	skb->dev = dev;
 	can_skb_set_owner(skb, op->sk);
 	err = can_send(skb, 1);
+
+	/* update currframe and count under lock protection */
+	spin_lock_bh(&op->bcm_tx_lock);
+
 	if (!err)
 		op->frames_abs++;
 
@@ -308,6 +324,11 @@ static void bcm_can_tx(struct bcm_op *op)
 	/* reached last frame? */
 	if (op->currframe >= op->nframes)
 		op->currframe = 0;
+
+	if (op->count > 0)
+		op->count--;
+
+	spin_unlock_bh(&op->bcm_tx_lock);
 out:
 	dev_put(dev);
 }
@@ -404,7 +425,7 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 	struct bcm_msg_head msg_head;
 
 	if (op->kt_ival1 && (op->count > 0)) {
-		op->count--;
+		bcm_can_tx(op);
 		if (!op->count && (op->flags & TX_COUNTEVT)) {
 
 			/* create notification to user */
@@ -419,7 +440,6 @@ static enum hrtimer_restart bcm_tx_timeout_handler(struct hrtimer *hrtimer)
 
 			bcm_send_to_user(op, &msg_head, NULL, 0);
 		}
-		bcm_can_tx(op);
 
 	} else if (op->kt_ival2) {
 		bcm_can_tx(op);
@@ -801,7 +821,7 @@ static int bcm_delete_rx_op(struct list_head *ops, struct bcm_msg_head *mh,
 						  REGMASK(op->can_id),
 						  bcm_rx_handler, op);
 
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -821,7 +841,7 @@ static int bcm_delete_tx_op(struct list_head *ops, struct bcm_msg_head *mh,
 	list_for_each_entry_safe(op, n, ops, list) {
 		if ((op->can_id == mh->can_id) && (op->ifindex == ifindex) &&
 		    (op->flags & CAN_FD_FRAME) == (mh->flags & CAN_FD_FRAME)) {
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return 1; /* done */
 		}
@@ -914,6 +934,27 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		}
 		op->flags = msg_head->flags;
 
+		/* only lock for unlikely count/nframes/currframe changes */
+		if (op->nframes != msg_head->nframes ||
+		    op->flags & TX_RESET_MULTI_IDX ||
+		    op->flags & SETTIMER) {
+
+			spin_lock_bh(&op->bcm_tx_lock);
+
+			if (op->nframes != msg_head->nframes ||
+			    op->flags & TX_RESET_MULTI_IDX) {
+				/* potentially update changed nframes */
+				op->nframes = msg_head->nframes;
+				/* restart multiple frame transmission */
+				op->currframe = 0;
+			}
+
+			if (op->flags & SETTIMER)
+				op->count = msg_head->count;
+
+			spin_unlock_bh(&op->bcm_tx_lock);
+		}
+
 	} else {
 		/* insert new BCM operation for the given can_id */
 
@@ -921,9 +962,14 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		if (!op)
 			return -ENOMEM;
 
+		spin_lock_init(&op->bcm_tx_lock);
 		op->can_id = msg_head->can_id;
 		op->cfsiz = CFSIZ(msg_head->flags);
 		op->flags = msg_head->flags;
+		op->nframes = msg_head->nframes;
+
+		if (op->flags & SETTIMER)
+			op->count = msg_head->count;
 
 		/* create array for CAN frames and copy the data */
 		if (msg_head->nframes > 1) {
@@ -982,22 +1028,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 
 	} /* if ((op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex))) */
 
-	if (op->nframes != msg_head->nframes) {
-		op->nframes   = msg_head->nframes;
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
-
-	/* check flags */
-
-	if (op->flags & TX_RESET_MULTI_IDX) {
-		/* start multiple frame transmission with index 0 */
-		op->currframe = 0;
-	}
-
 	if (op->flags & SETTIMER) {
 		/* set timer values */
-		op->count = msg_head->count;
 		op->ival1 = msg_head->ival1;
 		op->ival2 = msg_head->ival2;
 		op->kt_ival1 = bcm_timeval_to_ktime(msg_head->ival1);
@@ -1014,11 +1046,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 		op->flags |= TX_ANNOUNCE;
 	}
 
-	if (op->flags & TX_ANNOUNCE) {
+	if (op->flags & TX_ANNOUNCE)
 		bcm_can_tx(op);
-		if (op->count)
-			op->count--;
-	}
 
 	if (op->flags & STARTTIMER)
 		bcm_tx_start_timer(op);
@@ -1234,7 +1263,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head, struct msghdr *msg,
 					      bcm_rx_handler, op, "bcm", sk);
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
-			list_del(&op->list);
+			list_del_rcu(&op->list);
 			bcm_remove_op(op);
 			return err;
 		}
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index a2fb951996b8..a2838c15aa9d 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -897,6 +897,10 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 	pkt_dev->nr_labels = 0;
 	do {
 		__u32 tmp;
+
+		if (n >= MAX_MPLS_LABELS)
+			return -E2BIG;
+
 		len = hex32_arg(&buffer[i], 8, &tmp);
 		if (len <= 0)
 			return len;
@@ -908,8 +912,6 @@ static ssize_t get_labels(const char __user *buffer, struct pktgen_dev *pkt_dev)
 			return -EFAULT;
 		i++;
 		n++;
-		if (n >= MAX_MPLS_LABELS)
-			return -E2BIG;
 	} while (c == ',');
 
 	pkt_dev->nr_labels = n;
@@ -1875,8 +1877,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	i = len;
 
 	/* Read variable name */
-
-	len = strn_len(&user_buffer[i], sizeof(name) - 1);
+	max = min(sizeof(name) - 1, count - i);
+	len = strn_len(&user_buffer[i], max);
 	if (len < 0)
 		return len;
 
@@ -1906,7 +1908,8 @@ static ssize_t pktgen_thread_write(struct file *file,
 	if (!strcmp(name, "add_device")) {
 		char f[32];
 		memset(f, 0, 32);
-		len = strn_len(&user_buffer[i], sizeof(f) - 1);
+		max = min(sizeof(f) - 1, count - i);
+		len = strn_len(&user_buffer[i], max);
 		if (len < 0) {
 			ret = len;
 			goto out;
diff --git a/net/core/scm.c b/net/core/scm.c
index a877c4ef4c25..cdd4e5befb14 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -36,6 +36,7 @@
 #include <net/compat.h>
 #include <net/scm.h>
 #include <net/cls_cgroup.h>
+#include <net/af_unix.h>
 
 
 /*
@@ -85,8 +86,15 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 			return -ENOMEM;
 		*fplp = fpl;
 		fpl->count = 0;
+		fpl->count_unix = 0;
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
+#if IS_ENABLED(CONFIG_UNIX)
+		fpl->inflight = false;
+		fpl->dead = false;
+		fpl->edges = NULL;
+		INIT_LIST_HEAD(&fpl->vertices);
+#endif
 	}
 	fpp = &fpl->fp[fpl->count];
 
@@ -109,6 +117,9 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 			fput(file);
 			return -EINVAL;
 		}
+		if (unix_get_socket(file))
+			fpl->count_unix++;
+
 		*fpp++ = file;
 		fpl->count++;
 	}
@@ -367,8 +378,14 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 	if (new_fpl) {
 		for (i = 0; i < fpl->count; i++)
 			get_file(fpl->fp[i]);
+
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
+#if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->inflight = false;
+		new_fpl->edges = NULL;
+		INIT_LIST_HEAD(&new_fpl->vertices);
+#endif
 	}
 	return new_fpl;
 }
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 419969b26822..8f5417ff355d 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -118,47 +118,16 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 }
 
 #ifdef CONFIG_INET_ESPINTCP
-struct esp_tcp_sk {
-	struct sock *sk;
-	struct rcu_head rcu;
-};
-
-static void esp_free_tcp_sk(struct rcu_head *head)
-{
-	struct esp_tcp_sk *esk = container_of(head, struct esp_tcp_sk, rcu);
-
-	sock_put(esk->sk);
-	kfree(esk);
-}
-
 static struct sock *esp_find_tcp_sk(struct xfrm_state *x)
 {
 	struct xfrm_encap_tmpl *encap = x->encap;
 	struct net *net = xs_net(x);
-	struct esp_tcp_sk *esk;
 	__be16 sport, dport;
-	struct sock *nsk;
 	struct sock *sk;
 
-	sk = rcu_dereference(x->encap_sk);
-	if (sk && sk->sk_state == TCP_ESTABLISHED)
-		return sk;
-
 	spin_lock_bh(&x->lock);
 	sport = encap->encap_sport;
 	dport = encap->encap_dport;
-	nsk = rcu_dereference_protected(x->encap_sk,
-					lockdep_is_held(&x->lock));
-	if (sk && sk == nsk) {
-		esk = kmalloc(sizeof(*esk), GFP_ATOMIC);
-		if (!esk) {
-			spin_unlock_bh(&x->lock);
-			return ERR_PTR(-ENOMEM);
-		}
-		RCU_INIT_POINTER(x->encap_sk, NULL);
-		esk->sk = sk;
-		call_rcu(&esk->rcu, esp_free_tcp_sk);
-	}
 	spin_unlock_bh(&x->lock);
 
 	sk = inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo, x->id.daddr.a4,
@@ -171,20 +140,6 @@ static struct sock *esp_find_tcp_sk(struct xfrm_state *x)
 		return ERR_PTR(-EINVAL);
 	}
 
-	spin_lock_bh(&x->lock);
-	nsk = rcu_dereference_protected(x->encap_sk,
-					lockdep_is_held(&x->lock));
-	if (encap->encap_sport != sport ||
-	    encap->encap_dport != dport) {
-		sock_put(sk);
-		sk = nsk ?: ERR_PTR(-EREMCHG);
-	} else if (sk == nsk) {
-		sock_put(sk);
-	} else {
-		rcu_assign_pointer(x->encap_sk, sk);
-	}
-	spin_unlock_bh(&x->lock);
-
 	return sk;
 }
 
@@ -207,6 +162,8 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 		err = espintcp_push_skb(sk, skb);
 	bh_unlock_sock(sk);
 
+	sock_put(sk);
+
 out:
 	rcu_read_unlock();
 	return err;
@@ -391,6 +348,8 @@ static struct ip_esp_hdr *esp_output_tcp_encap(struct xfrm_state *x,
 	if (IS_ERR(sk))
 		return ERR_CAST(sk);
 
+	sock_put(sk);
+
 	*lenp = htons(len);
 	esph = (struct ip_esp_hdr *)(lenp + 1);
 
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 90ce87ffed46..7993ff46de23 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -829,19 +829,33 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
 		}
 	}
 
+	if (cfg->fc_dst_len > 32) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix length");
+		err = -EINVAL;
+		goto errout;
+	}
+
+	if (cfg->fc_dst_len < 32 && (ntohl(cfg->fc_dst) << cfg->fc_dst_len)) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix for given prefix length");
+		err = -EINVAL;
+		goto errout;
+	}
+
 	if (cfg->fc_nh_id) {
 		if (cfg->fc_oif || cfg->fc_gw_family ||
 		    cfg->fc_encap || cfg->fc_mp) {
 			NL_SET_ERR_MSG(extack,
 				       "Nexthop specification and nexthop id are mutually exclusive");
-			return -EINVAL;
+			err = -EINVAL;
+			goto errout;
 		}
 	}
 
 	if (has_gw && has_via) {
 		NL_SET_ERR_MSG(extack,
 			       "Nexthop configuration can not contain both GATEWAY and VIA");
-		return -EINVAL;
+		err = -EINVAL;
+		goto errout;
 	}
 
 	if (!cfg->fc_table)
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 513f475c6a53..298a9944a3d1 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -222,9 +222,9 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
-	struct net *net = sock_net(skb->sk);
+	struct fib4_rule *rule4 = (struct fib4_rule *)rule;
+	struct net *net = rule->fr_net;
 	int err = -EINVAL;
-	struct fib4_rule *rule4 = (struct fib4_rule *) rule;
 
 	if (!inet_validate_dscp(frh->tos)) {
 		NL_SET_ERR_MSG(extack,
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 77b97c48da5e..fa54b36b241a 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1192,22 +1192,6 @@ static int fib_insert_alias(struct trie *t, struct key_vector *tp,
 	return 0;
 }
 
-static bool fib_valid_key_len(u32 key, u8 plen, struct netlink_ext_ack *extack)
-{
-	if (plen > KEYLENGTH) {
-		NL_SET_ERR_MSG(extack, "Invalid prefix length");
-		return false;
-	}
-
-	if ((plen < KEYLENGTH) && (key << plen)) {
-		NL_SET_ERR_MSG(extack,
-			       "Invalid prefix for given prefix length");
-		return false;
-	}
-
-	return true;
-}
-
 static void fib_remove_alias(struct trie *t, struct key_vector *tp,
 			     struct key_vector *l, struct fib_alias *old);
 
@@ -1228,9 +1212,6 @@ int fib_table_insert(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	pr_debug("Insert table=%u %08x/%d\n", tb->tb_id, key, plen);
 
 	fi = fib_create_info(cfg, extack);
@@ -1723,9 +1704,6 @@ int fib_table_delete(struct net *net, struct fib_table *tb,
 
 	key = ntohl(cfg->fc_dst);
 
-	if (!fib_valid_key_len(key, plen, extack))
-		return -EINVAL;
-
 	l = fib_find_node(t, &tp, key);
 	if (!l)
 		return -ESRCH;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 321f509f2347..5e7cdcebd64f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1218,22 +1218,37 @@ int inet_ehash_locks_alloc(struct inet_hashinfo *hashinfo)
 {
 	unsigned int locksz = sizeof(spinlock_t);
 	unsigned int i, nblocks = 1;
+	spinlock_t *ptr = NULL;
 
-	if (locksz != 0) {
-		/* allocate 2 cache lines or at least one spinlock per cpu */
-		nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U);
-		nblocks = roundup_pow_of_two(nblocks * num_possible_cpus());
+	if (locksz == 0)
+		goto set_mask;
 
-		/* no more locks than number of hash buckets */
-		nblocks = min(nblocks, hashinfo->ehash_mask + 1);
+	/* Allocate 2 cache lines or at least one spinlock per cpu. */
+	nblocks = max(2U * L1_CACHE_BYTES / locksz, 1U) * num_possible_cpus();
 
-		hashinfo->ehash_locks = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
-		if (!hashinfo->ehash_locks)
-			return -ENOMEM;
+	/* At least one page per NUMA node. */
+	nblocks = max(nblocks, num_online_nodes() * PAGE_SIZE / locksz);
+
+	nblocks = roundup_pow_of_two(nblocks);
+
+	/* No more locks than number of hash buckets. */
+	nblocks = min(nblocks, hashinfo->ehash_mask + 1);
 
-		for (i = 0; i < nblocks; i++)
-			spin_lock_init(&hashinfo->ehash_locks[i]);
+	if (num_online_nodes() > 1) {
+		/* Use vmalloc() to allow NUMA policy to spread pages
+		 * on all available nodes if desired.
+		 */
+		ptr = vmalloc_array(nblocks, locksz);
+	}
+	if (!ptr) {
+		ptr = kvmalloc_array(nblocks, locksz, GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
 	}
+	for (i = 0; i < nblocks; i++)
+		spin_lock_init(&ptr[i]);
+	hashinfo->ehash_locks = ptr;
+set_mask:
 	hashinfo->ehash_locks_mask = nblocks - 1;
 	return 0;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3b81f6df829f..db1a99df29d5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -404,6 +404,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
 	return false;
 }
 
+static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
+{
+	tp->delivered_ce += ecn_count;
+}
+
+/* Updates the delivered and delivered_ce counts */
+static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
+				bool ece_ack)
+{
+	tp->delivered += delivered;
+	if (ece_ack)
+		tcp_count_delivered_ce(tp, delivered);
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -1119,15 +1133,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-/* Updates the delivered and delivered_ce counts */
-static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
-				bool ece_ack)
-{
-	tp->delivered += delivered;
-	if (ece_ack)
-		tp->delivered_ce += delivered;
-}
-
 /* This procedure tags the retransmission queue when SACKs arrive.
  *
  * We have three tag bits: SACKED(S), RETRANS(R) and LOST(L).
@@ -3783,12 +3788,23 @@ static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
 	}
 }
 
-static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
+static void tcp_in_ack_event(struct sock *sk, int flag)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	if (icsk->icsk_ca_ops->in_ack_event)
-		icsk->icsk_ca_ops->in_ack_event(sk, flags);
+	if (icsk->icsk_ca_ops->in_ack_event) {
+		u32 ack_ev_flags = 0;
+
+		if (flag & FLAG_WIN_UPDATE)
+			ack_ev_flags |= CA_ACK_WIN_UPDATE;
+		if (flag & FLAG_SLOWPATH) {
+			ack_ev_flags |= CA_ACK_SLOWPATH;
+			if (flag & FLAG_ECE)
+				ack_ev_flags |= CA_ACK_ECE;
+		}
+
+		icsk->icsk_ca_ops->in_ack_event(sk, ack_ev_flags);
+	}
 }
 
 /* Congestion control has updated the cwnd already. So if we're in
@@ -3905,12 +3921,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		tcp_snd_una_update(tp, ack);
 		flag |= FLAG_WIN_UPDATE;
 
-		tcp_in_ack_event(sk, CA_ACK_WIN_UPDATE);
-
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
 	} else {
-		u32 ack_ev_flags = CA_ACK_SLOWPATH;
-
 		if (ack_seq != TCP_SKB_CB(skb)->end_seq)
 			flag |= FLAG_DATA;
 		else
@@ -3922,19 +3934,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 			flag |= tcp_sacktag_write_queue(sk, skb, prior_snd_una,
 							&sack_state);
 
-		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb))) {
+		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb)))
 			flag |= FLAG_ECE;
-			ack_ev_flags |= CA_ACK_ECE;
-		}
 
 		if (sack_state.sack_delivered)
 			tcp_count_delivered(tp, sack_state.sack_delivered,
 					    flag & FLAG_ECE);
-
-		if (flag & FLAG_WIN_UPDATE)
-			ack_ev_flags |= CA_ACK_WIN_UPDATE;
-
-		tcp_in_ack_event(sk, ack_ev_flags);
 	}
 
 	/* This is a deviation from RFC3168 since it states that:
@@ -3961,6 +3966,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	tcp_in_ack_event(sk, flag);
+
 	if (tp->tlp_high_seq)
 		tcp_process_tlp_ack(sk, ack, flag);
 
@@ -3992,6 +3999,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index a021c88d3d9b..085a83b807af 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -135,47 +135,16 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp)
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-struct esp_tcp_sk {
-	struct sock *sk;
-	struct rcu_head rcu;
-};
-
-static void esp_free_tcp_sk(struct rcu_head *head)
-{
-	struct esp_tcp_sk *esk = container_of(head, struct esp_tcp_sk, rcu);
-
-	sock_put(esk->sk);
-	kfree(esk);
-}
-
 static struct sock *esp6_find_tcp_sk(struct xfrm_state *x)
 {
 	struct xfrm_encap_tmpl *encap = x->encap;
 	struct net *net = xs_net(x);
-	struct esp_tcp_sk *esk;
 	__be16 sport, dport;
-	struct sock *nsk;
 	struct sock *sk;
 
-	sk = rcu_dereference(x->encap_sk);
-	if (sk && sk->sk_state == TCP_ESTABLISHED)
-		return sk;
-
 	spin_lock_bh(&x->lock);
 	sport = encap->encap_sport;
 	dport = encap->encap_dport;
-	nsk = rcu_dereference_protected(x->encap_sk,
-					lockdep_is_held(&x->lock));
-	if (sk && sk == nsk) {
-		esk = kmalloc(sizeof(*esk), GFP_ATOMIC);
-		if (!esk) {
-			spin_unlock_bh(&x->lock);
-			return ERR_PTR(-ENOMEM);
-		}
-		RCU_INIT_POINTER(x->encap_sk, NULL);
-		esk->sk = sk;
-		call_rcu(&esk->rcu, esp_free_tcp_sk);
-	}
 	spin_unlock_bh(&x->lock);
 
 	sk = __inet6_lookup_established(net, net->ipv4.tcp_death_row.hashinfo, &x->id.daddr.in6,
@@ -188,20 +157,6 @@ static struct sock *esp6_find_tcp_sk(struct xfrm_state *x)
 		return ERR_PTR(-EINVAL);
 	}
 
-	spin_lock_bh(&x->lock);
-	nsk = rcu_dereference_protected(x->encap_sk,
-					lockdep_is_held(&x->lock));
-	if (encap->encap_sport != sport ||
-	    encap->encap_dport != dport) {
-		sock_put(sk);
-		sk = nsk ?: ERR_PTR(-EREMCHG);
-	} else if (sk == nsk) {
-		sock_put(sk);
-	} else {
-		rcu_assign_pointer(x->encap_sk, sk);
-	}
-	spin_unlock_bh(&x->lock);
-
 	return sk;
 }
 
@@ -224,6 +179,8 @@ static int esp_output_tcp_finish(struct xfrm_state *x, struct sk_buff *skb)
 		err = espintcp_push_skb(sk, skb);
 	bh_unlock_sock(sk);
 
+	sock_put(sk);
+
 out:
 	rcu_read_unlock();
 	return err;
@@ -427,6 +384,8 @@ static struct ip_esp_hdr *esp6_output_tcp_encap(struct xfrm_state *x,
 	if (IS_ERR(sk))
 		return ERR_CAST(sk);
 
+	sock_put(sk);
+
 	*lenp = htons(len);
 	esph = (struct ip_esp_hdr *)(lenp + 1);
 
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 6eeab21512ba..e0f0c5f8cccd 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -350,9 +350,9 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
+	struct fib6_rule *rule6 = (struct fib6_rule *)rule;
+	struct net *net = rule->fr_net;
 	int err = -EINVAL;
-	struct net *net = sock_net(skb->sk);
-	struct fib6_rule *rule6 = (struct fib6_rule *) rule;
 
 	if (!inet_validate_dscp(frh->tos)) {
 		NL_SET_ERR_MSG(extack,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f7a225da8525..cfc276e5a249 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1450,6 +1450,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	}
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
+	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
@@ -1483,7 +1484,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags, struct ipcm6_cookie *ipc6)
+			     unsigned int flags)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
@@ -1539,7 +1540,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
+	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_ICMPV6 ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1884,7 +1885,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags, ipc6);
+				 from, length, transhdrlen, flags);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2089,7 +2090,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
-				flags, ipc6);
+				flags);
 	if (err) {
 		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
 		return ERR_PTR(err);
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 447031c5eac4..39c7d62c933f 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -888,15 +888,15 @@ static int llc_ui_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		if (sk->sk_type != SOCK_STREAM)
 			goto copy_uaddr;
 
+		/* Partial read */
+		if (used + offset < skb_len)
+			continue;
+
 		if (!(flags & MSG_PEEK)) {
 			skb_unlink(skb, &sk->sk_receive_queue);
 			kfree_skb(skb);
 			*seq = 0;
 		}
-
-		/* Partial read */
-		if (used + offset < skb_len)
-			continue;
 	} while (len > 0);
 
 out:
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9a5530ca2f6b..b300972c3150 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2896,7 +2896,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	if (tx)
 		ieee80211_flush_queues(local, sdata, false);
 
-	drv_mgd_complete_tx(sdata->local, sdata, &info);
+	if (tx || frame_buf)
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 
 	/* clear AP addr only after building the needed mgmt frames */
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
@@ -7311,7 +7312,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 52245dbfae31..c333132e2079 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -631,7 +631,9 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.data		= &nf_conntrack_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	[NF_SYSCTL_CT_COUNT] = {
 		.procname	= "nf_conntrack_count",
@@ -667,7 +669,9 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.data		= &nf_ct_expect_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	[NF_SYSCTL_CT_ACCT] = {
 		.procname	= "nf_conntrack_acct",
@@ -970,7 +974,9 @@ static struct ctl_table nf_ct_netfilter_table[] = {
 		.data		= &nf_conntrack_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{ }
 };
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index fc1370c29373..61b91de8065f 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -176,6 +176,11 @@ struct hfsc_sched {
 
 #define	HT_INFINITY	0xffffffffffffffffULL	/* infinite time value */
 
+static bool cl_in_el_or_vttree(struct hfsc_class *cl)
+{
+	return ((cl->cl_flags & HFSC_FSC) && cl->cl_nactive) ||
+		((cl->cl_flags & HFSC_RSC) && !RB_EMPTY_NODE(&cl->el_node));
+}
 
 /*
  * eligible tree holds backlogged classes being sorted by their eligible times.
@@ -1041,6 +1046,8 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (cl == NULL)
 		return -ENOBUFS;
 
+	RB_CLEAR_NODE(&cl->el_node);
+
 	err = tcf_block_get(&cl->block, &cl->filter_list, sch, extack);
 	if (err) {
 		kfree(cl);
@@ -1568,7 +1575,10 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		return err;
 	}
 
-	if (first && !cl->cl_nactive) {
+	sch->qstats.backlog += len;
+	sch->q.qlen++;
+
+	if (first && !cl_in_el_or_vttree(cl)) {
 		if (cl->cl_flags & HFSC_RSC)
 			init_ed(cl, len);
 		if (cl->cl_flags & HFSC_FSC)
@@ -1583,9 +1593,6 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 
 	}
 
-	sch->qstats.backlog += len;
-	sch->q.qlen++;
-
 	return NET_XMIT_SUCCESS;
 }
 
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 399314cfab90..af12e0215274 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -1080,14 +1080,16 @@ static void smc_pnet_find_roce_by_pnetid(struct net_device *ndev,
 					 struct smc_init_info *ini)
 {
 	u8 ndev_pnetid[SMC_MAX_PNETID_LEN];
+	struct net_device *base_ndev;
 	struct net *net;
 
-	ndev = pnet_find_base_ndev(ndev);
+	base_ndev = pnet_find_base_ndev(ndev);
 	net = dev_net(ndev);
-	if (smc_pnetid_by_dev_port(ndev->dev.parent, ndev->dev_port,
+	if (smc_pnetid_by_dev_port(base_ndev->dev.parent, base_ndev->dev_port,
 				   ndev_pnetid) &&
+	    smc_pnet_find_ndev_pnetid_by_table(base_ndev, ndev_pnetid) &&
 	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid)) {
-		smc_pnet_find_rdma_dev(ndev, ini);
+		smc_pnet_find_rdma_dev(base_ndev, ini);
 		return; /* pnetid could not be determined */
 	}
 	_smc_pnet_find_roce_by_pnetid(ndev_pnetid, ini, NULL, net);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index b6529a9d37d3..a390a4e5592f 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -275,9 +275,6 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 	old = rcu_dereference_protected(clnt->cl_xprt,
 			lockdep_is_held(&clnt->cl_lock));
 
-	if (!xprt_bound(xprt))
-		clnt->cl_autobind = 1;
-
 	clnt->cl_timeout = timeout;
 	rcu_assign_pointer(clnt->cl_xprt, xprt);
 	spin_unlock(&clnt->cl_lock);
diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 82afb56695f8..1ec20163a0b7 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -797,9 +797,10 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
 	}
 
 	trace_rpcb_setport(child, map->r_status, map->r_port);
-	xprt->ops->set_port(xprt, map->r_port);
-	if (map->r_port)
+	if (map->r_port) {
+		xprt->ops->set_port(xprt, map->r_port);
 		xprt_set_bound(xprt);
+	}
 }
 
 /*
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 9b45fbdc90ca..73bc39281ef5 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -276,6 +276,8 @@ EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
 static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 {
+	if (unlikely(current->flags & PF_EXITING))
+		return -EINTR;
 	schedule();
 	if (signal_pending_state(mode, current))
 		return -ERESTARTSYS;
diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c
index 25c18f8783ce..a9c02fac039b 100644
--- a/net/tipc/crypto.c
+++ b/net/tipc/crypto.c
@@ -817,12 +817,16 @@ static int tipc_aead_encrypt(struct tipc_aead *aead, struct sk_buff *skb,
 		goto exit;
 	}
 
+	/* Get net to avoid freed tipc_crypto when delete namespace */
+	get_net(aead->crypto->net);
+
 	/* Now, do encrypt */
 	rc = crypto_aead_encrypt(req);
 	if (rc == -EINPROGRESS || rc == -EBUSY)
 		return rc;
 
 	tipc_bearer_put(b);
+	put_net(aead->crypto->net);
 
 exit:
 	kfree(ctx);
@@ -860,6 +864,7 @@ static void tipc_aead_encrypt_done(struct crypto_async_request *base, int err)
 	kfree(tx_ctx);
 	tipc_bearer_put(b);
 	tipc_aead_put(aead);
+	put_net(net);
 }
 
 /**
diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index b7f811216820..8b5d04210d7c 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -4,7 +4,7 @@
 #
 
 config UNIX
-	tristate "Unix domain sockets"
+	bool "Unix domain sockets"
 	help
 	  If you say Y here, you will include support for Unix domain sockets;
 	  sockets are the standard Unix mechanism for establishing and
@@ -14,17 +14,8 @@ config UNIX
 	  an embedded system or something similar, you therefore definitely
 	  want to say Y here.
 
-	  To compile this driver as a module, choose M here: the module will be
-	  called unix.  Note that several important services won't work
-	  correctly if you say M here and then neglect to load the module.
-
 	  Say Y unless you know what you are doing.
 
-config UNIX_SCM
-	bool
-	depends on UNIX
-	default y
-
 config	AF_UNIX_OOB
 	bool
 	depends on UNIX
diff --git a/net/unix/Makefile b/net/unix/Makefile
index 20491825b4d0..4ddd125c4642 100644
--- a/net/unix/Makefile
+++ b/net/unix/Makefile
@@ -11,5 +11,3 @@ unix-$(CONFIG_BPF_SYSCALL) += unix_bpf.o
 
 obj-$(CONFIG_UNIX_DIAG)	+= unix_diag.o
 unix_diag-y		:= diag.o
-
-obj-$(CONFIG_UNIX_SCM)	+= scm.o
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5ce60087086c..79b783a70c87 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -116,8 +116,6 @@
 #include <linux/file.h>
 #include <linux/btf_ids.h>
 
-#include "scm.h"
-
 static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
 static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
@@ -956,11 +954,11 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
-	u->inflight = 0;
+	u->listener = NULL;
+	u->vertex = NULL;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
-	INIT_LIST_HEAD(&u->link);
 	mutex_init(&u->iolock); /* single task reading lock */
 	mutex_init(&u->bindlock); /* single task binding lock */
 	init_waitqueue_head(&u->peer_wait);
@@ -1559,6 +1557,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	newsk->sk_type		= sk->sk_type;
 	init_peercred(newsk);
 	newu = unix_sk(newsk);
+	newu->listener = other;
 	RCU_INIT_POINTER(newsk->sk_wq, &newu->peer_wq);
 	otheru = unix_sk(other);
 
@@ -1652,8 +1651,8 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 		       bool kern)
 {
 	struct sock *sk = sock->sk;
-	struct sock *tsk;
 	struct sk_buff *skb;
+	struct sock *tsk;
 	int err;
 
 	err = -EOPNOTSUPP;
@@ -1683,6 +1682,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 
 	/* attach accepted sock to socket */
 	unix_state_lock(tsk);
+	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
 	unix_sock_inherit_flags(sock, newsock);
 	sock_graft(tsk, newsock);
@@ -1726,51 +1726,65 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	return err;
 }
 
+/* The "user->unix_inflight" variable is protected by the garbage
+ * collection lock, and we just read it locklessly here. If you go
+ * over the limit, there might be a tiny race in actually noticing
+ * it across threads. Tough.
+ */
+static inline bool too_many_unix_fds(struct task_struct *p)
+{
+	struct user_struct *user = current_user();
+
+	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
+		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+	return false;
+}
+
+static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	if (too_many_unix_fds(current))
+		return -ETOOMANYREFS;
+
+	/* Need to duplicate file references for the sake of garbage
+	 * collection.  Otherwise a socket in the fps might become a
+	 * candidate for GC while the skb is not yet queued.
+	 */
+	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
+	if (!UNIXCB(skb).fp)
+		return -ENOMEM;
+
+	if (unix_prepare_fpl(UNIXCB(skb).fp))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	scm->fp = UNIXCB(skb).fp;
+	UNIXCB(skb).fp = NULL;
+
+	unix_destroy_fpl(scm->fp);
+}
+
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
+}
 
-	/*
-	 * Garbage collection of unix sockets starts by selecting a set of
-	 * candidate sockets which have reference only from being in flight
-	 * (total_refs == inflight_refs).  This condition is checked once during
-	 * the candidate collection phase, and candidates are marked as such, so
-	 * that non-candidates can later be ignored.  While inflight_refs is
-	 * protected by unix_gc_lock, total_refs (file count) is not, hence this
-	 * is an instantaneous decision.
-	 *
-	 * Once a candidate, however, the socket must not be reinstalled into a
-	 * file descriptor while the garbage collection is in progress.
-	 *
-	 * If the above conditions are met, then the directed graph of
-	 * candidates (*) does not change while unix_gc_lock is held.
-	 *
-	 * Any operations that changes the file count through file descriptors
-	 * (dup, close, sendmsg) does not change the graph since candidates are
-	 * not installed in fds.
-	 *
-	 * Dequeing a candidate via recvmsg would install it into an fd, but
-	 * that takes unix_gc_lock to decrement the inflight count, so it's
-	 * serialized with garbage collection.
-	 *
-	 * MSG_PEEK is special in that it does not change the inflight count,
-	 * yet does install the socket into an fd.  The following lock/unlock
-	 * pair is to ensure serialization with garbage collection.  It must be
-	 * done between incrementing the file count and installing the file into
-	 * an fd.
-	 *
-	 * If garbage collection starts after the barrier provided by the
-	 * lock/unlock, then it will see the elevated refcount and not mark this
-	 * as a candidate.  If a garbage collection is already in progress
-	 * before the file count was incremented, then the lock/unlock pair will
-	 * ensure that garbage collection is finished before progressing to
-	 * installing the fd.
-	 *
-	 * (*) A -> B where B is on the queue of A or B is on the queue of C
-	 * which is on the queue of listening socket A.
-	 */
-	spin_lock(&unix_gc_lock);
-	spin_unlock(&unix_gc_lock);
+static void unix_destruct_scm(struct sk_buff *skb)
+{
+	struct scm_cookie scm;
+
+	memset(&scm, 0, sizeof(scm));
+	scm.pid  = UNIXCB(skb).pid;
+	if (UNIXCB(skb).fp)
+		unix_detach_fds(&scm, skb);
+
+	/* Alas, it calls VFS */
+	/* So fscking what? fput() had been SMP-safe since the last Summer */
+	scm_destroy(&scm);
+	sock_wfree(skb);
 }
 
 static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool send_fds)
@@ -1845,8 +1859,10 @@ static void scm_stat_add(struct sock *sk, struct sk_buff *skb)
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_add(fp->count, &u->scm_stat.nr_fds);
+		unix_add_edges(fp, u);
+	}
 }
 
 static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
@@ -1854,8 +1870,10 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_sub(fp->count, &u->scm_stat.nr_fds);
+		unix_del_edges(fp);
+	}
 }
 
 /*
@@ -1875,11 +1893,12 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	long timeo;
 	int err;
 
-	wait_for_unix_gc();
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
 		return err;
 
+	wait_for_unix_gc(scm.fp);
+
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags&MSG_OOB)
 		goto out;
@@ -2145,11 +2164,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	bool fds_sent = false;
 	int data_len;
 
-	wait_for_unix_gc();
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
 		return err;
 
+	wait_for_unix_gc(scm.fp);
+
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags & MSG_OOB) {
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d2fc795394a5..23efb78fe9ef 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -81,278 +81,551 @@
 #include <net/scm.h>
 #include <net/tcp_states.h>
 
-#include "scm.h"
+struct unix_sock *unix_get_socket(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+
+	/* Socket ? */
+	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
+		struct socket *sock = SOCKET_I(inode);
+		const struct proto_ops *ops;
+		struct sock *sk = sock->sk;
 
-/* Internal data structures and random procedures: */
+		ops = READ_ONCE(sock->ops);
 
-static LIST_HEAD(gc_candidates);
-static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
+		/* PF_UNIX ? */
+		if (sk && ops && ops->family == PF_UNIX)
+			return unix_sk(sk);
+	}
 
-static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
-			  struct sk_buff_head *hitlist)
+	return NULL;
+}
+
+static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 {
-	struct sk_buff *skb;
-	struct sk_buff *next;
-
-	spin_lock(&x->sk_receive_queue.lock);
-	skb_queue_walk_safe(&x->sk_receive_queue, skb, next) {
-		/* Do we have file descriptors ? */
-		if (UNIXCB(skb).fp) {
-			bool hit = false;
-			/* Process the descriptors of this socket */
-			int nfd = UNIXCB(skb).fp->count;
-			struct file **fp = UNIXCB(skb).fp->fp;
-
-			while (nfd--) {
-				/* Get the socket the fd matches if it indeed does so */
-				struct sock *sk = unix_get_socket(*fp++);
-
-				if (sk) {
-					struct unix_sock *u = unix_sk(sk);
-
-					/* Ignore non-candidates, they could
-					 * have been added to the queues after
-					 * starting the garbage collection
-					 */
-					if (test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
-						hit = true;
-
-						func(u);
-					}
-				}
-			}
-			if (hit && hitlist != NULL) {
-				__skb_unlink(skb, &x->sk_receive_queue);
-				__skb_queue_tail(hitlist, skb);
-			}
-		}
+	/* If an embryo socket has a fd,
+	 * the listener indirectly holds the fd's refcnt.
+	 */
+	if (edge->successor->listener)
+		return unix_sk(edge->successor->listener)->vertex;
+
+	return edge->successor->vertex;
+}
+
+static bool unix_graph_maybe_cyclic;
+static bool unix_graph_grouped;
+
+static void unix_update_graph(struct unix_vertex *vertex)
+{
+	/* If the receiver socket is not inflight, no cyclic
+	 * reference could be formed.
+	 */
+	if (!vertex)
+		return;
+
+	unix_graph_maybe_cyclic = true;
+	unix_graph_grouped = false;
+}
+
+static LIST_HEAD(unix_unvisited_vertices);
+
+enum unix_vertex_index {
+	UNIX_VERTEX_INDEX_MARK1,
+	UNIX_VERTEX_INDEX_MARK2,
+	UNIX_VERTEX_INDEX_START,
+};
+
+static unsigned long unix_vertex_unvisited_index = UNIX_VERTEX_INDEX_MARK1;
+
+static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
+{
+	struct unix_vertex *vertex = edge->predecessor->vertex;
+
+	if (!vertex) {
+		vertex = list_first_entry(&fpl->vertices, typeof(*vertex), entry);
+		vertex->index = unix_vertex_unvisited_index;
+		vertex->out_degree = 0;
+		INIT_LIST_HEAD(&vertex->edges);
+		INIT_LIST_HEAD(&vertex->scc_entry);
+
+		list_move_tail(&vertex->entry, &unix_unvisited_vertices);
+		edge->predecessor->vertex = vertex;
 	}
-	spin_unlock(&x->sk_receive_queue.lock);
+
+	vertex->out_degree++;
+	list_add_tail(&edge->vertex_entry, &vertex->edges);
+
+	unix_update_graph(unix_edge_successor(edge));
 }
 
-static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
-			  struct sk_buff_head *hitlist)
+static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
-	if (x->sk_state != TCP_LISTEN) {
-		scan_inflight(x, func, hitlist);
-	} else {
-		struct sk_buff *skb;
-		struct sk_buff *next;
-		struct unix_sock *u;
-		LIST_HEAD(embryos);
+	struct unix_vertex *vertex = edge->predecessor->vertex;
 
-		/* For a listening socket collect the queued embryos
-		 * and perform a scan on them as well.
-		 */
-		spin_lock(&x->sk_receive_queue.lock);
-		skb_queue_walk_safe(&x->sk_receive_queue, skb, next) {
-			u = unix_sk(skb->sk);
+	if (!fpl->dead)
+		unix_update_graph(unix_edge_successor(edge));
 
-			/* An embryo cannot be in-flight, so it's safe
-			 * to use the list link.
-			 */
-			BUG_ON(!list_empty(&u->link));
-			list_add_tail(&u->link, &embryos);
-		}
-		spin_unlock(&x->sk_receive_queue.lock);
+	list_del(&edge->vertex_entry);
+	vertex->out_degree--;
 
-		while (!list_empty(&embryos)) {
-			u = list_entry(embryos.next, struct unix_sock, link);
-			scan_inflight(&u->sk, func, hitlist);
-			list_del_init(&u->link);
-		}
+	if (!vertex->out_degree) {
+		edge->predecessor->vertex = NULL;
+		list_move_tail(&vertex->entry, &fpl->vertices);
 	}
 }
 
-static void dec_inflight(struct unix_sock *usk)
+static void unix_free_vertices(struct scm_fp_list *fpl)
 {
-	usk->inflight--;
+	struct unix_vertex *vertex, *next_vertex;
+
+	list_for_each_entry_safe(vertex, next_vertex, &fpl->vertices, entry) {
+		list_del(&vertex->entry);
+		kfree(vertex);
+	}
 }
 
-static void inc_inflight(struct unix_sock *usk)
+static DEFINE_SPINLOCK(unix_gc_lock);
+unsigned int unix_tot_inflight;
+
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
-	usk->inflight++;
+	int i = 0, j = 0;
+
+	spin_lock(&unix_gc_lock);
+
+	if (!fpl->count_unix)
+		goto out;
+
+	do {
+		struct unix_sock *inflight = unix_get_socket(fpl->fp[j++]);
+		struct unix_edge *edge;
+
+		if (!inflight)
+			continue;
+
+		edge = fpl->edges + i++;
+		edge->predecessor = inflight;
+		edge->successor = receiver;
+
+		unix_add_edge(fpl, edge);
+	} while (i < fpl->count_unix);
+
+	receiver->scm_stat.nr_unix_fds += fpl->count_unix;
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
+out:
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
+
+	spin_unlock(&unix_gc_lock);
+
+	fpl->inflight = true;
+
+	unix_free_vertices(fpl);
 }
 
-static void inc_inflight_move_tail(struct unix_sock *u)
+void unix_del_edges(struct scm_fp_list *fpl)
 {
-	u->inflight++;
+	struct unix_sock *receiver;
+	int i = 0;
+
+	spin_lock(&unix_gc_lock);
 
-	/* If this still might be part of a cycle, move it to the end
-	 * of the list, so that it's checked even if it was already
-	 * passed over
+	if (!fpl->count_unix)
+		goto out;
+
+	do {
+		struct unix_edge *edge = fpl->edges + i++;
+
+		unix_del_edge(fpl, edge);
+	} while (i < fpl->count_unix);
+
+	if (!fpl->dead) {
+		receiver = fpl->edges[0].successor;
+		receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
+	}
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
+out:
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
+
+	spin_unlock(&unix_gc_lock);
+
+	fpl->inflight = false;
+}
+
+void unix_update_edges(struct unix_sock *receiver)
+{
+	/* nr_unix_fds is only updated under unix_state_lock().
+	 * If it's 0 here, the embryo socket is not part of the
+	 * inflight graph, and GC will not see it, so no lock needed.
 	 */
-	if (test_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags))
-		list_move_tail(&u->link, &gc_candidates);
+	if (!receiver->scm_stat.nr_unix_fds) {
+		receiver->listener = NULL;
+	} else {
+		spin_lock(&unix_gc_lock);
+		unix_update_graph(unix_sk(receiver->listener)->vertex);
+		receiver->listener = NULL;
+		spin_unlock(&unix_gc_lock);
+	}
 }
 
-static bool gc_in_progress;
-#define UNIX_INFLIGHT_TRIGGER_GC 16000
+int unix_prepare_fpl(struct scm_fp_list *fpl)
+{
+	struct unix_vertex *vertex;
+	int i;
+
+	if (!fpl->count_unix)
+		return 0;
+
+	for (i = 0; i < fpl->count_unix; i++) {
+		vertex = kmalloc(sizeof(*vertex), GFP_KERNEL);
+		if (!vertex)
+			goto err;
+
+		list_add(&vertex->entry, &fpl->vertices);
+	}
+
+	fpl->edges = kvmalloc_array(fpl->count_unix, sizeof(*fpl->edges),
+				    GFP_KERNEL_ACCOUNT);
+	if (!fpl->edges)
+		goto err;
+
+	return 0;
 
-void wait_for_unix_gc(void)
+err:
+	unix_free_vertices(fpl);
+	return -ENOMEM;
+}
+
+void unix_destroy_fpl(struct scm_fp_list *fpl)
 {
-	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
-	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight() and gc_in_progress().
-	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
-	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
+	if (fpl->inflight)
+		unix_del_edges(fpl);
+
+	kvfree(fpl->edges);
+	unix_free_vertices(fpl);
 }
 
-/* The external entry point: unix_gc() */
-void unix_gc(void)
+static bool unix_vertex_dead(struct unix_vertex *vertex)
 {
-	struct sk_buff *next_skb, *skb;
+	struct unix_edge *edge;
 	struct unix_sock *u;
-	struct unix_sock *next;
-	struct sk_buff_head hitlist;
-	struct list_head cursor;
-	LIST_HEAD(not_cycle_list);
+	long total_ref;
 
-	spin_lock(&unix_gc_lock);
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		struct unix_vertex *next_vertex = unix_edge_successor(edge);
 
-	/* Avoid a recursive GC. */
-	if (gc_in_progress)
-		goto out;
+		/* The vertex's fd can be received by a non-inflight socket. */
+		if (!next_vertex)
+			return false;
 
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, true);
+		/* The vertex's fd can be received by an inflight socket in
+		 * another SCC.
+		 */
+		if (next_vertex->scc_index != vertex->scc_index)
+			return false;
+	}
 
-	/* First, select candidates for garbage collection.  Only
-	 * in-flight sockets are considered, and from those only ones
-	 * which don't have any external reference.
-	 *
-	 * Holding unix_gc_lock will protect these candidates from
-	 * being detached, and hence from gaining an external
-	 * reference.  Since there are no possible receivers, all
-	 * buffers currently on the candidates' queues stay there
-	 * during the garbage collection.
-	 *
-	 * We also know that no new candidate can be added onto the
-	 * receive queues.  Other, non candidate sockets _can_ be
-	 * added to queue, so we must make sure only to touch
-	 * candidates.
-	 *
-	 * Embryos, though never candidates themselves, affect which
-	 * candidates are reachable by the garbage collector.  Before
-	 * being added to a listener's queue, an embryo may already
-	 * receive data carrying SCM_RIGHTS, potentially making the
-	 * passed socket a candidate that is not yet reachable by the
-	 * collector.  It becomes reachable once the embryo is
-	 * enqueued.  Therefore, we must ensure that no SCM-laden
-	 * embryo appears in a (candidate) listener's queue between
-	 * consecutive scan_children() calls.
-	 */
-	list_for_each_entry_safe(u, next, &gc_inflight_list, link) {
-		struct sock *sk = &u->sk;
-		long total_refs;
-
-		total_refs = file_count(sk->sk_socket->file);
-
-		BUG_ON(!u->inflight);
-		BUG_ON(total_refs < u->inflight);
-		if (total_refs == u->inflight) {
-			list_move_tail(&u->link, &gc_candidates);
-			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
-			__set_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
-
-			if (sk->sk_state == TCP_LISTEN) {
-				unix_state_lock_nested(sk, U_LOCK_GC_LISTENER);
-				unix_state_unlock(sk);
+	/* No receiver exists out of the same SCC. */
+
+	edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
+	u = edge->predecessor;
+	total_ref = file_count(u->sk.sk_socket->file);
+
+	/* If not close()d, total_ref > out_degree. */
+	if (total_ref != vertex->out_degree)
+		return false;
+
+	return true;
+}
+
+enum unix_recv_queue_lock_class {
+	U_RECVQ_LOCK_NORMAL,
+	U_RECVQ_LOCK_EMBRYO,
+};
+
+static void unix_collect_queue(struct unix_sock *u, struct sk_buff_head *hitlist)
+{
+	skb_queue_splice_init(&u->sk.sk_receive_queue, hitlist);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	if (u->oob_skb) {
+		WARN_ON_ONCE(skb_unref(u->oob_skb));
+		u->oob_skb = NULL;
+	}
+#endif
+}
+
+static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
+{
+	struct unix_vertex *vertex;
+
+	list_for_each_entry_reverse(vertex, scc, scc_entry) {
+		struct sk_buff_head *queue;
+		struct unix_edge *edge;
+		struct unix_sock *u;
+
+		edge = list_first_entry(&vertex->edges, typeof(*edge), vertex_entry);
+		u = edge->predecessor;
+		queue = &u->sk.sk_receive_queue;
+
+		spin_lock(&queue->lock);
+
+		if (u->sk.sk_state == TCP_LISTEN) {
+			struct sk_buff *skb;
+
+			skb_queue_walk(queue, skb) {
+				struct sk_buff_head *embryo_queue = &skb->sk->sk_receive_queue;
+
+				/* listener -> embryo order, the inversion never happens. */
+				spin_lock_nested(&embryo_queue->lock, U_RECVQ_LOCK_EMBRYO);
+				unix_collect_queue(unix_sk(skb->sk), hitlist);
+				spin_unlock(&embryo_queue->lock);
 			}
+		} else {
+			unix_collect_queue(u, hitlist);
 		}
+
+		spin_unlock(&queue->lock);
 	}
+}
 
-	/* Now remove all internal in-flight reference to children of
-	 * the candidates.
-	 */
-	list_for_each_entry(u, &gc_candidates, link)
-		scan_children(&u->sk, dec_inflight, NULL);
+static bool unix_scc_cyclic(struct list_head *scc)
+{
+	struct unix_vertex *vertex;
+	struct unix_edge *edge;
 
-	/* Restore the references for children of all candidates,
-	 * which have remaining references.  Do this recursively, so
-	 * only those remain, which form cyclic references.
-	 *
-	 * Use a "cursor" link, to make the list traversal safe, even
-	 * though elements might be moved about.
+	/* SCC containing multiple vertices ? */
+	if (!list_is_singular(scc))
+		return true;
+
+	vertex = list_first_entry(scc, typeof(*vertex), scc_entry);
+
+	/* Self-reference or a embryo-listener circle ? */
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		if (unix_edge_successor(edge) == vertex)
+			return true;
+	}
+
+	return false;
+}
+
+static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+
+static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index,
+			    struct sk_buff_head *hitlist)
+{
+	LIST_HEAD(vertex_stack);
+	struct unix_edge *edge;
+	LIST_HEAD(edge_stack);
+
+next_vertex:
+	/* Push vertex to vertex_stack and mark it as on-stack
+	 * (index >= UNIX_VERTEX_INDEX_START).
+	 * The vertex will be popped when finalising SCC later.
 	 */
-	list_add(&cursor, &gc_candidates);
-	while (cursor.next != &gc_candidates) {
-		u = list_entry(cursor.next, struct unix_sock, link);
+	list_add(&vertex->scc_entry, &vertex_stack);
+
+	vertex->index = *last_index;
+	vertex->scc_index = *last_index;
+	(*last_index)++;
+
+	/* Explore neighbour vertices (receivers of the current vertex's fd). */
+	list_for_each_entry(edge, &vertex->edges, vertex_entry) {
+		struct unix_vertex *next_vertex = unix_edge_successor(edge);
+
+		if (!next_vertex)
+			continue;
+
+		if (next_vertex->index == unix_vertex_unvisited_index) {
+			/* Iterative deepening depth first search
+			 *
+			 *   1. Push a forward edge to edge_stack and set
+			 *      the successor to vertex for the next iteration.
+			 */
+			list_add(&edge->stack_entry, &edge_stack);
 
-		/* Move cursor to after the current position. */
-		list_move(&cursor, &u->link);
+			vertex = next_vertex;
+			goto next_vertex;
 
-		if (u->inflight) {
-			list_move_tail(&u->link, &not_cycle_list);
-			__clear_bit(UNIX_GC_MAYBE_CYCLE, &u->gc_flags);
-			scan_children(&u->sk, inc_inflight_move_tail, NULL);
+			/*   2. Pop the edge directed to the current vertex
+			 *      and restore the ancestor for backtracking.
+			 */
+prev_vertex:
+			edge = list_first_entry(&edge_stack, typeof(*edge), stack_entry);
+			list_del_init(&edge->stack_entry);
+
+			next_vertex = vertex;
+			vertex = edge->predecessor->vertex;
+
+			/* If the successor has a smaller scc_index, two vertices
+			 * are in the same SCC, so propagate the smaller scc_index
+			 * to skip SCC finalisation.
+			 */
+			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
+		} else if (next_vertex->index != unix_vertex_grouped_index) {
+			/* Loop detected by a back/cross edge.
+			 *
+			 * The successor is on vertex_stack, so two vertices are in
+			 * the same SCC.  If the successor has a smaller *scc_index*,
+			 * propagate it to skip SCC finalisation.
+			 */
+			vertex->scc_index = min(vertex->scc_index, next_vertex->scc_index);
+		} else {
+			/* The successor was already grouped as another SCC */
 		}
 	}
-	list_del(&cursor);
 
-	/* Now gc_candidates contains only garbage.  Restore original
-	 * inflight counters for these as well, and remove the skbuffs
-	 * which are creating the cycle(s).
-	 */
-	skb_queue_head_init(&hitlist);
-	list_for_each_entry(u, &gc_candidates, link) {
-		scan_children(&u->sk, inc_inflight, &hitlist);
+	if (vertex->index == vertex->scc_index) {
+		struct unix_vertex *v;
+		struct list_head scc;
+		bool scc_dead = true;
 
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-		if (u->oob_skb) {
-			kfree_skb(u->oob_skb);
-			u->oob_skb = NULL;
+		/* SCC finalised.
+		 *
+		 * If the scc_index was not updated, all the vertices above on
+		 * vertex_stack are in the same SCC.  Group them using scc_entry.
+		 */
+		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
+
+		list_for_each_entry_reverse(v, &scc, scc_entry) {
+			/* Don't restart DFS from this vertex in unix_walk_scc(). */
+			list_move_tail(&v->entry, &unix_visited_vertices);
+
+			/* Mark vertex as off-stack. */
+			v->index = unix_vertex_grouped_index;
+
+			if (scc_dead)
+				scc_dead = unix_vertex_dead(v);
 		}
-#endif
+
+		if (scc_dead)
+			unix_collect_skb(&scc, hitlist);
+		else if (!unix_graph_maybe_cyclic)
+			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+
+		list_del(&scc);
 	}
 
-	/* not_cycle_list contains those sockets which do not make up a
-	 * cycle.  Restore these to the inflight list.
+	/* Need backtracking ? */
+	if (!list_empty(&edge_stack))
+		goto prev_vertex;
+}
+
+static void unix_walk_scc(struct sk_buff_head *hitlist)
+{
+	unsigned long last_index = UNIX_VERTEX_INDEX_START;
+
+	unix_graph_maybe_cyclic = false;
+
+	/* Visit every vertex exactly once.
+	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
 	 */
-	while (!list_empty(&not_cycle_list)) {
-		u = list_entry(not_cycle_list.next, struct unix_sock, link);
-		__clear_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
-		list_move_tail(&u->link, &gc_inflight_list);
+	while (!list_empty(&unix_unvisited_vertices)) {
+		struct unix_vertex *vertex;
+
+		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
+		__unix_walk_scc(vertex, &last_index, hitlist);
 	}
 
-	spin_unlock(&unix_gc_lock);
+	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
+	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
-	/* We need io_uring to clean its registered files, ignore all io_uring
-	 * originated skbs. It's fine as io_uring doesn't keep references to
-	 * other io_uring instances and so killing all other files in the cycle
-	 * will put all io_uring references forcing it to go through normal
-	 * release.path eventually putting registered files.
-	 */
-	skb_queue_walk_safe(&hitlist, skb, next_skb) {
-		if (skb->scm_io_uring) {
-			__skb_unlink(skb, &hitlist);
-			skb_queue_tail(&skb->sk->sk_receive_queue, skb);
+	unix_graph_grouped = true;
+}
+
+static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
+{
+	unix_graph_maybe_cyclic = false;
+
+	while (!list_empty(&unix_unvisited_vertices)) {
+		struct unix_vertex *vertex;
+		struct list_head scc;
+		bool scc_dead = true;
+
+		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
+		list_add(&scc, &vertex->scc_entry);
+
+		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
+			list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+			if (scc_dead)
+				scc_dead = unix_vertex_dead(vertex);
 		}
+
+		if (scc_dead)
+			unix_collect_skb(&scc, hitlist);
+		else if (!unix_graph_maybe_cyclic)
+			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+
+		list_del(&scc);
 	}
 
-	/* Here we are. Hitlist is filled. Die. */
-	__skb_queue_purge(&hitlist);
+	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
+}
+
+static bool gc_in_progress;
+
+static void __unix_gc(struct work_struct *work)
+{
+	struct sk_buff_head hitlist;
+	struct sk_buff *skb;
 
 	spin_lock(&unix_gc_lock);
 
-	/* There could be io_uring registered files, just push them back to
-	 * the inflight list
-	 */
-	list_for_each_entry_safe(u, next, &gc_candidates, link)
-		list_move_tail(&u->link, &gc_inflight_list);
+	if (!unix_graph_maybe_cyclic) {
+		spin_unlock(&unix_gc_lock);
+		goto skip_gc;
+	}
+
+	__skb_queue_head_init(&hitlist);
+
+	if (unix_graph_grouped)
+		unix_walk_scc_fast(&hitlist);
+	else
+		unix_walk_scc(&hitlist);
 
-	/* All candidates should have been detached by now. */
-	BUG_ON(!list_empty(&gc_candidates));
+	spin_unlock(&unix_gc_lock);
+
+	skb_queue_walk(&hitlist, skb) {
+		if (UNIXCB(skb).fp)
+			UNIXCB(skb).fp->dead = true;
+	}
 
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
+	__skb_queue_purge(&hitlist);
+skip_gc:
 	WRITE_ONCE(gc_in_progress, false);
+}
 
-	wake_up(&unix_gc_wait);
+static DECLARE_WORK(unix_gc_work, __unix_gc);
 
- out:
-	spin_unlock(&unix_gc_lock);
+void unix_gc(void)
+{
+	WRITE_ONCE(gc_in_progress, true);
+	queue_work(system_unbound_wq, &unix_gc_work);
+}
+
+#define UNIX_INFLIGHT_TRIGGER_GC 16000
+#define UNIX_INFLIGHT_SANE_USER (SCM_MAX_FD * 8)
+
+void wait_for_unix_gc(struct scm_fp_list *fpl)
+{
+	/* If number of inflight sockets is insane,
+	 * force a garbage collect right now.
+	 *
+	 * Paired with the WRITE_ONCE() in unix_inflight(),
+	 * unix_notinflight(), and __unix_gc().
+	 */
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
+	    !READ_ONCE(gc_in_progress))
+		unix_gc();
+
+	/* Penalise users who want to send AF_UNIX sockets
+	 * but whose sockets have not been received yet.
+	 */
+	if (!fpl || !fpl->count_unix ||
+	    READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
+		return;
+
+	if (READ_ONCE(gc_in_progress))
+		flush_work(&unix_gc_work);
 }
diff --git a/net/unix/scm.c b/net/unix/scm.c
deleted file mode 100644
index 4eff7da9f6f9..000000000000
--- a/net/unix/scm.c
+++ /dev/null
@@ -1,154 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/socket.h>
-#include <linux/net.h>
-#include <linux/fs.h>
-#include <net/af_unix.h>
-#include <net/scm.h>
-#include <linux/init.h>
-#include <linux/io_uring.h>
-
-#include "scm.h"
-
-unsigned int unix_tot_inflight;
-EXPORT_SYMBOL(unix_tot_inflight);
-
-LIST_HEAD(gc_inflight_list);
-EXPORT_SYMBOL(gc_inflight_list);
-
-DEFINE_SPINLOCK(unix_gc_lock);
-EXPORT_SYMBOL(unix_gc_lock);
-
-struct sock *unix_get_socket(struct file *filp)
-{
-	struct sock *u_sock = NULL;
-	struct inode *inode = file_inode(filp);
-
-	/* Socket ? */
-	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
-		struct socket *sock = SOCKET_I(inode);
-		struct sock *s = sock->sk;
-
-		/* PF_UNIX ? */
-		if (s && sock->ops && sock->ops->family == PF_UNIX)
-			u_sock = s;
-	}
-
-	return u_sock;
-}
-EXPORT_SYMBOL(unix_get_socket);
-
-/* Keep the number of times in flight count for the file
- * descriptor if it is for an AF_UNIX socket.
- */
-void unix_inflight(struct user_struct *user, struct file *fp)
-{
-	struct sock *s = unix_get_socket(fp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
-		if (!u->inflight) {
-			BUG_ON(!list_empty(&u->link));
-			list_add_tail(&u->link, &gc_inflight_list);
-		} else {
-			BUG_ON(list_empty(&u->link));
-		}
-		u->inflight++;
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
-	}
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
-	spin_unlock(&unix_gc_lock);
-}
-
-void unix_notinflight(struct user_struct *user, struct file *fp)
-{
-	struct sock *s = unix_get_socket(fp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
-		BUG_ON(!u->inflight);
-		BUG_ON(list_empty(&u->link));
-
-		u->inflight--;
-		if (!u->inflight)
-			list_del_init(&u->link);
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
-	}
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
-	spin_unlock(&unix_gc_lock);
-}
-
-/*
- * The "user->unix_inflight" variable is protected by the garbage
- * collection lock, and we just read it locklessly here. If you go
- * over the limit, there might be a tiny race in actually noticing
- * it across threads. Tough.
- */
-static inline bool too_many_unix_fds(struct task_struct *p)
-{
-	struct user_struct *user = current_user();
-
-	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
-		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
-	return false;
-}
-
-int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
-{
-	int i;
-
-	if (too_many_unix_fds(current))
-		return -ETOOMANYREFS;
-
-	/*
-	 * Need to duplicate file references for the sake of garbage
-	 * collection.  Otherwise a socket in the fps might become a
-	 * candidate for GC while the skb is not yet queued.
-	 */
-	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
-	if (!UNIXCB(skb).fp)
-		return -ENOMEM;
-
-	for (i = scm->fp->count - 1; i >= 0; i--)
-		unix_inflight(scm->fp->user, scm->fp->fp[i]);
-	return 0;
-}
-EXPORT_SYMBOL(unix_attach_fds);
-
-void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
-{
-	int i;
-
-	scm->fp = UNIXCB(skb).fp;
-	UNIXCB(skb).fp = NULL;
-
-	for (i = scm->fp->count-1; i >= 0; i--)
-		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
-}
-EXPORT_SYMBOL(unix_detach_fds);
-
-void unix_destruct_scm(struct sk_buff *skb)
-{
-	struct scm_cookie scm;
-
-	memset(&scm, 0, sizeof(scm));
-	scm.pid  = UNIXCB(skb).pid;
-	if (UNIXCB(skb).fp)
-		unix_detach_fds(&scm, skb);
-
-	/* Alas, it calls VFS */
-	/* So fscking what? fput() had been SMP-safe since the last Summer */
-	scm_destroy(&scm);
-	sock_wfree(skb);
-}
-EXPORT_SYMBOL(unix_destruct_scm);
diff --git a/net/unix/scm.h b/net/unix/scm.h
deleted file mode 100644
index 5a255a477f16..000000000000
--- a/net/unix/scm.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef NET_UNIX_SCM_H
-#define NET_UNIX_SCM_H
-
-extern struct list_head gc_inflight_list;
-extern spinlock_t unix_gc_lock;
-
-int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb);
-void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb);
-
-#endif
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a022f4984687..e015ff225b27 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1597,6 +1597,9 @@ int xfrm_policy_insert(int dir, struct xfrm_policy *policy, int excl)
 	struct xfrm_policy *delpol;
 	struct hlist_head *chain;
 
+	/* Sanitize mark before store */
+	policy->mark.v &= policy->mark.m;
+
 	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
 	chain = policy_hash_bysel(net, &policy->selector, policy->family, dir);
 	if (chain)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 2f4cf976b59a..58c53bb1c583 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -694,9 +694,6 @@ int __xfrm_state_delete(struct xfrm_state *x)
 		net->xfrm.state_num--;
 		spin_unlock(&net->xfrm.xfrm_state_lock);
 
-		if (x->encap_sk)
-			sock_put(rcu_dereference_raw(x->encap_sk));
-
 		xfrm_dev_state_delete(x);
 
 		/* All xfrm_state objects are created by xfrm_state_alloc.
@@ -1278,6 +1275,9 @@ static void __xfrm_state_insert(struct xfrm_state *x)
 
 	list_add(&x->km.all, &net->xfrm.state_all);
 
+	/* Sanitize mark before store */
+	x->mark.v &= x->mark.m;
+
 	h = xfrm_dst_hash(net, &x->id.daddr, &x->props.saddr,
 			  x->props.reqid, x->props.family);
 	hlist_add_head_rcu(&x->bydst, net->xfrm.state_bydst + h);
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 727da3c5879b..77bf18cfdae7 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
 	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
 		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
-		-I$(LIBBPF_INCLUDE) \
+		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
diff --git a/scripts/config b/scripts/config
index ff88e2faefd3..ea475c07de28 100755
--- a/scripts/config
+++ b/scripts/config
@@ -32,6 +32,7 @@ commands:
                              Disable option directly after other option
 	--module-after|-M beforeopt option
                              Turn option into module directly after other option
+	--refresh            Refresh the config using old settings
 
 	commands can be repeated multiple times
 
@@ -124,16 +125,22 @@ undef_var() {
 	txt_delete "^# $name is not set" "$FN"
 }
 
-if [ "$1" = "--file" ]; then
-	FN="$2"
-	if [ "$FN" = "" ] ; then
-		usage
+FN=.config
+CMDS=()
+while [[ $# -gt 0 ]]; do
+	if [ "$1" = "--file" ]; then
+		if [ "$2" = "" ]; then
+			usage
+		fi
+		FN="$2"
+		shift 2
+	else
+		CMDS+=("$1")
+		shift
 	fi
-	shift 2
-else
-	FN=.config
-fi
+done
 
+set -- "${CMDS[@]}"
 if [ "$1" = "" ] ; then
 	usage
 fi
@@ -217,9 +224,8 @@ while [ "$1" != "" ] ; do
 		set_var "${CONFIG_}$B" "${CONFIG_}$B=m" "${CONFIG_}$A"
 		;;
 
-	# undocumented because it ignores --file (fixme)
 	--refresh)
-		yes "" | make oldconfig
+		yes "" | make oldconfig KCONFIG_CONFIG=$FN
 		;;
 
 	*)
diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 72da3b8d6f30..151f9938abaa 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -105,8 +105,8 @@ INITFILE=$1
 shift;
 
 if [ ! -r "$INITFILE" ]; then
-	echo "The base file '$INITFILE' does not exist.  Exit." >&2
-	exit 1
+	echo "The base file '$INITFILE' does not exist. Creating one..." >&2
+	touch "$INITFILE"
 fi
 
 MERGE_LIST=$*
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index d955f3dcb3a5..9dca3672d82b 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -922,6 +922,10 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
 		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
+		if (ncats.attr.mls.cat)
+			skp->smk_netlabel.flags |= NETLBL_SECATTR_MLS_CAT;
+		else
+			skp->smk_netlabel.flags &= ~(u32)NETLBL_SECATTR_MLS_CAT;
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index ac2efeb63a39..2b9fada97532 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1085,8 +1085,7 @@ static int snd_pcm_oss_change_params_locked(struct snd_pcm_substream *substream)
 	runtime->oss.params = 0;
 	runtime->oss.prepare = 1;
 	runtime->oss.buffer_used = 0;
-	if (runtime->dma_area)
-		snd_pcm_format_set_silence(runtime->format, runtime->dma_area, bytes_to_samples(runtime, runtime->dma_bytes));
+	snd_pcm_runtime_buffer_set_silence(runtime);
 
 	runtime->oss.period_frames = snd_pcm_alsa_frames(substream, oss_period_size);
 
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f46b87ca76d0..bf752b188b05 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -703,6 +703,17 @@ static void snd_pcm_buffer_access_unlock(struct snd_pcm_runtime *runtime)
 	atomic_inc(&runtime->buffer_accessing);
 }
 
+/* fill the PCM buffer with the current silence format; called from pcm_oss.c */
+void snd_pcm_runtime_buffer_set_silence(struct snd_pcm_runtime *runtime)
+{
+	snd_pcm_buffer_access_lock(runtime);
+	if (runtime->dma_area)
+		snd_pcm_format_set_silence(runtime->format, runtime->dma_area,
+					   bytes_to_samples(runtime, runtime->dma_bytes));
+	snd_pcm_buffer_access_unlock(runtime);
+}
+EXPORT_SYMBOL_GPL(snd_pcm_runtime_buffer_set_silence);
+
 #if IS_ENABLED(CONFIG_SND_PCM_OSS)
 #define is_oss_stream(substream)	((substream)->oss.oss)
 #else
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 2d707afa1ef1..1252ea7ad55e 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1140,8 +1140,7 @@ static __poll_t snd_seq_poll(struct file *file, poll_table * wait)
 	if (snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT) {
 
 		/* check if data is available in the pool */
-		if (!snd_seq_write_pool_allocated(client) ||
-		    snd_seq_pool_poll_wait(client->pool, file, wait))
+		if (snd_seq_pool_poll_wait(client->pool, file, wait))
 			mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
@@ -2382,8 +2381,6 @@ int snd_seq_kernel_client_write_poll(int clientid, struct file *file, poll_table
 	if (client == NULL)
 		return -ENXIO;
 
-	if (! snd_seq_write_pool_allocated(client))
-		return 1;
 	if (snd_seq_pool_poll_wait(client->pool, file, wait))
 		return 1;
 	return 0;
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 47ef6bc30c0e..e30b92d85079 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -366,6 +366,7 @@ int snd_seq_pool_poll_wait(struct snd_seq_pool *pool, struct file *file,
 			   poll_table *wait)
 {
 	poll_wait(file, &pool->output_sleep, wait);
+	guard(spinlock_irq)(&pool->lock);
 	return snd_seq_output_ok(pool);
 }
 
diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index e63621bcb214..1a684e47d4d1 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -31,8 +31,9 @@ static void generate_tone(struct hda_beep *beep, int tone)
 			beep->power_hook(beep, true);
 		beep->playing = 1;
 	}
-	snd_hda_codec_write(codec, beep->nid, 0,
-			    AC_VERB_SET_BEEP_CONTROL, tone);
+	if (!codec->beep_just_power_on)
+		snd_hda_codec_write(codec, beep->nid, 0,
+				    AC_VERB_SET_BEEP_CONTROL, tone);
 	if (!tone && beep->playing) {
 		beep->playing = 0;
 		if (beep->power_hook)
@@ -212,10 +213,12 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 	struct hda_beep *beep;
 	int err;
 
-	if (!snd_hda_get_bool_hint(codec, "beep"))
-		return 0; /* disabled explicitly by hints */
-	if (codec->beep_mode == HDA_BEEP_MODE_OFF)
-		return 0; /* disabled by module option */
+	if (!codec->beep_just_power_on) {
+		if (!snd_hda_get_bool_hint(codec, "beep"))
+			return 0; /* disabled explicitly by hints */
+		if (codec->beep_mode == HDA_BEEP_MODE_OFF)
+			return 0; /* disabled by module option */
+	}
 
 	beep = kzalloc(sizeof(*beep), GFP_KERNEL);
 	if (beep == NULL)
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 61b48f2418bf..115c675819e6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -24,6 +24,7 @@
 #include <sound/hda_codec.h>
 #include "hda_local.h"
 #include "hda_auto_parser.h"
+#include "hda_beep.h"
 #include "hda_jack.h"
 #include "hda_generic.h"
 #include "hda_component.h"
@@ -6786,6 +6787,41 @@ static void alc285_fixup_hp_spectre_x360_eb1(struct hda_codec *codec,
 	}
 }
 
+/* GPIO1 = amplifier on/off */
+static void alc285_fixup_hp_spectre_x360_df1(struct hda_codec *codec,
+					     const struct hda_fixup *fix,
+					     int action)
+{
+	struct alc_spec *spec = codec->spec;
+	static const hda_nid_t conn[] = { 0x02 };
+	static const struct hda_pintbl pincfgs[] = {
+		{ 0x14, 0x90170110 },  /* front/high speakers */
+		{ 0x17, 0x90170130 },  /* back/bass speakers */
+		{ }
+	};
+
+	// enable mute led
+	alc285_fixup_hp_mute_led_coefbit(codec, fix, action);
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		/* needed for amp of back speakers */
+		spec->gpio_mask |= 0x01;
+		spec->gpio_dir |= 0x01;
+		snd_hda_apply_pincfgs(codec, pincfgs);
+		/* share DAC to have unified volume control */
+		snd_hda_override_conn_list(codec, 0x14, ARRAY_SIZE(conn), conn);
+		snd_hda_override_conn_list(codec, 0x17, ARRAY_SIZE(conn), conn);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		/* need to toggle GPIO to enable the amp of back speakers */
+		alc_update_gpio_data(codec, 0x01, true);
+		msleep(100);
+		alc_update_gpio_data(codec, 0x01, false);
+		break;
+	}
+}
+
 static void alc285_fixup_hp_spectre_x360(struct hda_codec *codec,
 					  const struct hda_fixup *fix, int action)
 {
@@ -6858,6 +6894,30 @@ static void alc285_fixup_hp_envy_x360(struct hda_codec *codec,
 	}
 }
 
+static void alc285_fixup_hp_beep(struct hda_codec *codec,
+				 const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		codec->beep_just_power_on = true;
+	} else  if (action == HDA_FIXUP_ACT_INIT) {
+#ifdef CONFIG_SND_HDA_INPUT_BEEP
+		/*
+		 * Just enable loopback to internal speaker and headphone jack.
+		 * Disable amplification to get about the same beep volume as
+		 * was on pure BIOS setup before loading the driver.
+		 */
+		alc_update_coef_idx(codec, 0x36, 0x7070, BIT(13));
+
+		snd_hda_enable_beep_device(codec, 1);
+
+#if !IS_ENABLED(CONFIG_INPUT_PCSPKR)
+		dev_warn_once(hda_codec_dev(codec),
+			      "enable CONFIG_INPUT_PCSPKR to get PC beeps\n");
+#endif
+#endif
+	}
+}
+
 /* for hda_fixup_thinkpad_acpi() */
 #include "thinkpad_helper.c"
 
@@ -7301,6 +7361,7 @@ enum {
 	ALC280_FIXUP_HP_9480M,
 	ALC245_FIXUP_HP_X360_AMP,
 	ALC285_FIXUP_HP_SPECTRE_X360_EB1,
+	ALC285_FIXUP_HP_SPECTRE_X360_DF1,
 	ALC285_FIXUP_HP_ENVY_X360,
 	ALC288_FIXUP_DELL_HEADSET_MODE,
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -7400,6 +7461,7 @@ enum {
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED,
+	ALC285_FIXUP_HP_BEEP_MICMUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
@@ -8947,6 +9009,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_mute_led,
 	},
+	[ALC285_FIXUP_HP_BEEP_MICMUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_beep,
+		.chained = true,
+		.chain_id = ALC285_FIXUP_HP_MUTE_LED,
+	},
 	[ALC236_FIXUP_HP_MUTE_LED_COEFBIT2] = {
 	    .type = HDA_FIXUP_FUNC,
 	    .v.func = alc236_fixup_hp_mute_led_coefbit2,
@@ -9290,6 +9358,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_spectre_x360_eb1
 	},
+	[ALC285_FIXUP_HP_SPECTRE_X360_DF1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_hp_spectre_x360_df1
+	},
 	[ALC285_FIXUP_HP_ENVY_X360] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_envy_x360,
@@ -9850,6 +9922,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x86c1, "HP Laptop 15-da3001TU", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x863e, "HP Spectre x360 15-df1xxx", ALC285_FIXUP_HP_SPECTRE_X360_DF1),
 	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x86f9, "HP Spectre x360 13-aw0xxx", ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8716, "HP Elite Dragonfly G2 Notebook PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
@@ -9860,7 +9933,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8730, "HP ProBook 445 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8735, "HP ProBook 435 G7", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8736, "HP", ALC285_FIXUP_HP_GPIO_AMP_INIT),
-	SND_PCI_QUIRK(0x103c, 0x8760, "HP", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x8760, "HP EliteBook 8{4,5}5 G7", ALC285_FIXUP_HP_BEEP_MICMUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x876e, "HP ENVY x360 Convertible 13-ay0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x877a, "HP", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x877d, "HP", ALC236_FIXUP_HP_MUTE_LED),
@@ -10306,6 +10379,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
@@ -10559,6 +10633,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC295_FIXUP_HP_OMEN, .name = "alc295-hp-omen"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360, .name = "alc285-hp-spectre-x360"},
 	{.id = ALC285_FIXUP_HP_SPECTRE_X360_EB1, .name = "alc285-hp-spectre-x360-eb1"},
+	{.id = ALC285_FIXUP_HP_SPECTRE_X360_DF1, .name = "alc285-hp-spectre-x360-df1"},
 	{.id = ALC285_FIXUP_HP_ENVY_X360, .name = "alc285-hp-envy-x360"},
 	{.id = ALC287_FIXUP_IDEAPAD_BASS_SPK_AMP, .name = "alc287-ideapad-bass-spk-amp"},
 	{.id = ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN, .name = "alc287-yoga9-bass-spk-pin"},
diff --git a/sound/soc/codecs/mt6359-accdet.h b/sound/soc/codecs/mt6359-accdet.h
index c234f2f4276a..78ada3a5bfae 100644
--- a/sound/soc/codecs/mt6359-accdet.h
+++ b/sound/soc/codecs/mt6359-accdet.h
@@ -123,6 +123,15 @@ struct mt6359_accdet {
 	struct workqueue_struct *jd_workqueue;
 };
 
+#if IS_ENABLED(CONFIG_SND_SOC_MT6359_ACCDET)
 int mt6359_accdet_enable_jack_detect(struct snd_soc_component *component,
 				     struct snd_soc_jack *jack);
+#else
+static inline int
+mt6359_accdet_enable_jack_detect(struct snd_soc_component *component,
+				 struct snd_soc_jack *jack)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif
diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 9d6431338fb7..329549936bd5 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -494,9 +494,9 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		}
 		break;
 	case 24:
-		if (provider_mode || (format == SND_SOC_DAIFMT_DSP_A) ||
-		    		     (format == SND_SOC_DAIFMT_DSP_B)) {
-			dev_err(component->dev, "24-bit slots not supported in provider mode, or consumer mode using DSP\n");
+		if (!provider_mode && ((format == SND_SOC_DAIFMT_DSP_A) ||
+				       (format == SND_SOC_DAIFMT_DSP_B))) {
+			dev_err(component->dev, "24-bit slots not supported in consumer mode using DSP\n");
 			return -EINVAL;
 		}
 		break;
diff --git a/sound/soc/codecs/tas2764.c b/sound/soc/codecs/tas2764.c
index fc8479d3d285..10f0f07b90ff 100644
--- a/sound/soc/codecs/tas2764.c
+++ b/sound/soc/codecs/tas2764.c
@@ -182,33 +182,6 @@ static SOC_ENUM_SINGLE_DECL(
 static const struct snd_kcontrol_new tas2764_asi1_mux =
 	SOC_DAPM_ENUM("ASI1 Source", tas2764_ASI1_src_enum);
 
-static int tas2764_dac_event(struct snd_soc_dapm_widget *w,
-			     struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
-	struct tas2764_priv *tas2764 = snd_soc_component_get_drvdata(component);
-	int ret;
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		tas2764->dac_powered = true;
-		ret = tas2764_update_pwr_ctrl(tas2764);
-		break;
-	case SND_SOC_DAPM_PRE_PMD:
-		tas2764->dac_powered = false;
-		ret = tas2764_update_pwr_ctrl(tas2764);
-		break;
-	default:
-		dev_err(tas2764->dev, "Unsupported event\n");
-		return -EINVAL;
-	}
-
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static const struct snd_kcontrol_new isense_switch =
 	SOC_DAPM_SINGLE("Switch", TAS2764_PWR_CTRL, TAS2764_ISENSE_POWER_EN, 1, 1);
 static const struct snd_kcontrol_new vsense_switch =
@@ -221,8 +194,7 @@ static const struct snd_soc_dapm_widget tas2764_dapm_widgets[] = {
 			    1, &isense_switch),
 	SND_SOC_DAPM_SWITCH("VSENSE", TAS2764_PWR_CTRL, TAS2764_VSENSE_POWER_EN,
 			    1, &vsense_switch),
-	SND_SOC_DAPM_DAC_E("DAC", NULL, SND_SOC_NOPM, 0, 0, tas2764_dac_event,
-			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUTPUT("OUT"),
 	SND_SOC_DAPM_SIGGEN("VMON"),
 	SND_SOC_DAPM_SIGGEN("IMON")
@@ -243,9 +215,28 @@ static int tas2764_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
 	struct tas2764_priv *tas2764 =
 			snd_soc_component_get_drvdata(dai->component);
+	int ret;
+
+	if (!mute) {
+		tas2764->dac_powered = true;
+		ret = tas2764_update_pwr_ctrl(tas2764);
+		if (ret)
+			return ret;
+	}
 
 	tas2764->unmuted = !mute;
-	return tas2764_update_pwr_ctrl(tas2764);
+	ret = tas2764_update_pwr_ctrl(tas2764);
+	if (ret)
+		return ret;
+
+	if (mute) {
+		tas2764->dac_powered = false;
+		ret = tas2764_update_pwr_ctrl(tas2764);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int tas2764_set_bitwidth(struct tas2764_priv *tas2764, int bitwidth)
@@ -636,6 +627,7 @@ static const struct reg_default tas2764_reg_defaults[] = {
 	{ TAS2764_TDM_CFG2, 0x0a },
 	{ TAS2764_TDM_CFG3, 0x10 },
 	{ TAS2764_TDM_CFG5, 0x42 },
+	{ TAS2764_INT_CLK_CFG, 0x19 },
 };
 
 static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
@@ -653,6 +645,7 @@ static const struct regmap_range_cfg tas2764_regmap_ranges[] = {
 static bool tas2764_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case TAS2764_SW_RST:
 	case TAS2764_INT_LTCH0 ... TAS2764_INT_LTCH4:
 	case TAS2764_INT_CLK_CFG:
 		return true;
diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index c6d55b21f949..11430f9f4996 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -517,7 +517,7 @@ static int imx_card_parse_of(struct imx_card_data *data)
 	if (!card->dai_link)
 		return -ENOMEM;
 
-	data->link_data = devm_kcalloc(dev, num_links, sizeof(*link), GFP_KERNEL);
+	data->link_data = devm_kcalloc(dev, num_links, sizeof(*link_data), GFP_KERNEL);
 	if (!data->link_data)
 		return -ENOMEM;
 
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 67b343632a10..b00a9fdd7a9c 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -576,6 +576,19 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{       /* Acer Aspire SW3-013 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW3-013"),
+		},
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 41be09a07ca7..65e51b6b46ff 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -7,6 +7,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <linux/soundwire/sdw.h>
 #include <sound/jack.h>
 #include <linux/input-event-codes.h>
@@ -39,9 +40,11 @@ static int sm8250_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
diff --git a/sound/soc/soc-dai.c b/sound/soc/soc-dai.c
index 49752af0e205..ba38b6e6b264 100644
--- a/sound/soc/soc-dai.c
+++ b/sound/soc/soc-dai.c
@@ -270,10 +270,11 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 
 	if (dai->driver->ops &&
 	    dai->driver->ops->xlate_tdm_slot_mask)
-		dai->driver->ops->xlate_tdm_slot_mask(slots,
-						      &tx_mask, &rx_mask);
+		ret = dai->driver->ops->xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 	else
-		snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+		ret = snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
+	if (ret)
+		goto err;
 
 	dai->tx_mask = tx_mask;
 	dai->rx_mask = rx_mask;
@@ -282,6 +283,7 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	    dai->driver->ops->set_tdm_slot)
 		ret = dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 						      slots, slot_width);
+err:
 	return soc_dai_ret(dai, ret);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index b4cfc34d00ee..eff1355cc3df 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -638,6 +638,33 @@ int snd_soc_get_volsw_range(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw_range);
 
+static int snd_soc_clip_to_platform_max(struct snd_kcontrol *kctl)
+{
+	struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
+	struct snd_ctl_elem_value uctl;
+	int ret;
+
+	if (!mc->platform_max)
+		return 0;
+
+	ret = kctl->get(kctl, &uctl);
+	if (ret < 0)
+		return ret;
+
+	if (uctl.value.integer.value[0] > mc->platform_max)
+		uctl.value.integer.value[0] = mc->platform_max;
+
+	if (snd_soc_volsw_is_stereo(mc) &&
+	    uctl.value.integer.value[1] > mc->platform_max)
+		uctl.value.integer.value[1] = mc->platform_max;
+
+	ret = kctl->put(kctl, &uctl);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 /**
  * snd_soc_limit_volume - Set new limit to an existing volume control.
  *
@@ -662,7 +689,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
 		if (max <= mc->max - mc->min) {
 			mc->platform_max = max;
-			ret = 0;
+			ret = snd_soc_clip_to_platform_max(kctl);
 		}
 	}
 	return ret;
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 835dc3404367..1e310958f8c0 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -25,6 +25,7 @@
 #include <linux/gpio/consumer.h>
 
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -239,6 +240,7 @@ struct sun4i_codec {
 	struct clk	*clk_module;
 	struct reset_control *rst;
 	struct gpio_desc *gpio_pa;
+	struct gpio_desc *gpio_hp;
 
 	/* ADC_FIFOC register is at different offset on different SoCs */
 	struct regmap_field *reg_adc_fifoc;
@@ -1273,6 +1275,49 @@ static struct snd_soc_dai_driver dummy_cpu_dai = {
 	 },
 };
 
+static struct snd_soc_jack sun4i_headphone_jack;
+
+static struct snd_soc_jack_pin sun4i_headphone_jack_pins[] = {
+	{ .pin = "Headphone", .mask = SND_JACK_HEADPHONE },
+};
+
+static struct snd_soc_jack_gpio sun4i_headphone_jack_gpio = {
+	.name = "hp-det",
+	.report = SND_JACK_HEADPHONE,
+	.debounce_time = 150,
+};
+
+static int sun4i_codec_machine_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_card *card = rtd->card;
+	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	if (scodec->gpio_hp) {
+		ret = snd_soc_card_jack_new_pins(card, "Headphone Jack",
+						 SND_JACK_HEADPHONE,
+						 &sun4i_headphone_jack,
+						 sun4i_headphone_jack_pins,
+						 ARRAY_SIZE(sun4i_headphone_jack_pins));
+		if (ret) {
+			dev_err(rtd->dev,
+				"Headphone jack creation failed: %d\n", ret);
+			return ret;
+		}
+
+		sun4i_headphone_jack_gpio.desc = scodec->gpio_hp;
+		ret = snd_soc_jack_add_gpios(&sun4i_headphone_jack, 1,
+					     &sun4i_headphone_jack_gpio);
+
+		if (ret) {
+			dev_err(rtd->dev, "Headphone GPIO not added: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 							int *num_links)
 {
@@ -1298,6 +1343,7 @@ static struct snd_soc_dai_link *sun4i_codec_create_link(struct device *dev,
 	link->codecs->name	= dev_name(dev);
 	link->platforms->name	= dev_name(dev);
 	link->dai_fmt		= SND_SOC_DAIFMT_I2S;
+	link->init		= sun4i_codec_machine_init;
 
 	*num_links = 1;
 
@@ -1738,6 +1784,13 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	scodec->gpio_hp = devm_gpiod_get_optional(&pdev->dev, "hp-det", GPIOD_IN);
+	if (IS_ERR(scodec->gpio_hp)) {
+		ret = PTR_ERR(scodec->gpio_hp);
+		dev_err_probe(&pdev->dev, ret, "Failed to get hp-det gpio\n");
+		return ret;
+	}
+
 	/* reg_field setup */
 	scodec->reg_adc_fifoc = devm_regmap_field_alloc(&pdev->dev,
 							scodec->regmap,
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index db02b000fbeb..eea00bc15b5c 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -384,10 +384,11 @@ int get_fd_type(int fd)
 		p_err("can't read link type: %s", strerror(errno));
 		return -1;
 	}
-	if (n == sizeof(path)) {
+	if (n == sizeof(buf)) {
 		p_err("can't read link type: path too long!");
 		return -1;
 	}
+	buf[n] = '\0';
 
 	if (strstr(buf, "bpf-map"))
 		return BPF_OBJ_MAP;
diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 715092fc6a23..6a043b729b36 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -130,6 +130,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
 obj-y        := $(addprefix $(objprefix),$(obj-y))
 subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
 
+# Separate out test log files from real build objects.
+test-y       := $(filter %_log, $(obj-y))
+obj-y        := $(filter-out %_log, $(obj-y))
+
 # Final '$(obj)-in.o' object
 in-target := $(objprefix)$(obj)-in.o
 
@@ -140,7 +144,7 @@ $(subdir-y):
 
 $(sort $(subdir-obj-y)): $(subdir-y) ;
 
-$(in-target): $(obj-y) FORCE
+$(in-target): $(obj-y) $(test-y) FORCE
 	$(call rule_mkdir)
 	$(call if_changed,$(host)ld_multi)
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a0fb50718dae..98d5e566e058 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1751,7 +1751,7 @@ static int set_kcfg_value_str(struct extern_desc *ext, char *ext_val,
 	}
 
 	len = strlen(value);
-	if (value[len - 1] != '"') {
+	if (len < 2 || value[len - 1] != '"') {
 		pr_warn("extern (kcfg) '%s': invalid string config '%s'\n",
 			ext->name, value);
 		return -EINVAL;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 828c91aaf55b..bf75628c5389 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3083,7 +3083,7 @@ static int handle_insn_ops(struct instruction *insn,
 		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
-		if (!insn->alt_group)
+		if (!opts.uaccess || !insn->alt_group)
 			continue;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -3535,6 +3535,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 0;
 
 		case INSN_STAC:
+			if (!opts.uaccess)
+				break;
+
 			if (state.uaccess) {
 				WARN_FUNC("recursive UACCESS enable", sec, insn->offset);
 				return 1;
@@ -3544,6 +3547,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_CLAC:
+			if (!opts.uaccess)
+				break;
+
 			if (!state.uaccess && func) {
 				WARN_FUNC("redundant UACCESS disable", sec, insn->offset);
 				return 1;
@@ -3956,7 +3962,8 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	if (!insn || insn->ignore || insn->visited)
 		return 0;
 
-	state->uaccess = sym->uaccess_safe;
+	if (opts.uaccess)
+		state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn->func, insn, *state);
 	if (ret && opts.backtrace)
diff --git a/tools/testing/kunit/qemu_configs/x86_64.py b/tools/testing/kunit/qemu_configs/x86_64.py
index dc7949076863..4a6bf4e048f5 100644
--- a/tools/testing/kunit/qemu_configs/x86_64.py
+++ b/tools/testing/kunit/qemu_configs/x86_64.py
@@ -7,4 +7,6 @@ CONFIG_SERIAL_8250_CONSOLE=y''',
 			   qemu_arch='x86_64',
 			   kernel_path='arch/x86/boot/bzImage',
 			   kernel_command_line='console=ttyS0',
-			   extra_qemu_params=[])
+			   # qboot is faster than SeaBIOS and doesn't mess up
+			   # the terminal.
+			   extra_qemu_params=['-bios', 'qboot.rom'])
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 2d0796314862..0a99fd404f6d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -68,7 +68,6 @@ static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 		goto close_cli;
 
 	err = disconnect(cli);
-	ASSERT_OK(err, "disconnect");
 
 close_cli:
 	close(cli);
diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 342ad27f631b..e771f5f7faa2 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -95,5 +95,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;

