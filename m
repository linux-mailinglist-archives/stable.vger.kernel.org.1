Return-Path: <stable+bounces-79499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8A998D8C6
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485C228556D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5A1CFEB3;
	Wed,  2 Oct 2024 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r8PvdhTL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49961D0E3E;
	Wed,  2 Oct 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877637; cv=none; b=LcwQgWNpMbMUJtVHDVT9abv52Y3fitmxCtAEE0ePaWguFZZthaJ1PXTzTomDDTFrirYTpP0JazQGO1oylK2d78JKGSyYyP8XTA30Wce2k0dmGFwm/llOBZ8sZ2thjBfq15Vu6dbOSxZ39N+AoN41aKbkBASq9ClAjUUfwDqSR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877637; c=relaxed/simple;
	bh=GP9sCAn1C6fAWpaQyk50YgScyCaKq5/OFvrsqmIqUcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq7yTyuILlsU7PLa2ZUpH8xgu1s43Sp1V/2t69ewFtoJ+2eTLKcLAbOE/8HwZnnABZpELFQwl97iZ9ne30AA7Nr2+RbwbsPFrYFDZCI+YJajqtVc+dbeSE+0vkEpj8cYNz9OP9rMB3dnkHaUl1KRF84IXtIVahJPIIDLmeRGvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r8PvdhTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAE7C4CEC2;
	Wed,  2 Oct 2024 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877637;
	bh=GP9sCAn1C6fAWpaQyk50YgScyCaKq5/OFvrsqmIqUcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8PvdhTLIJLpWSqD0A2ZtXmcq4DEP+pNooc/8+JJPtIPBxZ2bbTgBA5I5eAsroT/y
	 Pf1zkqXJglqTZe16aERQutOo2Wp+4riLdyRyh1dDWEe2J0bynbxtjKNnj4SQH6tQlD
	 G1AjMkQ28cxx8YnVsAJvc6/+PnGGhlmXcCiC/lkc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Lutomirski <luto@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 143/634] x86/mm: Use IPIs to synchronize LAM enablement
Date: Wed,  2 Oct 2024 14:54:03 +0200
Message-ID: <20241002125816.749875283@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yosry Ahmed <yosryahmed@google.com>

[ Upstream commit 3b299b99556c1753923f8d9bbd9304bcd139282f ]

LAM can only be enabled when a process is single-threaded.  But _kernel_
threads can temporarily use a single-threaded process's mm.

If LAM is enabled by a userspace process while a kthread is using its
mm, the kthread will not observe LAM enablement (i.e.  LAM will be
disabled in CR3). This could be fine for the kthread itself, as LAM only
affects userspace addresses. However, if the kthread context switches to
a thread in the same userspace process, CR3 may or may not be updated
because the mm_struct doesn't change (based on pending TLB flushes). If
CR3 is not updated, the userspace thread will run incorrectly with LAM
disabled, which may cause page faults when using tagged addresses.
Example scenario:

CPU 1                                   CPU 2
/* kthread */
kthread_use_mm()
                                        /* user thread */
                                        prctl_enable_tagged_addr()
                                        /* LAM enabled on CPU 2 */
/* LAM disabled on CPU 1 */
                                        context_switch() /* to CPU 1 */
/* Switching to user thread */
switch_mm_irqs_off()
/* CR3 not updated */
/* LAM is still disabled on CPU 1 */

Synchronize LAM enablement by sending an IPI to all CPUs running with
the mm_struct to enable LAM. This makes sure LAM is enabled on CPU 1
in the above scenario before prctl_enable_tagged_addr() returns and
userspace starts using tagged addresses, and before it's possible to
run the userspace process on CPU 1.

In switch_mm_irqs_off(), move reading the LAM mask until after
mm_cpumask() is updated. This ensures that if an outdated LAM mask is
written to CR3, an IPI is received to update it right after IRQs are
re-enabled.

[ dhansen: Add a LAM enabling helper and comment it ]

Fixes: 82721d8b25d7 ("x86/mm: Handle LAM on context switch")
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20240702132139.3332013-2-yosryahmed%40google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/process_64.c | 29 ++++++++++++++++++++++++++---
 arch/x86/mm/tlb.c            |  7 +++----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6d3d20e3e43a9..d8d582b750d4f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -798,6 +798,27 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 #define LAM_U57_BITS 6
 
+static void enable_lam_func(void *__mm)
+{
+	struct mm_struct *mm = __mm;
+
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
+		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
+		set_tlbstate_lam_mode(mm);
+	}
+}
+
+static void mm_enable_lam(struct mm_struct *mm)
+{
+	/*
+	 * Even though the process must still be single-threaded at this
+	 * point, kernel threads may be using the mm.  IPI those kernel
+	 * threads if they exist.
+	 */
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+}
+
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_LAM))
@@ -814,6 +835,10 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
+	/*
+	 * MM_CONTEXT_LOCK_LAM is set on clone.  Prevent LAM from
+	 * being enabled unless the process is single threaded:
+	 */
 	if (test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags)) {
 		mmap_write_unlock(mm);
 		return -EBUSY;
@@ -830,9 +855,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EINVAL;
 	}
 
-	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-	set_tlbstate_lam_mode(mm);
-	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+	mm_enable_lam(mm);
 
 	mmap_write_unlock(mm);
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047c..a041d2ecd8380 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -503,9 +503,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 {
 	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
+	unsigned long new_lam;
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
@@ -619,9 +619,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 		}
 
-		/*
-		 * Start remote flushes and then read tlb_gen.
-		 */
+		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
 		if (next != &init_mm)
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
@@ -633,6 +631,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		barrier();
 	}
 
+	new_lam = mm_lam_cr3_mask(next);
 	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
-- 
2.43.0




