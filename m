Return-Path: <stable+bounces-247761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PhXNu4jB2oEsQIAu9opvQ
	(envelope-from <stable+bounces-247761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:47:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2700550B80
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CF7330F77E3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900183090D4;
	Fri, 15 May 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UT9llkOt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F083019D8;
	Fri, 15 May 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850336; cv=none; b=uYOSn2UxDof3U3CeghEfEJEy43x6JmoDej5KUd3zDZojiiwbAa/3SLzxxFQCufPRVsOOOEblDJUQSCKx6L5isG3tg9RQWEnI86ZyLXOOEXNaEjTSfkVgo6Cn3bcTFAVc+U10gdyfQzW6vSgbttjihZ5J9t5Ls0Mn6vTtsidAabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850336; c=relaxed/simple;
	bh=PT6Ap9MCv6+ztYDyyY/zBvsO5da/UpD+PBrAMliADIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LV18ZUuQQjPU3QdtBtD4aIRX/1sDvZj8sa7pr1fHNsiZGHQMYpXU+G1occ5+8+fw1DSVYrEV3iz7KJYI/DoXKUXUh427NVt9pFScYWmz+Z+8KZMtHRYLUmHX5OzIWqRpRHvnRGWlzuv6O9YtdGjObvymViy5mKVtjhUHbh/jh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UT9llkOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98209C2BCB0;
	Fri, 15 May 2026 13:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850335;
	bh=PT6Ap9MCv6+ztYDyyY/zBvsO5da/UpD+PBrAMliADIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UT9llkOtY2Yvm7vvAs37igmVbAkLXu1RA2VYhFhlH2qXppDymlV9dwhVOMU40xyHK
	 VQsMmqyYUCKOx+4Hlt2Wee4q9D3xupTqLNBTDVsiDhWkeDtLp1uPacpEzJZfFlbZ1Y
	 NMzMdtSiKBalcIRTC97QbuQiPJQ2AWt5Uis4800Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.256
Date: Fri, 15 May 2026 15:05:33 +0200
Message-ID: <2026051533-rake-endorse-0d42@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051533-feast-promenade-7d8e@gregkh>
References: <2026051533-feast-promenade-7d8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D2700550B80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247761-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.963];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

diff --git a/Makefile b/Makefile
index 2dc1e360a98b..d8f781615d3e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 255
+SUBLEVEL = 256
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 79017db18b02..19a18df50a2e 100644
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
@@ -306,6 +306,10 @@
 #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
 #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
 #define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* "" IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
+#define X86_FEATURE_ZEN2		(11*32+28) /* "" CPU based on Zen2 microarchitecture */
+#define X86_FEATURE_ZEN3		(11*32+29) /* "" CPU based on Zen3 microarchitecture */
+#define X86_FEATURE_ZEN4		(11*32+30) /* "" CPU based on Zen4 microarchitecture */
+#define X86_FEATURE_ZEN1		(11*32+31) /* "" CPU based on Zen1 microarchitecture */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 390db709b432..59bee2206d97 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -570,6 +570,7 @@
 /* Zen4 */
 #define MSR_ZEN4_BP_CFG			0xc001102e
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
+#define MSR_ZEN2_BP_CFG_BUG_FIX_BIT	33
 
 /* Zen 2 */
 #define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 39602a7ed1fc..519e388083b2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -735,7 +735,50 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 
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
@@ -1058,10 +1101,8 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
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
@@ -1079,13 +1120,17 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
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
@@ -1148,6 +1193,25 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
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
@@ -1177,11 +1241,17 @@ static void init_amd(struct cpuinfo_x86 *c)
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
index 3613c3f43b83..540431e31681 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -805,6 +805,9 @@ struct task_struct {
 	 */
 	unsigned			sched_remote_wakeup:1;
 
+	/* Save user-dumpable when mm goes away */
+	unsigned			user_dumpable:1;
+
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
diff --git a/kernel/exit.c b/kernel/exit.c
index cfdf2d275bba..99ab6d7a09ce 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -528,6 +528,7 @@ static void exit_mm(void)
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
+	current->user_dumpable = (get_dumpable(mm) == SUID_DUMP_USER);
 	current->mm = NULL;
 	mmap_read_unlock(mm);
 	enter_lazy_tlb(mm, current);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index aab480e24bd6..fb21c2bf55c3 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -287,11 +287,24 @@ static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
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
 
@@ -352,11 +365,8 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
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
index 2ae4d74ee73b..96da27e14fc2 100644
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
index 8fb925676813..c28d75fe4dee 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -523,6 +523,9 @@
 
 #define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 
+#define MSR_ZEN4_BP_CFG			0xc001102e
+#define MSR_ZEN2_BP_CFG_BUG_FIX_BIT	33
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 

