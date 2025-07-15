Return-Path: <stable+bounces-161969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2CB05A5E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386AC4A303C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9182E040D;
	Tue, 15 Jul 2025 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2ieCCCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2C92E03F5
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583076; cv=none; b=BeFEWdeIp+HYAfbSTlUIonBXOR24c5M5/iTxsLMoqWoMnVOApm7Fjx0ENcCK0LLIoLGnUC+Y8gai1Igtas7zav43IBF9gHPo7xnE+LZ0FthVIbYifXs4rdhI/tFIQgb7NjtBBrYvjRBiGtuqVPlbBHSSwStQBhDAXBUvA9nj8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583076; c=relaxed/simple;
	bh=0G8/xvkH6jbnlZRJkmMSNAIdd0p6ylehtMZJeW439ak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1yL7Lq6QtAbkVivtfHoGCeSZ0mOrSh7pqYDdfFNGcLZNAgcckIGVkZ60YZzwKJwYJ1HwtDT5xwnveHss3bqAVsajyxPiF3ivH68Qa78M9dhNSqF5cBndUdVOus5YYoaeV3DlSIq+LZBOAmgsPe4USen0S0XlfVSgecV/5M5FIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2ieCCCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E38C4CEE3;
	Tue, 15 Jul 2025 12:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583075;
	bh=0G8/xvkH6jbnlZRJkmMSNAIdd0p6ylehtMZJeW439ak=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q2ieCCCY77NLnfPjkmMkDWmEHCvzmIBHqw0stpDSAgZIfUc1IqR6NgFBfDRVJIpO8
	 r8xSzB0az81w1O5tpkq8HRQiyr1QytZ1/qG/jTQVR8FBrdg5k+5DHoBKgmNDMgJo73
	 Hn7njNRbzIpLts9VaDusvYE9+E3WkqrTEfahGMpEsl1MJmtsPd4/Lw3b1CpGl0YfCY
	 U4+f87iIIuIRUXUJZ+xqjb80wvwbOuWonHuw7A0+z2e7OAtZZ5XLhRYiKjRNxTlnY/
	 Dr4i8L7NBKmjrtnJKW+vdoI918Gjk0zY2ML4m+m1tMCojRgWIQaIkL/Vnr3OjOuNhA
	 Fp/k85jwAyGFA==
From: Borislav Petkov <bp@kernel.org>
To: <stable@vger.kernel.org>
Subject: [PATCH 2/5] x86/bugs: Add a Transient Scheduler Attacks mitigation
Date: Tue, 15 Jul 2025 14:37:46 +0200
Message-ID: <20250715123749.4610-3-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715123749.4610-1-bp@kernel.org>
References: <20250715123749.4610-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit d8010d4ba43e9f790925375a7de100604a5e2dba upstream.

Add the required features detection glue to bugs.c et all in order to
support the TSA mitigation.

Co-developed-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      |   1 +
 .../admin-guide/kernel-parameters.txt         |  13 ++
 arch/x86/Kconfig                              |   9 ++
 arch/x86/include/asm/cpu.h                    |  13 ++
 arch/x86/include/asm/cpufeatures.h            |   6 +
 arch/x86/include/asm/mwait.h                  |   2 +-
 arch/x86/include/asm/nospec-branch.h          |  12 +-
 arch/x86/kernel/cpu/amd.c                     |  58 +++++++++
 arch/x86/kernel/cpu/bugs.c                    | 121 ++++++++++++++++++
 arch/x86/kernel/cpu/common.c                  |  14 +-
 arch/x86/kernel/cpu/scattered.c               |   2 +
 arch/x86/kvm/svm/vmenter.S                    |   3 +
 drivers/base/cpu.c                            |   2 +
 include/linux/cpu.h                           |   1 +
 14 files changed, 252 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2a273bfebed0..c5042cd35302 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -513,6 +513,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
 		/sys/devices/system/cpu/vulnerabilities/srbds
+		/sys/devices/system/cpu/vulnerabilities/tsa
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 12af5b0ecc8e..d48fe8abdddd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5601,6 +5601,19 @@
 			See Documentation/admin-guide/mm/transhuge.rst
 			for more details.
 
+	tsa=		[X86] Control mitigation for Transient Scheduler
+			Attacks on AMD CPUs. Search the following in your
+			favourite search engine for more details:
+
+			"Technical guidance for mitigating transient scheduler
+			attacks".
+
+			off		- disable the mitigation
+			on		- enable the mitigation (default)
+			user		- mitigate only user/kernel transitions
+			vm		- mitigate only guest/host transitions
+
+
 	tsc=		Disable clocksource stability checks for TSC.
 			Format: <string>
 			[x86] reliable: mark tsc clocksource as reliable, this
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 93a1f9937a9b..4a33cb01ce1b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2521,6 +2521,15 @@ config MITIGATION_RFDS
 	  stored in floating point, vector and integer registers.
 	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
 
+config MITIGATION_TSA
+	bool "Mitigate Transient Scheduler Attacks"
+	depends on CPU_SUP_AMD
+	default y
+	help
+	  Enable mitigation for Transient Scheduler Attacks. TSA is a hardware
+	  security vulnerability on AMD CPUs which can lead to forwarding of
+	  invalid info to subsequent instructions and thus can affect their
+	  timing and thereby cause a leakage.
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index da78ccbd493b..96ed5f1ceef5 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -63,4 +63,17 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
 #else
 static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
 #endif
+
+union zen_patch_rev {
+	struct {
+		__u32 rev	 : 8,
+		      stepping	 : 4,
+		      model	 : 4,
+		      __reserved : 4,
+		      ext_model	 : 4,
+		      ext_fam	 : 8;
+	};
+	__u32 ucode_rev;
+};
+
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3365ec97376..9dafd0c64d25 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -406,11 +406,16 @@
 #define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
 
+#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* "" The memory form of VERW mitigates TSA */
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
 #define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+#define X86_FEATURE_TSA_SQ_NO          (21*32+11) /* "" AMD CPU not vulnerable to TSA-SQ */
+#define X86_FEATURE_TSA_L1_NO          (21*32+12) /* "" AMD CPU not vulnerable to TSA-L1 */
+#define X86_FEATURE_CLEAR_CPU_BUF_VM   (21*32+13) /* "" Clear CPU buffers using VERW before VMRUN */
+
 /*
  * BUG word(s)
  */
@@ -459,4 +464,5 @@
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET		X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_TSA			X86_BUG(1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index 35e20e8a7cc6..20b33e6370c3 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -79,7 +79,7 @@ static inline void __mwait(unsigned long eax, unsigned long ecx)
 static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 			    unsigned long ecx)
 {
-	/* No MDS buffer clear as this is AMD/HYGON only */
+	/* No need for TSA buffer clearing on AMD */
 
 	/* "mwaitx %eax, %ebx, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xfb;"
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 432506c0f16e..ece41d3aad16 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -197,8 +197,8 @@
  * CFLAGS.ZF.
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
-.macro CLEAR_CPU_BUFFERS
-	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
+.macro __CLEAR_CPU_BUFFERS feature
+	ALTERNATIVE "jmp .Lskip_verw_\@", "", \feature
 #ifdef CONFIG_X86_64
 	verw x86_verw_sel(%rip)
 #else
@@ -212,6 +212,12 @@
 .Lskip_verw_\@:
 .endm
 
+#define CLEAR_CPU_BUFFERS \
+	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF
+
+#define VM_CLEAR_CPU_BUFFERS \
+	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF_VM
+
 #else /* __ASSEMBLY__ */
 
 #define ANNOTATE_RETPOLINE_SAFE					\
@@ -420,7 +426,7 @@ static __always_inline void x86_clear_cpu_buffers(void)
 
 /**
  * x86_idle_clear_cpu_buffers - Buffer clearing support in idle for the MDS
- * vulnerability
+ * and TSA vulnerabilities.
  *
  * Clear CPU buffers if the corresponding static key is enabled
  */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5f0bdb53b006..e67d7603449b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -589,6 +589,62 @@ static void early_init_amd_mc(struct cpuinfo_x86 *c)
 #endif
 }
 
+static bool amd_check_tsa_microcode(void)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	union zen_patch_rev p;
+	u32 min_rev = 0;
+
+	p.ext_fam	= c->x86 - 0xf;
+	p.model		= c->x86_model;
+	p.ext_model	= c->x86_model >> 4;
+	p.stepping	= c->x86_stepping;
+
+	if (c->x86 == 0x19) {
+		switch (p.ucode_rev >> 8) {
+		case 0xa0011:	min_rev = 0x0a0011d7; break;
+		case 0xa0012:	min_rev = 0x0a00123b; break;
+		case 0xa0082:	min_rev = 0x0a00820d; break;
+		case 0xa1011:	min_rev = 0x0a10114c; break;
+		case 0xa1012:	min_rev = 0x0a10124c; break;
+		case 0xa1081:	min_rev = 0x0a108109; break;
+		case 0xa2010:	min_rev = 0x0a20102e; break;
+		case 0xa2012:	min_rev = 0x0a201211; break;
+		case 0xa4041:	min_rev = 0x0a404108; break;
+		case 0xa5000:	min_rev = 0x0a500012; break;
+		case 0xa6012:	min_rev = 0x0a60120a; break;
+		case 0xa7041:	min_rev = 0x0a704108; break;
+		case 0xa7052:	min_rev = 0x0a705208; break;
+		case 0xa7080:	min_rev = 0x0a708008; break;
+		case 0xa70c0:	min_rev = 0x0a70c008; break;
+		case 0xaa002:	min_rev = 0x0aa00216; break;
+		default:
+			pr_debug("%s: ucode_rev: 0x%x, current revision: 0x%x\n",
+				 __func__, p.ucode_rev, c->microcode);
+			return false;
+		}
+	}
+
+	if (!min_rev)
+		return false;
+
+	return c->microcode >= min_rev;
+}
+
+static void tsa_init(struct cpuinfo_x86 *c)
+{
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return;
+
+	if (c->x86 == 0x19) {
+		if (amd_check_tsa_microcode())
+			setup_force_cpu_cap(X86_FEATURE_VERW_CLEAR);
+	} else {
+		setup_force_cpu_cap(X86_FEATURE_TSA_SQ_NO);
+		setup_force_cpu_cap(X86_FEATURE_TSA_L1_NO);
+	}
+}
+
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
 
@@ -676,6 +732,8 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	}
 
 	resctrl_cpu_detect(c);
+
+	tsa_init(c);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb9b6e7fed20..7a67d7a6c292 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -47,6 +47,7 @@ static void __init mmio_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init srso_select_mitigation(void);
+static void __init tsa_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -161,6 +162,7 @@ void __init cpu_select_mitigations(void)
 	 */
 	srso_select_mitigation();
 	gds_select_mitigation();
+	tsa_select_mitigation();
 }
 
 /*
@@ -1817,6 +1819,94 @@ static void update_mds_branch_idle(void)
 #define TAA_MSG_SMT "TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.\n"
 #define MMIO_MSG_SMT "MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.\n"
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"Transient Scheduler Attacks: " fmt
+
+enum tsa_mitigations {
+	TSA_MITIGATION_NONE,
+	TSA_MITIGATION_UCODE_NEEDED,
+	TSA_MITIGATION_USER_KERNEL,
+	TSA_MITIGATION_VM,
+	TSA_MITIGATION_FULL,
+};
+
+static const char * const tsa_strings[] = {
+	[TSA_MITIGATION_NONE]		= "Vulnerable",
+	[TSA_MITIGATION_UCODE_NEEDED]	= "Vulnerable: Clear CPU buffers attempted, no microcode",
+	[TSA_MITIGATION_USER_KERNEL]	= "Mitigation: Clear CPU buffers: user/kernel boundary",
+	[TSA_MITIGATION_VM]		= "Mitigation: Clear CPU buffers: VM",
+	[TSA_MITIGATION_FULL]		= "Mitigation: Clear CPU buffers",
+};
+
+static enum tsa_mitigations tsa_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_TSA) ? TSA_MITIGATION_FULL : TSA_MITIGATION_NONE;
+
+static int __init tsa_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off"))
+		tsa_mitigation = TSA_MITIGATION_NONE;
+	else if (!strcmp(str, "on"))
+		tsa_mitigation = TSA_MITIGATION_FULL;
+	else if (!strcmp(str, "user"))
+		tsa_mitigation = TSA_MITIGATION_USER_KERNEL;
+	else if (!strcmp(str, "vm"))
+		tsa_mitigation = TSA_MITIGATION_VM;
+	else
+		pr_err("Ignoring unknown tsa=%s option.\n", str);
+
+	return 0;
+}
+early_param("tsa", tsa_parse_cmdline);
+
+static void __init tsa_select_mitigation(void)
+{
+	if (tsa_mitigation == TSA_MITIGATION_NONE)
+		return;
+
+	if (cpu_mitigations_off() || !boot_cpu_has_bug(X86_BUG_TSA)) {
+		tsa_mitigation = TSA_MITIGATION_NONE;
+		return;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_VERW_CLEAR))
+		tsa_mitigation = TSA_MITIGATION_UCODE_NEEDED;
+
+	switch (tsa_mitigation) {
+	case TSA_MITIGATION_USER_KERNEL:
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+		break;
+
+	case TSA_MITIGATION_VM:
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF_VM);
+		break;
+
+	case TSA_MITIGATION_UCODE_NEEDED:
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			goto out;
+
+		pr_notice("Forcing mitigation on in a VM\n");
+
+		/*
+		 * On the off-chance that microcode has been updated
+		 * on the host, enable the mitigation in the guest just
+		 * in case.
+		 */
+		fallthrough;
+	case TSA_MITIGATION_FULL:
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
+		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF_VM);
+		break;
+	default:
+		break;
+	}
+
+out:
+	pr_info("%s\n", tsa_strings[tsa_mitigation]);
+}
+
 void cpu_bugs_smt_update(void)
 {
 	mutex_lock(&spec_ctrl_mutex);
@@ -1870,6 +1960,24 @@ void cpu_bugs_smt_update(void)
 		break;
 	}
 
+	switch (tsa_mitigation) {
+	case TSA_MITIGATION_USER_KERNEL:
+	case TSA_MITIGATION_VM:
+	case TSA_MITIGATION_FULL:
+	case TSA_MITIGATION_UCODE_NEEDED:
+		/*
+		 * TSA-SQ can potentially lead to info leakage between
+		 * SMT threads.
+		 */
+		if (sched_smt_active())
+			static_branch_enable(&cpu_buf_idle_clear);
+		else
+			static_branch_disable(&cpu_buf_idle_clear);
+		break;
+	case TSA_MITIGATION_NONE:
+		break;
+	}
+
 	mutex_unlock(&spec_ctrl_mutex);
 }
 
@@ -2746,6 +2854,11 @@ static ssize_t srso_show_state(char *buf)
 			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
 }
 
+static ssize_t tsa_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", tsa_strings[tsa_mitigation]);
+}
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -2804,6 +2917,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_RFDS:
 		return rfds_show_state(buf);
 
+	case X86_BUG_TSA:
+		return tsa_show_state(buf);
+
 	default:
 		break;
 	}
@@ -2883,4 +2999,9 @@ ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attrib
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
 }
+
+ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_TSA);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 840fdffec850..a15daefeba0e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1134,6 +1134,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define GDS		BIT(6)
 /* CPU is affected by Register File Data Sampling */
 #define RFDS		BIT(7)
+/* CPU is affected by Transient Scheduler Attacks */
+#define TSA		BIT(10)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
@@ -1178,7 +1180,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SRSO),
 	VULNBL_HYGON(0x18, RETBLEED | SRSO),
-	VULNBL_AMD(0x19, SRSO),
+	VULNBL_AMD(0x19, SRSO | TSA),
 	{}
 };
 
@@ -1338,6 +1340,16 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB) && !cpu_has(c, X86_FEATURE_AMD_IBPB_RET))
 		setup_force_cpu_bug(X86_BUG_IBPB_NO_RET);
 
+	if (c->x86_vendor == X86_VENDOR_AMD) {
+		if (!cpu_has(c, X86_FEATURE_TSA_SQ_NO) ||
+		    !cpu_has(c, X86_FEATURE_TSA_L1_NO)) {
+			if (cpu_matches(cpu_vuln_blacklist, TSA) ||
+			    /* Enable bug on Zen guests to allow for live migration. */
+			    (cpu_has(c, X86_FEATURE_HYPERVISOR) && cpu_has(c, X86_FEATURE_ZEN)))
+				setup_force_cpu_bug(X86_BUG_TSA);
+		}
+	}
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index f1cd1b6fb99e..55c192c3be80 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -41,6 +41,8 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
 	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_TSA_SQ_NO,	CPUID_ECX,  1, 0x80000021, 0 },
+	{ X86_FEATURE_TSA_L1_NO,	CPUID_ECX,  2, 0x80000021, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index a8859c173258..c3ec69f94b45 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -77,6 +77,9 @@ SYM_FUNC_START(__svm_vcpu_run)
 	/* "POP" @vmcb to RAX. */
 	pop %_ASM_AX
 
+	/* Clobbers EFLAGS.ZF */
+	VM_CLEAR_CPU_BUFFERS
+
 	/* Enter guest mode */
 	sti
 1:	vmload %_ASM_AX
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index e3aed8333f09..04c43b95f503 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -611,6 +611,7 @@ static DEVICE_ATTR(retbleed, 0444, cpu_show_retbleed, NULL);
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NULL);
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
+static DEVICE_ATTR(tsa, 0444, cpu_show_tsa, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -627,6 +628,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_spec_rstack_overflow.attr,
 	&dev_attr_reg_file_data_sampling.attr,
+	&dev_attr_tsa.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 2099226d8623..af080af7ad83 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -76,6 +76,7 @@ extern ssize_t cpu_show_gds(struct device *dev,
 			    struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 					       struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
-- 
2.43.0


