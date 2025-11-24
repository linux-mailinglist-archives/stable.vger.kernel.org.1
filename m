Return-Path: <stable+bounces-196694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527EC80B58
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40DA54E3D3B
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037E44AEE2;
	Mon, 24 Nov 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guS/axBu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137C1A275
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990541; cv=none; b=DwYFHD0vrM+4x0xjwK4+Lm1DNpY76UJMYguCouxlSpYi0r4euBCXGnohQUABYlZzUh1UIKX+/vO4DIKvrceVWWUSagU7Gs4Gn8ppKVr9fSGtzurDGNKNBOgfMQiOmHxrXru5T+m20D2yKY8bXJfMrWbC0rYhlfVk70Gg/yZahTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990541; c=relaxed/simple;
	bh=QVdnnhP1IQSEevA3AFg1EMsJ76hseFpah694sh+Cth0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z02g8quQ+lIBi+c/0UYpwLP1Gd03JKgTsPkkWNquEAEzYRu7fk8E3q8SA8peBBS8JJXu283J9fFXj/ztOJd3J6RlpQ+YXaUwN6YIkz/+n1M/ZVGb6KxYf2WAxwcT6QZoTpRo2ib2hCJfHGC8Gj5G+oMJrrAz6v14d07UXhby/4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guS/axBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E258FC4CEF1;
	Mon, 24 Nov 2025 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990541;
	bh=QVdnnhP1IQSEevA3AFg1EMsJ76hseFpah694sh+Cth0=;
	h=Subject:To:Cc:From:Date:From;
	b=guS/axButqbsLI/jVh4bnxSaaakIm1b6NvbGOX+dZfpXU0cBEbvk95ehuzAqjjnW7
	 Eo1UR8jB5wwQO5R+IfgmoC33PiskorYb+0vQNWPtDrMd8xoMNUJB9DsDCrfN2EIksx
	 e09JgVgvGfcBmT8tFG53P6yiHZcJZaS5ldefusvQ=
Subject: FAILED: patch "[PATCH] s390/mm: Fix __ptep_rdp() inline assembly" failed to apply to 6.12-stable tree
To: hca@linux.ibm.com,gerald.schaefer@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:22:18 +0100
Message-ID: <2025112418-impish-remix-d936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 31475b88110c4725b4f9a79c3a0d9bbf97e69e1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112418-impish-remix-d936@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 31475b88110c4725b4f9a79c3a0d9bbf97e69e1c Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Thu, 13 Nov 2025 13:21:47 +0100
Subject: [PATCH] s390/mm: Fix __ptep_rdp() inline assembly

When a zero ASCE is passed to the __ptep_rdp() inline assembly, the
generated instruction should have the R3 field of the instruction set to
zero. However the inline assembly is written incorrectly: for such cases a
zero is loaded into a register allocated by the compiler and this register
is then used by the instruction.

This means that selected TLB entries may not be flushed since the specified
ASCE does not match the one which was used when the selected TLB entries
were created.

Fix this by removing the asce and opt parameters of __ptep_rdp(), since
all callers always pass zero, and use a hard-coded register zero for
the R3 field.

Fixes: 0807b856521f ("s390/mm: add support for RDP (Reset DAT-Protection)")
Cc: stable@vger.kernel.org
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index b7100c6a4054..6663f1619abb 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1154,17 +1154,15 @@ static inline pte_t pte_mkhuge(pte_t pte)
 #define IPTE_NODAT	0x400
 #define IPTE_GUEST_ASCE	0x800
 
-static __always_inline void __ptep_rdp(unsigned long addr, pte_t *ptep,
-				       unsigned long opt, unsigned long asce,
-				       int local)
+static __always_inline void __ptep_rdp(unsigned long addr, pte_t *ptep, int local)
 {
 	unsigned long pto;
 
 	pto = __pa(ptep) & ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
-	asm volatile(".insn rrf,0xb98b0000,%[r1],%[r2],%[asce],%[m4]"
+	asm volatile(".insn	rrf,0xb98b0000,%[r1],%[r2],%%r0,%[m4]"
 		     : "+m" (*ptep)
-		     : [r1] "a" (pto), [r2] "a" ((addr & PAGE_MASK) | opt),
-		       [asce] "a" (asce), [m4] "i" (local));
+		     : [r1] "a" (pto), [r2] "a" (addr & PAGE_MASK),
+		       [m4] "i" (local));
 }
 
 static __always_inline void __ptep_ipte(unsigned long address, pte_t *ptep,
@@ -1348,7 +1346,7 @@ static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
 	 * A local RDP can be used to do the flush.
 	 */
 	if (cpu_has_rdp() && !(pte_val(*ptep) & _PAGE_PROTECT))
-		__ptep_rdp(address, ptep, 0, 0, 1);
+		__ptep_rdp(address, ptep, 1);
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0fde20bbc50b..05974304d622 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -274,9 +274,9 @@ void ptep_reset_dat_prot(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	preempt_disable();
 	atomic_inc(&mm->context.flush_count);
 	if (cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
-		__ptep_rdp(addr, ptep, 0, 0, 1);
+		__ptep_rdp(addr, ptep, 1);
 	else
-		__ptep_rdp(addr, ptep, 0, 0, 0);
+		__ptep_rdp(addr, ptep, 0);
 	/*
 	 * PTE is not invalidated by RDP, only _PAGE_PROTECT is cleared. That
 	 * means it is still valid and active, and must not be changed according


