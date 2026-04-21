Return-Path: <stable+bounces-240114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Dm3OGJM52lW6QEAu9opvQ
	(envelope-from <stable+bounces-240114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:07:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABFD439526
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 888303056FD4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C7C3A63E3;
	Tue, 21 Apr 2026 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M7pLyEYM"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4810634F24A
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765633; cv=none; b=kdym56JXWQbDMYon+FnOQ6+UjrKoBxTDxtIZ22hQFAOIFzx+008aKT2sbjc11/ASMUllkhioAT/VwGc3uu1ExT3Ba8cLj5XZNdFq2bXtDh9MujqdXrcqNsjTvcHv2v3Igl1HE4CYtoJUVecah8k+UA/wV22UpqkqJG/LCVwmXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765633; c=relaxed/simple;
	bh=RwsN2CgG2SI9qNtkK8vDdEWy5REKILJGAL5W2Im1J58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6F9WYSbsLCIMeH+IIQTg7vxWYM0USPSBtAaCe6qI5tPBK9uaLCpBaW/arXytIFx8anX35vx3axiQ1kHCfJt+v67ppk0p61aM2Hdpl7bN4spZbKftketwME7eBSV1HHfOFJNJyp1ZBJghevThlhhN5WcMsYRK3tUEOekIqCbx0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M7pLyEYM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A9E025E4;
	Tue, 21 Apr 2026 03:00:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.89.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 435A83FBCB;
	Tue, 21 Apr 2026 03:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776765631; bh=RwsN2CgG2SI9qNtkK8vDdEWy5REKILJGAL5W2Im1J58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M7pLyEYMjdtAFhBTfS8O2+tot/hhcYEo2K0HQXkxJvt8PV1uebEIKZ4i0pFyTwCji
	 yyPpU7EQPAwgfG+VyCTnI2oUVeFNC/HyauDUai5xgzOE48gA56+3ItPAlqj1bi/DV+
	 LXAF2ZedyXXA8wiiHaEWTSxOblTjgxiXJgpYAy+4=
From: Catalin Marinas <catalin.marinas@arm.com>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6.18.y 6/6] arm64: errata: Work around early CME DVMSync acknowledgement
Date: Tue, 21 Apr 2026 11:00:17 +0100
Message-ID: <20260421100018.335793-7-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421100018.335793-1-catalin.marinas@arm.com>
References: <20260421100018.335793-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240114-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,arm.com:dkim,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4ABFD439526
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 0baba94a9779c13c857f6efc55807e6a45b1d4e4 upstream.

C1-Pro acknowledges DVMSync messages before completing the SME/CME
memory accesses. Work around this by issuing an IPI to the affected CPUs
if they are running in EL0 with SME enabled.

Note that we avoid the local DSB in the IPI handler as the kernel runs
with SCTLR_EL1.IESB=1. This is sufficient to complete SME memory
accesses at EL0 on taking an exception to EL1. On the return to user
path, no barrier is necessary either. See the comment in
sme_set_active() and the more detailed explanation in the link below.

To avoid a potential IPI flood from malicious applications (e.g.
madvise(MADV_PAGEOUT) in a tight loop), track where a process is active
via mm_cpumask() and only interrupt those CPUs.

Link: https://lore.kernel.org/r/ablEXwhfKyJW1i7l@J2N7QTR9R3
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Reviewed-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 +
 arch/arm64/Kconfig                          | 12 ++++
 arch/arm64/include/asm/cpucaps.h            |  2 +
 arch/arm64/include/asm/fpsimd.h             | 21 ++++++
 arch/arm64/include/asm/tlbbatch.h           | 10 ++-
 arch/arm64/include/asm/tlbflush.h           | 72 ++++++++++++++++++-
 arch/arm64/kernel/cpu_errata.c              | 30 ++++++++
 arch/arm64/kernel/entry-common.c            |  3 +
 arch/arm64/kernel/fpsimd.c                  | 79 +++++++++++++++++++++
 arch/arm64/kernel/process.c                 | 36 ++++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 11 files changed, 264 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index a7ec57060f64..93cdf1693715 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -202,6 +202,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-V3AE   | #3312417        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | C1-Pro          | #4193714        | ARM64_ERRATUM_4193714       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | ARM_SMMU_MMU_500_CPRE_ERRATA|
 |                |                 | #562869,1047329 |                             |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6663ffd23f25..840a945cb4ac 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1154,6 +1154,18 @@ config ARM64_ERRATUM_3194386
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_4193714
+	bool "C1-Pro: 4193714: SME DVMSync early acknowledgement"
+	depends on ARM64_SME
+	default y
+	help
+	  Enable workaround for C1-Pro acknowledging the DVMSync before
+	  the SME memory accesses are complete. This will cause TLB
+	  maintenance for processes using SME to also issue an IPI to
+	  the affected CPUs.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 9d769291a306..121210b7ffd0 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -66,6 +66,8 @@ cpucap_is_possible(const unsigned int cap)
 		return IS_ENABLED(CONFIG_ARM64_WORKAROUND_REPEAT_TLBI);
 	case ARM64_WORKAROUND_SPECULATIVE_SSBS:
 		return IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386);
+	case ARM64_WORKAROUND_4193714:
+		return IS_ENABLED(CONFIG_ARM64_ERRATUM_4193714);
 	case ARM64_MPAM:
 		/*
 		 * KVM MPAM support doesn't rely on the host kernel supporting MPAM.
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index b8cf0ea43cc0..0fa8d1d5722e 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -428,6 +428,24 @@ static inline size_t sme_state_size(struct task_struct const *task)
 	return __sme_state_size(task_get_sme_vl(task));
 }
 
+void sme_enable_dvmsync(void);
+void sme_set_active(void);
+void sme_clear_active(void);
+
+static inline void sme_enter_from_user_mode(void)
+{
+	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_4193714) &&
+	    test_thread_flag(TIF_SME))
+		sme_clear_active();
+}
+
+static inline void sme_exit_to_user_mode(void)
+{
+	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_4193714) &&
+	    test_thread_flag(TIF_SME))
+		sme_set_active();
+}
+
 #else
 
 static inline void sme_user_disable(void) { BUILD_BUG(); }
@@ -456,6 +474,9 @@ static inline size_t sme_state_size(struct task_struct const *task)
 	return 0;
 }
 
+static inline void sme_enter_from_user_mode(void) { }
+static inline void sme_exit_to_user_mode(void) { }
+
 #endif /* ! CONFIG_ARM64_SME */
 
 /* For use by EFI runtime services calls only */
diff --git a/arch/arm64/include/asm/tlbbatch.h b/arch/arm64/include/asm/tlbbatch.h
index fedb0b87b8db..6297631532e5 100644
--- a/arch/arm64/include/asm/tlbbatch.h
+++ b/arch/arm64/include/asm/tlbbatch.h
@@ -2,11 +2,17 @@
 #ifndef _ARCH_ARM64_TLBBATCH_H
 #define _ARCH_ARM64_TLBBATCH_H
 
+#include <linux/cpumask.h>
+
 struct arch_tlbflush_unmap_batch {
+#ifdef CONFIG_ARM64_ERRATUM_4193714
 	/*
-	 * For arm64, HW can do tlb shootdown, so we don't
-	 * need to record cpumask for sending IPI
+	 * Track CPUs that need SME DVMSync on completion of this batch.
+	 * Otherwise, the arm64 HW can do tlb shootdown, so we don't need to
+	 * record cpumask for sending IPI
 	 */
+	cpumask_var_t cpumask;
+#endif
 };
 
 #endif /* _ARCH_ARM64_TLBBATCH_H */
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index ba36e91aefb8..f53ab3ba0c48 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -80,6 +80,71 @@ static inline unsigned long get_trans_granule(void)
 	}
 }
 
+#ifdef CONFIG_ARM64_ERRATUM_4193714
+
+void sme_do_dvmsync(const struct cpumask *mask);
+
+static inline void sme_dvmsync(struct mm_struct *mm)
+{
+	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_4193714))
+		return;
+
+	sme_do_dvmsync(mm_cpumask(mm));
+}
+
+static inline void sme_dvmsync_add_pending(struct arch_tlbflush_unmap_batch *batch,
+					   struct mm_struct *mm)
+{
+	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_4193714))
+		return;
+
+	/*
+	 * Order the mm_cpumask() read after the hardware DVMSync.
+	 */
+	dsb(ish);
+	if (cpumask_empty(mm_cpumask(mm)))
+		return;
+
+	/*
+	 * Allocate the batch cpumask on first use. Fall back to an immediate
+	 * IPI for this mm in case of failure.
+	 */
+	if (!cpumask_available(batch->cpumask) &&
+	    !zalloc_cpumask_var(&batch->cpumask, GFP_ATOMIC)) {
+		sme_do_dvmsync(mm_cpumask(mm));
+		return;
+	}
+
+	cpumask_or(batch->cpumask, batch->cpumask, mm_cpumask(mm));
+}
+
+static inline void sme_dvmsync_batch(struct arch_tlbflush_unmap_batch *batch)
+{
+	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_4193714))
+		return;
+
+	if (!cpumask_available(batch->cpumask))
+		return;
+
+	sme_do_dvmsync(batch->cpumask);
+	cpumask_clear(batch->cpumask);
+}
+
+#else
+
+static inline void sme_dvmsync(struct mm_struct *mm)
+{
+}
+static inline void sme_dvmsync_add_pending(struct arch_tlbflush_unmap_batch *batch,
+					   struct mm_struct *mm)
+{
+}
+static inline void sme_dvmsync_batch(struct arch_tlbflush_unmap_batch *batch)
+{
+}
+
+#endif /* CONFIG_ARM64_ERRATUM_4193714 */
+
 /*
  * Level-based TLBI operations.
  *
@@ -189,12 +254,14 @@ static inline void __tlbi_sync_s1ish(struct mm_struct *mm)
 {
 	dsb(ish);
 	__repeat_tlbi_sync(vale1is, 0);
+	sme_dvmsync(mm);
 }
 
-static inline void __tlbi_sync_s1ish_batch(void)
+static inline void __tlbi_sync_s1ish_batch(struct arch_tlbflush_unmap_batch *batch)
 {
 	dsb(ish);
 	__repeat_tlbi_sync(vale1is, 0);
+	sme_dvmsync_batch(batch);
 }
 
 static inline void __tlbi_sync_s1ish_kernel(void)
@@ -357,7 +424,7 @@ static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
  */
 static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	__tlbi_sync_s1ish_batch();
+	__tlbi_sync_s1ish_batch(batch);
 }
 
 /*
@@ -546,6 +613,7 @@ static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *b
 		struct mm_struct *mm, unsigned long start, unsigned long end)
 {
 	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
+	sme_dvmsync_add_pending(batch, mm);
 }
 #endif
 
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8cb3b575a031..6c8c4301d9c6 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -11,6 +11,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/fpsimd.h>
 #include <asm/kvm_asm.h>
 #include <asm/smp_plat.h>
 
@@ -551,6 +552,23 @@ static const struct midr_range erratum_spec_ssbs_list[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_ERRATUM_4193714
+static bool has_sme_dvmsync_erratum(const struct arm64_cpu_capabilities *entry,
+				    int scope)
+{
+	if (!id_aa64pfr1_sme(read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1)))
+		return false;
+
+	return is_affected_midr_range(entry, scope);
+}
+
+static void cpu_enable_sme_dvmsync(const struct arm64_cpu_capabilities *__unused)
+{
+	if (this_cpu_has_cap(ARM64_WORKAROUND_4193714))
+		sme_enable_dvmsync();
+}
+#endif
+
 #ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38
 static const struct midr_range erratum_ac03_cpu_38_list[] = {
 	MIDR_ALL_VERSIONS(MIDR_AMPERE1),
@@ -870,6 +888,18 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_RANGE_LIST(erratum_spec_ssbs_list),
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_4193714
+	{
+		.desc = "C1-Pro SME DVMSync early acknowledgement",
+		.capability = ARM64_WORKAROUND_4193714,
+		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
+		.matches = has_sme_dvmsync_erratum,
+		.cpu_enable = cpu_enable_sme_dvmsync,
+		/* C1-Pro r0p0 - r1p2 (the latter only when REVIDR_EL1[0]==0) */
+		.midr_range = MIDR_RANGE(MIDR_C1_PRO, 0, 0, 1, 2),
+		MIDR_FIXED(MIDR_CPU_VAR_REV(1, 2), BIT(0)),
+	},
+#endif
 #ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	{
 		.desc = "ARM errata 2966298, 3117295",
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index a9c81715ce59..5b97dfcf796d 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -21,6 +21,7 @@
 #include <asm/daifflags.h>
 #include <asm/esr.h>
 #include <asm/exception.h>
+#include <asm/fpsimd.h>
 #include <asm/irq_regs.h>
 #include <asm/kprobes.h>
 #include <asm/mmu.h>
@@ -84,6 +85,7 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
 	mte_disable_tco_entry(current);
+	sme_enter_from_user_mode();
 }
 
 static __always_inline void arm64_enter_from_user_mode(struct pt_regs *regs)
@@ -102,6 +104,7 @@ static __always_inline void arm64_exit_to_user_mode(struct pt_regs *regs)
 	local_irq_disable();
 	exit_to_user_mode_prepare(regs);
 	local_daif_mask();
+	sme_exit_to_user_mode();
 	mte_check_tfsr_exit();
 	exit_to_user_mode();
 }
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e3f8f51748bc..ca18214ce2ab 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
+#include <linux/cpumask.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
 #include <linux/linkage.h>
@@ -28,6 +29,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
 #include <linux/swab.h>
@@ -1384,6 +1386,83 @@ void do_sve_acc(unsigned long esr, struct pt_regs *regs)
 	put_cpu_fpsimd_context();
 }
 
+#ifdef CONFIG_ARM64_ERRATUM_4193714
+
+/*
+ * SME/CME erratum handling.
+ */
+static cpumask_t sme_dvmsync_cpus;
+
+/*
+ * These helpers are only called from non-preemptible contexts, so
+ * smp_processor_id() is safe here.
+ */
+void sme_set_active(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (!cpumask_test_cpu(cpu, &sme_dvmsync_cpus))
+		return;
+
+	cpumask_set_cpu(cpu, mm_cpumask(current->mm));
+
+	/*
+	 * A subsequent (post ERET) SME access may use a stale address
+	 * translation. On C1-Pro, a TLBI+DSB on a different CPU will wait for
+	 * the completion of cpumask_set_cpu() above as it appears in program
+	 * order before the SME access. The post-TLBI+DSB read of mm_cpumask()
+	 * will lead to the IPI being issued.
+	 *
+	 * https://lore.kernel.org/r/ablEXwhfKyJW1i7l@J2N7QTR9R3
+	 */
+}
+
+void sme_clear_active(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (!cpumask_test_cpu(cpu, &sme_dvmsync_cpus))
+		return;
+
+	/*
+	 * With SCTLR_EL1.IESB enabled, the SME memory transactions are
+	 * completed on entering EL1.
+	 */
+	cpumask_clear_cpu(cpu, mm_cpumask(current->mm));
+}
+
+static void sme_dvmsync_ipi(void *unused)
+{
+	/*
+	 * With SCTLR_EL1.IESB on, taking an exception is sufficient to ensure
+	 * the completion of the SME memory accesses, so no need for an
+	 * explicit DSB.
+	 */
+}
+
+void sme_do_dvmsync(const struct cpumask *mask)
+{
+	/*
+	 * This is called from the TLB maintenance functions after the DSB ISH
+	 * to send the hardware DVMSync message. If this CPU sees the mask as
+	 * empty, the remote CPU executing sme_set_active() would have seen
+	 * the DVMSync and no IPI required.
+	 */
+	if (cpumask_empty(mask))
+		return;
+
+	preempt_disable();
+	smp_call_function_many(mask, sme_dvmsync_ipi, NULL, true);
+	preempt_enable();
+}
+
+void sme_enable_dvmsync(void)
+{
+	cpumask_set_cpu(smp_processor_id(), &sme_dvmsync_cpus);
+}
+
+#endif /* CONFIG_ARM64_ERRATUM_4193714 */
+
 /*
  * Trapped SME access
  *
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 489554931231..4c328b7c79ba 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/cpumask.h>
 #include <linux/cpu.h>
 #include <linux/elfcore.h>
 #include <linux/pm.h>
@@ -339,8 +340,41 @@ void flush_thread(void)
 	flush_gcs();
 }
 
+#ifdef CONFIG_ARM64_ERRATUM_4193714
+
+static void arch_dup_tlbbatch_mask(struct task_struct *dst)
+{
+	/*
+	 * Clear the inherited cpumask with memset() to cover both cases where
+	 * cpumask_var_t is a pointer or an array. It will be allocated lazily
+	 * in sme_dvmsync_add_pending() if CPUMASK_OFFSTACK=y.
+	 */
+	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_4193714))
+		memset(&dst->tlb_ubc.arch.cpumask, 0,
+		       sizeof(dst->tlb_ubc.arch.cpumask));
+}
+
+static void arch_release_tlbbatch_mask(struct task_struct *tsk)
+{
+	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_4193714))
+		free_cpumask_var(tsk->tlb_ubc.arch.cpumask);
+}
+
+#else
+
+static void arch_dup_tlbbatch_mask(struct task_struct *dst)
+{
+}
+
+static void arch_release_tlbbatch_mask(struct task_struct *tsk)
+{
+}
+
+#endif /* CONFIG_ARM64_ERRATUM_4193714 */
+
 void arch_release_task_struct(struct task_struct *tsk)
 {
+	arch_release_tlbbatch_mask(tsk);
 	fpsimd_release_task(tsk);
 }
 
@@ -356,6 +390,8 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 
 	*dst = *src;
 
+	arch_dup_tlbbatch_mask(dst);
+
 	/*
 	 * Drop stale reference to src's sve_state and convert dst to
 	 * non-streaming FPSIMD mode.
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 1b32c1232d28..16d123088ddd 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -101,6 +101,7 @@ WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
+WORKAROUND_4193714
 WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_AMPERE_AC04_CPU_23
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE

