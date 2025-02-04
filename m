Return-Path: <stable+bounces-112099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3335A269AC
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 02:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692B5161DB8
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 01:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E9919E83E;
	Tue,  4 Feb 2025 01:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA46vTEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95081993B7;
	Tue,  4 Feb 2025 01:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631914; cv=none; b=j6UjAG/muKprqzK7Vi/olUlrRKh1LnqfPj6myJoXoTWtDv+FbaackA3gImZP468BbfClNCVW8WDAPN5J0s2HXe9qFLpOoQtjRhJAqdJ3W+zBtYvOXBrSGfnGjncerZoccDFlHdkCwAJMTj25qrJ5intc++NI4Pg7SQizJ8qDJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631914; c=relaxed/simple;
	bh=mxhC4edHVa6XrvQsYK4JhAzJcV0u+cR3t3YfAjPBDuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mS0HwNyILjJi3touH0ObnJVtgAs9MLHmhokXXM6JyDFw3NuAQrJGIkZRFtWjuoNI/AHjhNLI9gMUvtaMLJ707XSqwCYeA0fT0/TXcIwsYbUWaM3WtfngXLmG37U4BOx3Bk+bRDHyEDbTpA6n1qDRXXLZ9kzLB++tHF88fwqS+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA46vTEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62615C4CEE0;
	Tue,  4 Feb 2025 01:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738631914;
	bh=mxhC4edHVa6XrvQsYK4JhAzJcV0u+cR3t3YfAjPBDuM=;
	h=From:To:Cc:Subject:Date:From;
	b=kA46vTEwsqrqQVm37Yy+pppagSG7fRNgjOHOnUTE/4Kx1qT4Qd4E7B/vjDkj7rrzj
	 aD8QnTORV6gh7q4QGMk+Bd9iNuEnpW11AkNZEMks4psAP81NlxUN2eQBruW6IXsMB3
	 F6uMaRxdY4mQsH3YkQWVvboaSdjTSi1fY03w+osr/qi6JtEYvXZB4oVtffBRS7Yn9I
	 5DZCW1+9x3LebPBCQtTh8IeLJ6Jel61io3+m7wOghzJc9qsX/MMMsh4uVePn9zBmVc
	 Qizjd9BsWDaHNpMDw8TPUgL9tzuCrOpjXS7LuF/SsuD5QCmgNibLDKcYCsUNOmkcd+
	 uuP3ooyo1TvDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rik van Riel <riel@fb.com>,
	kernel test roboto <oliver.sang@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	akpm@linux-foundation.org,
	yosry.ahmed@linux.dev,
	Liam.Howlett@oracle.com,
	kirill.shutemov@linux.intel.com,
	mpe@ellerman.id.au
Subject: [PATCH AUTOSEL 6.1 1/3] x86/mm/tlb: Only trim the mm_cpumask once a second
Date: Mon,  3 Feb 2025 20:18:23 -0500
Message-Id: <20250204011828.2207072-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@fb.com>

[ Upstream commit 6db2526c1d694c91c6e05e2f186c085e9460f202 ]

Setting and clearing CPU bits in the mm_cpumask is only ever done
by the CPU itself, from the context switch code or the TLB flush
code.

Synchronization is handled by switch_mm_irqs_off() blocking interrupts.

Sending TLB flush IPIs to CPUs that are in the mm_cpumask, but no
longer running the program causes a regression in the will-it-scale
tlbflush2 test. This test is contrived, but a large regression here
might cause a small regression in some real world workload.

Instead of always sending IPIs to CPUs that are in the mm_cpumask,
but no longer running the program, send these IPIs only once a second.

The rest of the time we can skip over CPUs where the loaded_mm is
different from the target mm.

Reported-by: kernel test roboto <oliver.sang@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241204210316.612ee573@fangorn
Closes: https://lore.kernel.org/oe-lkp/202411282207.6bd28eae-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/mmu.h         |  2 ++
 arch/x86/include/asm/mmu_context.h |  1 +
 arch/x86/include/asm/tlbflush.h    |  1 +
 arch/x86/mm/tlb.c                  | 35 +++++++++++++++++++++++++++---
 4 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea95..c07c018a1c139 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -33,6 +33,8 @@ typedef struct {
 	 */
 	atomic64_t tlb_gen;
 
+	unsigned long next_trim_cpumask;
+
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct rw_semaphore	ldt_usr_sem;
 	struct ldt_struct	*ldt;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00f..6f5c7584fe1e3 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -106,6 +106,7 @@ static inline int init_new_context(struct task_struct *tsk,
 
 	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
 	atomic64_set(&mm->context.tlb_gen, 0);
+	mm->context.next_trim_cpumask = jiffies + HZ;
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27d..d1eb6bbfd39e3 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -208,6 +208,7 @@ struct flush_tlb_info {
 	unsigned int		initiating_cpu;
 	u8			stride_shift;
 	u8			freed_tables;
+	u8			trim_cpumask;
 };
 
 void flush_tlb_local(void);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c1e31e9a85d76..b07e2167fcebf 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -878,9 +878,36 @@ static void flush_tlb_func(void *info)
 			nr_invalidate);
 }
 
-static bool tlb_is_not_lazy(int cpu, void *data)
+static bool should_flush_tlb(int cpu, void *data)
 {
-	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
+	struct flush_tlb_info *info = data;
+
+	/* Lazy TLB will get flushed at the next context switch. */
+	if (per_cpu(cpu_tlbstate_shared.is_lazy, cpu))
+		return false;
+
+	/* No mm means kernel memory flush. */
+	if (!info->mm)
+		return true;
+
+	/* The target mm is loaded, and the CPU is not lazy. */
+	if (per_cpu(cpu_tlbstate.loaded_mm, cpu) == info->mm)
+		return true;
+
+	/* In cpumask, but not the loaded mm? Periodically remove by flushing. */
+	if (info->trim_cpumask)
+		return true;
+
+	return false;
+}
+
+static bool should_trim_cpumask(struct mm_struct *mm)
+{
+	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
+		WRITE_ONCE(mm->context.next_trim_cpumask, jiffies + HZ);
+		return true;
+	}
+	return false;
 }
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state_shared, cpu_tlbstate_shared);
@@ -914,7 +941,7 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	if (info->freed_tables)
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
+		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
 				(void *)info, 1, cpumask);
 }
 
@@ -965,6 +992,7 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	info->freed_tables	= freed_tables;
 	info->new_tlb_gen	= new_tlb_gen;
 	info->initiating_cpu	= smp_processor_id();
+	info->trim_cpumask	= 0;
 
 	return info;
 }
@@ -1007,6 +1035,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * flush_tlb_func_local() directly in this case.
 	 */
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+		info->trim_cpumask = should_trim_cpumask(mm);
 		flush_tlb_multi(mm_cpumask(mm), info);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
-- 
2.39.5


