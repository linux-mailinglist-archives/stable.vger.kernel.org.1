Return-Path: <stable+bounces-27505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A7879B2E
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6589D1C225E6
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB413959A;
	Tue, 12 Mar 2024 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0Mfsg3J"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE8139585
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267450; cv=none; b=NyUO2XiB3+8CK+qGc5oHIZwrjZee99XII4ElVSzYsXwMtvH2mBK6GgHFxPG4ooD4OcOn78qPPvozqtO4tfG43zS+IzHgcr5Hvfx7zYiB46SBy+Bpip8hMvCrFfJpgTRNhrtqepsOZVwmyiDe+vkSroE1ajUpdi13/MkLkdHIAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267450; c=relaxed/simple;
	bh=7ZcQjdMBL4SIZdEYSWvBZIJyUjBY9wFgSNIHgPgEp3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POwlhqMpB3WgVbqGP2pvgfTnPsEAkjcvsBnK7M1VjW9JV1WeEmiJ2Ldnc9yknCPJBvnac9ePfqT3B+JD19leWFErm7Cu8S19gB8xM2z23y8XLQfESlcKGjYUEKyPpp3dKtV/iwjhSVVsyHa15aD0vnNg6mZZEK7nVSmXL2fM6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V0Mfsg3J; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710267449; x=1741803449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ZcQjdMBL4SIZdEYSWvBZIJyUjBY9wFgSNIHgPgEp3Q=;
  b=V0Mfsg3JG478d4nY1UTRZH6pBxo+d4RPiiyrWY0haZNN7CRKBvIyRMWv
   pIZQZxvSlmJvhEIrfgEuNG9YM0mbswBpXEWga7pbkW14GYbXMOz22IIVQ
   47zek9eexi8566n8IzuJeJp+mrS+1/0s51qieFnrnCJA7Oo7z8Agx3d+d
   U1AJly47o1F2qYhVVIT9YibowmO25VO4PF694NlA8pN08+UgM6MQwrUeO
   V5m5S8OYutmflt4i2dqK8euTxu9TF7ONP+VvF7Umin0Q/bld2FzFWqn5M
   oyJpBTkZ27fjtzexRTfaFXc8ocOP9/jvFqCFRduisVBKk01EG3xdDz87D
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4853375"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4853375"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:17:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11676186"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:17:27 -0700
Date: Tue, 12 Mar 2024 11:17:26 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 3/4] x86/rfds: Mitigate Register File Data Sampling (RFDS)
Message-ID: <20240312-rfds-backport-6-1-y-v1-3-31cae244c4de@linux.intel.com>
X-Mailer: b4 0.12.3
References: <20240312-rfds-backport-6-1-y-v1-0-31cae244c4de@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-rfds-backport-6-1-y-v1-0-31cae244c4de@linux.intel.com>

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
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  1 +
 Documentation/admin-guide/kernel-parameters.txt    | 21 ++++++
 arch/x86/Kconfig                                   | 11 +++
 arch/x86/include/asm/cpufeatures.h                 |  1 +
 arch/x86/include/asm/msr-index.h                   |  8 +++
 arch/x86/kernel/cpu/bugs.c                         | 78 +++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c                       | 38 ++++++++++-
 drivers/base/cpu.c                                 |  8 +++
 include/linux/cpu.h                                |  2 +
 9 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 13c01b641dc7..78c26280c473 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -519,6 +519,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
 		/sys/devices/system/cpu/vulnerabilities/retbleed
 		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4ad60e127e04..2dfe75104e7d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1107,6 +1107,26 @@
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
 			List of driver names to be probed asynchronously. *
 			matches with all driver names. If * is specified, the
@@ -3262,6 +3282,7 @@
 					       nospectre_bhb [ARM64]
 					       nospectre_v1 [X86,PPC]
 					       nospectre_v2 [X86,PPC,S390,ARM64]
+					       reg_file_data_sampling=off [X86]
 					       retbleed=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
 					       spectre_v2_user=off [X86]
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2f7af61b49b6..5caa023e9839 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2565,6 +2565,17 @@ config GDS_FORCE_MITIGATION
 
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
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index b60f24b30cb9..b97a70aa4de9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -477,4 +477,5 @@
 /* BUG word 2 */
 #define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
 #define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ec955ab2ff03..005e41dc7ee5 100644
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
 
 #define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
 						 * IA32_XAPIC_DISABLE_STATUS MSR
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c66f6eb40afb..c68789fdc123 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -479,6 +479,57 @@ static int __init mmio_stale_data_parse_cmdline(char *str)
 }
 early_param("mmio_stale_data", mmio_stale_data_parse_cmdline);
 
+#undef pr_fmt
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
 #undef pr_fmt
 #define pr_fmt(fmt)     "" fmt
 
@@ -512,6 +563,11 @@ static void __init md_clear_update_mitigation(void)
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
@@ -521,6 +577,8 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
 	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
 		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
+	if (boot_cpu_has_bug(X86_BUG_RFDS))
+		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
 
 static void __init md_clear_select_mitigation(void)
@@ -528,11 +586,12 @@ static void __init md_clear_select_mitigation(void)
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
@@ -2596,6 +2655,11 @@ static ssize_t mmio_stale_data_show_state(char *buf)
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
@@ -2757,6 +2821,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_SRSO:
 		return srso_show_state(buf);
 
+	case X86_BUG_RFDS:
+		return rfds_show_state(buf);
+
 	default:
 		break;
 	}
@@ -2831,4 +2898,9 @@ ssize_t cpu_show_spec_rstack_overflow(struct device *dev, struct device_attribut
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SRSO);
 }
+
+ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 454cdf341862..758938c94b41 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1248,6 +1248,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define SRSO		BIT(5)
 /* CPU is affected by GDS */
 #define GDS		BIT(6)
+/* CPU is affected by Register File Data Sampling */
+#define RFDS		BIT(7)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1275,9 +1277,18 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
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
@@ -1311,6 +1322,24 @@ static bool arch_cap_mmio_immune(u64 ia32_cap)
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
@@ -1419,6 +1448,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 			setup_force_cpu_bug(X86_BUG_SRSO);
 	}
 
+	if (vulnerable_to_rfds(ia32_cap))
+		setup_force_cpu_bug(X86_BUG_RFDS);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index dab70a65377c..31da94afe4f3 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -589,6 +589,12 @@ ssize_t __weak cpu_show_spec_rstack_overflow(struct device *dev,
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
@@ -602,6 +608,7 @@ static DEVICE_ATTR(mmio_stale_data, 0444, cpu_show_mmio_stale_data, NULL);
 static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
+static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -617,6 +624,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_retbleed.attr,
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_spec_rstack_overflow.attr,
+	&dev_attr_reg_file_data_sampling.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 008bfa68cfab..4b06b1f1e267 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -74,6 +74,8 @@ extern ssize_t cpu_show_spec_rstack_overflow(struct device *dev,
 					     struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
+					       struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,

-- 
2.34.1



