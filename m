Return-Path: <stable+bounces-38916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368C8A1102
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2944E288336
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D173146D47;
	Thu, 11 Apr 2024 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ayZakPN+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7C8146A8D;
	Thu, 11 Apr 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831966; cv=none; b=c2FQLxzmf/0qW9Vb6lXmD2q1W53Cys+1iGla+5KoH47yOpOoX9UVqNJ5aOvmOoswDNNhhvl1k9u+ZlCdkH6tx/2MDsEKeSe0tq9KWaZD7VLRcdGk5q4iqH7NeWBD5lULIfekf+ykNbA9xZllzgyd0ejaHRLWdd+Pz8LlHBLFRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831966; c=relaxed/simple;
	bh=KfF6fc46I93xlPrHF1++zORnoVLrBEwTRzAzMcsG0u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eqkTwSadOlQDoJKPQ7Qa2DQO7aKyXue0W6DujnjdNtKILWLZ0XqCgkVmRL9sTXQpFg01rleu94xi8yHy76q1BbiZLUlLMxIFdalWAmp48cZ6+KMCKQ+8ssYOKRcIcCptXR2+Qo3D4ubP6Z0oAs1vc5Llr8gQlEt5Fjk2xeyw2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ayZakPN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665B9C433F1;
	Thu, 11 Apr 2024 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831965;
	bh=KfF6fc46I93xlPrHF1++zORnoVLrBEwTRzAzMcsG0u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayZakPN+H6gsIxzEB7t8eXNa/pZUdDGo9hP3saD3+aPp29cYTf8QadQmjjA2cquCw
	 WKtN+I1d1gAPPlnZXAKXwDpTNw/imh+NdQHuLB7E9djc4Ga+PEdVRpQmY9gLellQVk
	 gTqKkfm+vgfH97uCDLi4J7KHPsm4IZN2BfEsH4yM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 5.10 147/294] x86/rfds: Mitigate Register File Data Sampling (RFDS)
Date: Thu, 11 Apr 2024 11:55:10 +0200
Message-ID: <20240411095440.078216580@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

commit 8076fcde016c9c0e0660543e67bff86cb48a7c9c upstream.

RFDS is a CPU vulnerability that may allow userspace to infer kernel
stale data previously used in floating point registers, vector registers
and integer registers. RFDS only affects certain Intel Atom processors.

Intel released a microcode update that uses VERW instruction to clear
the affected CPU buffers. Unlike MDS, none of the affected cores support
SMT.

Add RFDS bug infrastructure and enable the VERW based mitigation by
default, that clears the affected buffers just before exiting to
userspace. Also add sysfs reporting and cmdline parameter
"reg_file_data_sampling" to control the mitigation.

For details see:
Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst

  [ pawan: - Resolved conflicts in sysfs reporting.
	   - s/ATOM_GRACEMONT/ALDERLAKE_N/ATOM_GRACEMONT is called
	     ALDERLAKE_N in 6.6. ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    1 
 Documentation/admin-guide/kernel-parameters.txt    |   21 +++++
 arch/x86/Kconfig                                   |   11 ++
 arch/x86/include/asm/cpufeatures.h                 |    1 
 arch/x86/include/asm/msr-index.h                   |    8 ++
 arch/x86/kernel/cpu/bugs.c                         |   78 ++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c                       |   38 +++++++++-
 drivers/base/cpu.c                                 |    8 ++
 include/linux/cpu.h                                |    2 
 9 files changed, 162 insertions(+), 6 deletions(-)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -507,6 +507,7 @@ What:		/sys/devices/system/cpu/vulnerabi
 		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
 		/sys/devices/system/cpu/vulnerabilities/retbleed
 		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -993,6 +993,26 @@
 			The filter can be disabled or changed to another
 			driver later using sysfs.
 
+	reg_file_data_sampling=
+			[X86] Controls mitigation for Register File Data
+			Sampling (RFDS) vulnerability. RFDS is a CPU
+			vulnerability which may allow userspace to infer
+			kernel data values previously stored in floating point
+			registers, vector registers, or integer registers.
+			RFDS only affects Intel Atom processors.
+
+			on:	Turns ON the mitigation.
+			off:	Turns OFF the mitigation.
+
+			This parameter overrides the compile time default set
+			by CONFIG_MITIGATION_RFDS. Mitigation cannot be
+			disabled when other VERW based mitigations (like MDS)
+			are enabled. In order to disable RFDS mitigation all
+			VERW based mitigations need to be disabled.
+
+			For details see:
+			Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
+
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously.
 			Format: <driver_name1>,<driver_name2>...
@@ -2919,6 +2939,7 @@
 					       nopti [X86,PPC]
 					       nospectre_v1 [X86,PPC]
 					       nospectre_v2 [X86,PPC,S390,ARM64]
+					       reg_file_data_sampling=off [X86]
 					       retbleed=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
 					       spectre_v2_user=off [X86]
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2508,6 +2508,17 @@ config GDS_FORCE_MITIGATION
 
 	  If in doubt, say N.
 
+config MITIGATION_RFDS
+	bool "RFDS Mitigation"
+	depends on CPU_SUP_INTEL
+	default y
+	help
+	  Enable mitigation for Register File Data Sampling (RFDS) by default.
+	  RFDS is a hardware vulnerability which affects Intel Atom CPUs. It
+	  allows unprivileged speculative access to stale data previously
+	  stored in floating point, vector and integer registers.
+	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
+
 endif
 
 config ARCH_HAS_ADD_PAGES
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -454,4 +454,5 @@
 /* BUG word 2 */
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #endif /* _ASM_X86_CPUFEATURES_H */
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -168,6 +168,14 @@
 						 * CPU is not vulnerable to Gather
 						 * Data Sampling (GDS).
 						 */
+#define ARCH_CAP_RFDS_NO		BIT(27)	/*
+						 * Not susceptible to Register
+						 * File Data Sampling.
+						 */
+#define ARCH_CAP_RFDS_CLEAR		BIT(28)	/*
+						 * VERW clears CPU Register
+						 * File.
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -478,6 +478,57 @@ static int __init mmio_stale_data_parse_
 early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
 #undef pr_fmt
+#define pr_fmt(fmt)	"Register File Data Sampling: " fmt
+
+enum rfds_mitigations {
+	RFDS_MITIGATION_OFF,
+	RFDS_MITIGATION_VERW,
+	RFDS_MITIGATION_UCODE_NEEDED,
+};
+
+/* Default mitigation for Register File Data Sampling */
+static enum rfds_mitigations rfds_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_RFDS) ? RFDS_MITIGATION_VERW : RFDS_MITIGATION_OFF;
+
+static const char * const rfds_strings[] = {
+	[RFDS_MITIGATION_OFF]			= "Vulnerable",
+	[RFDS_MITIGATION_VERW]			= "Mitigation: Clear Register File",
+	[RFDS_MITIGATION_UCODE_NEEDED]		= "Vulnerable: No microcode",
+};
+
+static void __init rfds_select_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_RFDS) || cpu_mitigations_off()) {
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+		return;
+	}
+	if (rfds_mitigation == RFDS_MITIGATION_OFF)
+		return;
+
+	if (x86_read_arch_cap_msr() & ARCH_CAP_RFDS_CLEAR)
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+	else
+		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
+}
+
+static __init int rfds_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!boot_cpu_has_bug(X86_BUG_RFDS))
+		return 0;
+
+	if (!strcmp(str, "off"))
+		rfds_mitigation = RFDS_MITIGATION_OFF;
+	else if (!strcmp(str, "on"))
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+
+	return 0;
+}
+early_param("reg_file_data_sampling", rfds_parse_cmdline);
+
+#undef pr_fmt
 #define pr_fmt(fmt)     "" fmt
 
 static void __init md_clear_update_mitigation(void)
@@ -510,6 +561,11 @@ static void __init md_clear_update_mitig
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 		mmio_select_mitigation();
 	}
+	if (rfds_mitigation == RFDS_MITIGATION_OFF &&
+	    boot_cpu_has_bug(X86_BUG_RFDS)) {
+		rfds_mitigation = RFDS_MITIGATION_VERW;
+		rfds_select_mitigation();
+	}
 out:
 	if (boot_cpu_has_bug(X86_BUG_MDS))
 		pr_info("MDS: %s\n", mds_strings[mds_mitigation]);
@@ -519,6 +575,8 @@ out:
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
 	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
 		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
+	if (boot_cpu_has_bug(X86_BUG_RFDS))
+		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
 
 static void __init md_clear_select_mitigation(void)
@@ -526,11 +584,12 @@ static void __init md_clear_select_mitig
 	mds_select_mitigation();
 	taa_select_mitigation();
 	mmio_select_mitigation();
+	rfds_select_mitigation();
 
 	/*
-	 * As MDS, TAA and MMIO Stale Data mitigations are inter-related, update
-	 * and print their mitigation after MDS, TAA and MMIO Stale Data
-	 * mitigation selection is done.
+	 * As these mitigations are inter-related and rely on VERW instruction
+	 * to clear the microarchitural buffers, update and print their status
+	 * after mitigation selection is done for each of these vulnerabilities.
 	 */
 	md_clear_update_mitigation();
 }
@@ -2530,6 +2589,11 @@ static ssize_t mmio_stale_data_show_stat
 			  sched_smt_active() ? "vulnerable" : "disabled");
 }
 
+static ssize_t rfds_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
@@ -2690,6 +2754,9 @@ static ssize_t cpu_show_common(struct de
 	case X86_BUG_SRSO:
 		return srso_show_state(buf);
 
+	case X86_BUG_RFDS:
+		return rfds_show_state(buf);
+
 	default:
 		break;
 	}
@@ -2764,4 +2831,9 @@ ssize_t cpu_show_spec_rstack_overflow(st
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SRSO);
 }
+
+ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
+}
 #endif
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1132,6 +1132,8 @@ static const __initconst struct x86_cpu_
 #define SRSO		BIT(5)
 /* CPU is affected by GDS */
 #define GDS		BIT(6)
+/* CPU is affected by Register File Data Sampling */
+#define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1159,9 +1161,18 @@ static const struct x86_cpu_id cpu_vuln_
 	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_N,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT_D,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ATOM_GOLDMONT_PLUS, X86_STEPPING_ANY,		RFDS),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
@@ -1195,6 +1206,24 @@ static bool arch_cap_mmio_immune(u64 ia3
 		ia32_cap & ARCH_CAP_SBDR_SSDP_NO);
 }
 
+static bool __init vulnerable_to_rfds(u64 ia32_cap)
+{
+	/* The "immunity" bit trumps everything else: */
+	if (ia32_cap & ARCH_CAP_RFDS_NO)
+		return false;
+
+	/*
+	 * VMMs set ARCH_CAP_RFDS_CLEAR for processors not in the blacklist to
+	 * indicate that mitigation is needed because guest is running on a
+	 * vulnerable hardware or may migrate to such hardware:
+	 */
+	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+		return true;
+
+	/* Only consult the blacklist when there is no enumeration: */
+	return cpu_matches(cpu_vuln_blacklist, RFDS);
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = x86_read_arch_cap_msr();
@@ -1303,6 +1332,9 @@ static void __init cpu_set_bug_bits(stru
 			setup_force_cpu_bug(X86_BUG_SRSO);
 	}
 
+	if (vulnerable_to_rfds(ia32_cap))
+		setup_force_cpu_bug(X86_BUG_RFDS);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -591,6 +591,12 @@ ssize_t __weak cpu_show_spec_rstack_over
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_reg_file_data_sampling(struct device *dev,
+					       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -604,6 +610,7 @@ static DEVICE_ATTR(mmio_stale_data, 0444
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
+static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -619,6 +626,7 @@ static struct attribute *cpu_root_vulner
 	&dev_attr_retbleed.attr,
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_spec_rstack_overflow.attr,
+	&dev_attr_reg_file_data_sampling.attr,
 	NULL
 };
 
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -74,6 +74,8 @@ extern ssize_t cpu_show_spec_rstack_over
 					     struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
+					       struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,



