Return-Path: <stable+bounces-161154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DEBAFD3A1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14434816E1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF52DC34C;
	Tue,  8 Jul 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wKtpjbhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620518F5E;
	Tue,  8 Jul 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993751; cv=none; b=JgvOYQExoCis/+TM3KpKNLxw2xzEqgKp0xUxMiU3zv80h8tYsTKS+1EUInpGlh7ZPViBDw1BUYhEBapJ26BrDC8fSJb8X40a+R2yXZy7ib1YNCUeLkBb5qziAcOvKfmW4c3acD89UzKBGKjg6SZbjm1R61da1zY+/AwUTd6F3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993751; c=relaxed/simple;
	bh=H8GJXtuRtAgiH0tABw6SiCTMu5iUBR4SUXA4QE7W3BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsqJMVi96GsbfkMmrzLpIx27MgensvbU48qbeEnrSHzw90pLa0RwJhO2Y/+S9RKKmkWqqN1PYZ2g3162R4Sqsdcst1NQLYR6dxJ7WFYtrxBuLeYOF/Lf+uCy7anxnQkDFpXeLN6ckFo51yC5G55IrprCLTSt/qoJPr1k6g9xhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wKtpjbhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB95C4CEED;
	Tue,  8 Jul 2025 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993751;
	bh=H8GJXtuRtAgiH0tABw6SiCTMu5iUBR4SUXA4QE7W3BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wKtpjbhGSkXU/JbNrOwIT5SRq0iCKpb/2Id+9DE+EPjLdVC9KNeAkoe9NaRhZ1PKs
	 k4iSxGKTcjJxeh4dBTa+61fDKn4dyunUurCsDls0H5L7aKt/P3L+7j2xemVsgP2ZjJ
	 DNt+lcBNUEvNNWfbzX5si7gNWTYsURU48UBzLGiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kim Phillips <kim.phillips@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 6.15 174/178] x86/bugs: Add a Transient Scheduler Attacks mitigation
Date: Tue,  8 Jul 2025 18:23:31 +0200
Message-ID: <20250708162240.993483371@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit d8010d4ba43e9f790925375a7de100604a5e2dba upstream.

Add the required features detection glue to bugs.c et all in order to
support the TSA mitigation.

Co-developed-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    1 
 Documentation/admin-guide/kernel-parameters.txt    |   13 ++
 arch/x86/Kconfig                                   |    9 +
 arch/x86/include/asm/cpufeatures.h                 |    5 
 arch/x86/include/asm/mwait.h                       |    2 
 arch/x86/include/asm/nospec-branch.h               |   14 +-
 arch/x86/kernel/cpu/amd.c                          |   44 +++++++
 arch/x86/kernel/cpu/bugs.c                         |  121 +++++++++++++++++++++
 arch/x86/kernel/cpu/common.c                       |   14 ++
 arch/x86/kernel/cpu/scattered.c                    |    2 
 arch/x86/kvm/svm/vmenter.S                         |    6 +
 drivers/base/cpu.c                                 |    3 
 include/linux/cpu.h                                |    1 
 13 files changed, 229 insertions(+), 6 deletions(-)

--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -523,6 +523,7 @@ What:		/sys/devices/system/cpu/vulnerabi
 		/sys/devices/system/cpu/vulnerabilities/spectre_v1
 		/sys/devices/system/cpu/vulnerabilities/spectre_v2
 		/sys/devices/system/cpu/vulnerabilities/srbds
+		/sys/devices/system/cpu/vulnerabilities/tsa
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7423,6 +7423,19 @@
 			having this key zero'ed is acceptable. E.g. in testing
 			scenarios.
 
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
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2723,6 +2723,15 @@ config MITIGATION_ITS
 	  disabled, mitigation cannot be enabled via cmdline.
 	  See <file:Documentation/admin-guide/hw-vuln/indirect-target-selection.rst>
 
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
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -453,6 +453,7 @@
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
 #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
+#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW mitigates TSA */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* Automatic IBRS */
 #define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* SMM_CTL MSR is not present */
@@ -482,6 +483,9 @@
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
 #define X86_FEATURE_PREFER_YMM		(21*32 + 8) /* Avoid ZMM registers due to downclocking */
 #define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32 + 9) /* Use thunk for indirect branches in lower half of cacheline */
+#define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
+#define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
+#define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
 
 /*
  * BUG word(s)
@@ -536,4 +540,5 @@
 #define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
 #define X86_BUG_ITS			X86_BUG(1*32 + 6) /* "its" CPU is affected by Indirect Target Selection */
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 7) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
+#define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #endif /* _ASM_X86_CPUFEATURES_H */
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -79,7 +79,7 @@ static __always_inline void __mwait(unsi
 static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
 				     unsigned long ecx)
 {
-	/* No MDS buffer clear as this is AMD/HYGON only */
+	/* No need for TSA buffer clearing on AMD */
 
 	/* "mwaitx %eax, %ebx, %ecx;" */
 	asm volatile(".byte 0x0f, 0x01, 0xfb;"
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -308,19 +308,25 @@
  * CFLAGS.ZF.
  * Note: Only the memory operand variant of VERW clears the CPU buffers.
  */
-.macro CLEAR_CPU_BUFFERS
+.macro __CLEAR_CPU_BUFFERS feature
 #ifdef CONFIG_X86_64
-	ALTERNATIVE "", "verw x86_verw_sel(%rip)", X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", "verw x86_verw_sel(%rip)", \feature
 #else
 	/*
 	 * In 32bit mode, the memory operand must be a %cs reference. The data
 	 * segments may not be usable (vm86 mode), and the stack segment may not
 	 * be flat (ESPFIX32).
 	 */
-	ALTERNATIVE "", "verw %cs:x86_verw_sel", X86_FEATURE_CLEAR_CPU_BUF
+	ALTERNATIVE "", "verw %cs:x86_verw_sel", \feature
 #endif
 .endm
 
+#define CLEAR_CPU_BUFFERS \
+	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF
+
+#define VM_CLEAR_CPU_BUFFERS \
+	__CLEAR_CPU_BUFFERS X86_FEATURE_CLEAR_CPU_BUF_VM
+
 #ifdef CONFIG_X86_64
 .macro CLEAR_BRANCH_HISTORY
 	ALTERNATIVE "", "call clear_bhb_loop", X86_FEATURE_CLEAR_BHB_LOOP
@@ -602,7 +608,7 @@ static __always_inline void x86_clear_cp
 
 /**
  * x86_idle_clear_cpu_buffers - Buffer clearing support in idle for the MDS
- * vulnerability
+ * and TSA vulnerabilities.
  *
  * Clear CPU buffers if the corresponding static key is enabled
  */
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -375,6 +375,47 @@ static void bsp_determine_snp(struct cpu
 #endif
 }
 
+#define ZEN_MODEL_STEP_UCODE(fam, model, step, ucode) \
+	X86_MATCH_VFM_STEPS(VFM_MAKE(X86_VENDOR_AMD, fam, model), \
+			    step, step, ucode)
+
+static const struct x86_cpu_id amd_tsa_microcode[] = {
+	ZEN_MODEL_STEP_UCODE(0x19, 0x01, 0x1, 0x0a0011d7),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x01, 0x2, 0x0a00123b),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x08, 0x2, 0x0a00820d),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x11, 0x1, 0x0a10114c),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x11, 0x2, 0x0a10124c),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x18, 0x1, 0x0a108109),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x21, 0x0, 0x0a20102e),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x21, 0x2, 0x0a201211),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x44, 0x1, 0x0a404108),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x50, 0x0, 0x0a500012),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x61, 0x2, 0x0a60120a),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x74, 0x1, 0x0a704108),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x75, 0x2, 0x0a705208),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x78, 0x0, 0x0a708008),
+	ZEN_MODEL_STEP_UCODE(0x19, 0x7c, 0x0, 0x0a70c008),
+	ZEN_MODEL_STEP_UCODE(0x19, 0xa0, 0x2, 0x0aa00216),
+	{},
+};
+
+static void tsa_init(struct cpuinfo_x86 *c)
+{
+	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
+		return;
+
+	if (cpu_has(c, X86_FEATURE_ZEN3) ||
+	    cpu_has(c, X86_FEATURE_ZEN4)) {
+		if (x86_match_min_microcode_rev(amd_tsa_microcode))
+			setup_force_cpu_cap(X86_FEATURE_VERW_CLEAR);
+		else
+			pr_debug("%s: current revision: 0x%x\n", __func__, c->microcode);
+	} else {
+		setup_force_cpu_cap(X86_FEATURE_TSA_SQ_NO);
+		setup_force_cpu_cap(X86_FEATURE_TSA_L1_NO);
+	}
+}
+
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -487,6 +528,9 @@ static void bsp_init_amd(struct cpuinfo_
 	}
 
 	bsp_determine_snp(c);
+
+	tsa_init(c);
+
 	return;
 
 warn:
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -50,6 +50,7 @@ static void __init l1d_flush_select_miti
 static void __init srso_select_mitigation(void);
 static void __init gds_select_mitigation(void);
 static void __init its_select_mitigation(void);
+static void __init tsa_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -188,6 +189,7 @@ void __init cpu_select_mitigations(void)
 	srso_select_mitigation();
 	gds_select_mitigation();
 	its_select_mitigation();
+	tsa_select_mitigation();
 }
 
 /*
@@ -2074,6 +2076,94 @@ static void update_mds_branch_idle(void)
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
@@ -2130,6 +2220,24 @@ void cpu_bugs_smt_update(void)
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
 
@@ -3078,6 +3186,11 @@ static ssize_t gds_show_state(char *buf)
 	return sysfs_emit(buf, "%s\n", gds_strings[gds_mitigation]);
 }
 
+static ssize_t tsa_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", tsa_strings[tsa_mitigation]);
+}
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -3139,6 +3252,9 @@ static ssize_t cpu_show_common(struct de
 	case X86_BUG_ITS:
 		return its_show_state(buf);
 
+	case X86_BUG_TSA:
+		return tsa_show_state(buf);
+
 	default:
 		break;
 	}
@@ -3223,6 +3339,11 @@ ssize_t cpu_show_indirect_target_selecti
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_ITS);
 }
+
+ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_TSA);
+}
 #endif
 
 void __warn_thunk(void)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1232,6 +1232,8 @@ static const __initconst struct x86_cpu_
 #define ITS		BIT(8)
 /* CPU is affected by Indirect Target Selection, but guest-host isolation is not affected */
 #define ITS_NATIVE_ONLY	BIT(9)
+/* CPU is affected by Transient Scheduler Attacks */
+#define TSA		BIT(10)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_INTEL_STEPS(INTEL_IVYBRIDGE,	     X86_STEP_MAX,	SRBDS),
@@ -1279,7 +1281,7 @@ static const struct x86_cpu_id cpu_vuln_
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
 	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_AMD(0x19, SRSO),
+	VULNBL_AMD(0x19, SRSO | TSA),
 	VULNBL_AMD(0x1a, SRSO),
 	{}
 };
@@ -1492,6 +1494,16 @@ static void __init cpu_set_bug_bits(stru
 			setup_force_cpu_bug(X86_BUG_ITS_NATIVE_ONLY);
 	}
 
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
 
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,8 @@ static const struct cpuid_bit cpuid_bits
 	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
+	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
 	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -169,6 +169,9 @@ SYM_FUNC_START(__svm_vcpu_run)
 #endif
 	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
 
+	/* Clobbers EFLAGS.ZF */
+	VM_CLEAR_CPU_BUFFERS
+
 	/* Enter guest mode */
 3:	vmrun %_ASM_AX
 4:
@@ -335,6 +338,9 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	mov SVM_current_vmcb(%rdi), %rax
 	mov KVM_VMCB_pa(%rax), %rax
 
+	/* Clobbers EFLAGS.ZF */
+	VM_CLEAR_CPU_BUFFERS
+
 	/* Enter guest mode */
 1:	vmrun %rax
 2:
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -601,6 +601,7 @@ CPU_SHOW_VULN_FALLBACK(gds);
 CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
 CPU_SHOW_VULN_FALLBACK(ghostwrite);
 CPU_SHOW_VULN_FALLBACK(indirect_target_selection);
+CPU_SHOW_VULN_FALLBACK(tsa);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -618,6 +619,7 @@ static DEVICE_ATTR(gather_data_sampling,
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 static DEVICE_ATTR(ghostwrite, 0444, cpu_show_ghostwrite, NULL);
 static DEVICE_ATTR(indirect_target_selection, 0444, cpu_show_indirect_target_selection, NULL);
+static DEVICE_ATTR(tsa, 0444, cpu_show_tsa, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -636,6 +638,7 @@ static struct attribute *cpu_root_vulner
 	&dev_attr_reg_file_data_sampling.attr,
 	&dev_attr_ghostwrite.attr,
 	&dev_attr_indirect_target_selection.attr,
+	&dev_attr_tsa.attr,
 	NULL
 };
 
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -80,6 +80,7 @@ extern ssize_t cpu_show_reg_file_data_sa
 extern ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_indirect_target_selection(struct device *dev,
 						  struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,



