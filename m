Return-Path: <stable+bounces-144706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2184DABAE53
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 08:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21568163A7E
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 06:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892320D4FC;
	Sun, 18 May 2025 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GOuWBYAE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0F20CCC9;
	Sun, 18 May 2025 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747550633; cv=none; b=JfWDWI4YFc9oSrZ8IR3hP51XRKOQMW3FIq7qmv+S5yklNqlKsTssXT60LWE3gMElpS1fyT6c1u5mJDEfKO776A3iiPMURdDBP3GCUPlb/SkVNpBkQXNCr5gTPz9g8cLaoq065LmY+mnAOL57UXAENcOkbmI220TUj7yFA513BGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747550633; c=relaxed/simple;
	bh=awwyLMR8/bIq0hAUPV5QsvuttqR/2O5dxGQQs6bVH9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlcKT1baJbTu8hbluewOJx6yGf2x9wXA4xZj20+uN+zt0xMaN5rHFnysDobkbZISjFGybL+S8C2cHWlVFaKjum9EF/Hx/G1D0LYZ3OJmOz3UduFuV4e3r47tEOy4+A4CTEer8Eh+G26ocTT+GbWGYvvGfGJxLsdpXBh5m8X5l5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GOuWBYAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A250C4CEE9;
	Sun, 18 May 2025 06:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747550633;
	bh=awwyLMR8/bIq0hAUPV5QsvuttqR/2O5dxGQQs6bVH9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOuWBYAEng5jgGgz2Rcmny8uWYghUPzDSgumFDJx1ujsXOYzNPBDRRqcUGXor6NQj
	 y714xhoNHTKMqgK3NBNxRR9k3dAw9YGAjYZCfc+tJJvzZH6svvfs2kqeDK09iwU4Gf
	 AHxWuH3L+sfHp2COoVAXRxXGOIXmH1qYbKzcoDag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.29
Date: Sun, 18 May 2025 08:41:54 +0200
Message-ID: <2025051854-scoring-destitute-d20f@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025051854-unrevised-dreamless-0ec7@gregkh>
References: <2025051854-unrevised-dreamless-0ec7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/.clippy.toml b/.clippy.toml
index e4c4eef10b28..5d99a317f7d6 100644
--- a/.clippy.toml
+++ b/.clippy.toml
@@ -5,5 +5,5 @@ check-private-items = true
 disallowed-macros = [
     # The `clippy::dbg_macro` lint only works with `std::dbg!`, thus we simulate
     # it here, see: https://github.com/rust-lang/rust-clippy/issues/11303.
-    { path = "kernel::dbg", reason = "the `dbg!` macro is intended as a debugging tool" },
+    { path = "kernel::dbg", reason = "the `dbg!` macro is intended as a debugging tool", allow-invalid = true },
 ]
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 206079d3bd5b..6a1acabb29d8 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -511,6 +511,7 @@ Description:	information about CPUs heterogeneity.
 
 What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/gather_data_sampling
+		/sys/devices/system/cpu/vulnerabilities/indirect_target_selection
 		/sys/devices/system/cpu/vulnerabilities/itlb_multihit
 		/sys/devices/system/cpu/vulnerabilities/l1tf
 		/sys/devices/system/cpu/vulnerabilities/mds
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index ff0b440ef2dc..d2caa390395e 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -22,3 +22,4 @@ are configurable at compile, boot or run time.
    srso
    gather_data_sampling
    reg-file-data-sampling
+   indirect-target-selection
diff --git a/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
new file mode 100644
index 000000000000..d9ca64108d23
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
@@ -0,0 +1,168 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Indirect Target Selection (ITS)
+===============================
+
+ITS is a vulnerability in some Intel CPUs that support Enhanced IBRS and were
+released before Alder Lake. ITS may allow an attacker to control the prediction
+of indirect branches and RETs located in the lower half of a cacheline.
+
+ITS is assigned CVE-2024-28956 with a CVSS score of 4.7 (Medium).
+
+Scope of Impact
+---------------
+- **eIBRS Guest/Host Isolation**: Indirect branches in KVM/kernel may still be
+  predicted with unintended target corresponding to a branch in the guest.
+
+- **Intra-Mode BTI**: In-kernel training such as through cBPF or other native
+  gadgets.
+
+- **Indirect Branch Prediction Barrier (IBPB)**: After an IBPB, indirect
+  branches may still be predicted with targets corresponding to direct branches
+  executed prior to the IBPB. This is fixed by the IPU 2025.1 microcode, which
+  should be available via distro updates. Alternatively microcode can be
+  obtained from Intel's github repository [#f1]_.
+
+Affected CPUs
+-------------
+Below is the list of ITS affected CPUs [#f2]_ [#f3]_:
+
+   ========================  ============  ====================  ===============
+   Common name               Family_Model  eIBRS                 Intra-mode BTI
+                                           Guest/Host Isolation
+   ========================  ============  ====================  ===============
+   SKYLAKE_X (step >= 6)     06_55H        Affected              Affected
+   ICELAKE_X                 06_6AH        Not affected          Affected
+   ICELAKE_D                 06_6CH        Not affected          Affected
+   ICELAKE_L                 06_7EH        Not affected          Affected
+   TIGERLAKE_L               06_8CH        Not affected          Affected
+   TIGERLAKE                 06_8DH        Not affected          Affected
+   KABYLAKE_L (step >= 12)   06_8EH        Affected              Affected
+   KABYLAKE (step >= 13)     06_9EH        Affected              Affected
+   COMETLAKE                 06_A5H        Affected              Affected
+   COMETLAKE_L               06_A6H        Affected              Affected
+   ROCKETLAKE                06_A7H        Not affected          Affected
+   ========================  ============  ====================  ===============
+
+- All affected CPUs enumerate Enhanced IBRS feature.
+- IBPB isolation is affected on all ITS affected CPUs, and need a microcode
+  update for mitigation.
+- None of the affected CPUs enumerate BHI_CTRL which was introduced in Golden
+  Cove (Alder Lake and Sapphire Rapids). This can help guests to determine the
+  host's affected status.
+- Intel Atom CPUs are not affected by ITS.
+
+Mitigation
+----------
+As only the indirect branches and RETs that have their last byte of instruction
+in the lower half of the cacheline are vulnerable to ITS, the basic idea behind
+the mitigation is to not allow indirect branches in the lower half.
+
+This is achieved by relying on existing retpoline support in the kernel, and in
+compilers. ITS-vulnerable retpoline sites are runtime patched to point to newly
+added ITS-safe thunks. These safe thunks consists of indirect branch in the
+second half of the cacheline. Not all retpoline sites are patched to thunks, if
+a retpoline site is evaluated to be ITS-safe, it is replaced with an inline
+indirect branch.
+
+Dynamic thunks
+~~~~~~~~~~~~~~
+From a dynamically allocated pool of safe-thunks, each vulnerable site is
+replaced with a new thunk, such that they get a unique address. This could
+improve the branch prediction accuracy. Also, it is a defense-in-depth measure
+against aliasing.
+
+Note, for simplicity, indirect branches in eBPF programs are always replaced
+with a jump to a static thunk in __x86_indirect_its_thunk_array. If required,
+in future this can be changed to use dynamic thunks.
+
+All vulnerable RETs are replaced with a static thunk, they do not use dynamic
+thunks. This is because RETs get their prediction from RSB mostly that does not
+depend on source address. RETs that underflow RSB may benefit from dynamic
+thunks. But, RETs significantly outnumber indirect branches, and any benefit
+from a unique source address could be outweighed by the increased icache
+footprint and iTLB pressure.
+
+Retpoline
+~~~~~~~~~
+Retpoline sequence also mitigates ITS-unsafe indirect branches. For this
+reason, when retpoline is enabled, ITS mitigation only relocates the RETs to
+safe thunks. Unless user requested the RSB-stuffing mitigation.
+
+RSB Stuffing
+~~~~~~~~~~~~
+RSB-stuffing via Call Depth Tracking is a mitigation for Retbleed RSB-underflow
+attacks. And it also mitigates RETs that are vulnerable to ITS.
+
+Mitigation in guests
+^^^^^^^^^^^^^^^^^^^^
+All guests deploy ITS mitigation by default, irrespective of eIBRS enumeration
+and Family/Model of the guest. This is because eIBRS feature could be hidden
+from a guest. One exception to this is when a guest enumerates BHI_DIS_S, which
+indicates that the guest is running on an unaffected host.
+
+To prevent guests from unnecessarily deploying the mitigation on unaffected
+platforms, Intel has defined ITS_NO bit(62) in MSR IA32_ARCH_CAPABILITIES. When
+a guest sees this bit set, it should not enumerate the ITS bug. Note, this bit
+is not set by any hardware, but is **intended for VMMs to synthesize** it for
+guests as per the host's affected status.
+
+Mitigation options
+^^^^^^^^^^^^^^^^^^
+The ITS mitigation can be controlled using the "indirect_target_selection"
+kernel parameter. The available options are:
+
+   ======== ===================================================================
+   on       (default)  Deploy the "Aligned branch/return thunks" mitigation.
+	    If spectre_v2 mitigation enables retpoline, aligned-thunks are only
+	    deployed for the affected RET instructions. Retpoline mitigates
+	    indirect branches.
+
+   off      Disable ITS mitigation.
+
+   vmexit   Equivalent to "=on" if the CPU is affected by guest/host isolation
+	    part of ITS. Otherwise, mitigation is not deployed. This option is
+	    useful when host userspace is not in the threat model, and only
+	    attacks from guest to host are considered.
+
+   stuff    Deploy RSB-fill mitigation when retpoline is also deployed.
+	    Otherwise, deploy the default mitigation. When retpoline mitigation
+	    is enabled, RSB-stuffing via Call-Depth-Tracking also mitigates
+	    ITS.
+
+   force    Force the ITS bug and deploy the default mitigation.
+   ======== ===================================================================
+
+Sysfs reporting
+---------------
+
+The sysfs file showing ITS mitigation status is:
+
+  /sys/devices/system/cpu/vulnerabilities/indirect_target_selection
+
+Note, microcode mitigation status is not reported in this file.
+
+The possible values in this file are:
+
+.. list-table::
+
+   * - Not affected
+     - The processor is not vulnerable.
+   * - Vulnerable
+     - System is vulnerable and no mitigation has been applied.
+   * - Vulnerable, KVM: Not affected
+     - System is vulnerable to intra-mode BTI, but not affected by eIBRS
+       guest/host isolation.
+   * - Mitigation: Aligned branch/return thunks
+     - The mitigation is enabled, affected indirect branches and RETs are
+       relocated to safe thunks.
+   * - Mitigation: Retpolines, Stuffing RSB
+     - The mitigation is enabled using retpoline and RSB stuffing.
+
+References
+----------
+.. [#f1] Microcode repository - https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files
+
+.. [#f2] Affected Processors list - https://www.intel.com/content/www/us/en/developer/topic-technology/software-security-guidance/processors-affected-consolidated-product-cpu-model.html
+
+.. [#f3] Affected Processors list (machine readable) - https://github.com/intel/Intel-affected-processor-list
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 607a8937f175..e691f75c97e7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2149,6 +2149,23 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	indirect_target_selection= [X86,Intel] Mitigation control for Indirect
+			Target Selection(ITS) bug in Intel CPUs. Updated
+			microcode is also required for a fix in IBPB.
+
+			on:     Enable mitigation (default).
+			off:    Disable mitigation.
+			force:	Force the ITS bug and deploy default
+				mitigation.
+			vmexit: Only deploy mitigation if CPU is affected by
+				guest/host isolation part of ITS.
+			stuff:	Deploy RSB-fill mitigation when retpoline is
+				also deployed. Otherwise, deploy the default
+				mitigation.
+
+			For details see:
+			Documentation/admin-guide/hw-vuln/indirect-target-selection.rst
+
 	init=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /sbin/init as init
@@ -3510,6 +3527,7 @@
 				expose users to several CPU vulnerabilities.
 				Equivalent to: if nokaslr then kpti=0 [ARM64]
 					       gather_data_sampling=off [X86]
+					       indirect_target_selection=off [X86]
 					       kvm.nx_huge_pages=off [X86]
 					       l1tf=off [X86]
 					       mds=off [X86]
diff --git a/Makefile b/Makefile
index f26e0f946f02..7a06c48ffbaa 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 28
+SUBLEVEL = 29
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index aee79a50d0e2..d9b13c87f93b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -165,6 +165,19 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		startup-delay-us = <20000>;
 	};
 
+	reg_usdhc2_vqmmc: regulator-usdhc2-vqmmc {
+		compatible = "regulator-gpio";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc2_vsel>;
+		gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <1800000>;
+		states = <1800000 0x1>,
+			 <3300000 0x0>;
+		regulator-name = "PMIC_USDHC_VSELECT";
+		vin-supply = <&reg_nvcc_sd>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -290,7 +303,7 @@ &gpio1 {
 			  "SODIMM_19",
 			  "",
 			  "",
-			  "",
+			  "PMIC_USDHC_VSELECT",
 			  "",
 			  "",
 			  "",
@@ -801,6 +814,7 @@ &usdhc2 {
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
 	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
+	vqmmc-supply = <&reg_usdhc2_vqmmc>;
 };
 
 &wdog1 {
@@ -1222,13 +1236,17 @@ pinctrl_usdhc2_pwr_en: usdhc2pwrengrp {
 			<MX8MM_IOMUXC_NAND_CLE_GPIO3_IO5		0x6>;	/* SODIMM 76 */
 	};
 
+	pinctrl_usdhc2_vsel: usdhc2vselgrp {
+		fsl,pins =
+			<MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4	0x10>; /* PMIC_USDHC_VSELECT */
+	};
+
 	/*
 	 * Note: Due to ERR050080 we use discrete external on-module resistors pulling-up to the
 	 * on-module +V3.3_1.8_SD (LDO5) rail and explicitly disable the internal pull-ups here.
 	 */
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x90>,	/* SODIMM 78 */
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x90>,	/* SODIMM 74 */
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x90>,	/* SODIMM 80 */
@@ -1239,7 +1257,6 @@ pinctrl_usdhc2: usdhc2grp {
 
 	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x94>,
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x94>,
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x94>,
@@ -1250,7 +1267,6 @@ pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 
 	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x10>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x96>,
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x96>,
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x96>,
@@ -1262,7 +1278,6 @@ pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 	/* Avoid backfeeding with removed card power */
 	pinctrl_usdhc2_sleep: usdhc2slpgrp {
 		fsl,pins =
-			<MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x0>,
 			<MX8MM_IOMUXC_SD2_CLK_USDHC2_CLK		0x0>,
 			<MX8MM_IOMUXC_SD2_CMD_USDHC2_CMD		0x0>,
 			<MX8MM_IOMUXC_SD2_DATA0_USDHC2_DATA0		0x0>,
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 2a4e686e633c..8a6b7feca3e4 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -81,6 +81,7 @@
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
 #define ARM_CPU_PART_CORTEX_X1		0xD44
 #define ARM_CPU_PART_CORTEX_A510	0xD46
+#define ARM_CPU_PART_CORTEX_X1C		0xD4C
 #define ARM_CPU_PART_CORTEX_A520	0xD80
 #define ARM_CPU_PART_CORTEX_A710	0xD47
 #define ARM_CPU_PART_CORTEX_A715	0xD4D
@@ -166,6 +167,7 @@
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
 #define MIDR_CORTEX_X1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1)
 #define MIDR_CORTEX_A510 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A510)
+#define MIDR_CORTEX_X1C MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
 #define MIDR_CORTEX_A520 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A520)
 #define MIDR_CORTEX_A710 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A710)
 #define MIDR_CORTEX_A715 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A715)
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index bc77869dbd43..509c874de5c7 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -693,6 +693,7 @@ u32 aarch64_insn_gen_cas(enum aarch64_insn_register result,
 }
 #endif
 u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type);
+u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type);
 u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
 			 enum aarch64_insn_system_register sysreg);
 
diff --git a/arch/arm64/include/asm/spectre.h b/arch/arm64/include/asm/spectre.h
index f1524cdeacf1..8fef12626090 100644
--- a/arch/arm64/include/asm/spectre.h
+++ b/arch/arm64/include/asm/spectre.h
@@ -97,6 +97,9 @@ enum mitigation_state arm64_get_meltdown_state(void);
 
 enum mitigation_state arm64_get_spectre_bhb_state(void);
 bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry, int scope);
+extern bool __nospectre_bhb;
+u8 get_spectre_bhb_loop_value(void);
+bool is_spectre_bhb_fw_mitigated(void);
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *__unused);
 bool try_emulate_el1_ssbs(struct pt_regs *regs, u32 instr);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 709f2b51be6d..05ccf4ec278f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -111,7 +111,14 @@ static struct arm64_cpu_capabilities const __ro_after_init *cpucap_ptrs[ARM64_NC
 
 DECLARE_BITMAP(boot_cpucaps, ARM64_NCAPS);
 
-bool arm64_use_ng_mappings = false;
+/*
+ * arm64_use_ng_mappings must be placed in the .data section, otherwise it
+ * ends up in the .bss section where it is initialized in early_map_kernel()
+ * after the MMU (with the idmap) was enabled. create_init_idmap() - which
+ * runs before early_map_kernel() and reads the variable via PTE_MAYBE_NG -
+ * may end up generating an incorrect idmap page table attributes.
+ */
+bool arm64_use_ng_mappings __read_mostly = false;
 EXPORT_SYMBOL(arm64_use_ng_mappings);
 
 DEFINE_PER_CPU_READ_MOSTLY(const char *, this_cpu_vector) = vectors;
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 30e79f111b35..8ef3335ecff7 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -891,6 +891,7 @@ static u8 spectre_bhb_loop_affected(void)
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
 		MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
@@ -998,6 +999,11 @@ bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entry,
 	return true;
 }
 
+u8 get_spectre_bhb_loop_value(void)
+{
+	return max_bhb_k;
+}
+
 static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
 {
 	const char *v = arm64_get_bp_hardening_vector(slot);
@@ -1015,7 +1021,7 @@ static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
 	isb();
 }
 
-static bool __read_mostly __nospectre_bhb;
+bool __read_mostly __nospectre_bhb;
 static int __init parse_spectre_bhb_param(char *str)
 {
 	__nospectre_bhb = true;
@@ -1093,6 +1099,11 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 	update_mitigation_state(&spectre_bhb_state, state);
 }
 
+bool is_spectre_bhb_fw_mitigated(void)
+{
+	return test_bit(BHB_FW, &system_bhb_mitigations);
+}
+
 /* Patched to NOP when enabled */
 void noinstr spectre_bhb_patch_loop_mitigation_enable(struct alt_instr *alt,
 						     __le32 *origptr,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index b008a9b46a7f..36d33e064ea0 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2014-2016 Zi Shen Lim <zlim.lnx@gmail.com>
  */
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/printk.h>
@@ -1471,43 +1472,41 @@ u32 aarch64_insn_gen_extr(enum aarch64_insn_variant variant,
 	return aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RM, insn, Rm);
 }
 
-u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
+static u32 __get_barrier_crm_val(enum aarch64_insn_mb_type type)
 {
-	u32 opt;
-	u32 insn;
-
 	switch (type) {
 	case AARCH64_INSN_MB_SY:
-		opt = 0xf;
-		break;
+		return 0xf;
 	case AARCH64_INSN_MB_ST:
-		opt = 0xe;
-		break;
+		return 0xe;
 	case AARCH64_INSN_MB_LD:
-		opt = 0xd;
-		break;
+		return 0xd;
 	case AARCH64_INSN_MB_ISH:
-		opt = 0xb;
-		break;
+		return 0xb;
 	case AARCH64_INSN_MB_ISHST:
-		opt = 0xa;
-		break;
+		return 0xa;
 	case AARCH64_INSN_MB_ISHLD:
-		opt = 0x9;
-		break;
+		return 0x9;
 	case AARCH64_INSN_MB_NSH:
-		opt = 0x7;
-		break;
+		return 0x7;
 	case AARCH64_INSN_MB_NSHST:
-		opt = 0x6;
-		break;
+		return 0x6;
 	case AARCH64_INSN_MB_NSHLD:
-		opt = 0x5;
-		break;
+		return 0x5;
 	default:
-		pr_err("%s: unknown dmb type %d\n", __func__, type);
+		pr_err("%s: unknown barrier type %d\n", __func__, type);
 		return AARCH64_BREAK_FAULT;
 	}
+}
+
+u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
+{
+	u32 opt;
+	u32 insn;
+
+	opt = __get_barrier_crm_val(type);
+	if (opt == AARCH64_BREAK_FAULT)
+		return AARCH64_BREAK_FAULT;
 
 	insn = aarch64_insn_get_dmb_value();
 	insn &= ~GENMASK(11, 8);
@@ -1516,6 +1515,21 @@ u32 aarch64_insn_gen_dmb(enum aarch64_insn_mb_type type)
 	return insn;
 }
 
+u32 aarch64_insn_gen_dsb(enum aarch64_insn_mb_type type)
+{
+	u32 opt, insn;
+
+	opt = __get_barrier_crm_val(type);
+	if (opt == AARCH64_BREAK_FAULT)
+		return AARCH64_BREAK_FAULT;
+
+	insn = aarch64_insn_get_dsb_base_value();
+	insn &= ~GENMASK(11, 8);
+	insn |= (opt << 8);
+
+	return insn;
+}
+
 u32 aarch64_insn_gen_mrs(enum aarch64_insn_register result,
 			 enum aarch64_insn_system_register sysreg)
 {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 27ef366363e4..515c411c2c83 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) "bpf_jit: " fmt
 
+#include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
 #include <linux/filter.h>
@@ -17,6 +18,7 @@
 #include <asm/asm-extable.h>
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
+#include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/patching.h>
@@ -857,7 +859,51 @@ static void build_plt(struct jit_ctx *ctx)
 		plt->target = (u64)&dummy_tramp;
 }
 
-static void build_epilogue(struct jit_ctx *ctx)
+/* Clobbers BPF registers 1-4, aka x0-x3 */
+static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
+{
+	const u8 r1 = bpf2a64[BPF_REG_1]; /* aka x0 */
+	u8 k = get_spectre_bhb_loop_value();
+
+	if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY) ||
+	    cpu_mitigations_off() || __nospectre_bhb ||
+	    arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE)
+		return;
+
+	if (capable(CAP_SYS_ADMIN))
+		return;
+
+	if (supports_clearbhb(SCOPE_SYSTEM)) {
+		emit(aarch64_insn_gen_hint(AARCH64_INSN_HINT_CLEARBHB), ctx);
+		return;
+	}
+
+	if (k) {
+		emit_a64_mov_i64(r1, k, ctx);
+		emit(A64_B(1), ctx);
+		emit(A64_SUBS_I(true, r1, r1, 1), ctx);
+		emit(A64_B_(A64_COND_NE, -2), ctx);
+		emit(aarch64_insn_gen_dsb(AARCH64_INSN_MB_ISH), ctx);
+		emit(aarch64_insn_get_isb_value(), ctx);
+	}
+
+	if (is_spectre_bhb_fw_mitigated()) {
+		emit(A64_ORR_I(false, r1, AARCH64_INSN_REG_ZR,
+			       ARM_SMCCC_ARCH_WORKAROUND_3), ctx);
+		switch (arm_smccc_1_1_get_conduit()) {
+		case SMCCC_CONDUIT_HVC:
+			emit(aarch64_insn_get_hvc_value(), ctx);
+			break;
+		case SMCCC_CONDUIT_SMC:
+			emit(aarch64_insn_get_smc_value(), ctx);
+			break;
+		default:
+			pr_err_once("Firmware mitigation enabled with unknown conduit\n");
+		}
+	}
+}
+
+static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 {
 	const u8 r0 = bpf2a64[BPF_REG_0];
 	const u8 ptr = bpf2a64[TCCNT_PTR];
@@ -870,10 +916,13 @@ static void build_epilogue(struct jit_ctx *ctx)
 
 	emit(A64_POP(A64_ZR, ptr, A64_SP), ctx);
 
+	if (was_classic)
+		build_bhb_mitigation(ctx);
+
 	/* Restore FP/LR registers */
 	emit(A64_POP(A64_FP, A64_LR, A64_SP), ctx);
 
-	/* Set return value */
+	/* Move the return value from bpf:r0 (aka x7) to x0 */
 	emit(A64_MOV(1, A64_R(0), r0), ctx);
 
 	/* Authenticate lr */
@@ -1817,7 +1866,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.epilogue_offset = ctx.idx;
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, was_classic);
 	build_plt(&ctx);
 
 	extable_align = __alignof__(struct exception_table_entry);
@@ -1880,7 +1929,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		goto out_free_hdr;
 	}
 
-	build_epilogue(&ctx);
+	build_epilogue(&ctx, was_classic);
 	build_plt(&ctx);
 
 	/* Extra pass to validate JITed code. */
diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index 4a2b40ce39e0..841612913f0d 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -65,7 +65,8 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
-#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last))
+#define MAX_REG_OFFSET \
+	(offsetof(struct pt_regs, __last) - sizeof(unsigned long))
 
 /**
  * regs_get_register() - get register value from its offset
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8ff8e8b36524..9c83848797a7 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -198,47 +198,57 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 DO_ERROR_INFO(do_trap_load_fault,
 	SIGSEGV, SEGV_ACCERR, "load access fault");
 
-asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
+enum misaligned_access_type {
+	MISALIGNED_STORE,
+	MISALIGNED_LOAD,
+};
+static const struct {
+	const char *type_str;
+	int (*handler)(struct pt_regs *regs);
+} misaligned_handler[] = {
+	[MISALIGNED_STORE] = {
+		.type_str = "Oops - store (or AMO) address misaligned",
+		.handler = handle_misaligned_store,
+	},
+	[MISALIGNED_LOAD] = {
+		.type_str = "Oops - load address misaligned",
+		.handler = handle_misaligned_load,
+	},
+};
+
+static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type type)
 {
+	irqentry_state_t state;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
+		local_irq_enable();
+	} else {
+		state = irqentry_nmi_enter(regs);
+	}
 
-		if (handle_misaligned_load(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
+	if (misaligned_handler[type].handler(regs))
+		do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+			      misaligned_handler[type].type_str);
 
+	if (user_mode(regs)) {
+		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		if (handle_misaligned_load(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-			      "Oops - load address misaligned");
-
 		irqentry_nmi_exit(regs, state);
 	}
 }
 
-asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
 {
-	if (user_mode(regs)) {
-		irqentry_enter_from_user_mode(regs);
-
-		if (handle_misaligned_store(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-				"Oops - store (or AMO) address misaligned");
-
-		irqentry_exit_to_user_mode(regs);
-	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
-
-		if (handle_misaligned_store(regs))
-			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
-				"Oops - store (or AMO) address misaligned");
+	do_trap_misaligned(regs, MISALIGNED_LOAD);
+}
 
-		irqentry_nmi_exit(regs, state);
-	}
+asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
+{
+	do_trap_misaligned(regs, MISALIGNED_STORE);
 }
+
 DO_ERROR_INFO(do_trap_store_fault,
 	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
 DO_ERROR_INFO(do_trap_ecall_s,
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 9a80a12f6b48..d14bfc23e315 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -87,6 +87,13 @@
 #define INSN_MATCH_C_FSWSP		0xe002
 #define INSN_MASK_C_FSWSP		0xe003
 
+#define INSN_MATCH_C_LHU		0x8400
+#define INSN_MASK_C_LHU			0xfc43
+#define INSN_MATCH_C_LH			0x8440
+#define INSN_MASK_C_LH			0xfc43
+#define INSN_MATCH_C_SH			0x8c00
+#define INSN_MASK_C_SH			0xfc43
+
 #define INSN_LEN(insn)			((((insn) & 0x3) < 0x3) ? 2 : 4)
 
 #if defined(CONFIG_64BIT)
@@ -405,6 +412,13 @@ int handle_misaligned_load(struct pt_regs *regs)
 		fp = 1;
 		len = 4;
 #endif
+	} else if ((insn & INSN_MASK_C_LHU) == INSN_MATCH_C_LHU) {
+		len = 2;
+		insn = RVC_RS2S(insn) << SH_RD;
+	} else if ((insn & INSN_MASK_C_LH) == INSN_MATCH_C_LH) {
+		len = 2;
+		shift = 8 * (sizeof(ulong) - len);
+		insn = RVC_RS2S(insn) << SH_RD;
 	} else {
 		regs->epc = epc;
 		return -1;
@@ -504,6 +518,9 @@ int handle_misaligned_store(struct pt_regs *regs)
 		len = 4;
 		val.data_ulong = GET_F32_RS2C(insn, regs);
 #endif
+	} else if ((insn & INSN_MASK_C_SH) == INSN_MATCH_C_SH) {
+		len = 2;
+		val.data_ulong = GET_RS2S(insn, regs);
 	} else {
 		regs->epc = epc;
 		return -1;
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index a7de838f8031..669d335c87ab 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -636,7 +636,8 @@ SYM_CODE_START(stack_overflow)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_R8(64,%r11),0(%r14)
-	stg	%r10,__PT_ORIG_GPR2(%r11) # store last break to orig_gpr2
+	GET_LC	%r2
+	mvc	__PT_ORIG_GPR2(8,%r11),__LC_PGM_LAST_BREAK(%r2)
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	jg	kernel_stack_overflow
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index 74dac6da03d5..8edd13237a17 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -422,6 +422,8 @@ static void __clp_add(struct clp_fh_list_entry *entry, void *data)
 		return;
 	}
 	zdev = zpci_create_device(entry->fid, entry->fh, entry->config_state);
+	if (IS_ERR(zdev))
+		return;
 	list_add_tail(&zdev->entry, scan_list);
 }
 
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 138908b999d7..b22226634ff6 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -83,8 +83,6 @@ extern void time_travel_not_configured(void);
 #define time_travel_del_event(...) time_travel_not_configured()
 #endif /* CONFIG_UML_TIME_TRAVEL_SUPPORT */
 
-extern unsigned long tt_extra_sched_jiffies;
-
 /*
  * Without CONFIG_UML_TIME_TRAVEL_SUPPORT this is a linker error if used,
  * which is intentional since we really shouldn't link it in that case.
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index a5beaea2967e..b09e85279d2b 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -31,17 +31,6 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
-
-	/*
-	 * If no time passes, then sched_yield may not actually yield, causing
-	 * broken spinlock implementations in userspace (ASAN) to hang for long
-	 * periods of time.
-	 */
-	if ((time_travel_mode == TT_MODE_INFCPU ||
-	     time_travel_mode == TT_MODE_EXTERNAL) &&
-	    syscall == __NR_sched_yield)
-		tt_extra_sched_jiffies += 1;
-
 	if (syscall >= 0 && syscall < __NR_syscalls) {
 		unsigned long ret = EXECUTE_SYSCALL(syscall, regs);
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e54da3b4d334..7b3622ba4c3c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2747,6 +2747,18 @@ config MITIGATION_SSB
 	  of speculative execution in a similar way to the Meltdown and Spectre
 	  security vulnerabilities.
 
+config MITIGATION_ITS
+	bool "Enable Indirect Target Selection mitigation"
+	depends on CPU_SUP_INTEL && X86_64
+	depends on MITIGATION_RETPOLINE && MITIGATION_RETHUNK
+	select EXECMEM
+	default y
+	help
+	  Enable Indirect Target Selection (ITS) mitigation. ITS is a bug in
+	  BPU on some Intel CPUs that may allow Spectre V2 style attacks. If
+	  disabled, mitigation cannot be enabled via cmdline.
+	  See <file:Documentation/admin-guide/hw-vuln/indirect-target-selection.rst>
+
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1b5be07f8669..9c6a110a52d4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1524,7 +1524,9 @@ SYM_CODE_END(rewind_stack_and_make_dead)
  * ORC to unwind properly.
  *
  * The alignment is for performance and not for safety, and may be safely
- * refactored in the future if needed.
+ * refactored in the future if needed. The .skips are for safety, to ensure
+ * that all RETs are in the second half of a cacheline to mitigate Indirect
+ * Target Selection, rather than taking the slowpath via its_return_thunk.
  */
 SYM_FUNC_START(clear_bhb_loop)
 	push	%rbp
@@ -1534,10 +1536,22 @@ SYM_FUNC_START(clear_bhb_loop)
 	call	1f
 	jmp	5f
 	.align 64, 0xcc
+	/*
+	 * Shift instructions so that the RET is in the upper half of the
+	 * cacheline and don't take the slowpath to its_return_thunk.
+	 */
+	.skip 32 - (.Lret1 - 1f), 0xcc
 	ANNOTATE_INTRA_FUNCTION_CALL
 1:	call	2f
-	RET
+.Lret1:	RET
 	.align 64, 0xcc
+	/*
+	 * As above shift instructions for RET at .Lret2 as well.
+	 *
+	 * This should be ideally be: .skip 32 - (.Lret2 - 2f), 0xcc
+	 * but some Clang versions (e.g. 18) don't like this.
+	 */
+	.skip 32 - 18, 0xcc
 2:	movl	$5, %eax
 3:	jmp	4f
 	nop
@@ -1545,7 +1559,7 @@ SYM_FUNC_START(clear_bhb_loop)
 	jnz	3b
 	sub	$1, %ecx
 	jnz	1b
-	RET
+.Lret2:	RET
 5:	lfence
 	pop	%rbp
 	RET
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index ca9ae606aab9..f8dab517de8a 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/stringify.h>
 #include <asm/asm.h>
+#include <asm/bug.h>
 
 #define ALT_FLAGS_SHIFT		16
 
@@ -134,6 +135,37 @@ static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
 }
 #endif
 
+#ifdef CONFIG_MITIGATION_ITS
+extern void its_init_mod(struct module *mod);
+extern void its_fini_mod(struct module *mod);
+extern void its_free_mod(struct module *mod);
+extern u8 *its_static_thunk(int reg);
+#else /* CONFIG_MITIGATION_ITS */
+static inline void its_init_mod(struct module *mod) { }
+static inline void its_fini_mod(struct module *mod) { }
+static inline void its_free_mod(struct module *mod) { }
+static inline u8 *its_static_thunk(int reg)
+{
+	WARN_ONCE(1, "ITS not compiled in");
+
+	return NULL;
+}
+#endif
+
+#if defined(CONFIG_MITIGATION_RETHUNK) && defined(CONFIG_OBJTOOL)
+extern bool cpu_wants_rethunk(void);
+extern bool cpu_wants_rethunk_at(void *addr);
+#else
+static __always_inline bool cpu_wants_rethunk(void)
+{
+	return false;
+}
+static __always_inline bool cpu_wants_rethunk_at(void *addr)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SMP
 extern void alternatives_smp_module_add(struct module *mod, char *name,
 					void *locks, void *locks_end,
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 64fa42175a15..308e7d97135c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -475,6 +475,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_FAST_CPPC		(21*32 + 5) /* AMD Fast CPPC */
+#define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32 + 6) /* Use thunk for indirect branches in lower half of cacheline */
 
 /*
  * BUG word(s)
@@ -526,4 +527,6 @@
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_ITS			X86_BUG(1*32 + 5) /* "its" CPU is affected by Indirect Target Selection */
+#define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 6) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 695e569159c1..be7cddc414e4 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -17,10 +17,12 @@ struct ucode_cpu_info {
 void load_ucode_bsp(void);
 void load_ucode_ap(void);
 void microcode_bsp_resume(void);
+bool __init microcode_loader_disabled(void);
 #else
 static inline void load_ucode_bsp(void)	{ }
 static inline void load_ucode_ap(void) { }
 static inline void microcode_bsp_resume(void) { }
+static inline bool __init microcode_loader_disabled(void) { return false; }
 #endif
 
 extern unsigned long initrd_start_early;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 61e991507353..ac25f9eb5912 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -209,6 +209,14 @@
 						 * VERW clears CPU Register
 						 * File.
 						 */
+#define ARCH_CAP_ITS_NO			BIT_ULL(62) /*
+						     * Not susceptible to
+						     * Indirect Target Selection.
+						     * This bit is not set by
+						     * HW, but is synthesized by
+						     * VMMs for guests to know
+						     * their affected status.
+						     */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 96b410b1d4e8..f7bb0016d7d9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -210,9 +210,8 @@
 .endm
 
 /*
- * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
- * to the retpoline thunk with a CS prefix when the register requires
- * a RAX prefix byte to encode. Also see apply_retpolines().
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
  */
 .macro __CS_PREFIX reg:req
 	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
@@ -356,10 +355,14 @@
 	".long 999b\n\t"					\
 	".popsection\n\t"
 
+#define ITS_THUNK_SIZE	64
+
 typedef u8 retpoline_thunk_t[RETPOLINE_THUNK_SIZE];
+typedef u8 its_thunk_t[ITS_THUNK_SIZE];
 extern retpoline_thunk_t __x86_indirect_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
+extern its_thunk_t	 __x86_indirect_its_thunk_array[];
 
 #ifdef CONFIG_MITIGATION_RETHUNK
 extern void __x86_return_thunk(void);
@@ -383,6 +386,12 @@ static inline void srso_return_thunk(void) {}
 static inline void srso_alias_return_thunk(void) {}
 #endif
 
+#ifdef CONFIG_MITIGATION_ITS
+extern void its_return_thunk(void);
+#else
+static inline void its_return_thunk(void) {}
+#endif
+
 extern void retbleed_return_thunk(void);
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
@@ -438,20 +447,23 @@ static inline void call_depth_return_thunk(void) {}
 
 #ifdef CONFIG_X86_64
 
+/*
+ * Emits a conditional CS prefix that is compatible with
+ * -mindirect-branch-cs-prefix.
+ */
+#define __CS_PREFIX(reg)				\
+	".irp rs,r8,r9,r10,r11,r12,r13,r14,r15\n"	\
+	".ifc \\rs," reg "\n"				\
+	".byte 0x2e\n"					\
+	".endif\n"					\
+	".endr\n"
+
 /*
  * Inline asm uses the %V modifier which is only in newer GCC
  * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
  */
-# define CALL_NOSPEC						\
-	ALTERNATIVE_2(						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	"call __x86_indirect_thunk_%V[thunk_target]\n",		\
-	X86_FEATURE_RETPOLINE,					\
-	"lfence;\n"						\
-	ANNOTATE_RETPOLINE_SAFE					\
-	"call *%[thunk_target]\n",				\
-	X86_FEATURE_RETPOLINE_LFENCE)
+#define CALL_NOSPEC	__CS_PREFIX("%V[thunk_target]")	\
+			"call __x86_indirect_thunk_%V[thunk_target]\n"
 
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d17518ca19b8..66e77bd7d511 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -18,6 +18,7 @@
 #include <linux/mmu_context.h>
 #include <linux/bsearch.h>
 #include <linux/sync_core.h>
+#include <linux/execmem.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -31,6 +32,8 @@
 #include <asm/paravirt.h>
 #include <asm/asm-prototypes.h>
 #include <asm/cfi.h>
+#include <asm/ibt.h>
+#include <asm/set_memory.h>
 
 int __read_mostly alternatives_patched;
 
@@ -124,6 +127,136 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 #endif
 };
 
+#ifdef CONFIG_MITIGATION_ITS
+
+#ifdef CONFIG_MODULES
+static struct module *its_mod;
+#endif
+static void *its_page;
+static unsigned int its_offset;
+
+/* Initialize a thunk with the "jmp *reg; int3" instructions. */
+static void *its_init_thunk(void *thunk, int reg)
+{
+	u8 *bytes = thunk;
+	int i = 0;
+
+	if (reg >= 8) {
+		bytes[i++] = 0x41; /* REX.B prefix */
+		reg -= 8;
+	}
+	bytes[i++] = 0xff;
+	bytes[i++] = 0xe0 + reg; /* jmp *reg */
+	bytes[i++] = 0xcc;
+
+	return thunk;
+}
+
+#ifdef CONFIG_MODULES
+void its_init_mod(struct module *mod)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return;
+
+	mutex_lock(&text_mutex);
+	its_mod = mod;
+	its_page = NULL;
+}
+
+void its_fini_mod(struct module *mod)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return;
+
+	WARN_ON_ONCE(its_mod != mod);
+
+	its_mod = NULL;
+	its_page = NULL;
+	mutex_unlock(&text_mutex);
+
+	for (int i = 0; i < mod->its_num_pages; i++) {
+		void *page = mod->its_page_array[i];
+		set_memory_rox((unsigned long)page, 1);
+	}
+}
+
+void its_free_mod(struct module *mod)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return;
+
+	for (int i = 0; i < mod->its_num_pages; i++) {
+		void *page = mod->its_page_array[i];
+		execmem_free(page);
+	}
+	kfree(mod->its_page_array);
+}
+#endif /* CONFIG_MODULES */
+
+static void *its_alloc(void)
+{
+	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
+
+	if (!page)
+		return NULL;
+
+#ifdef CONFIG_MODULES
+	if (its_mod) {
+		void *tmp = krealloc(its_mod->its_page_array,
+				     (its_mod->its_num_pages+1) * sizeof(void *),
+				     GFP_KERNEL);
+		if (!tmp)
+			return NULL;
+
+		its_mod->its_page_array = tmp;
+		its_mod->its_page_array[its_mod->its_num_pages++] = page;
+	}
+#endif /* CONFIG_MODULES */
+
+	return no_free_ptr(page);
+}
+
+static void *its_allocate_thunk(int reg)
+{
+	int size = 3 + (reg / 8);
+	void *thunk;
+
+	if (!its_page || (its_offset + size - 1) >= PAGE_SIZE) {
+		its_page = its_alloc();
+		if (!its_page) {
+			pr_err("ITS page allocation failed\n");
+			return NULL;
+		}
+		memset(its_page, INT3_INSN_OPCODE, PAGE_SIZE);
+		its_offset = 32;
+	}
+
+	/*
+	 * If the indirect branch instruction will be in the lower half
+	 * of a cacheline, then update the offset to reach the upper half.
+	 */
+	if ((its_offset + size - 1) % 64 < 32)
+		its_offset = ((its_offset - 1) | 0x3F) + 33;
+
+	thunk = its_page + its_offset;
+	its_offset += size;
+
+	set_memory_rw((unsigned long)its_page, 1);
+	thunk = its_init_thunk(thunk, reg);
+	set_memory_rox((unsigned long)its_page, 1);
+
+	return thunk;
+}
+
+u8 *its_static_thunk(int reg)
+{
+	u8 *thunk = __x86_indirect_its_thunk_array[reg];
+
+	return thunk;
+}
+
+#endif
+
 /*
  * Nomenclature for variable names to simplify and clarify this code and ease
  * any potential staring at it:
@@ -581,7 +714,8 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 	return i;
 }
 
-static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8 *bytes)
+static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
+			     void *call_dest, void *jmp_dest)
 {
 	u8 op = insn->opcode.bytes[0];
 	int i = 0;
@@ -602,7 +736,7 @@ static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
 	switch (op) {
 	case CALL_INSN_OPCODE:
 		__text_gen_insn(bytes+i, op, addr+i,
-				__x86_indirect_call_thunk_array[reg],
+				call_dest,
 				CALL_INSN_SIZE);
 		i += CALL_INSN_SIZE;
 		break;
@@ -610,7 +744,7 @@ static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
 	case JMP32_INSN_OPCODE:
 clang_jcc:
 		__text_gen_insn(bytes+i, op, addr+i,
-				__x86_indirect_jump_thunk_array[reg],
+				jmp_dest,
 				JMP32_INSN_SIZE);
 		i += JMP32_INSN_SIZE;
 		break;
@@ -625,6 +759,39 @@ static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8
 	return i;
 }
 
+static int emit_call_track_retpoline(void *addr, struct insn *insn, int reg, u8 *bytes)
+{
+	return __emit_trampoline(addr, insn, bytes,
+				 __x86_indirect_call_thunk_array[reg],
+				 __x86_indirect_jump_thunk_array[reg]);
+}
+
+#ifdef CONFIG_MITIGATION_ITS
+static int emit_its_trampoline(void *addr, struct insn *insn, int reg, u8 *bytes)
+{
+	u8 *thunk = __x86_indirect_its_thunk_array[reg];
+	u8 *tmp = its_allocate_thunk(reg);
+
+	if (tmp)
+		thunk = tmp;
+
+	return __emit_trampoline(addr, insn, bytes, thunk, thunk);
+}
+
+/* Check if an indirect branch is at ITS-unsafe address */
+static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
+		return false;
+
+	/* Indirect branch opcode is 2 or 3 bytes depending on reg */
+	addr += 1 + reg / 8;
+
+	/* Lower-half of the cacheline? */
+	return !(addr & 0x20);
+}
+#endif
+
 /*
  * Rewrite the compiler generated retpoline thunk calls.
  *
@@ -699,6 +866,15 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 		bytes[i++] = 0xe8; /* LFENCE */
 	}
 
+#ifdef CONFIG_MITIGATION_ITS
+	/*
+	 * Check if the address of last byte of emitted-indirect is in
+	 * lower-half of the cacheline. Such branches need ITS mitigation.
+	 */
+	if (cpu_wants_indirect_its_thunk_at((unsigned long)addr + i, reg))
+		return emit_its_trampoline(addr, insn, reg, bytes);
+#endif
+
 	ret = emit_indirect(op, reg, bytes + i);
 	if (ret < 0)
 		return ret;
@@ -770,6 +946,21 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 
 #ifdef CONFIG_MITIGATION_RETHUNK
 
+bool cpu_wants_rethunk(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_RETHUNK);
+}
+
+bool cpu_wants_rethunk_at(void *addr)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_RETHUNK))
+		return false;
+	if (x86_return_thunk != its_return_thunk)
+		return true;
+
+	return !((unsigned long)addr & 0x20);
+}
+
 /*
  * Rewrite the compiler generated return thunk tail-calls.
  *
@@ -786,7 +977,7 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 	int i = 0;
 
 	/* Patch the custom return thunks... */
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+	if (cpu_wants_rethunk_at(addr)) {
 		i = JMP32_INSN_SIZE;
 		__text_gen_insn(bytes, JMP32_INSN_OPCODE, addr, x86_return_thunk, i);
 	} else {
@@ -803,7 +994,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 {
 	s32 *s;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+	if (cpu_wants_rethunk())
 		static_call_force_reinit();
 
 	for (s = start; s < end; s++) {
@@ -1665,6 +1856,8 @@ static noinline void __init alt_reloc_selftest(void)
 
 void __init alternative_instructions(void)
 {
+	u64 ibt;
+
 	int3_selftest();
 
 	/*
@@ -1691,6 +1884,9 @@ void __init alternative_instructions(void)
 	 */
 	paravirt_set_cap();
 
+	/* Keep CET-IBT disabled until caller/callee are patched */
+	ibt = ibt_save(/*disable*/ true);
+
 	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
 			__cfi_sites, __cfi_sites_end, true);
 
@@ -1714,6 +1910,8 @@ void __init alternative_instructions(void)
 	 */
 	apply_seal_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
 
+	ibt_restore(ibt);
+
 #ifdef CONFIG_SMP
 	/* Patch to UP if other cpus not imminent. */
 	if (!noreplace_smp && (num_present_cpus() == 1 || setup_max_cpus <= 1)) {
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 46bddb5bb15f..c683abd640fd 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -49,6 +49,7 @@ static void __init srbds_select_mitigation(void);
 static void __init l1d_flush_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
+static void __init its_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -67,6 +68,14 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
 
 void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
 
+static void __init set_return_thunk(void *thunk)
+{
+	if (x86_return_thunk != __x86_return_thunk)
+		pr_warn("x86/bugs: return thunk changed\n");
+
+	x86_return_thunk = thunk;
+}
+
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
 static void update_spec_ctrl(u64 val)
 {
@@ -175,6 +184,7 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+	its_select_mitigation();
 }
 
 /*
@@ -1104,7 +1114,7 @@ static void __init retbleed_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_UNRET);
 
-		x86_return_thunk = retbleed_return_thunk;
+		set_return_thunk(retbleed_return_thunk);
 
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
 		    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
@@ -1139,7 +1149,7 @@ static void __init retbleed_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
 		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
 
-		x86_return_thunk = call_depth_return_thunk;
+		set_return_thunk(call_depth_return_thunk);
 		break;
 
 	default:
@@ -1173,6 +1183,145 @@ static void __init retbleed_select_mitigation(void)
 	pr_info("%s\n", retbleed_strings[retbleed_mitigation]);
 }
 
+#undef pr_fmt
+#define pr_fmt(fmt)     "ITS: " fmt
+
+enum its_mitigation_cmd {
+	ITS_CMD_OFF,
+	ITS_CMD_ON,
+	ITS_CMD_VMEXIT,
+	ITS_CMD_RSB_STUFF,
+};
+
+enum its_mitigation {
+	ITS_MITIGATION_OFF,
+	ITS_MITIGATION_VMEXIT_ONLY,
+	ITS_MITIGATION_ALIGNED_THUNKS,
+	ITS_MITIGATION_RETPOLINE_STUFF,
+};
+
+static const char * const its_strings[] = {
+	[ITS_MITIGATION_OFF]			= "Vulnerable",
+	[ITS_MITIGATION_VMEXIT_ONLY]		= "Mitigation: Vulnerable, KVM: Not affected",
+	[ITS_MITIGATION_ALIGNED_THUNKS]		= "Mitigation: Aligned branch/return thunks",
+	[ITS_MITIGATION_RETPOLINE_STUFF]	= "Mitigation: Retpolines, Stuffing RSB",
+};
+
+static enum its_mitigation its_mitigation __ro_after_init = ITS_MITIGATION_ALIGNED_THUNKS;
+
+static enum its_mitigation_cmd its_cmd __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_ITS) ? ITS_CMD_ON : ITS_CMD_OFF;
+
+static int __init its_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!IS_ENABLED(CONFIG_MITIGATION_ITS)) {
+		pr_err("Mitigation disabled at compile time, ignoring option (%s)", str);
+		return 0;
+	}
+
+	if (!strcmp(str, "off")) {
+		its_cmd = ITS_CMD_OFF;
+	} else if (!strcmp(str, "on")) {
+		its_cmd = ITS_CMD_ON;
+	} else if (!strcmp(str, "force")) {
+		its_cmd = ITS_CMD_ON;
+		setup_force_cpu_bug(X86_BUG_ITS);
+	} else if (!strcmp(str, "vmexit")) {
+		its_cmd = ITS_CMD_VMEXIT;
+	} else if (!strcmp(str, "stuff")) {
+		its_cmd = ITS_CMD_RSB_STUFF;
+	} else {
+		pr_err("Ignoring unknown indirect_target_selection option (%s).", str);
+	}
+
+	return 0;
+}
+early_param("indirect_target_selection", its_parse_cmdline);
+
+static void __init its_select_mitigation(void)
+{
+	enum its_mitigation_cmd cmd = its_cmd;
+
+	if (!boot_cpu_has_bug(X86_BUG_ITS) || cpu_mitigations_off()) {
+		its_mitigation = ITS_MITIGATION_OFF;
+		return;
+	}
+
+	/* Retpoline+CDT mitigates ITS, bail out */
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
+	    boot_cpu_has(X86_FEATURE_CALL_DEPTH)) {
+		its_mitigation = ITS_MITIGATION_RETPOLINE_STUFF;
+		goto out;
+	}
+
+	/* Exit early to avoid irrelevant warnings */
+	if (cmd == ITS_CMD_OFF) {
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+	if (spectre_v2_enabled == SPECTRE_V2_NONE) {
+		pr_err("WARNING: Spectre-v2 mitigation is off, disabling ITS\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+	if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) ||
+	    !IS_ENABLED(CONFIG_MITIGATION_RETHUNK)) {
+		pr_err("WARNING: ITS mitigation depends on retpoline and rethunk support\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+	if (IS_ENABLED(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)) {
+		pr_err("WARNING: ITS mitigation is not compatible with CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+	if (boot_cpu_has(X86_FEATURE_RETPOLINE_LFENCE)) {
+		pr_err("WARNING: ITS mitigation is not compatible with lfence mitigation\n");
+		its_mitigation = ITS_MITIGATION_OFF;
+		goto out;
+	}
+
+	if (cmd == ITS_CMD_RSB_STUFF &&
+	    (!boot_cpu_has(X86_FEATURE_RETPOLINE) || !IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING))) {
+		pr_err("RSB stuff mitigation not supported, using default\n");
+		cmd = ITS_CMD_ON;
+	}
+
+	switch (cmd) {
+	case ITS_CMD_OFF:
+		its_mitigation = ITS_MITIGATION_OFF;
+		break;
+	case ITS_CMD_VMEXIT:
+		if (boot_cpu_has_bug(X86_BUG_ITS_NATIVE_ONLY)) {
+			its_mitigation = ITS_MITIGATION_VMEXIT_ONLY;
+			goto out;
+		}
+		fallthrough;
+	case ITS_CMD_ON:
+		its_mitigation = ITS_MITIGATION_ALIGNED_THUNKS;
+		if (!boot_cpu_has(X86_FEATURE_RETPOLINE))
+			setup_force_cpu_cap(X86_FEATURE_INDIRECT_THUNK_ITS);
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		set_return_thunk(its_return_thunk);
+		break;
+	case ITS_CMD_RSB_STUFF:
+		its_mitigation = ITS_MITIGATION_RETPOLINE_STUFF;
+		setup_force_cpu_cap(X86_FEATURE_RETHUNK);
+		setup_force_cpu_cap(X86_FEATURE_CALL_DEPTH);
+		set_return_thunk(call_depth_return_thunk);
+		if (retbleed_mitigation == RETBLEED_MITIGATION_NONE) {
+			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
+			pr_info("Retbleed mitigation updated to stuffing\n");
+		}
+		break;
+	}
+out:
+	pr_info("%s\n", its_strings[its_mitigation]);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
@@ -1684,11 +1833,11 @@ static void __init bhi_select_mitigation(void)
 			return;
 	}
 
-	/* Mitigate in hardware if supported */
-	if (spec_ctrl_bhi_dis())
+	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
-	if (!IS_ENABLED(CONFIG_X86_64))
+	/* Mitigate in hardware if supported */
+	if (spec_ctrl_bhi_dis())
 		return;
 
 	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
@@ -2624,10 +2773,10 @@ static void __init srso_select_mitigation(void)
 
 			if (boot_cpu_data.x86 == 0x19) {
 				setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				x86_return_thunk = srso_alias_return_thunk;
+				set_return_thunk(srso_alias_return_thunk);
 			} else {
 				setup_force_cpu_cap(X86_FEATURE_SRSO);
-				x86_return_thunk = srso_return_thunk;
+				set_return_thunk(srso_return_thunk);
 			}
 			if (has_microcode)
 				srso_mitigation = SRSO_MITIGATION_SAFE_RET;
@@ -2802,6 +2951,11 @@ static ssize_t rfds_show_state(char *buf)
 	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
 }
 
+static ssize_t its_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", its_strings[its_mitigation]);
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
@@ -2984,6 +3138,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_RFDS:
 		return rfds_show_state(buf);
 
+	case X86_BUG_ITS:
+		return its_show_state(buf);
+
 	default:
 		break;
 	}
@@ -3063,6 +3220,11 @@ ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attrib
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
 }
+
+ssize_t cpu_show_indirect_target_selection(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_ITS);
+}
 #endif
 
 void __warn_thunk(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f439763f45ae..39e9ec3dea98 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1228,6 +1228,10 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define GDS		BIT(6)
 /* CPU is affected by Register File Data Sampling */
 #define RFDS		BIT(7)
+/* CPU is affected by Indirect Target Selection */
+#define ITS		BIT(8)
+/* CPU is affected by Indirect Target Selection, but guest-host isolation is not affected */
+#define ITS_NATIVE_ONLY	BIT(9)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(INTEL_IVYBRIDGE,		X86_STEPPING_ANY,		SRBDS),
@@ -1239,22 +1243,25 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
 	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
 	VULNBL_INTEL_STEPPINGS(INTEL_BROADWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPINGS(0x0, 0x5),	MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_X,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
 	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE_L,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
 	VULNBL_INTEL_STEPPINGS(INTEL_SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPINGS(0x0, 0xb),	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPINGS(0x0, 0xc),	MMIO | RETBLEED | GDS | SRBDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_KABYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
 	VULNBL_INTEL_STEPPINGS(INTEL_CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_ANY,		MMIO | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_ANY,		GDS),
-	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_ANY,		GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_L,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_D,		X86_STEPPING_ANY,		MMIO | GDS | ITS | ITS_NATIVE_ONLY),
+	VULNBL_INTEL_STEPPINGS(INTEL_ICELAKE_X,		X86_STEPPING_ANY,		MMIO | GDS | ITS | ITS_NATIVE_ONLY),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS | ITS_NATIVE_ONLY),
+	VULNBL_INTEL_STEPPINGS(INTEL_TIGERLAKE,		X86_STEPPING_ANY,		GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(INTEL_LAKEFIELD,		X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
-	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
+	VULNBL_INTEL_STEPPINGS(INTEL_ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE,		X86_STEPPING_ANY,		RFDS),
 	VULNBL_INTEL_STEPPINGS(INTEL_ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
 	VULNBL_INTEL_STEPPINGS(INTEL_RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
@@ -1318,6 +1325,32 @@ static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
 	return cpu_matches(cpu_vuln_blacklist, RFDS);
 }
 
+static bool __init vulnerable_to_its(u64 x86_arch_cap_msr)
+{
+	/* The "immunity" bit trumps everything else: */
+	if (x86_arch_cap_msr & ARCH_CAP_ITS_NO)
+		return false;
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return false;
+
+	/* None of the affected CPUs have BHI_CTRL */
+	if (boot_cpu_has(X86_FEATURE_BHI_CTRL))
+		return false;
+
+	/*
+	 * If a VMM did not expose ITS_NO, assume that a guest could
+	 * be running on a vulnerable hardware or may migrate to such
+	 * hardware.
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return true;
+
+	if (cpu_matches(cpu_vuln_blacklist, ITS))
+		return true;
+
+	return false;
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
@@ -1437,9 +1470,12 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	if (vulnerable_to_rfds(x86_arch_cap_msr))
 		setup_force_cpu_bug(X86_BUG_RFDS);
 
-	/* When virtualized, eIBRS could be hidden, assume vulnerable */
-	if (!(x86_arch_cap_msr & ARCH_CAP_BHI_NO) &&
-	    !cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
+	/*
+	 * Intel parts with eIBRS are vulnerable to BHI attacks. Parts with
+	 * BHI_NO still need to use the BHI mitigation to prevent Intra-mode
+	 * attacks.  When virtualized, eIBRS could be hidden, assume vulnerable.
+	 */
+	if (!cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
 	    (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
 	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
 		setup_force_cpu_bug(X86_BUG_BHI);
@@ -1447,6 +1483,12 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
 		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
 
+	if (vulnerable_to_its(x86_arch_cap_msr)) {
+		setup_force_cpu_bug(X86_BUG_ITS);
+		if (cpu_matches(cpu_vuln_blacklist, ITS_NATIVE_ONLY))
+			setup_force_cpu_bug(X86_BUG_ITS_NATIVE_ONLY);
+	}
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 093d3ca43c46..2f84164b20e0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -1099,15 +1099,17 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 
 static int __init save_microcode_in_initrd(void)
 {
-	unsigned int cpuid_1_eax = native_cpuid_eax(1);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	struct cont_desc desc = { 0 };
+	unsigned int cpuid_1_eax;
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
+	if (microcode_loader_disabled() || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
 		return 0;
 
+	cpuid_1_eax = native_cpuid_eax(1);
+
 	if (!find_blobs_in_containers(&cp))
 		return -EINVAL;
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b3658d11e7b6..079f046ee26d 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -41,8 +41,8 @@
 
 #include "internal.h"
 
-static struct microcode_ops	*microcode_ops;
-bool dis_ucode_ldr = true;
+static struct microcode_ops *microcode_ops;
+static bool dis_ucode_ldr = false;
 
 bool force_minrev = IS_ENABLED(CONFIG_MICROCODE_LATE_FORCE_MINREV);
 module_param(force_minrev, bool, S_IRUSR | S_IWUSR);
@@ -84,6 +84,9 @@ static bool amd_check_current_patch_level(void)
 	u32 lvl, dummy, i;
 	u32 *levels;
 
+	if (x86_cpuid_vendor() != X86_VENDOR_AMD)
+		return false;
+
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, lvl, dummy);
 
 	levels = final_levels;
@@ -95,27 +98,29 @@ static bool amd_check_current_patch_level(void)
 	return false;
 }
 
-static bool __init check_loader_disabled_bsp(void)
+bool __init microcode_loader_disabled(void)
 {
-	static const char *__dis_opt_str = "dis_ucode_ldr";
-	const char *cmdline = boot_command_line;
-	const char *option  = __dis_opt_str;
+	if (dis_ucode_ldr)
+		return true;
 
 	/*
-	 * CPUID(1).ECX[31]: reserved for hypervisor use. This is still not
-	 * completely accurate as xen pv guests don't see that CPUID bit set but
-	 * that's good enough as they don't land on the BSP path anyway.
+	 * Disable when:
+	 *
+	 * 1) The CPU does not support CPUID.
+	 *
+	 * 2) Bit 31 in CPUID[1]:ECX is clear
+	 *    The bit is reserved for hypervisor use. This is still not
+	 *    completely accurate as XEN PV guests don't see that CPUID bit
+	 *    set, but that's good enough as they don't land on the BSP
+	 *    path anyway.
+	 *
+	 * 3) Certain AMD patch levels are not allowed to be
+	 *    overwritten.
 	 */
-	if (native_cpuid_ecx(1) & BIT(31))
-		return true;
-
-	if (x86_cpuid_vendor() == X86_VENDOR_AMD) {
-		if (amd_check_current_patch_level())
-			return true;
-	}
-
-	if (cmdline_find_option_bool(cmdline, option) <= 0)
-		dis_ucode_ldr = false;
+	if (!have_cpuid_p() ||
+	    native_cpuid_ecx(1) & BIT(31) ||
+	    amd_check_current_patch_level())
+		dis_ucode_ldr = true;
 
 	return dis_ucode_ldr;
 }
@@ -125,7 +130,10 @@ void __init load_ucode_bsp(void)
 	unsigned int cpuid_1_eax;
 	bool intel = true;
 
-	if (!have_cpuid_p())
+	if (cmdline_find_option_bool(boot_command_line, "dis_ucode_ldr") > 0)
+		dis_ucode_ldr = true;
+
+	if (microcode_loader_disabled())
 		return;
 
 	cpuid_1_eax = native_cpuid_eax(1);
@@ -146,9 +154,6 @@ void __init load_ucode_bsp(void)
 		return;
 	}
 
-	if (check_loader_disabled_bsp())
-		return;
-
 	if (intel)
 		load_ucode_intel_bsp(&early_data);
 	else
@@ -159,6 +164,11 @@ void load_ucode_ap(void)
 {
 	unsigned int cpuid_1_eax;
 
+	/*
+	 * Can't use microcode_loader_disabled() here - .init section
+	 * hell. It doesn't have to either - the BSP variant must've
+	 * parsed cmdline already anyway.
+	 */
 	if (dis_ucode_ldr)
 		return;
 
@@ -810,7 +820,7 @@ static int __init microcode_init(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	int error;
 
-	if (dis_ucode_ldr)
+	if (microcode_loader_disabled())
 		return -EINVAL;
 
 	if (c->x86_vendor == X86_VENDOR_INTEL)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 815fa67356a2..df5650eb3f08 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -395,7 +395,7 @@ static int __init save_builtin_microcode(void)
 	if (xchg(&ucode_patch_va, NULL) != UCODE_BSP_LOADED)
 		return 0;
 
-	if (dis_ucode_ldr || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (microcode_loader_disabled() || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
 	uci.mc = get_microcode_blob(&uci, true);
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 5df621752fef..50a9702ae4e2 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -94,7 +94,6 @@ static inline unsigned int x86_cpuid_family(void)
 	return x86_family(eax);
 }
 
-extern bool dis_ucode_ldr;
 extern bool force_minrev;
 
 #ifdef CONFIG_CPU_SUP_AMD
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 8da0e66ca22d..bfab966ea56e 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -354,7 +354,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		goto fail;
 
 	ip = trampoline + size;
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+	if (cpu_wants_rethunk_at(ip))
 		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
 		memcpy(ip, retq, sizeof(retq));
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index de001b2146ab..375f2d7f1762 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -145,10 +145,6 @@ void __init __no_stack_protector mk_early_pgtbl_32(void)
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
 
 #ifdef CONFIG_MICROCODE_INITRD32
-	/* Running on a hypervisor? */
-	if (native_cpuid_ecx(1) & BIT(31))
-		return;
-
 	params = (struct boot_params *)__pa_nodebug(&boot_params);
 	if (!params->hdr.ramdisk_size || !params->hdr.ramdisk_image)
 		return;
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 837450b6e882..1e231dac61e3 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -251,6 +251,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			ibt_endbr = s;
 	}
 
+	its_init_mod(me);
+
 	if (retpolines || cfi) {
 		void *rseg = NULL, *cseg = NULL;
 		unsigned int rsize = 0, csize = 0;
@@ -271,6 +273,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *rseg = (void *)retpolines->sh_addr;
 		apply_retpolines(rseg, rseg + retpolines->sh_size);
 	}
+
+	its_fini_mod(me);
+
 	if (returns) {
 		void *rseg = (void *)returns->sh_addr;
 		apply_returns(rseg, rseg + returns->sh_size);
@@ -318,4 +323,5 @@ int module_finalize(const Elf_Ehdr *hdr,
 void module_arch_cleanup(struct module *mod)
 {
 	alternatives_smp_module_del(mod);
+	its_free_mod(mod);
 }
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 9e51242ed125..aae909d4ed78 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -81,7 +81,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 		break;
 
 	case RET:
-		if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+		if (cpu_wants_rethunk_at(insn))
 			code = text_gen_insn(JMP32_INSN_OPCODE, insn, x86_return_thunk);
 		else
 			code = &retinsn;
@@ -90,7 +90,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type,
 	case JCC:
 		if (!func) {
 			func = __static_call_return;
-			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+			if (cpu_wants_rethunk())
 				func = x86_return_thunk;
 		}
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index feb8102a9ca7..e2567c8f6bac 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -530,4 +530,14 @@ INIT_PER_CPU(irq_stack_backing_store);
 		"SRSO function pair won't alias");
 #endif
 
+#if defined(CONFIG_MITIGATION_ITS) && !defined(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)
+. = ASSERT(__x86_indirect_its_thunk_rax & 0x20, "__x86_indirect_thunk_rax not in second half of cacheline");
+. = ASSERT(((__x86_indirect_its_thunk_rcx - __x86_indirect_its_thunk_rax) % 64) == 0, "Indirect thunks are not cacheline apart");
+. = ASSERT(__x86_indirect_its_thunk_array == __x86_indirect_its_thunk_rax, "Gap in ITS thunk array");
+#endif
+
+#if defined(CONFIG_MITIGATION_ITS) && !defined(CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B)
+. = ASSERT(its_return_thunk & 0x20, "its_return_thunk not in second half of cacheline");
+#endif
+
 #endif /* CONFIG_X86_64 */
diff --git a/arch/x86/kvm/smm.c b/arch/x86/kvm/smm.c
index 85241c0c7f56..b0cab215b08f 100644
--- a/arch/x86/kvm/smm.c
+++ b/arch/x86/kvm/smm.c
@@ -131,6 +131,7 @@ void kvm_smm_changed(struct kvm_vcpu *vcpu, bool entering_smm)
 
 	kvm_mmu_reset_context(vcpu);
 }
+EXPORT_SYMBOL_GPL(kvm_smm_changed);
 
 void process_smi(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e39ab7c0be4e..7cbacd043921 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2222,6 +2222,10 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
 	 */
 	if (!sev_es_guest(vcpu->kvm)) {
 		clear_page(svm->vmcb);
+#ifdef CONFIG_KVM_SMM
+		if (is_smm(vcpu))
+			kvm_smm_changed(vcpu, false);
+#endif
 		kvm_vcpu_reset(vcpu, true);
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7a5367b14518..f378d479fea3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1623,7 +1623,7 @@ EXPORT_SYMBOL_GPL(kvm_emulate_rdpmc);
 	 ARCH_CAP_PSCHANGE_MC_NO | ARCH_CAP_TSX_CTRL_MSR | ARCH_CAP_TAA_NO | \
 	 ARCH_CAP_SBDR_SSDP_NO | ARCH_CAP_FBSDP_NO | ARCH_CAP_PSDP_NO | \
 	 ARCH_CAP_FB_CLEAR | ARCH_CAP_RRSBA | ARCH_CAP_PBRSB_NO | ARCH_CAP_GDS_NO | \
-	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO)
+	 ARCH_CAP_RFDS_NO | ARCH_CAP_RFDS_CLEAR | ARCH_CAP_BHI_NO | ARCH_CAP_ITS_NO)
 
 static u64 kvm_get_arch_capabilities(void)
 {
@@ -1657,6 +1657,8 @@ static u64 kvm_get_arch_capabilities(void)
 		data |= ARCH_CAP_MDS_NO;
 	if (!boot_cpu_has_bug(X86_BUG_RFDS))
 		data |= ARCH_CAP_RFDS_NO;
+	if (!boot_cpu_has_bug(X86_BUG_ITS))
+		data |= ARCH_CAP_ITS_NO;
 
 	if (!boot_cpu_has(X86_FEATURE_RTM)) {
 		/*
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 391059b2c6fb..614fb9aee2ff 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -366,6 +366,45 @@ SYM_FUNC_END(call_depth_return_thunk)
 
 #endif /* CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
 
+#ifdef CONFIG_MITIGATION_ITS
+
+.macro ITS_THUNK reg
+
+SYM_INNER_LABEL(__x86_indirect_its_thunk_\reg, SYM_L_GLOBAL)
+	UNWIND_HINT_UNDEFINED
+	ANNOTATE_NOENDBR
+	ANNOTATE_RETPOLINE_SAFE
+	jmp *%\reg
+	int3
+	.align 32, 0xcc		/* fill to the end of the line */
+	.skip  32, 0xcc		/* skip to the next upper half */
+.endm
+
+/* ITS mitigation requires thunks be aligned to upper half of cacheline */
+.align 64, 0xcc
+.skip 32, 0xcc
+SYM_CODE_START(__x86_indirect_its_thunk_array)
+
+#define GEN(reg) ITS_THUNK reg
+#include <asm/GEN-for-each-reg.h>
+#undef GEN
+
+	.align 64, 0xcc
+SYM_CODE_END(__x86_indirect_its_thunk_array)
+
+.align 64, 0xcc
+.skip 32, 0xcc
+SYM_CODE_START(its_return_thunk)
+	UNWIND_HINT_FUNC
+	ANNOTATE_NOENDBR
+	ANNOTATE_UNRET_SAFE
+	ret
+	int3
+SYM_CODE_END(its_return_thunk)
+EXPORT_SYMBOL(its_return_thunk)
+
+#endif /* CONFIG_MITIGATION_ITS */
+
 /*
  * This function name is magical and is used by -mfunction-return=thunk-extern
  * for the compiler to generate JMPs to it.
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 27d81cb049ff..8629d90fdcd9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -624,7 +624,11 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 
 		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
 
-		/* Let nmi_uaccess_okay() know that we're changing CR3. */
+		/*
+		 * Indicate that CR3 is about to change. nmi_uaccess_okay()
+		 * and others are sensitive to the window where mm_cpumask(),
+		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
+ 		 */
 		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
 		barrier();
 	}
@@ -895,8 +899,16 @@ static void flush_tlb_func(void *info)
 
 static bool should_flush_tlb(int cpu, void *data)
 {
+	struct mm_struct *loaded_mm = per_cpu(cpu_tlbstate.loaded_mm, cpu);
 	struct flush_tlb_info *info = data;
 
+	/*
+	 * Order the 'loaded_mm' and 'is_lazy' against their
+	 * write ordering in switch_mm_irqs_off(). Ensure
+	 * 'is_lazy' is at least as new as 'loaded_mm'.
+	 */
+	smp_rmb();
+
 	/* Lazy TLB will get flushed at the next context switch. */
 	if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
 		return false;
@@ -905,8 +917,15 @@ static bool should_flush_tlb(int cpu, void *data)
 	if (!info->mm)
 		return true;
 
+	/*
+	 * While switching, the remote CPU could have state from
+	 * either the prev or next mm. Assume the worst and flush.
+	 */
+	if (loaded_mm == LOADED_MM_SWITCHING)
+		return true;
+
 	/* The target mm is loaded, and the CPU is not lazy. */
-	if (per_cpu(cpu_tlbstate.loaded_mm, cpu) == info->mm)
+	if (loaded_mm == info->mm)
 		return true;
 
 	/* In cpumask, but not the loaded mm? Periodically remove by flushing. */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..ccb2f7703c33 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -41,6 +41,8 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 #define EMIT2(b1, b2)		EMIT((b1) + ((b2) << 8), 2)
 #define EMIT3(b1, b2, b3)	EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
 #define EMIT4(b1, b2, b3, b4)   EMIT((b1) + ((b2) << 8) + ((b3) << 16) + ((b4) << 24), 4)
+#define EMIT5(b1, b2, b3, b4, b5) \
+	do { EMIT1(b1); EMIT4(b2, b3, b4, b5); } while (0)
 
 #define EMIT1_off32(b1, off) \
 	do { EMIT1(b1); EMIT(off, 4); } while (0)
@@ -637,7 +639,10 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 {
 	u8 *prog = *pprog;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
+	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
+		OPTIMIZER_HIDE_VAR(reg);
+		emit_jump(&prog, its_static_thunk(reg), ip);
+	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_LFENCE)) {
 		EMIT_LFENCE();
 		EMIT2(0xFF, 0xE0 + reg);
 	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
@@ -659,7 +664,7 @@ static void emit_return(u8 **pprog, u8 *ip)
 {
 	u8 *prog = *pprog;
 
-	if (cpu_feature_enabled(X86_FEATURE_RETHUNK)) {
+	if (cpu_wants_rethunk()) {
 		emit_jump(&prog, x86_return_thunk, ip);
 	} else {
 		EMIT1(0xC3);		/* ret */
@@ -1412,6 +1417,48 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 #define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
 
+static int emit_spectre_bhb_barrier(u8 **pprog, u8 *ip,
+				    struct bpf_prog *bpf_prog)
+{
+	u8 *prog = *pprog;
+	u8 *func;
+
+	if (cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP)) {
+		/* The clearing sequence clobbers eax and ecx. */
+		EMIT1(0x50); /* push rax */
+		EMIT1(0x51); /* push rcx */
+		ip += 2;
+
+		func = (u8 *)clear_bhb_loop;
+		ip += x86_call_depth_emit_accounting(&prog, func, ip);
+
+		if (emit_call(&prog, func, ip))
+			return -EINVAL;
+		EMIT1(0x59); /* pop rcx */
+		EMIT1(0x58); /* pop rax */
+	}
+	/* Insert IBHF instruction */
+	if ((cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_LOOP) &&
+	     cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) ||
+	    cpu_feature_enabled(X86_FEATURE_CLEAR_BHB_HW)) {
+		/*
+		 * Add an Indirect Branch History Fence (IBHF). IBHF acts as a
+		 * fence preventing branch history from before the fence from
+		 * affecting indirect branches after the fence. This is
+		 * specifically used in cBPF jitted code to prevent Intra-mode
+		 * BHI attacks. The IBHF instruction is designed to be a NOP on
+		 * hardware that doesn't need or support it.  The REP and REX.W
+		 * prefixes are required by the microcode, and they also ensure
+		 * that the NOP is unlikely to be used in existing code.
+		 *
+		 * IBHF is not a valid instruction in 32-bit mode.
+		 */
+		EMIT5(0xF3, 0x48, 0x0F, 0x1E, 0xF8); /* ibhf */
+	}
+	*pprog = prog;
+	return 0;
+}
+
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2402,6 +2449,13 @@ st:			if (is_imm8(insn->off))
 			seen_exit = true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
+			if (bpf_prog_was_classic(bpf_prog) &&
+			    !capable(CAP_SYS_ADMIN)) {
+				u8 *ip = image + addrs[i - 1];
+
+				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
+					return -EINVAL;
+			}
 			if (bpf_prog->aux->exception_boundary) {
 				pop_callee_regs(&prog, all_callee_regs_used);
 				pop_r12(&prog);
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index 08b3cef58fd2..1214f155afa1 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -106,7 +106,7 @@ static void timeouts_init(struct ivpu_device *vdev)
 		else
 			vdev->timeout.autosuspend = 100;
 		vdev->timeout.d0i3_entry_msg = 5;
-		vdev->timeout.state_dump_msg = 10;
+		vdev->timeout.state_dump_msg = 100;
 	}
 }
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fdaa24bb641a..d88f721cf68c 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -599,6 +599,7 @@ CPU_SHOW_VULN_FALLBACK(retbleed);
 CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
 CPU_SHOW_VULN_FALLBACK(gds);
 CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
+CPU_SHOW_VULN_FALLBACK(indirect_target_selection);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -614,6 +615,7 @@ static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
+static DEVICE_ATTR(indirect_target_selection, 0444, cpu_show_indirect_target_selection, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -630,6 +632,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_spec_rstack_overflow.attr,
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_reg_file_data_sampling.attr,
+	&dev_attr_indirect_target_selection.attr,
 	NULL
 };
 
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8827a768284a..6bd44ec2c9b1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -493,6 +493,25 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 	return 0;
 }
 
+static void loop_assign_backing_file(struct loop_device *lo, struct file *file)
+{
+	lo->lo_backing_file = file;
+	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
+	mapping_set_gfp_mask(file->f_mapping,
+			lo->old_gfp_mask & ~(__GFP_IO | __GFP_FS));
+}
+
+static int loop_check_backing_file(struct file *file)
+{
+	if (!file->f_op->read_iter)
+		return -EINVAL;
+
+	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
+		return -EINVAL;
+
+	return 0;
+}
+
 /*
  * loop_change_fd switched the backing store of a loopback device to
  * a new file. This is useful for operating system installers to free up
@@ -513,6 +532,10 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!file)
 		return -EBADF;
 
+	error = loop_check_backing_file(file);
+	if (error)
+		return error;
+
 	/* suppress uevents while reconfiguring the device */
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 1);
 
@@ -545,10 +568,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	disk_force_media_change(lo->lo_disk);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
-	lo->lo_backing_file = file;
-	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
-	mapping_set_gfp_mask(file->f_mapping,
-			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
+	loop_assign_backing_file(lo, file);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
@@ -694,12 +714,11 @@ static void loop_sysfs_exit(struct loop_device *lo)
 				   &loop_attribute_group);
 }
 
-static void loop_config_discard(struct loop_device *lo,
-		struct queue_limits *lim)
+static void loop_get_discard_config(struct loop_device *lo,
+				    u32 *granularity, u32 *max_discard_sectors)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
-	u32 granularity = 0, max_discard_sectors = 0;
 	struct kstatfs sbuf;
 
 	/*
@@ -710,27 +729,19 @@ static void loop_config_discard(struct loop_device *lo,
 	 * file-backed loop devices: discarded regions read back as zero.
 	 */
 	if (S_ISBLK(inode->i_mode)) {
-		struct request_queue *backingq = bdev_get_queue(I_BDEV(inode));
+		struct block_device *bdev = I_BDEV(inode);
 
-		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
-		granularity = bdev_discard_granularity(I_BDEV(inode)) ?:
-			queue_physical_block_size(backingq);
+		*max_discard_sectors = bdev_write_zeroes_sectors(bdev);
+		*granularity = bdev_discard_granularity(bdev);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
 	 * image a.k.a. discard.
 	 */
 	} else if (file->f_op->fallocate && !vfs_statfs(&file->f_path, &sbuf)) {
-		max_discard_sectors = UINT_MAX >> 9;
-		granularity = sbuf.f_bsize;
+		*max_discard_sectors = UINT_MAX >> 9;
+		*granularity = sbuf.f_bsize;
 	}
-
-	lim->max_hw_discard_sectors = max_discard_sectors;
-	lim->max_write_zeroes_sectors = max_discard_sectors;
-	if (max_discard_sectors)
-		lim->discard_granularity = granularity;
-	else
-		lim->discard_granularity = 0;
 }
 
 struct loop_worker {
@@ -910,12 +921,13 @@ static unsigned int loop_default_blocksize(struct loop_device *lo,
 	return SECTOR_SIZE;
 }
 
-static int loop_reconfigure_limits(struct loop_device *lo, unsigned int bsize)
+static void loop_update_limits(struct loop_device *lo, struct queue_limits *lim,
+		unsigned int bsize)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
 	struct block_device *backing_bdev = NULL;
-	struct queue_limits lim;
+	u32 granularity = 0, max_discard_sectors = 0;
 
 	if (S_ISBLK(inode->i_mode))
 		backing_bdev = I_BDEV(inode);
@@ -925,17 +937,22 @@ static int loop_reconfigure_limits(struct loop_device *lo, unsigned int bsize)
 	if (!bsize)
 		bsize = loop_default_blocksize(lo, backing_bdev);
 
-	lim = queue_limits_start_update(lo->lo_queue);
-	lim.logical_block_size = bsize;
-	lim.physical_block_size = bsize;
-	lim.io_min = bsize;
-	lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
+	loop_get_discard_config(lo, &granularity, &max_discard_sectors);
+
+	lim->logical_block_size = bsize;
+	lim->physical_block_size = bsize;
+	lim->io_min = bsize;
+	lim->features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_ROTATIONAL);
 	if (file->f_op->fsync && !(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		lim.features |= BLK_FEAT_WRITE_CACHE;
+		lim->features |= BLK_FEAT_WRITE_CACHE;
 	if (backing_bdev && !bdev_nonrot(backing_bdev))
-		lim.features |= BLK_FEAT_ROTATIONAL;
-	loop_config_discard(lo, &lim);
-	return queue_limits_commit_update(lo->lo_queue, &lim);
+		lim->features |= BLK_FEAT_ROTATIONAL;
+	lim->max_hw_discard_sectors = max_discard_sectors;
+	lim->max_write_zeroes_sectors = max_discard_sectors;
+	if (max_discard_sectors)
+		lim->discard_granularity = granularity;
+	else
+		lim->discard_granularity = 0;
 }
 
 static int loop_configure(struct loop_device *lo, blk_mode_t mode,
@@ -943,7 +960,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 			  const struct loop_config *config)
 {
 	struct file *file = fget(config->fd);
-	struct address_space *mapping;
+	struct queue_limits lim;
 	int error;
 	loff_t size;
 	bool partscan;
@@ -951,6 +968,14 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 	if (!file)
 		return -EBADF;
+
+	if ((mode & BLK_OPEN_WRITE) && !file->f_op->write_iter)
+		return -EINVAL;
+
+	error = loop_check_backing_file(file);
+	if (error)
+		return error;
+
 	is_loop = is_loop_device(file);
 
 	/* This is safe, since we have a reference from open(). */
@@ -978,8 +1003,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (error)
 		goto out_unlock;
 
-	mapping = file->f_mapping;
-
 	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
 		error = -EINVAL;
 		goto out_unlock;
@@ -1011,11 +1034,11 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
-	lo->lo_backing_file = file;
-	lo->old_gfp_mask = mapping_gfp_mask(mapping);
-	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
+	loop_assign_backing_file(lo, file);
 
-	error = loop_reconfigure_limits(lo, config->block_size);
+	lim = queue_limits_start_update(lo->lo_queue);
+	loop_update_limits(lo, &lim, config->block_size);
+	error = queue_limits_commit_update(lo->lo_queue, &lim);
 	if (error)
 		goto out_unlock;
 
@@ -1383,6 +1406,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
+	struct queue_limits lim;
 	int err = 0;
 
 	if (lo->lo_state != Lo_bound)
@@ -1395,7 +1419,9 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	invalidate_bdev(lo->lo_device);
 
 	blk_mq_freeze_queue(lo->lo_queue);
-	err = loop_reconfigure_limits(lo, arg);
+	lim = queue_limits_start_update(lo->lo_queue);
+	loop_update_limits(lo, &lim, arg);
+	err = queue_limits_commit_update(lo->lo_queue, &lim);
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index af487abe9932..05de2e6f563d 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1329,15 +1329,8 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 		fwname = FIRMWARE_MT7668;
 		break;
 	case 0x7922:
-	case 0x7961:
 	case 0x7925:
-		/* Reset the device to ensure it's in the initial state before
-		 * downloading the firmware to ensure.
-		 */
-
-		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
-			btmtk_usb_subsys_reset(hdev, dev_id);
-
+	case 0x7961:
 		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
 				      fw_version, fw_flavor);
 
@@ -1345,12 +1338,9 @@ int btmtk_usb_setup(struct hci_dev *hdev)
 						btmtk_usb_hci_wmt_sync);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to set up firmware (%d)", err);
-			clear_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
 			return err;
 		}
 
-		set_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags);
-
 		/* It's Device EndPoint Reset Option Register */
 		err = btmtk_usb_uhw_reg_write(hdev, MTK_EP_RST_OPT,
 					      MTK_EP_RST_IN_OUT_OPT);
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 39f7c2d736d1..b603c25f3dfa 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -103,7 +103,7 @@ int __init clocksource_i8253_init(void)
 #ifdef CONFIG_CLKEVT_I8253
 void clockevent_i8253_disable(void)
 {
-	raw_spin_lock(&i8253_lock);
+	guard(raw_spinlock_irqsave)(&i8253_lock);
 
 	/*
 	 * Writing the MODE register should stop the counter, according to
@@ -132,8 +132,6 @@ void clockevent_i8253_disable(void)
 	outb_p(0, PIT_CH0);
 
 	outb_p(0x30, PIT_MODE);
-
-	raw_spin_unlock(&i8253_lock);
 }
 
 static int pit_shutdown(struct clock_event_device *evt)
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index f8934d049d68..993615fa490e 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1219,7 +1219,8 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
 }
 
 static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
-				      struct scmi_xfer *xfer, ktime_t stop)
+				      struct scmi_xfer *xfer, ktime_t stop,
+				      bool *ooo)
 {
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 
@@ -1228,7 +1229,7 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
 	 * in case of out-of-order receptions of delayed responses
 	 */
 	return info->desc->ops->poll_done(cinfo, xfer) ||
-	       try_wait_for_completion(&xfer->done) ||
+	       (*ooo = try_wait_for_completion(&xfer->done)) ||
 	       ktime_after(ktime_get(), stop);
 }
 
@@ -1245,15 +1246,17 @@ static int scmi_wait_for_reply(struct device *dev, const struct scmi_desc *desc,
 		 * itself to support synchronous commands replies.
 		 */
 		if (!desc->sync_cmds_completed_on_ret) {
+			bool ooo = false;
+
 			/*
 			 * Poll on xfer using transport provided .poll_done();
 			 * assumes no completion interrupt was available.
 			 */
 			ktime_t stop = ktime_add_ms(ktime_get(), timeout_ms);
 
-			spin_until_cond(scmi_xfer_done_no_timeout(cinfo,
-								  xfer, stop));
-			if (ktime_after(ktime_get(), stop)) {
+			spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer,
+								  stop, &ooo));
+			if (!ooo && !info->desc->ops->poll_done(cinfo, xfer)) {
 				dev_err(dev,
 					"timed out in resp(caller: %pS) - polling\n",
 					(void *)_RET_IP_);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2a1f3dbb14d3..3b6254de2c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -66,7 +66,6 @@
 #define VCN_ENC_CMD_REG_WAIT		0x0000000c
 
 #define VCN_AON_SOC_ADDRESS_2_0 	0x1f800
-#define VCN1_AON_SOC_ADDRESS_3_0 	0x48000
 #define VCN_VID_IP_ADDRESS_2_0		0x0
 #define VCN_AON_IP_ADDRESS_2_0		0x30000
 
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 194026e9be33..1ca1bbe7784e 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -42,7 +42,12 @@ static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index d3962d469088..40705e13ca56 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -33,7 +33,12 @@ static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
index f52552c5fa27..6b9f2e1d9d69 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
@@ -34,7 +34,17 @@ static void hdp_v5_2_flush_hdp(struct amdgpu_device *adev,
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
 			0);
-		RREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		if (amdgpu_sriov_vf(adev)) {
+			/* this is fine because SR_IOV doesn't remap the register */
+			RREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		} else {
+			/* We just need to read back a register to post the write.
+			 * Reading back the remapped register causes problems on
+			 * some platforms so just read back the memory size register.
+			 */
+			if (adev->nbio.funcs->get_memsize)
+				adev->nbio.funcs->get_memsize(adev);
+		}
 	} else {
 		amdgpu_ring_emit_wreg(ring,
 			(adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index 6948fe9956ce..20da813299f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -36,7 +36,12 @@ static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index 63820329f67e..f7ecdd15d528 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -33,7 +33,12 @@ static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
 {
 	if (!ring || !ring->funcs->emit_wreg) {
 		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+		/* We just need to read back a register to post the write.
+		 * Reading back the remapped register causes problems on
+		 * some platforms so just read back the memory size register.
+		 */
+		if (adev->nbio.funcs->get_memsize)
+			adev->nbio.funcs->get_memsize(adev);
 	} else {
 		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index bfd067e2d2f1..f0edaabdcde5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -39,6 +39,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x1fd
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x503
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 04e9e806e318..e4d0c0310e76 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -39,6 +39,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 65dd68b32280..be86f86b49e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -40,6 +40,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
 #define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+#define VCN1_AON_SOC_ADDRESS_3_0				0x48000
 
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 26c6f10a8c8f..f391f0c54043 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -46,6 +46,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0							0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0						0x48300
+#define VCN1_AON_SOC_ADDRESS_3_0						0x48000
 
 #define VCN_HARVEST_MMSCH								0
 
@@ -575,7 +576,8 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+			VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG),
+			adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 84c6b0f5c4c0..77542dabec59 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -44,6 +44,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0		0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0	0x48300
+#define VCN1_AON_SOC_ADDRESS_3_0	0x48000
 
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 9d4f5352a62c..e0b02bf1c563 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -46,6 +46,7 @@
 
 #define VCN_VID_SOC_ADDRESS_2_0						0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0					(0x48300 + 0x38000)
+#define VCN1_AON_SOC_ADDRESS_3_0					(0x48000 + 0x38000)
 
 #define VCN_HARVEST_MMSCH							0
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c305386358b4..d19eec4d4790 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -488,7 +488,8 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 
 	/* VCN global tiling registers */
 	WREG32_SOC24_DPG_MODE(inst_idx, SOC24_DPG_MODE_OFFSET(
-		VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG),
+		adev->gfx.config.gb_addr_config, 0, indirect);
 
 	return;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 115fb3bc4564..66c50a09d2df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -666,15 +666,21 @@ static void dm_crtc_high_irq(void *interrupt_params)
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 
 	if (acrtc->dm_irq_params.stream &&
-	    acrtc->dm_irq_params.vrr_params.supported &&
-	    acrtc->dm_irq_params.freesync_config.state ==
-		    VRR_STATE_ACTIVE_VARIABLE) {
+		acrtc->dm_irq_params.vrr_params.supported) {
+		bool replay_en = acrtc->dm_irq_params.stream->link->replay_settings.replay_feature_enabled;
+		bool psr_en = acrtc->dm_irq_params.stream->link->psr_settings.psr_feature_enabled;
+		bool fs_active_var_en = acrtc->dm_irq_params.freesync_config.state == VRR_STATE_ACTIVE_VARIABLE;
+
 		mod_freesync_handle_v_update(adev->dm.freesync_module,
 					     acrtc->dm_irq_params.stream,
 					     &acrtc->dm_irq_params.vrr_params);
 
-		dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc->dm_irq_params.stream,
-					   &acrtc->dm_irq_params.vrr_params.adjust);
+		/* update vmin_vmax only if freesync is enabled, or only if PSR and REPLAY are disabled */
+		if (fs_active_var_en || (!fs_active_var_en && !replay_en && !psr_en)) {
+			dc_stream_adjust_vmin_vmax(adev->dm.dc,
+					acrtc->dm_irq_params.stream,
+					&acrtc->dm_irq_params.vrr_params.adjust);
+		}
 	}
 
 	/*
@@ -12526,7 +12532,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		 * Transient states before tunneling is enabled could
 		 * lead to this error. We can ignore this for now.
 		 */
-		if (p_notify->result != AUX_RET_ERROR_PROTOCOL_ERROR) {
+		if (p_notify->result == AUX_RET_ERROR_PROTOCOL_ERROR) {
 			DRM_WARN("DPIA AUX failed on 0x%x(%d), error %d\n",
 					payload->address, payload->length,
 					p_notify->result);
@@ -12535,22 +12541,14 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		goto out;
 	}
 
+	payload->reply[0] = adev->dm.dmub_notify->aux_reply.command & 0xF;
+	if (adev->dm.dmub_notify->aux_reply.command & 0xF0)
+		/* The reply is stored in the top nibble of the command. */
+		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
-	payload->reply[0] = adev->dm.dmub_notify->aux_reply.command;
-	if (!payload->write && p_notify->aux_reply.length &&
-			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK)) {
-
-		if (payload->length != p_notify->aux_reply.length) {
-			DRM_WARN("invalid read length %d from DPIA AUX 0x%x(%d)!\n",
-				p_notify->aux_reply.length,
-					payload->address, payload->length);
-			*operation_result = AUX_RET_ERROR_INVALID_REPLY;
-			goto out;
-		}
-
+	if (!payload->write && p_notify->aux_reply.length)
 		memcpy(payload->data, p_notify->aux_reply.data,
 				p_notify->aux_reply.length);
-	}
 
 	/* success */
 	ret = p_notify->aux_reply.length;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5bdf44c69218..dca8384af95d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -51,6 +51,9 @@
 
 #define PEAK_FACTOR_X1000 1006
 
+/*
+ * This function handles both native AUX and I2C-Over-AUX transactions.
+ */
 static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 				  struct drm_dp_aux_msg *msg)
 {
@@ -87,15 +90,25 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	if (adev->dm.aux_hpd_discon_quirk) {
 		if (msg->address == DP_SIDEBAND_MSG_DOWN_REQ_BASE &&
 			operation_result == AUX_RET_ERROR_HPD_DISCON) {
-			result = 0;
+			result = msg->size;
 			operation_result = AUX_RET_SUCCESS;
 		}
 	}
 
-	if (payload.write && result >= 0)
-		result = msg->size;
+	/*
+	 * result equals to 0 includes the cases of AUX_DEFER/I2C_DEFER
+	 */
+	if (payload.write && result >= 0) {
+		if (result) {
+			/*one byte indicating partially written bytes. Force 0 to retry*/
+			drm_info(adev_to_drm(adev), "amdgpu: AUX partially written\n");
+			result = 0;
+		} else if (!payload.reply[0])
+			/*I2C_ACK|AUX_ACK*/
+			result = msg->size;
+	}
 
-	if (result < 0)
+	if (result < 0) {
 		switch (operation_result) {
 		case AUX_RET_SUCCESS:
 			break;
@@ -114,6 +127,13 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 			break;
 		}
 
+		drm_info(adev_to_drm(adev), "amdgpu: DP AUX transfer fail:%d\n", operation_result);
+	}
+
+	if (payload.reply[0])
+		drm_info(adev_to_drm(adev), "amdgpu: AUX reply command not ACK: 0x%02x.",
+			payload.reply[0]);
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 81ba8809a3b4..92a3fff1e261 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -929,7 +929,9 @@ static void populate_dml_surface_cfg_from_plane_state(enum dml_project_id dml2_p
 	}
 }
 
-static void get_scaler_data_for_plane(const struct dc_plane_state *in, struct dc_state *context, struct scaler_data *out)
+static struct scaler_data *get_scaler_data_for_plane(
+		const struct dc_plane_state *in,
+		struct dc_state *context)
 {
 	int i;
 	struct pipe_ctx *temp_pipe = &context->res_ctx.temp_pipe;
@@ -950,7 +952,7 @@ static void get_scaler_data_for_plane(const struct dc_plane_state *in, struct dc
 	}
 
 	ASSERT(i < MAX_PIPES);
-	memcpy(out, &temp_pipe->plane_res.scl_data, sizeof(*out));
+	return &temp_pipe->plane_res.scl_data;
 }
 
 static void populate_dummy_dml_plane_cfg(struct dml_plane_cfg_st *out, unsigned int location,
@@ -1013,11 +1015,7 @@ static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out
 						    const struct dc_plane_state *in, struct dc_state *context,
 						    const struct soc_bounding_box_st *soc)
 {
-	struct scaler_data *scaler_data = kzalloc(sizeof(*scaler_data), GFP_KERNEL);
-	if (!scaler_data)
-		return;
-
-	get_scaler_data_for_plane(in, context, scaler_data);
+	struct scaler_data *scaler_data = get_scaler_data_for_plane(in, context);
 
 	out->CursorBPP[location] = dml_cur_32bit;
 	out->CursorWidth[location] = 256;
@@ -1082,8 +1080,6 @@ static void populate_dml_plane_cfg_from_plane_state(struct dml_plane_cfg_st *out
 	out->DynamicMetadataTransmittedBytes[location] = 0;
 
 	out->NumberOfCursors[location] = 1;
-
-	kfree(scaler_data);
 }
 
 static unsigned int map_stream_to_dml_display_cfg(const struct dml2_context *dml2,
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 06381c628209..d041ff542a4e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1027,27 +1027,28 @@ static const struct panel_desc auo_g070vvn01 = {
 	},
 };
 
-static const struct drm_display_mode auo_g101evn010_mode = {
-	.clock = 68930,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 82,
-	.hsync_end = 1280 + 82 + 2,
-	.htotal = 1280 + 82 + 2 + 84,
-	.vdisplay = 800,
-	.vsync_start = 800 + 8,
-	.vsync_end = 800 + 8 + 2,
-	.vtotal = 800 + 8 + 2 + 6,
+static const struct display_timing auo_g101evn010_timing = {
+	.pixelclock = { 64000000, 68930000, 85000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 8, 64, 256 },
+	.hback_porch = { 8, 64, 256 },
+	.hsync_len = { 40, 168, 767 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 4, 8, 100 },
+	.vback_porch = { 4, 8, 100 },
+	.vsync_len = { 8, 16, 223 },
 };
 
 static const struct panel_desc auo_g101evn010 = {
-	.modes = &auo_g101evn010_mode,
-	.num_modes = 1,
+	.timings = &auo_g101evn010_timing,
+	.num_timings = 1,
 	.bpc = 6,
 	.size = {
 		.width = 216,
 		.height = 135,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 4a6aa36619fe..ad32e584deee 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -728,11 +728,16 @@ v3d_gpu_reset_for_timeout(struct v3d_dev *v3d, struct drm_sched_job *sched_job)
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 
-/* If the current address or return address have changed, then the GPU
- * has probably made progress and we should delay the reset.  This
- * could fail if the GPU got in an infinite loop in the CL, but that
- * is pretty unlikely outside of an i-g-t testcase.
- */
+static void
+v3d_sched_skip_reset(struct drm_sched_job *sched_job)
+{
+	struct drm_gpu_scheduler *sched = sched_job->sched;
+
+	spin_lock(&sched->job_list_lock);
+	list_add(&sched_job->list, &sched->pending_list);
+	spin_unlock(&sched->job_list_lock);
+}
+
 static enum drm_gpu_sched_stat
 v3d_cl_job_timedout(struct drm_sched_job *sched_job, enum v3d_queue q,
 		    u32 *timedout_ctca, u32 *timedout_ctra)
@@ -742,9 +747,16 @@ v3d_cl_job_timedout(struct drm_sched_job *sched_job, enum v3d_queue q,
 	u32 ctca = V3D_CORE_READ(0, V3D_CLE_CTNCA(q));
 	u32 ctra = V3D_CORE_READ(0, V3D_CLE_CTNRA(q));
 
+	/* If the current address or return address have changed, then the GPU
+	 * has probably made progress and we should delay the reset. This
+	 * could fail if the GPU got in an infinite loop in the CL, but that
+	 * is pretty unlikely outside of an i-g-t testcase.
+	 */
 	if (*timedout_ctca != ctca || *timedout_ctra != ctra) {
 		*timedout_ctca = ctca;
 		*timedout_ctra = ctra;
+
+		v3d_sched_skip_reset(sched_job);
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 	}
 
@@ -784,11 +796,13 @@ v3d_csd_job_timedout(struct drm_sched_job *sched_job)
 	struct v3d_dev *v3d = job->base.v3d;
 	u32 batches = V3D_CORE_READ(0, V3D_CSD_CURRENT_CFG4(v3d->ver));
 
-	/* If we've made progress, skip reset and let the timer get
-	 * rearmed.
+	/* If we've made progress, skip reset, add the job to the pending
+	 * list, and let the timer get rearmed.
 	 */
 	if (job->timedout_batches != batches) {
 		job->timedout_batches = batches;
+
+		v3d_sched_skip_reset(sched_job);
 		return DRM_GPU_SCHED_STAT_NOMINAL;
 	}
 
diff --git a/drivers/gpu/drm/xe/tests/xe_mocs.c b/drivers/gpu/drm/xe/tests/xe_mocs.c
index 79be73b4a02b..61a7d20ce42b 100644
--- a/drivers/gpu/drm/xe/tests/xe_mocs.c
+++ b/drivers/gpu/drm/xe/tests/xe_mocs.c
@@ -43,12 +43,14 @@ static void read_l3cc_table(struct xe_gt *gt,
 {
 	struct kunit *test = kunit_get_current_test();
 	u32 l3cc, l3cc_expected;
-	unsigned int i;
+	unsigned int fw_ref, i;
 	u32 reg_val;
-	u32 ret;
 
-	ret = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Forcewake Failed.\n");
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FORCEWAKE_ALL);
+	if (!xe_force_wake_ref_has_domain(fw_ref, XE_FORCEWAKE_ALL)) {
+		xe_force_wake_put(gt_to_fw(gt), fw_ref);
+		KUNIT_ASSERT_TRUE_MSG(test, true, "Forcewake Failed.\n");
+	}
 
 	for (i = 0; i < info->num_mocs_regs; i++) {
 		if (!(i & 1)) {
@@ -72,7 +74,7 @@ static void read_l3cc_table(struct xe_gt *gt,
 		KUNIT_EXPECT_EQ_MSG(test, l3cc_expected, l3cc,
 				    "l3cc idx=%u has incorrect val.\n", i);
 	}
-	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 }
 
 static void read_mocs_table(struct xe_gt *gt,
@@ -80,15 +82,14 @@ static void read_mocs_table(struct xe_gt *gt,
 {
 	struct kunit *test = kunit_get_current_test();
 	u32 mocs, mocs_expected;
-	unsigned int i;
+	unsigned int fw_ref, i;
 	u32 reg_val;
-	u32 ret;
 
 	KUNIT_EXPECT_TRUE_MSG(test, info->unused_entries_index,
 			      "Unused entries index should have been defined\n");
 
-	ret = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
-	KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Forcewake Failed.\n");
+	fw_ref = xe_force_wake_get(gt_to_fw(gt), XE_FW_GT);
+	KUNIT_ASSERT_NE_MSG(test, fw_ref, 0, "Forcewake Failed.\n");
 
 	for (i = 0; i < info->num_mocs_regs; i++) {
 		if (regs_are_mcr(gt))
@@ -106,7 +107,7 @@ static void read_mocs_table(struct xe_gt *gt,
 				    "mocs reg 0x%x has incorrect val.\n", i);
 	}
 
-	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
+	xe_force_wake_put(gt_to_fw(gt), fw_ref);
 }
 
 static int mocs_kernel_test_run_device(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index 79c426dc2505..db540c8be6c7 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -423,9 +423,16 @@ static int xe_alloc_pf_queue(struct xe_gt *gt, struct pf_queue *pf_queue)
 	num_eus = bitmap_weight(gt->fuse_topo.eu_mask_per_dss,
 				XE_MAX_EU_FUSE_BITS) * num_dss;
 
-	/* user can issue separate page faults per EU and per CS */
+	/*
+	 * user can issue separate page faults per EU and per CS
+	 *
+	 * XXX: Multiplier required as compute UMD are getting PF queue errors
+	 * without it. Follow on why this multiplier is required.
+	 */
+#define PF_MULTIPLIER	8
 	pf_queue->num_dw =
-		(num_eus + XE_NUM_HW_ENGINES) * PF_MSG_LEN_DW;
+		(num_eus + XE_NUM_HW_ENGINES) * PF_MSG_LEN_DW * PF_MULTIPLIER;
+#undef PF_MULTIPLIER
 
 	pf_queue->gt = gt;
 	pf_queue->data = devm_kcalloc(xe->drm.dev, pf_queue->num_dw,
diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index d054721859b3..99b05548b7bd 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -211,9 +211,9 @@ static const struct iio_chan_spec adis16201_channels[] = {
 			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
 	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
 	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	ADIS_INCLI_CHAN(Y, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
-			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
+			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 12),
 	IIO_CHAN_SOFT_TIMESTAMP(7)
 };
 
diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index eabaefa92f19..5e1946828b96 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -231,7 +231,7 @@ struct adxl355_data {
 		u8 transf_buf[3];
 		struct {
 			u8 buf[14];
-			s64 ts;
+			aligned_s64 ts;
 		} buffer;
 	} __aligned(IIO_DMA_MINALIGN);
 };
diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
index e790a66d86c7..d44d52e5a514 100644
--- a/drivers/iio/accel/adxl367.c
+++ b/drivers/iio/accel/adxl367.c
@@ -604,18 +604,14 @@ static int _adxl367_set_odr(struct adxl367_state *st, enum adxl367_odr odr)
 	if (ret)
 		return ret;
 
+	st->odr = odr;
+
 	/* Activity timers depend on ODR */
 	ret = _adxl367_set_act_time_ms(st, st->act_time_ms);
 	if (ret)
 		return ret;
 
-	ret = _adxl367_set_inact_time_ms(st, st->inact_time_ms);
-	if (ret)
-		return ret;
-
-	st->odr = odr;
-
-	return 0;
+	return _adxl367_set_inact_time_ms(st, st->inact_time_ms);
 }
 
 static int adxl367_set_odr(struct iio_dev *indio_dev, enum adxl367_odr odr)
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 62ec12195307..32a5448116a1 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -127,7 +127,7 @@ static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
 		{
 			.tx_buf = &st->d16[0],
 			.len = 2,
-			.cs_change = 0,
+			.cs_change = 1,
 		}, {
 			.rx_buf = &st->d16[1],
 			.len = 2,
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index de7252a10047..84c23d3def59 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -481,7 +481,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct {
 		__le16 values[DLN2_ADC_MAX_CHANNELS];
-		int64_t timestamp_space;
+		aligned_s64 timestamp_space;
 	} data;
 	struct dln2_adc_get_all_vals dev_data;
 	struct dln2_adc *dln2 = iio_priv(indio_dev);
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index dfd47a6e1f4a..e4dcd9e782af 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -480,15 +480,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (info->reset)
 		rockchip_saradc_reset_controller(info->reset);
 
-	/*
-	 * Use a default value for the converter clock.
-	 * This may become user-configurable in the future.
-	 */
-	ret = clk_set_rate(info->clk, info->data->clk_rate);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "failed to set adc clk rate\n");
-
 	ret = regulator_enable(info->vref);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
@@ -515,6 +506,14 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
 				     "failed to get adc clock\n");
+	/*
+	 * Use a default value for the converter clock.
+	 * This may become user-configurable in the future.
+	 */
+	ret = clk_set_rate(info->clk, info->data->clk_rate);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set adc clk rate\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 3d3b27f28c9d..273196e647a2 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -50,7 +50,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	u32 fifo_period;
 	s64 timestamp;
-	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
+	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] __aligned(8);
 	size_t i, nb;
 
 	mutex_lock(&st->lock);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..8a9d2593576a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -392,6 +392,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
@@ -623,6 +626,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
+
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index c28a7a6dea5f..555a61e2f3fd 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -121,9 +121,9 @@ static const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
 struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
+	char tc_type;
 
 	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
-	char tc_type;
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index a6c795101130..e14d8f316ad8 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -77,12 +77,13 @@
  * xbox d-pads should map to buttons, as is required for DDR pads
  * but we map them to axes when possible to simplify things
  */
-#define MAP_DPAD_TO_BUTTONS		(1 << 0)
-#define MAP_TRIGGERS_TO_BUTTONS		(1 << 1)
-#define MAP_STICKS_TO_NULL		(1 << 2)
-#define MAP_SELECT_BUTTON		(1 << 3)
-#define MAP_PADDLES			(1 << 4)
-#define MAP_PROFILE_BUTTON		(1 << 5)
+#define MAP_DPAD_TO_BUTTONS		BIT(0)
+#define MAP_TRIGGERS_TO_BUTTONS		BIT(1)
+#define MAP_STICKS_TO_NULL		BIT(2)
+#define MAP_SHARE_BUTTON		BIT(3)
+#define MAP_PADDLES			BIT(4)
+#define MAP_PROFILE_BUTTON		BIT(5)
+#define MAP_SHARE_OFFSET		BIT(6)
 
 #define DANCEPAD_MAP_CONFIG	(MAP_DPAD_TO_BUTTONS |			\
 				MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
@@ -135,7 +136,7 @@ static const struct xpad_device {
 	{ 0x03f0, 0x048D, "HyperX Clutch", 0, XTYPE_XBOX360 },			/* wireless */
 	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x03f0, 0x07A0, "HyperX Clutch Gladiate RGB", 0, XTYPE_XBOXONE },
-	{ 0x03f0, 0x08B6, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },		/* v2 */
+	{ 0x03f0, 0x08B6, "HyperX Clutch Gladiate", MAP_SHARE_BUTTON, XTYPE_XBOXONE },		/* v2 */
 	{ 0x03f0, 0x09B4, "HyperX Clutch Tanto", 0, XTYPE_XBOXONE },
 	{ 0x044f, 0x0f00, "Thrustmaster Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f03, "Thrustmaster Wheel", 0, XTYPE_XBOX },
@@ -159,7 +160,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0b00, "Microsoft X-Box One Elite 2 pad", MAP_PADDLES, XTYPE_XBOXONE },
 	{ 0x045e, 0x0b0a, "Microsoft X-Box Adaptive Controller", MAP_PROFILE_BUTTON, XTYPE_XBOXONE },
-	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
+	{ 0x045e, 0x0b12, "Microsoft Xbox Series S|X Controller", MAP_SHARE_BUTTON | MAP_SHARE_OFFSET, XTYPE_XBOXONE },
 	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
@@ -205,13 +206,13 @@ static const struct xpad_device {
 	{ 0x0738, 0x9871, "Mad Catz Portable Drum", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xb726, "Mad Catz Xbox controller - MW2", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xb738, "Mad Catz MVC2TE Stick 2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
-	{ 0x0738, 0xbeef, "Mad Catz JOYTECH NEO SE Advanced GamePad", XTYPE_XBOX360 },
+	{ 0x0738, 0xbeef, "Mad Catz JOYTECH NEO SE Advanced GamePad", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xcb02, "Saitek Cyborg Rumble Pad - PC/Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xcb03, "Saitek P3200 Rumble Pad - PC/Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xcb29, "Saitek Aviator Stick AV8R02", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0xf738, "Super SFIV FightStick TE S", 0, XTYPE_XBOX360 },
 	{ 0x07ff, 0xffff, "Mad Catz GamePad", 0, XTYPE_XBOX360 },
-	{ 0x0b05, 0x1a38, "ASUS ROG RAIKIRI", 0, XTYPE_XBOXONE },
+	{ 0x0b05, 0x1a38, "ASUS ROG RAIKIRI", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },
 	{ 0x0c12, 0x0005, "Intec wireless", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8801, "Nyko Xbox Controller", 0, XTYPE_XBOX },
@@ -240,7 +241,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0146, "Rock Candy Wired Controller for Xbox One", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0147, "PDP Marvel Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x015c, "PDP Xbox One Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
-	{ 0x0e6f, 0x015d, "PDP Mirror's Edge Official Wired Controller for Xbox One", XTYPE_XBOXONE },
+	{ 0x0e6f, 0x015d, "PDP Mirror's Edge Official Wired Controller for Xbox One", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0161, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0162, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0163, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
@@ -387,10 +388,11 @@ static const struct xpad_device {
 	{ 0x2dc8, 0x3106, "8BitDo Ultimate Wireless / Pro 2 Wired Controller", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x3109, "8BitDo Ultimate Wireless Bluetooth", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x310a, "8BitDo Ultimate 2C Wireless Controller", 0, XTYPE_XBOX360 },
+	{ 0x2dc8, 0x310b, "8BitDo Ultimate 2 Wireless Controller", 0, XTYPE_XBOX360 },
 	{ 0x2dc8, 0x6001, "8BitDo SN30 Pro", 0, XTYPE_XBOX360 },
 	{ 0x2e24, 0x0652, "Hyperkin Duke X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x2e24, 0x1688, "Hyperkin X91 X-Box One pad", 0, XTYPE_XBOXONE },
-	{ 0x2e95, 0x0504, "SCUF Gaming Controller", MAP_SELECT_BUTTON, XTYPE_XBOXONE },
+	{ 0x2e95, 0x0504, "SCUF Gaming Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x31e3, 0x1100, "Wooting One", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1200, "Wooting Two", 0, XTYPE_XBOX360 },
 	{ 0x31e3, 0x1210, "Wooting Lekker", 0, XTYPE_XBOX360 },
@@ -1027,7 +1029,7 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
  *	The report format was gleaned from
  *	https://github.com/kylelemons/xbox/blob/master/xbox.go
  */
-static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
+static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data, u32 len)
 {
 	struct input_dev *dev = xpad->dev;
 	bool do_sync = false;
@@ -1068,8 +1070,12 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		/* menu/view buttons */
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
-		if (xpad->mapping & MAP_SELECT_BUTTON)
-			input_report_key(dev, KEY_RECORD, data[22] & BIT(0));
+		if (xpad->mapping & MAP_SHARE_BUTTON) {
+			if (xpad->mapping & MAP_SHARE_OFFSET)
+				input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
+			else
+				input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
+		}
 
 		/* buttons A,B,X,Y */
 		input_report_key(dev, BTN_A,	data[4] & BIT(4));
@@ -1217,7 +1223,7 @@ static void xpad_irq_in(struct urb *urb)
 		xpad360w_process_packet(xpad, 0, xpad->idata);
 		break;
 	case XTYPE_XBOXONE:
-		xpadone_process_packet(xpad, 0, xpad->idata);
+		xpadone_process_packet(xpad, 0, xpad->idata, urb->actual_length);
 		break;
 	default:
 		xpad_process_packet(xpad, 0, xpad->idata);
@@ -1974,7 +1980,7 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	    xpad->xtype == XTYPE_XBOXONE) {
 		for (i = 0; xpad360_btn[i] >= 0; i++)
 			input_set_capability(input_dev, EV_KEY, xpad360_btn[i]);
-		if (xpad->mapping & MAP_SELECT_BUTTON)
+		if (xpad->mapping & MAP_SHARE_BUTTON)
 			input_set_capability(input_dev, EV_KEY, KEY_RECORD);
 	} else {
 		for (i = 0; xpad_btn[i] >= 0; i++)
diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 4364c3401ff1..486ca8ff86f8 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -147,8 +147,8 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
 	u32 value, mask;
 	int error;
 
-	kregs_home = keys->keys[MTK_PMIC_HOMEKEY_INDEX].regs;
-	kregs_pwr = keys->keys[MTK_PMIC_PWRKEY_INDEX].regs;
+	kregs_home = &regs->keys_regs[MTK_PMIC_HOMEKEY_INDEX];
+	kregs_pwr = &regs->keys_regs[MTK_PMIC_PWRKEY_INDEX];
 
 	error = of_property_read_u32(keys->dev->of_node, "power-off-time-sec",
 				     &long_press_debounce);
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 3d1459b551bb..2b8895368437 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -163,6 +163,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 
 static const char * const smbus_pnp_ids[] = {
 	/* all of the topbuttonpad_pnp_ids are valid, we just add some extras */
+	"DLL060d", /* Dell Precision M3800 */
 	"LEN0048", /* X1 Carbon 3 */
 	"LEN0046", /* X250 */
 	"LEN0049", /* Yoga 11e */
@@ -189,11 +190,15 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2068", /* T14 Gen 1 */
+	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
+	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3015", /* HP EliteBook 840 G2 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
 	"SYN3257", /* HP Envy 13-ad105ng */
+	"TOS01f6", /* Dynabook Portege X30L-G */
+	"TOS0213", /* Dynabook Portege X30-D */
 	NULL
 };
 
diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
index eafe5a9b8964..071b7c9bf566 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -580,7 +580,7 @@ static int cyttsp5_power_control(struct cyttsp5 *ts, bool on)
 	int rc;
 
 	SET_CMD_REPORT_TYPE(cmd[0], 0);
-	SET_CMD_REPORT_ID(cmd[0], HID_POWER_SLEEP);
+	SET_CMD_REPORT_ID(cmd[0], state);
 	SET_CMD_OPCODE(cmd[1], HID_CMD_SET_POWER);
 
 	rc = cyttsp5_write(ts, HID_COMMAND_REG, cmd, sizeof(cmd));
@@ -870,13 +870,16 @@ static int cyttsp5_probe(struct device *dev, struct regmap *regmap, int irq,
 	ts->input->phys = ts->phys;
 	input_set_drvdata(ts->input, ts);
 
-	/* Reset the gpio to be in a reset state */
+	/* Assert gpio to be in a reset state */
 	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->reset_gpio)) {
 		error = PTR_ERR(ts->reset_gpio);
 		dev_err(dev, "Failed to request reset gpio, error %d\n", error);
 		return error;
 	}
+
+	fsleep(10); /* Ensure long-enough reset pulse (minimum 10us). */
+
 	gpiod_set_value_cansleep(ts->reset_gpio, 0);
 
 	/* Need a delay to have device up */
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 9cacc49f2cb0..3dc5bc3d29d6 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1183,7 +1183,7 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
 
 	t = dm_get_live_table(md, &srcu_idx);
 	if (!t)
-		return 0;
+		goto put_live_table;
 
 	for (unsigned int i = 0; i < t->num_targets; i++) {
 		struct dm_target *ti = dm_table_get_target(t, i);
@@ -1194,6 +1194,7 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
 					  (void *)key);
 	}
 
+put_live_table:
 	dm_put_live_table(md, srcu_idx);
 	return 0;
 }
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 97cd8bbf2e32..dbd4d8796f9b 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2372,6 +2372,7 @@ struct m_can_classdev *m_can_class_allocate_dev(struct device *dev,
 	SET_NETDEV_DEV(net_dev, dev);
 
 	m_can_of_parse_mram(class_dev, mram_config_vals);
+	spin_lock_init(&class_dev->tx_handling_spinlock);
 out:
 	return class_dev;
 }
@@ -2456,9 +2457,9 @@ EXPORT_SYMBOL_GPL(m_can_class_register);
 
 void m_can_class_unregister(struct m_can_classdev *cdev)
 {
+	unregister_candev(cdev->net);
 	if (cdev->is_peripheral)
 		can_rx_offload_del(&cdev->offload);
-	unregister_candev(cdev->net);
 }
 EXPORT_SYMBOL_GPL(m_can_class_unregister);
 
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index ac514766d431..07510b6f9073 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -942,8 +942,8 @@ static void rkcanfd_remove(struct platform_device *pdev)
 	struct rkcanfd_priv *priv = platform_get_drvdata(pdev);
 	struct net_device *ndev = priv->ndev;
 
-	can_rx_offload_del(&priv->offload);
 	rkcanfd_unregister(priv);
+	can_rx_offload_del(&priv->offload);
 	free_candev(ndev);
 }
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 3bc56517fe7a..c30b04f8fc0d 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -75,6 +75,24 @@ static const struct can_bittiming_const mcp251xfd_data_bittiming_const = {
 	.brp_inc = 1,
 };
 
+/* The datasheet of the mcp2518fd (DS20006027B) specifies a range of
+ * [-64,63] for TDCO, indicating a relative TDCO.
+ *
+ * Manual tests have shown, that using a relative TDCO configuration
+ * results in bus off, while an absolute configuration works.
+ *
+ * For TDCO use the max value (63) from the data sheet, but 0 as the
+ * minimum.
+ */
+static const struct can_tdc_const mcp251xfd_tdc_const = {
+	.tdcv_min = 0,
+	.tdcv_max = 63,
+	.tdco_min = 0,
+	.tdco_max = 63,
+	.tdcf_min = 0,
+	.tdcf_max = 0,
+};
+
 static const char *__mcp251xfd_get_model_str(enum mcp251xfd_model model)
 {
 	switch (model) {
@@ -510,8 +528,7 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 {
 	const struct can_bittiming *bt = &priv->can.bittiming;
 	const struct can_bittiming *dbt = &priv->can.data_bittiming;
-	u32 val = 0;
-	s8 tdco;
+	u32 tdcmod, val = 0;
 	int err;
 
 	/* CAN Control Register
@@ -575,11 +592,16 @@ static int mcp251xfd_set_bittiming(const struct mcp251xfd_priv *priv)
 		return err;
 
 	/* Transmitter Delay Compensation */
-	tdco = clamp_t(int, dbt->brp * (dbt->prop_seg + dbt->phase_seg1),
-		       -64, 63);
-	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK,
-			 MCP251XFD_REG_TDC_TDCMOD_AUTO) |
-		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, tdco);
+	if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_AUTO)
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_AUTO;
+	else if (priv->can.ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_MANUAL;
+	else
+		tdcmod = MCP251XFD_REG_TDC_TDCMOD_DISABLED;
+
+	val = FIELD_PREP(MCP251XFD_REG_TDC_TDCMOD_MASK, tdcmod) |
+		FIELD_PREP(MCP251XFD_REG_TDC_TDCV_MASK, priv->can.tdc.tdcv) |
+		FIELD_PREP(MCP251XFD_REG_TDC_TDCO_MASK, priv->can.tdc.tdco);
 
 	return regmap_write(priv->map_reg, MCP251XFD_REG_TDC, val);
 }
@@ -2083,10 +2105,12 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->can.do_get_berr_counter = mcp251xfd_get_berr_counter;
 	priv->can.bittiming_const = &mcp251xfd_bittiming_const;
 	priv->can.data_bittiming_const = &mcp251xfd_data_bittiming_const;
+	priv->can.tdc_const = &mcp251xfd_tdc_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_LISTENONLY | CAN_CTRLMODE_BERR_REPORTING |
 		CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO |
-		CAN_CTRLMODE_CC_LEN8_DLC;
+		CAN_CTRLMODE_CC_LEN8_DLC | CAN_CTRLMODE_TDC_AUTO |
+		CAN_CTRLMODE_TDC_MANUAL;
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	priv->ndev = ndev;
 	priv->spi = spi;
@@ -2174,8 +2198,8 @@ static void mcp251xfd_remove(struct spi_device *spi)
 	struct mcp251xfd_priv *priv = spi_get_drvdata(spi);
 	struct net_device *ndev = priv->ndev;
 
-	can_rx_offload_del(&priv->offload);
 	mcp251xfd_unregister(priv);
+	can_rx_offload_del(&priv->offload);
 	spi->max_speed_hz = priv->spi_max_speed_hz_orig;
 	free_candev(ndev);
 }
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d4600ab0b70b..e072d2b50c98 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -373,15 +373,17 @@ static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
 		b53_read8(dev, B53_VLAN_PAGE, B53_VLAN_CTRL5, &vc5);
 	}
 
+	vc1 &= ~VC1_RX_MCST_FWD_EN;
+
 	if (enable) {
 		vc0 |= VC0_VLAN_EN | VC0_VID_CHK_EN | VC0_VID_HASH_VID;
-		vc1 |= VC1_RX_MCST_UNTAG_EN | VC1_RX_MCST_FWD_EN;
+		vc1 |= VC1_RX_MCST_UNTAG_EN;
 		vc4 &= ~VC4_ING_VID_CHECK_MASK;
 		if (enable_filtering) {
 			vc4 |= VC4_ING_VID_VIO_DROP << VC4_ING_VID_CHECK_S;
 			vc5 |= VC5_DROP_VTABLE_MISS;
 		} else {
-			vc4 |= VC4_ING_VID_VIO_FWD << VC4_ING_VID_CHECK_S;
+			vc4 |= VC4_NO_ING_VID_CHK << VC4_ING_VID_CHECK_S;
 			vc5 &= ~VC5_DROP_VTABLE_MISS;
 		}
 
@@ -393,7 +395,7 @@ static void b53_enable_vlan(struct b53_device *dev, int port, bool enable,
 
 	} else {
 		vc0 &= ~(VC0_VLAN_EN | VC0_VID_CHK_EN | VC0_VID_HASH_VID);
-		vc1 &= ~(VC1_RX_MCST_UNTAG_EN | VC1_RX_MCST_FWD_EN);
+		vc1 &= ~VC1_RX_MCST_UNTAG_EN;
 		vc4 &= ~VC4_ING_VID_CHECK_MASK;
 		vc5 &= ~VC5_DROP_VTABLE_MISS;
 
@@ -576,6 +578,18 @@ static void b53_eee_enable_set(struct dsa_switch *ds, int port, bool enable)
 	b53_write16(dev, B53_EEE_PAGE, B53_EEE_EN_CTRL, reg);
 }
 
+int b53_setup_port(struct dsa_switch *ds, int port)
+{
+	struct b53_device *dev = ds->priv;
+
+	b53_port_set_ucast_flood(dev, port, true);
+	b53_port_set_mcast_flood(dev, port, true);
+	b53_port_set_learning(dev, port, false);
+
+	return 0;
+}
+EXPORT_SYMBOL(b53_setup_port);
+
 int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 {
 	struct b53_device *dev = ds->priv;
@@ -588,10 +602,6 @@ int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy)
 
 	cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 
-	b53_port_set_ucast_flood(dev, port, true);
-	b53_port_set_mcast_flood(dev, port, true);
-	b53_port_set_learning(dev, port, false);
-
 	if (dev->ops->irq_enable)
 		ret = dev->ops->irq_enable(dev, port);
 	if (ret)
@@ -722,10 +732,6 @@ static void b53_enable_cpu_port(struct b53_device *dev, int port)
 	b53_write8(dev, B53_CTRL_PAGE, B53_PORT_CTRL(port), port_ctrl);
 
 	b53_brcm_hdr_setup(dev->ds, port);
-
-	b53_port_set_ucast_flood(dev, port, true);
-	b53_port_set_mcast_flood(dev, port, true);
-	b53_port_set_learning(dev, port, false);
 }
 
 static void b53_enable_mib(struct b53_device *dev)
@@ -761,6 +767,22 @@ static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, int port)
 	return dev->tag_protocol == DSA_TAG_PROTO_NONE && dsa_is_cpu_port(ds, port);
 }
 
+static bool b53_vlan_port_may_join_untagged(struct dsa_switch *ds, int port)
+{
+	struct b53_device *dev = ds->priv;
+	struct dsa_port *dp;
+
+	if (!dev->vlan_filtering)
+		return true;
+
+	dp = dsa_to_port(ds, port);
+
+	if (dsa_port_is_cpu(dp))
+		return true;
+
+	return dp->bridge == NULL;
+}
+
 int b53_configure_vlan(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
@@ -779,7 +801,7 @@ int b53_configure_vlan(struct dsa_switch *ds)
 		b53_do_vlan_op(dev, VTA_CMD_CLEAR);
 	}
 
-	b53_enable_vlan(dev, -1, dev->vlan_enabled, ds->vlan_filtering);
+	b53_enable_vlan(dev, -1, dev->vlan_enabled, dev->vlan_filtering);
 
 	/* Create an untagged VLAN entry for the default PVID in case
 	 * CONFIG_VLAN_8021Q is disabled and there are no calls to
@@ -787,26 +809,39 @@ int b53_configure_vlan(struct dsa_switch *ds)
 	 * entry. Do this only when the tagging protocol is not
 	 * DSA_TAG_PROTO_NONE
 	 */
+	v = &dev->vlans[def_vid];
 	b53_for_each_port(dev, i) {
-		v = &dev->vlans[def_vid];
-		v->members |= BIT(i);
+		if (!b53_vlan_port_may_join_untagged(ds, i))
+			continue;
+
+		vl.members |= BIT(i);
 		if (!b53_vlan_port_needs_forced_tagged(ds, i))
-			v->untag = v->members;
-		b53_write16(dev, B53_VLAN_PAGE,
-			    B53_VLAN_PORT_DEF_TAG(i), def_vid);
+			vl.untag = vl.members;
+		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(i),
+			    def_vid);
 	}
+	b53_set_vlan_entry(dev, def_vid, &vl);
 
-	/* Upon initial call we have not set-up any VLANs, but upon
-	 * system resume, we need to restore all VLAN entries.
-	 */
-	for (vid = def_vid; vid < dev->num_vlans; vid++) {
-		v = &dev->vlans[vid];
+	if (dev->vlan_filtering) {
+		/* Upon initial call we have not set-up any VLANs, but upon
+		 * system resume, we need to restore all VLAN entries.
+		 */
+		for (vid = def_vid + 1; vid < dev->num_vlans; vid++) {
+			v = &dev->vlans[vid];
 
-		if (!v->members)
-			continue;
+			if (!v->members)
+				continue;
+
+			b53_set_vlan_entry(dev, vid, v);
+			b53_fast_age_vlan(dev, vid);
+		}
 
-		b53_set_vlan_entry(dev, vid, v);
-		b53_fast_age_vlan(dev, vid);
+		b53_for_each_port(dev, i) {
+			if (!dsa_is_cpu_port(ds, i))
+				b53_write16(dev, B53_VLAN_PAGE,
+					    B53_VLAN_PORT_DEF_TAG(i),
+					    dev->ports[i].pvid);
+		}
 	}
 
 	return 0;
@@ -1126,7 +1161,9 @@ EXPORT_SYMBOL(b53_setup_devlink_resources);
 static int b53_setup(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
+	struct b53_vlan *vl;
 	unsigned int port;
+	u16 pvid;
 	int ret;
 
 	/* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
@@ -1134,12 +1171,26 @@ static int b53_setup(struct dsa_switch *ds)
 	 */
 	ds->untag_bridge_pvid = dev->tag_protocol == DSA_TAG_PROTO_NONE;
 
+	/* The switch does not tell us the original VLAN for untagged
+	 * packets, so keep the CPU port always tagged.
+	 */
+	ds->untag_vlan_aware_bridge_pvid = true;
+
 	ret = b53_reset_switch(dev);
 	if (ret) {
 		dev_err(ds->dev, "failed to reset switch\n");
 		return ret;
 	}
 
+	/* setup default vlan for filtering mode */
+	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
+	b53_for_each_port(dev, port) {
+		vl->members |= BIT(port);
+		if (!b53_vlan_port_needs_forced_tagged(ds, port))
+			vl->untag |= BIT(port);
+	}
+
 	b53_reset_mib(dev);
 
 	ret = b53_apply_config(dev);
@@ -1493,7 +1544,10 @@ int b53_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 {
 	struct b53_device *dev = ds->priv;
 
-	b53_enable_vlan(dev, port, dev->vlan_enabled, vlan_filtering);
+	if (dev->vlan_filtering != vlan_filtering) {
+		dev->vlan_filtering = vlan_filtering;
+		b53_apply_config(dev);
+	}
 
 	return 0;
 }
@@ -1518,7 +1572,7 @@ static int b53_vlan_prepare(struct dsa_switch *ds, int port,
 	if (vlan->vid >= dev->num_vlans)
 		return -ERANGE;
 
-	b53_enable_vlan(dev, port, true, ds->vlan_filtering);
+	b53_enable_vlan(dev, port, true, dev->vlan_filtering);
 
 	return 0;
 }
@@ -1531,18 +1585,29 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 	struct b53_vlan *vl;
+	u16 old_pvid, new_pvid;
 	int err;
 
 	err = b53_vlan_prepare(ds, port, vlan);
 	if (err)
 		return err;
 
-	vl = &dev->vlans[vlan->vid];
+	if (vlan->vid == 0)
+		return 0;
 
-	b53_get_vlan_entry(dev, vlan->vid, vl);
+	old_pvid = dev->ports[port].pvid;
+	if (pvid)
+		new_pvid = vlan->vid;
+	else if (!pvid && vlan->vid == old_pvid)
+		new_pvid = b53_default_pvid(dev);
+	else
+		new_pvid = old_pvid;
+	dev->ports[port].pvid = new_pvid;
+
+	vl = &dev->vlans[vlan->vid];
 
-	if (vlan->vid == 0 && vlan->vid == b53_default_pvid(dev))
-		untagged = true;
+	if (dsa_is_cpu_port(ds, port))
+		untagged = false;
 
 	vl->members |= BIT(port);
 	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
@@ -1550,13 +1615,16 @@ int b53_vlan_add(struct dsa_switch *ds, int port,
 	else
 		vl->untag &= ~BIT(port);
 
+	if (!dev->vlan_filtering)
+		return 0;
+
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
-	if (pvid && !dsa_is_cpu_port(ds, port)) {
+	if (!dsa_is_cpu_port(ds, port) && new_pvid != old_pvid) {
 		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port),
-			    vlan->vid);
-		b53_fast_age_vlan(dev, vlan->vid);
+			    new_pvid);
+		b53_fast_age_vlan(dev, old_pvid);
 	}
 
 	return 0;
@@ -1571,20 +1639,25 @@ int b53_vlan_del(struct dsa_switch *ds, int port,
 	struct b53_vlan *vl;
 	u16 pvid;
 
-	b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_PORT_DEF_TAG(port), &pvid);
+	if (vlan->vid == 0)
+		return 0;
 
-	vl = &dev->vlans[vlan->vid];
+	pvid = dev->ports[port].pvid;
 
-	b53_get_vlan_entry(dev, vlan->vid, vl);
+	vl = &dev->vlans[vlan->vid];
 
 	vl->members &= ~BIT(port);
 
 	if (pvid == vlan->vid)
 		pvid = b53_default_pvid(dev);
+	dev->ports[port].pvid = pvid;
 
 	if (untagged && !b53_vlan_port_needs_forced_tagged(ds, port))
 		vl->untag &= ~(BIT(port));
 
+	if (!dev->vlan_filtering)
+		return 0;
+
 	b53_set_vlan_entry(dev, vlan->vid, vl);
 	b53_fast_age_vlan(dev, vlan->vid);
 
@@ -1917,8 +1990,9 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 		bool *tx_fwd_offload, struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
+	struct b53_vlan *vl;
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
-	u16 pvlan, reg;
+	u16 pvlan, reg, pvid;
 	unsigned int i;
 
 	/* On 7278, port 7 which connects to the ASP should only receive
@@ -1927,15 +2001,29 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 	if (dev->chip_id == BCM7278_DEVICE_ID && port == 7)
 		return -EINVAL;
 
-	/* Make this port leave the all VLANs join since we will have proper
-	 * VLAN entries from now on
-	 */
-	if (is58xx(dev)) {
-		b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, &reg);
-		reg &= ~BIT(port);
-		if ((reg & BIT(cpu_port)) == BIT(cpu_port))
-			reg &= ~BIT(cpu_port);
-		b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
+	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
+
+	if (dev->vlan_filtering) {
+		/* Make this port leave the all VLANs join since we will have
+		 * proper VLAN entries from now on
+		 */
+		if (is58xx(dev)) {
+			b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN,
+				   &reg);
+			reg &= ~BIT(port);
+			if ((reg & BIT(cpu_port)) == BIT(cpu_port))
+				reg &= ~BIT(cpu_port);
+			b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN,
+				    reg);
+		}
+
+		b53_get_vlan_entry(dev, pvid, vl);
+		vl->members &= ~BIT(port);
+		if (vl->members == BIT(cpu_port))
+			vl->members &= ~BIT(cpu_port);
+		vl->untag = vl->members;
+		b53_set_vlan_entry(dev, pvid, vl);
 	}
 
 	b53_read16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), &pvlan);
@@ -1968,7 +2056,7 @@ EXPORT_SYMBOL(b53_br_join);
 void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 {
 	struct b53_device *dev = ds->priv;
-	struct b53_vlan *vl = &dev->vlans[0];
+	struct b53_vlan *vl;
 	s8 cpu_port = dsa_to_port(ds, port)->cpu_dp->index;
 	unsigned int i;
 	u16 pvlan, reg, pvid;
@@ -1994,15 +2082,18 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 	dev->ports[port].vlan_ctl_mask = pvlan;
 
 	pvid = b53_default_pvid(dev);
+	vl = &dev->vlans[pvid];
+
+	if (dev->vlan_filtering) {
+		/* Make this port join all VLANs without VLAN entries */
+		if (is58xx(dev)) {
+			b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, &reg);
+			reg |= BIT(port);
+			if (!(reg & BIT(cpu_port)))
+				reg |= BIT(cpu_port);
+			b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
+		}
 
-	/* Make this port join all VLANs without VLAN entries */
-	if (is58xx(dev)) {
-		b53_read16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, &reg);
-		reg |= BIT(port);
-		if (!(reg & BIT(cpu_port)))
-			reg |= BIT(cpu_port);
-		b53_write16(dev, B53_VLAN_PAGE, B53_JOIN_ALL_VLAN_EN, reg);
-	} else {
 		b53_get_vlan_entry(dev, pvid, vl);
 		vl->members |= BIT(port) | BIT(cpu_port);
 		vl->untag |= BIT(port) | BIT(cpu_port);
@@ -2307,6 +2398,7 @@ static const struct dsa_switch_ops b53_switch_ops = {
 	.phy_read		= b53_phy_read16,
 	.phy_write		= b53_phy_write16,
 	.phylink_get_caps	= b53_phylink_get_caps,
+	.port_setup		= b53_setup_port,
 	.port_enable		= b53_enable_port,
 	.port_disable		= b53_disable_port,
 	.get_mac_eee		= b53_get_mac_eee,
@@ -2751,6 +2843,7 @@ struct b53_device *b53_switch_alloc(struct device *base,
 	ds->ops = &b53_switch_ops;
 	ds->phylink_mac_ops = &b53_phylink_mac_ops;
 	dev->vlan_enabled = true;
+	dev->vlan_filtering = false;
 	/* Let DSA handle the case were multiple bridges span the same switch
 	 * device and different VLAN awareness settings are requested, which
 	 * would be breaking filtering semantics for any of the other bridge
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 05141176daf5..4f8c97098d2a 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -95,6 +95,7 @@ struct b53_pcs {
 
 struct b53_port {
 	u16		vlan_ctl_mask;
+	u16		pvid;
 	struct ethtool_keee eee;
 };
 
@@ -146,6 +147,7 @@ struct b53_device {
 	unsigned int num_vlans;
 	struct b53_vlan *vlans;
 	bool vlan_enabled;
+	bool vlan_filtering;
 	unsigned int num_ports;
 	struct b53_port *ports;
 
@@ -380,6 +382,7 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 					   enum dsa_tag_protocol mprot);
 void b53_mirror_del(struct dsa_switch *ds, int port,
 		    struct dsa_mall_mirror_tc_entry *mirror);
+int b53_setup_port(struct dsa_switch *ds, int port);
 int b53_enable_port(struct dsa_switch *ds, int port, struct phy_device *phy);
 void b53_disable_port(struct dsa_switch *ds, int port);
 void b53_brcm_hdr_setup(struct dsa_switch *ds, int port);
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 0e663ec0c12a..c4771a07878e 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1230,6 +1230,7 @@ static const struct dsa_switch_ops bcm_sf2_ops = {
 	.resume			= bcm_sf2_sw_resume,
 	.get_wol		= bcm_sf2_sw_get_wol,
 	.set_wol		= bcm_sf2_sw_set_wol,
+	.port_setup		= b53_setup_port,
 	.port_enable		= bcm_sf2_port_setup,
 	.port_disable		= bcm_sf2_port_disable,
 	.get_mac_eee		= b53_get_mac_eee,
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index f3e195974a8e..66e070095d1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // SPDX-FileCopyrightText: Copyright Red Hat
 
-#include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -9,27 +8,21 @@
 #include <linux/spinlock.h>
 #include <linux/xarray.h>
 #include "ice_adapter.h"
+#include "ice.h"
 
 static DEFINE_XARRAY(ice_adapters);
 static DEFINE_MUTEX(ice_adapters_mutex);
 
-/* PCI bus number is 8 bits. Slot is 5 bits. Domain can have the rest. */
-#define INDEX_FIELD_DOMAIN GENMASK(BITS_PER_LONG - 1, 13)
-#define INDEX_FIELD_BUS    GENMASK(12, 5)
-#define INDEX_FIELD_SLOT   GENMASK(4, 0)
-
-static unsigned long ice_adapter_index(const struct pci_dev *pdev)
+static unsigned long ice_adapter_index(u64 dsn)
 {
-	unsigned int domain = pci_domain_nr(pdev->bus);
-
-	WARN_ON(domain > FIELD_MAX(INDEX_FIELD_DOMAIN));
-
-	return FIELD_PREP(INDEX_FIELD_DOMAIN, domain) |
-	       FIELD_PREP(INDEX_FIELD_BUS,    pdev->bus->number) |
-	       FIELD_PREP(INDEX_FIELD_SLOT,   PCI_SLOT(pdev->devfn));
+#if BITS_PER_LONG == 64
+	return dsn;
+#else
+	return (u32)dsn ^ (u32)(dsn >> 32);
+#endif
 }
 
-static struct ice_adapter *ice_adapter_new(void)
+static struct ice_adapter *ice_adapter_new(u64 dsn)
 {
 	struct ice_adapter *adapter;
 
@@ -37,6 +30,7 @@ static struct ice_adapter *ice_adapter_new(void)
 	if (!adapter)
 		return NULL;
 
+	adapter->device_serial_number = dsn;
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	refcount_set(&adapter->refcount, 1);
 
@@ -67,23 +61,26 @@ static void ice_adapter_free(struct ice_adapter *adapter)
  * Return:  Pointer to ice_adapter on success.
  *          ERR_PTR() on error. -ENOMEM is the only possible error.
  */
-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
-	unsigned long index = ice_adapter_index(pdev);
+	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
+	unsigned long index;
 	int err;
 
+	index = ice_adapter_index(dsn);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		err = xa_insert(&ice_adapters, index, NULL, GFP_KERNEL);
 		if (err == -EBUSY) {
 			adapter = xa_load(&ice_adapters, index);
 			refcount_inc(&adapter->refcount);
+			WARN_ON_ONCE(adapter->device_serial_number != dsn);
 			return adapter;
 		}
 		if (err)
 			return ERR_PTR(err);
 
-		adapter = ice_adapter_new();
+		adapter = ice_adapter_new(dsn);
 		if (!adapter)
 			return ERR_PTR(-ENOMEM);
 		xa_store(&ice_adapters, index, adapter, GFP_KERNEL);
@@ -100,11 +97,13 @@ struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev)
  *
  * Context: Process, may sleep.
  */
-void ice_adapter_put(const struct pci_dev *pdev)
+void ice_adapter_put(struct pci_dev *pdev)
 {
-	unsigned long index = ice_adapter_index(pdev);
+	u64 dsn = pci_get_dsn(pdev);
 	struct ice_adapter *adapter;
+	unsigned long index;
 
+	index = ice_adapter_index(dsn);
 	scoped_guard(mutex, &ice_adapters_mutex) {
 		adapter = xa_load(&ice_adapters, index);
 		if (WARN_ON(!adapter))
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index e233225848b3..ac15c0d2bc1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -32,6 +32,7 @@ struct ice_port_list {
  * @refcount: Reference count. struct ice_pf objects hold the references.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
+ * @device_serial_number: DSN cached for collision detection on 32bit systems
  */
 struct ice_adapter {
 	refcount_t refcount;
@@ -40,9 +41,10 @@ struct ice_adapter {
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
+	u64 device_serial_number;
 };
 
-struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
-void ice_adapter_put(const struct pci_dev *pdev);
+struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
+void ice_adapter_put(struct pci_dev *pdev);
 
 #endif /* _ICE_ADAPTER_H */
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index c5d5b9ff8bc4..0a13f7c4684e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3140,11 +3140,19 @@ static int mtk_dma_init(struct mtk_eth *eth)
 static void mtk_dma_free(struct mtk_eth *eth)
 {
 	const struct mtk_soc_data *soc = eth->soc;
-	int i;
+	int i, j, txqs = 1;
+
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
+		txqs = MTK_QDMA_NUM_QUEUES;
+
+	for (i = 0; i < MTK_MAX_DEVS; i++) {
+		if (!eth->netdev[i])
+			continue;
+
+		for (j = 0; j < txqs; j++)
+			netdev_tx_reset_subqueue(eth->netdev[i], j);
+	}
 
-	for (i = 0; i < MTK_MAX_DEVS; i++)
-		if (eth->netdev[i])
-			netdev_reset_queue(eth->netdev[i]);
 	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
 		dma_free_coherent(eth->dma_dev,
 				  MTK_QDMA_RING_SIZE * soc->tx.desc_size,
@@ -3419,9 +3427,6 @@ static int mtk_open(struct net_device *dev)
 			}
 			mtk_gdm_config(eth, target_mac->id, gdm_config);
 		}
-		/* Reset and enable PSE */
-		mtk_w32(eth, RST_GL_PSE, MTK_RST_GL);
-		mtk_w32(eth, 0, MTK_RST_GL);
 
 		napi_enable(&eth->tx_napi);
 		napi_enable(&eth->rx_napi);
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 21db509acbc1..e91b4432fddd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -700,8 +700,10 @@ enum {
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG	0x3103e		/* 0xc40f8 */
+#define FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME		CSR_BIT(18)
 #define FBNIC_CSR_END_PUL_USER	0x31080	/* CSR section delimiter */
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 8f7a2a19ddf8..7775418316df 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -17,11 +17,29 @@ static void __fbnic_mbx_wr_desc(struct fbnic_dev *fbd, int mbx_idx,
 {
 	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
 
+	/* Write the upper 32b and then the lower 32b. Doing this the
+	 * FW can then read lower, upper, lower to verify that the state
+	 * of the descriptor wasn't changed mid-transaction.
+	 */
 	fw_wr32(fbd, desc_offset + 1, upper_32_bits(desc));
 	fw_wrfl(fbd);
 	fw_wr32(fbd, desc_offset, lower_32_bits(desc));
 }
 
+static void __fbnic_mbx_invalidate_desc(struct fbnic_dev *fbd, int mbx_idx,
+					int desc_idx, u32 desc)
+{
+	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
+
+	/* For initialization we write the lower 32b of the descriptor first.
+	 * This way we can set the state to mark it invalid before we clear the
+	 * upper 32b.
+	 */
+	fw_wr32(fbd, desc_offset, desc);
+	fw_wrfl(fbd);
+	fw_wr32(fbd, desc_offset + 1, 0);
+}
+
 static u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
 {
 	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
@@ -33,29 +51,41 @@ static u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
 	return desc;
 }
 
-static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+static void fbnic_mbx_reset_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	int desc_idx;
 
+	/* Disable DMA transactions from the device,
+	 * and flush any transactions triggered during cleaning
+	 */
+	switch (mbx_idx) {
+	case FBNIC_IPC_MBX_RX_IDX:
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH);
+		break;
+	case FBNIC_IPC_MBX_TX_IDX:
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH);
+		break;
+	}
+
+	wrfl(fbd);
+
 	/* Initialize first descriptor to all 0s. Doing this gives us a
 	 * solid stop for the firmware to hit when it is done looping
 	 * through the ring.
 	 */
-	__fbnic_mbx_wr_desc(fbd, mbx_idx, 0, 0);
-
-	fw_wrfl(fbd);
+	__fbnic_mbx_invalidate_desc(fbd, mbx_idx, 0, 0);
 
 	/* We then fill the rest of the ring starting at the end and moving
 	 * back toward descriptor 0 with skip descriptors that have no
 	 * length nor address, and tell the firmware that they can skip
 	 * them and just move past them to the one we initialized to 0.
 	 */
-	for (desc_idx = FBNIC_IPC_MBX_DESC_LEN; --desc_idx;) {
-		__fbnic_mbx_wr_desc(fbd, mbx_idx, desc_idx,
-				    FBNIC_IPC_MBX_DESC_FW_CMPL |
-				    FBNIC_IPC_MBX_DESC_HOST_CMPL);
-		fw_wrfl(fbd);
-	}
+	for (desc_idx = FBNIC_IPC_MBX_DESC_LEN; --desc_idx;)
+		__fbnic_mbx_invalidate_desc(fbd, mbx_idx, desc_idx,
+					    FBNIC_IPC_MBX_DESC_FW_CMPL |
+					    FBNIC_IPC_MBX_DESC_HOST_CMPL);
 }
 
 void fbnic_mbx_init(struct fbnic_dev *fbd)
@@ -76,7 +106,7 @@ void fbnic_mbx_init(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
 
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
-		fbnic_mbx_init_desc_ring(fbd, i);
+		fbnic_mbx_reset_desc_ring(fbd, i);
 }
 
 static int fbnic_mbx_map_msg(struct fbnic_dev *fbd, int mbx_idx,
@@ -141,7 +171,7 @@ static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	int i;
 
-	fbnic_mbx_init_desc_ring(fbd, mbx_idx);
+	fbnic_mbx_reset_desc_ring(fbd, mbx_idx);
 
 	for (i = FBNIC_IPC_MBX_DESC_LEN; i--;)
 		fbnic_mbx_unmap_and_free_msg(fbd, mbx_idx, i);
@@ -265,67 +295,41 @@ static int fbnic_fw_xmit_simple_msg(struct fbnic_dev *fbd, u32 msg_type)
 	return err;
 }
 
-/**
- * fbnic_fw_xmit_cap_msg - Allocate and populate a FW capabilities message
- * @fbd: FBNIC device structure
- *
- * Return: NULL on failure to allocate, error pointer on error, or pointer
- * to new TLV test message.
- *
- * Sends a single TLV header indicating the host wants the firmware to
- * confirm the capabilities and version.
- **/
-static int fbnic_fw_xmit_cap_msg(struct fbnic_dev *fbd)
-{
-	int err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
-
-	/* Return 0 if we are not calling this on ASIC */
-	return (err == -EOPNOTSUPP) ? 0 : err;
-}
-
-static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
 
-	/* This is a one time init, so just exit if it is completed */
-	if (mbx->ready)
-		return;
-
 	mbx->ready = true;
 
 	switch (mbx_idx) {
 	case FBNIC_IPC_MBX_RX_IDX:
+		/* Enable DMA writes from the device */
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
+
 		/* Make sure we have a page for the FW to write to */
 		fbnic_mbx_alloc_rx_msgs(fbd);
 		break;
 	case FBNIC_IPC_MBX_TX_IDX:
-		/* Force version to 1 if we successfully requested an update
-		 * from the firmware. This should be overwritten once we get
-		 * the actual version from the firmware in the capabilities
-		 * request message.
-		 */
-		if (!fbnic_fw_xmit_cap_msg(fbd) &&
-		    !fbd->fw_cap.running.mgmt.version)
-			fbd->fw_cap.running.mgmt.version = 1;
+		/* Enable DMA reads from the device */
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
 		break;
 	}
 }
 
-static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
+static bool fbnic_mbx_event(struct fbnic_dev *fbd)
 {
-	int i;
-
-	/* We only need to do this on the first interrupt following init.
+	/* We only need to do this on the first interrupt following reset.
 	 * this primes the mailbox so that we will have cleared all the
 	 * skip descriptors.
 	 */
 	if (!(rd32(fbd, FBNIC_INTR_STATUS(0)) & (1u << FBNIC_FW_MSIX_ENTRY)))
-		return;
+		return false;
 
 	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
 
-	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
-		fbnic_mbx_postinit_desc_ring(fbd, i);
+	return true;
 }
 
 /**
@@ -726,7 +730,7 @@ static void fbnic_mbx_process_rx_msgs(struct fbnic_dev *fbd)
 
 void fbnic_mbx_poll(struct fbnic_dev *fbd)
 {
-	fbnic_mbx_postinit(fbd);
+	fbnic_mbx_event(fbd);
 
 	fbnic_mbx_process_tx_msgs(fbd);
 	fbnic_mbx_process_rx_msgs(fbd);
@@ -734,60 +738,80 @@ void fbnic_mbx_poll(struct fbnic_dev *fbd)
 
 int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 {
-	struct fbnic_fw_mbx *tx_mbx;
-	int attempts = 50;
+	unsigned long timeout = jiffies + 10 * HZ + 1;
+	int err, i;
 
-	/* Immediate fail if BAR4 isn't there */
-	if (!fbnic_fw_present(fbd))
-		return -ENODEV;
+	do {
+		if (!time_is_after_jiffies(timeout))
+			return -ETIMEDOUT;
 
-	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
-	while (!tx_mbx->ready && --attempts) {
 		/* Force the firmware to trigger an interrupt response to
 		 * avoid the mailbox getting stuck closed if the interrupt
 		 * is reset.
 		 */
-		fbnic_mbx_init_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX);
+		fbnic_mbx_reset_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX);
 
-		msleep(200);
+		/* Immediate fail if BAR4 went away */
+		if (!fbnic_fw_present(fbd))
+			return -ENODEV;
 
-		fbnic_mbx_poll(fbd);
-	}
+		msleep(20);
+	} while (!fbnic_mbx_event(fbd));
+
+	/* FW has shown signs of life. Enable DMA and start Tx/Rx */
+	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
+		fbnic_mbx_init_desc_ring(fbd, i);
 
-	return attempts ? 0 : -ETIMEDOUT;
+	/* Request an update from the firmware. This should overwrite
+	 * mgmt.version once we get the actual version from the firmware
+	 * in the capabilities request message.
+	 */
+	err = fbnic_fw_xmit_simple_msg(fbd, FBNIC_TLV_MSG_ID_HOST_CAP_REQ);
+	if (err)
+		goto clean_mbx;
+
+	/* Use "1" to indicate we entered the state waiting for a response */
+	fbd->fw_cap.running.mgmt.version = 1;
+
+	return 0;
+clean_mbx:
+	/* Cleanup Rx buffers and disable mailbox */
+	fbnic_mbx_clean(fbd);
+	return err;
 }
 
 void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
 {
+	unsigned long timeout = jiffies + 10 * HZ + 1;
 	struct fbnic_fw_mbx *tx_mbx;
-	int attempts = 50;
-	u8 count = 0;
-
-	/* Nothing to do if there is no mailbox */
-	if (!fbnic_fw_present(fbd))
-		return;
+	u8 tail;
 
 	/* Record current Rx stats */
 	tx_mbx = &fbd->mbx[FBNIC_IPC_MBX_TX_IDX];
 
-	/* Nothing to do if mailbox never got to ready */
-	if (!tx_mbx->ready)
-		return;
+	spin_lock_irq(&fbd->fw_tx_lock);
+
+	/* Clear ready to prevent any further attempts to transmit */
+	tx_mbx->ready = false;
+
+	/* Read tail to determine the last tail state for the ring */
+	tail = tx_mbx->tail;
+
+	spin_unlock_irq(&fbd->fw_tx_lock);
 
 	/* Give firmware time to process packet,
-	 * we will wait up to 10 seconds which is 50 waits of 200ms.
+	 * we will wait up to 10 seconds which is 500 waits of 20ms.
 	 */
 	do {
 		u8 head = tx_mbx->head;
 
-		if (head == tx_mbx->tail)
+		/* Tx ring is empty once head == tail */
+		if (head == tail)
 			break;
 
-		msleep(200);
+		msleep(20);
 		fbnic_mbx_process_tx_msgs(fbd);
-
-		count += (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN;
-	} while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
+	} while (time_is_after_jiffies(timeout));
 }
 
 void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 7b654d0a6dac..06fa65e4f35b 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -79,12 +79,6 @@ static void fbnic_mac_init_axi(struct fbnic_dev *fbd)
 	fbnic_init_readrq(fbd, FBNIC_QM_RNI_RBP_CTL, cls, readrq);
 	fbnic_init_mps(fbd, FBNIC_QM_RNI_RDE_CTL, cls, mps);
 	fbnic_init_mps(fbd, FBNIC_QM_RNI_RCM_CTL, cls, mps);
-
-	/* Enable XALI AR/AW outbound */
-	wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
-	     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
-	wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
-	     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
 }
 
 static void fbnic_mac_init_qm(struct fbnic_dev *fbd)
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 60027b439021..fbd1150c33cc 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -298,6 +298,10 @@ struct send_queue {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	struct xsk_buff_pool *xsk_pool;
+
+	dma_addr_t xsk_hdr_dma_addr;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -501,6 +505,8 @@ struct virtio_net_common_hdr {
 	};
 };
 
+static struct virtio_net_common_hdr xsk_hdr;
+
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf_done(struct virtqueue *vq);
 static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
@@ -5421,6 +5427,10 @@ static void virtnet_get_base_stats(struct net_device *dev,
 
 	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_SPEED)
 		tx->hw_drop_ratelimits = 0;
+
+	netdev_stat_queue_sum(dev,
+			      dev->real_num_rx_queues, vi->max_queue_pairs, rx,
+			      dev->real_num_tx_queues, vi->max_queue_pairs, tx);
 }
 
 static const struct netdev_stat_ops virtnet_stat_ops = {
@@ -5556,6 +5566,29 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queu
 	return err;
 }
 
+static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
+				    struct send_queue *sq,
+				    struct xsk_buff_pool *pool)
+{
+	int err, qindex;
+
+	qindex = sq - vi->sq;
+
+	virtnet_tx_pause(vi, sq);
+
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	if (err) {
+		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
+		pool = NULL;
+	}
+
+	sq->xsk_pool = pool;
+
+	virtnet_tx_resume(vi, sq);
+
+	return err;
+}
+
 static int virtnet_xsk_pool_enable(struct net_device *dev,
 				   struct xsk_buff_pool *pool,
 				   u16 qid)
@@ -5564,6 +5597,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	struct receive_queue *rq;
 	struct device *dma_dev;
 	struct send_queue *sq;
+	dma_addr_t hdr_dma;
 	int err, size;
 
 	if (vi->hdr_len > xsk_pool_get_headroom(pool))
@@ -5601,6 +5635,13 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (!rq->xsk_buffs)
 		return -ENOMEM;
 
+	hdr_dma = virtqueue_dma_map_single_attrs(sq->vq, &xsk_hdr, vi->hdr_len,
+						 DMA_TO_DEVICE, 0);
+	if (virtqueue_dma_mapping_error(sq->vq, hdr_dma)) {
+		err = -ENOMEM;
+		goto err_free_buffs;
+	}
+
 	err = xsk_pool_dma_map(pool, dma_dev, 0);
 	if (err)
 		goto err_xsk_map;
@@ -5609,11 +5650,26 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (err)
 		goto err_rq;
 
+	err = virtnet_sq_bind_xsk_pool(vi, sq, pool);
+	if (err)
+		goto err_sq;
+
+	/* Now, we do not support tx offload(such as tx csum), so all the tx
+	 * virtnet hdr is zero. So all the tx packets can share a single hdr.
+	 */
+	sq->xsk_hdr_dma_addr = hdr_dma;
+
 	return 0;
 
+err_sq:
+	virtnet_rq_bind_xsk_pool(vi, rq, NULL);
 err_rq:
 	xsk_pool_dma_unmap(pool, 0);
 err_xsk_map:
+	virtqueue_dma_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
+					 DMA_TO_DEVICE, 0);
+err_free_buffs:
+	kvfree(rq->xsk_buffs);
 	return err;
 }
 
@@ -5622,19 +5678,24 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct xsk_buff_pool *pool;
 	struct receive_queue *rq;
+	struct send_queue *sq;
 	int err;
 
 	if (qid >= vi->curr_queue_pairs)
 		return -EINVAL;
 
+	sq = &vi->sq[qid];
 	rq = &vi->rq[qid];
 
 	pool = rq->xsk_pool;
 
 	err = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
+	err |= virtnet_sq_bind_xsk_pool(vi, sq, NULL);
 
 	xsk_pool_dma_unmap(pool, 0);
 
+	virtqueue_dma_unmap_single_attrs(sq->vq, sq->xsk_hdr_dma_addr,
+					 vi->hdr_len, DMA_TO_DEVICE, 0);
 	kvfree(rq->xsk_buffs);
 
 	return err;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f19410723b17..98dad1bdff44 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4473,7 +4473,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 		msleep(100);
 	}
 
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
 	nvme_unquiesce_io_queues(ctrl);
diff --git a/drivers/pci/hotplug/s390_pci_hpc.c b/drivers/pci/hotplug/s390_pci_hpc.c
index 055518ee354d..e9e9aaa91770 100644
--- a/drivers/pci/hotplug/s390_pci_hpc.c
+++ b/drivers/pci/hotplug/s390_pci_hpc.c
@@ -59,7 +59,6 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 
 	pdev = pci_get_slot(zdev->zbus->bus, zdev->devfn);
 	if (pdev && pci_num_vf(pdev)) {
-		pci_dev_put(pdev);
 		rc = -EBUSY;
 		goto out;
 	}
diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 1bbb9a6db597..6769f066b0b4 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -393,16 +393,14 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 	bytes_available = ioread32(fifo->base_addr + XLLF_RLR_OFFSET);
 	if (!bytes_available) {
-		dev_err(fifo->dt_device, "received a packet of length 0 - fifo core will be reset\n");
-		reset_ip_core(fifo);
+		dev_err(fifo->dt_device, "received a packet of length 0\n");
 		ret = -EIO;
 		goto end_unlock;
 	}
 
 	if (bytes_available > len) {
-		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu) - fifo core will be reset\n",
+		dev_err(fifo->dt_device, "user read buffer too small (available bytes=%zu user buffer bytes=%zu)\n",
 			bytes_available, len);
-		reset_ip_core(fifo);
 		ret = -EINVAL;
 		goto end_unlock;
 	}
@@ -411,8 +409,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		/* this probably can't happen unless IP
 		 * registers were previously mishandled
 		 */
-		dev_err(fifo->dt_device, "received a packet that isn't word-aligned - fifo core will be reset\n");
-		reset_ip_core(fifo);
+		dev_err(fifo->dt_device, "received a packet that isn't word-aligned\n");
 		ret = -EIO;
 		goto end_unlock;
 	}
@@ -433,7 +430,6 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 
 		if (copy_to_user(buf + copied * sizeof(u32), tmp_buf,
 				 copy * sizeof(u32))) {
-			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
 		}
@@ -542,7 +538,6 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 
 		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
 				   copy * sizeof(u32))) {
-			reset_ip_core(fifo);
 			ret = -EFAULT;
 			goto end_unlock;
 		}
@@ -775,9 +770,6 @@ static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 		goto end;
 	}
 
-	/* IP sets TDFV to fifo depth - 4 so we will do the same */
-	fifo->tx_fifo_depth -= 4;
-
 	ret = get_dts_property(fifo, "xlnx,use-rx-data", &fifo->has_rx_fifo);
 	if (ret) {
 		dev_err(fifo->dt_device, "missing xlnx,use-rx-data property\n");
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 6c14d7bcdd67..081b17f49863 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (strcmp(buf, "full")) {
+	if (strcmp(buf, "full") == 0) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index deec33f63bcf..e6724329356b 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1902,6 +1902,7 @@ static int bcm2835_mmal_probe(struct vchiq_device *device)
 				__func__, ret);
 			goto free_dev;
 		}
+		dev->v4l2_dev.dev = &device->dev;
 
 		/* setup v4l controls */
 		ret = bcm2835_mmal_init_controls(dev, &dev->ctrl_handler);
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 4a3f0f958256..79d06958d619 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -138,6 +138,26 @@ static void cdnsp_clear_port_change_bit(struct cdnsp_device *pdev,
 	       (portsc & PORT_CHANGE_BITS), port_regs);
 }
 
+static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev)
+{
+	struct cdns *cdns = dev_get_drvdata(pdev->dev);
+	__le32 __iomem *reg;
+	void __iomem *base;
+	u32 offset = 0;
+	u32 val;
+
+	if (!cdns->override_apb_timeout)
+		return;
+
+	base = &pdev->cap_regs->hc_capbase;
+	offset = cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
+	reg = base + offset + REG_CHICKEN_BITS_3_OFFSET;
+
+	val  = le32_to_cpu(readl(reg));
+	val = CHICKEN_APB_TIMEOUT_SET(val, cdns->override_apb_timeout);
+	writel(cpu_to_le32(val), reg);
+}
+
 static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
 {
 	__le32 __iomem *reg;
@@ -1772,6 +1792,8 @@ static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
 	reg += cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
 	pdev->rev_cap  = reg;
 
+	pdev->rtl_revision = readl(&pdev->rev_cap->rtl_revision);
+
 	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
 		 readl(&pdev->rev_cap->ctrl_revision),
 		 readl(&pdev->rev_cap->rtl_revision),
@@ -1797,6 +1819,15 @@ static int cdnsp_gen_setup(struct cdnsp_device *pdev)
 	pdev->hci_version = HC_VERSION(pdev->hcc_params);
 	pdev->hcc_params = readl(&pdev->cap_regs->hcc_params);
 
+	/*
+	 * Override the APB timeout value to give the controller more time for
+	 * enabling UTMI clock and synchronizing APB and UTMI clock domains.
+	 * This fix is platform specific and is required to fixes issue with
+	 * reading incorrect value from PORTSC register after resuming
+	 * from L1 state.
+	 */
+	cdnsp_set_apb_timeout_value(pdev);
+
 	cdnsp_get_rev_cap(pdev);
 
 	/* Make sure the Device Controller is halted. */
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 84887dfea763..12534be52f39 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -520,6 +520,9 @@ struct cdnsp_rev_cap {
 #define REG_CHICKEN_BITS_2_OFFSET	0x48
 #define CHICKEN_XDMA_2_TP_CACHE_DIS	BIT(28)
 
+#define REG_CHICKEN_BITS_3_OFFSET       0x4C
+#define CHICKEN_APB_TIMEOUT_SET(p, val) (((p) & ~GENMASK(21, 0)) | (val))
+
 /* XBUF Extended Capability ID. */
 #define XBUF_CAP_ID			0xCB
 #define XBUF_RX_TAG_MASK_0_OFFSET	0x1C
@@ -1357,6 +1360,7 @@ struct cdnsp_port {
  * @rev_cap: Controller Capabilities Registers.
  * @hcs_params1: Cached register copies of read-only HCSPARAMS1
  * @hcc_params: Cached register copies of read-only HCCPARAMS1
+ * @rtl_revision: Cached controller rtl revision.
  * @setup: Temporary buffer for setup packet.
  * @ep0_preq: Internal allocated request used during enumeration.
  * @ep0_stage: ep0 stage during enumeration process.
@@ -1411,6 +1415,8 @@ struct cdnsp_device {
 	__u32 hcs_params1;
 	__u32 hcs_params3;
 	__u32 hcc_params;
+	#define RTL_REVISION_NEW_LPM 0x2700
+	__u32 rtl_revision;
 	/* Lock used in interrupt thread context. */
 	spinlock_t lock;
 	struct usb_ctrlrequest setup;
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 2d05368a6745..36781ea60f6a 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -34,6 +34,8 @@
 #define PCI_CLASS_SERIAL_USB_CDNS_USB3	(PCI_CLASS_SERIAL_USB << 8 | 0x80)
 #define PCI_CLASS_SERIAL_USB_CDNS_UDC	PCI_CLASS_SERIAL_USB_DEVICE
 
+#define CHICKEN_APB_TIMEOUT_VALUE       0x1C20
+
 static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
 {
 	/*
@@ -145,6 +147,14 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 		cdnsp->otg_irq = pdev->irq;
 	}
 
+	/*
+	 * Cadence PCI based platform require some longer timeout for APB
+	 * to fixes domain clock synchronization issue after resuming
+	 * controller from L1 state.
+	 */
+	cdnsp->override_apb_timeout = CHICKEN_APB_TIMEOUT_VALUE;
+	pci_set_drvdata(pdev, cdnsp);
+
 	if (pci_is_enabled(func)) {
 		cdnsp->dev = dev;
 		cdnsp->gadget_init = cdnsp_gadget_init;
@@ -154,8 +164,6 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 			goto free_cdnsp;
 	}
 
-	pci_set_drvdata(pdev, cdnsp);
-
 	device_wakeup_enable(&pdev->dev);
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_put_noidle(&pdev->dev);
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index 46852529499d..fd06cb85c4ea 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -308,7 +308,8 @@ static bool cdnsp_ring_ep_doorbell(struct cdnsp_device *pdev,
 
 	writel(db_value, reg_addr);
 
-	cdnsp_force_l0_go(pdev);
+	if (pdev->rtl_revision < RTL_REVISION_NEW_LPM)
+		cdnsp_force_l0_go(pdev);
 
 	/* Doorbell was set. */
 	return true;
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 57d47348dc19..ac30ee21309d 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -79,6 +79,8 @@ struct cdns3_platform_data {
  * @pdata: platform data from glue layer
  * @lock: spinlock structure
  * @xhci_plat_data: xhci private data structure pointer
+ * @override_apb_timeout: hold value of APB timeout. For value 0 the default
+ *                        value in CHICKEN_BITS_3 will be preserved.
  * @gadget_init: pointer to gadget initialization function
  */
 struct cdns {
@@ -117,6 +119,7 @@ struct cdns {
 	struct cdns3_platform_data	*pdata;
 	spinlock_t			lock;
 	struct xhci_plat_priv		*xhci_plat_data;
+	u32                             override_apb_timeout;
 
 	int (*gadget_init)(struct cdns *cdns);
 };
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 34e46ef308ab..740d2d2b19fb 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -482,6 +482,7 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	u8 *buffer;
 	u8 tag;
 	int rv;
+	long wait_rv;
 
 	dev_dbg(dev, "Enter ioctl_read_stb iin_ep_present: %d\n",
 		data->iin_ep_present);
@@ -511,16 +512,17 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 	}
 
 	if (data->iin_ep_present) {
-		rv = wait_event_interruptible_timeout(
+		wait_rv = wait_event_interruptible_timeout(
 			data->waitq,
 			atomic_read(&data->iin_data_valid) != 0,
 			file_data->timeout);
-		if (rv < 0) {
-			dev_dbg(dev, "wait interrupted %d\n", rv);
+		if (wait_rv < 0) {
+			dev_dbg(dev, "wait interrupted %ld\n", wait_rv);
+			rv = wait_rv;
 			goto exit;
 		}
 
-		if (rv == 0) {
+		if (wait_rv == 0) {
 			dev_dbg(dev, "wait timed out\n");
 			rv = -ETIMEDOUT;
 			goto exit;
@@ -539,6 +541,8 @@ static int usbtmc_get_stb(struct usbtmc_file_data *file_data, __u8 *stb)
 
 	dev_dbg(dev, "stb:0x%02x received %d\n", (unsigned int)*stb, rv);
 
+	rv = 0;
+
  exit:
 	/* bump interrupt bTag */
 	data->iin_bTag += 1;
@@ -602,9 +606,9 @@ static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
 {
 	struct usbtmc_device_data *data = file_data->data;
 	struct device *dev = &data->intf->dev;
-	int rv;
 	u32 timeout;
 	unsigned long expire;
+	long wait_rv;
 
 	if (!data->iin_ep_present) {
 		dev_dbg(dev, "no interrupt endpoint present\n");
@@ -618,25 +622,24 @@ static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
 
 	mutex_unlock(&data->io_mutex);
 
-	rv = wait_event_interruptible_timeout(
-			data->waitq,
-			atomic_read(&file_data->srq_asserted) != 0 ||
-			atomic_read(&file_data->closing),
-			expire);
+	wait_rv = wait_event_interruptible_timeout(
+		data->waitq,
+		atomic_read(&file_data->srq_asserted) != 0 ||
+		atomic_read(&file_data->closing),
+		expire);
 
 	mutex_lock(&data->io_mutex);
 
 	/* Note! disconnect or close could be called in the meantime */
 	if (atomic_read(&file_data->closing) || data->zombie)
-		rv = -ENODEV;
+		return -ENODEV;
 
-	if (rv < 0) {
-		/* dev can be invalid now! */
-		pr_debug("%s - wait interrupted %d\n", __func__, rv);
-		return rv;
+	if (wait_rv < 0) {
+		dev_dbg(dev, "%s - wait interrupted %ld\n", __func__, wait_rv);
+		return wait_rv;
 	}
 
-	if (rv == 0) {
+	if (wait_rv == 0) {
 		dev_dbg(dev, "%s - wait timed out\n", __func__);
 		return -ETIMEDOUT;
 	}
@@ -830,6 +833,7 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 	unsigned long expire;
 	int bufcount = 1;
 	int again = 0;
+	long wait_rv;
 
 	/* mutex already locked */
 
@@ -942,19 +946,24 @@ static ssize_t usbtmc_generic_read(struct usbtmc_file_data *file_data,
 		if (!(flags & USBTMC_FLAG_ASYNC)) {
 			dev_dbg(dev, "%s: before wait time %lu\n",
 				__func__, expire);
-			retval = wait_event_interruptible_timeout(
+			wait_rv = wait_event_interruptible_timeout(
 				file_data->wait_bulk_in,
 				usbtmc_do_transfer(file_data),
 				expire);
 
-			dev_dbg(dev, "%s: wait returned %d\n",
-				__func__, retval);
+			dev_dbg(dev, "%s: wait returned %ld\n",
+				__func__, wait_rv);
+
+			if (wait_rv < 0) {
+				retval = wait_rv;
+				goto error;
+			}
 
-			if (retval <= 0) {
-				if (retval == 0)
-					retval = -ETIMEDOUT;
+			if (wait_rv == 0) {
+				retval = -ETIMEDOUT;
 				goto error;
 			}
+
 		}
 
 		urb = usb_get_from_anchor(&file_data->in_anchor);
@@ -1380,7 +1389,10 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 	if (!buffer)
 		return -ENOMEM;
 
-	mutex_lock(&data->io_mutex);
+	retval = mutex_lock_interruptible(&data->io_mutex);
+	if (retval < 0)
+		goto exit_nolock;
+
 	if (data->zombie) {
 		retval = -ENODEV;
 		goto exit;
@@ -1503,6 +1515,7 @@ static ssize_t usbtmc_read(struct file *filp, char __user *buf,
 
 exit:
 	mutex_unlock(&data->io_mutex);
+exit_nolock:
 	kfree(buffer);
 	return retval;
 }
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f288d88cd105..30fe7df1c3ca 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1168,6 +1168,9 @@ struct dwc3_scratchpad_array {
  * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
  *		       DATWRREQINFO, and DESWRREQINFO value passed from
  *		       glue driver.
+ * @wakeup_pending_funcs: Indicates whether any interface has requested for
+ *			 function wakeup in bitmap format where bit position
+ *			 represents interface_id.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1398,6 +1401,7 @@ struct dwc3 {
 	int			num_ep_resized;
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
+	u32			wakeup_pending_funcs;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e72bac650981..76e6000c65c7 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -277,8 +277,6 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 	return ret;
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
-
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
  * @dep: the endpoint to which the command is going to be issued
@@ -2348,10 +2346,8 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
 	return __dwc3_gadget_get_frame(dwc);
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 {
-	int			retries;
-
 	int			ret;
 	u32			reg;
 
@@ -2379,8 +2375,7 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 		return -EINVAL;
 	}
 
-	if (async)
-		dwc3_gadget_enable_linksts_evts(dwc, true);
+	dwc3_gadget_enable_linksts_evts(dwc, true);
 
 	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
 	if (ret < 0) {
@@ -2399,27 +2394,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 
 	/*
 	 * Since link status change events are enabled we will receive
-	 * an U0 event when wakeup is successful. So bail out.
+	 * an U0 event when wakeup is successful.
 	 */
-	if (async)
-		return 0;
-
-	/* poll until Link State changes to ON */
-	retries = 20000;
-
-	while (retries--) {
-		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
-
-		/* in HS, means ON */
-		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
-			break;
-	}
-
-	if (DWC3_DSTS_USBLNKST(reg) != DWC3_LINK_STATE_U0) {
-		dev_err(dwc->dev, "failed to send remote wakeup\n");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -2440,7 +2416,7 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return -EINVAL;
 	}
-	ret = __dwc3_gadget_wakeup(dwc, true);
+	ret = __dwc3_gadget_wakeup(dwc);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2468,14 +2444,10 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 	 */
 	link_state = dwc3_gadget_get_link_state(dwc);
 	if (link_state == DWC3_LINK_STATE_U3) {
-		ret = __dwc3_gadget_wakeup(dwc, false);
-		if (ret) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return -EINVAL;
-		}
-		dwc3_resume_gadget(dwc);
-		dwc->suspended = false;
-		dwc->link_state = DWC3_LINK_STATE_U0;
+		dwc->wakeup_pending_funcs |= BIT(intf_id);
+		ret = __dwc3_gadget_wakeup(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return ret;
 	}
 
 	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
@@ -4320,6 +4292,8 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state	next = evtinfo & DWC3_LINK_STATE_MASK;
 	unsigned int		pwropt;
+	int			ret;
+	int			intf_id;
 
 	/*
 	 * WORKAROUND: DWC3 < 2.50a have an issue when configured without
@@ -4395,7 +4369,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 	switch (next) {
 	case DWC3_LINK_STATE_U0:
-		if (dwc->gadget->wakeup_armed) {
+		if (dwc->gadget->wakeup_armed || dwc->wakeup_pending_funcs) {
 			dwc3_gadget_enable_linksts_evts(dwc, false);
 			dwc3_resume_gadget(dwc);
 			dwc->suspended = false;
@@ -4418,6 +4392,18 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	dwc->link_state = next;
+
+	/* Proceed with func wakeup if any interfaces that has requested */
+	while (dwc->wakeup_pending_funcs && (next == DWC3_LINK_STATE_U0)) {
+		intf_id = ffs(dwc->wakeup_pending_funcs) - 1;
+		ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
+						       DWC3_DGCMDPAR_DN_FUNC_WAKE |
+						       DWC3_DGCMDPAR_INTF_SEL(intf_id));
+		if (ret)
+			dev_err(dwc->dev, "Failed to send DN wake for intf %d\n", intf_id);
+
+		dwc->wakeup_pending_funcs &= ~BIT(intf_id);
+	}
 }
 
 static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 8402a86176f4..301a435b9ee3 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2011,15 +2011,13 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 
 		if (f->get_status) {
 			status = f->get_status(f);
+
 			if (status < 0)
 				break;
-		} else {
-			/* Set D0 and D1 bits based on func wakeup capability */
-			if (f->config->bmAttributes & USB_CONFIG_ATT_WAKEUP) {
-				status |= USB_INTRF_STAT_FUNC_RW_CAP;
-				if (f->func_wakeup_armed)
-					status |= USB_INTRF_STAT_FUNC_RW;
-			}
+
+			/* if D5 is not set, then device is not wakeup capable */
+			if (!(f->config->bmAttributes & USB_CONFIG_ATT_WAKEUP))
+				status &= ~(USB_INTRF_STAT_FUNC_RW_CAP | USB_INTRF_STAT_FUNC_RW);
 		}
 
 		put_unaligned_le16(status & 0x0000ffff, req->buf);
diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
index 6cb7771e8a69..549efc84dd83 100644
--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -892,6 +892,12 @@ static void ecm_resume(struct usb_function *f)
 	gether_resume(&ecm->port);
 }
 
+static int ecm_get_status(struct usb_function *f)
+{
+	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
+		USB_INTRF_STAT_FUNC_RW_CAP;
+}
+
 static void ecm_free(struct usb_function *f)
 {
 	struct f_ecm *ecm;
@@ -960,6 +966,7 @@ static struct usb_function *ecm_alloc(struct usb_function_instance *fi)
 	ecm->port.func.disable = ecm_disable;
 	ecm->port.func.free_func = ecm_free;
 	ecm->port.func.suspend = ecm_suspend;
+	ecm->port.func.get_status = ecm_get_status;
 	ecm->port.func.resume = ecm_resume;
 
 	return &ecm->port.func;
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 7aa46d426f31..9bb54da8a6ae 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1749,6 +1749,10 @@ static int __tegra_xudc_ep_disable(struct tegra_xudc_ep *ep)
 		val = xudc_readl(xudc, CTRL);
 		val &= ~CTRL_RUN;
 		xudc_writel(xudc, val, CTRL);
+
+		val = xudc_readl(xudc, ST);
+		if (val & ST_RC)
+			xudc_writel(xudc, ST_RC, ST);
 	}
 
 	dev_info(xudc->dev, "ep %u disabled\n", ep->index);
diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 3dec5dd3a0d5..712389599d46 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -121,7 +121,7 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get and enable clock if any specified */
-	uhci->clk = devm_clk_get(&pdev->dev, NULL);
+	uhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(uhci->clk)) {
 		ret = PTR_ERR(uhci->clk);
 		goto err_rmr;
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 76f228e7443c..89b3079194d7 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1363,6 +1363,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(tegra->padctl,
 								    tegra->otg_usb2_port);
 
+	pm_runtime_get_sync(tegra->dev);
 	if (tegra->host_mode) {
 		/* switch to host mode */
 		if (tegra->otg_usb3_port >= 0) {
@@ -1392,6 +1393,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 		}
 
 		tegra_xhci_set_port_power(tegra, true, true);
+		pm_runtime_mark_last_busy(tegra->dev);
 
 	} else {
 		if (tegra->otg_usb3_port >= 0)
@@ -1399,6 +1401,7 @@ static void tegra_xhci_id_work(struct work_struct *work)
 
 		tegra_xhci_set_port_power(tegra, true, false);
 	}
+	pm_runtime_put_autosuspend(tegra->dev);
 }
 
 #if IS_ENABLED(CONFIG_PM) || IS_ENABLED(CONFIG_PM_SLEEP)
diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 27b0a6e18267..b4d5408a4371 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -569,8 +569,14 @@ static void onboard_dev_usbdev_disconnect(struct usb_device *udev)
 }
 
 static const struct usb_device_id onboard_dev_id_table[] = {
-	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 HUB */
-	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6500) }, /* CYUSB330x 3.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6502) }, /* CYUSB330x 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6503) }, /* CYUSB33{0,1}x 2.0 HUB, Vendor Mode */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB331x 3.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB331x 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6507) }, /* CYUSB332x 2.0 HUB, Vendor Mode */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6508) }, /* CYUSB332x 3.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x650a) }, /* CYUSB332x 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6570) }, /* CY7C6563x 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 HUB */
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 48ddf2770461..bbd7f53f7d59 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5890,7 +5890,7 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 	case SNK_TRY_WAIT_DEBOUNCE:
 		if (!tcpm_port_is_sink(port)) {
 			port->max_wait = 0;
-			tcpm_set_state(port, SRC_TRYWAIT, 0);
+			tcpm_set_state(port, SRC_TRYWAIT, PD_T_PD_DEBOUNCE);
 		}
 		break;
 	case SRC_TRY_WAIT:
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 420af5139c70..5d24a2321e15 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -296,6 +296,8 @@ void ucsi_displayport_remove_partner(struct typec_altmode *alt)
 	if (!dp)
 		return;
 
+	cancel_work_sync(&dp->work);
+
 	dp->data.conf = 0;
 	dp->data.status = 0;
 	dp->initialized = false;
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1a4ed5a357d3..c9eaba227636 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1658,14 +1658,14 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
+	unsigned long addr = vmf->address & ~((PAGE_SIZE << order) - 1);
+	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	unsigned long pfn = vma_to_pfn(vma) + pgoff;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
-	pfn = vma_to_pfn(vma) + pgoff;
-
-	if (order && (pfn & ((1 << order) - 1) ||
-		      vmf->address & ((PAGE_SIZE << order) - 1) ||
-		      vmf->address + (PAGE_SIZE << order) > vma->vm_end)) {
+	if (order && (addr < vma->vm_start ||
+		      addr + (PAGE_SIZE << order) > vma->vm_end ||
+		      pfn & ((1 << order) - 1))) {
 		ret = VM_FAULT_FALLBACK;
 		goto out;
 	}
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 1f65795cf5d7..ef56a2500ed6 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -217,6 +217,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 * buffering it.
 	 */
 	if (dma_capable(dev, dev_addr, size, true) &&
+	    !dma_kmalloc_needs_bounce(dev, size, dir) &&
 	    !range_straddles_page_boundary(phys, size) &&
 		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
 		!is_swiotlb_force_bounce(dev))
diff --git a/drivers/xen/xenbus/xenbus.h b/drivers/xen/xenbus/xenbus.h
index 13821e7e825e..9ac0427724a3 100644
--- a/drivers/xen/xenbus/xenbus.h
+++ b/drivers/xen/xenbus/xenbus.h
@@ -77,6 +77,7 @@ enum xb_req_state {
 struct xb_req_data {
 	struct list_head list;
 	wait_queue_head_t wq;
+	struct kref kref;
 	struct xsd_sockmsg msg;
 	uint32_t caller_req_id;
 	enum xsd_sockmsg_type type;
@@ -103,6 +104,7 @@ int xb_init_comms(void);
 void xb_deinit_comms(void);
 int xs_watch_msg(struct xs_watch_event *event);
 void xs_request_exit(struct xb_req_data *req);
+void xs_free_req(struct kref *kref);
 
 int xenbus_match(struct device *_dev, const struct device_driver *_drv);
 int xenbus_dev_probe(struct device *_dev);
diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
index e5fda0256feb..82df2da1b880 100644
--- a/drivers/xen/xenbus/xenbus_comms.c
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -309,8 +309,8 @@ static int process_msg(void)
 			virt_wmb();
 			req->state = xb_req_state_got_reply;
 			req->cb(req);
-		} else
-			kfree(req);
+		}
+		kref_put(&req->kref, xs_free_req);
 	}
 
 	mutex_unlock(&xs_response_mutex);
@@ -386,14 +386,13 @@ static int process_writes(void)
 	state.req->msg.type = XS_ERROR;
 	state.req->err = err;
 	list_del(&state.req->list);
-	if (state.req->state == xb_req_state_aborted)
-		kfree(state.req);
-	else {
+	if (state.req->state != xb_req_state_aborted) {
 		/* write err, then update state */
 		virt_wmb();
 		state.req->state = xb_req_state_got_reply;
 		wake_up(&state.req->wq);
 	}
+	kref_put(&state.req->kref, xs_free_req);
 
 	mutex_unlock(&xb_write_mutex);
 
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 46f8916597e5..f5c21ba64df5 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -406,7 +406,7 @@ void xenbus_dev_queue_reply(struct xb_req_data *req)
 	mutex_unlock(&u->reply_mutex);
 
 	kfree(req->body);
-	kfree(req);
+	kref_put(&req->kref, xs_free_req);
 
 	kref_put(&u->kref, xenbus_file_free);
 
diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
index d32c726f7a12..dcf9182c8451 100644
--- a/drivers/xen/xenbus/xenbus_xs.c
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -112,6 +112,12 @@ static void xs_suspend_exit(void)
 	wake_up_all(&xs_state_enter_wq);
 }
 
+void xs_free_req(struct kref *kref)
+{
+	struct xb_req_data *req = container_of(kref, struct xb_req_data, kref);
+	kfree(req);
+}
+
 static uint32_t xs_request_enter(struct xb_req_data *req)
 {
 	uint32_t rq_id;
@@ -237,6 +243,12 @@ static void xs_send(struct xb_req_data *req, struct xsd_sockmsg *msg)
 	req->caller_req_id = req->msg.req_id;
 	req->msg.req_id = xs_request_enter(req);
 
+	/*
+	 * Take 2nd ref.  One for this thread, and the second for the
+	 * xenbus_thread.
+	 */
+	kref_get(&req->kref);
+
 	mutex_lock(&xb_write_mutex);
 	list_add_tail(&req->list, &xb_write_list);
 	notify = list_is_singular(&xb_write_list);
@@ -261,8 +273,8 @@ static void *xs_wait_for_reply(struct xb_req_data *req, struct xsd_sockmsg *msg)
 	if (req->state == xb_req_state_queued ||
 	    req->state == xb_req_state_wait_reply)
 		req->state = xb_req_state_aborted;
-	else
-		kfree(req);
+
+	kref_put(&req->kref, xs_free_req);
 	mutex_unlock(&xb_write_mutex);
 
 	return ret;
@@ -291,6 +303,7 @@ int xenbus_dev_request_and_reply(struct xsd_sockmsg *msg, void *par)
 	req->cb = xenbus_dev_queue_reply;
 	req->par = par;
 	req->user_req = true;
+	kref_init(&req->kref);
 
 	xs_send(req, msg);
 
@@ -319,6 +332,7 @@ static void *xs_talkv(struct xenbus_transaction t,
 	req->num_vecs = num_vecs;
 	req->cb = xs_wake_up;
 	req->user_req = false;
+	kref_init(&req->kref);
 
 	msg.req_id = 0;
 	msg.tx_id = t.id;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 587ac07cd194..8e6501860001 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -732,82 +732,6 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
 	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
 }
 
-/*
- * We can have very weird soft links passed in.
- * One example is "/proc/self/fd/<fd>", which can be a soft link to
- * a block device.
- *
- * But it's never a good idea to use those weird names.
- * Here we check if the path (not following symlinks) is a good one inside
- * "/dev/".
- */
-static bool is_good_dev_path(const char *dev_path)
-{
-	struct path path = { .mnt = NULL, .dentry = NULL };
-	char *path_buf = NULL;
-	char *resolved_path;
-	bool is_good = false;
-	int ret;
-
-	if (!dev_path)
-		goto out;
-
-	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!path_buf)
-		goto out;
-
-	/*
-	 * Do not follow soft link, just check if the original path is inside
-	 * "/dev/".
-	 */
-	ret = kern_path(dev_path, 0, &path);
-	if (ret)
-		goto out;
-	resolved_path = d_path(&path, path_buf, PATH_MAX);
-	if (IS_ERR(resolved_path))
-		goto out;
-	if (strncmp(resolved_path, "/dev/", strlen("/dev/")))
-		goto out;
-	is_good = true;
-out:
-	kfree(path_buf);
-	path_put(&path);
-	return is_good;
-}
-
-static int get_canonical_dev_path(const char *dev_path, char *canonical)
-{
-	struct path path = { .mnt = NULL, .dentry = NULL };
-	char *path_buf = NULL;
-	char *resolved_path;
-	int ret;
-
-	if (!dev_path) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	path_buf = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!path_buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = kern_path(dev_path, LOOKUP_FOLLOW, &path);
-	if (ret)
-		goto out;
-	resolved_path = d_path(&path, path_buf, PATH_MAX);
-	if (IS_ERR(resolved_path)) {
-		ret = PTR_ERR(resolved_path);
-		goto out;
-	}
-	ret = strscpy(canonical, resolved_path, PATH_MAX);
-out:
-	kfree(path_buf);
-	path_put(&path);
-	return ret;
-}
-
 static bool is_same_device(struct btrfs_device *device, const char *new_path)
 {
 	struct path old = { .mnt = NULL, .dentry = NULL };
@@ -1495,23 +1419,12 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	bool new_device_added = false;
 	struct btrfs_device *device = NULL;
 	struct file *bdev_file;
-	char *canonical_path = NULL;
 	u64 bytenr;
 	dev_t devt;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
 
-	if (!is_good_dev_path(path)) {
-		canonical_path = kmalloc(PATH_MAX, GFP_KERNEL);
-		if (canonical_path) {
-			ret = get_canonical_dev_path(path, canonical_path);
-			if (ret < 0) {
-				kfree(canonical_path);
-				canonical_path = NULL;
-			}
-		}
-	}
 	/*
 	 * Avoid an exclusive open here, as the systemd-udev may initiate the
 	 * device scan which may race with the user's mount or mkfs command,
@@ -1556,8 +1469,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto free_disk_super;
 	}
 
-	device = device_list_add(canonical_path ? : path, disk_super,
-				 &new_device_added);
+	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
@@ -1566,7 +1478,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 error_bdev_put:
 	fput(bdev_file);
-	kfree(canonical_path);
 
 	return device;
 }
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 17aed5f6c549..12e709d93445 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -150,10 +150,10 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 				io->rq->bio.bi_iter.bi_sector = io->dev.m_pa >> 9;
 				attached = 0;
 			}
-			if (!attached++)
-				erofs_onlinefolio_split(folio);
 			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
 				goto io_retry;
+			if (!attached++)
+				erofs_onlinefolio_split(folio);
 			io->dev.m_pa += len;
 		}
 		cur += len;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index a8fb4b525f54..e5e94afc5af8 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -82,9 +82,6 @@ struct z_erofs_pcluster {
 	/* L: whether partial decompression or not */
 	bool partial;
 
-	/* L: indicate several pageofs_outs or not */
-	bool multibases;
-
 	/* L: whether extra buffer allocations are best-effort */
 	bool besteffort;
 
@@ -1073,8 +1070,6 @@ static int z_erofs_scan_folio(struct z_erofs_decompress_frontend *f,
 				break;
 
 			erofs_onlinefolio_split(folio);
-			if (f->pcl->pageofs_out != (map->m_la & ~PAGE_MASK))
-				f->pcl->multibases = true;
 			if (f->pcl->length < offset + end - map->m_la) {
 				f->pcl->length = offset + end - map->m_la;
 				f->pcl->pageofs_out = map->m_la & ~PAGE_MASK;
@@ -1120,7 +1115,6 @@ struct z_erofs_decompress_backend {
 	struct page *onstack_pages[Z_EROFS_ONSTACK_PAGES];
 	struct super_block *sb;
 	struct z_erofs_pcluster *pcl;
-
 	/* pages with the longest decompressed length for deduplication */
 	struct page **decompressed_pages;
 	/* pages to keep the compressed data */
@@ -1129,6 +1123,8 @@ struct z_erofs_decompress_backend {
 	struct list_head decompressed_secondary_bvecs;
 	struct page **pagepool;
 	unsigned int onstack_used, nr_pages;
+	/* indicate if temporary copies should be preserved for later use */
+	bool keepxcpy;
 };
 
 struct z_erofs_bvec_item {
@@ -1139,18 +1135,20 @@ struct z_erofs_bvec_item {
 static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 					 struct z_erofs_bvec *bvec)
 {
+	int poff = bvec->offset + be->pcl->pageofs_out;
 	struct z_erofs_bvec_item *item;
-	unsigned int pgnr;
-
-	if (!((bvec->offset + be->pcl->pageofs_out) & ~PAGE_MASK) &&
-	    (bvec->end == PAGE_SIZE ||
-	     bvec->offset + bvec->end == be->pcl->length)) {
-		pgnr = (bvec->offset + be->pcl->pageofs_out) >> PAGE_SHIFT;
-		DBG_BUGON(pgnr >= be->nr_pages);
-		if (!be->decompressed_pages[pgnr]) {
-			be->decompressed_pages[pgnr] = bvec->page;
+	struct page **page;
+
+	if (!(poff & ~PAGE_MASK) && (bvec->end == PAGE_SIZE ||
+			bvec->offset + bvec->end == be->pcl->length)) {
+		DBG_BUGON((poff >> PAGE_SHIFT) >= be->nr_pages);
+		page = be->decompressed_pages + (poff >> PAGE_SHIFT);
+		if (!*page) {
+			*page = bvec->page;
 			return;
 		}
+	} else {
+		be->keepxcpy = true;
 	}
 
 	/* (cold path) one pcluster is requested multiple times */
@@ -1316,7 +1314,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
-					.fillgaps = pcl->multibases,
+					.fillgaps = be->keepxcpy,
 					.gfp = pcl->besteffort ? GFP_KERNEL :
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
@@ -1370,7 +1368,6 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 
 	pcl->length = 0;
 	pcl->partial = true;
-	pcl->multibases = false;
 	pcl->besteffort = false;
 	pcl->bvset.nextpage = NULL;
 	pcl->vcnt = 0;
diff --git a/fs/namespace.c b/fs/namespace.c
index bd601ab26e78..c3c1e8c644f2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -747,7 +747,7 @@ int __legitimize_mnt(struct vfsmount *bastard, unsigned seq)
 		return 0;
 	mnt = real_mount(bastard);
 	mnt_add_count(mnt, 1);
-	smp_mb();			// see mntput_no_expire()
+	smp_mb();		// see mntput_no_expire() and do_umount()
 	if (likely(!read_seqretry(&mount_lock, seq)))
 		return 0;
 	if (bastard->mnt_flags & MNT_SYNC_UMOUNT) {
@@ -1916,6 +1916,7 @@ static int do_umount(struct mount *mnt, int flags)
 			umount_tree(mnt, UMOUNT_PROPAGATE);
 		retval = 0;
 	} else {
+		smp_mb(); // paired with __legitimize_mnt()
 		shrink_submounts(mnt);
 		retval = -EBUSY;
 		if (!propagate_mount_busy(mnt, 2)) {
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 1bf188b6866a..2ebee1dced1b 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -174,7 +174,7 @@ int ocfs2_recovery_init(struct ocfs2_super *osb)
 	struct ocfs2_recovery_map *rm;
 
 	mutex_init(&osb->recovery_lock);
-	osb->disable_recovery = 0;
+	osb->recovery_state = OCFS2_REC_ENABLED;
 	osb->recovery_thread_task = NULL;
 	init_waitqueue_head(&osb->recovery_event);
 
@@ -190,31 +190,53 @@ int ocfs2_recovery_init(struct ocfs2_super *osb)
 	return 0;
 }
 
-/* we can't grab the goofy sem lock from inside wait_event, so we use
- * memory barriers to make sure that we'll see the null task before
- * being woken up */
 static int ocfs2_recovery_thread_running(struct ocfs2_super *osb)
 {
-	mb();
 	return osb->recovery_thread_task != NULL;
 }
 
-void ocfs2_recovery_exit(struct ocfs2_super *osb)
+static void ocfs2_recovery_disable(struct ocfs2_super *osb,
+				   enum ocfs2_recovery_state state)
 {
-	struct ocfs2_recovery_map *rm;
-
-	/* disable any new recovery threads and wait for any currently
-	 * running ones to exit. Do this before setting the vol_state. */
 	mutex_lock(&osb->recovery_lock);
-	osb->disable_recovery = 1;
+	/*
+	 * If recovery thread is not running, we can directly transition to
+	 * final state.
+	 */
+	if (!ocfs2_recovery_thread_running(osb)) {
+		osb->recovery_state = state + 1;
+		goto out_lock;
+	}
+	osb->recovery_state = state;
+	/* Wait for recovery thread to acknowledge state transition */
+	wait_event_cmd(osb->recovery_event,
+		       !ocfs2_recovery_thread_running(osb) ||
+				osb->recovery_state >= state + 1,
+		       mutex_unlock(&osb->recovery_lock),
+		       mutex_lock(&osb->recovery_lock));
+out_lock:
 	mutex_unlock(&osb->recovery_lock);
-	wait_event(osb->recovery_event, !ocfs2_recovery_thread_running(osb));
 
-	/* At this point, we know that no more recovery threads can be
-	 * launched, so wait for any recovery completion work to
-	 * complete. */
+	/*
+	 * At this point we know that no more recovery work can be queued so
+	 * wait for any recovery completion work to complete.
+	 */
 	if (osb->ocfs2_wq)
 		flush_workqueue(osb->ocfs2_wq);
+}
+
+void ocfs2_recovery_disable_quota(struct ocfs2_super *osb)
+{
+	ocfs2_recovery_disable(osb, OCFS2_REC_QUOTA_WANT_DISABLE);
+}
+
+void ocfs2_recovery_exit(struct ocfs2_super *osb)
+{
+	struct ocfs2_recovery_map *rm;
+
+	/* disable any new recovery threads and wait for any currently
+	 * running ones to exit. Do this before setting the vol_state. */
+	ocfs2_recovery_disable(osb, OCFS2_REC_WANT_DISABLE);
 
 	/*
 	 * Now that recovery is shut down, and the osb is about to be
@@ -1472,6 +1494,18 @@ static int __ocfs2_recovery_thread(void *arg)
 		}
 	}
 restart:
+	if (quota_enabled) {
+		mutex_lock(&osb->recovery_lock);
+		/* Confirm that recovery thread will no longer recover quotas */
+		if (osb->recovery_state == OCFS2_REC_QUOTA_WANT_DISABLE) {
+			osb->recovery_state = OCFS2_REC_QUOTA_DISABLED;
+			wake_up(&osb->recovery_event);
+		}
+		if (osb->recovery_state >= OCFS2_REC_QUOTA_DISABLED)
+			quota_enabled = 0;
+		mutex_unlock(&osb->recovery_lock);
+	}
+
 	status = ocfs2_super_lock(osb, 1);
 	if (status < 0) {
 		mlog_errno(status);
@@ -1569,27 +1603,29 @@ static int __ocfs2_recovery_thread(void *arg)
 
 	ocfs2_free_replay_slots(osb);
 	osb->recovery_thread_task = NULL;
-	mb(); /* sync with ocfs2_recovery_thread_running */
+	if (osb->recovery_state == OCFS2_REC_WANT_DISABLE)
+		osb->recovery_state = OCFS2_REC_DISABLED;
 	wake_up(&osb->recovery_event);
 
 	mutex_unlock(&osb->recovery_lock);
 
-	if (quota_enabled)
-		kfree(rm_quota);
+	kfree(rm_quota);
 
 	return status;
 }
 
 void ocfs2_recovery_thread(struct ocfs2_super *osb, int node_num)
 {
+	int was_set = -1;
+
 	mutex_lock(&osb->recovery_lock);
+	if (osb->recovery_state < OCFS2_REC_WANT_DISABLE)
+		was_set = ocfs2_recovery_map_set(osb, node_num);
 
 	trace_ocfs2_recovery_thread(node_num, osb->node_num,
-		osb->disable_recovery, osb->recovery_thread_task,
-		osb->disable_recovery ?
-		-1 : ocfs2_recovery_map_set(osb, node_num));
+		osb->recovery_state, osb->recovery_thread_task, was_set);
 
-	if (osb->disable_recovery)
+	if (osb->recovery_state >= OCFS2_REC_WANT_DISABLE)
 		goto out;
 
 	if (osb->recovery_thread_task)
diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
index e3c3a35dc5e0..6397170f302f 100644
--- a/fs/ocfs2/journal.h
+++ b/fs/ocfs2/journal.h
@@ -148,6 +148,7 @@ void ocfs2_wait_for_recovery(struct ocfs2_super *osb);
 
 int ocfs2_recovery_init(struct ocfs2_super *osb);
 void ocfs2_recovery_exit(struct ocfs2_super *osb);
+void ocfs2_recovery_disable_quota(struct ocfs2_super *osb);
 
 int ocfs2_compute_replay_slots(struct ocfs2_super *osb);
 void ocfs2_free_replay_slots(struct ocfs2_super *osb);
diff --git a/fs/ocfs2/ocfs2.h b/fs/ocfs2/ocfs2.h
index 51c52768132d..6aaa94c554c1 100644
--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -308,6 +308,21 @@ enum ocfs2_journal_trigger_type {
 void ocfs2_initialize_journal_triggers(struct super_block *sb,
 				       struct ocfs2_triggers triggers[]);
 
+enum ocfs2_recovery_state {
+	OCFS2_REC_ENABLED = 0,
+	OCFS2_REC_QUOTA_WANT_DISABLE,
+	/*
+	 * Must be OCFS2_REC_QUOTA_WANT_DISABLE + 1 for
+	 * ocfs2_recovery_disable_quota() to work.
+	 */
+	OCFS2_REC_QUOTA_DISABLED,
+	OCFS2_REC_WANT_DISABLE,
+	/*
+	 * Must be OCFS2_REC_WANT_DISABLE + 1 for ocfs2_recovery_exit() to work
+	 */
+	OCFS2_REC_DISABLED,
+};
+
 struct ocfs2_journal;
 struct ocfs2_slot_info;
 struct ocfs2_recovery_map;
@@ -370,7 +385,7 @@ struct ocfs2_super
 	struct ocfs2_recovery_map *recovery_map;
 	struct ocfs2_replay_map *replay_map;
 	struct task_struct *recovery_thread_task;
-	int disable_recovery;
+	enum ocfs2_recovery_state recovery_state;
 	wait_queue_head_t checkpoint_event;
 	struct ocfs2_journal *journal;
 	unsigned long osb_commit_interval;
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..e272429da3db 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -453,8 +453,7 @@ struct ocfs2_quota_recovery *ocfs2_begin_quota_recovery(
 
 /* Sync changes in local quota file into global quota file and
  * reinitialize local quota file.
- * The function expects local quota file to be already locked and
- * s_umount locked in shared mode. */
+ * The function expects local quota file to be already locked. */
 static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 					  int type,
 					  struct ocfs2_quota_recovery *rec)
@@ -588,7 +587,6 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 {
 	unsigned int ino[OCFS2_MAXQUOTAS] = { LOCAL_USER_QUOTA_SYSTEM_INODE,
 					      LOCAL_GROUP_QUOTA_SYSTEM_INODE };
-	struct super_block *sb = osb->sb;
 	struct ocfs2_local_disk_dqinfo *ldinfo;
 	struct buffer_head *bh;
 	handle_t *handle;
@@ -600,7 +598,6 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 	printk(KERN_NOTICE "ocfs2: Finishing quota recovery on device (%s) for "
 	       "slot %u\n", osb->dev_str, slot_num);
 
-	down_read(&sb->s_umount);
 	for (type = 0; type < OCFS2_MAXQUOTAS; type++) {
 		if (list_empty(&(rec->r_list[type])))
 			continue;
@@ -677,7 +674,6 @@ int ocfs2_finish_quota_recovery(struct ocfs2_super *osb,
 			break;
 	}
 out:
-	up_read(&sb->s_umount);
 	kfree(rec);
 	return status;
 }
@@ -843,8 +839,7 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 	ocfs2_release_local_quota_bitmaps(&oinfo->dqi_chunk);
 
 	/*
-	 * s_umount held in exclusive mode protects us against racing with
-	 * recovery thread...
+	 * ocfs2_dismount_volume() has already aborted quota recovery...
 	 */
 	if (oinfo->dqi_rec) {
 		ocfs2_free_quota_recovery(oinfo->dqi_rec);
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index f7b483f0de2a..6ac4dcd54588 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -698,10 +698,12 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 
 	bg_bh = ocfs2_block_group_alloc_contig(osb, handle, alloc_inode,
 					       ac, cl);
-	if (PTR_ERR(bg_bh) == -ENOSPC)
+	if (PTR_ERR(bg_bh) == -ENOSPC) {
+		ac->ac_which = OCFS2_AC_USE_MAIN_DISCONTIG;
 		bg_bh = ocfs2_block_group_alloc_discontig(handle,
 							  alloc_inode,
 							  ac, cl);
+	}
 	if (IS_ERR(bg_bh)) {
 		status = PTR_ERR(bg_bh);
 		bg_bh = NULL;
@@ -1794,6 +1796,7 @@ static int ocfs2_search_chain(struct ocfs2_alloc_context *ac,
 {
 	int status;
 	u16 chain;
+	u32 contig_bits;
 	u64 next_group;
 	struct inode *alloc_inode = ac->ac_inode;
 	struct buffer_head *group_bh = NULL;
@@ -1819,10 +1822,21 @@ static int ocfs2_search_chain(struct ocfs2_alloc_context *ac,
 	status = -ENOSPC;
 	/* for now, the chain search is a bit simplistic. We just use
 	 * the 1st group with any empty bits. */
-	while ((status = ac->ac_group_search(alloc_inode, group_bh,
-					     bits_wanted, min_bits,
-					     ac->ac_max_block,
-					     res)) == -ENOSPC) {
+	while (1) {
+		if (ac->ac_which == OCFS2_AC_USE_MAIN_DISCONTIG) {
+			contig_bits = le16_to_cpu(bg->bg_contig_free_bits);
+			if (!contig_bits)
+				contig_bits = ocfs2_find_max_contig_free_bits(bg->bg_bitmap,
+						le16_to_cpu(bg->bg_bits), 0);
+			if (bits_wanted > contig_bits && contig_bits >= min_bits)
+				bits_wanted = contig_bits;
+		}
+
+		status = ac->ac_group_search(alloc_inode, group_bh,
+				bits_wanted, min_bits,
+				ac->ac_max_block, res);
+		if (status != -ENOSPC)
+			break;
 		if (!bg->bg_next_group)
 			break;
 
@@ -1982,6 +1996,7 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 	victim = ocfs2_find_victim_chain(cl);
 	ac->ac_chain = victim;
 
+search:
 	status = ocfs2_search_chain(ac, handle, bits_wanted, min_bits,
 				    res, &bits_left);
 	if (!status) {
@@ -2022,6 +2037,16 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 		}
 	}
 
+	/* Chains can't supply the bits_wanted contiguous space.
+	 * We should switch to using every single bit when allocating
+	 * from the global bitmap. */
+	if (i == le16_to_cpu(cl->cl_next_free_rec) &&
+	    status == -ENOSPC && ac->ac_which == OCFS2_AC_USE_MAIN) {
+		ac->ac_which = OCFS2_AC_USE_MAIN_DISCONTIG;
+		ac->ac_chain = victim;
+		goto search;
+	}
+
 set_hint:
 	if (status != -ENOSPC) {
 		/* If the next search of this group is not likely to
@@ -2365,7 +2390,8 @@ int __ocfs2_claim_clusters(handle_t *handle,
 	BUG_ON(ac->ac_bits_given >= ac->ac_bits_wanted);
 
 	BUG_ON(ac->ac_which != OCFS2_AC_USE_LOCAL
-	       && ac->ac_which != OCFS2_AC_USE_MAIN);
+	       && ac->ac_which != OCFS2_AC_USE_MAIN
+	       && ac->ac_which != OCFS2_AC_USE_MAIN_DISCONTIG);
 
 	if (ac->ac_which == OCFS2_AC_USE_LOCAL) {
 		WARN_ON(min_clusters > 1);
diff --git a/fs/ocfs2/suballoc.h b/fs/ocfs2/suballoc.h
index b481b834857d..bcf2ed4a8631 100644
--- a/fs/ocfs2/suballoc.h
+++ b/fs/ocfs2/suballoc.h
@@ -29,6 +29,7 @@ struct ocfs2_alloc_context {
 #define OCFS2_AC_USE_MAIN  2
 #define OCFS2_AC_USE_INODE 3
 #define OCFS2_AC_USE_META  4
+#define OCFS2_AC_USE_MAIN_DISCONTIG  5
 	u32    ac_which;
 
 	/* these are used by the chain search */
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 1e87554f6f41..868ccdf44738 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1867,6 +1867,9 @@ static void ocfs2_dismount_volume(struct super_block *sb, int mnt_err)
 	/* Orphan scan should be stopped as early as possible */
 	ocfs2_orphan_scan_stop(osb);
 
+	/* Stop quota recovery so that we can disable quotas */
+	ocfs2_recovery_disable_quota(osb);
+
 	ocfs2_disable_quotas(osb);
 
 	/* All dquots should be freed by now */
diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 9c0ef4195b58..749794667295 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -29,7 +29,6 @@ static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 {
 	struct cached_fid *cfid;
 
-	spin_lock(&cfids->cfid_list_lock);
 	list_for_each_entry(cfid, &cfids->entries, entry) {
 		if (!strcmp(cfid->path, path)) {
 			/*
@@ -38,25 +37,20 @@ static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 			 * being deleted due to a lease break.
 			 */
 			if (!cfid->time || !cfid->has_lease) {
-				spin_unlock(&cfids->cfid_list_lock);
 				return NULL;
 			}
 			kref_get(&cfid->refcount);
-			spin_unlock(&cfids->cfid_list_lock);
 			return cfid;
 		}
 	}
 	if (lookup_only) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	if (cfids->num_entries >= max_cached_dirs) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	cfid = init_cached_dir(path);
 	if (cfid == NULL) {
-		spin_unlock(&cfids->cfid_list_lock);
 		return NULL;
 	}
 	cfid->cfids = cfids;
@@ -74,7 +68,6 @@ static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
 	 */
 	cfid->has_lease = true;
 
-	spin_unlock(&cfids->cfid_list_lock);
 	return cfid;
 }
 
@@ -185,8 +178,10 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	if (!utf16_path)
 		return -ENOMEM;
 
+	spin_lock(&cfids->cfid_list_lock);
 	cfid = find_or_create_cached_dir(cfids, path, lookup_only, tcon->max_cached_dirs);
 	if (cfid == NULL) {
+		spin_unlock(&cfids->cfid_list_lock);
 		kfree(utf16_path);
 		return -ENOENT;
 	}
@@ -195,7 +190,6 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	 * Otherwise, it is either a new entry or laundromat worker removed it
 	 * from @cfids->entries.  Caller will put last reference if the latter.
 	 */
-	spin_lock(&cfids->cfid_list_lock);
 	if (cfid->has_lease && cfid->time) {
 		spin_unlock(&cfids->cfid_list_lock);
 		*ret_cfid = cfid;
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 81a29857b1e3..03f606afad93 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1496,7 +1496,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 
 		if (le16_to_cpu(cc->DataOffset) + le32_to_cpu(cc->DataLength) <
 		    sizeof(struct create_lease_v2) - 4)
-			return NULL;
+			goto err_out;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 		lreq->req_state = lc->lcontext.LeaseState;
@@ -1512,7 +1512,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 
 		if (le16_to_cpu(cc->DataOffset) + le32_to_cpu(cc->DataLength) <
 		    sizeof(struct create_lease))
-			return NULL;
+			goto err_out;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
 		lreq->req_state = lc->lcontext.LeaseState;
@@ -1521,6 +1521,9 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 		lreq->version = 1;
 	}
 	return lreq;
+err_out:
+	kfree(lreq);
+	return NULL;
 }
 
 /**
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 85348705f255..f0760d786502 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -633,6 +633,11 @@ smb2_get_name(const char *src, const int maxlen, struct nls_table *local_nls)
 		return name;
 	}
 
+	if (*name == '\0') {
+		kfree(name);
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (*name == '\\') {
 		pr_err("not allow directory name included leading slash\n");
 		kfree(name);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index a7694aae0b94..e059316be36f 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -443,6 +443,13 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		goto out;
 	}
 
+	if (v_len <= *pos) {
+		pr_err("stream write position %lld is out of bounds (stream length: %zd)\n",
+				*pos, v_len);
+		err = -EINVAL;
+		goto out;
+	}
+
 	if (v_len < size) {
 		wbuf = kvzalloc(size, KSMBD_DEFAULT_GFP);
 		if (!wbuf) {
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 1f8fa3468173..dfed6fce8904 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -661,21 +661,40 @@ __close_file_table_ids(struct ksmbd_file_table *ft,
 		       bool (*skip)(struct ksmbd_tree_connect *tcon,
 				    struct ksmbd_file *fp))
 {
-	unsigned int			id;
-	struct ksmbd_file		*fp;
-	int				num = 0;
+	struct ksmbd_file *fp;
+	unsigned int id = 0;
+	int num = 0;
+
+	while (1) {
+		write_lock(&ft->lock);
+		fp = idr_get_next(ft->idr, &id);
+		if (!fp) {
+			write_unlock(&ft->lock);
+			break;
+		}
 
-	idr_for_each_entry(ft->idr, fp, id) {
-		if (skip(tcon, fp))
+		if (skip(tcon, fp) ||
+		    !atomic_dec_and_test(&fp->refcount)) {
+			id++;
+			write_unlock(&ft->lock);
 			continue;
+		}
 
 		set_close_state_blocked_works(fp);
+		idr_remove(ft->idr, fp->volatile_id);
+		fp->volatile_id = KSMBD_NO_FID;
+		write_unlock(&ft->lock);
+
+		down_write(&fp->f_ci->m_lock);
+		list_del_init(&fp->node);
+		up_write(&fp->f_ci->m_lock);
 
-		if (!atomic_dec_and_test(&fp->refcount))
-			continue;
 		__ksmbd_close_fd(ft, fp);
+
 		num++;
+		id++;
 	}
+
 	return num;
 }
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 199ec6d10b62..10df55aea512 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1585,8 +1585,11 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 	user_uffdio_copy = (struct uffdio_copy __user *) arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_copy->copy)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_copy, user_uffdio_copy,
@@ -1641,8 +1644,11 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 	user_uffdio_zeropage = (struct uffdio_zeropage __user *) arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_zeropage->zeropage)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_zeropage, user_uffdio_zeropage,
@@ -1744,8 +1750,11 @@ static int userfaultfd_continue(struct userfaultfd_ctx *ctx, unsigned long arg)
 	user_uffdio_continue = (struct uffdio_continue __user *)arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_continue->mapped)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_continue, user_uffdio_continue,
@@ -1801,8 +1810,11 @@ static inline int userfaultfd_poison(struct userfaultfd_ctx *ctx, unsigned long
 	user_uffdio_poison = (struct uffdio_poison __user *)arg;
 
 	ret = -EAGAIN;
-	if (atomic_read(&ctx->mmap_changing))
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_poison->updated)))
+			return -EFAULT;
 		goto out;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_poison, user_uffdio_poison,
@@ -1870,8 +1882,12 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
 
 	user_uffdio_move = (struct uffdio_move __user *) arg;
 
-	if (atomic_read(&ctx->mmap_changing))
-		return -EAGAIN;
+	ret = -EAGAIN;
+	if (unlikely(atomic_read(&ctx->mmap_changing))) {
+		if (unlikely(put_user(ret, &user_uffdio_move->move)))
+			return -EFAULT;
+		goto out;
+	}
 
 	if (copy_from_user(&uffdio_move, user_uffdio_move,
 			   /* don't copy "move" last field */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index bdcec1732445..cc668a054d09 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -77,6 +77,8 @@ extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 					       struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_indirect_target_selection(struct device *dev,
+						  struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
diff --git a/include/linux/execmem.h b/include/linux/execmem.h
index 32cef1144117..584e112ca380 100644
--- a/include/linux/execmem.h
+++ b/include/linux/execmem.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/moduleloader.h>
+#include <linux/cleanup.h>
 
 #if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
 		!defined(CONFIG_KASAN_VMALLOC)
@@ -123,6 +124,8 @@ void *execmem_alloc(enum execmem_type type, size_t size);
  */
 void execmem_free(void *ptr);
 
+DEFINE_FREE(execmem, void *, if (_T) execmem_free(_T));
+
 #if defined(CONFIG_EXECMEM) && !defined(CONFIG_ARCH_WANTS_EXECMEM_LATE)
 void execmem_init(void);
 #else
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 3750e56bfcbb..777f6aa8efa7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1524,7 +1524,7 @@ struct ieee80211_mgmt {
 				struct {
 					u8 action_code;
 					u8 dialog_token;
-					u8 status_code;
+					__le16 status_code;
 					u8 variable[];
 				} __packed ttlm_res;
 				struct {
diff --git a/include/linux/module.h b/include/linux/module.h
index 82a9527d43c7..7886217c9988 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -582,6 +582,11 @@ struct module {
 	atomic_t refcnt;
 #endif
 
+#ifdef CONFIG_MITIGATION_ITS
+	int its_num_pages;
+	void **its_page_array;
+#endif
+
 #ifdef CONFIG_CONSTRUCTORS
 	/* Constructor functions. */
 	ctor_fn_t *ctors;
diff --git a/include/linux/types.h b/include/linux/types.h
index 2bc8766ba20c..2d7b9ae8714c 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -115,8 +115,9 @@ typedef u64			u_int64_t;
 typedef s64			int64_t;
 #endif
 
-/* this is a special 64bit data type that is 8-byte aligned */
+/* These are the special 64-bit data types that are 8-byte aligned */
 #define aligned_u64		__aligned_u64
+#define aligned_s64		__aligned_s64
 #define aligned_be64		__aligned_be64
 #define aligned_le64		__aligned_le64
 
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index ad2ce7a6ab7a..2dcf76219131 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -61,6 +61,7 @@ struct vm_struct {
 	unsigned int		nr_pages;
 	phys_addr_t		phys_addr;
 	const void		*caller;
+	unsigned long		requested_size;
 };
 
 struct vmap_area {
diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 5ca019d294ca..173bcfcd868a 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -92,6 +92,12 @@ struct netdev_stat_ops {
 			       struct netdev_queue_stats_tx *tx);
 };
 
+void netdev_stat_queue_sum(struct net_device *netdev,
+			   int rx_start, int rx_end,
+			   struct netdev_queue_stats_rx *rx_sum,
+			   int tx_start, int tx_end,
+			   struct netdev_queue_stats_tx *tx_sum);
+
 /**
  * struct netdev_queue_mgmt_ops - netdev ops for queue management
  *
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 6375a0684052..48b933938877 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -53,6 +53,7 @@ typedef __u32 __bitwise __wsum;
  * No conversions are necessary between 32-bit user-space and a 64-bit kernel.
  */
 #define __aligned_u64 __u64 __attribute__((aligned(8)))
+#define __aligned_s64 __s64 __attribute__((aligned(8)))
 #define __aligned_be64 __be64 __attribute__((aligned(8)))
 #define __aligned_le64 __le64 __attribute__((aligned(8)))
 
diff --git a/init/Kconfig b/init/Kconfig
index 2b4969758da8..d3755b2264bd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -134,6 +134,9 @@ config LD_CAN_USE_KEEP_IN_OVERLAY
 	# https://github.com/llvm/llvm-project/pull/130661
 	def_bool LD_IS_BFD || LLD_VERSION >= 210000
 
+config RUSTC_HAS_UNNECESSARY_TRANSMUTES
+	def_bool RUSTC_VERSION >= 108800
+
 config PAHOLE_VERSION
 	int
 	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index fef5c6e3b251..8ef0603c07f1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -441,24 +441,6 @@ static struct io_kiocb *__io_prep_linked_timeout(struct io_kiocb *req)
 	return req->link;
 }
 
-static inline struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
-{
-	if (likely(!(req->flags & REQ_F_ARM_LTIMEOUT)))
-		return NULL;
-	return __io_prep_linked_timeout(req);
-}
-
-static noinline void __io_arm_ltimeout(struct io_kiocb *req)
-{
-	io_queue_linked_timeout(__io_prep_linked_timeout(req));
-}
-
-static inline void io_arm_ltimeout(struct io_kiocb *req)
-{
-	if (unlikely(req->flags & REQ_F_ARM_LTIMEOUT))
-		__io_arm_ltimeout(req);
-}
-
 static void io_prep_async_work(struct io_kiocb *req)
 {
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
@@ -511,7 +493,6 @@ static void io_prep_async_link(struct io_kiocb *req)
 
 static void io_queue_iowq(struct io_kiocb *req)
 {
-	struct io_kiocb *link = io_prep_linked_timeout(req);
 	struct io_uring_task *tctx = req->task->io_uring;
 
 	BUG_ON(!tctx);
@@ -536,8 +517,6 @@ static void io_queue_iowq(struct io_kiocb *req)
 
 	trace_io_uring_queue_async_work(req, io_wq_is_hashed(&req->work));
 	io_wq_enqueue(tctx->io_wq, &req->work);
-	if (link)
-		io_queue_linked_timeout(link);
 }
 
 static void io_req_queue_iowq_tw(struct io_kiocb *req, struct io_tw_state *ts)
@@ -884,6 +863,14 @@ bool io_req_post_cqe(struct io_kiocb *req, s32 res, u32 cflags)
 	struct io_ring_ctx *ctx = req->ctx;
 	bool posted;
 
+	/*
+	 * If multishot has already posted deferred completions, ensure that
+	 * those are flushed first before posting this one. If not, CQEs
+	 * could get reordered.
+	 */
+	if (!wq_list_empty(&ctx->submit_state.compl_reqs))
+		__io_submit_flush_completions(ctx);
+
 	lockdep_assert(!io_wq_current_is_worker());
 	lockdep_assert_held(&ctx->uring_lock);
 
@@ -1723,17 +1710,24 @@ static bool io_assign_file(struct io_kiocb *req, const struct io_issue_def *def,
 	return !!req->file;
 }
 
+#define REQ_ISSUE_SLOW_FLAGS	(REQ_F_CREDS | REQ_F_ARM_LTIMEOUT)
+
 static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 {
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
 	const struct cred *creds = NULL;
+	struct io_kiocb *link = NULL;
 	int ret;
 
 	if (unlikely(!io_assign_file(req, def, issue_flags)))
 		return -EBADF;
 
-	if (unlikely((req->flags & REQ_F_CREDS) && req->creds != current_cred()))
-		creds = override_creds(req->creds);
+	if (unlikely(req->flags & REQ_ISSUE_SLOW_FLAGS)) {
+		if ((req->flags & REQ_F_CREDS) && req->creds != current_cred())
+			creds = override_creds(req->creds);
+		if (req->flags & REQ_F_ARM_LTIMEOUT)
+			link = __io_prep_linked_timeout(req);
+	}
 
 	if (!def->audit_skip)
 		audit_uring_entry(req->opcode);
@@ -1743,8 +1737,12 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	if (!def->audit_skip)
 		audit_uring_exit(!ret, ret);
 
-	if (creds)
-		revert_creds(creds);
+	if (unlikely(creds || link)) {
+		if (creds)
+			revert_creds(creds);
+		if (link)
+			io_queue_linked_timeout(link);
+	}
 
 	if (ret == IOU_OK) {
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
@@ -1757,7 +1755,6 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (ret == IOU_ISSUE_SKIP_COMPLETE) {
 		ret = 0;
-		io_arm_ltimeout(req);
 
 		/* If the op doesn't have a file, we're not polling for it */
 		if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queue)
@@ -1800,8 +1797,6 @@ void io_wq_submit_work(struct io_wq_work *work)
 	else
 		req_ref_get(req);
 
-	io_arm_ltimeout(req);
-
 	/* either cancelled or io-wq is dying, so don't touch tctx->iowq */
 	if (atomic_read(&work->flags) & IO_WQ_WORK_CANCEL) {
 fail:
@@ -1921,15 +1916,11 @@ struct file *io_file_get_normal(struct io_kiocb *req, int fd)
 static void io_queue_async(struct io_kiocb *req, int ret)
 	__must_hold(&req->ctx->uring_lock)
 {
-	struct io_kiocb *linked_timeout;
-
 	if (ret != -EAGAIN || (req->flags & REQ_F_NOWAIT)) {
 		io_req_defer_failed(req, ret);
 		return;
 	}
 
-	linked_timeout = io_prep_linked_timeout(req);
-
 	switch (io_arm_poll_handler(req, 0)) {
 	case IO_APOLL_READY:
 		io_kbuf_recycle(req, 0);
@@ -1942,9 +1933,6 @@ static void io_queue_async(struct io_kiocb *req, int ret)
 	case IO_APOLL_OK:
 		break;
 	}
-
-	if (linked_timeout)
-		io_queue_linked_timeout(linked_timeout);
 }
 
 static inline void io_queue_sqe(struct io_kiocb *req)
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 5bc54c6df20f..430922c54168 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -20,7 +20,7 @@
 #include "sqpoll.h"
 
 #define IORING_SQPOLL_CAP_ENTRIES_VALUE 8
-#define IORING_TW_CAP_ENTRIES_VALUE	8
+#define IORING_TW_CAP_ENTRIES_VALUE	32
 
 enum {
 	IO_SQ_THREAD_SHOULD_STOP = 0,
diff --git a/kernel/params.c b/kernel/params.c
index 33b2985b31c7..9935ff599356 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -949,7 +949,9 @@ struct kset *module_kset;
 static void module_kobj_release(struct kobject *kobj)
 {
 	struct module_kobject *mk = to_module_kobject(kobj);
-	complete(mk->kobj_completion);
+
+	if (mk->kobj_completion)
+		complete(mk->kobj_completion);
 }
 
 const struct kobj_type module_ktype = {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ceb023629d48..990d0828bf2a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7182,9 +7182,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		idle_h_nr_running = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
 			h_nr_delayed = !!se->sched_delayed;
-	} else {
-		cfs_rq = group_cfs_rq(se);
-		slice = cfs_rq_min_slice(cfs_rq);
 	}
 
 	for_each_sched_entity(se) {
@@ -7194,6 +7191,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			if (p && &p->se == se)
 				return -1;
 
+			slice = cfs_rq_min_slice(cfs_rq);
 			break;
 		}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40ac11e29423..f94a9d413585 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2879,6 +2879,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio)
 {
+	bool pmd_migration = is_pmd_migration_entry(*pmd);
+
 	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
 	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
 	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
@@ -2889,9 +2891,12 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 	 * require a folio to check the PMD against. Otherwise, there
 	 * is a risk of replacing the wrong folio.
 	 */
-	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
-	    is_pmd_migration_entry(*pmd)) {
-		if (folio && folio != pmd_folio(*pmd))
+	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
+		/*
+		 * Do not apply pmd_folio() to a migration entry; and folio lock
+		 * guarantees that it must be of the wrong folio anyway.
+		 */
+		if (folio && (pmd_migration || folio != pmd_folio(*pmd)))
 			return;
 		__split_huge_pmd_locked(vma, pmd, address, freeze);
 	}
diff --git a/mm/internal.h b/mm/internal.h
index 398633d6b6c9..9e0577413087 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -204,11 +204,9 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
 		bool *any_writable, bool *any_young, bool *any_dirty)
 {
-	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
-	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte, *ptep;
 	bool writable, young, dirty;
-	int nr;
+	int nr, cur_nr;
 
 	if (any_writable)
 		*any_writable = false;
@@ -221,11 +219,15 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
 	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
 
+	/* Limit max_nr to the actual remaining PFNs in the folio we could batch. */
+	max_nr = min_t(unsigned long, max_nr,
+		       folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte));
+
 	nr = pte_batch_hint(start_ptep, pte);
 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
 	ptep = start_ptep + nr;
 
-	while (ptep < end_ptep) {
+	while (nr < max_nr) {
 		pte = ptep_get(ptep);
 		if (any_writable)
 			writable = !!pte_write(pte);
@@ -238,14 +240,6 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		if (!pte_same(pte, expected_pte))
 			break;
 
-		/*
-		 * Stop immediately once we reached the end of the folio. In
-		 * corner cases the next PFN might fall into a different
-		 * folio.
-		 */
-		if (pte_pfn(pte) >= folio_end_pfn)
-			break;
-
 		if (any_writable)
 			*any_writable |= writable;
 		if (any_young)
@@ -253,12 +247,13 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		if (any_dirty)
 			*any_dirty |= dirty;
 
-		nr = pte_batch_hint(ptep, pte);
-		expected_pte = pte_advance_pfn(expected_pte, nr);
-		ptep += nr;
+		cur_nr = pte_batch_hint(ptep, pte);
+		expected_pte = pte_advance_pfn(expected_pte, cur_nr);
+		ptep += cur_nr;
+		nr += cur_nr;
 	}
 
-	return min(ptep - start_ptep, max_nr);
+	return min(nr, max_nr);
 }
 
 /**
diff --git a/mm/memblock.c b/mm/memblock.c
index cc5ee323245e..3d7b0114442c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -456,7 +456,14 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 				min(new_area_start, memblock.current_limit),
 				new_alloc_size, PAGE_SIZE);
 
-		new_array = addr ? __va(addr) : NULL;
+		if (addr) {
+			/* The memory may not have been accepted, yet. */
+			accept_memory(addr, new_alloc_size);
+
+			new_array = __va(addr);
+		} else {
+			new_array = NULL;
+		}
 	}
 	if (!addr) {
 		pr_err("memblock: Failed to double %s array from %ld to %ld entries !\n",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fd4e0e1cd65e..d29da0c6a7f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1907,13 +1907,12 @@ static inline bool boost_watermark(struct zone *zone)
  * can claim the whole pageblock for the requested migratetype. If not, we check
  * the pageblock for constituent pages; if at least half of the pages are free
  * or compatible, we can still claim the whole block, so pages freed in the
- * future will be put on the correct free list. Otherwise, we isolate exactly
- * the order we need from the fallback block and leave its migratetype alone.
+ * future will be put on the correct free list.
  */
 static struct page *
-steal_suitable_fallback(struct zone *zone, struct page *page,
-			int current_order, int order, int start_type,
-			unsigned int alloc_flags, bool whole_block)
+try_to_steal_block(struct zone *zone, struct page *page,
+		   int current_order, int order, int start_type,
+		   unsigned int alloc_flags)
 {
 	int free_pages, movable_pages, alike_pages;
 	unsigned long start_pfn;
@@ -1926,7 +1925,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	 * highatomic accounting.
 	 */
 	if (is_migrate_highatomic(block_type))
-		goto single_page;
+		return NULL;
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
@@ -1947,14 +1946,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
 		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 
-	/* We are not allowed to try stealing from the whole block */
-	if (!whole_block)
-		goto single_page;
-
 	/* moving whole block can fail due to zone boundary conditions */
 	if (!prep_move_freepages_block(zone, page, &start_pfn, &free_pages,
 				       &movable_pages))
-		goto single_page;
+		return NULL;
 
 	/*
 	 * Determine how many pages are compatible with our allocation.
@@ -1987,9 +1982,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
-single_page:
-	page_del_and_expand(zone, page, order, current_order, block_type);
-	return page;
+	return NULL;
 }
 
 /*
@@ -2171,17 +2164,15 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 }
 
 /*
- * Try finding a free buddy page on the fallback list and put it on the free
- * list of requested migratetype, possibly along with other pages from the same
- * block, depending on fragmentation avoidance heuristics. Returns true if
- * fallback was found so that __rmqueue_smallest() can grab it.
+ * Try to allocate from some fallback migratetype by claiming the entire block,
+ * i.e. converting it to the allocation's start migratetype.
  *
  * The use of signed ints for order and current_order is a deliberate
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
  */
 static __always_inline struct page *
-__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
+__rmqueue_claim(struct zone *zone, int order, int start_migratetype,
 						unsigned int alloc_flags)
 {
 	struct free_area *area;
@@ -2212,58 +2203,66 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		if (fallback_mt == -1)
 			continue;
 
-		/*
-		 * We cannot steal all free pages from the pageblock and the
-		 * requested migratetype is movable. In that case it's better to
-		 * steal and split the smallest available page instead of the
-		 * largest available page, because even if the next movable
-		 * allocation falls back into a different pageblock than this
-		 * one, it won't cause permanent fragmentation.
-		 */
-		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
-					&& current_order > order)
-			goto find_smallest;
+		if (!can_steal)
+			break;
 
-		goto do_steal;
+		page = get_page_from_free_area(area, fallback_mt);
+		page = try_to_steal_block(zone, page, current_order, order,
+					  start_migratetype, alloc_flags);
+		if (page) {
+			trace_mm_page_alloc_extfrag(page, order, current_order,
+						    start_migratetype, fallback_mt);
+			return page;
+		}
 	}
 
 	return NULL;
+}
+
+/*
+ * Try to steal a single page from some fallback migratetype. Leave the rest of
+ * the block as its current migratetype, potentially causing fragmentation.
+ */
+static __always_inline struct page *
+__rmqueue_steal(struct zone *zone, int order, int start_migratetype)
+{
+	struct free_area *area;
+	int current_order;
+	struct page *page;
+	int fallback_mt;
+	bool can_steal;
 
-find_smallest:
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
 				start_migratetype, false, &can_steal);
-		if (fallback_mt != -1)
-			break;
-	}
-
-	/*
-	 * This should not happen - we already found a suitable fallback
-	 * when looking for the largest page.
-	 */
-	VM_BUG_ON(current_order > MAX_PAGE_ORDER);
-
-do_steal:
-	page = get_page_from_free_area(area, fallback_mt);
-
-	/* take off list, maybe claim block, expand remainder */
-	page = steal_suitable_fallback(zone, page, current_order, order,
-				       start_migratetype, alloc_flags, can_steal);
+		if (fallback_mt == -1)
+			continue;
 
-	trace_mm_page_alloc_extfrag(page, order, current_order,
-		start_migratetype, fallback_mt);
+		page = get_page_from_free_area(area, fallback_mt);
+		page_del_and_expand(zone, page, order, current_order, fallback_mt);
+		trace_mm_page_alloc_extfrag(page, order, current_order,
+					    start_migratetype, fallback_mt);
+		return page;
+	}
 
-	return page;
+	return NULL;
 }
 
+enum rmqueue_mode {
+	RMQUEUE_NORMAL,
+	RMQUEUE_CMA,
+	RMQUEUE_CLAIM,
+	RMQUEUE_STEAL,
+};
+
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
 static __always_inline struct page *
 __rmqueue(struct zone *zone, unsigned int order, int migratetype,
-						unsigned int alloc_flags)
+	  unsigned int alloc_flags, enum rmqueue_mode *mode)
 {
 	struct page *page;
 
@@ -2282,16 +2281,49 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 		}
 	}
 
-	page = __rmqueue_smallest(zone, order, migratetype);
-	if (unlikely(!page)) {
-		if (alloc_flags & ALLOC_CMA)
+	/*
+	 * First try the freelists of the requested migratetype, then try
+	 * fallbacks modes with increasing levels of fragmentation risk.
+	 *
+	 * The fallback logic is expensive and rmqueue_bulk() calls in
+	 * a loop with the zone->lock held, meaning the freelists are
+	 * not subject to any outside changes. Remember in *mode where
+	 * we found pay dirt, to save us the search on the next call.
+	 */
+	switch (*mode) {
+	case RMQUEUE_NORMAL:
+		page = __rmqueue_smallest(zone, order, migratetype);
+		if (page)
+			return page;
+		fallthrough;
+	case RMQUEUE_CMA:
+		if (alloc_flags & ALLOC_CMA) {
 			page = __rmqueue_cma_fallback(zone, order);
-
-		if (!page)
-			page = __rmqueue_fallback(zone, order, migratetype,
-						  alloc_flags);
+			if (page) {
+				*mode = RMQUEUE_CMA;
+				return page;
+			}
+		}
+		fallthrough;
+	case RMQUEUE_CLAIM:
+		page = __rmqueue_claim(zone, order, migratetype, alloc_flags);
+		if (page) {
+			/* Replenished preferred freelist, back to normal mode. */
+			*mode = RMQUEUE_NORMAL;
+			return page;
+		}
+		fallthrough;
+	case RMQUEUE_STEAL:
+		if (!(alloc_flags & ALLOC_NOFRAGMENT)) {
+			page = __rmqueue_steal(zone, order, migratetype);
+			if (page) {
+				*mode = RMQUEUE_STEAL;
+				return page;
+			}
+		}
 	}
-	return page;
+
+	return NULL;
 }
 
 /*
@@ -2303,13 +2335,14 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
 	unsigned long flags;
 	int i;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+					      alloc_flags, &rmqm);
 		if (unlikely(page == NULL))
 			break;
 
@@ -2910,7 +2943,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
+			enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
+
+			page = __rmqueue(zone, order, migratetype, alloc_flags, &rmqm);
 
 			/*
 			 * If the allocation fails, allow OOM handling and
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index fd70a7cd1c8f..358bd3083b88 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1940,7 +1940,7 @@ static inline void setup_vmalloc_vm(struct vm_struct *vm,
 {
 	vm->flags = flags;
 	vm->addr = (void *)va->va_start;
-	vm->size = va_size(va);
+	vm->size = vm->requested_size = va_size(va);
 	vm->caller = caller;
 	va->vm = vm;
 }
@@ -3128,6 +3128,7 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
 
 	area->flags = flags;
 	area->caller = caller;
+	area->requested_size = requested_size;
 
 	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
 	if (IS_ERR(va)) {
@@ -4067,6 +4068,8 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
  */
 void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 {
+	struct vm_struct *vm = NULL;
+	size_t alloced_size = 0;
 	size_t old_size = 0;
 	void *n;
 
@@ -4076,15 +4079,17 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	}
 
 	if (p) {
-		struct vm_struct *vm;
-
 		vm = find_vm_area(p);
 		if (unlikely(!vm)) {
 			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
 			return NULL;
 		}
 
-		old_size = get_vm_area_size(vm);
+		alloced_size = get_vm_area_size(vm);
+		old_size = vm->requested_size;
+		if (WARN(alloced_size < old_size,
+			 "vrealloc() has mismatched area vs requested sizes (%p)\n", p))
+			return NULL;
 	}
 
 	/*
@@ -4092,14 +4097,26 @@ void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
 	 * would be a good heuristic for when to shrink the vm_area?
 	 */
 	if (size <= old_size) {
-		/* Zero out spare memory. */
-		if (want_init_on_alloc(flags))
+		/* Zero out "freed" memory. */
+		if (want_init_on_free())
 			memset((void *)p + size, 0, old_size - size);
+		vm->requested_size = size;
 		kasan_poison_vmalloc(p + size, old_size - size);
-		kasan_unpoison_vmalloc(p, size, KASAN_VMALLOC_PROT_NORMAL);
 		return (void *)p;
 	}
 
+	/*
+	 * We already have the bytes available in the allocation; use them.
+	 */
+	if (size <= alloced_size) {
+		kasan_unpoison_vmalloc(p + old_size, size - old_size,
+				       KASAN_VMALLOC_PROT_NORMAL);
+		/* Zero out "alloced" memory. */
+		if (want_init_on_alloc(flags))
+			memset((void *)p + old_size, 0, size - old_size);
+		vm->requested_size = size;
+	}
+
 	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
 	n = __vmalloc_noprof(size, flags);
 	if (!n)
diff --git a/net/can/gw.c b/net/can/gw.c
index 37528826935e..e65500c52bf5 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -130,7 +130,7 @@ struct cgw_job {
 	u32 handled_frames;
 	u32 dropped_frames;
 	u32 deleted_frames;
-	struct cf_mod mod;
+	struct cf_mod __rcu *cf_mod;
 	union {
 		/* CAN frame data source */
 		struct net_device *dev;
@@ -459,6 +459,7 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	struct cgw_job *gwj = (struct cgw_job *)data;
 	struct canfd_frame *cf;
 	struct sk_buff *nskb;
+	struct cf_mod *mod;
 	int modidx = 0;
 
 	/* process strictly Classic CAN or CAN FD frames */
@@ -506,7 +507,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	 * When there is at least one modification function activated,
 	 * we need to copy the skb as we want to modify skb->data.
 	 */
-	if (gwj->mod.modfunc[0])
+	mod = rcu_dereference(gwj->cf_mod);
+	if (mod->modfunc[0])
 		nskb = skb_copy(skb, GFP_ATOMIC);
 	else
 		nskb = skb_clone(skb, GFP_ATOMIC);
@@ -529,8 +531,8 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 	cf = (struct canfd_frame *)nskb->data;
 
 	/* perform preprocessed modification functions if there are any */
-	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
-		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
+	while (modidx < MAX_MODFUNCTIONS && mod->modfunc[modidx])
+		(*mod->modfunc[modidx++])(cf, mod);
 
 	/* Has the CAN frame been modified? */
 	if (modidx) {
@@ -546,11 +548,11 @@ static void can_can_gw_rcv(struct sk_buff *skb, void *data)
 		}
 
 		/* check for checksum updates */
-		if (gwj->mod.csumfunc.crc8)
-			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
+		if (mod->csumfunc.crc8)
+			(*mod->csumfunc.crc8)(cf, &mod->csum.crc8);
 
-		if (gwj->mod.csumfunc.xor)
-			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
+		if (mod->csumfunc.xor)
+			(*mod->csumfunc.xor)(cf, &mod->csum.xor);
 	}
 
 	/* clear the skb timestamp if not configured the other way */
@@ -581,9 +583,20 @@ static void cgw_job_free_rcu(struct rcu_head *rcu_head)
 {
 	struct cgw_job *gwj = container_of(rcu_head, struct cgw_job, rcu);
 
+	/* cgw_job::cf_mod is always accessed from the same cgw_job object within
+	 * the same RCU read section. Once cgw_job is scheduled for removal,
+	 * cf_mod can also be removed without mandating an additional grace period.
+	 */
+	kfree(rcu_access_pointer(gwj->cf_mod));
 	kmem_cache_free(cgw_cache, gwj);
 }
 
+/* Return cgw_job::cf_mod with RTNL protected section */
+static struct cf_mod *cgw_job_cf_mod(struct cgw_job *gwj)
+{
+	return rcu_dereference_protected(gwj->cf_mod, rtnl_is_locked());
+}
+
 static int cgw_notifier(struct notifier_block *nb,
 			unsigned long msg, void *ptr)
 {
@@ -616,6 +629,7 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 {
 	struct rtcanmsg *rtcan;
 	struct nlmsghdr *nlh;
+	struct cf_mod *mod;
 
 	nlh = nlmsg_put(skb, pid, seq, type, sizeof(*rtcan), flags);
 	if (!nlh)
@@ -650,82 +664,83 @@ static int cgw_put_job(struct sk_buff *skb, struct cgw_job *gwj, int type,
 			goto cancel;
 	}
 
+	mod = cgw_job_cf_mod(gwj);
 	if (gwj->flags & CGW_FLAGS_CAN_FD) {
 		struct cgw_fdframe_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = mod->modtype.and;
 			if (nla_put(skb, CGW_FDMOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = mod->modtype.or;
 			if (nla_put(skb, CGW_FDMOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = mod->modtype.xor;
 			if (nla_put(skb, CGW_FDMOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = mod->modtype.set;
 			if (nla_put(skb, CGW_FDMOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	} else {
 		struct cgw_frame_mod mb;
 
-		if (gwj->mod.modtype.and) {
-			memcpy(&mb.cf, &gwj->mod.modframe.and, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.and;
+		if (mod->modtype.and) {
+			memcpy(&mb.cf, &mod->modframe.and, sizeof(mb.cf));
+			mb.modtype = mod->modtype.and;
 			if (nla_put(skb, CGW_MOD_AND, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.or) {
-			memcpy(&mb.cf, &gwj->mod.modframe.or, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.or;
+		if (mod->modtype.or) {
+			memcpy(&mb.cf, &mod->modframe.or, sizeof(mb.cf));
+			mb.modtype = mod->modtype.or;
 			if (nla_put(skb, CGW_MOD_OR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.xor) {
-			memcpy(&mb.cf, &gwj->mod.modframe.xor, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.xor;
+		if (mod->modtype.xor) {
+			memcpy(&mb.cf, &mod->modframe.xor, sizeof(mb.cf));
+			mb.modtype = mod->modtype.xor;
 			if (nla_put(skb, CGW_MOD_XOR, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 
-		if (gwj->mod.modtype.set) {
-			memcpy(&mb.cf, &gwj->mod.modframe.set, sizeof(mb.cf));
-			mb.modtype = gwj->mod.modtype.set;
+		if (mod->modtype.set) {
+			memcpy(&mb.cf, &mod->modframe.set, sizeof(mb.cf));
+			mb.modtype = mod->modtype.set;
 			if (nla_put(skb, CGW_MOD_SET, sizeof(mb), &mb) < 0)
 				goto cancel;
 		}
 	}
 
-	if (gwj->mod.uid) {
-		if (nla_put_u32(skb, CGW_MOD_UID, gwj->mod.uid) < 0)
+	if (mod->uid) {
+		if (nla_put_u32(skb, CGW_MOD_UID, mod->uid) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.crc8) {
+	if (mod->csumfunc.crc8) {
 		if (nla_put(skb, CGW_CS_CRC8, CGW_CS_CRC8_LEN,
-			    &gwj->mod.csum.crc8) < 0)
+			    &mod->csum.crc8) < 0)
 			goto cancel;
 	}
 
-	if (gwj->mod.csumfunc.xor) {
+	if (mod->csumfunc.xor) {
 		if (nla_put(skb, CGW_CS_XOR, CGW_CS_XOR_LEN,
-			    &gwj->mod.csum.xor) < 0)
+			    &mod->csum.xor) < 0)
 			goto cancel;
 	}
 
@@ -1059,7 +1074,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	struct net *net = sock_net(skb->sk);
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
-	struct cf_mod mod;
+	struct cf_mod *mod;
 	struct can_can_gw ccgw;
 	u8 limhops = 0;
 	int err = 0;
@@ -1078,37 +1093,48 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (r->gwtype != CGW_TYPE_CAN_CAN)
 		return -EINVAL;
 
-	err = cgw_parse_attr(nlh, &mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
+	mod = kmalloc(sizeof(*mod), GFP_KERNEL);
+	if (!mod)
+		return -ENOMEM;
+
+	err = cgw_parse_attr(nlh, mod, CGW_TYPE_CAN_CAN, &ccgw, &limhops);
 	if (err < 0)
-		return err;
+		goto out_free_cf;
 
-	if (mod.uid) {
+	if (mod->uid) {
 		ASSERT_RTNL();
 
 		/* check for updating an existing job with identical uid */
 		hlist_for_each_entry(gwj, &net->can.cgw_list, list) {
-			if (gwj->mod.uid != mod.uid)
+			struct cf_mod *old_cf;
+
+			old_cf = cgw_job_cf_mod(gwj);
+			if (old_cf->uid != mod->uid)
 				continue;
 
 			/* interfaces & filters must be identical */
-			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw)))
-				return -EINVAL;
+			if (memcmp(&gwj->ccgw, &ccgw, sizeof(ccgw))) {
+				err = -EINVAL;
+				goto out_free_cf;
+			}
 
-			/* update modifications with disabled softirq & quit */
-			local_bh_disable();
-			memcpy(&gwj->mod, &mod, sizeof(mod));
-			local_bh_enable();
+			rcu_assign_pointer(gwj->cf_mod, mod);
+			kfree_rcu_mightsleep(old_cf);
 			return 0;
 		}
 	}
 
 	/* ifindex == 0 is not allowed for job creation */
-	if (!ccgw.src_idx || !ccgw.dst_idx)
-		return -ENODEV;
+	if (!ccgw.src_idx || !ccgw.dst_idx) {
+		err = -ENODEV;
+		goto out_free_cf;
+	}
 
 	gwj = kmem_cache_alloc(cgw_cache, GFP_KERNEL);
-	if (!gwj)
-		return -ENOMEM;
+	if (!gwj) {
+		err = -ENOMEM;
+		goto out_free_cf;
+	}
 
 	gwj->handled_frames = 0;
 	gwj->dropped_frames = 0;
@@ -1118,7 +1144,7 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	gwj->limit_hops = limhops;
 
 	/* insert already parsed information */
-	memcpy(&gwj->mod, &mod, sizeof(mod));
+	RCU_INIT_POINTER(gwj->cf_mod, mod);
 	memcpy(&gwj->ccgw, &ccgw, sizeof(ccgw));
 
 	err = -ENODEV;
@@ -1152,9 +1178,11 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 	if (!err)
 		hlist_add_head_rcu(&gwj->list, &net->can.cgw_list);
 out:
-	if (err)
+	if (err) {
 		kmem_cache_free(cgw_cache, gwj);
-
+out_free_cf:
+		kfree(mod);
+	}
 	return err;
 }
 
@@ -1214,19 +1242,22 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	/* remove only the first matching entry */
 	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
+		struct cf_mod *cf_mod;
+
 		if (gwj->flags != r->flags)
 			continue;
 
 		if (gwj->limit_hops != limhops)
 			continue;
 
+		cf_mod = cgw_job_cf_mod(gwj);
 		/* we have a match when uid is enabled and identical */
-		if (gwj->mod.uid || mod.uid) {
-			if (gwj->mod.uid != mod.uid)
+		if (cf_mod->uid || mod.uid) {
+			if (cf_mod->uid != mod.uid)
 				continue;
 		} else {
 			/* no uid => check for identical modifications */
-			if (memcmp(&gwj->mod, &mod, sizeof(mod)))
+			if (memcmp(cf_mod, &mod, sizeof(mod)))
 				continue;
 		}
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 790345c2546b..99b23fd2f509 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2526,6 +2526,7 @@ int skb_do_redirect(struct sk_buff *skb)
 			goto out_drop;
 		skb->dev = dev;
 		dev_sw_netstats_rx_add(dev, skb->len);
+		skb_scrub_packet(skb, false);
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index ad426b3a03b5..0fe537781bc4 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -616,25 +616,66 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 	return 0;
 }
 
+/**
+ * netdev_stat_queue_sum() - add up queue stats from range of queues
+ * @netdev:	net_device
+ * @rx_start:	index of the first Rx queue to query
+ * @rx_end:	index after the last Rx queue (first *not* to query)
+ * @rx_sum:	output Rx stats, should be already initialized
+ * @tx_start:	index of the first Tx queue to query
+ * @tx_end:	index after the last Tx queue (first *not* to query)
+ * @tx_sum:	output Tx stats, should be already initialized
+ *
+ * Add stats from [start, end) range of queue IDs to *x_sum structs.
+ * The sum structs must be already initialized. Usually this
+ * helper is invoked from the .get_base_stats callbacks of drivers
+ * to account for stats of disabled queues. In that case the ranges
+ * are usually [netdev->real_num_*x_queues, netdev->num_*x_queues).
+ */
+void netdev_stat_queue_sum(struct net_device *netdev,
+			   int rx_start, int rx_end,
+			   struct netdev_queue_stats_rx *rx_sum,
+			   int tx_start, int tx_end,
+			   struct netdev_queue_stats_tx *tx_sum)
+{
+	const struct netdev_stat_ops *ops;
+	struct netdev_queue_stats_rx rx;
+	struct netdev_queue_stats_tx tx;
+	int i;
+
+	ops = netdev->stat_ops;
+
+	for (i = rx_start; i < rx_end; i++) {
+		memset(&rx, 0xff, sizeof(rx));
+		if (ops->get_queue_stats_rx)
+			ops->get_queue_stats_rx(netdev, i, &rx);
+		netdev_nl_stats_add(rx_sum, &rx, sizeof(rx));
+	}
+	for (i = tx_start; i < tx_end; i++) {
+		memset(&tx, 0xff, sizeof(tx));
+		if (ops->get_queue_stats_tx)
+			ops->get_queue_stats_tx(netdev, i, &tx);
+		netdev_nl_stats_add(tx_sum, &tx, sizeof(tx));
+	}
+}
+EXPORT_SYMBOL(netdev_stat_queue_sum);
+
 static int
 netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
 			  const struct genl_info *info)
 {
-	struct netdev_queue_stats_rx rx_sum, rx;
-	struct netdev_queue_stats_tx tx_sum, tx;
-	const struct netdev_stat_ops *ops;
+	struct netdev_queue_stats_rx rx_sum;
+	struct netdev_queue_stats_tx tx_sum;
 	void *hdr;
-	int i;
 
-	ops = netdev->stat_ops;
 	/* Netdev can't guarantee any complete counters */
-	if (!ops->get_base_stats)
+	if (!netdev->stat_ops->get_base_stats)
 		return 0;
 
 	memset(&rx_sum, 0xff, sizeof(rx_sum));
 	memset(&tx_sum, 0xff, sizeof(tx_sum));
 
-	ops->get_base_stats(netdev, &rx_sum, &tx_sum);
+	netdev->stat_ops->get_base_stats(netdev, &rx_sum, &tx_sum);
 
 	/* The op was there, but nothing reported, don't bother */
 	if (!memchr_inv(&rx_sum, 0xff, sizeof(rx_sum)) &&
@@ -647,18 +688,8 @@ netdev_nl_stats_by_netdev(struct net_device *netdev, struct sk_buff *rsp,
 	if (nla_put_u32(rsp, NETDEV_A_QSTATS_IFINDEX, netdev->ifindex))
 		goto nla_put_failure;
 
-	for (i = 0; i < netdev->real_num_rx_queues; i++) {
-		memset(&rx, 0xff, sizeof(rx));
-		if (ops->get_queue_stats_rx)
-			ops->get_queue_stats_rx(netdev, i, &rx);
-		netdev_nl_stats_add(&rx_sum, &rx, sizeof(rx));
-	}
-	for (i = 0; i < netdev->real_num_tx_queues; i++) {
-		memset(&tx, 0xff, sizeof(tx));
-		if (ops->get_queue_stats_tx)
-			ops->get_queue_stats_tx(netdev, i, &tx);
-		netdev_nl_stats_add(&tx_sum, &tx, sizeof(tx));
-	}
+	netdev_stat_queue_sum(netdev, 0, netdev->real_num_rx_queues, &rx_sum,
+			      0, netdev->real_num_tx_queues, &tx_sum);
 
 	if (netdev_nl_stats_write_rx(rsp, &rx_sum) ||
 	    netdev_nl_stats_write_tx(rsp, &tx_sum))
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index f5d49162f798..16ba3bb12fc4 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3237,16 +3237,13 @@ static void add_v4_addrs(struct inet6_dev *idev)
 	struct in6_addr addr;
 	struct net_device *dev;
 	struct net *net = dev_net(idev->dev);
-	int scope, plen, offset = 0;
+	int scope, plen;
 	u32 pflags = 0;
 
 	ASSERT_RTNL();
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-	/* in case of IP6GRE the dev_addr is an IPv6 and therefore we use only the last 4 bytes */
-	if (idev->dev->addr_len == sizeof(struct in6_addr))
-		offset = sizeof(struct in6_addr) - 4;
-	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr + offset, 4);
+	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr, 4);
 
 	if (!(idev->dev->flags & IFF_POINTOPOINT) && idev->dev->type == ARPHRD_SIT) {
 		scope = IPV6_ADDR_COMPATv4;
@@ -3557,7 +3554,13 @@ static void addrconf_gre_config(struct net_device *dev)
 		return;
 	}
 
-	if (dev->type == ARPHRD_ETHER) {
+	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
+	 * unless we have an IPv4 GRE device not bound to an IP address and
+	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
+	 * case). Such devices fall back to add_v4_addrs() instead.
+	 */
+	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
+	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
 		addrconf_addr_gen(idev, true);
 		return;
 	}
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ad0d040569dc..cc8c5d18b130 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7177,6 +7177,7 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_res);
 	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
 		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
+	u16 status_code;
 
 	skb = dev_alloc_skb(local->tx_headroom + hdr_len + ttlm_max_len);
 	if (!skb)
@@ -7199,19 +7200,18 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 		WARN_ON(1);
 		fallthrough;
 	case NEG_TTLM_RES_REJECT:
-		mgmt->u.action.u.ttlm_res.status_code =
-			WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING;
+		status_code = WLAN_STATUS_DENIED_TID_TO_LINK_MAPPING;
 		break;
 	case NEG_TTLM_RES_ACCEPT:
-		mgmt->u.action.u.ttlm_res.status_code = WLAN_STATUS_SUCCESS;
+		status_code = WLAN_STATUS_SUCCESS;
 		break;
 	case NEG_TTLM_RES_SUGGEST_PREFERRED:
-		mgmt->u.action.u.ttlm_res.status_code =
-			WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED;
+		status_code = WLAN_STATUS_PREF_TID_TO_LINK_MAPPING_SUGGESTED;
 		ieee80211_neg_ttlm_add_suggested_map(skb, neg_ttlm);
 		break;
 	}
 
+	mgmt->u.action.u.ttlm_res.status_code = cpu_to_le16(status_code);
 	ieee80211_tx_skb(sdata, skb);
 }
 
@@ -7377,7 +7377,7 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
 	 * This can be better implemented in the future, to handle request
 	 * rejections.
 	 */
-	if (mgmt->u.action.u.ttlm_res.status_code != WLAN_STATUS_SUCCESS)
+	if (le16_to_cpu(mgmt->u.action.u.ttlm_res.status_code) != WLAN_STATUS_SUCCESS)
 		__ieee80211_disconnect(sdata);
 }
 
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index cf3ce72c3de6..5251524b96af 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -64,7 +64,7 @@ struct hbucket {
 #define ahash_sizeof_regions(htable_bits)		\
 	(ahash_numof_locks(htable_bits) * sizeof(struct ip_set_region))
 #define ahash_region(n, htable_bits)		\
-	((n) % ahash_numof_locks(htable_bits))
+	((n) / jhash_size(HTABLE_REGION_BITS))
 #define ahash_bucket_start(h,  htable_bits)	\
 	((htable_bits) < HTABLE_REGION_BITS ? 0	\
 		: (h) * jhash_size(HTABLE_REGION_BITS))
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 3313bceb6cc9..014f07740369 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -119,13 +119,12 @@ __mtu_check_toobig_v6(const struct sk_buff *skb, u32 mtu)
 	return false;
 }
 
-/* Get route to daddr, update *saddr, optionally bind route to saddr */
+/* Get route to daddr, optionally bind route to saddr */
 static struct rtable *do_output_route4(struct net *net, __be32 daddr,
-				       int rt_mode, __be32 *saddr)
+				       int rt_mode, __be32 *ret_saddr)
 {
 	struct flowi4 fl4;
 	struct rtable *rt;
-	bool loop = false;
 
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.daddr = daddr;
@@ -135,23 +134,17 @@ static struct rtable *do_output_route4(struct net *net, __be32 daddr,
 retry:
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
-		/* Invalid saddr ? */
-		if (PTR_ERR(rt) == -EINVAL && *saddr &&
-		    rt_mode & IP_VS_RT_MODE_CONNECT && !loop) {
-			*saddr = 0;
-			flowi4_update_output(&fl4, 0, daddr, 0);
-			goto retry;
-		}
 		IP_VS_DBG_RL("ip_route_output error, dest: %pI4\n", &daddr);
 		return NULL;
-	} else if (!*saddr && rt_mode & IP_VS_RT_MODE_CONNECT && fl4.saddr) {
+	}
+	if (rt_mode & IP_VS_RT_MODE_CONNECT && fl4.saddr) {
 		ip_rt_put(rt);
-		*saddr = fl4.saddr;
 		flowi4_update_output(&fl4, 0, daddr, fl4.saddr);
-		loop = true;
+		rt_mode = 0;
 		goto retry;
 	}
-	*saddr = fl4.saddr;
+	if (ret_saddr)
+		*ret_saddr = fl4.saddr;
 	return rt;
 }
 
@@ -344,19 +337,15 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 		if (ret_saddr)
 			*ret_saddr = dest_dst->dst_saddr.ip;
 	} else {
-		__be32 saddr = htonl(INADDR_ANY);
-
 		noref = 0;
 
 		/* For such unconfigured boxes avoid many route lookups
 		 * for performance reasons because we do not remember saddr
 		 */
 		rt_mode &= ~IP_VS_RT_MODE_CONNECT;
-		rt = do_output_route4(net, daddr, rt_mode, &saddr);
+		rt = do_output_route4(net, daddr, rt_mode, ret_saddr);
 		if (!rt)
 			goto err_unreach;
-		if (ret_saddr)
-			*ret_saddr = saddr;
 	}
 
 	local = (rt->rt_flags & RTCF_LOCAL) ? 1 : 0;
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 61fea7baae5d..2f22ca59586f 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -975,8 +975,7 @@ static int output_userspace(struct datapath *dp, struct sk_buff *skb,
 	upcall.cmd = OVS_PACKET_CMD_ACTION;
 	upcall.mru = OVS_CB(skb)->mru;
 
-	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
-	     a = nla_next(a, &rem)) {
+	nla_for_each_nested(a, attr, rem) {
 		switch (nla_type(a)) {
 		case OVS_USERSPACE_ATTR_USERDATA:
 			upcall.userdata = a;
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 12cccc84d58a..b2494d24a542 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
  */
 static inline void htb_next_rb_node(struct rb_node **n)
 {
-	*n = rb_next(*n);
+	if (*n)
+		*n = rb_next(*n);
 }
 
 /**
@@ -609,8 +610,8 @@ static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
  */
 static inline void htb_deactivate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(!cl->prio_activity);
-
+	if (!cl->prio_activity)
+		return;
 	htb_deactivate_prios(q, cl);
 	cl->prio_activity = 0;
 }
@@ -1485,8 +1486,6 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
-	if (!cl->prio_activity)
-		return;
 	htb_deactivate(qdisc_priv(sch), cl);
 }
 
@@ -1740,8 +1739,7 @@ static int htb_delete(struct Qdisc *sch, unsigned long arg,
 	if (cl->parent)
 		cl->parent->children--;
 
-	if (cl->prio_activity)
-		htb_deactivate(q, cl);
+	htb_deactivate(q, cl);
 
 	if (cl->cmode != HTB_CAN_SEND)
 		htb_safe_rb_erase(&cl->pq_node,
@@ -1949,8 +1947,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
 			/* turn parent into inner node */
 			qdisc_purge_queue(parent->leaf.q);
 			parent_qdisc = parent->leaf.q;
-			if (parent->prio_activity)
-				htb_deactivate(q, parent);
+			htb_deactivate(q, parent);
 
 			/* remove from evt list because of level change */
 			if (parent->cmode != HTB_CAN_SEND) {
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 18e132cdea72..f0dd1f448d4d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2644,7 +2644,7 @@ cfg80211_defrag_mle(const struct element *mle, const u8 *ie, size_t ielen,
 	/* Required length for first defragmentation */
 	buf_len = mle->datalen - 1;
 	for_each_element(elem, mle->data + mle->datalen,
-			 ielen - sizeof(*mle) + mle->datalen) {
+			 ie + ielen - mle->data - mle->datalen) {
 		if (elem->id != WLAN_EID_FRAGMENT)
 			break;
 
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 014af0d1fc70..a08eb5518cac 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -26,6 +26,7 @@
 
 #[allow(dead_code)]
 #[allow(clippy::undocumented_unsafe_blocks)]
+#[cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
 mod bindings_raw {
     // Manual definition for blocklisted types.
     type __kernel_size_t = usize;
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..87a71fd40c3c 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -2,6 +2,9 @@
 
 //! Implementation of [`Vec`].
 
+// May not be needed in Rust 1.87.0 (pending beta backport).
+#![allow(clippy::ptr_eq)]
+
 use super::{
     allocator::{KVmalloc, Kmalloc, Vmalloc},
     layout::ArrayLayout,
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb93330f4af4..3841ba02ef7a 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -4,6 +4,9 @@
 
 //! A linked list implementation.
 
+// May not be needed in Rust 1.87.0 (pending beta backport).
+#![allow(clippy::ptr_eq)]
+
 use crate::init::PinInit;
 use crate::sync::ArcBorrow;
 use crate::types::Opaque;
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index d04c12a1426d..78ccfeb73858 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -55,7 +55,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 b'\r' => f.write_str("\\r")?,
                 // Printable characters.
                 0x20..=0x7e => f.write_char(b as char)?,
-                _ => write!(f, "\\x{:02x}", b)?,
+                _ => write!(f, "\\x{b:02x}")?,
             }
         }
         Ok(())
@@ -90,7 +90,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 b'\\' => f.write_str("\\\\")?,
                 // Printable characters.
                 0x20..=0x7e => f.write_char(b as char)?,
-                _ => write!(f, "\\x{:02x}", b)?,
+                _ => write!(f, "\\x{b:02x}")?,
             }
         }
         f.write_char('"')
@@ -397,7 +397,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 // Printable character.
                 f.write_char(c as char)?;
             } else {
-                write!(f, "\\x{:02x}", c)?;
+                write!(f, "\\x{c:02x}")?;
             }
         }
         Ok(())
@@ -428,7 +428,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                 // Printable characters.
                 b'\"' => f.write_str("\\\"")?,
                 0x20..=0x7e => f.write_char(c as char)?,
-                _ => write!(f, "\\x{:02x}", c)?,
+                _ => write!(f, "\\x{c:02x}")?,
             }
         }
         f.write_str("\"")
@@ -588,13 +588,13 @@ fn test_cstr_as_str_unchecked() {
     #[test]
     fn test_cstr_display() {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{}", hello_world), "hello, world!");
+        assert_eq!(format!("{hello_world}"), "hello, world!");
         let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{}", non_printables), "\\x01\\x09\\x0a");
+        assert_eq!(format!("{non_printables}"), "\\x01\\x09\\x0a");
         let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
+        assert_eq!(format!("{non_ascii}"), "d\\xe9j\\xe0 vu");
         let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        assert_eq!(format!("{good_bytes}"), "\\xf0\\x9f\\xa6\\x80");
     }
 
     #[test]
@@ -605,47 +605,47 @@ fn test_cstr_display_all_bytes() {
             bytes[i as usize] = i.wrapping_add(1);
         }
         let cstr = CStr::from_bytes_with_nul(&bytes).unwrap();
-        assert_eq!(format!("{}", cstr), ALL_ASCII_CHARS);
+        assert_eq!(format!("{cstr}"), ALL_ASCII_CHARS);
     }
 
     #[test]
     fn test_cstr_debug() {
         let hello_world = CStr::from_bytes_with_nul(b"hello, world!\0").unwrap();
-        assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
+        assert_eq!(format!("{hello_world:?}"), "\"hello, world!\"");
         let non_printables = CStr::from_bytes_with_nul(b"\x01\x09\x0a\0").unwrap();
-        assert_eq!(format!("{:?}", non_printables), "\"\\x01\\x09\\x0a\"");
+        assert_eq!(format!("{non_printables:?}"), "\"\\x01\\x09\\x0a\"");
         let non_ascii = CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").unwrap();
-        assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
+        assert_eq!(format!("{non_ascii:?}"), "\"d\\xe9j\\xe0 vu\"");
         let good_bytes = CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\0").unwrap();
-        assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
+        assert_eq!(format!("{good_bytes:?}"), "\"\\xf0\\x9f\\xa6\\x80\"");
     }
 
     #[test]
     fn test_bstr_display() {
         let hello_world = BStr::from_bytes(b"hello, world!");
-        assert_eq!(format!("{}", hello_world), "hello, world!");
+        assert_eq!(format!("{hello_world}"), "hello, world!");
         let escapes = BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
-        assert_eq!(format!("{}", escapes), "_\\t_\\n_\\r_\\_'_\"_");
+        assert_eq!(format!("{escapes}"), "_\\t_\\n_\\r_\\_'_\"_");
         let others = BStr::from_bytes(b"\x01");
-        assert_eq!(format!("{}", others), "\\x01");
+        assert_eq!(format!("{others}"), "\\x01");
         let non_ascii = BStr::from_bytes(b"d\xe9j\xe0 vu");
-        assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
+        assert_eq!(format!("{non_ascii}"), "d\\xe9j\\xe0 vu");
         let good_bytes = BStr::from_bytes(b"\xf0\x9f\xa6\x80");
-        assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
+        assert_eq!(format!("{good_bytes}"), "\\xf0\\x9f\\xa6\\x80");
     }
 
     #[test]
     fn test_bstr_debug() {
         let hello_world = BStr::from_bytes(b"hello, world!");
-        assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
+        assert_eq!(format!("{hello_world:?}"), "\"hello, world!\"");
         let escapes = BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
-        assert_eq!(format!("{:?}", escapes), "\"_\\t_\\n_\\r_\\\\_'_\\\"_\"");
+        assert_eq!(format!("{escapes:?}"), "\"_\\t_\\n_\\r_\\\\_'_\\\"_\"");
         let others = BStr::from_bytes(b"\x01");
-        assert_eq!(format!("{:?}", others), "\"\\x01\"");
+        assert_eq!(format!("{others:?}"), "\"\\x01\"");
         let non_ascii = BStr::from_bytes(b"d\xe9j\xe0 vu");
-        assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
+        assert_eq!(format!("{non_ascii:?}"), "\"d\\xe9j\\xe0 vu\"");
         let good_bytes = BStr::from_bytes(b"\xf0\x9f\xa6\x80");
-        assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\"");
+        assert_eq!(format!("{good_bytes:?}"), "\"\\xf0\\x9f\\xa6\\x80\"");
     }
 }
 
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index e7a087b7e884..da2a18b276e0 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -48,7 +48,7 @@ fn emit_base(&mut self, field: &str, content: &str, builtin: bool) {
             )
         } else {
             // Loadable modules' modinfo strings go as-is.
-            format!("{field}={content}\0", field = field, content = content)
+            format!("{field}={content}\0")
         };
 
         write!(
@@ -124,10 +124,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             };
 
             if seen_keys.contains(&key) {
-                panic!(
-                    "Duplicated key \"{}\". Keys can only be specified once.",
-                    key
-                );
+                panic!("Duplicated key \"{key}\". Keys can only be specified once.");
             }
 
             assert_eq!(expect_punct(it), ':');
@@ -140,10 +137,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
                 "license" => info.license = expect_string_ascii(it),
                 "alias" => info.alias = Some(expect_string_array(it)),
                 "firmware" => info.firmware = Some(expect_string_array(it)),
-                _ => panic!(
-                    "Unknown key \"{}\". Valid keys are: {:?}.",
-                    key, EXPECTED_KEYS
-                ),
+                _ => panic!("Unknown key \"{key}\". Valid keys are: {EXPECTED_KEYS:?}."),
             }
 
             assert_eq!(expect_punct(it), ',');
@@ -155,7 +149,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
 
         for key in REQUIRED_KEYS {
             if !seen_keys.iter().any(|e| e == key) {
-                panic!("Missing required key \"{}\".", key);
+                panic!("Missing required key \"{key}\".");
             }
         }
 
@@ -167,10 +161,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
         }
 
         if seen_keys != ordered_keys {
-            panic!(
-                "Keys are not ordered as expected. Order them like: {:?}.",
-                ordered_keys
-            );
+            panic!("Keys are not ordered as expected. Order them like: {ordered_keys:?}.");
         }
 
         info
diff --git a/rust/macros/pinned_drop.rs b/rust/macros/pinned_drop.rs
index 88fb72b20660..79a52e254f71 100644
--- a/rust/macros/pinned_drop.rs
+++ b/rust/macros/pinned_drop.rs
@@ -25,8 +25,7 @@ pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> TokenStream
             // Found the end of the generics, this should be `PinnedDrop`.
             assert!(
                 matches!(tt, TokenTree::Ident(i) if i.to_string() == "PinnedDrop"),
-                "expected 'PinnedDrop', found: '{:?}'",
-                tt
+                "expected 'PinnedDrop', found: '{tt:?}'"
             );
             pinned_drop_idx = Some(i);
             break;
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 13495910271f..c98d7a8cde77 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -24,6 +24,7 @@
     unreachable_pub,
     unsafe_op_in_unsafe_fn
 )]
+#![cfg_attr(CONFIG_RUSTC_HAS_UNNECESSARY_TRANSMUTES, allow(unnecessary_transmutes))]
 
 // Manual definition of blocklisted types.
 type __kernel_size_t = usize;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d8aea31ee393..bea6461ac340 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -219,6 +219,7 @@ static bool is_rust_noreturn(const struct symbol *func)
 	       str_ends_with(func->name, "_4core9panicking19assert_failed_inner")			||
 	       str_ends_with(func->name, "_4core9panicking30panic_null_pointer_dereference")		||
 	       str_ends_with(func->name, "_4core9panicking36panic_misaligned_pointer_dereference")	||
+	       str_ends_with(func->name, "_7___rustc17rust_begin_unwind")				||
 	       strstr(func->name, "_4core9panicking13assert_failed")					||
 	       strstr(func->name, "_4core9panicking11panic_const24panic_const_")			||
 	       (strstr(func->name, "_4core5slice5index24slice_") &&
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 363d031a16f7..9cf769d41568 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -115,6 +115,7 @@ TARGETS += user_events
 TARGETS += vDSO
 TARGETS += mm
 TARGETS += x86
+TARGETS += x86/bugs
 TARGETS += zram
 #Please keep the TARGETS list alphabetically sorted
 # Run "make quicktest=1 run_tests" or
diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 2c3a0eb6b22d..9bc4591c7b16 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -90,6 +90,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 	int compaction_index = 0;
 	char nr_hugepages[20] = {0};
 	char init_nr_hugepages[24] = {0};
+	char target_nr_hugepages[24] = {0};
+	int slen;
 
 	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
 		 "%lu", initial_nr_hugepages);
@@ -106,11 +108,18 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
 		goto out;
 	}
 
-	/* Request a large number of huge pages. The Kernel will allocate
-	   as much as it can */
-	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
-		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
-			       strerror(errno));
+	/*
+	 * Request huge pages for about half of the free memory. The Kernel
+	 * will allocate as much as it can, and we expect it will get at least 1/3
+	 */
+	nr_hugepages_ul = mem_free / hugepage_size / 2;
+	snprintf(target_nr_hugepages, sizeof(target_nr_hugepages),
+		 "%lu", nr_hugepages_ul);
+
+	slen = strlen(target_nr_hugepages);
+	if (write(fd, target_nr_hugepages, slen) != slen) {
+		ksft_print_msg("Failed to write %lu to /proc/sys/vm/nr_hugepages: %s\n",
+			       nr_hugepages_ul, strerror(errno));
 		goto close_fd;
 	}
 
diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index 3d0c0bdae5bc..e90af82f8688 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -102,8 +102,18 @@ void expect_fault_on_read_execonly_key(void *p1, int pkey)
 	return;
 }
 
+#define REPEAT_8(s) s s s s s s s s
+#define REPEAT_64(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) \
+		     REPEAT_8(s) REPEAT_8(s) REPEAT_8(s) REPEAT_8(s)
+#define REPEAT_512(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) \
+		      REPEAT_64(s) REPEAT_64(s) REPEAT_64(s) REPEAT_64(s)
+#define REPEAT_4096(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) \
+		       REPEAT_512(s) REPEAT_512(s) REPEAT_512(s) REPEAT_512(s)
+#define REPEAT_16384(s) REPEAT_4096(s) REPEAT_4096(s) \
+			REPEAT_4096(s) REPEAT_4096(s)
+
 /* 4-byte instructions * 16384 = 64K page */
-#define __page_o_noops() asm(".rept 16384 ; nop; .endr")
+#define __page_o_noops() asm(REPEAT_16384("nop\n"))
 
 void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
 {
diff --git a/tools/testing/selftests/x86/bugs/Makefile b/tools/testing/selftests/x86/bugs/Makefile
new file mode 100644
index 000000000000..8ff2d7226c7f
--- /dev/null
+++ b/tools/testing/selftests/x86/bugs/Makefile
@@ -0,0 +1,3 @@
+TEST_PROGS := its_sysfs.py its_permutations.py its_indirect_alignment.py its_ret_alignment.py
+TEST_FILES := common.py
+include ../../lib.mk
diff --git a/tools/testing/selftests/x86/bugs/common.py b/tools/testing/selftests/x86/bugs/common.py
new file mode 100644
index 000000000000..2f9664a80617
--- /dev/null
+++ b/tools/testing/selftests/x86/bugs/common.py
@@ -0,0 +1,164 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Intel Corporation
+#
+# This contains kselftest framework adapted common functions for testing
+# mitigation for x86 bugs.
+
+import os, sys, re, shutil
+
+sys.path.insert(0, '../../kselftest')
+import ksft
+
+def read_file(path):
+    if not os.path.exists(path):
+        return None
+    with open(path, 'r') as file:
+        return file.read().strip()
+
+def cpuinfo_has(arg):
+    cpuinfo = read_file('/proc/cpuinfo')
+    if arg in cpuinfo:
+        return True
+    return False
+
+def cmdline_has(arg):
+    cmdline = read_file('/proc/cmdline')
+    if arg in cmdline:
+        return True
+    return False
+
+def cmdline_has_either(args):
+    cmdline = read_file('/proc/cmdline')
+    for arg in args:
+        if arg in cmdline:
+            return True
+    return False
+
+def cmdline_has_none(args):
+    return not cmdline_has_either(args)
+
+def cmdline_has_all(args):
+    cmdline = read_file('/proc/cmdline')
+    for arg in args:
+        if arg not in cmdline:
+            return False
+    return True
+
+def get_sysfs(bug):
+    return read_file("/sys/devices/system/cpu/vulnerabilities/" + bug)
+
+def sysfs_has(bug, mitigation):
+    status = get_sysfs(bug)
+    if mitigation in status:
+        return True
+    return False
+
+def sysfs_has_either(bugs, mitigations):
+    for bug in bugs:
+        for mitigation in mitigations:
+            if sysfs_has(bug, mitigation):
+                return True
+    return False
+
+def sysfs_has_none(bugs, mitigations):
+    return not sysfs_has_either(bugs, mitigations)
+
+def sysfs_has_all(bugs, mitigations):
+    for bug in bugs:
+        for mitigation in mitigations:
+            if not sysfs_has(bug, mitigation):
+                return False
+    return True
+
+def bug_check_pass(bug, found):
+    ksft.print_msg(f"\nFound: {found}")
+    # ksft.print_msg(f"\ncmdline: {read_file('/proc/cmdline')}")
+    ksft.test_result_pass(f'{bug}: {found}')
+
+def bug_check_fail(bug, found, expected):
+    ksft.print_msg(f'\nFound:\t {found}')
+    ksft.print_msg(f'Expected:\t {expected}')
+    ksft.print_msg(f"\ncmdline: {read_file('/proc/cmdline')}")
+    ksft.test_result_fail(f'{bug}: {found}')
+
+def bug_status_unknown(bug, found):
+    ksft.print_msg(f'\nUnknown status: {found}')
+    ksft.print_msg(f"\ncmdline: {read_file('/proc/cmdline')}")
+    ksft.test_result_fail(f'{bug}: {found}')
+
+def basic_checks_sufficient(bug, mitigation):
+    if not mitigation:
+        bug_status_unknown(bug, "None")
+        return True
+    elif mitigation == "Not affected":
+        ksft.test_result_pass(bug)
+        return True
+    elif mitigation == "Vulnerable":
+        if cmdline_has_either([f'{bug}=off', 'mitigations=off']):
+            bug_check_pass(bug, mitigation)
+            return True
+    return False
+
+def get_section_info(vmlinux, section_name):
+    from elftools.elf.elffile import ELFFile
+    with open(vmlinux, 'rb') as f:
+        elffile = ELFFile(f)
+        section = elffile.get_section_by_name(section_name)
+        if section is None:
+            ksft.print_msg("Available sections in vmlinux:")
+            for sec in elffile.iter_sections():
+                ksft.print_msg(sec.name)
+            raise ValueError(f"Section {section_name} not found in {vmlinux}")
+        return section['sh_addr'], section['sh_offset'], section['sh_size']
+
+def get_patch_sites(vmlinux, offset, size):
+    import struct
+    output = []
+    with open(vmlinux, 'rb') as f:
+        f.seek(offset)
+        i = 0
+        while i < size:
+            data = f.read(4)  # s32
+            if not data:
+                break
+            sym_offset = struct.unpack('<i', data)[0] + i
+            i += 4
+            output.append(sym_offset)
+    return output
+
+def get_instruction_from_vmlinux(elffile, section, virtual_address, target_address):
+    from capstone import Cs, CS_ARCH_X86, CS_MODE_64
+    section_start = section['sh_addr']
+    section_end = section_start + section['sh_size']
+
+    if not (section_start <= target_address < section_end):
+        return None
+
+    offset = target_address - section_start
+    code = section.data()[offset:offset + 16]
+
+    cap = init_capstone()
+    for instruction in cap.disasm(code, target_address):
+        if instruction.address == target_address:
+            return instruction
+    return None
+
+def init_capstone():
+    from capstone import Cs, CS_ARCH_X86, CS_MODE_64, CS_OPT_SYNTAX_ATT
+    cap = Cs(CS_ARCH_X86, CS_MODE_64)
+    cap.syntax = CS_OPT_SYNTAX_ATT
+    return cap
+
+def get_runtime_kernel():
+    import drgn
+    return drgn.program_from_kernel()
+
+def check_dependencies_or_skip(modules, script_name="unknown test"):
+    for mod in modules:
+        try:
+            __import__(mod)
+        except ImportError:
+            ksft.test_result_skip(f"Skipping {script_name}: missing module '{mod}'")
+            ksft.finished()
diff --git a/tools/testing/selftests/x86/bugs/its_indirect_alignment.py b/tools/testing/selftests/x86/bugs/its_indirect_alignment.py
new file mode 100644
index 000000000000..cdc33ae6a91c
--- /dev/null
+++ b/tools/testing/selftests/x86/bugs/its_indirect_alignment.py
@@ -0,0 +1,150 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Intel Corporation
+#
+# Test for indirect target selection (ITS) mitigation.
+#
+# Test if indirect CALL/JMP are correctly patched by evaluating
+# the vmlinux .retpoline_sites in /proc/kcore.
+
+# Install dependencies
+# add-apt-repository ppa:michel-slm/kernel-utils
+# apt update
+# apt install -y python3-drgn python3-pyelftools python3-capstone
+#
+# Best to copy the vmlinux at a standard location:
+# mkdir -p /usr/lib/debug/lib/modules/$(uname -r)
+# cp $VMLINUX /usr/lib/debug/lib/modules/$(uname -r)/vmlinux
+#
+# Usage: ./its_indirect_alignment.py [vmlinux]
+
+import os, sys, argparse
+from pathlib import Path
+
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, this_dir + '/../../kselftest')
+import ksft
+import common as c
+
+bug = "indirect_target_selection"
+
+mitigation = c.get_sysfs(bug)
+if not mitigation or "Aligned branch/return thunks" not in mitigation:
+    ksft.test_result_skip("Skipping its_indirect_alignment.py: Aligned branch/return thunks not enabled")
+    ksft.finished()
+
+if c.sysfs_has("spectre_v2", "Retpolines"):
+    ksft.test_result_skip("Skipping its_indirect_alignment.py: Retpolines deployed")
+    ksft.finished()
+
+c.check_dependencies_or_skip(['drgn', 'elftools', 'capstone'], script_name="its_indirect_alignment.py")
+
+from elftools.elf.elffile import ELFFile
+from drgn.helpers.common.memory import identify_address
+
+cap = c.init_capstone()
+
+if len(os.sys.argv) > 1:
+    arg_vmlinux = os.sys.argv[1]
+    if not os.path.exists(arg_vmlinux):
+        ksft.test_result_fail(f"its_indirect_alignment.py: vmlinux not found at argument path: {arg_vmlinux}")
+        ksft.exit_fail()
+    os.makedirs(f"/usr/lib/debug/lib/modules/{os.uname().release}", exist_ok=True)
+    os.system(f'cp {arg_vmlinux} /usr/lib/debug/lib/modules/$(uname -r)/vmlinux')
+
+vmlinux = f"/usr/lib/debug/lib/modules/{os.uname().release}/vmlinux"
+if not os.path.exists(vmlinux):
+    ksft.test_result_fail(f"its_indirect_alignment.py: vmlinux not found at {vmlinux}")
+    ksft.exit_fail()
+
+ksft.print_msg(f"Using vmlinux: {vmlinux}")
+
+retpolines_start_vmlinux, retpolines_sec_offset, size = c.get_section_info(vmlinux, '.retpoline_sites')
+ksft.print_msg(f"vmlinux: Section .retpoline_sites (0x{retpolines_start_vmlinux:x}) found at 0x{retpolines_sec_offset:x} with size 0x{size:x}")
+
+sites_offset = c.get_patch_sites(vmlinux, retpolines_sec_offset, size)
+total_retpoline_tests = len(sites_offset)
+ksft.print_msg(f"Found {total_retpoline_tests} retpoline sites")
+
+prog = c.get_runtime_kernel()
+retpolines_start_kcore = prog.symbol('__retpoline_sites').address
+ksft.print_msg(f'kcore: __retpoline_sites: 0x{retpolines_start_kcore:x}')
+
+x86_indirect_its_thunk_r15 = prog.symbol('__x86_indirect_its_thunk_r15').address
+ksft.print_msg(f'kcore: __x86_indirect_its_thunk_r15: 0x{x86_indirect_its_thunk_r15:x}')
+
+tests_passed = 0
+tests_failed = 0
+tests_unknown = 0
+
+with open(vmlinux, 'rb') as f:
+    elffile = ELFFile(f)
+    text_section = elffile.get_section_by_name('.text')
+
+    for i in range(0, len(sites_offset)):
+        site = retpolines_start_kcore + sites_offset[i]
+        vmlinux_site = retpolines_start_vmlinux + sites_offset[i]
+        passed = unknown = failed = False
+        try:
+            vmlinux_insn = c.get_instruction_from_vmlinux(elffile, text_section, text_section['sh_addr'], vmlinux_site)
+            kcore_insn = list(cap.disasm(prog.read(site, 16), site))[0]
+            operand = kcore_insn.op_str
+            insn_end = site + kcore_insn.size - 1 # TODO handle Jcc.32 __x86_indirect_thunk_\reg
+            safe_site = insn_end & 0x20
+            site_status = "" if safe_site else "(unsafe)"
+
+            ksft.print_msg(f"\nSite {i}: {identify_address(prog, site)} <0x{site:x}> {site_status}")
+            ksft.print_msg(f"\tvmlinux: 0x{vmlinux_insn.address:x}:\t{vmlinux_insn.mnemonic}\t{vmlinux_insn.op_str}")
+            ksft.print_msg(f"\tkcore:   0x{kcore_insn.address:x}:\t{kcore_insn.mnemonic}\t{kcore_insn.op_str}")
+
+            if (site & 0x20) ^ (insn_end & 0x20):
+                ksft.print_msg(f"\tSite at safe/unsafe boundary: {str(kcore_insn.bytes)} {kcore_insn.mnemonic} {operand}")
+            if safe_site:
+                tests_passed += 1
+                passed = True
+                ksft.print_msg(f"\tPASSED: At safe address")
+                continue
+
+            if operand.startswith('0xffffffff'):
+                thunk = int(operand, 16)
+                if thunk > x86_indirect_its_thunk_r15:
+                    insn_at_thunk = list(cap.disasm(prog.read(thunk, 16), thunk))[0]
+                    operand += ' -> ' + insn_at_thunk.mnemonic + ' ' + insn_at_thunk.op_str + ' <dynamic-thunk?>'
+                    if 'jmp' in insn_at_thunk.mnemonic and thunk & 0x20:
+                        ksft.print_msg(f"\tPASSED: Found {operand} at safe address")
+                        passed = True
+                if not passed:
+                    if kcore_insn.operands[0].type == capstone.CS_OP_IMM:
+                        operand += ' <' + prog.symbol(int(operand, 16)) + '>'
+                        if '__x86_indirect_its_thunk_' in operand:
+                            ksft.print_msg(f"\tPASSED: Found {operand}")
+                        else:
+                            ksft.print_msg(f"\tPASSED: Found direct branch: {kcore_insn}, ITS thunk not required.")
+                        passed = True
+                    else:
+                        unknown = True
+            if passed:
+                tests_passed += 1
+            elif unknown:
+                ksft.print_msg(f"UNKNOWN: unexpected operand: {kcore_insn}")
+                tests_unknown += 1
+            else:
+                ksft.print_msg(f'\t************* FAILED *************')
+                ksft.print_msg(f"\tFound {kcore_insn.bytes} {kcore_insn.mnemonic} {operand}")
+                ksft.print_msg(f'\t**********************************')
+                tests_failed += 1
+        except Exception as e:
+            ksft.print_msg(f"UNKNOWN: An unexpected error occurred: {e}")
+            tests_unknown += 1
+
+ksft.print_msg(f"\n\nSummary:")
+ksft.print_msg(f"PASS:    \t{tests_passed} \t/ {total_retpoline_tests}")
+ksft.print_msg(f"FAIL:    \t{tests_failed} \t/ {total_retpoline_tests}")
+ksft.print_msg(f"UNKNOWN: \t{tests_unknown} \t/ {total_retpoline_tests}")
+
+if tests_failed == 0:
+    ksft.test_result_pass("All ITS return thunk sites passed")
+else:
+    ksft.test_result_fail(f"{tests_failed} ITS return thunk sites failed")
+ksft.finished()
diff --git a/tools/testing/selftests/x86/bugs/its_permutations.py b/tools/testing/selftests/x86/bugs/its_permutations.py
new file mode 100644
index 000000000000..3204f4728c62
--- /dev/null
+++ b/tools/testing/selftests/x86/bugs/its_permutations.py
@@ -0,0 +1,109 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Intel Corporation
+#
+# Test for indirect target selection (ITS) cmdline permutations with other bugs
+# like spectre_v2 and retbleed.
+
+import os, sys, subprocess, itertools, re, shutil
+
+test_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, test_dir + '/../../kselftest')
+import ksft
+import common as c
+
+bug = "indirect_target_selection"
+mitigation = c.get_sysfs(bug)
+
+if not mitigation or "Not affected" in mitigation:
+    ksft.test_result_skip("Skipping its_permutations.py: not applicable")
+    ksft.finished()
+
+if shutil.which('vng') is None:
+    ksft.test_result_skip("Skipping its_permutations.py: virtme-ng ('vng') not found in PATH.")
+    ksft.finished()
+
+TEST = f"{test_dir}/its_sysfs.py"
+default_kparam = ['clearcpuid=hypervisor', 'panic=5', 'panic_on_warn=1', 'oops=panic', 'nmi_watchdog=1', 'hung_task_panic=1']
+
+DEBUG = " -v "
+
+# Install dependencies
+# https://github.com/arighi/virtme-ng
+# apt install virtme-ng
+BOOT_CMD = f"vng --run {test_dir}/../../../../../arch/x86/boot/bzImage "
+#BOOT_CMD += DEBUG
+
+bug = "indirect_target_selection"
+
+input_options = {
+    'indirect_target_selection'     : ['off', 'on', 'stuff', 'vmexit'],
+    'retbleed'                      : ['off', 'stuff', 'auto'],
+    'spectre_v2'                    : ['off', 'on', 'eibrs', 'retpoline', 'ibrs', 'eibrs,retpoline'],
+}
+
+def pretty_print(output):
+    OKBLUE = '\033[94m'
+    OKGREEN = '\033[92m'
+    WARNING = '\033[93m'
+    FAIL = '\033[91m'
+    ENDC = '\033[0m'
+    BOLD = '\033[1m'
+
+    # Define patterns and their corresponding colors
+    patterns = {
+        r"^ok \d+": OKGREEN,
+        r"^not ok \d+": FAIL,
+        r"^# Testing .*": OKBLUE,
+        r"^# Found: .*": WARNING,
+        r"^# Totals: .*": BOLD,
+        r"pass:([1-9]\d*)": OKGREEN,
+        r"fail:([1-9]\d*)": FAIL,
+        r"skip:([1-9]\d*)": WARNING,
+    }
+
+    # Apply colors based on patterns
+    for pattern, color in patterns.items():
+        output = re.sub(pattern, lambda match: f"{color}{match.group(0)}{ENDC}", output, flags=re.MULTILINE)
+
+    print(output)
+
+combinations = list(itertools.product(*input_options.values()))
+ksft.print_header()
+ksft.set_plan(len(combinations))
+
+logs = ""
+
+for combination in combinations:
+    append = ""
+    log = ""
+    for p in default_kparam:
+        append += f' --append={p}'
+    command = BOOT_CMD + append
+    test_params = ""
+    for i, key in enumerate(input_options.keys()):
+        param = f'{key}={combination[i]}'
+        test_params += f' {param}'
+        command += f" --append={param}"
+    command += f" -- {TEST}"
+    test_name = f"{bug} {test_params}"
+    pretty_print(f'# Testing {test_name}')
+    t =  subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
+    t.wait()
+    output, _ = t.communicate()
+    if t.returncode == 0:
+        ksft.test_result_pass(test_name)
+    else:
+        ksft.test_result_fail(test_name)
+    output = output.decode()
+    log += f" {output}"
+    pretty_print(log)
+    logs += output + "\n"
+
+# Optionally use tappy to parse the output
+# apt install python3-tappy
+with open("logs.txt", "w") as f:
+    f.write(logs)
+
+ksft.finished()
diff --git a/tools/testing/selftests/x86/bugs/its_ret_alignment.py b/tools/testing/selftests/x86/bugs/its_ret_alignment.py
new file mode 100644
index 000000000000..f40078d9f6ff
--- /dev/null
+++ b/tools/testing/selftests/x86/bugs/its_ret_alignment.py
@@ -0,0 +1,139 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Intel Corporation
+#
+# Test for indirect target selection (ITS) mitigation.
+#
+# Tests if the RETs are correctly patched by evaluating the
+# vmlinux .return_sites in /proc/kcore.
+#
+# Install dependencies
+# add-apt-repository ppa:michel-slm/kernel-utils
+# apt update
+# apt install -y python3-drgn python3-pyelftools python3-capstone
+#
+# Run on target machine
+# mkdir -p /usr/lib/debug/lib/modules/$(uname -r)
+# cp $VMLINUX /usr/lib/debug/lib/modules/$(uname -r)/vmlinux
+#
+# Usage: ./its_ret_alignment.py
+
+import os, sys, argparse
+from pathlib import Path
+
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, this_dir + '/../../kselftest')
+import ksft
+import common as c
+
+bug = "indirect_target_selection"
+mitigation = c.get_sysfs(bug)
+if not mitigation or "Aligned branch/return thunks" not in mitigation:
+    ksft.test_result_skip("Skipping its_ret_alignment.py: Aligned branch/return thunks not enabled")
+    ksft.finished()
+
+c.check_dependencies_or_skip(['drgn', 'elftools', 'capstone'], script_name="its_ret_alignment.py")
+
+from elftools.elf.elffile import ELFFile
+from drgn.helpers.common.memory import identify_address
+
+cap = c.init_capstone()
+
+if len(os.sys.argv) > 1:
+    arg_vmlinux = os.sys.argv[1]
+    if not os.path.exists(arg_vmlinux):
+        ksft.test_result_fail(f"its_ret_alignment.py: vmlinux not found at user-supplied path: {arg_vmlinux}")
+        ksft.exit_fail()
+    os.makedirs(f"/usr/lib/debug/lib/modules/{os.uname().release}", exist_ok=True)
+    os.system(f'cp {arg_vmlinux} /usr/lib/debug/lib/modules/$(uname -r)/vmlinux')
+
+vmlinux = f"/usr/lib/debug/lib/modules/{os.uname().release}/vmlinux"
+if not os.path.exists(vmlinux):
+    ksft.test_result_fail(f"its_ret_alignment.py: vmlinux not found at {vmlinux}")
+    ksft.exit_fail()
+
+ksft.print_msg(f"Using vmlinux: {vmlinux}")
+
+rethunks_start_vmlinux, rethunks_sec_offset, size = c.get_section_info(vmlinux, '.return_sites')
+ksft.print_msg(f"vmlinux: Section .return_sites (0x{rethunks_start_vmlinux:x}) found at 0x{rethunks_sec_offset:x} with size 0x{size:x}")
+
+sites_offset = c.get_patch_sites(vmlinux, rethunks_sec_offset, size)
+total_rethunk_tests = len(sites_offset)
+ksft.print_msg(f"Found {total_rethunk_tests} rethunk sites")
+
+prog = c.get_runtime_kernel()
+rethunks_start_kcore = prog.symbol('__return_sites').address
+ksft.print_msg(f'kcore: __rethunk_sites: 0x{rethunks_start_kcore:x}')
+
+its_return_thunk = prog.symbol('its_return_thunk').address
+ksft.print_msg(f'kcore: its_return_thunk: 0x{its_return_thunk:x}')
+
+tests_passed = 0
+tests_failed = 0
+tests_unknown = 0
+tests_skipped = 0
+
+with open(vmlinux, 'rb') as f:
+    elffile = ELFFile(f)
+    text_section = elffile.get_section_by_name('.text')
+
+    for i in range(len(sites_offset)):
+        site = rethunks_start_kcore + sites_offset[i]
+        vmlinux_site = rethunks_start_vmlinux + sites_offset[i]
+        try:
+            passed = unknown = failed = skipped = False
+
+            symbol = identify_address(prog, site)
+            vmlinux_insn = c.get_instruction_from_vmlinux(elffile, text_section, text_section['sh_addr'], vmlinux_site)
+            kcore_insn = list(cap.disasm(prog.read(site, 16), site))[0]
+
+            insn_end = site + kcore_insn.size - 1
+
+            safe_site = insn_end & 0x20
+            site_status = "" if safe_site else "(unsafe)"
+
+            ksft.print_msg(f"\nSite {i}: {symbol} <0x{site:x}> {site_status}")
+            ksft.print_msg(f"\tvmlinux: 0x{vmlinux_insn.address:x}:\t{vmlinux_insn.mnemonic}\t{vmlinux_insn.op_str}")
+            ksft.print_msg(f"\tkcore:   0x{kcore_insn.address:x}:\t{kcore_insn.mnemonic}\t{kcore_insn.op_str}")
+
+            if safe_site:
+                tests_passed += 1
+                passed = True
+                ksft.print_msg(f"\tPASSED: At safe address")
+                continue
+
+            if "jmp" in kcore_insn.mnemonic:
+                passed = True
+            elif "ret" not in kcore_insn.mnemonic:
+                skipped = True
+
+            if passed:
+                ksft.print_msg(f"\tPASSED: Found {kcore_insn.mnemonic} {kcore_insn.op_str}")
+                tests_passed += 1
+            elif skipped:
+                ksft.print_msg(f"\tSKIPPED: Found '{kcore_insn.mnemonic}'")
+                tests_skipped += 1
+            elif unknown:
+                ksft.print_msg(f"UNKNOWN: An unknown instruction: {kcore_insn}")
+                tests_unknown += 1
+            else:
+                ksft.print_msg(f'\t************* FAILED *************')
+                ksft.print_msg(f"\tFound {kcore_insn.mnemonic} {kcore_insn.op_str}")
+                ksft.print_msg(f'\t**********************************')
+                tests_failed += 1
+        except Exception as e:
+            ksft.print_msg(f"UNKNOWN: An unexpected error occurred: {e}")
+            tests_unknown += 1
+
+ksft.print_msg(f"\n\nSummary:")
+ksft.print_msg(f"PASSED: \t{tests_passed} \t/ {total_rethunk_tests}")
+ksft.print_msg(f"FAILED: \t{tests_failed} \t/ {total_rethunk_tests}")
+ksft.print_msg(f"SKIPPED: \t{tests_skipped} \t/ {total_rethunk_tests}")
+ksft.print_msg(f"UNKNOWN: \t{tests_unknown} \t/ {total_rethunk_tests}")
+
+if tests_failed == 0:
+    ksft.test_result_pass("All ITS return thunk sites passed.")
+else:
+    ksft.test_result_fail(f"{tests_failed} failed sites need ITS return thunks.")
+ksft.finished()
diff --git a/tools/testing/selftests/x86/bugs/its_sysfs.py b/tools/testing/selftests/x86/bugs/its_sysfs.py
new file mode 100644
index 000000000000..7bca81f2f606
--- /dev/null
+++ b/tools/testing/selftests/x86/bugs/its_sysfs.py
@@ -0,0 +1,65 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025 Intel Corporation
+#
+# Test for Indirect Target Selection(ITS) mitigation sysfs status.
+
+import sys, os, re
+this_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, this_dir + '/../../kselftest')
+import ksft
+
+from common import *
+
+bug = "indirect_target_selection"
+mitigation = get_sysfs(bug)
+
+ITS_MITIGATION_ALIGNED_THUNKS	= "Mitigation: Aligned branch/return thunks"
+ITS_MITIGATION_RETPOLINE_STUFF	= "Mitigation: Retpolines, Stuffing RSB"
+ITS_MITIGATION_VMEXIT_ONLY		= "Mitigation: Vulnerable, KVM: Not affected"
+ITS_MITIGATION_VULNERABLE       = "Vulnerable"
+
+def check_mitigation():
+    if mitigation == ITS_MITIGATION_ALIGNED_THUNKS:
+        if cmdline_has(f'{bug}=stuff') and sysfs_has("spectre_v2", "Retpolines"):
+            bug_check_fail(bug, ITS_MITIGATION_ALIGNED_THUNKS, ITS_MITIGATION_RETPOLINE_STUFF)
+            return
+        if cmdline_has(f'{bug}=vmexit') and cpuinfo_has('its_native_only'):
+            bug_check_fail(bug, ITS_MITIGATION_ALIGNED_THUNKS, ITS_MITIGATION_VMEXIT_ONLY)
+            return
+        bug_check_pass(bug, ITS_MITIGATION_ALIGNED_THUNKS)
+        return
+
+    if mitigation == ITS_MITIGATION_RETPOLINE_STUFF:
+        if cmdline_has(f'{bug}=stuff') and sysfs_has("spectre_v2", "Retpolines"):
+            bug_check_pass(bug, ITS_MITIGATION_RETPOLINE_STUFF)
+            return
+        if sysfs_has('retbleed', 'Stuffing'):
+            bug_check_pass(bug, ITS_MITIGATION_RETPOLINE_STUFF)
+            return
+        bug_check_fail(bug, ITS_MITIGATION_RETPOLINE_STUFF, ITS_MITIGATION_ALIGNED_THUNKS)
+
+    if mitigation == ITS_MITIGATION_VMEXIT_ONLY:
+        if cmdline_has(f'{bug}=vmexit') and cpuinfo_has('its_native_only'):
+            bug_check_pass(bug, ITS_MITIGATION_VMEXIT_ONLY)
+            return
+        bug_check_fail(bug, ITS_MITIGATION_VMEXIT_ONLY, ITS_MITIGATION_ALIGNED_THUNKS)
+
+    if mitigation == ITS_MITIGATION_VULNERABLE:
+        if sysfs_has("spectre_v2", "Vulnerable"):
+            bug_check_pass(bug, ITS_MITIGATION_VULNERABLE)
+        else:
+            bug_check_fail(bug, "Mitigation", ITS_MITIGATION_VULNERABLE)
+
+    bug_status_unknown(bug, mitigation)
+    return
+
+ksft.print_header()
+ksft.set_plan(1)
+ksft.print_msg(f'{bug}: {mitigation} ...')
+
+if not basic_checks_sufficient(bug, mitigation):
+    check_mitigation()
+
+ksft.finished()

