Return-Path: <stable+bounces-183057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5871BB40DB
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 15:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EE77A1905
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 13:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D503148AD;
	Thu,  2 Oct 2025 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nLko4Ywa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736823148AA;
	Thu,  2 Oct 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411860; cv=none; b=dCCQD/O+3gZGHF5e2+/KomMwFTz1KRU3QL/k18jpt5kxW/mrf1coDTTiIpUs0birBodOKobF8GZEpl9Cl7j5AlZFXP6liO1sXbz6XagD7S1yTy+IS+howLHXTkKZ5DrHgTO8gD/+zEZlX0jv9nI8ahJrdPFhQJGBKfxuhgoy6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411860; c=relaxed/simple;
	bh=DalqH+duR8i38tNKy4ZiMLWAZxhppYmHnhhCOG9tI/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H82hNQCHQ9M7lhdsdF2vqJXwOzTBc07x+Z3RAnJXQrYmxz0JxUorAcv1hKVYxiXJ+R18jRhdQP1k2RrT+NJaya+59eo38CjMB8zonU8PiVcSFvpdCRds+4y03Sznxc5oKKkwDXfV9TuUItYcmemfkGib++I+QLGCuGNEC80VGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nLko4Ywa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0508EC4CEF4;
	Thu,  2 Oct 2025 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759411860;
	bh=DalqH+duR8i38tNKy4ZiMLWAZxhppYmHnhhCOG9tI/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLko4YwaDY42TWrCDwlX5OgXn4XHYfyogaaSoLNRzi9T+I3npL36Wu+OUTdLALHBB
	 0cMHAW0OROtSXyWnrRUy7NdY0uhjFzJk08+GAyCeAvFAm+X7x2kJNlQ0NWN+TMWB/a
	 iOVpC4fSRjRuCQvcIq6g9TMWUx/10qz6TUDIzaIE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.16.10
Date: Thu,  2 Oct 2025 15:30:45 +0200
Message-ID: <2025100245-shifty-expel-c101@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025100245-skintight-elastic-1e30@gregkh>
References: <2025100245-skintight-elastic-1e30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/laptops/lg-laptop.rst b/Documentation/admin-guide/laptops/lg-laptop.rst
index 67fd6932cef4..c4dd534f91ed 100644
--- a/Documentation/admin-guide/laptops/lg-laptop.rst
+++ b/Documentation/admin-guide/laptops/lg-laptop.rst
@@ -48,8 +48,8 @@ This value is reset to 100 when the kernel boots.
 Fan mode
 --------
 
-Writing 1/0 to /sys/devices/platform/lg-laptop/fan_mode disables/enables
-the fan silent mode.
+Writing 0/1/2 to /sys/devices/platform/lg-laptop/fan_mode sets fan mode to
+Optimal/Silent/Performance respectively.
 
 
 USB charge
diff --git a/Makefile b/Makefile
index aef2cb6ea99d..19856af4819a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 16
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
index ce0d6514eeb5..e4794ccb8e41 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
@@ -66,8 +66,10 @@ &gmac1 {
 	mdio0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		phy0: ethernet-phy@0 {
-			reg = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		phy0: ethernet-phy@4 {
+			reg = <4>;
 			rxd0-skew-ps = <0>;
 			rxd1-skew-ps = <0>;
 			rxd2-skew-ps = <0>;
diff --git a/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts b/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
index d4e0b8150a84..cf26e2ceaaa0 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
@@ -38,7 +38,7 @@ sound {
 		simple-audio-card,mclk-fs = <256>;
 
 		simple-audio-card,cpu {
-			sound-dai = <&audio0 0>;
+			sound-dai = <&audio0>;
 		};
 
 		simple-audio-card,codec {
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 948b88cf5e9d..305c2912e90f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -298,7 +298,7 @@ thermal-zones {
 		cpu-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 0>;
+			thermal-sensors = <&tmu 1>;
 			trips {
 				cpu_alert0: trip0 {
 					temperature = <85000>;
@@ -328,7 +328,7 @@ map0 {
 		soc-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <2000>;
-			thermal-sensors = <&tmu 1>;
+			thermal-sensors = <&tmu 0>;
 			trips {
 				soc_alert0: trip0 {
 					temperature = <85000>;
diff --git a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
index ad0ab34b6602..bd42bfbe408b 100644
--- a/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130-cf.dtsi
@@ -152,11 +152,12 @@ expander0_pins: cp0-expander0-pins {
 
 /* SRDS #0 - SATA on M.2 connector */
 &cp0_sata0 {
-	phys = <&cp0_comphy0 1>;
 	status = "okay";
 
-	/* only port 1 is available */
-	/delete-node/ sata-port@0;
+	sata-port@1 {
+		phys = <&cp0_comphy0 1>;
+		status = "okay";
+	};
 };
 
 /* microSD */
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
index 47234d0858dd..338853d3b179 100644
--- a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -563,11 +563,13 @@ &cp1_rtc {
 
 /* SRDS #1 - SATA on M.2 (J44) */
 &cp1_sata0 {
-	phys = <&cp1_comphy1 0>;
 	status = "okay";
 
 	/* only port 0 is available */
-	/delete-node/ sata-port@1;
+	sata-port@0 {
+		phys = <&cp1_comphy1 0>;
+		status = "okay";
+	};
 };
 
 &cp1_syscon0 {
diff --git a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
index 0f53745a6fa0..6f237d3542b9 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
+++ b/arch/arm64/boot/dts/marvell/cn9132-clearfog.dts
@@ -413,7 +413,13 @@ fixed-link {
 /* SRDS #0,#1,#2,#3 - PCIe */
 &cp0_pcie0 {
 	num-lanes = <4>;
-	phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
+	/*
+	 * The mvebu-comphy driver does not currently know how to pass correct
+	 * lane-count to ATF while configuring the serdes lanes.
+	 * Rely on bootloader configuration only.
+	 *
+	 * phys = <&cp0_comphy0 0>, <&cp0_comphy1 0>, <&cp0_comphy2 0>, <&cp0_comphy3 0>;
+	 */
 	status = "okay";
 };
 
@@ -475,7 +481,13 @@ &cp1_eth0 {
 /* SRDS #0,#1 - PCIe */
 &cp1_pcie0 {
 	num-lanes = <2>;
-	phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
+	/*
+	 * The mvebu-comphy driver does not currently know how to pass correct
+	 * lane-count to ATF while configuring the serdes lanes.
+	 * Rely on bootloader configuration only.
+	 *
+	 * phys = <&cp1_comphy0 0>, <&cp1_comphy1 0>;
+	 */
 	status = "okay";
 };
 
@@ -512,10 +524,9 @@ &cp1_sata0 {
 	status = "okay";
 
 	/* only port 1 is available */
-	/delete-node/ sata-port@0;
-
 	sata-port@1 {
 		phys = <&cp1_comphy3 1>;
+		status = "okay";
 	};
 };
 
@@ -631,9 +642,8 @@ &cp2_sata0 {
 	status = "okay";
 
 	/* only port 1 is available */
-	/delete-node/ sata-port@0;
-
 	sata-port@1 {
+		status = "okay";
 		phys = <&cp2_comphy3 1>;
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
index afc041c1c448..bb2bb47fd77c 100644
--- a/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9132-sr-cex7.dtsi
@@ -137,6 +137,14 @@ &ap_sdhci0 {
 	pinctrl-0 = <&ap_mmc0_pins>;
 	pinctrl-names = "default";
 	vqmmc-supply = <&v_1_8>;
+	/*
+	 * Not stable in HS modes - phy needs "more calibration", so disable
+	 * UHS (by preventing voltage switch), SDR104, SDR50 and DDR50 modes.
+	 */
+	no-1-8-v;
+	no-sd;
+	no-sdio;
+	non-removable;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
index 4fedc50cce8c..11940c77f2bd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
@@ -42,9 +42,8 @@ analog-sound {
 		simple-audio-card,bitclock-master = <&masterdai>;
 		simple-audio-card,format = "i2s";
 		simple-audio-card,frame-master = <&masterdai>;
-		simple-audio-card,hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_LOW>;
+		simple-audio-card,hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
 		simple-audio-card,mclk-fs = <256>;
-		simple-audio-card,pin-switches = "Headphones";
 		simple-audio-card,routing =
 			"Headphones", "LOUT1",
 			"Headphones", "ROUT1",
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5bd5aae60d53..4d9fe4ea78af 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -964,6 +964,23 @@ static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
 }
 
+#define __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
+static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
+					    unsigned long address,  pud_t *pudp)
+{
+#ifdef CONFIG_SMP
+	pud_t pud = __pud(xchg(&pudp->pud, 0));
+#else
+	pud_t pud = *pudp;
+
+	pud_clear(pudp);
+#endif
+
+	page_table_check_pud_clear(mm, pud);
+
+	return pud;
+}
+
 static inline int pud_young(pud_t pud)
 {
 	return pte_young(pud_pte(pud));
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 874c9b264d6f..a530806ec5b0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,7 +26,6 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
-	select ARCH_HAS_PTDUMP
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_SUPPORTS_PER_VMA_LOCK
@@ -101,6 +100,7 @@ config X86
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PREEMPT_LAZY
+	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_HW_PTE_YOUNG
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 6c79ee7c0957..21041898157a 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -231,6 +231,16 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 }
 #define topology_is_primary_thread topology_is_primary_thread
 
+int topology_get_primary_thread(unsigned int cpu);
+
+static inline bool topology_is_core_online(unsigned int cpu)
+{
+	int pcpu = topology_get_primary_thread(cpu);
+
+	return pcpu >= 0 ? cpu_online(pcpu) : false;
+}
+#define topology_is_core_online topology_is_core_online
+
 #else /* CONFIG_SMP */
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index e35ccdc84910..6073a16628f9 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -372,6 +372,19 @@ unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_uni
 	return topo_unit_count(lvlid, at_level, apic_maps[which_units].map);
 }
 
+#ifdef CONFIG_SMP
+int topology_get_primary_thread(unsigned int cpu)
+{
+	u32 apic_id = cpuid_to_apicid[cpu];
+
+	/*
+	 * Get the core domain level APIC id, which is the primary thread
+	 * and return the CPU number assigned to it.
+	 */
+	return topo_lookup_cpuid(topo_apicid(apic_id, TOPO_CORE_DOMAIN));
+}
+#endif
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /**
  * topology_hotplug_apic - Handle a physical hotplugged APIC after boot
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 628f5b633b61..b2da1cda4ceb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2956,6 +2956,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 			goto err_null_driver;
 	}
 
+	/*
+	 * Mark support for the scheduler's frequency invariance engine for
+	 * drivers that implement target(), target_index() or fast_switch().
+	 */
+	if (!cpufreq_driver->setpolicy) {
+		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
+		pr_debug("cpufreq: supports frequency invariance\n");
+	}
+
 	ret = subsys_interface_register(&cpufreq_interface);
 	if (ret)
 		goto err_boost_unreg;
@@ -2977,21 +2986,14 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	hp_online = ret;
 	ret = 0;
 
-	/*
-	 * Mark support for the scheduler's frequency invariance engine for
-	 * drivers that implement target(), target_index() or fast_switch().
-	 */
-	if (!cpufreq_driver->setpolicy) {
-		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
-		pr_debug("supports frequency invariance");
-	}
-
 	pr_debug("driver %s up and running\n", driver_data->name);
 	goto out;
 
 err_if_unreg:
 	subsys_interface_unregister(&cpufreq_interface);
 err_boost_unreg:
+	if (!cpufreq_driver->setpolicy)
+		static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
 	remove_boost_sysfs_file();
 err_null_driver:
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index bd04980009a4..6a81c3fd4c86 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -41,7 +41,7 @@
 /*
  * ABI version history is documented in linux/firewire-cdev.h.
  */
-#define FW_CDEV_KERNEL_VERSION			5
+#define FW_CDEV_KERNEL_VERSION			6
 #define FW_CDEV_VERSION_EVENT_REQUEST2		4
 #define FW_CDEV_VERSION_ALLOCATE_REGION_END	4
 #define FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW	5
diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 87c4225784cf..b3b84a404485 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -274,7 +274,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (!chip->ngpio) {
 		ret = gpiochip_get_ngpios(chip, chip->parent);
 		if (ret)
-			return ERR_PTR(ret);
+			goto err_free_gpio;
 	}
 
 	/* if not set, assume there is only one register */
diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index c13545dce349..bfb04e67c4bc 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -344,6 +344,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 5.35
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/4482
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt PX13"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "ASCP1A00:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3a3eca5b4c40..01d611d7ee66 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4605,6 +4605,23 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	return desc;
 }
 
+static struct gpio_desc *gpiod_fwnode_lookup(struct fwnode_handle *fwnode,
+					     struct device *consumer,
+					     const char *con_id,
+					     unsigned int idx,
+					     enum gpiod_flags *flags,
+					     unsigned long *lookupflags)
+{
+	struct gpio_desc *desc;
+
+	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
+	if (gpiod_not_found(desc) && !IS_ERR_OR_NULL(fwnode))
+		desc = gpiod_find_by_fwnode(fwnode->secondary, consumer, con_id,
+					    idx, flags, lookupflags);
+
+	return desc;
+}
+
 struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 					 struct fwnode_handle *fwnode,
 					 const char *con_id,
@@ -4623,8 +4640,8 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	int ret = 0;
 
 	scoped_guard(srcu, &gpio_devices_srcu) {
-		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
-					    &flags, &lookupflags);
+		desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx,
+					   &flags, &lookupflags);
 		if (gpiod_not_found(desc) && platform_lookup_allowed) {
 			/*
 			 * Either we are not using DT or ACPI, or their lookup
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 260165bbe373..b16cce7c22c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -213,19 +213,35 @@ int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 
 	if (kfd_mem_limit.system_mem_used + system_mem_needed >
-	    kfd_mem_limit.max_system_mem_limit)
+	    kfd_mem_limit.max_system_mem_limit) {
 		pr_debug("Set no_system_mem_limit=1 if using shared memory\n");
+		if (!no_system_mem_limit) {
+			ret = -ENOMEM;
+			goto release;
+		}
+	}
 
-	if ((kfd_mem_limit.system_mem_used + system_mem_needed >
-	     kfd_mem_limit.max_system_mem_limit && !no_system_mem_limit) ||
-	    (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
-	     kfd_mem_limit.max_ttm_mem_limit) ||
-	    (adev && xcp_id >= 0 && adev->kfd.vram_used[xcp_id] + vram_needed >
-	     vram_size - reserved_for_pt - reserved_for_ras - atomic64_read(&adev->vram_pin_size))) {
+	if (kfd_mem_limit.ttm_mem_used + ttm_mem_needed >
+		kfd_mem_limit.max_ttm_mem_limit) {
 		ret = -ENOMEM;
 		goto release;
 	}
 
+	/*if is_app_apu is false and apu_prefer_gtt is true, it is an APU with
+	 * carve out < gtt. In that case, VRAM allocation will go to gtt domain, skip
+	 * VRAM check since ttm_mem_limit check already cover this allocation
+	 */
+
+	if (adev && xcp_id >= 0 && (!adev->apu_prefer_gtt || adev->gmc.is_app_apu)) {
+		uint64_t vram_available =
+			vram_size - reserved_for_pt - reserved_for_ras -
+			atomic64_read(&adev->vram_pin_size);
+		if (adev->kfd.vram_used[xcp_id] + vram_needed > vram_available) {
+			ret = -ENOMEM;
+			goto release;
+		}
+	}
+
 	/* Update memory accounting by decreasing available system
 	 * memory, TTM memory and GPU memory as computed above
 	 */
@@ -1626,11 +1642,15 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 	uint64_t vram_available, system_mem_available, ttm_mem_available;
 
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
-	vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
-		- adev->kfd.vram_used_aligned[xcp_id]
-		- atomic64_read(&adev->vram_pin_size)
-		- reserved_for_pt
-		- reserved_for_ras;
+	if (adev->apu_prefer_gtt && !adev->gmc.is_app_apu)
+		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
+			- adev->kfd.vram_used_aligned[xcp_id];
+	else
+		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
+			- adev->kfd.vram_used_aligned[xcp_id]
+			- atomic64_read(&adev->vram_pin_size)
+			- reserved_for_pt
+			- reserved_for_ras;
 
 	if (adev->apu_prefer_gtt) {
 		system_mem_available = no_system_mem_limit ?
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 4ec73f33535e..720b20e842ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1587,7 +1587,8 @@ static int kfd_dev_create_p2p_links(void)
 			break;
 		if (!dev->gpu || !dev->gpu->adev ||
 		    (dev->gpu->kfd->hive_id &&
-		     dev->gpu->kfd->hive_id == new_dev->gpu->kfd->hive_id))
+		     dev->gpu->kfd->hive_id == new_dev->gpu->kfd->hive_id &&
+		     amdgpu_xgmi_get_is_sharing_enabled(dev->gpu->adev, new_dev->gpu->adev)))
 			goto next;
 
 		/* check if node(s) is/are peer accessible in one direction or bi-direction */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 58ea351dd48b..fa24bcae3c5f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2035,6 +2035,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	dc_hardware_init(adev->dm.dc);
 
+	adev->dm.restore_backlight = true;
+
 	adev->dm.hpd_rx_offload_wq = hpd_rx_irq_create_workqueue(adev);
 	if (!adev->dm.hpd_rx_offload_wq) {
 		drm_err(adev_to_drm(adev), "amdgpu: failed to create hpd rx offload workqueue.\n");
@@ -3396,6 +3398,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
 
 		dc_resume(dm->dc);
+		adev->dm.restore_backlight = true;
 
 		amdgpu_dm_irq_resume_early(adev);
 
@@ -9801,7 +9804,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	bool mode_set_reset_required = false;
 	u32 i;
 	struct dc_commit_streams_params params = {dc_state->streams, dc_state->stream_count};
-	bool set_backlight_level = false;
 
 	/* Disable writeback */
 	for_each_old_connector_in_state(state, connector, old_con_state, i) {
@@ -9921,7 +9923,6 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
 			mode_set_reset_required = true;
-			set_backlight_level = true;
 		} else if (modereset_required(new_crtc_state)) {
 			drm_dbg_atomic(dev,
 				       "Atomic commit: RESET. crtc id %d:[%p]\n",
@@ -9978,13 +9979,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 	 * to fix a flicker issue.
 	 * It will cause the dm->actual_brightness is not the current panel brightness
 	 * level. (the dm->brightness is the correct panel level)
-	 * So we set the backlight level with dm->brightness value after set mode
+	 * So we set the backlight level with dm->brightness value after initial
+	 * set mode. Use restore_backlight flag to avoid setting backlight level
+	 * for every subsequent mode set.
 	 */
-	if (set_backlight_level) {
+	if (dm->restore_backlight) {
 		for (i = 0; i < dm->num_of_edps; i++) {
 			if (dm->backlight_dev[i])
 				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
 		}
+		dm->restore_backlight = false;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index d7d92f9911e4..47abef63686e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -610,6 +610,13 @@ struct amdgpu_display_manager {
 	 */
 	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
 
+	/**
+	 * @restore_backlight:
+	 *
+	 * Flag to indicate whether to restore backlight after modeset.
+	 */
+	bool restore_backlight;
+
 	/**
 	 * @aux_hpd_discon_quirk:
 	 *
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7dfbfb18593c..f037f2d83400 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1292,7 +1292,6 @@ union surface_update_flags {
 		uint32_t in_transfer_func_change:1;
 		uint32_t input_csc_change:1;
 		uint32_t coeff_reduction_change:1;
-		uint32_t output_tf_change:1;
 		uint32_t pixel_format_change:1;
 		uint32_t plane_size_change:1;
 		uint32_t gamut_remap_change:1;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 454e362ff096..c0127d8b5b39 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1990,10 +1990,8 @@ static void dcn20_program_pipe(
 	 * updating on slave planes
 	 */
 	if (pipe_ctx->update_flags.bits.enable ||
-		pipe_ctx->update_flags.bits.plane_changed ||
-		pipe_ctx->stream->update_flags.bits.out_tf ||
-		(pipe_ctx->plane_state &&
-			pipe_ctx->plane_state->update_flags.bits.output_tf_change))
+	    pipe_ctx->update_flags.bits.plane_changed ||
+	    pipe_ctx->stream->update_flags.bits.out_tf)
 		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
 
 	/* If the pipe has been enabled or has a different opp, we
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index c4177a9a662f..c68d01f37860 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2289,10 +2289,8 @@ void dcn401_program_pipe(
 	 * updating on slave planes
 	 */
 	if (pipe_ctx->update_flags.bits.enable ||
-		pipe_ctx->update_flags.bits.plane_changed ||
-		pipe_ctx->stream->update_flags.bits.out_tf ||
-		(pipe_ctx->plane_state &&
-			pipe_ctx->plane_state->update_flags.bits.output_tf_change))
+	    pipe_ctx->update_flags.bits.plane_changed ||
+	    pipe_ctx->stream->update_flags.bits.out_tf)
 		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
 
 	/* If the pipe has been enabled or has a different opp, we
diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
index 19c04687b0fe..8e650a02c528 100644
--- a/drivers/gpu/drm/ast/ast_dp.c
+++ b/drivers/gpu/drm/ast/ast_dp.c
@@ -134,7 +134,7 @@ static int ast_astdp_read_edid_block(void *data, u8 *buf, unsigned int block, si
 			 * 3. The Delays are often longer a lot when system resume from S3/S4.
 			 */
 			if (j)
-				mdelay(j + 1);
+				msleep(j + 1);
 
 			/* Wait for EDID offset to show up in mirror register */
 			vgacrd7 = ast_get_index_reg(ast, AST_IO_VGACRI, 0xd7);
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi.c b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
index 1cf394369127..c0feca58511d 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi.c
@@ -726,8 +726,8 @@ void oaktrail_hdmi_teardown(struct drm_device *dev)
 
 	if (hdmi_dev) {
 		pdev = hdmi_dev->dev;
-		pci_set_drvdata(pdev, NULL);
 		oaktrail_hdmi_i2c_exit(pdev);
+		pci_set_drvdata(pdev, NULL);
 		iounmap(hdmi_dev->regs);
 		kfree(hdmi_dev);
 		pci_dev_put(pdev);
diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index d58f8fc37326..55b8bfcf364a 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -593,8 +593,9 @@ intel_ddi_transcoder_func_reg_val_get(struct intel_encoder *encoder,
 			enum transcoder master;
 
 			master = crtc_state->mst_master_transcoder;
-			drm_WARN_ON(display->drm,
-				    master == INVALID_TRANSCODER);
+			if (drm_WARN_ON(display->drm,
+					master == INVALID_TRANSCODER))
+				master = TRANSCODER_A;
 			temp |= TRANS_DDI_MST_TRANSPORT_SELECT(master);
 		}
 	} else {
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index f1ec3b02f15a..07cd67baa81b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -789,6 +789,8 @@ static const struct panfrost_compatible amlogic_data = {
 	.vendor_quirk = panfrost_gpu_amlogic_quirk,
 };
 
+static const char * const mediatek_pm_domains[] = { "core0", "core1", "core2",
+						    "core3", "core4" };
 /*
  * The old data with two power supplies for MT8183 is here only to
  * keep retro-compatibility with older devicetrees, as DVFS will
@@ -797,51 +799,53 @@ static const struct panfrost_compatible amlogic_data = {
  * On new devicetrees please use the _b variant with a single and
  * coupled regulators instead.
  */
-static const char * const mediatek_mt8183_supplies[] = { "mali", "sram", NULL };
-static const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
+static const char * const legacy_supplies[] = { "mali", "sram", NULL };
 static const struct panfrost_compatible mediatek_mt8183_data = {
-	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies) - 1,
-	.supply_names = mediatek_mt8183_supplies,
-	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
-	.pm_domain_names = mediatek_mt8183_pm_domains,
+	.num_supplies = ARRAY_SIZE(legacy_supplies) - 1,
+	.supply_names = legacy_supplies,
+	.num_pm_domains = 3,
+	.pm_domain_names = mediatek_pm_domains,
 };
 
-static const char * const mediatek_mt8183_b_supplies[] = { "mali", NULL };
 static const struct panfrost_compatible mediatek_mt8183_b_data = {
-	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
-	.supply_names = mediatek_mt8183_b_supplies,
-	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
-	.pm_domain_names = mediatek_mt8183_pm_domains,
+	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
+	.supply_names = default_supplies,
+	.num_pm_domains = 3,
+	.pm_domain_names = mediatek_pm_domains,
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
 };
 
-static const char * const mediatek_mt8186_pm_domains[] = { "core0", "core1" };
 static const struct panfrost_compatible mediatek_mt8186_data = {
-	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
-	.supply_names = mediatek_mt8183_b_supplies,
-	.num_pm_domains = ARRAY_SIZE(mediatek_mt8186_pm_domains),
-	.pm_domain_names = mediatek_mt8186_pm_domains,
+	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
+	.supply_names = default_supplies,
+	.num_pm_domains = 2,
+	.pm_domain_names = mediatek_pm_domains,
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
 };
 
-/* MT8188 uses the same power domains and power supplies as MT8183 */
 static const struct panfrost_compatible mediatek_mt8188_data = {
-	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
-	.supply_names = mediatek_mt8183_b_supplies,
-	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
-	.pm_domain_names = mediatek_mt8183_pm_domains,
+	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
+	.supply_names = default_supplies,
+	.num_pm_domains = 3,
+	.pm_domain_names = mediatek_pm_domains,
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
 	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
 };
 
-static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
-static const char * const mediatek_mt8192_pm_domains[] = { "core0", "core1", "core2",
-							   "core3", "core4" };
 static const struct panfrost_compatible mediatek_mt8192_data = {
-	.num_supplies = ARRAY_SIZE(mediatek_mt8192_supplies) - 1,
-	.supply_names = mediatek_mt8192_supplies,
-	.num_pm_domains = ARRAY_SIZE(mediatek_mt8192_pm_domains),
-	.pm_domain_names = mediatek_mt8192_pm_domains,
+	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
+	.supply_names = default_supplies,
+	.num_pm_domains = 5,
+	.pm_domain_names = mediatek_pm_domains,
+	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
+	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
+};
+
+static const struct panfrost_compatible mediatek_mt8370_data = {
+	.num_supplies = ARRAY_SIZE(default_supplies) - 1,
+	.supply_names = default_supplies,
+	.num_pm_domains = 2,
+	.pm_domain_names = mediatek_pm_domains,
 	.pm_features = BIT(GPU_PM_CLK_DIS) | BIT(GPU_PM_VREG_OFF),
 	.gpu_quirks = BIT(GPU_QUIRK_FORCE_AARCH64_PGTABLE),
 };
@@ -868,6 +872,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8186-mali", .data = &mediatek_mt8186_data },
 	{ .compatible = "mediatek,mt8188-mali", .data = &mediatek_mt8188_data },
 	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
+	{ .compatible = "mediatek,mt8370-mali", .data = &mediatek_mt8370_data },
 	{ .compatible = "allwinner,sun50i-h616-mali", .data = &allwinner_h616_data },
 	{}
 };
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 43ee57728de5..e927d80d6a2a 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -886,8 +886,7 @@ static void group_free_queue(struct panthor_group *group, struct panthor_queue *
 	if (IS_ERR_OR_NULL(queue))
 		return;
 
-	if (queue->entity.fence_context)
-		drm_sched_entity_destroy(&queue->entity);
+	drm_sched_entity_destroy(&queue->entity);
 
 	if (queue->scheduler.ops)
 		drm_sched_fini(&queue->scheduler);
@@ -3558,11 +3557,6 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	if (!group)
 		return -EINVAL;
 
-	for (u32 i = 0; i < group->queue_count; i++) {
-		if (group->queues[i])
-			drm_sched_entity_destroy(&group->queues[i]->entity);
-	}
-
 	mutex_lock(&sched->reset.lock);
 	mutex_lock(&sched->lock);
 	group->destroyed = true;
diff --git a/drivers/gpu/drm/xe/abi/guc_actions_abi.h b/drivers/gpu/drm/xe/abi/guc_actions_abi.h
index 4d9896e14649..448afb86e05c 100644
--- a/drivers/gpu/drm/xe/abi/guc_actions_abi.h
+++ b/drivers/gpu/drm/xe/abi/guc_actions_abi.h
@@ -117,7 +117,6 @@ enum xe_guc_action {
 	XE_GUC_ACTION_ENTER_S_STATE = 0x501,
 	XE_GUC_ACTION_EXIT_S_STATE = 0x502,
 	XE_GUC_ACTION_GLOBAL_SCHED_POLICY_CHANGE = 0x506,
-	XE_GUC_ACTION_UPDATE_SCHEDULING_POLICIES_KLV = 0x509,
 	XE_GUC_ACTION_SCHED_CONTEXT = 0x1000,
 	XE_GUC_ACTION_SCHED_CONTEXT_MODE_SET = 0x1001,
 	XE_GUC_ACTION_SCHED_CONTEXT_MODE_DONE = 0x1002,
@@ -143,7 +142,6 @@ enum xe_guc_action {
 	XE_GUC_ACTION_SET_ENG_UTIL_BUFF = 0x550A,
 	XE_GUC_ACTION_SET_DEVICE_ENGINE_ACTIVITY_BUFFER = 0x550C,
 	XE_GUC_ACTION_SET_FUNCTION_ENGINE_ACTIVITY_BUFFER = 0x550D,
-	XE_GUC_ACTION_OPT_IN_FEATURE_KLV = 0x550E,
 	XE_GUC_ACTION_NOTIFY_MEMORY_CAT_ERROR = 0x6000,
 	XE_GUC_ACTION_REPORT_PAGE_FAULT_REQ_DESC = 0x6002,
 	XE_GUC_ACTION_PAGE_FAULT_RES_DESC = 0x6003,
@@ -242,7 +240,4 @@ enum xe_guc_g2g_type {
 #define XE_G2G_DEREGISTER_TILE	REG_GENMASK(15, 12)
 #define XE_G2G_DEREGISTER_TYPE	REG_GENMASK(11, 8)
 
-/* invalid type for XE_GUC_ACTION_NOTIFY_MEMORY_CAT_ERROR */
-#define XE_GUC_CAT_ERR_TYPE_INVALID 0xdeadbeef
-
 #endif
diff --git a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
index 89034bc97ec5..7de8f827281f 100644
--- a/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
+++ b/drivers/gpu/drm/xe/abi/guc_klvs_abi.h
@@ -16,8 +16,6 @@
  *  +===+=======+==============================================================+
  *  | 0 | 31:16 | **KEY** - KLV key identifier                                 |
  *  |   |       |   - `GuC Self Config KLVs`_                                  |
- *  |   |       |   - `GuC Opt In Feature KLVs`_                               |
- *  |   |       |   - `GuC Scheduling Policies KLVs`_                          |
  *  |   |       |   - `GuC VGT Policy KLVs`_                                   |
  *  |   |       |   - `GuC VF Configuration KLVs`_                             |
  *  |   |       |                                                              |
@@ -126,44 +124,6 @@ enum  {
 	GUC_CONTEXT_POLICIES_KLV_NUM_IDS = 5,
 };
 
-/**
- * DOC: GuC Opt In Feature KLVs
- *
- * `GuC KLV`_ keys available for use with OPT_IN_FEATURE_KLV
- *
- *  _`GUC_KLV_OPT_IN_FEATURE_EXT_CAT_ERR_TYPE` : 0x4001
- *      Adds an extra dword to the XE_GUC_ACTION_NOTIFY_MEMORY_CAT_ERROR G2H
- *      containing the type of the CAT error. On HW that does not support
- *      reporting the CAT error type, the extra dword is set to 0xdeadbeef.
- */
-
-#define GUC_KLV_OPT_IN_FEATURE_EXT_CAT_ERR_TYPE_KEY 0x4001
-#define GUC_KLV_OPT_IN_FEATURE_EXT_CAT_ERR_TYPE_LEN 0u
-
-/**
- * DOC: GuC Scheduling Policies KLVs
- *
- * `GuC KLV`_ keys available for use with UPDATE_SCHEDULING_POLICIES_KLV.
- *
- * _`GUC_KLV_SCHEDULING_POLICIES_RENDER_COMPUTE_YIELD` : 0x1001
- *      Some platforms do not allow concurrent execution of RCS and CCS
- *      workloads from different address spaces. By default, the GuC prioritizes
- *      RCS submissions over CCS ones, which can lead to CCS workloads being
- *      significantly (or completely) starved of execution time. This KLV allows
- *      the driver to specify a quantum (in ms) and a ratio (percentage value
- *      between 0 and 100), and the GuC will prioritize the CCS for that
- *      percentage of each quantum. For example, specifying 100ms and 30% will
- *      make the GuC prioritize the CCS for 30ms of every 100ms.
- *      Note that this does not necessarly mean that RCS and CCS engines will
- *      only be active for their percentage of the quantum, as the restriction
- *      only kicks in if both classes are fully busy with non-compatible address
- *      spaces; i.e., if one engine is idle or running the same address space,
- *      a pending job on the other engine will still be submitted to the HW no
- *      matter what the ratio is
- */
-#define GUC_KLV_SCHEDULING_POLICIES_RENDER_COMPUTE_YIELD_KEY	0x1001
-#define GUC_KLV_SCHEDULING_POLICIES_RENDER_COMPUTE_YIELD_LEN	2u
-
 /**
  * DOC: GuC VGT Policy KLVs
  *
diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index ed3746d32b27..4620201c7239 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -158,8 +158,8 @@ int xe_bo_evict_all(struct xe_device *xe)
 	if (ret)
 		return ret;
 
-	ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.kernel_bo_present,
-				    &xe->pinned.late.evicted, xe_bo_evict_pinned);
+	ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.external,
+				    &xe->pinned.late.external, xe_bo_evict_pinned);
 
 	if (!ret)
 		ret = xe_bo_apply_to_pinned(xe, &xe->pinned.late.kernel_bo_present,
diff --git a/drivers/gpu/drm/xe/xe_configfs.c b/drivers/gpu/drm/xe/xe_configfs.c
index 9a2b96b111ef..2b591ed05561 100644
--- a/drivers/gpu/drm/xe/xe_configfs.c
+++ b/drivers/gpu/drm/xe/xe_configfs.c
@@ -244,7 +244,7 @@ int __init xe_configfs_init(void)
 	return 0;
 }
 
-void __exit xe_configfs_exit(void)
+void xe_configfs_exit(void)
 {
 	configfs_unregister_subsystem(&xe_configfs);
 }
diff --git a/drivers/gpu/drm/xe/xe_device_sysfs.c b/drivers/gpu/drm/xe/xe_device_sysfs.c
index b9440f8c781e..652da4d294c0 100644
--- a/drivers/gpu/drm/xe/xe_device_sysfs.c
+++ b/drivers/gpu/drm/xe/xe_device_sysfs.c
@@ -166,7 +166,7 @@ int xe_device_sysfs_init(struct xe_device *xe)
 			return ret;
 	}
 
-	if (xe->info.platform == XE_BATTLEMAGE) {
+	if (xe->info.platform == XE_BATTLEMAGE && !IS_SRIOV_VF(xe)) {
 		ret = sysfs_create_files(&dev->kobj, auto_link_downgrade_attrs);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index eaf7569a7c1d..e3517ce2e18c 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -41,7 +41,6 @@
 #include "xe_gt_topology.h"
 #include "xe_guc_exec_queue_types.h"
 #include "xe_guc_pc.h"
-#include "xe_guc_submit.h"
 #include "xe_hw_fence.h"
 #include "xe_hw_engine_class_sysfs.h"
 #include "xe_irq.h"
@@ -98,7 +97,7 @@ void xe_gt_sanitize(struct xe_gt *gt)
 	 * FIXME: if xe_uc_sanitize is called here, on TGL driver will not
 	 * reload
 	 */
-	xe_guc_submit_disable(&gt->uc.guc);
+	gt->uc.guc.submission_state.enabled = false;
 }
 
 static void xe_gt_enable_host_l2_vram(struct xe_gt *gt)
diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index b9d21fdaad48..bac5471a1a78 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -29,7 +29,6 @@
 #include "xe_guc_db_mgr.h"
 #include "xe_guc_engine_activity.h"
 #include "xe_guc_hwconfig.h"
-#include "xe_guc_klv_helpers.h"
 #include "xe_guc_log.h"
 #include "xe_guc_pc.h"
 #include "xe_guc_relay.h"
@@ -571,57 +570,6 @@ static int guc_g2g_start(struct xe_guc *guc)
 	return err;
 }
 
-static int __guc_opt_in_features_enable(struct xe_guc *guc, u64 addr, u32 num_dwords)
-{
-	u32 action[] = {
-		XE_GUC_ACTION_OPT_IN_FEATURE_KLV,
-		lower_32_bits(addr),
-		upper_32_bits(addr),
-		num_dwords
-	};
-
-	return xe_guc_ct_send_block(&guc->ct, action, ARRAY_SIZE(action));
-}
-
-#define OPT_IN_MAX_DWORDS 16
-int xe_guc_opt_in_features_enable(struct xe_guc *guc)
-{
-	struct xe_device *xe = guc_to_xe(guc);
-	CLASS(xe_guc_buf, buf)(&guc->buf, OPT_IN_MAX_DWORDS);
-	u32 count = 0;
-	u32 *klvs;
-	int ret;
-
-	if (!xe_guc_buf_is_valid(buf))
-		return -ENOBUFS;
-
-	klvs = xe_guc_buf_cpu_ptr(buf);
-
-	/*
-	 * The extra CAT error type opt-in was added in GuC v70.17.0, which maps
-	 * to compatibility version v1.7.0.
-	 * Note that the GuC allows enabling this KLV even on platforms that do
-	 * not support the extra type; in such case the returned type variable
-	 * will be set to a known invalid value which we can check against.
-	 */
-	if (GUC_SUBMIT_VER(guc) >= MAKE_GUC_VER(1, 7, 0))
-		klvs[count++] = PREP_GUC_KLV_TAG(OPT_IN_FEATURE_EXT_CAT_ERR_TYPE);
-
-	if (count) {
-		xe_assert(xe, count <= OPT_IN_MAX_DWORDS);
-
-		ret = __guc_opt_in_features_enable(guc, xe_guc_buf_flush(buf), count);
-		if (ret < 0) {
-			xe_gt_err(guc_to_gt(guc),
-				  "failed to enable GuC opt-in features: %pe\n",
-				  ERR_PTR(ret));
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static void guc_fini_hw(void *arg)
 {
 	struct xe_guc *guc = arg;
@@ -815,17 +763,15 @@ int xe_guc_post_load_init(struct xe_guc *guc)
 
 	xe_guc_ads_populate_post_load(&guc->ads);
 
-	ret = xe_guc_opt_in_features_enable(guc);
-	if (ret)
-		return ret;
-
 	if (xe_guc_g2g_wanted(guc_to_xe(guc))) {
 		ret = guc_g2g_start(guc);
 		if (ret)
 			return ret;
 	}
 
-	return xe_guc_submit_enable(guc);
+	guc->submission_state.enabled = true;
+
+	return 0;
 }
 
 int xe_guc_reset(struct xe_guc *guc)
@@ -1519,7 +1465,7 @@ void xe_guc_sanitize(struct xe_guc *guc)
 {
 	xe_uc_fw_sanitize(&guc->fw);
 	xe_guc_ct_disable(&guc->ct);
-	xe_guc_submit_disable(guc);
+	guc->submission_state.enabled = false;
 }
 
 int xe_guc_reset_prepare(struct xe_guc *guc)
diff --git a/drivers/gpu/drm/xe/xe_guc.h b/drivers/gpu/drm/xe/xe_guc.h
index 4a66575f017d..58338be44558 100644
--- a/drivers/gpu/drm/xe/xe_guc.h
+++ b/drivers/gpu/drm/xe/xe_guc.h
@@ -33,7 +33,6 @@ int xe_guc_reset(struct xe_guc *guc);
 int xe_guc_upload(struct xe_guc *guc);
 int xe_guc_min_load_for_hwconfig(struct xe_guc *guc);
 int xe_guc_enable_communication(struct xe_guc *guc);
-int xe_guc_opt_in_features_enable(struct xe_guc *guc);
 int xe_guc_suspend(struct xe_guc *guc);
 void xe_guc_notify(struct xe_guc *guc);
 int xe_guc_auth_huc(struct xe_guc *guc, u32 rsa_addr);
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 18ddbb7b98a1..45a21af12692 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -32,7 +32,6 @@
 #include "xe_guc_ct.h"
 #include "xe_guc_exec_queue_types.h"
 #include "xe_guc_id_mgr.h"
-#include "xe_guc_klv_helpers.h"
 #include "xe_guc_submit_types.h"
 #include "xe_hw_engine.h"
 #include "xe_hw_fence.h"
@@ -317,71 +316,6 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
 	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
 }
 
-/*
- * Given that we want to guarantee enough RCS throughput to avoid missing
- * frames, we set the yield policy to 20% of each 80ms interval.
- */
-#define RC_YIELD_DURATION	80	/* in ms */
-#define RC_YIELD_RATIO		20	/* in percent */
-static u32 *emit_render_compute_yield_klv(u32 *emit)
-{
-	*emit++ = PREP_GUC_KLV_TAG(SCHEDULING_POLICIES_RENDER_COMPUTE_YIELD);
-	*emit++ = RC_YIELD_DURATION;
-	*emit++ = RC_YIELD_RATIO;
-
-	return emit;
-}
-
-#define SCHEDULING_POLICY_MAX_DWORDS 16
-static int guc_init_global_schedule_policy(struct xe_guc *guc)
-{
-	u32 data[SCHEDULING_POLICY_MAX_DWORDS];
-	u32 *emit = data;
-	u32 count = 0;
-	int ret;
-
-	if (GUC_SUBMIT_VER(guc) < MAKE_GUC_VER(1, 1, 0))
-		return 0;
-
-	*emit++ = XE_GUC_ACTION_UPDATE_SCHEDULING_POLICIES_KLV;
-
-	if (CCS_MASK(guc_to_gt(guc)))
-		emit = emit_render_compute_yield_klv(emit);
-
-	count = emit - data;
-	if (count > 1) {
-		xe_assert(guc_to_xe(guc), count <= SCHEDULING_POLICY_MAX_DWORDS);
-
-		ret = xe_guc_ct_send_block(&guc->ct, data, count);
-		if (ret < 0) {
-			xe_gt_err(guc_to_gt(guc),
-				  "failed to enable GuC sheduling policies: %pe\n",
-				  ERR_PTR(ret));
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-int xe_guc_submit_enable(struct xe_guc *guc)
-{
-	int ret;
-
-	ret = guc_init_global_schedule_policy(guc);
-	if (ret)
-		return ret;
-
-	guc->submission_state.enabled = true;
-
-	return 0;
-}
-
-void xe_guc_submit_disable(struct xe_guc *guc)
-{
-	guc->submission_state.enabled = false;
-}
-
 static void __release_guc_id(struct xe_guc *guc, struct xe_exec_queue *q, u32 xa_count)
 {
 	int i;
@@ -2154,16 +2088,12 @@ int xe_guc_exec_queue_memory_cat_error_handler(struct xe_guc *guc, u32 *msg,
 	struct xe_gt *gt = guc_to_gt(guc);
 	struct xe_exec_queue *q;
 	u32 guc_id;
-	u32 type = XE_GUC_CAT_ERR_TYPE_INVALID;
 
-	if (unlikely(!len || len > 2))
+	if (unlikely(len < 1))
 		return -EPROTO;
 
 	guc_id = msg[0];
 
-	if (len == 2)
-		type = msg[1];
-
 	if (guc_id == GUC_ID_UNKNOWN) {
 		/*
 		 * GuC uses GUC_ID_UNKNOWN if it can not map the CAT fault to any PF/VF
@@ -2177,19 +2107,8 @@ int xe_guc_exec_queue_memory_cat_error_handler(struct xe_guc *guc, u32 *msg,
 	if (unlikely(!q))
 		return -EPROTO;
 
-	/*
-	 * The type is HW-defined and changes based on platform, so we don't
-	 * decode it in the kernel and only check if it is valid.
-	 * See bspec 54047 and 72187 for details.
-	 */
-	if (type != XE_GUC_CAT_ERR_TYPE_INVALID)
-		xe_gt_dbg(gt,
-			  "Engine memory CAT error [%u]: class=%s, logical_mask: 0x%x, guc_id=%d",
-			  type, xe_hw_engine_class_to_str(q->class), q->logical_mask, guc_id);
-	else
-		xe_gt_dbg(gt,
-			  "Engine memory CAT error: class=%s, logical_mask: 0x%x, guc_id=%d",
-			  xe_hw_engine_class_to_str(q->class), q->logical_mask, guc_id);
+	xe_gt_dbg(gt, "Engine memory cat error: engine_class=%s, logical_mask: 0x%x, guc_id=%d",
+		  xe_hw_engine_class_to_str(q->class), q->logical_mask, guc_id);
 
 	trace_xe_exec_queue_memory_cat_error(q);
 
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.h b/drivers/gpu/drm/xe/xe_guc_submit.h
index 0d126b807c10..9b71a986c6ca 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.h
+++ b/drivers/gpu/drm/xe/xe_guc_submit.h
@@ -13,8 +13,6 @@ struct xe_exec_queue;
 struct xe_guc;
 
 int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids);
-int xe_guc_submit_enable(struct xe_guc *guc);
-void xe_guc_submit_disable(struct xe_guc *guc);
 
 int xe_guc_submit_reset_prepare(struct xe_guc *guc);
 void xe_guc_submit_reset_wait(struct xe_guc *guc);
diff --git a/drivers/gpu/drm/xe/xe_uc.c b/drivers/gpu/drm/xe/xe_uc.c
index 5c45b0f072a4..3a8751a8b92d 100644
--- a/drivers/gpu/drm/xe/xe_uc.c
+++ b/drivers/gpu/drm/xe/xe_uc.c
@@ -165,10 +165,6 @@ static int vf_uc_init_hw(struct xe_uc *uc)
 
 	uc->guc.submission_state.enabled = true;
 
-	err = xe_guc_opt_in_features_enable(&uc->guc);
-	if (err)
-		return err;
-
 	err = xe_gt_record_default_lrcs(uc_to_gt(uc));
 	if (err)
 		return err;
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index 3438d392920f..8dae9a776685 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -39,8 +39,12 @@ int amd_sfh_get_report(struct hid_device *hid, int report_id, int report_type)
 	struct amdtp_hid_data *hid_data = hid->driver_data;
 	struct amdtp_cl_data *cli_data = hid_data->cli_data;
 	struct request_list *req_list = &cli_data->req_list;
+	struct amd_input_data *in_data = cli_data->in_data;
+	struct amd_mp2_dev *mp2;
 	int i;
 
+	mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
+	guard(mutex)(&mp2->lock);
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->hid_sensor_hubs[i] == hid) {
 			struct request_list *new = kzalloc(sizeof(*new), GFP_KERNEL);
@@ -75,6 +79,8 @@ void amd_sfh_work(struct work_struct *work)
 	u8 report_id, node_type;
 	u8 report_size = 0;
 
+	mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
+	guard(mutex)(&mp2->lock);
 	req_node = list_last_entry(&req_list->list, struct request_list, list);
 	list_del(&req_node->list);
 	current_index = req_node->current_index;
@@ -83,7 +89,6 @@ void amd_sfh_work(struct work_struct *work)
 	node_type = req_node->report_type;
 	kfree(req_node);
 
-	mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
 	mp2_ops = mp2->mp2_ops;
 	if (node_type == HID_FEATURE_REPORT) {
 		report_size = mp2_ops->get_feat_rep(sensor_index, report_id,
@@ -107,6 +112,8 @@ void amd_sfh_work(struct work_struct *work)
 	cli_data->cur_hid_dev = current_index;
 	cli_data->sensor_requested_cnt[current_index] = 0;
 	amdtp_hid_wakeup(cli_data->hid_sensor_hubs[current_index]);
+	if (!list_empty(&req_list->list))
+		schedule_delayed_work(&cli_data->work, 0);
 }
 
 void amd_sfh_work_buffer(struct work_struct *work)
@@ -117,9 +124,10 @@ void amd_sfh_work_buffer(struct work_struct *work)
 	u8 report_size;
 	int i;
 
+	mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
+	guard(mutex)(&mp2->lock);
 	for (i = 0; i < cli_data->num_hid_devices; i++) {
 		if (cli_data->sensor_sts[i] == SENSOR_ENABLED) {
-			mp2 = container_of(in_data, struct amd_mp2_dev, in_data);
 			report_size = mp2->mp2_ops->get_in_rep(i, cli_data->sensor_idx[i],
 							       cli_data->report_id[i], in_data);
 			hid_input_report(cli_data->hid_sensor_hubs[i], HID_INPUT_REPORT,
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index f44a3bb2fbd4..78f830c133e5 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -10,6 +10,7 @@
 #ifndef AMD_SFH_COMMON_H
 #define AMD_SFH_COMMON_H
 
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include "amd_sfh_hid.h"
 
@@ -59,6 +60,8 @@ struct amd_mp2_dev {
 	u32 mp2_acs;
 	struct sfh_dev_status dev_en;
 	struct work_struct work;
+	/* mp2 to protect data */
+	struct mutex lock;
 	u8 init_done;
 	u8 rver;
 };
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1c1fd63330c9..9a669c18a132 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -462,6 +462,10 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	if (!privdata->cl_data)
 		return -ENOMEM;
 
+	rc = devm_mutex_init(&pdev->dev, &privdata->lock);
+	if (rc)
+		return rc;
+
 	privdata->sfh1_1_ops = (const struct amd_sfh1_1_ops *)id->driver_data;
 	if (privdata->sfh1_1_ops) {
 		if (boot_cpu_data.x86 >= 0x1A)
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d27dcfb2b9e4..8db9d4e7c3b0 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -974,7 +974,10 @@ static int asus_input_mapping(struct hid_device *hdev,
 		case 0xc4: asus_map_key_clear(KEY_KBDILLUMUP);		break;
 		case 0xc5: asus_map_key_clear(KEY_KBDILLUMDOWN);		break;
 		case 0xc7: asus_map_key_clear(KEY_KBDILLUMTOGGLE);	break;
+		case 0x4e: asus_map_key_clear(KEY_FN_ESC);		break;
+		case 0x7e: asus_map_key_clear(KEY_EMOJI_PICKER);	break;
 
+		case 0x8b: asus_map_key_clear(KEY_PROG1);	break; /* ProArt Creator Hub key */
 		case 0x6b: asus_map_key_clear(KEY_F21);		break; /* ASUS touchpad toggle */
 		case 0x38: asus_map_key_clear(KEY_PROG1);	break; /* ROG key */
 		case 0xba: asus_map_key_clear(KEY_PROG2);	break; /* Fn+C ASUS Splendid */
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 234fa82eab07..b5f2b6356f51 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -229,10 +229,12 @@ static int cp2112_gpio_set_unlocked(struct cp2112_device *dev,
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_SET, buf,
 				 CP2112_GPIO_SET_LENGTH, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
-	if (ret < 0)
+	if (ret != CP2112_GPIO_SET_LENGTH) {
 		hid_err(hdev, "error setting GPIO values: %d\n", ret);
+		return ret < 0 ? ret : -EIO;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int cp2112_gpio_set(struct gpio_chip *chip, unsigned int offset,
@@ -309,9 +311,7 @@ static int cp2112_gpio_direction_output(struct gpio_chip *chip,
 	 * Set gpio value when output direction is already set,
 	 * as specified in AN495, Rev. 0.2, cpt. 4.4
 	 */
-	cp2112_gpio_set_unlocked(dev, offset, value);
-
-	return 0;
+	return cp2112_gpio_set_unlocked(dev, offset, value);
 }
 
 static int cp2112_hid_get(struct hid_device *hdev, unsigned char report_number,
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4c22bd2ba170..edb8da49d916 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -73,6 +73,7 @@ MODULE_LICENSE("GPL");
 #define MT_QUIRK_FORCE_MULTI_INPUT	BIT(20)
 #define MT_QUIRK_DISABLE_WAKEUP		BIT(21)
 #define MT_QUIRK_ORIENTATION_INVERT	BIT(22)
+#define MT_QUIRK_APPLE_TOUCHBAR		BIT(23)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -625,6 +626,7 @@ static struct mt_application *mt_find_application(struct mt_device *td,
 static struct mt_report_data *mt_allocate_report_data(struct mt_device *td,
 						      struct hid_report *report)
 {
+	struct mt_class *cls = &td->mtclass;
 	struct mt_report_data *rdata;
 	struct hid_field *field;
 	int r, n;
@@ -649,7 +651,11 @@ static struct mt_report_data *mt_allocate_report_data(struct mt_device *td,
 
 		if (field->logical == HID_DG_FINGER || td->hdev->group != HID_GROUP_MULTITOUCH_WIN_8) {
 			for (n = 0; n < field->report_count; n++) {
-				if (field->usage[n].hid == HID_DG_CONTACTID) {
+				unsigned int hid = field->usage[n].hid;
+
+				if (hid == HID_DG_CONTACTID ||
+				   (cls->quirks & MT_QUIRK_APPLE_TOUCHBAR &&
+				   hid == HID_DG_TRANSDUCER_INDEX)) {
 					rdata->is_mt_collection = true;
 					break;
 				}
@@ -821,12 +827,31 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 
 			MT_STORE_FIELD(confidence_state);
 			return 1;
+		case HID_DG_TOUCH:
+			/*
+			 * Legacy devices use TIPSWITCH and not TOUCH.
+			 * One special case here is of the Apple Touch Bars.
+			 * In these devices, the tip state is contained in
+			 * fields with the HID_DG_TOUCH usage.
+			 * Let's just ignore this field for other devices.
+			 */
+			if (!(cls->quirks & MT_QUIRK_APPLE_TOUCHBAR))
+				return -1;
+			fallthrough;
 		case HID_DG_TIPSWITCH:
 			if (field->application != HID_GD_SYSTEM_MULTIAXIS)
 				input_set_capability(hi->input,
 						     EV_KEY, BTN_TOUCH);
 			MT_STORE_FIELD(tip_state);
 			return 1;
+		case HID_DG_TRANSDUCER_INDEX:
+			/*
+			 * Contact ID in case of Apple Touch Bars is contained
+			 * in fields with HID_DG_TRANSDUCER_INDEX usage.
+			 */
+			if (!(cls->quirks & MT_QUIRK_APPLE_TOUCHBAR))
+				return 0;
+			fallthrough;
 		case HID_DG_CONTACTID:
 			MT_STORE_FIELD(contactid);
 			app->touches_by_report++;
@@ -883,10 +908,6 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		case HID_DG_CONTACTMAX:
 			/* contact max are global to the report */
 			return -1;
-		case HID_DG_TOUCH:
-			/* Legacy devices use TIPSWITCH and not TOUCH.
-			 * Let's just ignore this field. */
-			return -1;
 		}
 		/* let hid-input decide for the others */
 		return 0;
@@ -1314,6 +1335,13 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	struct input_dev *input = hi->input;
 	int ret;
 
+	/*
+	 * HID_DG_CONTACTMAX field is not present on Apple Touch Bars,
+	 * but the maximum contact count is greater than the default.
+	 */
+	if (cls->quirks & MT_QUIRK_APPLE_TOUCHBAR && cls->maxcontacts)
+		td->maxcontacts = cls->maxcontacts;
+
 	if (!td->maxcontacts)
 		td->maxcontacts = MT_DEFAULT_MAXCONTACT;
 
@@ -1321,6 +1349,13 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (td->serial_maybe)
 		mt_post_parse_default_settings(td, app);
 
+	/*
+	 * The application for Apple Touch Bars is HID_DG_TOUCHPAD,
+	 * but these devices are direct.
+	 */
+	if (cls->quirks & MT_QUIRK_APPLE_TOUCHBAR)
+		app->mt_flags |= INPUT_MT_DIRECT;
+
 	if (cls->is_indirect)
 		app->mt_flags |= INPUT_MT_POINTER;
 
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index d4f89f44c3b4..715480ef30ce 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -961,6 +961,8 @@ static const struct pci_device_id quickspi_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, THC_PTL_H_DEVICE_ID_SPI_PORT2, &ptl), },
 	{PCI_DEVICE_DATA(INTEL, THC_PTL_U_DEVICE_ID_SPI_PORT1, &ptl), },
 	{PCI_DEVICE_DATA(INTEL, THC_PTL_U_DEVICE_ID_SPI_PORT2, &ptl), },
+	{PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_SPI_PORT1, &ptl), },
+	{PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_SPI_PORT2, &ptl), },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, quickspi_pci_tbl);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index 6fdf674b21c5..f3532d866749 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -19,6 +19,8 @@
 #define PCI_DEVICE_ID_INTEL_THC_PTL_H_DEVICE_ID_SPI_PORT2	0xE34B
 #define PCI_DEVICE_ID_INTEL_THC_PTL_U_DEVICE_ID_SPI_PORT1	0xE449
 #define PCI_DEVICE_ID_INTEL_THC_PTL_U_DEVICE_ID_SPI_PORT2	0xE44B
+#define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT1 	0x4D49
+#define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT2 	0x4D4B
 
 /* HIDSPI special ACPI parameters DSM methods */
 #define ACPI_QUICKSPI_REVISION_NUM			2
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 879719e91df2..c1262df02cdb 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -101,7 +101,7 @@ static int bt1_i2c_request_regs(struct dw_i2c_dev *dev)
 }
 #endif
 
-static int txgbe_i2c_request_regs(struct dw_i2c_dev *dev)
+static int dw_i2c_get_parent_regmap(struct dw_i2c_dev *dev)
 {
 	dev->map = dev_get_regmap(dev->dev->parent, NULL);
 	if (!dev->map)
@@ -123,12 +123,15 @@ static int dw_i2c_plat_request_regs(struct dw_i2c_dev *dev)
 	struct platform_device *pdev = to_platform_device(dev->dev);
 	int ret;
 
+	if (device_is_compatible(dev->dev, "intel,xe-i2c"))
+		return dw_i2c_get_parent_regmap(dev);
+
 	switch (dev->flags & MODEL_MASK) {
 	case MODEL_BAIKAL_BT1:
 		ret = bt1_i2c_request_regs(dev);
 		break;
 	case MODEL_WANGXUN_SP:
-		ret = txgbe_i2c_request_regs(dev);
+		ret = dw_i2c_get_parent_regmap(dev);
 		break;
 	default:
 		dev->base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index c369fee33562..00727472c873 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -233,6 +233,7 @@ static u16 get_legacy_obj_type(u16 opcode)
 {
 	switch (opcode) {
 	case MLX5_CMD_OP_CREATE_RQ:
+	case MLX5_CMD_OP_CREATE_RMP:
 		return MLX5_EVENT_QUEUE_TYPE_RQ;
 	case MLX5_CMD_OP_CREATE_QP:
 		return MLX5_EVENT_QUEUE_TYPE_QP;
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index e373b9eec7f5..2afef30ce41f 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -393,12 +393,12 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 			       const struct file_operations *fops)
 {
 	struct file *filep;
-	int fdno;
 
 	spin_lock_init(&eventq->lock);
 	INIT_LIST_HEAD(&eventq->deliver);
 	init_waitqueue_head(&eventq->wait_queue);
 
+	/* The filep is fput() by the core code during failure */
 	filep = anon_inode_getfile(name, fops, eventq, O_RDWR);
 	if (IS_ERR(filep))
 		return PTR_ERR(filep);
@@ -408,10 +408,7 @@ static int iommufd_eventq_init(struct iommufd_eventq *eventq, char *name,
 	eventq->filep = filep;
 	refcount_inc(&eventq->obj.users);
 
-	fdno = get_unused_fd_flags(O_CLOEXEC);
-	if (fdno < 0)
-		fput(filep);
-	return fdno;
+	return get_unused_fd_flags(O_CLOEXEC);
 }
 
 static const struct file_operations iommufd_fault_fops =
@@ -455,7 +452,6 @@ int iommufd_fault_alloc(struct iommufd_ucmd *ucmd)
 	return 0;
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(fault->common.filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &fault->common.obj);
 
@@ -542,7 +538,6 @@ int iommufd_veventq_alloc(struct iommufd_ucmd *ucmd)
 
 out_put_fdno:
 	put_unused_fd(fdno);
-	fput(veventq->common.filep);
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &veventq->common.obj);
 out_unlock_veventqs:
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..62a3469bbd37 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -23,6 +23,7 @@
 #include "iommufd_test.h"
 
 struct iommufd_object_ops {
+	size_t file_offset;
 	void (*destroy)(struct iommufd_object *obj);
 	void (*abort)(struct iommufd_object *obj);
 };
@@ -71,10 +72,30 @@ void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
 void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj)
 {
-	if (iommufd_object_ops[obj->type].abort)
-		iommufd_object_ops[obj->type].abort(obj);
+	const struct iommufd_object_ops *ops = &iommufd_object_ops[obj->type];
+
+	if (ops->file_offset) {
+		struct file **filep = ((void *)obj) + ops->file_offset;
+
+		/*
+		 * A file should hold a users refcount while the file is open
+		 * and put it back in its release. The file should hold a
+		 * pointer to obj in their private data. Normal fput() is
+		 * deferred to a workqueue and can get out of order with the
+		 * following kfree(obj). Using the sync version ensures the
+		 * release happens immediately. During abort we require the file
+		 * refcount is one at this point - meaning the object alloc
+		 * function cannot do anything to allow another thread to take a
+		 * refcount prior to a guaranteed success.
+		 */
+		if (*filep)
+			__fput_sync(*filep);
+	}
+
+	if (ops->abort)
+		ops->abort(obj);
 	else
-		iommufd_object_ops[obj->type].destroy(obj);
+		ops->destroy(obj);
 	iommufd_object_abort(ictx, obj);
 }
 
@@ -493,6 +514,12 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, "IOMMUFD");
 
+#define IOMMUFD_FILE_OFFSET(_struct, _filep, _obj)                           \
+	.file_offset = (offsetof(_struct, _filep) +                          \
+			BUILD_BUG_ON_ZERO(!__same_type(                      \
+				struct file *, ((_struct *)NULL)->_filep)) + \
+			BUILD_BUG_ON_ZERO(offsetof(_struct, _obj)))
+
 static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_ACCESS] = {
 		.destroy = iommufd_access_destroy_object,
@@ -502,6 +529,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_FAULT] = {
 		.destroy = iommufd_fault_destroy,
+		IOMMUFD_FILE_OFFSET(struct iommufd_fault, common.filep, common.obj),
 	},
 	[IOMMUFD_OBJ_HWPT_PAGING] = {
 		.destroy = iommufd_hwpt_paging_destroy,
@@ -520,6 +548,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	[IOMMUFD_OBJ_VEVENTQ] = {
 		.destroy = iommufd_veventq_destroy,
 		.abort = iommufd_veventq_abort,
+		IOMMUFD_FILE_OFFSET(struct iommufd_veventq, common.filep, common.obj),
 	},
 	[IOMMUFD_OBJ_VIOMMU] = {
 		.destroy = iommufd_viommu_destroy,
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index a94b297fcf2a..60ca09780da3 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -433,6 +433,13 @@ static const struct sdhci_cdns_drv_data sdhci_elba_drv_data = {
 	},
 };
 
+static const struct sdhci_cdns_drv_data sdhci_eyeq_drv_data = {
+	.pltfm_data = {
+		.ops = &sdhci_cdns_ops,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+};
+
 static const struct sdhci_cdns_drv_data sdhci_cdns_drv_data = {
 	.pltfm_data = {
 		.ops = &sdhci_cdns_ops,
@@ -595,6 +602,10 @@ static const struct of_device_id sdhci_cdns_match[] = {
 		.compatible = "amd,pensando-elba-sd4hc",
 		.data = &sdhci_elba_drv_data,
 	},
+	{
+		.compatible = "mobileye,eyeq-sd4hc",
+		.data = &sdhci_eyeq_drv_data,
+	},
 	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 2b7dd359f27b..8569178b66df 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -861,7 +861,6 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct rcar_can_priv *priv = netdev_priv(ndev);
-	u16 ctlr;
 	int err;
 
 	if (!netif_running(ndev))
@@ -873,12 +872,7 @@ static int __maybe_unused rcar_can_resume(struct device *dev)
 		return err;
 	}
 
-	ctlr = readw(&priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_SLPM;
-	writew(ctlr, &priv->regs->ctlr);
-	ctlr &= ~RCAR_CAN_CTLR_CANM;
-	writew(ctlr, &priv->regs->ctlr);
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
+	rcar_can_start(ndev);
 
 	netif_device_attach(ndev);
 	netif_start_queue(ndev);
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 09ae218315d7..6441ff3b4198 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -812,6 +812,7 @@ static const struct net_device_ops hi3110_netdev_ops = {
 	.ndo_open = hi3110_open,
 	.ndo_stop = hi3110_stop,
 	.ndo_start_xmit = hi3110_hard_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops hi3110_ethtool_ops = {
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 6fcb301ef611..53bfd873de9b 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -768,6 +768,7 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_open = sun4ican_open,
 	.ndo_stop = sun4ican_close,
 	.ndo_start_xmit = sun4ican_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops sun4ican_ethtool_ops = {
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index db1acf6d504c..adc91873c083 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/unaligned.h>
@@ -1977,6 +1977,7 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_stop = es58x_stop,
 	.ndo_start_xmit = es58x_start_xmit,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops es58x_ethtool_ops = {
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 41c0a1c399bf..1f9b915094e6 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -761,6 +761,7 @@ static const struct net_device_ops mcba_netdev_ops = {
 	.ndo_open = mcba_usb_open,
 	.ndo_stop = mcba_usb_close,
 	.ndo_start_xmit = mcba_usb_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops mcba_ethtool_ops = {
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 117637b9b995..dd5caa1c302b 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -111,7 +111,7 @@ void peak_usb_update_ts_now(struct peak_time_ref *time_ref, u32 ts_now)
 		u32 delta_ts = time_ref->ts_dev_2 - time_ref->ts_dev_1;
 
 		if (time_ref->ts_dev_2 < time_ref->ts_dev_1)
-			delta_ts &= (1 << time_ref->adapter->ts_used_bits) - 1;
+			delta_ts &= (1ULL << time_ref->adapter->ts_used_bits) - 1;
 
 		time_ref->ts_total += delta_ts;
 	}
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 6eb3140d4044..84dc6e517acf 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -685,18 +685,27 @@ static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 	return 0;
 }
 
-static int gswip_port_enable(struct dsa_switch *ds, int port,
-			     struct phy_device *phydev)
+static int gswip_port_setup(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
 	int err;
 
 	if (!dsa_is_cpu_port(ds, port)) {
-		u32 mdio_phy = 0;
-
 		err = gswip_add_single_port_br(priv, port, true);
 		if (err)
 			return err;
+	}
+
+	return 0;
+}
+
+static int gswip_port_enable(struct dsa_switch *ds, int port,
+			     struct phy_device *phydev)
+{
+	struct gswip_priv *priv = ds->priv;
+
+	if (!dsa_is_cpu_port(ds, port)) {
+		u32 mdio_phy = 0;
 
 		if (phydev)
 			mdio_phy = phydev->mdio.addr & GSWIP_MDIO_PHY_ADDR_MASK;
@@ -1359,8 +1368,9 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 	int i;
 	int err;
 
+	/* Operation not supported on the CPU port, don't throw errors */
 	if (!bridge)
-		return -EINVAL;
+		return 0;
 
 	for (i = max_ports; i < ARRAY_SIZE(priv->vlans); i++) {
 		if (priv->vlans[i].bridge == bridge) {
@@ -1829,6 +1839,7 @@ static const struct phylink_mac_ops gswip_phylink_mac_ops = {
 static const struct dsa_switch_ops gswip_xrx200_switch_ops = {
 	.get_tag_protocol	= gswip_get_tag_protocol,
 	.setup			= gswip_setup,
+	.port_setup		= gswip_port_setup,
 	.port_enable		= gswip_port_enable,
 	.port_disable		= gswip_port_disable,
 	.port_bridge_join	= gswip_port_bridge_join,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index d2ca90407cce..8057350236c5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -244,7 +244,7 @@ bnxt_tc_parse_pedit(struct bnxt *bp, struct bnxt_tc_actions *actions,
 			   offset < offset_of_ip6_daddr + 16) {
 			actions->nat.src_xlate = false;
 			idx = (offset - offset_of_ip6_daddr) / 4;
-			actions->nat.l3.ipv6.saddr.s6_addr32[idx] = htonl(val);
+			actions->nat.l3.ipv6.daddr.s6_addr32[idx] = htonl(val);
 		} else {
 			netdev_err(bp->dev,
 				   "%s: IPv6_hdr: Invalid pedit field\n",
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5f15f42070c5..e8b37dfd5cc1 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -131,7 +131,7 @@ static const struct fec_devinfo fec_mvf600_info = {
 		  FEC_QUIRK_HAS_MDIO_C45,
 };
 
-static const struct fec_devinfo fec_imx6x_info = {
+static const struct fec_devinfo fec_imx6sx_info = {
 	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
 		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
 		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
@@ -196,7 +196,7 @@ static const struct of_device_id fec_dt_ids[] = {
 	{ .compatible = "fsl,imx28-fec", .data = &fec_imx28_info, },
 	{ .compatible = "fsl,imx6q-fec", .data = &fec_imx6q_info, },
 	{ .compatible = "fsl,mvf600-fec", .data = &fec_mvf600_info, },
-	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6x_info, },
+	{ .compatible = "fsl,imx6sx-fec", .data = &fec_imx6sx_info, },
 	{ .compatible = "fsl,imx6ul-fec", .data = &fec_imx6ul_info, },
 	{ .compatible = "fsl,imx8mq-fec", .data = &fec_imx8mq_info, },
 	{ .compatible = "fsl,imx8qm-fec", .data = &fec_imx8qm_info, },
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 7c600d6e66ba..fa9bb6f27868 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1277,7 +1277,8 @@ struct i40e_mac_filter *i40e_add_mac_filter(struct i40e_vsi *vsi,
 					    const u8 *macaddr);
 int i40e_del_mac_filter(struct i40e_vsi *vsi, const u8 *macaddr);
 bool i40e_is_vsi_in_vlan(struct i40e_vsi *vsi);
-int i40e_count_filters(struct i40e_vsi *vsi);
+int i40e_count_all_filters(struct i40e_vsi *vsi);
+int i40e_count_active_filters(struct i40e_vsi *vsi);
 struct i40e_mac_filter *i40e_find_mac(struct i40e_vsi *vsi, const u8 *macaddr);
 void i40e_vlan_stripping_enable(struct i40e_vsi *vsi);
 static inline bool i40e_is_sw_dcb(struct i40e_pf *pf)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 26dcdceae741..ec1e3fffb592 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1241,12 +1241,30 @@ void i40e_update_stats(struct i40e_vsi *vsi)
 }
 
 /**
- * i40e_count_filters - counts VSI mac filters
+ * i40e_count_all_filters - counts VSI MAC filters
  * @vsi: the VSI to be searched
  *
- * Returns count of mac filters
- **/
-int i40e_count_filters(struct i40e_vsi *vsi)
+ * Return: count of MAC filters in any state.
+ */
+int i40e_count_all_filters(struct i40e_vsi *vsi)
+{
+	struct i40e_mac_filter *f;
+	struct hlist_node *h;
+	int bkt, cnt = 0;
+
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist)
+		cnt++;
+
+	return cnt;
+}
+
+/**
+ * i40e_count_active_filters - counts VSI MAC filters
+ * @vsi: the VSI to be searched
+ *
+ * Return: count of active MAC filters.
+ */
+int i40e_count_active_filters(struct i40e_vsi *vsi)
 {
 	struct i40e_mac_filter *f;
 	struct hlist_node *h;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7ccfc1191ae5..59881846e8e3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -448,7 +448,7 @@ static void i40e_config_irq_link_list(struct i40e_vf *vf, u16 vsi_id,
 		    (qtype << I40E_QINT_RQCTL_NEXTQ_TYPE_SHIFT) |
 		    (pf_queue_id << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT) |
 		    BIT(I40E_QINT_RQCTL_CAUSE_ENA_SHIFT) |
-		    (itr_idx << I40E_QINT_RQCTL_ITR_INDX_SHIFT);
+		    FIELD_PREP(I40E_QINT_RQCTL_ITR_INDX_MASK, itr_idx);
 		wr32(hw, reg_idx, reg);
 	}
 
@@ -653,6 +653,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	tx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 8 */
+	if (!IS_ALIGNED(info->ring_len, 8) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_context;
+	}
 	tx_ctx.qlen = info->ring_len;
 	tx_ctx.rdylist = le16_to_cpu(vsi->info.qs_handle[0]);
 	tx_ctx.rdylist_act = 0;
@@ -716,6 +723,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	rx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 32 */
+	if (!IS_ALIGNED(info->ring_len, 32) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_param;
+	}
 	rx_ctx.qlen = info->ring_len;
 
 	if (info->splithdr_enabled) {
@@ -1453,6 +1467,7 @@ static void i40e_trigger_vf_reset(struct i40e_vf *vf, bool flr)
 	 * functions that may still be running at this point.
 	 */
 	clear_bit(I40E_VF_STATE_INIT, &vf->vf_states);
+	clear_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 	/* In the case of a VFLR, the HW has already reset the VF and we
 	 * just need to clean up, so don't hit the VFRTRIG register.
@@ -2119,7 +2134,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 	size_t len = 0;
 	int ret;
 
-	if (!i40e_sync_vf_state(vf, I40E_VF_STATE_INIT)) {
+	i40e_sync_vf_state(vf, I40E_VF_STATE_INIT);
+
+	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states) ||
+	    test_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states)) {
 		aq_ret = -EINVAL;
 		goto err;
 	}
@@ -2222,6 +2240,7 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 				vf->default_lan_addr.addr);
 	}
 	set_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states);
+	set_bit(I40E_VF_STATE_RESOURCES_LOADED, &vf->vf_states);
 
 err:
 	/* send the response back to the VF */
@@ -2384,7 +2403,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		}
 
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}
@@ -2405,7 +2424,7 @@ static int i40e_vc_config_queues_msg(struct i40e_vf *vf, u8 *msg)
 		 * to its appropriate VSIs based on TC mapping
 		 */
 		if (vf->adq_enabled) {
-			if (idx >= ARRAY_SIZE(vf->ch)) {
+			if (idx >= vf->num_tc) {
 				aq_ret = -ENODEV;
 				goto error_param;
 			}
@@ -2455,8 +2474,10 @@ static int i40e_validate_queue_map(struct i40e_vf *vf, u16 vsi_id,
 	u16 vsi_queue_id, queue_id;
 
 	for_each_set_bit(vsi_queue_id, &queuemap, I40E_MAX_VSI_QP) {
-		if (vf->adq_enabled) {
-			vsi_id = vf->ch[vsi_queue_id / I40E_MAX_VF_VSI].vsi_id;
+		u16 idx = vsi_queue_id / I40E_MAX_VF_VSI;
+
+		if (vf->adq_enabled && idx < vf->num_tc) {
+			vsi_id = vf->ch[idx].vsi_id;
 			queue_id = (vsi_queue_id % I40E_DEFAULT_QUEUES_PER_VF);
 		} else {
 			queue_id = vsi_queue_id;
@@ -2844,24 +2865,6 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 				      (u8 *)&stats, sizeof(stats));
 }
 
-/**
- * i40e_can_vf_change_mac
- * @vf: pointer to the VF info
- *
- * Return true if the VF is allowed to change its MAC filters, false otherwise
- */
-static bool i40e_can_vf_change_mac(struct i40e_vf *vf)
-{
-	/* If the VF MAC address has been set administratively (via the
-	 * ndo_set_vf_mac command), then deny permission to the VF to
-	 * add/delete unicast MAC addresses, unless the VF is trusted
-	 */
-	if (vf->pf_set_mac && !vf->trusted)
-		return false;
-
-	return true;
-}
-
 #define I40E_MAX_MACVLAN_PER_HW 3072
 #define I40E_MAX_MACVLAN_PER_PF(num_ports) (I40E_MAX_MACVLAN_PER_HW /	\
 	(num_ports))
@@ -2900,8 +2903,10 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
 	struct i40e_hw *hw = &pf->hw;
-	int mac2add_cnt = 0;
-	int i;
+	int i, mac_add_max, mac_add_cnt = 0;
+	bool vf_trusted;
+
+	vf_trusted = test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps);
 
 	for (i = 0; i < al->num_elements; i++) {
 		struct i40e_mac_filter *f;
@@ -2921,9 +2926,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		 * The VF may request to set the MAC address filter already
 		 * assigned to it so do not return an error in that case.
 		 */
-		if (!i40e_can_vf_change_mac(vf) &&
-		    !is_multicast_ether_addr(addr) &&
-		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
+		if (!vf_trusted && !is_multicast_ether_addr(addr) &&
+		    vf->pf_set_mac && !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
 			dev_err(&pf->pdev->dev,
 				"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
 			return -EPERM;
@@ -2932,29 +2936,33 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		/*count filters that really will be added*/
 		f = i40e_find_mac(vsi, addr);
 		if (!f)
-			++mac2add_cnt;
+			++mac_add_cnt;
 	}
 
 	/* If this VF is not privileged, then we can't add more than a limited
-	 * number of addresses. Check to make sure that the additions do not
-	 * push us over the limit.
-	 */
-	if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MAC_ADDR_PER_VF) {
-			dev_err(&pf->pdev->dev,
-				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
-			return -EPERM;
-		}
-	/* If this VF is trusted, it can use more resources than untrusted.
+	 * number of addresses.
+	 *
+	 * If this VF is trusted, it can use more resources than untrusted.
 	 * However to ensure that every trusted VF has appropriate number of
 	 * resources, divide whole pool of resources per port and then across
 	 * all VFs.
 	 */
-	} else {
-		if ((i40e_count_filters(vsi) + mac2add_cnt) >
-		    I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
-						       hw->num_ports)) {
+	if (!vf_trusted)
+		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
+	else
+		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
+
+	/* VF can replace all its filters in one step, in this case mac_add_max
+	 * will be added as active and another mac_add_max will be in
+	 * a to-be-removed state. Account for that.
+	 */
+	if ((i40e_count_active_filters(vsi) + mac_add_cnt) > mac_add_max ||
+	    (i40e_count_all_filters(vsi) + mac_add_cnt) > 2 * mac_add_max) {
+		if (!vf_trusted) {
+			dev_err(&pf->pdev->dev,
+				"Cannot add more MAC addresses, VF is not trusted, switch the VF to trusted to add more functionality\n");
+			return -EPERM;
+		} else {
 			dev_err(&pf->pdev->dev,
 				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
 			return -EPERM;
@@ -3589,7 +3597,7 @@ static int i40e_validate_cloud_filter(struct i40e_vf *vf,
 
 	/* action_meta is TC number here to which the filter is applied */
 	if (!tc_filter->action_meta ||
-	    tc_filter->action_meta > vf->num_tc) {
+	    tc_filter->action_meta >= vf->num_tc) {
 		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
 			 vf->vf_id, tc_filter->action_meta);
 		goto err;
@@ -3887,6 +3895,8 @@ static int i40e_vc_del_cloud_filter(struct i40e_vf *vf, u8 *msg)
 				       aq_ret);
 }
 
+#define I40E_MAX_VF_CLOUD_FILTER 0xFF00
+
 /**
  * i40e_vc_add_cloud_filter
  * @vf: pointer to the VF info
@@ -3926,6 +3936,14 @@ static int i40e_vc_add_cloud_filter(struct i40e_vf *vf, u8 *msg)
 		goto err_out;
 	}
 
+	if (vf->num_cloud_filters >= I40E_MAX_VF_CLOUD_FILTER) {
+		dev_warn(&pf->pdev->dev,
+			 "VF %d: Max number of filters reached, can't apply cloud filter\n",
+			 vf->vf_id);
+		aq_ret = -ENOSPC;
+		goto err_out;
+	}
+
 	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
 	if (!cfilter) {
 		aq_ret = -ENOMEM;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 5cf74f16f433..f558b45725c8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -41,7 +41,8 @@ enum i40e_vf_states {
 	I40E_VF_STATE_MC_PROMISC,
 	I40E_VF_STATE_UC_PROMISC,
 	I40E_VF_STATE_PRE_ENABLE,
-	I40E_VF_STATE_RESETTING
+	I40E_VF_STATE_RESETTING,
+	I40E_VF_STATE_RESOURCES_LOADED,
 };
 
 /* VF capabilities */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 442305463cc0..21161711c579 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -21,8 +21,7 @@
 #include "rvu.h"
 #include "lmac_common.h"
 
-#define DRV_NAME	"Marvell-CGX/RPM"
-#define DRV_STRING      "Marvell CGX/RPM Driver"
+#define DRV_NAME	"Marvell-CGX-RPM"
 
 #define CGX_RX_STAT_GLOBAL_INDEX	9
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 5f80b23c5335..26a08d2cfbb1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1326,7 +1326,6 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 free_leaf:
 	otx2_tc_del_from_flow_list(flow_cfg, new_node);
-	kfree_rcu(new_node, rcu);
 	if (new_node->is_act_police) {
 		mutex_lock(&nic->mbox.lock);
 
@@ -1346,6 +1345,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 		mutex_unlock(&nic->mbox.lock);
 	}
+	kfree_rcu(new_node, rcu);
 
 	return rc;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 19664fa7f217..46d6dd05fb81 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1466,6 +1466,7 @@ static void fec_set_block_stats(struct mlx5e_priv *priv,
 	case MLX5E_FEC_RS_528_514:
 	case MLX5E_FEC_RS_544_514:
 	case MLX5E_FEC_LLRS_272_257_1:
+	case MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD:
 		fec_set_rs_stats(fec_stats, out);
 		return;
 	case MLX5E_FEC_FIRECODE:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 3b57ef6b3de3..93fb4e861b69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -663,7 +663,7 @@ static void del_sw_hw_rule(struct fs_node *node)
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_ACTION) |
 			BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_FLOW_COUNTERS);
 		fte->act_dests.action.action &= ~MLX5_FLOW_CONTEXT_ACTION_COUNT;
-		mlx5_fc_local_destroy(rule->dest_attr.counter);
+		mlx5_fc_local_put(rule->dest_attr.counter);
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 500826229b0b..e6a95b310b55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -343,6 +343,7 @@ struct mlx5_fc {
 	enum mlx5_fc_type type;
 	struct mlx5_fc_bulk *bulk;
 	struct mlx5_fc_cache cache;
+	refcount_t fc_local_refcount;
 	/* last{packets,bytes} are used for calculating deltas since last reading. */
 	u64 lastpackets;
 	u64 lastbytes;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 492775d3d193..83001eda3884 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -562,17 +562,36 @@ mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
 	counter->id = counter_id;
 	fc_bulk->base_id = counter_id - offset;
 	fc_bulk->fs_bulk.bulk_len = bulk_size;
+	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
+	mutex_init(&fc_bulk->hws_data.lock);
 	counter->bulk = fc_bulk;
+	refcount_set(&counter->fc_local_refcount, 1);
 	return counter;
 }
 EXPORT_SYMBOL(mlx5_fc_local_create);
 
 void mlx5_fc_local_destroy(struct mlx5_fc *counter)
 {
-	if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
-		return;
-
 	kfree(counter->bulk);
 	kfree(counter);
 }
 EXPORT_SYMBOL(mlx5_fc_local_destroy);
+
+void mlx5_fc_local_get(struct mlx5_fc *counter)
+{
+	if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
+		return;
+
+	refcount_inc(&counter->fc_local_refcount);
+}
+
+void mlx5_fc_local_put(struct mlx5_fc *counter)
+{
+	if (!counter || counter->type != MLX5_FC_TYPE_LOCAL)
+		return;
+
+	if (!refcount_dec_and_test(&counter->fc_local_refcount))
+		return;
+
+	mlx5_fc_local_destroy(counter);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 8e4a085f4a2e..fe56b59e24c5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1358,11 +1358,8 @@ mlx5hws_action_create_modify_header(struct mlx5hws_context *ctx,
 }
 
 struct mlx5hws_action *
-mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
-				 size_t num_dest,
+mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx, size_t num_dest,
 				 struct mlx5hws_action_dest_attr *dests,
-				 bool ignore_flow_level,
-				 u32 flow_source,
 				 u32 flags)
 {
 	struct mlx5hws_cmd_set_fte_dest *dest_list = NULL;
@@ -1400,7 +1397,7 @@ mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
 				MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 			dest_list[i].destination_id = dests[i].dest->dest_obj.obj_id;
 			fte_attr.action_flags |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-			fte_attr.ignore_flow_level = ignore_flow_level;
+			fte_attr.ignore_flow_level = 1;
 			if (dests[i].is_wire_ft)
 				last_dest_idx = i;
 			break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 47e3947e7b51..6a4c4cccd643 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -572,14 +572,12 @@ static void mlx5_fs_put_dest_action_sampler(struct mlx5_fs_hws_context *fs_ctx,
 static struct mlx5hws_action *
 mlx5_fs_create_action_dest_array(struct mlx5hws_context *ctx,
 				 struct mlx5hws_action_dest_attr *dests,
-				 u32 num_of_dests, bool ignore_flow_level,
-				 u32 flow_source)
+				 u32 num_of_dests)
 {
 	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
 
 	return mlx5hws_action_create_dest_array(ctx, num_of_dests, dests,
-						ignore_flow_level,
-						flow_source, flags);
+						flags);
 }
 
 static struct mlx5hws_action *
@@ -1016,20 +1014,14 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 		}
 		(*ractions)[num_actions++].action = dest_actions->dest;
 	} else if (num_dest_actions > 1) {
-		u32 flow_source = fte->act_dests.flow_context.flow_source;
-		bool ignore_flow_level;
-
 		if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
 		    num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
 			err = -EOPNOTSUPP;
 			goto free_actions;
 		}
-		ignore_flow_level =
-			!!(fte_action->flags & FLOW_ACT_IGNORE_FLOW_LEVEL);
-		tmp_action = mlx5_fs_create_action_dest_array(ctx, dest_actions,
-							      num_dest_actions,
-							      ignore_flow_level,
-							      flow_source);
+		tmp_action =
+			mlx5_fs_create_action_dest_array(ctx, dest_actions,
+							 num_dest_actions);
 		if (!tmp_action) {
 			err = -EOPNOTSUPP;
 			goto free_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
index f1ecdba74e1f..839d71bd4216 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -407,15 +407,21 @@ struct mlx5hws_action *mlx5_fc_get_hws_action(struct mlx5hws_context *ctx,
 {
 	struct mlx5_fs_hws_create_action_ctx create_ctx;
 	struct mlx5_fc_bulk *fc_bulk = counter->bulk;
+	struct mlx5hws_action *hws_action;
 
 	create_ctx.hws_ctx = ctx;
 	create_ctx.id = fc_bulk->base_id;
 	create_ctx.actions_type = MLX5HWS_ACTION_TYP_CTR;
 
-	return mlx5_fs_get_hws_action(&fc_bulk->hws_data, &create_ctx);
+	mlx5_fc_local_get(counter);
+	hws_action = mlx5_fs_get_hws_action(&fc_bulk->hws_data, &create_ctx);
+	if (!hws_action)
+		mlx5_fc_local_put(counter);
+	return hws_action;
 }
 
 void mlx5_fc_put_hws_action(struct mlx5_fc *counter)
 {
 	mlx5_fs_put_hws_action(&counter->bulk->hws_data);
+	mlx5_fc_local_put(counter);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index a2fe2f9e832d..e6ba5a212907 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -727,18 +727,13 @@ mlx5hws_action_create_push_vlan(struct mlx5hws_context *ctx, u32 flags);
  * @num_dest: The number of dests attributes.
  * @dests: The destination array. Each contains a destination action and can
  *	   have additional actions.
- * @ignore_flow_level: Whether to turn on 'ignore_flow_level' for this dest.
- * @flow_source: Source port of the traffic for this actions.
  * @flags: Action creation flags (enum mlx5hws_action_flags).
  *
  * Return: pointer to mlx5hws_action on success NULL otherwise.
  */
 struct mlx5hws_action *
-mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx,
-				 size_t num_dest,
+mlx5hws_action_create_dest_array(struct mlx5hws_context *ctx, size_t num_dest,
 				 struct mlx5hws_action_dest_attr *dests,
-				 bool ignore_flow_level,
-				 u32 flow_source,
 				 u32 flags);
 
 /**
diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
index eba8b5fb1365..d3501f8487d9 100644
--- a/drivers/net/phy/bcm-phy-ptp.c
+++ b/drivers/net/phy/bcm-phy-ptp.c
@@ -597,10 +597,6 @@ static int bcm_ptp_perout_locked(struct bcm_ptp_private *priv,
 
 	period = BCM_MAX_PERIOD_8NS;	/* write nonzero value */
 
-	/* Reject unsupported flags */
-	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE)
-		return -EOPNOTSUPP;
-
 	if (req->flags & PTP_PEROUT_DUTY_CYCLE)
 		pulse = ktime_to_ns(ktime_set(req->on.sec, req->on.nsec));
 	else
@@ -741,6 +737,8 @@ static const struct ptp_clock_info bcm_ptp_clock_info = {
 	.n_pins		= 1,
 	.n_per_out	= 1,
 	.n_ext_ts	= 1,
+	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE,
+	.supported_extts_flags = PTP_STRICT_FLAGS | PTP_RISING_EDGE,
 };
 
 static void bcm_ptp_txtstamp(struct mii_timestamper *mii_ts,
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 347c1e0e94d9..4cd1d6c51dc2 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -361,6 +361,11 @@ static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
+static void sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
+{
+	sfp->state_hw_mask &= ~mask;
+}
+
 static void sfp_fixup_nokia(struct sfp *sfp)
 {
 	sfp_fixup_long_startup(sfp);
@@ -409,7 +414,19 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 	 * these are possibly used for other purposes on this
 	 * module, e.g. a serial port.
 	 */
-	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
+	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
+}
+
+static void sfp_fixup_potron(struct sfp *sfp)
+{
+	/*
+	 * The TX_FAULT and LOS pins on this device are used for serial
+	 * communication, so ignore them. Additionally, provide extra
+	 * time for this device to fully start up.
+	 */
+
+	sfp_fixup_long_startup(sfp);
+	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
 }
 
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
@@ -475,6 +492,9 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("ALCATELLUCENT", "3FE46541AA", sfp_quirk_2500basex,
 		  sfp_fixup_nokia),
 
+	// FLYPRO SFP-10GT-CS-30M uses Rollball protocol to talk to the PHY.
+	SFP_QUIRK_F("FLYPRO", "SFP-10GT-CS-30M", sfp_fixup_rollball),
+
 	// Fiberstore SFP-10G-T doesn't identify as copper, uses the Rollball
 	// protocol to talk to the PHY and needs 4 sec wait before probing the
 	// PHY.
@@ -512,6 +532,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
+
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f8c5e2fd04df..0fffa023cb73 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1863,6 +1863,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 				local_bh_enable();
 				goto unlock_frags;
 			}
+
+			if (frags && skb != tfile->napi.skb)
+				tfile->napi.skb = skb;
 		}
 		rcu_read_unlock();
 		local_bh_enable();
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index eee55428749c..de5005815ee7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -2093,7 +2093,8 @@ static void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 		break;
 	}
 
-	if (trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->mac_cfg->device_family >= IWL_DEVICE_FAMILY_7000 &&
+	    trans->mac_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		len = DIV_ROUND_UP(len, 4);
 
 	if (WARN_ON(len > 0xFFF || write_ptr >= TFD_QUEUE_SIZE_MAX))
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 1fffeff2190c..4eae89376feb 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -277,7 +277,9 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		priv->is_connected = true;
 
 	/* Schedules an event that acquires the rtnl lock. */
-	cfg80211_connect_result(priv->upperdev, requested_bss, NULL, 0, NULL, 0,
+	cfg80211_connect_result(priv->upperdev,
+				priv->is_connected ? fake_router_bssid : NULL,
+				NULL, 0, NULL, 0,
 				status, GFP_KERNEL);
 	netif_carrier_on(priv->upperdev);
 }
diff --git a/drivers/pinctrl/mediatek/pinctrl-airoha.c b/drivers/pinctrl/mediatek/pinctrl-airoha.c
index 3fa5131d81e5..1dc26e898d78 100644
--- a/drivers/pinctrl/mediatek/pinctrl-airoha.c
+++ b/drivers/pinctrl/mediatek/pinctrl-airoha.c
@@ -108,6 +108,9 @@
 #define JTAG_UDI_EN_MASK			BIT(4)
 #define JTAG_DFD_EN_MASK			BIT(3)
 
+#define REG_FORCE_GPIO_EN			0x0228
+#define FORCE_GPIO_EN(n)			BIT(n)
+
 /* LED MAP */
 #define REG_LAN_LED0_MAPPING			0x027c
 #define REG_LAN_LED1_MAPPING			0x0280
@@ -718,17 +721,17 @@ static const struct airoha_pinctrl_func_group mdio_func_group[] = {
 	{
 		.name = "mdio",
 		.regmap[0] = {
-			AIROHA_FUNC_MUX,
-			REG_GPIO_PON_MODE,
-			GPIO_SGMII_MDIO_MODE_MASK,
-			GPIO_SGMII_MDIO_MODE_MASK
-		},
-		.regmap[1] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_2ND_I2C_MODE,
 			GPIO_MDC_IO_MASTER_MODE_MODE,
 			GPIO_MDC_IO_MASTER_MODE_MODE
 		},
+		.regmap[1] = {
+			AIROHA_FUNC_MUX,
+			REG_FORCE_GPIO_EN,
+			FORCE_GPIO_EN(1) | FORCE_GPIO_EN(2),
+			FORCE_GPIO_EN(1) | FORCE_GPIO_EN(2)
+		},
 		.regmap_size = 2,
 	},
 };
@@ -1752,8 +1755,8 @@ static const struct airoha_pinctrl_func_group phy1_led1_func_group[] = {
 		.regmap[0] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_2ND_I2C_MODE,
-			GPIO_LAN3_LED0_MODE_MASK,
-			GPIO_LAN3_LED0_MODE_MASK
+			GPIO_LAN3_LED1_MODE_MASK,
+			GPIO_LAN3_LED1_MODE_MASK
 		},
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
@@ -1816,8 +1819,8 @@ static const struct airoha_pinctrl_func_group phy2_led1_func_group[] = {
 		.regmap[0] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_2ND_I2C_MODE,
-			GPIO_LAN3_LED0_MODE_MASK,
-			GPIO_LAN3_LED0_MODE_MASK
+			GPIO_LAN3_LED1_MODE_MASK,
+			GPIO_LAN3_LED1_MODE_MASK
 		},
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
@@ -1880,8 +1883,8 @@ static const struct airoha_pinctrl_func_group phy3_led1_func_group[] = {
 		.regmap[0] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_2ND_I2C_MODE,
-			GPIO_LAN3_LED0_MODE_MASK,
-			GPIO_LAN3_LED0_MODE_MASK
+			GPIO_LAN3_LED1_MODE_MASK,
+			GPIO_LAN3_LED1_MODE_MASK
 		},
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
@@ -1944,8 +1947,8 @@ static const struct airoha_pinctrl_func_group phy4_led1_func_group[] = {
 		.regmap[0] = {
 			AIROHA_FUNC_MUX,
 			REG_GPIO_2ND_I2C_MODE,
-			GPIO_LAN3_LED0_MODE_MASK,
-			GPIO_LAN3_LED0_MODE_MASK
+			GPIO_LAN3_LED1_MODE_MASK,
+			GPIO_LAN3_LED1_MODE_MASK
 		},
 		.regmap[1] = {
 			AIROHA_FUNC_MUX,
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 4b57102c7f62..6af6cf477c5b 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
@@ -75,6 +76,9 @@ MODULE_PARM_DESC(fw_debug, "Enable printing of firmware debug messages");
 #define WMBB_USB_CHARGE 0x10B
 #define WMBB_BATT_LIMIT 0x10C
 
+#define FAN_MODE_LOWER GENMASK(1, 0)
+#define FAN_MODE_UPPER GENMASK(5, 4)
+
 #define PLATFORM_NAME   "lg-laptop"
 
 MODULE_ALIAS("wmi:" WMI_EVENT_GUID0);
@@ -274,29 +278,19 @@ static ssize_t fan_mode_store(struct device *dev,
 			      struct device_attribute *attr,
 			      const char *buffer, size_t count)
 {
-	bool value;
+	unsigned long value;
 	union acpi_object *r;
-	u32 m;
 	int ret;
 
-	ret = kstrtobool(buffer, &value);
+	ret = kstrtoul(buffer, 10, &value);
 	if (ret)
 		return ret;
+	if (value >= 3)
+		return -EINVAL;
 
-	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
-	if (!r)
-		return -EIO;
-
-	if (r->type != ACPI_TYPE_INTEGER) {
-		kfree(r);
-		return -EIO;
-	}
-
-	m = r->integer.value;
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xffffff0f) | (value << 4));
-	kfree(r);
-	r = lg_wmab(dev, WM_FAN_MODE, WM_SET, (m & 0xfffffff0) | value);
+	r = lg_wmab(dev, WM_FAN_MODE, WM_SET,
+		FIELD_PREP(FAN_MODE_LOWER, value) |
+		FIELD_PREP(FAN_MODE_UPPER, value));
 	kfree(r);
 
 	return count;
@@ -305,7 +299,7 @@ static ssize_t fan_mode_store(struct device *dev,
 static ssize_t fan_mode_show(struct device *dev,
 			     struct device_attribute *attr, char *buffer)
 {
-	unsigned int status;
+	unsigned int mode;
 	union acpi_object *r;
 
 	r = lg_wmab(dev, WM_FAN_MODE, WM_GET, 0);
@@ -317,10 +311,10 @@ static ssize_t fan_mode_show(struct device *dev,
 		return -EIO;
 	}
 
-	status = r->integer.value & 0x01;
+	mode = FIELD_GET(FAN_MODE_LOWER, r->integer.value);
 	kfree(r);
 
-	return sysfs_emit(buffer, "%d\n", status);
+	return sysfs_emit(buffer, "%d\n", mode);
 }
 
 static ssize_t usb_charge_store(struct device *dev,
diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
index 9839e8cb82ce..eb076bb4099b 100644
--- a/drivers/platform/x86/oxpec.c
+++ b/drivers/platform/x86/oxpec.c
@@ -292,6 +292,13 @@ static const struct dmi_system_id dmi_table[] = {
 		},
 		.driver_data = (void *)oxp_x1,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Mini Pro"),
+		},
+		.driver_data = (void *)oxp_x1,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d3c78f59b22c..c9eb8004fcc2 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -46,6 +46,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_DMA_SET_MASK		BIT(7)
 #define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
+#define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -108,6 +109,8 @@ struct cqspi_st {
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 	bool			disable_stig_mode;
+	refcount_t		refcount;
+	refcount_t		inflight_ops;
 
 	const struct cqspi_driver_platdata *ddata;
 };
@@ -735,6 +738,9 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -1071,6 +1077,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	unsigned int write_bytes;
 	int ret;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1460,21 +1469,43 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	int ret;
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
+	const struct cqspi_driver_platdata *ddata = of_device_get_match_data(dev);
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret) {
-		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-		return ret;
+	if (refcount_read(&cqspi->inflight_ops) == 0)
+		return -ENODEV;
+
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+			return ret;
+		}
+	}
+
+	if (!refcount_read(&cqspi->refcount))
+		return -EBUSY;
+
+	refcount_inc(&cqspi->inflight_ops);
+
+	if (!refcount_read(&cqspi->refcount)) {
+		if (refcount_read(&cqspi->inflight_ops))
+			refcount_dec(&cqspi->inflight_ops);
+		return -EBUSY;
 	}
 
 	ret = cqspi_mem_process(mem, op);
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
 
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+	if (refcount_read(&cqspi->inflight_ops) > 1)
+		refcount_dec(&cqspi->inflight_ops);
+
 	return ret;
 }
 
@@ -1926,6 +1957,9 @@ static int cqspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	refcount_set(&cqspi->refcount, 1);
+	refcount_set(&cqspi->inflight_ops, 1);
+
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
@@ -1958,11 +1992,12 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	pm_runtime_enable(dev);
-
-	pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_get_noresume(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_enable(dev);
+		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
+		pm_runtime_use_autosuspend(dev);
+		pm_runtime_get_noresume(dev);
+	}
 
 	ret = spi_register_controller(host);
 	if (ret) {
@@ -1970,13 +2005,17 @@ static int cqspi_probe(struct platform_device *pdev)
 		goto probe_setup_failed;
 	}
 
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_put_autosuspend(dev);
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+	}
 
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
-	pm_runtime_disable(dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1987,7 +2026,16 @@ static int cqspi_probe(struct platform_device *pdev)
 
 static void cqspi_remove(struct platform_device *pdev)
 {
+	const struct cqspi_driver_platdata *ddata;
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	ddata = of_device_get_match_data(dev);
+
+	refcount_set(&cqspi->refcount, 0);
+
+	if (!refcount_dec_and_test(&cqspi->inflight_ops))
+		cqspi_wait_idle(cqspi);
 
 	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
@@ -1995,14 +2043,17 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_disable(cqspi->clk);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+		if (pm_runtime_get_sync(&pdev->dev) >= 0)
+			clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
 
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		pm_runtime_put_sync(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
 }
 
 static int cqspi_runtime_suspend(struct device *dev)
@@ -2081,7 +2132,8 @@ static const struct cqspi_driver_platdata socfpga_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE
 			| CQSPI_NO_SUPPORT_WR_COMPLETION
 			| CQSPI_SLOW_SRAM
-			| CQSPI_DISABLE_STIG_MODE,
+			| CQSPI_DISABLE_STIG_MODE
+			| CQSPI_DISABLE_RUNTIME_PM,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 1e50675772fe..cc88aaa106da 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -243,7 +243,7 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
 		hwq->sqe_base_addr = dmam_alloc_coherent(hba->dev, utrdl_size,
 							 &hwq->sqe_dma_addr,
 							 GFP_KERNEL);
-		if (!hwq->sqe_dma_addr) {
+		if (!hwq->sqe_base_addr) {
 			dev_err(hba->dev, "SQE allocation failed\n");
 			return -ENOMEM;
 		}
@@ -252,7 +252,7 @@ int ufshcd_mcq_memory_alloc(struct ufs_hba *hba)
 		hwq->cqe_base_addr = dmam_alloc_coherent(hba->dev, cqe_size,
 							 &hwq->cqe_dma_addr,
 							 GFP_KERNEL);
-		if (!hwq->cqe_dma_addr) {
+		if (!hwq->cqe_base_addr) {
 			dev_err(hba->dev, "CQE allocation failed\n");
 			return -ENOMEM;
 		}
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index d6daad39491b..f5bc53875330 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -737,7 +737,7 @@ void usb_detect_quirks(struct usb_device *udev)
 	udev->quirks ^= usb_detect_dynamic_quirks(udev);
 
 	if (udev->quirks)
-		dev_dbg(&udev->dev, "USB quirks for this device: %x\n",
+		dev_dbg(&udev->dev, "USB quirks for this device: 0x%x\n",
 			udev->quirks);
 
 #ifdef CONFIG_USB_DEFAULT_PERSIST
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 53551aafd470..c5902cc261e5 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -760,10 +760,10 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 	int err;
 	int sent_pkts = 0;
 	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
-	bool busyloop_intr;
 
 	do {
-		busyloop_intr = false;
+		bool busyloop_intr = false;
+
 		if (nvq->done_idx == VHOST_NET_BATCH)
 			vhost_tx_batch(net, nvq, sock, &msg);
 
@@ -774,10 +774,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 			break;
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head == vq->num) {
-			/* Kicks are disabled at this point, break loop and
-			 * process any remaining batched packets. Queue will
-			 * be re-enabled afterwards.
+			/* Flush batched packets to handle pending RX
+			 * work (if busyloop_intr is set) and to avoid
+			 * unnecessary virtqueue kicks.
 			 */
+			vhost_tx_batch(net, nvq, sock, &msg);
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev,
+								vq))) {
+				vhost_disable_notify(&net->dev, vq);
+				continue;
+			}
 			break;
 		}
 
@@ -827,22 +835,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
 		++nvq->done_idx;
 	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
 
-	/* Kicks are still disabled, dispatch any remaining batched msgs. */
 	vhost_tx_batch(net, nvq, sock, &msg);
-
-	if (unlikely(busyloop_intr))
-		/* If interrupted while doing busy polling, requeue the
-		 * handler to be fair handle_rx as well as other tasks
-		 * waiting on cpu.
-		 */
-		vhost_poll_queue(&vq->poll);
-	else
-		/* All of our work has been completed; however, before
-		 * leaving the TX handler, do one last check for work,
-		 * and requeue handler if necessary. If there is no work,
-		 * queue will be reenabled.
-		 */
-		vhost_net_busy_poll_try_queue(net, vq);
 }
 
 static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9eb880a11fd8..a786b0c1940b 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2491,7 +2491,7 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
-	int size;
+	int size, alloc_size;
 	int i, csum;
 	u8 *new_data, *data = font->data;
 	int pitch = PITCH(font->width);
@@ -2518,9 +2518,16 @@ static int fbcon_set_font(struct vc_data *vc, const struct console_font *font,
 	if (fbcon_invalid_charcount(info, charcount))
 		return -EINVAL;
 
-	size = CALC_FONTSZ(h, pitch, charcount);
+	/* Check for integer overflow in font size calculation */
+	if (check_mul_overflow(h, pitch, &size) ||
+	    check_mul_overflow(size, charcount, &size))
+		return -EINVAL;
+
+	/* Check for overflow in allocation size calculation */
+	if (check_add_overflow(FONT_EXTRA_WORDS * sizeof(int), size, &alloc_size))
+		return -EINVAL;
 
-	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
+	new_data = kmalloc(alloc_size, GFP_USER);
 
 	if (!new_data)
 		return -ENOMEM;
diff --git a/fs/afs/server.c b/fs/afs/server.c
index a97562f831eb..c4428ebddb1d 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -331,13 +331,14 @@ struct afs_server *afs_use_server(struct afs_server *server, bool activate,
 void afs_put_server(struct afs_net *net, struct afs_server *server,
 		    enum afs_server_trace reason)
 {
-	unsigned int a, debug_id = server->debug_id;
+	unsigned int a, debug_id;
 	bool zero;
 	int r;
 
 	if (!server)
 		return;
 
+	debug_id = server->debug_id;
 	a = atomic_read(&server->active);
 	zero = __refcount_dec_and_test(&server->ref, &r);
 	trace_afs_server(debug_id, r - 1, a, reason);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f475b4b7c457..817d3ef501ec 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2714,6 +2714,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		goto error;
 	}
 
+	if (bdev_nr_bytes(file_bdev(bdev_file)) <= BTRFS_DEVICE_RANGE_RESERVED) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	if (fs_devices->seeding) {
 		seeding_dev = true;
 		down_write(&sb->s_umount);
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index e4de5425838d..6040e5408277 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -520,14 +520,16 @@ static bool remove_inode_single_folio(struct hstate *h, struct inode *inode,
 
 	/*
 	 * If folio is mapped, it was faulted in after being
-	 * unmapped in caller.  Unmap (again) while holding
-	 * the fault mutex.  The mutex will prevent faults
-	 * until we finish removing the folio.
+	 * unmapped in caller or hugetlb_vmdelete_list() skips
+	 * unmapping it due to fail to grab lock.  Unmap (again)
+	 * while holding the fault mutex.  The mutex will prevent
+	 * faults until we finish removing the folio.  Hold folio
+	 * lock to guarantee no concurrent migration.
 	 */
+	folio_lock(folio);
 	if (unlikely(folio_mapped(folio)))
 		hugetlb_unmap_file_folio(h, mapping, folio, index);
 
-	folio_lock(folio);
 	/*
 	 * We must remove the folio from page cache before removing
 	 * the region/ reserve map (hugetlb_unreserve_pages).  In
diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 18b3dc74c70e..37ab6f28b5ad 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -369,7 +369,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	return netfs_put_request(rreq, netfs_rreq_trace_put_return);
 
 cleanup_free:
-	return netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	return netfs_put_failed_request(rreq);
 }
 EXPORT_SYMBOL(netfs_readahead);
 
@@ -472,7 +472,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	return ret < 0 ? ret : 0;
 
 discard:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 alloc_error:
 	folio_unlock(folio);
 	return ret;
@@ -532,7 +532,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	return ret < 0 ? ret : 0;
 
 discard:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 alloc_error:
 	folio_unlock(folio);
 	return ret;
@@ -699,7 +699,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	return 0;
 
 error_put:
-	netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(rreq);
 error:
 	if (folio) {
 		folio_unlock(folio);
@@ -754,7 +754,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	return ret < 0 ? ret : 0;
 
 error_put:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 error:
 	_leave(" = %d", ret);
 	return ret;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a05e13472baf..a498ee8d6674 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -131,6 +131,7 @@ static ssize_t netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 
 	if (rreq->len == 0) {
 		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
+		netfs_put_request(rreq, netfs_rreq_trace_put_discard);
 		return -EIO;
 	}
 
@@ -205,7 +206,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	if (user_backed_iter(iter)) {
 		ret = netfs_extract_user_iter(iter, rreq->len, &rreq->buffer.iter, 0);
 		if (ret < 0)
-			goto out;
+			goto error_put;
 		rreq->direct_bv = (struct bio_vec *)rreq->buffer.iter.bvec;
 		rreq->direct_bv_count = ret;
 		rreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
@@ -238,6 +239,10 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	if (ret > 0)
 		orig_count -= ret;
 	return ret;
+
+error_put:
+	netfs_put_failed_request(rreq);
+	return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_read_iter_locked);
 
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index a16660ab7f83..a9d1c3b2c084 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -57,7 +57,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 			n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
 			if (n < 0) {
 				ret = n;
-				goto out;
+				goto error_put;
 			}
 			wreq->direct_bv = (struct bio_vec *)wreq->buffer.iter.bvec;
 			wreq->direct_bv_count = n;
@@ -101,6 +101,10 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 out:
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 	return ret;
+
+error_put:
+	netfs_put_failed_request(wreq);
+	return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_write_iter_locked);
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d4f16fefd965..4319611f5354 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -87,6 +87,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what);
 void netfs_clear_subrequests(struct netfs_io_request *rreq);
 void netfs_put_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what);
+void netfs_put_failed_request(struct netfs_io_request *rreq);
 struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq);
 
 static inline void netfs_see_request(struct netfs_io_request *rreq,
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e8c99738b5bb..40a1c7d6f6e0 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -116,10 +116,8 @@ static void netfs_free_request_rcu(struct rcu_head *rcu)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
-static void netfs_free_request(struct work_struct *work)
+static void netfs_deinit_request(struct netfs_io_request *rreq)
 {
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, cleanup_work);
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
 	unsigned int i;
 
@@ -149,6 +147,14 @@ static void netfs_free_request(struct work_struct *work)
 
 	if (atomic_dec_and_test(&ictx->io_count))
 		wake_up_var(&ictx->io_count);
+}
+
+static void netfs_free_request(struct work_struct *work)
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, cleanup_work);
+
+	netfs_deinit_request(rreq);
 	call_rcu(&rreq->rcu, netfs_free_request_rcu);
 }
 
@@ -167,6 +173,24 @@ void netfs_put_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace
 	}
 }
 
+/*
+ * Free a request (synchronously) that was just allocated but has
+ * failed before it could be submitted.
+ */
+void netfs_put_failed_request(struct netfs_io_request *rreq)
+{
+	int r = refcount_read(&rreq->ref);
+
+	/* new requests have two references (see
+	 * netfs_alloc_request(), and this function is only allowed on
+	 * new request objects
+	 */
+	WARN_ON_ONCE(r != 2);
+
+	trace_netfs_rreq_ref(rreq->debug_id, r, netfs_rreq_trace_put_failed);
+	netfs_free_request(&rreq->cleanup_work);
+}
+
 /*
  * Allocate and partially initialise an I/O request structure.
  */
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 8097bc069c1d..a1489aa29f78 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -118,7 +118,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 	return creq;
 
 cancel_put:
-	netfs_put_request(creq, netfs_rreq_trace_put_return);
+	netfs_put_failed_request(creq);
 cancel:
 	rreq->copy_to_cache = ERR_PTR(-ENOBUFS);
 	clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..5c0dc4efc792 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -189,7 +189,7 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	return ret;
 
 cleanup_free:
-	netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(rreq);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_read_single);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 0584cba1a043..dd8743bc8d7f 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -133,8 +133,7 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 
 	return wreq;
 nomem:
-	wreq->error = -ENOMEM;
-	netfs_put_request(wreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(wreq);
 	return ERR_PTR(-ENOMEM);
 }
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index a16a619fb8c3..8cc39a73faff 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/gfp.h>
+#include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/compaction.h>
 
@@ -279,6 +280,37 @@ nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 }
 EXPORT_SYMBOL_GPL(nfs_file_fsync);
 
+void nfs_truncate_last_folio(struct address_space *mapping, loff_t from,
+			     loff_t to)
+{
+	struct folio *folio;
+
+	if (from >= to)
+		return;
+
+	folio = filemap_lock_folio(mapping, from >> PAGE_SHIFT);
+	if (IS_ERR(folio))
+		return;
+
+	if (folio_mkclean(folio))
+		folio_mark_dirty(folio);
+
+	if (folio_test_uptodate(folio)) {
+		loff_t fpos = folio_pos(folio);
+		size_t offset = from - fpos;
+		size_t end = folio_size(folio);
+
+		if (to - fpos < end)
+			end = to - fpos;
+		folio_zero_segment(folio, offset, end);
+		trace_nfs_size_truncate_folio(mapping->host, to);
+	}
+
+	folio_unlock(folio);
+	folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(nfs_truncate_last_folio);
+
 /*
  * Decide whether a read/modify/write cycle may be more efficient
  * then a modify/write/read cycle when writing to a page in the
@@ -353,6 +385,7 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 
 	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
+	nfs_truncate_last_folio(mapping, i_size_read(mapping->host), pos);
 
 	fgp |= fgf_set_order(len);
 start:
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a32cc45425e2..f6b448666d41 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -710,6 +710,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct nfs_fattr *fattr;
+	loff_t oldsize = i_size_read(inode);
 	int error = 0;
 
 	nfs_inc_stats(inode, NFSIOS_VFSSETATTR);
@@ -725,7 +726,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (error)
 			return error;
 
-		if (attr->ia_size == i_size_read(inode))
+		if (attr->ia_size == oldsize)
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
@@ -773,8 +774,12 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	error = NFS_PROTO(inode)->setattr(dentry, fattr, attr);
-	if (error == 0)
+	if (error == 0) {
+		if (attr->ia_valid & ATTR_SIZE)
+			nfs_truncate_last_folio(inode->i_mapping, oldsize,
+						attr->ia_size);
 		error = nfs_refresh_inode(inode, fattr);
+	}
 	nfs_free_fattr(fattr);
 out:
 	trace_nfs_setattr_exit(inode, error);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 0ef0fc6aba3b..ae4d039c10d3 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -438,6 +438,8 @@ int nfs_file_release(struct inode *, struct file *);
 int nfs_lock(struct file *, int, struct file_lock *);
 int nfs_flock(struct file *, int, struct file_lock *);
 int nfs_check_flags(int);
+void nfs_truncate_last_folio(struct address_space *mapping, loff_t from,
+			     loff_t to);
 
 /* inode.c */
 extern struct workqueue_struct *nfsiod_workqueue;
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 48ee3d5d89c4..6a0b5871ba3b 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -138,6 +138,7 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE],
 	};
 	struct inode *inode = file_inode(filep);
+	loff_t oldsize = i_size_read(inode);
 	int err;
 
 	if (!nfs_server_capable(inode, NFS_CAP_ALLOCATE))
@@ -146,7 +147,11 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
 	inode_lock(inode);
 
 	err = nfs42_proc_fallocate(&msg, filep, offset, len);
-	if (err == -EOPNOTSUPP)
+
+	if (err == 0)
+		nfs_truncate_last_folio(inode->i_mapping, oldsize,
+					offset + len);
+	else if (err == -EOPNOTSUPP)
 		NFS_SERVER(inode)->caps &= ~(NFS_CAP_ALLOCATE |
 					     NFS_CAP_ZERO_RANGE);
 
@@ -184,6 +189,7 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ZERO_RANGE],
 	};
 	struct inode *inode = file_inode(filep);
+	loff_t oldsize = i_size_read(inode);
 	int err;
 
 	if (!nfs_server_capable(inode, NFS_CAP_ZERO_RANGE))
@@ -192,9 +198,11 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
 	inode_lock(inode);
 
 	err = nfs42_proc_fallocate(&msg, filep, offset, len);
-	if (err == 0)
+	if (err == 0) {
+		nfs_truncate_last_folio(inode->i_mapping, oldsize,
+					offset + len);
 		truncate_pagecache_range(inode, offset, (offset + len) -1);
-	if (err == -EOPNOTSUPP)
+	} else if (err == -EOPNOTSUPP)
 		NFS_SERVER(inode)->caps &= ~NFS_CAP_ZERO_RANGE;
 
 	inode_unlock(inode);
@@ -355,22 +363,27 @@ static int process_copy_commit(struct file *dst, loff_t pos_dst,
 
 /**
  * nfs42_copy_dest_done - perform inode cache updates after clone/copy offload
- * @inode: pointer to destination inode
+ * @file: pointer to destination file
  * @pos: destination offset
  * @len: copy length
+ * @oldsize: length of the file prior to clone/copy
  *
  * Punch a hole in the inode page cache, so that the NFS client will
  * know to retrieve new data.
  * Update the file size if necessary, and then mark the inode as having
  * invalid cached values for change attribute, ctime, mtime and space used.
  */
-static void nfs42_copy_dest_done(struct inode *inode, loff_t pos, loff_t len)
+static void nfs42_copy_dest_done(struct file *file, loff_t pos, loff_t len,
+				 loff_t oldsize)
 {
+	struct inode *inode = file_inode(file);
+	struct address_space *mapping = file->f_mapping;
 	loff_t newsize = pos + len;
 	loff_t end = newsize - 1;
 
-	WARN_ON_ONCE(invalidate_inode_pages2_range(inode->i_mapping,
-				pos >> PAGE_SHIFT, end >> PAGE_SHIFT));
+	nfs_truncate_last_folio(mapping, oldsize, pos);
+	WARN_ON_ONCE(invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
+						   end >> PAGE_SHIFT));
 
 	spin_lock(&inode->i_lock);
 	if (newsize > i_size_read(inode))
@@ -403,6 +416,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 	struct nfs_server *src_server = NFS_SERVER(src_inode);
 	loff_t pos_src = args->src_pos;
 	loff_t pos_dst = args->dst_pos;
+	loff_t oldsize_dst = i_size_read(dst_inode);
 	size_t count = args->count;
 	ssize_t status;
 
@@ -477,7 +491,7 @@ static ssize_t _nfs42_proc_copy(struct file *src,
 			goto out;
 	}
 
-	nfs42_copy_dest_done(dst_inode, pos_dst, res->write_res.count);
+	nfs42_copy_dest_done(dst, pos_dst, res->write_res.count, oldsize_dst);
 	nfs_invalidate_atime(src_inode);
 	status = res->write_res.count;
 out:
@@ -1244,6 +1258,7 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 	struct nfs42_clone_res res = {
 		.server	= server,
 	};
+	loff_t oldsize_dst = i_size_read(dst_inode);
 	int status;
 
 	msg->rpc_argp = &args;
@@ -1278,7 +1293,7 @@ static int _nfs42_proc_clone(struct rpc_message *msg, struct file *src_f,
 		/* a zero-length count means clone to EOF in src */
 		if (count == 0 && res.dst_fattr->valid & NFS_ATTR_FATTR_SIZE)
 			count = nfs_size_to_loff_t(res.dst_fattr->size) - dst_offset;
-		nfs42_copy_dest_done(dst_inode, dst_offset, count);
+		nfs42_copy_dest_done(dst_f, dst_offset, count, oldsize_dst);
 		status = nfs_post_op_update_inode(dst_inode, res.dst_fattr);
 	}
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 7a058bd8c566..1e4dc632f180 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -267,6 +267,7 @@ DECLARE_EVENT_CLASS(nfs_update_size_class,
 			TP_ARGS(inode, new_size))
 
 DEFINE_NFS_UPDATE_SIZE_EVENT(truncate);
+DEFINE_NFS_UPDATE_SIZE_EVENT(truncate_folio);
 DEFINE_NFS_UPDATE_SIZE_EVENT(wcc);
 DEFINE_NFS_UPDATE_SIZE_EVENT(update);
 DEFINE_NFS_UPDATE_SIZE_EVENT(grow);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index bdc3c2e9334a..ea4ff22976c5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2286,6 +2286,9 @@ static void pagemap_scan_backout_range(struct pagemap_scan_private *p,
 {
 	struct page_region *cur_buf = &p->vec_buf[p->vec_buf_index];
 
+	if (!p->vec_buf)
+		return;
+
 	if (cur_buf->start != addr)
 		cur_buf->end = addr;
 	else
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 86cad8ee8e6f..ac3ce183bd59 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -687,7 +687,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	for (i = 0; i < num_cmds; i++) {
-		char *buf = rsp_iov[i + i].iov_base;
+		char *buf = rsp_iov[i + 1].iov_base;
 
 		if (buf && resp_buftype[i + 1] != CIFS_NO_BUFFER)
 			rc = server->ops->map_error(buf, false);
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 6550bd9f002c..74dfb6496095 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -148,7 +148,7 @@ struct smb_direct_transport {
 	wait_queue_head_t	wait_send_pending;
 	atomic_t		send_pending;
 
-	struct delayed_work	post_recv_credits_work;
+	struct work_struct	post_recv_credits_work;
 	struct work_struct	send_immediate_work;
 	struct work_struct	disconnect_work;
 
@@ -367,8 +367,8 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 
 	spin_lock_init(&t->lock_new_recv_credits);
 
-	INIT_DELAYED_WORK(&t->post_recv_credits_work,
-			  smb_direct_post_recv_credits);
+	INIT_WORK(&t->post_recv_credits_work,
+		  smb_direct_post_recv_credits);
 	INIT_WORK(&t->send_immediate_work, smb_direct_send_immediate_work);
 	INIT_WORK(&t->disconnect_work, smb_direct_disconnect_rdma_work);
 
@@ -399,9 +399,9 @@ static void free_transport(struct smb_direct_transport *t)
 	wait_event(t->wait_send_pending,
 		   atomic_read(&t->send_pending) == 0);
 
-	cancel_work_sync(&t->disconnect_work);
-	cancel_delayed_work_sync(&t->post_recv_credits_work);
-	cancel_work_sync(&t->send_immediate_work);
+	disable_work_sync(&t->disconnect_work);
+	disable_work_sync(&t->post_recv_credits_work);
+	disable_work_sync(&t->send_immediate_work);
 
 	if (t->qp) {
 		ib_drain_qp(t->qp);
@@ -615,8 +615,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			wake_up_interruptible(&t->wait_send_credits);
 
 		if (is_receive_credit_post_required(receive_credits, avail_recvmsg_count))
-			mod_delayed_work(smb_direct_wq,
-					 &t->post_recv_credits_work, 0);
+			queue_work(smb_direct_wq, &t->post_recv_credits_work);
 
 		if (data_length) {
 			enqueue_reassembly(t, recvmsg, (int)data_length);
@@ -773,8 +772,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 		st->count_avail_recvmsg += queue_removed;
 		if (is_receive_credit_post_required(st->recv_credits, st->count_avail_recvmsg)) {
 			spin_unlock(&st->receive_credit_lock);
-			mod_delayed_work(smb_direct_wq,
-					 &st->post_recv_credits_work, 0);
+			queue_work(smb_direct_wq, &st->post_recv_credits_work);
 		} else {
 			spin_unlock(&st->receive_credit_lock);
 		}
@@ -801,7 +799,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 static void smb_direct_post_recv_credits(struct work_struct *work)
 {
 	struct smb_direct_transport *t = container_of(work,
-		struct smb_direct_transport, post_recv_credits_work.work);
+		struct smb_direct_transport, post_recv_credits_work);
 	struct smb_direct_recvmsg *recvmsg;
 	int receive_credits, credits = 0;
 	int ret;
@@ -1734,7 +1732,7 @@ static int smb_direct_prepare_negotiation(struct smb_direct_transport *t)
 		goto out_err;
 	}
 
-	smb_direct_post_recv_credits(&t->post_recv_credits_work.work);
+	smb_direct_post_recv_credits(&t->post_recv_credits_work);
 	return 0;
 out_err:
 	put_recvmsg(t, recvmsg);
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 0c70f3a55575..107b797c33ec 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -152,7 +152,7 @@ struct af_alg_ctx {
 	size_t used;
 	atomic_t rcvused;
 
-	u32		more:1,
+	bool		more:1,
 			merge:1,
 			enc:1,
 			write:1,
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index a8a17eeb7d90..1817df9aceac 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -18,13 +18,43 @@
 #define SCMI_IMX_CTRL_SAI4_MCLK		4	/* WAKE SAI4 MCLK */
 #define SCMI_IMX_CTRL_SAI5_MCLK		5	/* WAKE SAI5 MCLK */
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV)
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
+#else
+static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
 
+static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_IMX_SCMI_CPU_DRV)
 int scmi_imx_cpu_start(u32 cpuid, bool start);
 int scmi_imx_cpu_started(u32 cpuid, bool *started);
 int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
 				  bool resume);
+#else
+static inline int scmi_imx_cpu_start(u32 cpuid, bool start)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_started(u32 cpuid, bool *started)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start,
+						bool boot, bool resume)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 enum scmi_imx_lmm_op {
 	SCMI_IMX_LMM_BOOT,
@@ -36,7 +66,24 @@ enum scmi_imx_lmm_op {
 #define SCMI_IMX_LMM_OP_FORCEFUL	0
 #define SCMI_IMX_LMM_OP_GRACEFUL	BIT(0)
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_LMM_DRV)
 int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags);
 int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);
 int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector);
+#else
+static inline int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 #endif
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 939e58c2f386..fb5f98fcc726 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -308,6 +308,8 @@ struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging);
 void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter);
 struct mlx5_fc *mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size);
 void mlx5_fc_local_destroy(struct mlx5_fc *counter);
+void mlx5_fc_local_get(struct mlx5_fc *counter);
+void mlx5_fc_local_put(struct mlx5_fc *counter);
 u64 mlx5_fc_query_lastuse(struct mlx5_fc *counter);
 void mlx5_fc_query_cached(struct mlx5_fc *counter,
 			  u64 *bytes, u64 *packets, u64 *lastuse);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 439bc124ce70..1347ae13dd0a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1245,6 +1245,27 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_role(struct hci_dev *hdev,
+							 __u8 type, __u8 role,
+							 bdaddr_t *ba)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->role == role && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_le(struct hci_dev *hdev,
 						       bdaddr_t *ba,
 						       __u8 ba_type)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 829f0792d8d8..17e5cf18da1e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3013,7 +3013,10 @@ EXPORT_SYMBOL_GPL(bpf_event_output);
 
 /* Always built-in helper functions. */
 const struct bpf_func_proto bpf_tail_call_proto = {
-	.func		= NULL,
+	/* func is unused for tail_call, we set it to pass the
+	 * get_helper_proto check
+	 */
+	.func		= BPF_PTR_POISON,
 	.gpl_only	= false,
 	.ret_type	= RET_VOID,
 	.arg1_type	= ARG_PTR_TO_CTX,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4fd89659750b..a6338936085a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8405,6 +8405,10 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
+		return -EOPNOTSUPP;
+	}
 	meta->map_uid = reg->map_uid;
 	meta->map_ptr = map;
 	return 0;
@@ -11206,7 +11210,7 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 		return -EINVAL;
 
 	*ptr = env->ops->get_func_proto(func_id, env->prog);
-	return *ptr ? 0 : -EINVAL;
+	return *ptr && (*ptr)->func ? 0 : -EINVAL;
 }
 
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38b..0cbc174da76a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2289,7 +2289,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (need_futex_hash_allocate_default(clone_flags)) {
 		retval = futex_hash_allocate_default();
 		if (retval)
-			goto bad_fork_core_free;
+			goto bad_fork_cancel_cgroup;
 		/*
 		 * If we fail beyond this point we don't free the allocated
 		 * futex hash map. We assume that another thread will be created
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index c716a66f8692..d818b4d47f1b 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -230,8 +230,9 @@ static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 			   struct futex_hash_bucket *hb)
 {
-	q->key = *key;
+	struct task_struct *task;
 
+	q->key = *key;
 	__futex_unqueue(q);
 
 	WARN_ON(!q->rt_waiter);
@@ -243,10 +244,11 @@ void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 	futex_hash_get(hb);
 	q->drop_hb_ref = true;
 	q->lock_ptr = &hb->lock;
+	task = READ_ONCE(q->task);
 
 	/* Signal locked state to the waiter */
 	futex_requeue_pi_complete(q, 1);
-	wake_up_state(q->task, TASK_NORMAL);
+	wake_up_state(task, TASK_NORMAL);
 }
 
 /**
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 001fb88a8481..edd6cdd9aadc 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -75,7 +75,7 @@ static int scx_cpu_node_if_enabled(int cpu)
 	return cpu_to_node(cpu);
 }
 
-bool scx_idle_test_and_clear_cpu(int cpu)
+static bool scx_idle_test_and_clear_cpu(int cpu)
 {
 	int node = scx_cpu_node_if_enabled(cpu);
 	struct cpumask *idle_cpus = idle_cpumask(node)->cpu;
@@ -198,7 +198,7 @@ pick_idle_cpu_from_online_nodes(const struct cpumask *cpus_allowed, int node, u6
 /*
  * Find an idle CPU in the system, starting from @node.
  */
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
 {
 	s32 cpu;
 
@@ -794,6 +794,16 @@ static void reset_idle_masks(struct sched_ext_ops *ops)
 		cpumask_and(idle_cpumask(node)->smt, cpu_online_mask, node_mask);
 	}
 }
+#else	/* !CONFIG_SMP */
+static bool scx_idle_test_and_clear_cpu(int cpu)
+{
+	return -EBUSY;
+}
+
+static s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
+{
+	return -EBUSY;
+}
 #endif	/* CONFIG_SMP */
 
 void scx_idle_enable(struct sched_ext_ops *ops)
@@ -860,8 +870,34 @@ static bool check_builtin_idle_enabled(void)
 	return false;
 }
 
-s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-			  const struct cpumask *allowed, u64 flags)
+/*
+ * Determine whether @p is a migration-disabled task in the context of BPF
+ * code.
+ *
+ * We can't simply check whether @p->migration_disabled is set in a
+ * sched_ext callback, because migration is always disabled for the current
+ * task while running BPF code.
+ *
+ * The prolog (__bpf_prog_enter) and epilog (__bpf_prog_exit) respectively
+ * disable and re-enable migration. For this reason, the current task
+ * inside a sched_ext callback is always a migration-disabled task.
+ *
+ * Therefore, when @p->migration_disabled == 1, check whether @p is the
+ * current task or not: if it is, then migration was not disabled before
+ * entering the callback, otherwise migration was disabled.
+ *
+ * Returns true if @p is migration-disabled, false otherwise.
+ */
+static bool is_bpf_migration_disabled(const struct task_struct *p)
+{
+	if (p->migration_disabled == 1)
+		return p != current;
+	else
+		return p->migration_disabled;
+}
+
+static s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+				 const struct cpumask *allowed, u64 flags)
 {
 	struct rq *rq;
 	struct rq_flags rf;
@@ -903,7 +939,7 @@ s32 select_cpu_from_kfunc(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	 * selection optimizations and simply check whether the previously
 	 * used CPU is idle and within the allowed cpumask.
 	 */
-	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
+	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
 		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
 		    scx_idle_test_and_clear_cpu(prev_cpu))
 			cpu = prev_cpu;
@@ -1125,10 +1161,10 @@ __bpf_kfunc bool scx_bpf_test_and_clear_cpu_idle(s32 cpu)
 	if (!check_builtin_idle_enabled())
 		return false;
 
-	if (kf_cpu_valid(cpu, NULL))
-		return scx_idle_test_and_clear_cpu(cpu);
-	else
+	if (!kf_cpu_valid(cpu, NULL))
 		return false;
+
+	return scx_idle_test_and_clear_cpu(cpu);
 }
 
 /**
diff --git a/kernel/sched/ext_idle.h b/kernel/sched/ext_idle.h
index 37be78a7502b..05e389ed72e4 100644
--- a/kernel/sched/ext_idle.h
+++ b/kernel/sched/ext_idle.h
@@ -15,16 +15,9 @@ struct sched_ext_ops;
 #ifdef CONFIG_SMP
 void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops);
 void scx_idle_init_masks(void);
-bool scx_idle_test_and_clear_cpu(int cpu);
-s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags);
 #else /* !CONFIG_SMP */
 static inline void scx_idle_update_selcpu_topology(struct sched_ext_ops *ops) {}
 static inline void scx_idle_init_masks(void) {}
-static inline bool scx_idle_test_and_clear_cpu(int cpu) { return false; }
-static inline s32 scx_pick_idle_cpu(const struct cpumask *cpus_allowed, int node, u64 flags)
-{
-	return -EBUSY;
-}
 #endif /* CONFIG_SMP */
 
 s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index db40ec5cc9d7..9fb1a8c107ec 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	unsigned long bitmap;
 	unsigned long ret;
 	int offset;
+	int bit;
 	int i;
 
 	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
@@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
+	bit = ftrace_test_recursion_trylock(trace.func, ret);
+	/*
+	 * This can fail because ftrace_test_recursion_trylock() allows one nest
+	 * call. If we are already in a nested call, then we don't probe this and
+	 * just return the original return address.
+	 */
+	if (unlikely(bit < 0))
+		goto out;
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
@@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		}
 	}
 
+	ftrace_test_recursion_unlock(bit);
+out:
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index f9b3aa9afb17..342e84f8a40e 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -428,8 +428,9 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
 {
 	unsigned long *addrs;
 
-	if (alist->index >= alist->size)
-		return -ENOMEM;
+	/* Previously we failed to expand the list. */
+	if (alist->index == alist->size)
+		return -ENOSPC;
 
 	alist->addrs[alist->index++] = addr;
 	if (alist->index < alist->size)
@@ -489,7 +490,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
 		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
 
-	if (alist.index < alist.size && alist.index > 0)
+	if (alist.index > 0)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 5d64a18cacac..d06854bd32b3 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -230,6 +230,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = tracing_check_open_get_tr(NULL);
 	if (ret)
 		return ret;
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 337bc0eb5d71..dc734867f0fc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2325,12 +2325,13 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (count < 1)
 		return 0;
 
-	buf = kmalloc(count, GFP_KERNEL);
+	buf = kmalloc(count + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	if (copy_from_user(buf, ubuf, count))
 		return -EFAULT;
+	buf[count] = '\0';
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index 2f844c279a3e..7f24ccc896c6 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
 	 * freeing it below.
 	 */
 	wait_for_completion(&vtsk->exited);
+	put_task_struct(vtsk->task);
 	kfree(vtsk);
 }
 EXPORT_SYMBOL_GPL(vhost_task_stop);
@@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
 		return ERR_PTR(PTR_ERR(tsk));
 	}
 
-	vtsk->task = tsk;
+	vtsk->task = get_task_struct(tsk);
 	return vtsk;
 }
 EXPORT_SYMBOL_GPL(vhost_task_create);
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 57d4ec256682..04f121a756d4 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1576,12 +1576,14 @@ static int damon_sysfs_damon_call(int (*fn)(void *data),
 		struct damon_sysfs_kdamond *kdamond)
 {
 	struct damon_call_control call_control = {};
+	int err;
 
 	if (!kdamond->damon_ctx)
 		return -EINVAL;
 	call_control.fn = fn;
 	call_control.data = kdamond;
-	return damon_call(kdamond->damon_ctx, &call_control);
+	err = damon_call(kdamond->damon_ctx, &call_control);
+	return err ? err : call_control.return_code;
 }
 
 struct damon_sysfs_schemes_walk_data {
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 1ea711786c52..8bca7fece47f 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -195,7 +195,8 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 				      u32 origin, bool checked)
 {
 	u64 address = (u64)addr;
-	u32 *shadow_start, *origin_start;
+	void *shadow_start;
+	u32 *aligned_shadow, *origin_start;
 	size_t pad = 0;
 
 	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(addr, size));
@@ -214,9 +215,12 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	}
 	__memset(shadow_start, b, size);
 
-	if (!IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+	if (IS_ALIGNED(address, KMSAN_ORIGIN_SIZE)) {
+		aligned_shadow = shadow_start;
+	} else {
 		pad = address % KMSAN_ORIGIN_SIZE;
 		address -= pad;
+		aligned_shadow = shadow_start - pad;
 		size += pad;
 	}
 	size = ALIGN(size, KMSAN_ORIGIN_SIZE);
@@ -230,7 +234,7 @@ void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
 	 * corresponding shadow slot is zero.
 	 */
 	for (int i = 0; i < size / KMSAN_ORIGIN_SIZE; i++) {
-		if (origin || !shadow_start[i])
+		if (origin || !aligned_shadow[i])
 			origin_start[i] = origin;
 	}
 }
diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index c6c5b2bbede0..902ec48b1e3e 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -556,6 +556,21 @@ DEFINE_TEST_MEMSETXX(16)
 DEFINE_TEST_MEMSETXX(32)
 DEFINE_TEST_MEMSETXX(64)
 
+/* Test case: ensure that KMSAN does not access shadow memory out of bounds. */
+static void test_memset_on_guarded_buffer(struct kunit *test)
+{
+	void *buf = vmalloc(PAGE_SIZE);
+
+	kunit_info(test,
+		   "memset() on ends of guarded buffer should not crash\n");
+
+	for (size_t size = 0; size <= 128; size++) {
+		memset(buf, 0xff, size);
+		memset(buf + PAGE_SIZE - size, 0xff, size);
+	}
+	vfree(buf);
+}
+
 static noinline void fibonacci(int *array, int size, int start)
 {
 	if (start < 2 || (start == size))
@@ -677,6 +692,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
 	KUNIT_CASE(test_memset64),
+	KUNIT_CASE(test_memset_on_guarded_buffer),
 	KUNIT_CASE(test_long_origin_chain),
 	KUNIT_CASE(test_stackdepot_roundtrip),
 	KUNIT_CASE(test_unpoison_memory),
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 090c7ffa5152..2ef5b3004197 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3087,8 +3087,18 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then it must be receiver/slave role.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
-	if (!conn) {
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
@@ -4391,6 +4401,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "num %d", ev->num);
 
+	hci_dev_lock(hdev);
+
 	for (i = 0; i < ev->num; i++) {
 		struct hci_comp_pkts_info *info = &ev->handles[i];
 		struct hci_conn *conn;
@@ -4472,6 +4484,8 @@ static void hci_num_comp_pkts_evt(struct hci_dev *hdev, void *data,
 	}
 
 	queue_work(hdev->workqueue, &hdev->tx_work);
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_mode_change_evt(struct hci_dev *hdev, void *data,
@@ -5634,8 +5648,18 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
-	if (!conn) {
+	/* Check for existing connection:
+	 *
+	 * 1. If it doesn't exist then use the role to create a new object.
+	 * 2. If it does exist confirm that it is connecting/BT_CONNECT in case
+	 *    of initiator/master role since there could be a collision where
+	 *    either side is attempting to connect or something like a fuzzing
+	 *    testing is trying to play tricks to destroy the hcon object before
+	 *    it even attempts to connect (e.g. hcon->state == BT_OPEN).
+	 */
+	conn = hci_conn_hash_lookup_role(hdev, LE_LINK, role, bdaddr);
+	if (!conn ||
+	    (conn->role == HCI_ROLE_MASTER && conn->state != BT_CONNECT)) {
 		/* In case of error status and there is no connection pending
 		 * just unlock as there is nothing to cleanup.
 		 */
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a25439f1eeac..7ca544d7791f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2594,6 +2594,13 @@ static int hci_resume_advertising_sync(struct hci_dev *hdev)
 			hci_remove_ext_adv_instance_sync(hdev, adv->instance,
 							 NULL);
 		}
+
+		/* If current advertising instance is set to instance 0x00
+		 * then we need to re-enable it.
+		 */
+		if (!hdev->cur_adv_instance)
+			err = hci_enable_ext_advertising_sync(hdev,
+							      hdev->cur_adv_instance);
 	} else {
 		/* Schedule for most recent instance to be restarted and begin
 		 * the software rotation loop
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 50634ef5c8b7..225140fcb3d6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1323,8 +1323,7 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 	struct mgmt_mode *cp;
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
 		return;
 
 	cp = cmd->param;
@@ -1351,23 +1350,29 @@ static void mgmt_set_powered_complete(struct hci_dev *hdev, void *data, int err)
 				mgmt_status(err));
 	}
 
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int set_powered_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp;
+	struct mgmt_mode cp;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
 
 	/* Make sure cmd still outstanding. */
-	if (cmd != pending_find(MGMT_OP_SET_POWERED, hdev))
+	if (!__mgmt_pending_listed(hdev, cmd)) {
+		mutex_unlock(&hdev->mgmt_pending_lock);
 		return -ECANCELED;
+	}
 
-	cp = cmd->param;
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
 
 	BT_DBG("%s", hdev->name);
 
-	return hci_set_powered_sync(hdev, cp->val);
+	return hci_set_powered_sync(hdev, cp.val);
 }
 
 static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -1516,8 +1521,7 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "err %d", err);
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1539,12 +1543,15 @@ static void mgmt_set_discoverable_complete(struct hci_dev *hdev, void *data,
 	new_settings(hdev, cmd->sk);
 
 done:
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 	hci_dev_unlock(hdev);
 }
 
 static int set_discoverable_sync(struct hci_dev *hdev, void *data)
 {
+	if (!mgmt_pending_listed(hdev, data))
+		return -ECANCELED;
+
 	BT_DBG("%s", hdev->name);
 
 	return hci_update_discoverable_sync(hdev);
@@ -1691,8 +1698,7 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "err %d", err);
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
 		return;
 
 	hci_dev_lock(hdev);
@@ -1707,7 +1713,7 @@ static void mgmt_set_connectable_complete(struct hci_dev *hdev, void *data,
 	new_settings(hdev, cmd->sk);
 
 done:
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_dev_unlock(hdev);
 }
@@ -1743,6 +1749,9 @@ static int set_connectable_update_settings(struct hci_dev *hdev,
 
 static int set_connectable_sync(struct hci_dev *hdev, void *data)
 {
+	if (!mgmt_pending_listed(hdev, data))
+		return -ECANCELED;
+
 	BT_DBG("%s", hdev->name);
 
 	return hci_update_connectable_sync(hdev);
@@ -1919,14 +1928,17 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct cmd_lookup match = { NULL, hdev };
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp = cmd->param;
-	u8 enable = cp->val;
+	struct mgmt_mode *cp;
+	u8 enable;
 	bool changed;
 
 	/* Make sure cmd still outstanding. */
-	if (err == -ECANCELED || cmd != pending_find(MGMT_OP_SET_SSP, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
 		return;
 
+	cp = cmd->param;
+	enable = cp->val;
+
 	if (err) {
 		u8 mgmt_err = mgmt_status(err);
 
@@ -1935,8 +1947,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 			new_settings(hdev, NULL);
 		}
 
-		mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, true,
-				     cmd_status_rsp, &mgmt_err);
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
 		return;
 	}
 
@@ -1946,7 +1957,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 		changed = hci_dev_test_and_clear_flag(hdev, HCI_SSP_ENABLED);
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_SSP, hdev, true, settings_rsp, &match);
+	settings_rsp(cmd, &match);
 
 	if (changed)
 		new_settings(hdev, match.sk);
@@ -1960,14 +1971,25 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 static int set_ssp_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp = cmd->param;
+	struct mgmt_mode cp;
 	bool changed = false;
 	int err;
 
-	if (cp->val)
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	if (!__mgmt_pending_listed(hdev, cmd)) {
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return -ECANCELED;
+	}
+
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	if (cp.val)
 		changed = !hci_dev_test_and_set_flag(hdev, HCI_SSP_ENABLED);
 
-	err = hci_write_ssp_mode_sync(hdev, cp->val);
+	err = hci_write_ssp_mode_sync(hdev, cp.val);
 
 	if (!err && changed)
 		hci_dev_clear_flag(hdev, HCI_SSP_ENABLED);
@@ -2060,32 +2082,50 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 static void set_le_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct mgmt_pending_cmd *cmd = data;
 	struct cmd_lookup match = { NULL, hdev };
 	u8 status = mgmt_status(err);
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (status) {
-		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, true, cmd_status_rsp,
-				     &status);
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, data))
 		return;
+
+	if (status) {
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, status);
+		goto done;
 	}
 
-	mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, true, settings_rsp, &match);
+	settings_rsp(cmd, &match);
 
 	new_settings(hdev, match.sk);
 
 	if (match.sk)
 		sock_put(match.sk);
+
+done:
+	mgmt_pending_free(cmd);
 }
 
 static int set_le_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp = cmd->param;
-	u8 val = !!cp->val;
+	struct mgmt_mode cp;
+	u8 val;
 	int err;
 
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	if (!__mgmt_pending_listed(hdev, cmd)) {
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return -ECANCELED;
+	}
+
+	memcpy(&cp, cmd->param, sizeof(cp));
+	val = !!cp.val;
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
 	if (!val) {
 		hci_clear_adv_instance_sync(hdev, NULL, 0x00, true);
 
@@ -2127,7 +2167,12 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 	u8 status = mgmt_status(err);
-	struct sock *sk = cmd->sk;
+	struct sock *sk;
+
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
+		return;
+
+	sk = cmd->sk;
 
 	if (status) {
 		mgmt_pending_foreach(MGMT_OP_SET_MESH_RECEIVER, hdev, true,
@@ -2142,24 +2187,37 @@ static void set_mesh_complete(struct hci_dev *hdev, void *data, int err)
 static int set_mesh_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_mesh *cp = cmd->param;
-	size_t len = cmd->param_len;
+	struct mgmt_cp_set_mesh cp;
+	size_t len;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	if (!__mgmt_pending_listed(hdev, cmd)) {
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return -ECANCELED;
+	}
+
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	len = cmd->param_len;
 
 	memset(hdev->mesh_ad_types, 0, sizeof(hdev->mesh_ad_types));
 
-	if (cp->enable)
+	if (cp.enable)
 		hci_dev_set_flag(hdev, HCI_MESH);
 	else
 		hci_dev_clear_flag(hdev, HCI_MESH);
 
-	hdev->le_scan_interval = __le16_to_cpu(cp->period);
-	hdev->le_scan_window = __le16_to_cpu(cp->window);
+	hdev->le_scan_interval = __le16_to_cpu(cp.period);
+	hdev->le_scan_window = __le16_to_cpu(cp.window);
 
-	len -= sizeof(*cp);
+	len -= sizeof(cp);
 
 	/* If filters don't fit, forward all adv pkts */
 	if (len <= sizeof(hdev->mesh_ad_types))
-		memcpy(hdev->mesh_ad_types, cp->ad_types, len);
+		memcpy(hdev->mesh_ad_types, cp.ad_types, len);
 
 	hci_update_passive_scan_sync(hdev);
 	return 0;
@@ -3867,15 +3925,16 @@ static int name_changed_sync(struct hci_dev *hdev, void *data)
 static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_local_name *cp = cmd->param;
+	struct mgmt_cp_set_local_name *cp;
 	u8 status = mgmt_status(err);
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_LOCAL_NAME, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
 		return;
 
+	cp = cmd->param;
+
 	if (status) {
 		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
 				status);
@@ -3887,16 +3946,27 @@ static void set_name_complete(struct hci_dev *hdev, void *data, int err)
 			hci_cmd_sync_queue(hdev, name_changed_sync, NULL, NULL);
 	}
 
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int set_name_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_cp_set_local_name *cp = cmd->param;
+	struct mgmt_cp_set_local_name cp;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	if (!__mgmt_pending_listed(hdev, cmd)) {
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return -ECANCELED;
+	}
+
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
 
 	if (lmp_bredr_capable(hdev)) {
-		hci_update_name_sync(hdev, cp->name);
+		hci_update_name_sync(hdev, cp.name);
 		hci_update_eir_sync(hdev);
 	}
 
@@ -4048,12 +4118,10 @@ int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip)
 static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct sk_buff *skb = cmd->skb;
+	struct sk_buff *skb;
 	u8 status = mgmt_status(err);
 
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_SET_PHY_CONFIGURATION, hdev))
-		return;
+	skb = cmd->skb;
 
 	if (!status) {
 		if (!skb)
@@ -4080,7 +4148,7 @@ static void set_default_phy_complete(struct hci_dev *hdev, void *data, int err)
 	if (skb && !IS_ERR(skb))
 		kfree_skb(skb);
 
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int set_default_phy_sync(struct hci_dev *hdev, void *data)
@@ -4088,7 +4156,9 @@ static int set_default_phy_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_cp_set_phy_configuration *cp = cmd->param;
 	struct hci_cp_le_set_default_phy cp_phy;
-	u32 selected_phys = __le32_to_cpu(cp->selected_phys);
+	u32 selected_phys;
+
+	selected_phys = __le32_to_cpu(cp->selected_phys);
 
 	memset(&cp_phy, 0, sizeof(cp_phy));
 
@@ -4228,7 +4298,7 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_SET_PHY_CONFIGURATION, hdev, data,
+	cmd = mgmt_pending_new(sk, MGMT_OP_SET_PHY_CONFIGURATION, hdev, data,
 			       len);
 	if (!cmd)
 		err = -ENOMEM;
@@ -5189,7 +5259,17 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 {
 	struct mgmt_rp_add_adv_patterns_monitor rp;
 	struct mgmt_pending_cmd *cmd = data;
-	struct adv_monitor *monitor = cmd->user_data;
+	struct adv_monitor *monitor;
+
+	/* This is likely the result of hdev being closed and mgmt_index_removed
+	 * is attempting to clean up any pending command so
+	 * hci_adv_monitors_clear is about to be called which will take care of
+	 * freeing the adv_monitor instances.
+	 */
+	if (status == -ECANCELED && !mgmt_pending_valid(hdev, cmd))
+		return;
+
+	monitor = cmd->user_data;
 
 	hci_dev_lock(hdev);
 
@@ -5215,9 +5295,20 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
 static int mgmt_add_adv_patterns_monitor_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct adv_monitor *monitor = cmd->user_data;
+	struct adv_monitor *mon;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	if (!__mgmt_pending_listed(hdev, cmd)) {
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return -ECANCELED;
+	}
+
+	mon = cmd->user_data;
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
 
-	return hci_add_adv_monitor(hdev, monitor);
+	return hci_add_adv_monitor(hdev, mon);
 }
 
 static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
@@ -5484,7 +5575,8 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
 			       status);
 }
 
-static void read_local_oob_data_complete(struct hci_dev *hdev, void *data, int err)
+static void read_local_oob_data_complete(struct hci_dev *hdev, void *data,
+					 int err)
 {
 	struct mgmt_rp_read_local_oob_data mgmt_rp;
 	size_t rp_size = sizeof(mgmt_rp);
@@ -5504,7 +5596,8 @@ static void read_local_oob_data_complete(struct hci_dev *hdev, void *data, int e
 	bt_dev_dbg(hdev, "status %d", status);
 
 	if (status) {
-		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA, status);
+		mgmt_cmd_status(cmd->sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
+				status);
 		goto remove;
 	}
 
@@ -5786,17 +5879,12 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
-	if (err == -ECANCELED)
-		return;
-
-	if (cmd != pending_find(MGMT_OP_START_DISCOVERY, hdev) &&
-	    cmd != pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev) &&
-	    cmd != pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
 		return;
 
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	hci_discovery_set_state(hdev, err ? DISCOVERY_STOPPED:
 				DISCOVERY_FINDING);
@@ -5804,6 +5892,9 @@ static void start_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 static int start_discovery_sync(struct hci_dev *hdev, void *data)
 {
+	if (!mgmt_pending_listed(hdev, data))
+		return -ECANCELED;
+
 	return hci_start_discovery_sync(hdev);
 }
 
@@ -6009,15 +6100,14 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 {
 	struct mgmt_pending_cmd *cmd = data;
 
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_STOP_DISCOVERY, hdev))
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, cmd))
 		return;
 
 	bt_dev_dbg(hdev, "err %d", err);
 
 	mgmt_cmd_complete(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_status(err),
 			  cmd->param, 1);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 
 	if (!err)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -6025,6 +6115,9 @@ static void stop_discovery_complete(struct hci_dev *hdev, void *data, int err)
 
 static int stop_discovery_sync(struct hci_dev *hdev, void *data)
 {
+	if (!mgmt_pending_listed(hdev, data))
+		return -ECANCELED;
+
 	return hci_stop_discovery_sync(hdev);
 }
 
@@ -6234,14 +6327,18 @@ static void enable_advertising_instance(struct hci_dev *hdev, int err)
 
 static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 {
+	struct mgmt_pending_cmd *cmd = data;
 	struct cmd_lookup match = { NULL, hdev };
 	u8 instance;
 	struct adv_info *adv_instance;
 	u8 status = mgmt_status(err);
 
+	if (err == -ECANCELED || !mgmt_pending_valid(hdev, data))
+		return;
+
 	if (status) {
-		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, true,
-				     cmd_status_rsp, &status);
+		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, status);
+		mgmt_pending_free(cmd);
 		return;
 	}
 
@@ -6250,8 +6347,7 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 	else
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
-	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, true, settings_rsp,
-			     &match);
+	settings_rsp(cmd, &match);
 
 	new_settings(hdev, match.sk);
 
@@ -6283,10 +6379,23 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 static int set_adv_sync(struct hci_dev *hdev, void *data)
 {
 	struct mgmt_pending_cmd *cmd = data;
-	struct mgmt_mode *cp = cmd->param;
-	u8 val = !!cp->val;
+	struct mgmt_mode cp;
+	u8 val;
 
-	if (cp->val == 0x02)
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	if (!__mgmt_pending_listed(hdev, cmd)) {
+		mutex_unlock(&hdev->mgmt_pending_lock);
+		return -ECANCELED;
+	}
+
+	memcpy(&cp, cmd->param, sizeof(cp));
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	val = !!cp.val;
+
+	if (cp.val == 0x02)
 		hci_dev_set_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
 	else
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
@@ -8039,10 +8148,6 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 	u8 status = mgmt_status(err);
 	u16 eir_len;
 
-	if (err == -ECANCELED ||
-	    cmd != pending_find(MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev))
-		return;
-
 	if (!status) {
 		if (!skb)
 			status = MGMT_STATUS_FAILED;
@@ -8149,7 +8254,7 @@ static void read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
 		kfree_skb(skb);
 
 	kfree(mgmt_rp);
-	mgmt_pending_remove(cmd);
+	mgmt_pending_free(cmd);
 }
 
 static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
@@ -8158,7 +8263,7 @@ static int read_local_ssp_oob_req(struct hci_dev *hdev, struct sock *sk,
 	struct mgmt_pending_cmd *cmd;
 	int err;
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev,
+	cmd = mgmt_pending_new(sk, MGMT_OP_READ_LOCAL_OOB_EXT_DATA, hdev,
 			       cp, sizeof(*cp));
 	if (!cmd)
 		return -ENOMEM;
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index a88a07da3947..aa7b5585cb26 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -320,6 +320,52 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 	mgmt_pending_free(cmd);
 }
 
+bool __mgmt_pending_listed(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd)
+{
+	struct mgmt_pending_cmd *tmp;
+
+	lockdep_assert_held(&hdev->mgmt_pending_lock);
+
+	if (!cmd)
+		return false;
+
+	list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
+		if (cmd == tmp)
+			return true;
+	}
+
+	return false;
+}
+
+bool mgmt_pending_listed(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd)
+{
+	bool listed;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+	listed = __mgmt_pending_listed(hdev, cmd);
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return listed;
+}
+
+bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd)
+{
+	bool listed;
+
+	if (!cmd)
+		return false;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	listed = __mgmt_pending_listed(hdev, cmd);
+	if (listed)
+		list_del(&cmd->list);
+
+	mutex_unlock(&hdev->mgmt_pending_lock);
+
+	return listed;
+}
+
 void mgmt_mesh_foreach(struct hci_dev *hdev,
 		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
 		       void *data, struct sock *sk)
diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
index 024e51dd6937..bcba8c9d8952 100644
--- a/net/bluetooth/mgmt_util.h
+++ b/net/bluetooth/mgmt_util.h
@@ -65,6 +65,9 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock *sk, u16 opcode,
 					  void *data, u16 len);
 void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
 void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
+bool __mgmt_pending_listed(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd);
+bool mgmt_pending_listed(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd);
+bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd);
 void mgmt_mesh_foreach(struct hci_dev *hdev,
 		       void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *data),
 		       void *data, struct sock *sk);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d6420b74ea9c..cb77bb84371b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6667,7 +6667,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 		return NULL;
 
 	while (data_len) {
-		if (nr_frags == MAX_SKB_FRAGS - 1)
+		if (nr_frags == MAX_SKB_FRAGS)
 			goto failure;
 		while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
 			order--;
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 4397e89d3123..423f876d14c6 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2400,6 +2400,13 @@ static int replace_nexthop_single(struct net *net, struct nexthop *old,
 		return -EINVAL;
 	}
 
+	if (!list_empty(&old->grp_list) &&
+	    rtnl_dereference(new->nh_info)->fdb_nh !=
+	    rtnl_dereference(old->nh_info)->fdb_nh) {
+		NL_SET_ERR_MSG(extack, "Cannot change nexthop FDB status while in a group");
+		return -EINVAL;
+	}
+
 	err = call_nexthop_notifiers(net, NEXTHOP_EVENT_REPLACE, new, extack);
 	if (err)
 		return err;
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 3c5f64ca4115..85f0b7853b17 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -56,6 +56,7 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 {
 	struct smc_lo_dmb_node *dmb_node, *tmp_node;
 	struct smc_lo_dev *ldev = smcd->priv;
+	struct folio *folio;
 	int sba_idx, rc;
 
 	/* check space for new dmb */
@@ -74,13 +75,16 @@ static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
 
 	dmb_node->sba_idx = sba_idx;
 	dmb_node->len = dmb->dmb_len;
-	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
-				     __GFP_NOWARN | __GFP_NORETRY |
-				     __GFP_NOMEMALLOC);
-	if (!dmb_node->cpu_addr) {
+
+	/* not critical; fail under memory pressure and fallback to TCP */
+	folio = folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
+			    __GFP_NORETRY | __GFP_ZERO,
+			    get_order(dmb_node->len));
+	if (!folio) {
 		rc = -ENOMEM;
 		goto err_node;
 	}
+	dmb_node->cpu_addr = folio_address(folio);
 	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
 	refcount_set(&dmb_node->refcnt, 1);
 
@@ -122,7 +126,7 @@ static void __smc_lo_unregister_dmb(struct smc_lo_dev *ldev,
 	write_unlock_bh(&ldev->dmb_ht_lock);
 
 	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
-	kvfree(dmb_node->cpu_addr);
+	folio_put(virt_to_folio(dmb_node->cpu_addr));
 	kfree(dmb_node);
 
 	if (atomic_dec_and_test(&ldev->dmb_cnt))
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index c7a1f080d2de..44b9de6e4e77 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
-	switch (x->props.family) {
+	switch (x->inner_mode.family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 86337453709b..4b2eb260f5c2 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2578,6 +2578,8 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 
 	for (h = 0; h < range; h++) {
 		u32 spi = (low == high) ? low : get_random_u32_inclusive(low, high);
+		if (spi == 0)
+			goto next;
 		newspi = htonl(spi);
 
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -2593,6 +2595,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		xfrm_state_put(x0);
 		spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
+next:
 		if (signal_pending(current)) {
 			err = -ERESTARTSYS;
 			goto unlock;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4819bd332f03..fa28e3e85861 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7298,6 +7298,11 @@ static void cs35l41_fixup_spi_two(struct hda_codec *codec, const struct hda_fixu
 	comp_generic_fixup(codec, action, "spi", "CSC3551", "-%s:00-cs35l41-hda.%d", 2);
 }
 
+static void cs35l41_fixup_spi_one(struct hda_codec *codec, const struct hda_fixup *fix, int action)
+{
+	comp_generic_fixup(codec, action, "spi", "CSC3551", "-%s:00-cs35l41-hda.%d", 1);
+}
+
 static void cs35l41_fixup_spi_four(struct hda_codec *codec, const struct hda_fixup *fix, int action)
 {
 	comp_generic_fixup(codec, action, "spi", "CSC3551", "-%s:00-cs35l41-hda.%d", 4);
@@ -7991,6 +7996,7 @@ enum {
 	ALC287_FIXUP_CS35L41_I2C_2,
 	ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED,
 	ALC287_FIXUP_CS35L41_I2C_4,
+	ALC245_FIXUP_CS35L41_SPI_1,
 	ALC245_FIXUP_CS35L41_SPI_2,
 	ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED,
 	ALC245_FIXUP_CS35L41_SPI_4,
@@ -10120,6 +10126,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_spi_two,
 	},
+	[ALC245_FIXUP_CS35L41_SPI_1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_spi_one,
+	},
 	[ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cs35l41_fixup_spi_two,
@@ -11099,6 +11109,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x8398, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x8516, "ASUS X101CH", ALC269_FIXUP_ASUS_X101),
+	SND_PCI_QUIRK(0x1043, 0x88f4, "ASUS NUC14LNS", ALC245_FIXUP_CS35L41_SPI_1),
 	SND_PCI_QUIRK(0x104d, 0x9073, "Sony VAIO", ALC275_FIXUP_SONY_VAIO_GPIO2),
 	SND_PCI_QUIRK(0x104d, 0x907b, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
 	SND_PCI_QUIRK(0x104d, 0x9084, "Sony VAIO", ALC275_FIXUP_SONY_HWEQ),
diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index a0b3679b17b4..1211a2b8a2a2 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -826,6 +826,16 @@ static const struct platform_device_id board_ids[] = {
 					SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK |
 					SOF_ES8336_JD_INVERTED),
 	},
+	{
+		.name = "ptl_es83x6_c1_h02",
+		.driver_data = (kernel_ulong_t)(SOF_ES8336_SSP_CODEC(1) |
+					SOF_NO_OF_HDMI_CAPTURE_SSP(2) |
+					SOF_HDMI_CAPTURE_1_SSP(0) |
+					SOF_HDMI_CAPTURE_2_SSP(2) |
+					SOF_SSP_HDMI_CAPTURE_PRESENT |
+					SOF_ES8336_SPEAKERS_EN_GPIO1_QUIRK |
+					SOF_ES8336_JD_INVERTED),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index f5925bd0a3fc..4994aaccc583 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -892,6 +892,13 @@ static const struct platform_device_id board_ids[] = {
 					SOF_SSP_PORT_BT_OFFLOAD(2) |
 					SOF_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.name = "ptl_rt5682_c1_h02",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_SSP_PORT_CODEC(1) |
+					/* SSP 0 and SSP 2 are used for HDMI IN */
+					SOF_SSP_MASK_HDMI_CAPTURE(0x5)),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index eae75f3f0fa4..d90d8672ab77 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -21,7 +21,24 @@ static const struct snd_soc_acpi_codecs ptl_rt5682_rt5682s_hp = {
 	.codecs = {RT5682_ACPI_HID, RT5682S_ACPI_HID},
 };
 
+static const struct snd_soc_acpi_codecs ptl_essx_83x6 = {
+	.num_codecs = 3,
+	.codecs = { "ESSX8316", "ESSX8326", "ESSX8336"},
+};
+
+static const struct snd_soc_acpi_codecs ptl_lt6911_hdmi = {
+	.num_codecs = 1,
+	.codecs = {"INTC10B0"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_machines[] = {
+	{
+		.comp_ids = &ptl_rt5682_rt5682s_hp,
+		.drv_name = "ptl_rt5682_c1_h02",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &ptl_lt6911_hdmi,
+		.sof_tplg_filename = "sof-ptl-rt5682-ssp1-hdmi-ssp02.tplg",
+	},
 	{
 		.comp_ids = &ptl_rt5682_rt5682s_hp,
 		.drv_name = "ptl_rt5682_def",
@@ -29,6 +46,21 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_machines[] = {
 		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_AMP_NAME |
 					SND_SOC_ACPI_TPLG_INTEL_CODEC_NAME,
 	},
+	{
+		.comp_ids = &ptl_essx_83x6,
+		.drv_name = "ptl_es83x6_c1_h02",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &ptl_lt6911_hdmi,
+		.sof_tplg_filename = "sof-ptl-es83x6-ssp1-hdmi-ssp02.tplg",
+	},
+	{
+		.comp_ids = &ptl_essx_83x6,
+		.drv_name = "sof-essx8336",
+		.sof_tplg_filename = "sof-ptl-es8336", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_SSP_NUMBER |
+					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
+					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_machines);
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index 9530c59b3cf4..3df537fdb9f1 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/hid.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -55,13 +56,13 @@ struct std_mono_table {
  * version, we keep it mono for simplicity.
  */
 static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
-				unsigned int unitid,
-				unsigned int control,
-				unsigned int cmask,
-				int val_type,
-				unsigned int idx_off,
-				const char *name,
-				snd_kcontrol_tlv_rw_t *tlv_callback)
+					  unsigned int unitid,
+					  unsigned int control,
+					  unsigned int cmask,
+					  int val_type,
+					  unsigned int idx_off,
+					  const char *name,
+					  snd_kcontrol_tlv_rw_t *tlv_callback)
 {
 	struct usb_mixer_elem_info *cval;
 	struct snd_kcontrol *kctl;
@@ -78,7 +79,8 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 	cval->idx_off = idx_off;
 
 	/* get_min_max() is called only for integer volumes later,
-	 * so provide a short-cut for booleans */
+	 * so provide a short-cut for booleans
+	 */
 	cval->min = 0;
 	cval->max = 1;
 	cval->res = 0;
@@ -108,15 +110,16 @@ static int snd_create_std_mono_ctl_offset(struct usb_mixer_interface *mixer,
 }
 
 static int snd_create_std_mono_ctl(struct usb_mixer_interface *mixer,
-				unsigned int unitid,
-				unsigned int control,
-				unsigned int cmask,
-				int val_type,
-				const char *name,
-				snd_kcontrol_tlv_rw_t *tlv_callback)
+				   unsigned int unitid,
+				   unsigned int control,
+				   unsigned int cmask,
+				   int val_type,
+				   const char *name,
+				   snd_kcontrol_tlv_rw_t *tlv_callback)
 {
 	return snd_create_std_mono_ctl_offset(mixer, unitid, control, cmask,
-		val_type, 0 /* Offset */, name, tlv_callback);
+					      val_type, 0 /* Offset */,
+					      name, tlv_callback);
 }
 
 /*
@@ -127,9 +130,10 @@ static int snd_create_std_mono_table(struct usb_mixer_interface *mixer,
 {
 	int err;
 
-	while (t->name != NULL) {
+	while (t->name) {
 		err = snd_create_std_mono_ctl(mixer, t->unitid, t->control,
-				t->cmask, t->val_type, t->name, t->tlv_callback);
+					      t->cmask, t->val_type, t->name,
+					      t->tlv_callback);
 		if (err < 0)
 			return err;
 		t++;
@@ -209,12 +213,11 @@ static void snd_usb_soundblaster_remote_complete(struct urb *urb)
 	if (code == rc->mute_code)
 		snd_usb_mixer_notify_id(mixer, rc->mute_mixer_id);
 	mixer->rc_code = code;
-	wmb();
 	wake_up(&mixer->rc_waitq);
 }
 
 static long snd_usb_sbrc_hwdep_read(struct snd_hwdep *hw, char __user *buf,
-				     long count, loff_t *offset)
+				    long count, loff_t *offset)
 {
 	struct usb_mixer_interface *mixer = hw->private_data;
 	int err;
@@ -234,7 +237,7 @@ static long snd_usb_sbrc_hwdep_read(struct snd_hwdep *hw, char __user *buf,
 }
 
 static __poll_t snd_usb_sbrc_hwdep_poll(struct snd_hwdep *hw, struct file *file,
-					    poll_table *wait)
+					poll_table *wait)
 {
 	struct usb_mixer_interface *mixer = hw->private_data;
 
@@ -285,7 +288,7 @@ static int snd_usb_soundblaster_remote_init(struct usb_mixer_interface *mixer)
 	mixer->rc_setup_packet->wLength = cpu_to_le16(len);
 	usb_fill_control_urb(mixer->rc_urb, mixer->chip->dev,
 			     usb_rcvctrlpipe(mixer->chip->dev, 0),
-			     (u8*)mixer->rc_setup_packet, mixer->rc_buffer, len,
+			     (u8 *)mixer->rc_setup_packet, mixer->rc_buffer, len,
 			     snd_usb_soundblaster_remote_complete, mixer);
 	return 0;
 }
@@ -310,20 +313,20 @@ static int snd_audigy2nx_led_update(struct usb_mixer_interface *mixer,
 
 	if (chip->usb_id == USB_ID(0x041e, 0x3042))
 		err = snd_usb_ctl_msg(chip->dev,
-			      usb_sndctrlpipe(chip->dev, 0), 0x24,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			      !value, 0, NULL, 0);
+				      usb_sndctrlpipe(chip->dev, 0), 0x24,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				      !value, 0, NULL, 0);
 	/* USB X-Fi S51 Pro */
 	if (chip->usb_id == USB_ID(0x041e, 0x30df))
 		err = snd_usb_ctl_msg(chip->dev,
-			      usb_sndctrlpipe(chip->dev, 0), 0x24,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			      !value, 0, NULL, 0);
+				      usb_sndctrlpipe(chip->dev, 0), 0x24,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				      !value, 0, NULL, 0);
 	else
 		err = snd_usb_ctl_msg(chip->dev,
-			      usb_sndctrlpipe(chip->dev, 0), 0x24,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			      value, index + 2, NULL, 0);
+				      usb_sndctrlpipe(chip->dev, 0), 0x24,
+				      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+				      value, index + 2, NULL, 0);
 	snd_usb_unlock_shutdown(chip);
 	return err;
 }
@@ -377,17 +380,17 @@ static int snd_audigy2nx_controls_create(struct usb_mixer_interface *mixer)
 		struct snd_kcontrol_new knew;
 
 		/* USB X-Fi S51 doesn't have a CMSS LED */
-		if ((mixer->chip->usb_id == USB_ID(0x041e, 0x3042)) && i == 0)
+		if (mixer->chip->usb_id == USB_ID(0x041e, 0x3042) && i == 0)
 			continue;
 		/* USB X-Fi S51 Pro doesn't have one either */
-		if ((mixer->chip->usb_id == USB_ID(0x041e, 0x30df)) && i == 0)
+		if (mixer->chip->usb_id == USB_ID(0x041e, 0x30df) && i == 0)
 			continue;
 		if (i > 1 && /* Live24ext has 2 LEDs only */
 			(mixer->chip->usb_id == USB_ID(0x041e, 0x3040) ||
 			 mixer->chip->usb_id == USB_ID(0x041e, 0x3042) ||
 			 mixer->chip->usb_id == USB_ID(0x041e, 0x30df) ||
 			 mixer->chip->usb_id == USB_ID(0x041e, 0x3048)))
-			break; 
+			break;
 
 		knew = snd_audigy2nx_control;
 		knew.name = snd_audigy2nx_led_names[i];
@@ -481,9 +484,9 @@ static int snd_emu0204_ch_switch_update(struct usb_mixer_interface *mixer,
 	buf[0] = 0x01;
 	buf[1] = value ? 0x02 : 0x01;
 	err = snd_usb_ctl_msg(chip->dev,
-		      usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
-		      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
-		      0x0400, 0x0e00, buf, 2);
+			      usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
+			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
+			      0x0400, 0x0e00, buf, 2);
 	snd_usb_unlock_shutdown(chip);
 	return err;
 }
@@ -529,6 +532,265 @@ static int snd_emu0204_controls_create(struct usb_mixer_interface *mixer)
 					  &snd_emu0204_control, NULL);
 }
 
+#if IS_REACHABLE(CONFIG_INPUT)
+/*
+ * Sony DualSense controller (PS5) jack detection
+ *
+ * Since this is an UAC 1 device, it doesn't support jack detection.
+ * However, the controller hid-playstation driver reports HP & MIC
+ * insert events through a dedicated input device.
+ */
+
+#define SND_DUALSENSE_JACK_OUT_TERM_ID 3
+#define SND_DUALSENSE_JACK_IN_TERM_ID 4
+
+struct dualsense_mixer_elem_info {
+	struct usb_mixer_elem_info info;
+	struct input_handler ih;
+	struct input_device_id id_table[2];
+	bool connected;
+};
+
+static void snd_dualsense_ih_event(struct input_handle *handle,
+				   unsigned int type, unsigned int code,
+				   int value)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_mixer_elem_list *me;
+
+	if (type != EV_SW)
+		return;
+
+	mei = container_of(handle->handler, struct dualsense_mixer_elem_info, ih);
+	me = &mei->info.head;
+
+	if ((me->id == SND_DUALSENSE_JACK_OUT_TERM_ID && code == SW_HEADPHONE_INSERT) ||
+	    (me->id == SND_DUALSENSE_JACK_IN_TERM_ID && code == SW_MICROPHONE_INSERT)) {
+		mei->connected = !!value;
+		snd_ctl_notify(me->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &me->kctl->id);
+	}
+}
+
+static bool snd_dualsense_ih_match(struct input_handler *handler,
+				   struct input_dev *dev)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_device *snd_dev;
+	char *input_dev_path, *usb_dev_path;
+	size_t usb_dev_path_len;
+	bool match = false;
+
+	mei = container_of(handler, struct dualsense_mixer_elem_info, ih);
+	snd_dev = mei->info.head.mixer->chip->dev;
+
+	input_dev_path = kobject_get_path(&dev->dev.kobj, GFP_KERNEL);
+	if (!input_dev_path) {
+		dev_warn(&snd_dev->dev, "Failed to get input dev path\n");
+		return false;
+	}
+
+	usb_dev_path = kobject_get_path(&snd_dev->dev.kobj, GFP_KERNEL);
+	if (!usb_dev_path) {
+		dev_warn(&snd_dev->dev, "Failed to get USB dev path\n");
+		goto free_paths;
+	}
+
+	/*
+	 * Ensure the VID:PID matched input device supposedly owned by the
+	 * hid-playstation driver belongs to the actual hardware handled by
+	 * the current USB audio device, which implies input_dev_path being
+	 * a subpath of usb_dev_path.
+	 *
+	 * This verification is necessary when there is more than one identical
+	 * controller attached to the host system.
+	 */
+	usb_dev_path_len = strlen(usb_dev_path);
+	if (usb_dev_path_len >= strlen(input_dev_path))
+		goto free_paths;
+
+	usb_dev_path[usb_dev_path_len] = '/';
+	match = !memcmp(input_dev_path, usb_dev_path, usb_dev_path_len + 1);
+
+free_paths:
+	kfree(input_dev_path);
+	kfree(usb_dev_path);
+
+	return match;
+}
+
+static int snd_dualsense_ih_connect(struct input_handler *handler,
+				    struct input_dev *dev,
+				    const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int err;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = handler->name;
+
+	err = input_register_handle(handle);
+	if (err)
+		goto err_free;
+
+	err = input_open_device(handle);
+	if (err)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	input_unregister_handle(handle);
+err_free:
+	kfree(handle);
+	return err;
+}
+
+static void snd_dualsense_ih_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static void snd_dualsense_ih_start(struct input_handle *handle)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct usb_mixer_elem_list *me;
+	int status = -1;
+
+	mei = container_of(handle->handler, struct dualsense_mixer_elem_info, ih);
+	me = &mei->info.head;
+
+	if (me->id == SND_DUALSENSE_JACK_OUT_TERM_ID &&
+	    test_bit(SW_HEADPHONE_INSERT, handle->dev->swbit))
+		status = test_bit(SW_HEADPHONE_INSERT, handle->dev->sw);
+	else if (me->id == SND_DUALSENSE_JACK_IN_TERM_ID &&
+		 test_bit(SW_MICROPHONE_INSERT, handle->dev->swbit))
+		status = test_bit(SW_MICROPHONE_INSERT, handle->dev->sw);
+
+	if (status >= 0) {
+		mei->connected = !!status;
+		snd_ctl_notify(me->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+			       &me->kctl->id);
+	}
+}
+
+static int snd_dualsense_jack_get(struct snd_kcontrol *kctl,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct dualsense_mixer_elem_info *mei = snd_kcontrol_chip(kctl);
+
+	ucontrol->value.integer.value[0] = mei->connected;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new snd_dualsense_jack_control = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.info = snd_ctl_boolean_mono_info,
+	.get = snd_dualsense_jack_get,
+};
+
+static int snd_dualsense_resume_jack(struct usb_mixer_elem_list *list)
+{
+	snd_ctl_notify(list->mixer->chip->card, SNDRV_CTL_EVENT_MASK_VALUE,
+		       &list->kctl->id);
+	return 0;
+}
+
+static void snd_dualsense_mixer_elem_free(struct snd_kcontrol *kctl)
+{
+	struct dualsense_mixer_elem_info *mei = snd_kcontrol_chip(kctl);
+
+	if (mei->ih.event)
+		input_unregister_handler(&mei->ih);
+
+	snd_usb_mixer_elem_free(kctl);
+}
+
+static int snd_dualsense_jack_create(struct usb_mixer_interface *mixer,
+				     const char *name, bool is_output)
+{
+	struct dualsense_mixer_elem_info *mei;
+	struct input_device_id *idev_id;
+	struct snd_kcontrol *kctl;
+	int err;
+
+	mei = kzalloc(sizeof(*mei), GFP_KERNEL);
+	if (!mei)
+		return -ENOMEM;
+
+	snd_usb_mixer_elem_init_std(&mei->info.head, mixer,
+				    is_output ? SND_DUALSENSE_JACK_OUT_TERM_ID :
+						SND_DUALSENSE_JACK_IN_TERM_ID);
+
+	mei->info.head.resume = snd_dualsense_resume_jack;
+	mei->info.val_type = USB_MIXER_BOOLEAN;
+	mei->info.channels = 1;
+	mei->info.min = 0;
+	mei->info.max = 1;
+
+	kctl = snd_ctl_new1(&snd_dualsense_jack_control, mei);
+	if (!kctl) {
+		kfree(mei);
+		return -ENOMEM;
+	}
+
+	strscpy(kctl->id.name, name, sizeof(kctl->id.name));
+	kctl->private_free = snd_dualsense_mixer_elem_free;
+
+	err = snd_usb_mixer_add_control(&mei->info.head, kctl);
+	if (err)
+		return err;
+
+	idev_id = &mei->id_table[0];
+	idev_id->flags = INPUT_DEVICE_ID_MATCH_VENDOR | INPUT_DEVICE_ID_MATCH_PRODUCT |
+			 INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_SWBIT;
+	idev_id->vendor = USB_ID_VENDOR(mixer->chip->usb_id);
+	idev_id->product = USB_ID_PRODUCT(mixer->chip->usb_id);
+	idev_id->evbit[BIT_WORD(EV_SW)] = BIT_MASK(EV_SW);
+	if (is_output)
+		idev_id->swbit[BIT_WORD(SW_HEADPHONE_INSERT)] = BIT_MASK(SW_HEADPHONE_INSERT);
+	else
+		idev_id->swbit[BIT_WORD(SW_MICROPHONE_INSERT)] = BIT_MASK(SW_MICROPHONE_INSERT);
+
+	mei->ih.event = snd_dualsense_ih_event;
+	mei->ih.match = snd_dualsense_ih_match;
+	mei->ih.connect = snd_dualsense_ih_connect;
+	mei->ih.disconnect = snd_dualsense_ih_disconnect;
+	mei->ih.start = snd_dualsense_ih_start;
+	mei->ih.name = name;
+	mei->ih.id_table = mei->id_table;
+
+	err = input_register_handler(&mei->ih);
+	if (err) {
+		dev_warn(&mixer->chip->dev->dev,
+			 "Could not register input handler: %d\n", err);
+		mei->ih.event = NULL;
+	}
+
+	return 0;
+}
+
+static int snd_dualsense_controls_create(struct usb_mixer_interface *mixer)
+{
+	int err;
+
+	err = snd_dualsense_jack_create(mixer, "Headphone Jack", true);
+	if (err < 0)
+		return err;
+
+	return snd_dualsense_jack_create(mixer, "Headset Mic Jack", false);
+}
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
+
 /* ASUS Xonar U1 / U3 controls */
 
 static int snd_xonar_u1_switch_get(struct snd_kcontrol *kcontrol,
@@ -856,6 +1118,7 @@ static const struct snd_kcontrol_new snd_mbox1_src_switch = {
 static int snd_mbox1_controls_create(struct usb_mixer_interface *mixer)
 {
 	int err;
+
 	err = add_single_ctl_with_resume(mixer, 0,
 					 snd_mbox1_clk_switch_resume,
 					 &snd_mbox1_clk_switch, NULL);
@@ -869,7 +1132,7 @@ static int snd_mbox1_controls_create(struct usb_mixer_interface *mixer)
 
 /* Native Instruments device quirks */
 
-#define _MAKE_NI_CONTROL(bRequest,wIndex) ((bRequest) << 16 | (wIndex))
+#define _MAKE_NI_CONTROL(bRequest, wIndex) ((bRequest) << 16 | (wIndex))
 
 static int snd_ni_control_init_val(struct usb_mixer_interface *mixer,
 				   struct snd_kcontrol *kctl)
@@ -1021,7 +1284,7 @@ static int snd_nativeinstruments_create_mixer(struct usb_mixer_interface *mixer,
 /* M-Audio FastTrack Ultra quirks */
 /* FTU Effect switch (also used by C400/C600) */
 static int snd_ftu_eff_switch_info(struct snd_kcontrol *kcontrol,
-					struct snd_ctl_elem_info *uinfo)
+				   struct snd_ctl_elem_info *uinfo)
 {
 	static const char *const texts[8] = {
 		"Room 1", "Room 2", "Room 3", "Hall 1",
@@ -1055,7 +1318,7 @@ static int snd_ftu_eff_switch_init(struct usb_mixer_interface *mixer,
 }
 
 static int snd_ftu_eff_switch_get(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
+				  struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.enumerated.item[0] = kctl->private_value >> 24;
 	return 0;
@@ -1086,7 +1349,7 @@ static int snd_ftu_eff_switch_update(struct usb_mixer_elem_list *list)
 }
 
 static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
-					struct snd_ctl_elem_value *ucontrol)
+				  struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kctl);
 	unsigned int pval = list->kctl->private_value;
@@ -1104,7 +1367,7 @@ static int snd_ftu_eff_switch_put(struct snd_kcontrol *kctl,
 }
 
 static int snd_ftu_create_effect_switch(struct usb_mixer_interface *mixer,
-	int validx, int bUnitID)
+					int validx, int bUnitID)
 {
 	static struct snd_kcontrol_new template = {
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1143,22 +1406,22 @@ static int snd_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 		for (in = 0; in < 8; in++) {
 			cmask = BIT(in);
 			snprintf(name, sizeof(name),
-				"AIn%d - Out%d Capture Volume",
-				in  + 1, out + 1);
+				 "AIn%d - Out%d Capture Volume",
+				 in  + 1, out + 1);
 			err = snd_create_std_mono_ctl(mixer, id, control,
-							cmask, val_type, name,
-							&snd_usb_mixer_vol_tlv);
+						      cmask, val_type, name,
+						      &snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
 		for (in = 8; in < 16; in++) {
 			cmask = BIT(in);
 			snprintf(name, sizeof(name),
-				"DIn%d - Out%d Playback Volume",
-				in - 7, out + 1);
+				 "DIn%d - Out%d Playback Volume",
+				 in - 7, out + 1);
 			err = snd_create_std_mono_ctl(mixer, id, control,
-							cmask, val_type, name,
-							&snd_usb_mixer_vol_tlv);
+						      cmask, val_type, name,
+						      &snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
@@ -1219,10 +1482,10 @@ static int snd_ftu_create_effect_return_ctls(struct usb_mixer_interface *mixer)
 	for (ch = 0; ch < 4; ++ch) {
 		cmask = BIT(ch);
 		snprintf(name, sizeof(name),
-			"Effect Return %d Volume", ch + 1);
+			 "Effect Return %d Volume", ch + 1);
 		err = snd_create_std_mono_ctl(mixer, id, control,
-						cmask, val_type, name,
-						snd_usb_mixer_vol_tlv);
+					      cmask, val_type, name,
+					      snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
@@ -1243,20 +1506,20 @@ static int snd_ftu_create_effect_send_ctls(struct usb_mixer_interface *mixer)
 	for (ch = 0; ch < 8; ++ch) {
 		cmask = BIT(ch);
 		snprintf(name, sizeof(name),
-			"Effect Send AIn%d Volume", ch + 1);
+			 "Effect Send AIn%d Volume", ch + 1);
 		err = snd_create_std_mono_ctl(mixer, id, control, cmask,
-						val_type, name,
-						snd_usb_mixer_vol_tlv);
+					      val_type, name,
+					      snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
 	for (ch = 8; ch < 16; ++ch) {
 		cmask = BIT(ch);
 		snprintf(name, sizeof(name),
-			"Effect Send DIn%d Volume", ch - 7);
+			 "Effect Send DIn%d Volume", ch - 7);
 		err = snd_create_std_mono_ctl(mixer, id, control, cmask,
-						val_type, name,
-						snd_usb_mixer_vol_tlv);
+					      val_type, name,
+					      snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
@@ -1346,19 +1609,19 @@ static int snd_c400_create_vol_ctls(struct usb_mixer_interface *mixer)
 		for (out = 0; out < num_outs; out++) {
 			if (chan < num_outs) {
 				snprintf(name, sizeof(name),
-					"PCM%d-Out%d Playback Volume",
-					chan + 1, out + 1);
+					 "PCM%d-Out%d Playback Volume",
+					 chan + 1, out + 1);
 			} else {
 				snprintf(name, sizeof(name),
-					"In%d-Out%d Playback Volume",
-					chan - num_outs + 1, out + 1);
+					 "In%d-Out%d Playback Volume",
+					 chan - num_outs + 1, out + 1);
 			}
 
 			cmask = (out == 0) ? 0 : BIT(out - 1);
 			offset = chan * num_outs;
 			err = snd_create_std_mono_ctl_offset(mixer, id, control,
-						cmask, val_type, offset, name,
-						&snd_usb_mixer_vol_tlv);
+							     cmask, val_type, offset, name,
+							     &snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
@@ -1377,7 +1640,7 @@ static int snd_c400_create_effect_volume_ctl(struct usb_mixer_interface *mixer)
 	const unsigned int cmask = 0;
 
 	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
-					name, snd_usb_mixer_vol_tlv);
+				       name, snd_usb_mixer_vol_tlv);
 }
 
 /* This control needs a volume quirk, see mixer.c */
@@ -1390,7 +1653,7 @@ static int snd_c400_create_effect_duration_ctl(struct usb_mixer_interface *mixer
 	const unsigned int cmask = 0;
 
 	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
-					name, snd_usb_mixer_vol_tlv);
+				       name, snd_usb_mixer_vol_tlv);
 }
 
 /* This control needs a volume quirk, see mixer.c */
@@ -1403,7 +1666,7 @@ static int snd_c400_create_effect_feedback_ctl(struct usb_mixer_interface *mixer
 	const unsigned int cmask = 0;
 
 	return snd_create_std_mono_ctl(mixer, id, control, cmask, val_type,
-					name, NULL);
+				       name, NULL);
 }
 
 static int snd_c400_create_effect_vol_ctls(struct usb_mixer_interface *mixer)
@@ -1432,18 +1695,18 @@ static int snd_c400_create_effect_vol_ctls(struct usb_mixer_interface *mixer)
 	for (chan = 0; chan < num_outs + num_ins; chan++) {
 		if (chan < num_outs) {
 			snprintf(name, sizeof(name),
-				"Effect Send DOut%d",
-				chan + 1);
+				 "Effect Send DOut%d",
+				 chan + 1);
 		} else {
 			snprintf(name, sizeof(name),
-				"Effect Send AIn%d",
-				chan - num_outs + 1);
+				 "Effect Send AIn%d",
+				 chan - num_outs + 1);
 		}
 
 		cmask = (chan == 0) ? 0 : BIT(chan - 1);
 		err = snd_create_std_mono_ctl(mixer, id, control,
-						cmask, val_type, name,
-						&snd_usb_mixer_vol_tlv);
+					      cmask, val_type, name,
+					      &snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
@@ -1478,14 +1741,14 @@ static int snd_c400_create_effect_ret_vol_ctls(struct usb_mixer_interface *mixer
 
 	for (chan = 0; chan < num_outs; chan++) {
 		snprintf(name, sizeof(name),
-			"Effect Return %d",
-			chan + 1);
+			 "Effect Return %d",
+			 chan + 1);
 
 		cmask = (chan == 0) ? 0 :
 			BIT(chan + (chan % 2) * num_outs - 1);
 		err = snd_create_std_mono_ctl_offset(mixer, id, control,
-						cmask, val_type, offset, name,
-						&snd_usb_mixer_vol_tlv);
+						     cmask, val_type, offset, name,
+						     &snd_usb_mixer_vol_tlv);
 		if (err < 0)
 			return err;
 	}
@@ -1626,7 +1889,7 @@ static const struct std_mono_table ebox44_table[] = {
  *
  */
 static int snd_microii_spdif_info(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_info *uinfo)
+				  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
 	uinfo->count = 1;
@@ -1634,7 +1897,7 @@ static int snd_microii_spdif_info(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_microii_spdif_default_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	struct snd_usb_audio *chip = list->mixer->chip;
@@ -1667,13 +1930,13 @@ static int snd_microii_spdif_default_get(struct snd_kcontrol *kcontrol,
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
 
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_rcvctrlpipe(chip->dev, 0),
-			UAC_GET_CUR,
-			USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
-			UAC_EP_CS_ATTR_SAMPLE_RATE << 8,
-			ep,
-			data,
-			sizeof(data));
+			      usb_rcvctrlpipe(chip->dev, 0),
+			      UAC_GET_CUR,
+			      USB_TYPE_CLASS | USB_RECIP_ENDPOINT | USB_DIR_IN,
+			      UAC_EP_CS_ATTR_SAMPLE_RATE << 8,
+			      ep,
+			      data,
+			      sizeof(data));
 	if (err < 0)
 		goto end;
 
@@ -1700,26 +1963,26 @@ static int snd_microii_spdif_default_update(struct usb_mixer_elem_list *list)
 
 	reg = ((pval >> 4) & 0xf0) | (pval & 0x0f);
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_sndctrlpipe(chip->dev, 0),
-			UAC_SET_CUR,
-			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			reg,
-			2,
-			NULL,
-			0);
+			      usb_sndctrlpipe(chip->dev, 0),
+			      UAC_SET_CUR,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+			      reg,
+			      2,
+			      NULL,
+			      0);
 	if (err < 0)
 		goto end;
 
 	reg = (pval & IEC958_AES0_NONAUDIO) ? 0xa0 : 0x20;
 	reg |= (pval >> 12) & 0x0f;
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_sndctrlpipe(chip->dev, 0),
-			UAC_SET_CUR,
-			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			reg,
-			3,
-			NULL,
-			0);
+			      usb_sndctrlpipe(chip->dev, 0),
+			      UAC_SET_CUR,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+			      reg,
+			      3,
+			      NULL,
+			      0);
 	if (err < 0)
 		goto end;
 
@@ -1729,13 +1992,14 @@ static int snd_microii_spdif_default_update(struct usb_mixer_elem_list *list)
 }
 
 static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					 struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	unsigned int pval, pval_old;
 	int err;
 
-	pval = pval_old = kcontrol->private_value;
+	pval = kcontrol->private_value;
+	pval_old = pval;
 	pval &= 0xfffff0f0;
 	pval |= (ucontrol->value.iec958.status[1] & 0x0f) << 8;
 	pval |= (ucontrol->value.iec958.status[0] & 0x0f);
@@ -1756,7 +2020,7 @@ static int snd_microii_spdif_default_put(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_microii_spdif_mask_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+				      struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.iec958.status[0] = 0x0f;
 	ucontrol->value.iec958.status[1] = 0xff;
@@ -1767,7 +2031,7 @@ static int snd_microii_spdif_mask_get(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_microii_spdif_switch_get(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	ucontrol->value.integer.value[0] = !(kcontrol->private_value & 0x02);
 
@@ -1785,20 +2049,20 @@ static int snd_microii_spdif_switch_update(struct usb_mixer_elem_list *list)
 		return err;
 
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_sndctrlpipe(chip->dev, 0),
-			UAC_SET_CUR,
-			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
-			reg,
-			9,
-			NULL,
-			0);
+			      usb_sndctrlpipe(chip->dev, 0),
+			      UAC_SET_CUR,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
+			      reg,
+			      9,
+			      NULL,
+			      0);
 
 	snd_usb_unlock_shutdown(chip);
 	return err;
 }
 
 static int snd_microii_spdif_switch_put(struct snd_kcontrol *kcontrol,
-	struct snd_ctl_elem_value *ucontrol)
+					struct snd_ctl_elem_value *ucontrol)
 {
 	struct usb_mixer_elem_list *list = snd_kcontrol_chip(kcontrol);
 	u8 reg;
@@ -1883,9 +2147,9 @@ static int snd_soundblaster_e1_switch_update(struct usb_mixer_interface *mixer,
 	if (err < 0)
 		return err;
 	err = snd_usb_ctl_msg(chip->dev,
-			usb_sndctrlpipe(chip->dev, 0), HID_REQ_SET_REPORT,
-			USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			0x0202, 3, buff, 2);
+			      usb_sndctrlpipe(chip->dev, 0), HID_REQ_SET_REPORT,
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_OUT,
+			      0x0202, 3, buff, 2);
 	snd_usb_unlock_shutdown(chip);
 	return err;
 }
@@ -2181,6 +2445,7 @@ static const u32 snd_rme_rate_table[] = {
 	256000,	352800, 384000, 400000,
 	512000, 705600, 768000, 800000
 };
+
 /* maximum number of items for AES and S/PDIF rates for above table */
 #define SND_RME_RATE_IDX_AES_SPDIF_NUM		12
 
@@ -3235,7 +3500,7 @@ static int snd_rme_digiface_enum_put(struct snd_kcontrol *kcontrol,
 }
 
 static int snd_rme_digiface_current_sync_get(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
+					     struct snd_ctl_elem_value *ucontrol)
 {
 	int ret = snd_rme_digiface_enum_get(kcontrol, ucontrol);
 
@@ -3269,7 +3534,6 @@ static int snd_rme_digiface_sync_state_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-
 static int snd_rme_digiface_format_info(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
 {
@@ -3281,7 +3545,6 @@ static int snd_rme_digiface_format_info(struct snd_kcontrol *kcontrol,
 				 ARRAY_SIZE(format), format);
 }
 
-
 static int snd_rme_digiface_sync_source_info(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_info *uinfo)
 {
@@ -3564,7 +3827,6 @@ static int snd_rme_digiface_controls_create(struct usb_mixer_interface *mixer)
 #define SND_DJM_A9_IDX		0x6
 #define SND_DJM_V10_IDX	0x7
 
-
 #define SND_DJM_CTL(_name, suffix, _default_value, _windex) { \
 	.name = _name, \
 	.options = snd_djm_opts_##suffix, \
@@ -3576,7 +3838,6 @@ static int snd_rme_digiface_controls_create(struct usb_mixer_interface *mixer)
 	.controls = snd_djm_ctls_##suffix, \
 	.ncontrols = ARRAY_SIZE(snd_djm_ctls_##suffix) }
 
-
 struct snd_djm_device {
 	const char *name;
 	const struct snd_djm_ctl *controls;
@@ -3722,7 +3983,6 @@ static const struct snd_djm_ctl snd_djm_ctls_250mk2[] = {
 	SND_DJM_CTL("Output 3 Playback Switch", 250mk2_pb3, 2, SND_DJM_WINDEX_PB)
 };
 
-
 // DJM-450
 static const u16 snd_djm_opts_450_cap1[] = {
 	0x0103, 0x0100, 0x0106, 0x0107, 0x0108, 0x0109, 0x010d, 0x010a };
@@ -3747,7 +4007,6 @@ static const struct snd_djm_ctl snd_djm_ctls_450[] = {
 	SND_DJM_CTL("Output 3 Playback Switch", 450_pb3, 2, SND_DJM_WINDEX_PB)
 };
 
-
 // DJM-750
 static const u16 snd_djm_opts_750_cap1[] = {
 	0x0101, 0x0103, 0x0106, 0x0107, 0x0108, 0x0109, 0x010a, 0x010f };
@@ -3766,7 +4025,6 @@ static const struct snd_djm_ctl snd_djm_ctls_750[] = {
 	SND_DJM_CTL("Input 4 Capture Switch", 750_cap4, 0, SND_DJM_WINDEX_CAP)
 };
 
-
 // DJM-850
 static const u16 snd_djm_opts_850_cap1[] = {
 	0x0100, 0x0103, 0x0106, 0x0107, 0x0108, 0x0109, 0x010a, 0x010f };
@@ -3785,7 +4043,6 @@ static const struct snd_djm_ctl snd_djm_ctls_850[] = {
 	SND_DJM_CTL("Input 4 Capture Switch", 850_cap4, 1, SND_DJM_WINDEX_CAP)
 };
 
-
 // DJM-900NXS2
 static const u16 snd_djm_opts_900nxs2_cap1[] = {
 	0x0100, 0x0102, 0x0103, 0x0106, 0x0107, 0x0108, 0x0109, 0x010a };
@@ -3823,7 +4080,6 @@ static const u16 snd_djm_opts_750mk2_pb1[] = { 0x0100, 0x0101, 0x0104 };
 static const u16 snd_djm_opts_750mk2_pb2[] = { 0x0200, 0x0201, 0x0204 };
 static const u16 snd_djm_opts_750mk2_pb3[] = { 0x0300, 0x0301, 0x0304 };
 
-
 static const struct snd_djm_ctl snd_djm_ctls_750mk2[] = {
 	SND_DJM_CTL("Master Input Level Capture Switch", cap_level, 0, SND_DJM_WINDEX_CAPLVL),
 	SND_DJM_CTL("Input 1 Capture Switch",   750mk2_cap1, 2, SND_DJM_WINDEX_CAP),
@@ -3836,7 +4092,6 @@ static const struct snd_djm_ctl snd_djm_ctls_750mk2[] = {
 	SND_DJM_CTL("Output 3 Playback Switch", 750mk2_pb3, 2, SND_DJM_WINDEX_PB)
 };
 
-
 // DJM-A9
 static const u16 snd_djm_opts_a9_cap_level[] = {
 	0x0000, 0x0100, 0x0200, 0x0300, 0x0400, 0x0500 };
@@ -3865,29 +4120,35 @@ static const struct snd_djm_ctl snd_djm_ctls_a9[] = {
 static const u16 snd_djm_opts_v10_cap_level[] = {
 	0x0000, 0x0100, 0x0200, 0x0300, 0x0400, 0x0500
 };
+
 static const u16 snd_djm_opts_v10_cap1[] = {
 	0x0103,
 	0x0100, 0x0102, 0x0106, 0x0110, 0x0107,
 	0x0108, 0x0109, 0x010a, 0x0121, 0x0122
 };
+
 static const u16 snd_djm_opts_v10_cap2[] = {
 	0x0200, 0x0202, 0x0206, 0x0210, 0x0207,
 	0x0208, 0x0209, 0x020a, 0x0221, 0x0222
 };
+
 static const u16 snd_djm_opts_v10_cap3[] = {
 	0x0303,
 	0x0300, 0x0302, 0x0306, 0x0310, 0x0307,
 	0x0308, 0x0309, 0x030a, 0x0321, 0x0322
 };
+
 static const u16 snd_djm_opts_v10_cap4[] = {
 	0x0403,
 	0x0400, 0x0402, 0x0406, 0x0410, 0x0407,
 	0x0408, 0x0409, 0x040a, 0x0421, 0x0422
 };
+
 static const u16 snd_djm_opts_v10_cap5[] = {
 	0x0500, 0x0502, 0x0506, 0x0510, 0x0507,
 	0x0508, 0x0509, 0x050a, 0x0521, 0x0522
 };
+
 static const u16 snd_djm_opts_v10_cap6[] = {
 	0x0603,
 	0x0600, 0x0602, 0x0606, 0x0610, 0x0607,
@@ -3916,9 +4177,8 @@ static const struct snd_djm_device snd_djm_devices[] = {
 	[SND_DJM_V10_IDX] = SND_DJM_DEVICE(v10),
 };
 
-
 static int snd_djm_controls_info(struct snd_kcontrol *kctl,
-				struct snd_ctl_elem_info *info)
+				 struct snd_ctl_elem_info *info)
 {
 	unsigned long private_value = kctl->private_value;
 	u8 device_idx = (private_value & SND_DJM_DEVICE_MASK) >> SND_DJM_DEVICE_SHIFT;
@@ -3937,8 +4197,8 @@ static int snd_djm_controls_info(struct snd_kcontrol *kctl,
 		info->value.enumerated.item = noptions - 1;
 
 	name = snd_djm_get_label(device_idx,
-				ctl->options[info->value.enumerated.item],
-				ctl->wIndex);
+				 ctl->options[info->value.enumerated.item],
+				 ctl->wIndex);
 	if (!name)
 		return -EINVAL;
 
@@ -3950,25 +4210,25 @@ static int snd_djm_controls_info(struct snd_kcontrol *kctl,
 }
 
 static int snd_djm_controls_update(struct usb_mixer_interface *mixer,
-				u8 device_idx, u8 group, u16 value)
+				   u8 device_idx, u8 group, u16 value)
 {
 	int err;
 	const struct snd_djm_device *device = &snd_djm_devices[device_idx];
 
-	if ((group >= device->ncontrols) || value >= device->controls[group].noptions)
+	if (group >= device->ncontrols || value >= device->controls[group].noptions)
 		return -EINVAL;
 
 	err = snd_usb_lock_shutdown(mixer->chip);
 	if (err)
 		return err;
 
-	err = snd_usb_ctl_msg(
-		mixer->chip->dev, usb_sndctrlpipe(mixer->chip->dev, 0),
-		USB_REQ_SET_FEATURE,
-		USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-		device->controls[group].options[value],
-		device->controls[group].wIndex,
-		NULL, 0);
+	err = snd_usb_ctl_msg(mixer->chip->dev,
+			      usb_sndctrlpipe(mixer->chip->dev, 0),
+			      USB_REQ_SET_FEATURE,
+			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
+			      device->controls[group].options[value],
+			      device->controls[group].wIndex,
+			      NULL, 0);
 
 	snd_usb_unlock_shutdown(mixer->chip);
 	return err;
@@ -4009,7 +4269,7 @@ static int snd_djm_controls_resume(struct usb_mixer_elem_list *list)
 }
 
 static int snd_djm_controls_create(struct usb_mixer_interface *mixer,
-		const u8 device_idx)
+				   const u8 device_idx)
 {
 	int err, i;
 	u16 value;
@@ -4028,10 +4288,10 @@ static int snd_djm_controls_create(struct usb_mixer_interface *mixer,
 	for (i = 0; i < device->ncontrols; i++) {
 		value = device->controls[i].default_value;
 		knew.name = device->controls[i].name;
-		knew.private_value = (
+		knew.private_value =
 			((unsigned long)device_idx << SND_DJM_DEVICE_SHIFT) |
 			(i << SND_DJM_GROUP_SHIFT) |
-			value);
+			value;
 		err = snd_djm_controls_update(mixer, device_idx, i, value);
 		if (err)
 			return err;
@@ -4073,6 +4333,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		err = snd_emu0204_controls_create(mixer);
 		break;
 
+#if IS_REACHABLE(CONFIG_INPUT)
+	case USB_ID(0x054c, 0x0ce6): /* Sony DualSense controller (PS5) */
+	case USB_ID(0x054c, 0x0df2): /* Sony DualSense Edge controller (PS5) */
+		err = snd_dualsense_controls_create(mixer);
+		break;
+#endif /* IS_REACHABLE(CONFIG_INPUT) */
+
 	case USB_ID(0x0763, 0x2030): /* M-Audio Fast Track C400 */
 	case USB_ID(0x0763, 0x2031): /* M-Audio Fast Track C400 */
 		err = snd_c400_create_mixer(mixer);
@@ -4098,13 +4365,15 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 		break;
 
 	case USB_ID(0x17cc, 0x1011): /* Traktor Audio 6 */
-		err = snd_nativeinstruments_create_mixer(mixer,
+		err = snd_nativeinstruments_create_mixer(/* checkpatch hack */
+				mixer,
 				snd_nativeinstruments_ta6_mixers,
 				ARRAY_SIZE(snd_nativeinstruments_ta6_mixers));
 		break;
 
 	case USB_ID(0x17cc, 0x1021): /* Traktor Audio 10 */
-		err = snd_nativeinstruments_create_mixer(mixer,
+		err = snd_nativeinstruments_create_mixer(/* checkpatch hack */
+				mixer,
 				snd_nativeinstruments_ta10_mixers,
 				ARRAY_SIZE(snd_nativeinstruments_ta10_mixers));
 		break;
@@ -4254,7 +4523,8 @@ static void snd_dragonfly_quirk_db_scale(struct usb_mixer_interface *mixer,
 					 struct snd_kcontrol *kctl)
 {
 	/* Approximation using 10 ranges based on output measurement on hw v1.2.
-	 * This seems close to the cubic mapping e.g. alsamixer uses. */
+	 * This seems close to the cubic mapping e.g. alsamixer uses.
+	 */
 	static const DECLARE_TLV_DB_RANGE(scale,
 		 0,  1, TLV_DB_MINMAX_ITEM(-5300, -4970),
 		 2,  5, TLV_DB_MINMAX_ITEM(-4710, -4160),
@@ -4338,20 +4608,15 @@ void snd_usb_mixer_fu_apply_quirk(struct usb_mixer_interface *mixer,
 		if (unitid == 7 && cval->control == UAC_FU_VOLUME)
 			snd_dragonfly_quirk_db_scale(mixer, cval, kctl);
 		break;
+	}
+
 	/* lowest playback value is muted on some devices */
-	case USB_ID(0x0572, 0x1b09): /* Conexant Systems (Rockwell), Inc. */
-	case USB_ID(0x0d8c, 0x000c): /* C-Media */
-	case USB_ID(0x0d8c, 0x0014): /* C-Media */
-	case USB_ID(0x19f7, 0x0003): /* RODE NT-USB */
-	case USB_ID(0x2d99, 0x0026): /* HECATE G2 GAMING HEADSET */
+	if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_MIN_MUTE)
 		if (strstr(kctl->id.name, "Playback"))
 			cval->min_mute = 1;
-		break;
-	}
 
 	/* ALSA-ify some Plantronics headset control names */
 	if (USB_ID_VENDOR(mixer->chip->usb_id) == 0x047f &&
 	    (cval->control == UAC_FU_MUTE || cval->control == UAC_FU_VOLUME))
 		snd_fix_plt_name(mixer->chip, &kctl->id);
 }
-
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index bd24f3a78ea9..766db7d00cbc 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2199,6 +2199,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0572, 0x1b08, /* Conexant Systems (Rockwell), Inc. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
+	DEVICE_FLG(0x0572, 0x1b09, /* Conexant Systems (Rockwell), Inc. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x05a3, 0x9420, /* ELP HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x05a7, 0x1020, /* Bose Companion 5 */
@@ -2241,12 +2245,16 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0bda, 0x498a, /* Realtek Semiconductor Corp. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0c45, 0x636b, /* Microdia JP001 USB Camera */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
-	DEVICE_FLG(0x0d8c, 0x0014, /* USB Audio Device */
-		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0d8c, 0x000c, /* C-Media */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
+	DEVICE_FLG(0x0d8c, 0x0014, /* C-Media */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
@@ -2255,6 +2263,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1101, 0x0003, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x12d1, 0x3a07, /* Huawei Technologies Co., Ltd. */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE | QUIRK_FLAG_MIC_RES_16),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
@@ -2293,6 +2303,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0003, /* RODE NT-USB */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
@@ -2343,6 +2355,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., Ltd. BE02T */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
@@ -2353,10 +2367,14 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x2d95, 0x8021, /* VIVO USB-C-XE710 HEADSET */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x2d99, 0x0026, /* HECATE G2 GAMING HEADSET */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x2fc6, 0xf0b7, /* iBasso DC07 Pro */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x339b, 0x3a07, /* Synaptics HONOR USB-C HEADSET */
+		   QUIRK_FLAG_MIXER_MIN_MUTE),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x534d, 0x0021, /* MacroSilicon MS2100/MS2106 */
@@ -2408,6 +2426,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x2d87, /* Cayin device */
 		   QUIRK_FLAG_DSD_RAW),
+	VENDOR_FLG(0x2fc6, /* Comture-inc devices */
+		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3336, /* HEM devices */
 		   QUIRK_FLAG_DSD_RAW),
 	VENDOR_FLG(0x3353, /* Khadas devices */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 158ec053dc44..1ef4d39978df 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -196,6 +196,9 @@ extern bool snd_usb_skip_validation;
  *  for the given endpoint.
  * QUIRK_FLAG_MIC_RES_16 and QUIRK_FLAG_MIC_RES_384
  *  Set the fixed resolution for Mic Capture Volume (mostly for webcams)
+ * QUIRK_FLAG_MIXER_MIN_MUTE
+ *  Set minimum volume control value as mute for devices where the lowest
+ *  playback value represents muted state instead of minimum audible volume
  */
 
 #define QUIRK_FLAG_GET_SAMPLE_RATE	(1U << 0)
@@ -222,5 +225,6 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_FIXED_RATE		(1U << 21)
 #define QUIRK_FLAG_MIC_RES_16		(1U << 22)
 #define QUIRK_FLAG_MIC_RES_384		(1U << 23)
+#define QUIRK_FLAG_MIXER_MIN_MUTE	(1U << 24)
 
 #endif /* __USBAUDIO_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/free_timer.c b/tools/testing/selftests/bpf/prog_tests/free_timer.c
index b7b77a6b2979..0de8facca4c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/free_timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/free_timer.c
@@ -124,6 +124,10 @@ void test_free_timer(void)
 	int err;
 
 	skel = free_timer__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(skel, "open_load"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index d66687f1ee6a..56f660ca567b 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -86,6 +86,10 @@ void serial_test_timer(void)
 	int err;
 
 	timer_skel = timer__open_and_load();
+	if (!timer_skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
index f74b82305da8..b841597c8a3a 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_crash.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
@@ -12,6 +12,10 @@ static void test_timer_crash_mode(int mode)
 	struct timer_crash *skel;
 
 	skel = timer_crash__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(skel, "timer_crash__open_and_load"))
 		return;
 	skel->bss->pid = getpid();
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
index 1a2f99596916..eb303fa1e09a 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
@@ -59,6 +59,10 @@ void test_timer_lockup(void)
 	}
 
 	skel = timer_lockup__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
index 9ff7843909e7..c930c7d7105b 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
@@ -65,6 +65,10 @@ void serial_test_timer_mim(void)
 		goto cleanup;
 
 	timer_skel = timer_mim__open_and_load();
+	if (!timer_skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
 		goto cleanup;
 
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 63ce708d93ed..e4b7c2b457ee 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -2,6 +2,13 @@
 // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
 
 #define _GNU_SOURCE
+
+// Needed for linux/fanotify.h
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#define __kernel_fsid_t __kernel_fsid_t
+
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
@@ -10,20 +17,12 @@
 #include <sys/mount.h>
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <sys/fanotify.h>
 
 #include "../../kselftest_harness.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
-// Needed for linux/fanotify.h
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-#endif
-
-#include <sys/fanotify.h>
-
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
 
 static const int mark_cmds[] = {
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index 090a5ca65004..9f57ca46e3af 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -2,6 +2,13 @@
 // Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
 
 #define _GNU_SOURCE
+
+// Needed for linux/fanotify.h
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#define __kernel_fsid_t __kernel_fsid_t
+
 #include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
@@ -10,21 +17,12 @@
 #include <sys/mount.h>
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <sys/fanotify.h>
 
 #include "../../kselftest_harness.h"
-#include "../../pidfd/pidfd.h"
 #include "../statmount/statmount.h"
 #include "../utils.h"
 
-// Needed for linux/fanotify.h
-#ifndef __kernel_fsid_t
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-#endif
-
-#include <sys/fanotify.h>
-
 static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
 
 static const int mark_types[] = {
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index b39f748c2572..2ac394c99d01 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -467,8 +467,8 @@ ipv6_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4"
-	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5"
+	run_cmd "$IP nexthop add id 63 via 2001:db8:91::4 dev veth1"
+	run_cmd "$IP nexthop add id 64 via 2001:db8:91::5 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 63/64 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
@@ -547,15 +547,15 @@ ipv4_fdb_grp_fcnal()
 	log_test $? 0 "Get Fdb nexthop group by id"
 
 	# fdb nexthop group can only contain fdb nexthops
-	run_cmd "$IP nexthop add id 14 via 172.16.1.2"
-	run_cmd "$IP nexthop add id 15 via 172.16.1.3"
+	run_cmd "$IP nexthop add id 14 via 172.16.1.2 dev veth1"
+	run_cmd "$IP nexthop add id 15 via 172.16.1.3 dev veth1"
 	run_cmd "$IP nexthop add id 103 group 14/15 fdb"
 	log_test $? 2 "Fdb Nexthop group with non-fdb nexthops"
 
 	# Non fdb nexthop group can not contain fdb nexthops
 	run_cmd "$IP nexthop add id 16 via 172.16.1.2 fdb"
 	run_cmd "$IP nexthop add id 17 via 172.16.1.3 fdb"
-	run_cmd "$IP nexthop add id 104 group 14/15"
+	run_cmd "$IP nexthop add id 104 group 16/17"
 	log_test $? 2 "Non-Fdb Nexthop group with fdb nexthops"
 
 	# fdb nexthop cannot have blackhole
@@ -582,7 +582,7 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
-	run_cmd "$IP ro add 172.16.0.0/22 nhid 15"
+	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 103"

