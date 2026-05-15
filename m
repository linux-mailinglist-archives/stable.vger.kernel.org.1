Return-Path: <stable+bounces-247763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPM/INobB2r+rwIAu9opvQ
	(envelope-from <stable+bounces-247763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:12:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23CC550489
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FEE63020EC7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1BC315D35;
	Fri, 15 May 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ez8NDdEr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D003530C368;
	Fri, 15 May 2026 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850342; cv=none; b=HBYKeCRd6OU0dxTWB1+lcixyD7Wx3n2F4oizL5YhIL15g3ALqdmR3MAhW3llbrq0nHhfn/QolsOnSpi3jeX25n97Dyxuc4McfrSALlCdML+MjEGwu+DFTMiSxag/N0ORtPsJgzOVh4wmswhdzUUcFVa6Dz6aQI1nsOfPBmBFmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850342; c=relaxed/simple;
	bh=E4BIfRJljzy7kH0CAZmVdMbdYZgzNLZWiTuMBAIIbIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkDm5WeQpw8S+5Bgp9ud7YzImKGActySzmCRFuowjJ5PmF9MEceXfz3tM2JFZ/rcGo7dGL/86TwvbkGR/PV9WPVz2fxwMW3TyF0SX+daq2pWnlGIIwmADNtOd2jWw0pGNbsLC5BvMG42pLhFCH07YITbDGSdmbzt9ihfJUwKZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ez8NDdEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32936C2BCB0;
	Fri, 15 May 2026 13:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850342;
	bh=E4BIfRJljzy7kH0CAZmVdMbdYZgzNLZWiTuMBAIIbIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ez8NDdEr9LC7wQpSfqnJkfbzi46WXZ62OhR293JkXCUBL9ugFqOuyG0z6OrmDxWsl
	 yurw2jCCDN7kLcaVR5kuso0rVWYVPDS2qAVws1Zz7YK+Mopg+NAbgSwPfiscOxBhxb
	 RlgFnF+/7ym/X8kqtU+m74tQ5nLz0O0cm2xa8iGc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.207
Date: Fri, 15 May 2026 15:05:39 +0200
Message-ID: <2026051539-shortly-seldom-5771@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051539-defiling-pesky-95a5@gregkh>
References: <2026051539-defiling-pesky-95a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F23CC550489
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247763-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.964];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index a5a6e44e331b..905d708fd87b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 206
+SUBLEVEL = 207
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 9fe8a408f182..060ae0d8387e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -219,7 +219,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* "ibpb" Indirect Branch Prediction Barrier without a guaranteed RSB flush */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" Generic flag for all Zen and newer */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
@@ -310,6 +310,10 @@
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
 #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
 #define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* "" IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
+#define X86_FEATURE_ZEN2		(11*32+28) /* "" CPU based on Zen2 microarchitecture */
+#define X86_FEATURE_ZEN3		(11*32+29) /* "" CPU based on Zen3 microarchitecture */
+#define X86_FEATURE_ZEN4		(11*32+30) /* "" CPU based on Zen4 microarchitecture */
+#define X86_FEATURE_ZEN1		(11*32+31) /* "" CPU based on Zen1 microarchitecture */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 2dff91cda82e..093d0bac7941 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -580,6 +580,7 @@
 /* Zen4 */
 #define MSR_ZEN4_BP_CFG			0xc001102e
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+#define MSR_ZEN2_BP_CFG_BUG_FIX_BIT	33
 
 /* Zen 2 */
 #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 94975e9d981c..6c1ada204bcf 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -708,7 +708,50 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 
 	resctrl_cpu_detect(c);
 
+	/* Figure out Zen generations: */
+	switch (c->x86) {
+	case 0x17: {
+		switch (c->x86_model) {
+		case 0x00 ... 0x2f:
+		case 0x50 ... 0x5f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN1);
+			break;
+		case 0x30 ... 0x4f:
+		case 0x60 ... 0x7f:
+		case 0x90 ... 0x91:
+		case 0xa0 ... 0xaf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN2);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+	}
+	case 0x19: {
+		switch (c->x86_model) {
+		case 0x00 ... 0x0f:
+		case 0x20 ... 0x5f:
+			setup_force_cpu_cap(X86_FEATURE_ZEN3);
+			break;
+		case 0x10 ... 0x1f:
+		case 0x60 ... 0xaf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN4);
+			break;
+		default:
+			goto warn;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+
 	tsa_init(c);
+
+	return;
+
+warn:
+	WARN_ONCE(1, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
 }
 
 static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
@@ -1031,10 +1074,8 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 	 *
 	 * This suppresses speculation from the middle of a basic block, i.e. it
 	 * suppresses non-branch predictions.
-	 *
-	 * We use STIBP as a heuristic to filter out Zen2 from the rest of F17H
 	 */
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && cpu_has(c, X86_FEATURE_AMD_STIBP)) {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		if (!rdmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
 			value |= MSR_ZEN2_SPECTRAL_CHICKEN_BIT;
 			wrmsrl_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
@@ -1052,13 +1093,17 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
 
-static void init_amd_zn(struct cpuinfo_x86 *c)
+static void init_amd_zen_common(void)
 {
-	set_cpu_cap(c, X86_FEATURE_ZEN);
-
+	setup_force_cpu_cap(X86_FEATURE_ZEN);
 #ifdef CONFIG_NUMA
 	node_reclaim_distance = 32;
 #endif
+}
+
+static void init_amd_zen1(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
 
 	/* Fix up CPUID bits, but only if not virtualised. */
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
@@ -1121,6 +1166,25 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 	}
 }
 
+static void init_amd_zen2(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
+	init_spectral_chicken(c);
+
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
+		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN2_BP_CFG_BUG_FIX_BIT);
+}
+
+static void init_amd_zen3(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
+}
+
+static void init_amd_zen4(struct cpuinfo_x86 *c)
+{
+	init_amd_zen_common();
+}
+
 static void init_amd(struct cpuinfo_x86 *c)
 {
 	early_init_amd(c);
@@ -1150,11 +1214,17 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17: init_spectral_chicken(c);
-		   fallthrough;
-	case 0x19: init_amd_zn(c); break;
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ZEN1))
+		init_amd_zen1(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN2))
+		init_amd_zen2(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN3))
+		init_amd_zen3(c);
+	else if (boot_cpu_has(X86_FEATURE_ZEN4))
+		init_amd_zen4(c);
+
 	/*
 	 * Enable workaround for FXSAVE leak on CPUs
 	 * without a XSaveErPtr feature
diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbf69d0d6952..141039b6d905 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -896,6 +896,9 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
+	/* Save user-dumpable when mm goes away */
+	unsigned			user_dumpable:1;
+
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/kernel/exit.c b/kernel/exit.c
index 888a63f076d5..3c6ddf7320fa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -540,6 +540,7 @@ static void exit_mm(void)
 	 */
 	smp_mb__after_spinlock();
 	local_irq_disable();
+	current->user_dumpable = (get_dumpable(mm) == SUID_DUMP_USER);
 	current->mm = NULL;
 	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 0cf547531ddf..8e949e40bfe3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -288,11 +288,24 @@ static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 	return ns_capable(ns, CAP_SYS_PTRACE);
 }
 
+static bool task_still_dumpable(struct task_struct *task, unsigned int mode)
+{
+	struct mm_struct *mm = task->mm;
+	if (mm) {
+		if (get_dumpable(mm) == SUID_DUMP_USER)
+			return true;
+		return ptrace_has_cap(mm->user_ns, mode);
+	}
+
+	if (task->user_dumpable)
+		return true;
+	return ptrace_has_cap(&init_user_ns, mode);
+}
+
 /* Returns 0 on success, -errno on denial. */
 static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	const struct cred *cred = current_cred(), *tcred;
-	struct mm_struct *mm;
 	kuid_t caller_uid;
 	kgid_t caller_gid;
 
@@ -353,11 +366,8 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 	 * Pairs with a write barrier in commit_creds().
 	 */
 	smp_rmb();
-	mm = task->mm;
-	if (mm &&
-	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
-	     !ptrace_has_cap(mm->user_ns, mode)))
-	    return -EPERM;
+	if (!task_still_dumpable(task, mode))
+		return -EPERM;
 
 	return security_ptrace_access_check(task, mode);
 }
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 861451839cf2..9541c0ff941a 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -219,7 +219,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" Generic flag for all Zen and newer */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 2c0838ee3eac..658570e4959d 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -530,6 +530,9 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN2_BP_CFG_BUG_FIX_BIT	33
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 

