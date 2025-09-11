Return-Path: <stable+bounces-179297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC87B5390E
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 18:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B880D586ADB
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ADF3629BC;
	Thu, 11 Sep 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eXNmfSAO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9235AACA;
	Thu, 11 Sep 2025 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607700; cv=none; b=atoplwicrkFhBeI0oshoALT6iCBrUwDh6Itkdz/c0WPFNFVK+lN+gG4gfJ9MNrIxWBmOA477UT4QdJ/3viXFPXYYnbNtwo67DvlIgF/eGaHZhJndUeVRiY1/JaLXqvz+iUzlM34IzceMOFVQ4HV76MVGR2QQrg2KELtJghNrwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607700; c=relaxed/simple;
	bh=T3mD4z5wTTulVwdf/AtPgjjVKAcDfHuQx9NTZKdjWzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+rx34sEXxmlG+256T9ouiiaavhOCpShncd/qJBwdx19msgxHpMePqn9tP+nS39nbqbGRa6ije3wM40SzS1sWrjacTeWPebE60HeLbazhYLxuepBuYm2tm0PXGOVRoSObHrTA4oRD/uiri0BzvZgpi1UYEzTlJlLPYlXmMDz67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eXNmfSAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BF5C4CEF0;
	Thu, 11 Sep 2025 16:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757607698;
	bh=T3mD4z5wTTulVwdf/AtPgjjVKAcDfHuQx9NTZKdjWzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXNmfSAOrT4aStnpnCleVd2eJRY0rtcP2vkkWXugon7Jmf6FCU7AtpyKByclkiVvz
	 /At4yR7A6KF/fffrUWlnz2CPLlIXVLOAXukzr2TGkGGXro/viW530Hcb1FyLdX0Fiq
	 kPEVORSRlsC+LBPfR0p0vK9DlUijwZoW6vzaWg5s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.16.7
Date: Thu, 11 Sep 2025 18:21:25 +0200
Message-ID: <2025091125-clustered-tractor-13c0@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091125-helper-splashed-ea2a@gregkh>
References: <2025091125-helper-splashed-ea2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ab8cd337f43a..8aed6d94c4cd 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -586,6 +586,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/srbds
 		/sys/devices/system/cpu/vulnerabilities/tsa
 		/sys/devices/system/cpu/vulnerabilities/tsx_async_abort
+		/sys/devices/system/cpu/vulnerabilities/vmscape
 Date:		January 2018
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Information about CPU vulnerabilities
diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
index 09890a8f3ee9..8e6130d21de1 100644
--- a/Documentation/admin-guide/hw-vuln/index.rst
+++ b/Documentation/admin-guide/hw-vuln/index.rst
@@ -25,3 +25,4 @@ are configurable at compile, boot or run time.
    rsb
    old_microcode
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
index f6d317e1674d..089e1a395178 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3774,6 +3774,7 @@
 					       srbds=off [X86,INTEL]
 					       ssbd=force-off [ARM64]
 					       tsx_async_abort=off [X86]
+					       vmscape=off [X86]
 
 				Exceptions:
 					       This does not have any effect on
@@ -7937,6 +7938,16 @@
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
 	vsyscall=	[X86-64,EARLY]
 			Controls the behavior of vsyscalls (i.e. calls to
 			fixed addresses of 0xffffffffff600x00 from legacy
diff --git a/Makefile b/Makefile
index 0200497da26c..86359283ccc9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 16
-SUBLEVEL = 6
+SUBLEVEL = 7
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8bed9030ad47..874c9b264d6f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2704,6 +2704,15 @@ config MITIGATION_TSA
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
index 4597ef662122..48ffdbab9145 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -492,6 +492,7 @@
 #define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
+#define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-userspace, see VMSCAPE bug */
 
 /*
  * BUG word(s)
@@ -548,4 +549,5 @@
 #define X86_BUG_ITS			X86_BUG( 1*32+ 7) /* "its" CPU is affected by Indirect Target Selection */
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
+#define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index d535a97c7284..ce3eb6d5fdf9 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -93,6 +93,13 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
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
index 10f261678749..e29f82466f43 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -530,6 +530,8 @@ void alternative_msr_write(unsigned int msr, u64 val, unsigned int feature)
 		: "memory");
 }
 
+DECLARE_PER_CPU(bool, x86_ibpb_exit_to_user);
+
 static inline void indirect_branch_prediction_barrier(void)
 {
 	asm_inline volatile(ALTERNATIVE("", "call write_ibpb", X86_FEATURE_IBPB)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d19972d5d729..65e253ef5218 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -96,6 +96,9 @@ static void __init its_update_mitigation(void);
 static void __init its_apply_mitigation(void);
 static void __init tsa_select_mitigation(void);
 static void __init tsa_apply_mitigation(void);
+static void __init vmscape_select_mitigation(void);
+static void __init vmscape_update_mitigation(void);
+static void __init vmscape_apply_mitigation(void);
 
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
@@ -105,6 +108,14 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
 EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 
+/*
+ * Set when the CPU has run a potentially malicious guest. An IBPB will
+ * be needed to before running userspace. That IBPB will flush the branch
+ * predictor content.
+ */
+DEFINE_PER_CPU(bool, x86_ibpb_exit_to_user);
+EXPORT_PER_CPU_SYMBOL_GPL(x86_ibpb_exit_to_user);
+
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 
 static u64 __ro_after_init x86_arch_cap_msr;
@@ -227,6 +238,7 @@ void __init cpu_select_mitigations(void)
 	its_select_mitigation();
 	bhi_select_mitigation();
 	tsa_select_mitigation();
+	vmscape_select_mitigation();
 
 	/*
 	 * After mitigations are selected, some may need to update their
@@ -258,6 +270,7 @@ void __init cpu_select_mitigations(void)
 	bhi_update_mitigation();
 	/* srso_update_mitigation() depends on retbleed_update_mitigation(). */
 	srso_update_mitigation();
+	vmscape_update_mitigation();
 
 	spectre_v1_apply_mitigation();
 	spectre_v2_apply_mitigation();
@@ -275,6 +288,7 @@ void __init cpu_select_mitigations(void)
 	its_apply_mitigation();
 	bhi_apply_mitigation();
 	tsa_apply_mitigation();
+	vmscape_apply_mitigation();
 }
 
 /*
@@ -2355,88 +2369,6 @@ static void update_mds_branch_idle(void)
 	}
 }
 
-#define MDS_MSG_SMT "MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.\n"
-#define TAA_MSG_SMT "TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.\n"
-#define MMIO_MSG_SMT "MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.\n"
-
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
-	case MDS_MITIGATION_AUTO:
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
-	case TAA_MITIGATION_AUTO:
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
-	case MMIO_MITIGATION_AUTO:
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
-	case TSA_MITIGATION_AUTO:
-	case TSA_MITIGATION_FULL:
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
-	case TSA_MITIGATION_UCODE_NEEDED:
-		break;
-	}
-
-	mutex_unlock(&spec_ctrl_mutex);
-}
-
 #undef pr_fmt
 #define pr_fmt(fmt)	"Speculative Store Bypass: " fmt
 
@@ -3137,9 +3069,185 @@ static void __init srso_apply_mitigation(void)
 	}
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
+}
+
+static void __init vmscape_update_mitigation(void)
+{
+	if (!boot_cpu_has_bug(X86_BUG_VMSCAPE))
+		return;
+
+	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB ||
+	    srso_mitigation == SRSO_MITIGATION_IBPB_ON_VMEXIT)
+		vmscape_mitigation = VMSCAPE_MITIGATION_IBPB_ON_VMEXIT;
+
+	pr_info("%s\n", vmscape_strings[vmscape_mitigation]);
+}
+
+static void __init vmscape_apply_mitigation(void)
+{
+	if (vmscape_mitigation == VMSCAPE_MITIGATION_IBPB_EXIT_TO_USER)
+		setup_force_cpu_cap(X86_FEATURE_IBPB_EXIT_TO_USER);
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt) fmt
 
+#define MDS_MSG_SMT "MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.\n"
+#define TAA_MSG_SMT "TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.\n"
+#define MMIO_MSG_SMT "MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.\n"
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
+	case MDS_MITIGATION_AUTO:
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
+	case TAA_MITIGATION_AUTO:
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
+	case MMIO_MITIGATION_AUTO:
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
+	case TSA_MITIGATION_AUTO:
+	case TSA_MITIGATION_FULL:
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
+	case TSA_MITIGATION_UCODE_NEEDED:
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
@@ -3388,6 +3496,11 @@ static ssize_t tsa_show_state(char *buf)
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
@@ -3454,6 +3567,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_TSA:
 		return tsa_show_state(buf);
 
+	case X86_BUG_VMSCAPE:
+		return vmscape_show_state(buf);
+
 	default:
 		break;
 	}
@@ -3545,6 +3661,11 @@ ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *bu
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_TSA);
 }
+
+ssize_t cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_VMSCAPE);
+}
 #endif
 
 void __warn_thunk(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index fb50c1dd53ef..bce82fa055e4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1235,55 +1235,71 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 #define ITS_NATIVE_ONLY	BIT(9)
 /* CPU is affected by Transient Scheduler Attacks */
 #define TSA		BIT(10)
+/* CPU is affected by VMSCAPE */
+#define VMSCAPE		BIT(11)
 
 static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
-	VULNBL_INTEL_STEPS(INTEL_IVYBRIDGE,	     X86_STEP_MAX,	SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_HASWELL,	     X86_STEP_MAX,	SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_HASWELL_L,	     X86_STEP_MAX,	SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_HASWELL_G,	     X86_STEP_MAX,	SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_HASWELL_X,	     X86_STEP_MAX,	MMIO),
-	VULNBL_INTEL_STEPS(INTEL_BROADWELL_D,	     X86_STEP_MAX,	MMIO),
-	VULNBL_INTEL_STEPS(INTEL_BROADWELL_G,	     X86_STEP_MAX,	SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_BROADWELL_X,	     X86_STEP_MAX,	MMIO),
-	VULNBL_INTEL_STEPS(INTEL_BROADWELL,	     X86_STEP_MAX,	SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,		      0x5,	MMIO | RETBLEED | GDS),
-	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | ITS),
-	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_SKYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,		      0xb,	MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | ITS),
-	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,		      0xc,	MMIO | RETBLEED | GDS | SRBDS),
-	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | ITS),
-	VULNBL_INTEL_STEPS(INTEL_CANNONLAKE_L,	     X86_STEP_MAX,	RETBLEED),
+	VULNBL_INTEL_STEPS(INTEL_SANDYBRIDGE_X,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_SANDYBRIDGE,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_IVYBRIDGE_X,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_IVYBRIDGE,	     X86_STEP_MAX,	SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL,	     X86_STEP_MAX,	SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_L,	     X86_STEP_MAX,	SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_G,	     X86_STEP_MAX,	SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_HASWELL_X,	     X86_STEP_MAX,	MMIO | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_D,	     X86_STEP_MAX,	MMIO | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_X,	     X86_STEP_MAX,	MMIO | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL_G,	     X86_STEP_MAX,	SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_BROADWELL,	     X86_STEP_MAX,	SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,		      0x5,	MMIO | RETBLEED | GDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_X,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_SKYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,		      0xb,	MMIO | RETBLEED | GDS | SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE_L,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,		      0xc,	MMIO | RETBLEED | GDS | SRBDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_KABYLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | SRBDS | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_CANNONLAKE_L,	     X86_STEP_MAX,	RETBLEED | VMSCAPE),
 	VULNBL_INTEL_STEPS(INTEL_ICELAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPS(INTEL_ICELAKE_D,	     X86_STEP_MAX,	MMIO | GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPS(INTEL_ICELAKE_X,	     X86_STEP_MAX,	MMIO | GDS | ITS | ITS_NATIVE_ONLY),
-	VULNBL_INTEL_STEPS(INTEL_COMETLAKE,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
-	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,		      0x0,	MMIO | RETBLEED | ITS),
-	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,		      0x0,	MMIO | RETBLEED | ITS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_COMETLAKE_L,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED | GDS | ITS | VMSCAPE),
 	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE_L,	     X86_STEP_MAX,	GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPS(INTEL_TIGERLAKE,	     X86_STEP_MAX,	GDS | ITS | ITS_NATIVE_ONLY),
 	VULNBL_INTEL_STEPS(INTEL_LAKEFIELD,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RETBLEED),
 	VULNBL_INTEL_STEPS(INTEL_ROCKETLAKE,	     X86_STEP_MAX,	MMIO | RETBLEED | GDS | ITS | ITS_NATIVE_ONLY),
-	VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,		     ATOM,	RFDS),
-	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS),
-	VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,		     ATOM,	RFDS),
-	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_P,	     X86_STEP_MAX,	RFDS),
-	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_S,	     X86_STEP_MAX,	RFDS),
-	VULNBL_INTEL_STEPS(INTEL_ATOM_GRACEMONT,     X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_TYPE(INTEL_ALDERLAKE,		     ATOM,	RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_ALDERLAKE_L,	     X86_STEP_MAX,	RFDS | VMSCAPE),
+	VULNBL_INTEL_TYPE(INTEL_RAPTORLAKE,		     ATOM,	RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_P,	     X86_STEP_MAX,	RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_RAPTORLAKE_S,	     X86_STEP_MAX,	RFDS | VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_METEORLAKE_L,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_ARROWLAKE_H,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_ARROWLAKE,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_ARROWLAKE_U,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_LUNARLAKE_M,	     X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_SAPPHIRERAPIDS_X,   X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_GRANITERAPIDS_X,    X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_EMERALDRAPIDS_X,    X86_STEP_MAX,	VMSCAPE),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_GRACEMONT,     X86_STEP_MAX,	RFDS | VMSCAPE),
 	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT,	     X86_STEP_MAX,	MMIO | MMIO_SBDS | RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT_D,     X86_STEP_MAX,	MMIO | RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ATOM_TREMONT_L,     X86_STEP_MAX,	MMIO | MMIO_SBDS | RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT,      X86_STEP_MAX,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT_D,    X86_STEP_MAX,	RFDS),
 	VULNBL_INTEL_STEPS(INTEL_ATOM_GOLDMONT_PLUS, X86_STEP_MAX,	RFDS),
+	VULNBL_INTEL_STEPS(INTEL_ATOM_CRESTMONT_X,   X86_STEP_MAX,	VMSCAPE),
 
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
-	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_AMD(0x19, SRSO | TSA),
-	VULNBL_AMD(0x1a, SRSO),
+	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
+	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
+	VULNBL_AMD(0x19, SRSO | TSA | VMSCAPE),
+	VULNBL_AMD(0x1a, SRSO | VMSCAPE),
 	{}
 };
 
@@ -1542,6 +1558,14 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
index 7d4cb1cbd629..6b3a64e73f21 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11145,6 +11145,15 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.guest_fpu.xfd_err)
 		wrmsrq(MSR_IA32_XFD_ERR, 0);
 
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
index efc575a00edd..008da0354fba 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -603,6 +603,7 @@ CPU_SHOW_VULN_FALLBACK(ghostwrite);
 CPU_SHOW_VULN_FALLBACK(old_microcode);
 CPU_SHOW_VULN_FALLBACK(indirect_target_selection);
 CPU_SHOW_VULN_FALLBACK(tsa);
+CPU_SHOW_VULN_FALLBACK(vmscape);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -622,6 +623,7 @@ static DEVICE_ATTR(ghostwrite, 0444, cpu_show_ghostwrite, NULL);
 static DEVICE_ATTR(old_microcode, 0444, cpu_show_old_microcode, NULL);
 static DEVICE_ATTR(indirect_target_selection, 0444, cpu_show_indirect_target_selection, NULL);
 static DEVICE_ATTR(tsa, 0444, cpu_show_tsa, NULL);
+static DEVICE_ATTR(vmscape, 0444, cpu_show_vmscape, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -642,6 +644,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_old_microcode.attr,
 	&dev_attr_indirect_target_selection.attr,
 	&dev_attr_tsa.attr,
+	&dev_attr_vmscape.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6378370a952f..9cc5472b87ea 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -83,6 +83,7 @@ extern ssize_t cpu_show_old_microcode(struct device *dev,
 extern ssize_t cpu_show_indirect_target_selection(struct device *dev,
 						  struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_tsa(struct device *dev, struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_vmscape(struct device *dev, struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,

