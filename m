Return-Path: <stable+bounces-179291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9497DB538FF
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D08A3A97C0
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9D835A2AC;
	Thu, 11 Sep 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rLBEGEVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA80635FC05;
	Thu, 11 Sep 2025 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607674; cv=none; b=DZhxBlcLuMHerENBcbBYGwTediNuZCyvZnCATGvJbUTKfBjhM2dZzcfQlz8VlFVflEfr7g2l4T8sKpJ+m0b52P9uutXz07TkLx5sHTW5P45weHezMGGUML3YONGcdhBgAm2beRBOo2NWFUjiyShcUk5DupPkf9QrxUz7HqebcwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607674; c=relaxed/simple;
	bh=baNVgo4OVZuVUEjD8eF/61IRct9VPgQPFHxZC2liaGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSiBp5xDndKm5PjQyJQYIIu28wJklEtl0YqmSY33c48RxwTGqY/5QR4y4EWflxV16MxPQ167N9hbIt3zmXqLllkp2yQARRRhQwxqTHmjXvhncKT8ZE3zYb0/6f8UBtjLMBiVtlvfAxn8mKhvnNrhxPfPL2n05VBvBukGgkYqhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rLBEGEVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF34C4CEF0;
	Thu, 11 Sep 2025 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757607673;
	bh=baNVgo4OVZuVUEjD8eF/61IRct9VPgQPFHxZC2liaGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLBEGEVToEBZrLcBzrMQTAX+4AQMtaOZOd6NVkS2gH7NOM5Ei4kdooKBxyOJHLA5y
	 66QusbCVj08v2o2gu2U7MovDJ5AFxtM/+FUrqRL3XBqfJp1PzpcB9ny7d0X84LuDRQ
	 4UklGw43XVzxVgXEASwPkpykAfSda0T+d0c8McYg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.152
Date: Thu, 11 Sep 2025 18:21:01 +0200
Message-ID: <2025091101-armband-retry-7a19@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091101-moneybags-improvise-b8a8@gregkh>
References: <2025091101-moneybags-improvise-b8a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 97e695efa959..6eeaec818242 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -528,6 +528,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/srbds
 		/sys/devices/system/cpu/vulnerabilities/tsa
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
+		/sys/devices/system/cpu/vulnerabilities/vmscape
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index dc69ba0b05e4..4f6c1a695fa9 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -23,3 +23,4 @@ are configurable at compile, boot or run time.
    srso
    reg-file-data-sampling
    indirect-target-selection
+   vmscape
diff --git a/Documentation/admin-guide/hw-vuln/vmscape.rst b/Documentation/admin-guide/hw-vuln/vmscape.rst
new file mode 100644
index 000000000000..d9b9a2b6c114
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/vmscape.rst
@@ -0,0 +1,110 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+VMSCAPE
+=======
+
+VMSCAPE is a vulnerability that may allow a guest to influence the branch
+prediction in host userspace. It particularly affects hypervisors like QEMU.
+
+Even if a hypervisor may not have any sensitive data like disk encryption keys,
+guest-userspace may be able to attack the guest-kernel using the hypervisor as
+a confused deputy.
+
+Affected processors
+-------------------
+
+The following CPU families are affected by VMSCAPE:
+
+**Intel processors:**
+  - Skylake generation (Parts without Enhanced-IBRS)
+  - Cascade Lake generation - (Parts affected by ITS guest/host separation)
+  - Alder Lake and newer (Parts affected by BHI)
+
+Note that, BHI affected parts that use BHB clearing software mitigation e.g.
+Icelake are not vulnerable to VMSCAPE.
+
+**AMD processors:**
+  - Zen series (families 0x17, 0x19, 0x1a)
+
+** Hygon processors:**
+ - Family 0x18
+
+Mitigation
+----------
+
+Conditional IBPB
+----------------
+
+Kernel tracks when a CPU has run a potentially malicious guest and issues an
+IBPB before the first exit to userspace after VM-exit. If userspace did not run
+between VM-exit and the next VM-entry, no IBPB is issued.
+
+Note that the existing userspace mitigation against Spectre-v2 is effective in
+protecting the userspace. They are insufficient to protect the userspace VMMs
+from a malicious guest. This is because Spectre-v2 mitigations are applied at
+context switch time, while the userspace VMM can run after a VM-exit without a
+context switch.
+
+Vulnerability enumeration and mitigation is not applied inside a guest. This is
+because nested hypervisors should already be deploying IBPB to isolate
+themselves from nested guests.
+
+SMT considerations
+------------------
+
+When Simultaneous Multi-Threading (SMT) is enabled, hypervisors can be
+vulnerable to cross-thread attacks. For complete protection against VMSCAPE
+attacks in SMT environments, STIBP should be enabled.
+
+The kernel will issue a warning if SMT is enabled without adequate STIBP
+protection. Warning is not issued when:
+
+- SMT is disabled
+- STIBP is enabled system-wide
+- Intel eIBRS is enabled (which implies STIBP protection)
+
+System information and options
+------------------------------
+
+The sysfs file showing VMSCAPE mitigation status is:
+
+  /sys/devices/system/cpu/vulnerabilities/vmscape
+
+The possible values in this file are:
+
+ * 'Not affected':
+
+   The processor is not vulnerable to VMSCAPE attacks.
+
+ * 'Vulnerable':
+
+   The processor is vulnerable and no mitigation has been applied.
+
+ * 'Mitigation: IBPB before exit to userspace':
+
+   Conditional IBPB mitigation is enabled. The kernel tracks when a CPU has
+   run a potentially malicious guest and issues an IBPB before the first
+   exit to userspace after VM-exit.
+
+ * 'Mitigation: IBPB on VMEXIT':
+
+   IBPB is issued on every VM-exit. This occurs when other mitigations like
+   RETBLEED or SRSO are already issuing IBPB on VM-exit.
+
+Mitigation control on the kernel command line
+----------------------------------------------
+
+The mitigation can be controlled via the ``vmscape=`` command line parameter:
+
+ * ``vmscape=off``:
+
+   Disable the VMSCAPE mitigation.
+
+ * ``vmscape=ibpb``:
+
+   Enable conditional IBPB mitigation (default when CONFIG_MITIGATION_VMSCAPE=y).
+
+ * ``vmscape=force``:
+
+   Force vulnerability detection and mitigation even on processors that are
+   not known to be affected.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index eaeabff9beff..cce273172739 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3297,6 +3297,7 @@
 					       srbds=off [X86,INTEL]
 					       ssbd=force-off [ARM64]
 					       tsx_async_abort=off [X86]
+					       vmscape=off [X86]
 
 				Exceptions:
 					       This does not have any effect on
@@ -6813,6 +6814,16 @@
 	vmpoff=		[KNL,S390] Perform z/VM CP command after power off.
 			Format: <command>
 
+	vmscape=	[X86] Controls mitigation for VMscape attacks.
+			VMscape attacks can leak information from a userspace
+			hypervisor to a guest via speculative side-channels.
+
+			off		- disable the mitigation
+			ibpb		- use Indirect Branch Prediction Barrier
+					  (IBPB) mitigation (default)
+			force		- force vulnerability detection even on
+					  unaffected processors
+
 	vsyscall=	[X86-64]
 			Controls the behavior of vsyscalls (i.e. calls to
 			fixed addresses of 0xffffffffff600x00 from legacy
diff --git a/Makefile b/Makefile
index 565d019f9de0..5d7fd3b481b3 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 151
+SUBLEVEL = 152
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f23510275076..c7dfe2a5f162 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2595,6 +2595,15 @@ config MITIGATION_TSA
 	  security vulnerability on AMD CPUs which can lead to forwarding of
 	  invalid info to subsequent instructions and thus can affect their
 	  timing and thereby cause a leakage.
+
+config MITIGATION_VMSCAPE
+	bool "Mitigate VMSCAPE"
+	depends on KVM
+	default y
+	help
+	  Enable mitigation for VMSCAPE attacks. VMSCAPE is a hardware security
+	  vulnerability on Intel and AMD CPUs that may allow a guest to do
+	  Spectre v2 style attacks on userspace hypervisor.
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index c48a9733e906..f86e100cf56b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -452,6 +452,7 @@
 #define X86_FEATURE_TSA_SQ_NO          (21*32+11) /* "" AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO          (21*32+12) /* "" AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM   (21*32+13) /* "" Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_IBPB_EXIT_TO_USER  (21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
 
 /*
  * BUG word(s)
@@ -505,4 +506,5 @@
 #define X86_BUG_ITS			X86_BUG(1*32 + 5) /* CPU is affected by Indirect Target Selection */
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG(1*32 + 6) /* CPU is affected by ITS, VMX is not affected */
 #define X86_BUG_TSA			X86_BUG(1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
+#define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index ebdf5c97f53a..7dedda82f499 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -83,6 +83,13 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	 * 8 (ia32) bits.
 	 */
 	choose_random_kstack_offset(rdtsc());
+
+	/* Avoid unnecessary reads of 'x86_ibpb_exit_to_user' */
+	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER) &&
+	    this_cpu_read(x86_ibpb_exit_to_user)) {
+		indirect_branch_prediction_barrier();
+		this_cpu_write(x86_ibpb_exit_to_user, false);
+	}
 }
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index c77a65a3e5f1..818a5913f219 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -394,6 +394,8 @@ void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 
 extern u64 x86_pred_cmd;
 
+DECLARE_PER_CPU(bool, x86_ibpb_exit_to_user);
+
 static inline void indirect_branch_prediction_barrier(void)
 {
 	alternative_msr_write(MSR_IA32_PRED_CMD, x86_pred_cmd, X86_FEATURE_USE_IBPB);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4fbb5b15ab75..ff8965bce6c9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -50,6 +50,7 @@ static void __init gds_select_mitigation(void);
 static void __init srso_select_mitigation(void);
 static void __init its_select_mitigation(void);
 static void __init tsa_select_mitigation(void);
+static void __init vmscape_select_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -59,6 +60,14 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
 
+/*
+ * Set when the CPU has run a potentially malicious guest. An IBPB will
+ * be needed to before running userspace. That IBPB will flush the branch
+ * predictor content.
+ */
+DEFINE_PER_CPU(bool, x86_ibpb_exit_to_user);
+EXPORT_PER_CPU_SYMBOL_GPL(x86_ibpb_exit_to_user);
+
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
@@ -185,6 +194,7 @@ void __init cpu_select_mitigations(void)
 	gds_select_mitigation();
 	its_select_mitigation();
 	tsa_select_mitigation();
+	vmscape_select_mitigation();
 }
 
 /*
@@ -2128,80 +2138,6 @@ static void __init tsa_select_mitigation(void)
 	pr_info("%s\n", tsa_strings[tsa_mitigation]);
 }
 
-void cpu_bugs_smt_update(void)
-{
-	mutex_lock(&spec_ctrl_mutex);
-
-	if (sched_smt_active() && unprivileged_ebpf_enabled() &&
-	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
-		pr_warn_once(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
-
-	switch (spectre_v2_user_stibp) {
-	case SPECTRE_V2_USER_NONE:
-		break;
-	case SPECTRE_V2_USER_STRICT:
-	case SPECTRE_V2_USER_STRICT_PREFERRED:
-		update_stibp_strict();
-		break;
-	case SPECTRE_V2_USER_PRCTL:
-	case SPECTRE_V2_USER_SECCOMP:
-		update_indir_branch_cond();
-		break;
-	}
-
-	switch (mds_mitigation) {
-	case MDS_MITIGATION_FULL:
-	case MDS_MITIGATION_VMWERV:
-		if (sched_smt_active() && !boot_cpu_has(X86_BUG_MSBDS_ONLY))
-			pr_warn_once(MDS_MSG_SMT);
-		update_mds_branch_idle();
-		break;
-	case MDS_MITIGATION_OFF:
-		break;
-	}
-
-	switch (taa_mitigation) {
-	case TAA_MITIGATION_VERW:
-	case TAA_MITIGATION_UCODE_NEEDED:
-		if (sched_smt_active())
-			pr_warn_once(TAA_MSG_SMT);
-		break;
-	case TAA_MITIGATION_TSX_DISABLED:
-	case TAA_MITIGATION_OFF:
-		break;
-	}
-
-	switch (mmio_mitigation) {
-	case MMIO_MITIGATION_VERW:
-	case MMIO_MITIGATION_UCODE_NEEDED:
-		if (sched_smt_active())
-			pr_warn_once(MMIO_MSG_SMT);
-		break;
-	case MMIO_MITIGATION_OFF:
-		break;
-	}
-
-	switch (tsa_mitigation) {
-	case TSA_MITIGATION_USER_KERNEL:
-	case TSA_MITIGATION_VM:
-	case TSA_MITIGATION_FULL:
-	case TSA_MITIGATION_UCODE_NEEDED:
-		/*
-		 * TSA-SQ can potentially lead to info leakage between
-		 * SMT threads.
-		 */
-		if (sched_smt_active())
-			static_branch_enable(&cpu_buf_idle_clear);
-		else
-			static_branch_disable(&cpu_buf_idle_clear);
-		break;
-	case TSA_MITIGATION_NONE:
-		break;
-	}
-
-	mutex_unlock(&spec_ctrl_mutex);
-}
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
@@ -2890,9 +2826,169 @@ static void __init srso_select_mitigation(void)
 		x86_pred_cmd = PRED_CMD_SBPB;
 }
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"VMSCAPE: " fmt
+
+enum vmscape_mitigations {
+	VMSCAPE_MITIGATION_NONE,
+	VMSCAPE_MITIGATION_AUTO,
+	VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER,
+	VMSCAPE_MITIGATION_IBPB_ON_VMEXIT,
+};
+
+static const char * const vmscape_strings[] = {
+	[VMSCAPE_MITIGATION_NONE]		= "Vulnerable",
+	/* [VMSCAPE_MITIGATION_AUTO] */
+	[VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER]	= "Mitigation: IBPB before exit to userspace",
+	[VMSCAPE_MITIGATION_IBPB_ON_VMEXIT]	= "Mitigation: IBPB on VMEXIT",
+};
+
+static enum vmscape_mitigations vmscape_mitigation __ro_after_init =
+	IS_ENABLED(CONFIG_MITIGATION_VMSCAPE) ? VMSCAPE_MITIGATION_AUTO : VMSCAPE_MITIGATION_NONE;
+
+static int __init vmscape_parse_cmdline(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	if (!strcmp(str, "off")) {
+		vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
+	} else if (!strcmp(str, "ibpb")) {
+		vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
+	} else if (!strcmp(str, "force")) {
+		setup_force_cpu_bug(X86_BUG_VMSCAPE);
+		vmscape_mitigation = VMSCAPE_MITIGATION_AUTO;
+	} else {
+		pr_err("Ignoring unknown vmscape=%s option.\n", str);
+	}
+
+	return 0;
+}
+early_param("vmscape", vmscape_parse_cmdline);
+
+static void __init vmscape_select_mitigation(void)
+{
+	if (cpu_mitigations_off() ||
+	    !boot_cpu_has_bug(X86_BUG_VMSCAPE) ||
+	    !boot_cpu_has(X86_FEATURE_IBPB)) {
+		vmscape_mitigation = VMSCAPE_MITIGATION_NONE;
+		return;
+	}
+
+	if (vmscape_mitigation == VMSCAPE_MITIGATION_AUTO)
+		vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER;
+
+	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB ||
+	    srso_mitigation == SRSO_MITIGATION_IBPB_ON_VMEXIT)
+		vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_ON_VMEXIT;
+
+	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
+		setup_force_cpu_cap(X86_FEATURE_IBPB_EXIT_TO_USER);
+
+	pr_info("%s\n", vmscape_strings[vmscape_mitigation]);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt) fmt
 
+#define VMSCAPE_MSG_SMT "VMSCAPE: SMT on, STIBP is required for full protection. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/vmscape.html for more details.\n"
+
+void cpu_bugs_smt_update(void)
+{
+	mutex_lock(&spec_ctrl_mutex);
+
+	if (sched_smt_active() && unprivileged_ebpf_enabled() &&
+	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
+		pr_warn_once(SPECTRE_V2_EIBRS_LFENCE_EBPF_SMT_MSG);
+
+	switch (spectre_v2_user_stibp) {
+	case SPECTRE_V2_USER_NONE:
+		break;
+	case SPECTRE_V2_USER_STRICT:
+	case SPECTRE_V2_USER_STRICT_PREFERRED:
+		update_stibp_strict();
+		break;
+	case SPECTRE_V2_USER_PRCTL:
+	case SPECTRE_V2_USER_SECCOMP:
+		update_indir_branch_cond();
+		break;
+	}
+
+	switch (mds_mitigation) {
+	case MDS_MITIGATION_FULL:
+	case MDS_MITIGATION_VMWERV:
+		if (sched_smt_active() && !boot_cpu_has(X86_BUG_MSBDS_ONLY))
+			pr_warn_once(MDS_MSG_SMT);
+		update_mds_branch_idle();
+		break;
+	case MDS_MITIGATION_OFF:
+		break;
+	}
+
+	switch (taa_mitigation) {
+	case TAA_MITIGATION_VERW:
+	case TAA_MITIGATION_UCODE_NEEDED:
+		if (sched_smt_active())
+			pr_warn_once(TAA_MSG_SMT);
+		break;
+	case TAA_MITIGATION_TSX_DISABLED:
+	case TAA_MITIGATION_OFF:
+		break;
+	}
+
+	switch (mmio_mitigation) {
+	case MMIO_MITIGATION_VERW:
+	case MMIO_MITIGATION_UCODE_NEEDED:
+		if (sched_smt_active())
+			pr_warn_once(MMIO_MSG_SMT);
+		break;
+	case MMIO_MITIGATION_OFF:
+		break;
+	}
+
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
+	switch (vmscape_mitigation) {
+	case VMSCAPE_MITIGATION_NONE:
+	case VMSCAPE_MITIGATION_AUTO:
+		break;
+	case VMSCAPE_MITIGATION_IBPB_ON_VMEXIT:
+	case VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER:
+		/*
+		 * Hypervisors can be attacked across-threads, warn for SMT when
+		 * STIBP is not already enabled system-wide.
+		 *
+		 * Intel eIBRS (!AUTOIBRS) implies STIBP on.
+		 */
+		if (!sched_smt_active() ||
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
+		    (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
+		     !boot_cpu_has(X86_FEATURE_AUTOIBRS)))
+			break;
+		pr_warn_once(VMSCAPE_MSG_SMT);
+		break;
+	}
+
+	mutex_unlock(&spec_ctrl_mutex);
+}
+
 #ifdef CONFIG_SYSFS
 
 #define L1TF_DEFAULT_MSG "Mitigation: PTE Inversion"
@@ -3138,6 +3234,11 @@ static ssize_t tsa_show_state(char *buf)
 	return sysfs_emit(buf, "%s\n", tsa_strings[tsa_mitigation]);
 }
 
+static ssize_t vmscape_show_state(char *buf)
+{
+	return sysfs_emit(buf, "%s\n", vmscape_strings[vmscape_mitigation]);
+}
+
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
 			       char *buf, unsigned int bug)
 {
@@ -3202,6 +3303,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_TSA:
 		return tsa_show_state(buf);
 
+	case X86_BUG_VMSCAPE:
+		return vmscape_show_state(buf);
+
 	default:
 		break;
 	}
@@ -3291,4 +3395,9 @@ ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *bu
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_TSA);
 }
+
+ssize_t cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_VMSCAPE);
+}
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9c849a4160cd..19c9087e2b84 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1258,42 +1258,54 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define ITS_NATIVE_ONLY	BIT(9)
 /* CPU is affected by Transient Scheduler Attacks */
 #define TSA		BIT(10)
+/* CPU is affected by VMSCAPE */
+#define VMSCAPE		BIT(11)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
-	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(HASWELL,		X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(HASWELL_L,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(HASWELL_G,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(HASWELL_X,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(BROADWELL_D,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(BROADWELL_G,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO),
-	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPINGS(0x0, 0x5),	MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPINGS(0x0, 0xb),	MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPINGS(0x0, 0xc),	MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS),
-	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED),
+	VULNBL_INTEL_STEPPINGS(SANDYBRIDGE_X,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(SANDYBRIDGE,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(IVYBRIDGE_X,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(IVYBRIDGE,	X86_STEPPING_ANY,		SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(HASWELL,		X86_STEPPING_ANY,		SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(HASWELL_L,	X86_STEPPING_ANY,		SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(HASWELL_G,	X86_STEPPING_ANY,		SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(HASWELL_X,	X86_STEPPING_ANY,		MMIO | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(BROADWELL_D,	X86_STEPPING_ANY,		MMIO | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(BROADWELL_X,	X86_STEPPING_ANY,		MMIO | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(BROADWELL_G,	X86_STEPPING_ANY,		SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(BROADWELL,	X86_STEPPING_ANY,		SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPINGS(0x0, 0x5),	MMIO | RETBLEED | GDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_X,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(SKYLAKE,		X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPINGS(0x0, 0xb),	MMIO | RETBLEED | GDS | SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE_L,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPINGS(0x0, 0xc),	MMIO | RETBLEED | GDS | SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(KABYLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | SRBDS | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(CANNONLAKE_L,	X86_STEPPING_ANY,		RETBLEED | VMSCAPE),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_D,	X86_STEPPING_ANY,		MMIO | GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(ICELAKE_X,	X86_STEPPING_ANY,		MMIO | GDS | ITS | ITS_NATIVE_ONLY),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | ITS),
-	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPINGS(0x0, 0x0),	MMIO | RETBLEED | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(COMETLAKE_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | VMSCAPE),
 	VULNBL_INTEL_STEPPINGS(TIGERLAKE_L,	X86_STEPPING_ANY,		GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(TIGERLAKE,	X86_STEPPING_ANY,		GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPPINGS(LAKEFIELD,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPPINGS(ROCKETLAKE,	X86_STEPPING_ANY,		MMIO | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
-	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS),
-	VULNBL_INTEL_STEPPINGS(ALDERLAKE_N,	X86_STEPPING_ANY,		RFDS),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE,	X86_STEPPING_ANY,		RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_L,	X86_STEPPING_ANY,		RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE,	X86_STEPPING_ANY,		RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_P,	X86_STEPPING_ANY,		RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(RAPTORLAKE_S,	X86_STEPPING_ANY,		RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(METEORLAKE_L,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(ARROWLAKE_H,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(ARROWLAKE,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(LUNARLAKE_M,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(SAPPHIRERAPIDS_X,X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(GRANITERAPIDS_X,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(EMERALDRAPIDS_X,	X86_STEPPING_ANY,		VMSCAPE),
+	VULNBL_INTEL_STEPPINGS(ALDERLAKE_N,	X86_STEPPING_ANY,		RFDS | VMSCAPE),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPING_ANY,		MMIO | RFDS),
 	VULNBL_INTEL_STEPPINGS(ATOM_TREMONT_L,	X86_STEPPING_ANY,		MMIO | MMIO_SBDS | RFDS),
@@ -1303,9 +1315,9 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
-	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_AMD(0x19, SRSO | TSA),
+	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
+	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
+	VULNBL_AMD(0x19, SRSO | TSA | VMSCAPE),
 	{}
 };
 
@@ -1520,6 +1532,14 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		}
 	}
 
+	/*
+	 * Set the bug only on bare-metal. A nested hypervisor should already be
+	 * deploying IBPB to isolate itself from nested guests.
+	 */
+	if (cpu_matches(cpu_vuln_blacklist, VMSCAPE) &&
+	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		setup_force_cpu_bug(X86_BUG_VMSCAPE);
+
 	if (cpu_matches(cpu_vuln_whitelist, NO_MELTDOWN))
 		return;
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 57ba9071841e..11ca05d830e7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10925,6 +10925,15 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrl(MSR_IA32_XFD_ERR, 0);
 
+	/*
+	 * Mark this CPU as needing a branch predictor flush before running
+	 * userspace. Must be done before enabling preemption to ensure it gets
+	 * set for the CPU that actually ran the guest, and not the CPU that it
+	 * may migrate to.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_IBPB_EXIT_TO_USER))
+		this_cpu_write(x86_ibpb_exit_to_user, true);
+
 	/*
 	 * Consume any pending interrupts, including the possible source of
 	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index d68c60f35764..186bd680e741 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -606,6 +606,11 @@ ssize_t __weak cpu_show_tsa(struct device *dev, struct device_attribute *attr, c
 	return sysfs_emit(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
@@ -622,6 +627,7 @@ static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NU
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 static DEVICE_ATTR(indirect_target_selection, 0444, cpu_show_indirect_target_selection, NULL);
 static DEVICE_ATTR(tsa, 0444, cpu_show_tsa, NULL);
+static DEVICE_ATTR(vmscape, 0444, cpu_show_vmscape, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -640,6 +646,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_reg_file_data_sampling.attr,
 	&dev_attr_indirect_target_selection.attr,
 	&dev_attr_tsa.attr,
+	&dev_attr_vmscape.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 3d3ceccf8224..4883ce43d90a 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -79,6 +79,7 @@ extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 extern ssize_t cpu_show_indirect_target_selection(struct device *dev,
 						  struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,

