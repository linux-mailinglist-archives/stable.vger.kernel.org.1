Return-Path: <stable+bounces-139866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E107AAA138
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCFE1885FAA
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822B29B233;
	Mon,  5 May 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLx74lke"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0391629B22C;
	Mon,  5 May 2025 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483570; cv=none; b=jy2qaprp9amXUBSzVwU2ZrGvUUbAQmuNHeOaD5zRge9ZIE7hIkplSLbSqN5MAqldSLZ0Lhx7hhI5xrUpM5I3+u5Q8tVqHAfHVcRS/BVfODnxqPHTWSv2Vqb0JecnW1RUrN+U9GhWQv14Tjp3V3nOEOYU277qlH0KaI6FptFhxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483570; c=relaxed/simple;
	bh=9tNZxUuqG1AtGoHQhp8p2F/QBEZIRb2NRve237ywaYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krnlCq3EIlOu1ge2+11ReUPqADqmuDfHj5qXn6OPX89DJVHYnNp3N7Fsnw9YopGlgSsUQS8B7/0ZDsrBqe4SsCZ2kFOB5TUo0XqghIX4iY9VCZjHafl1XPKgYberX5Dtj1H9FC3QMvZ0nh3WbsI/ZeddkJIZ/wzhzGO4s/dak5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLx74lke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE58C4CEE4;
	Mon,  5 May 2025 22:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483569;
	bh=9tNZxUuqG1AtGoHQhp8p2F/QBEZIRb2NRve237ywaYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLx74lkeADkjNOs/GmXzgzjrvGV/gk0z1f5hOhkKaDCLSE+ImbdCjpgvS4k0DV7Sg
	 cT9tO9f/kyYrjYaXnoUy/M14X7KG0wtwM1e3DKgWT1yUwLbPrVuzwRZBGjaZhOxwc9
	 7wperGK+tiPAXHHDvfFQNustOvk9CS8hdPNhR5IvQkG2CnF+OQGv1vrMY73QAZtCD1
	 STgNj+XcAIsjp1wCTnjD1bCbyFxOhw9Sb+vVVZIr4X3evc3Jdn/3LzeTd9gYmadG9+
	 iWrXOwG6NH2W742G8rlDV/PmUVQc6sY5C1ERquPko/JpVbq7PwCMZ0RvIIDM0adbj6
	 NhnB9ON/2uZAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	will@kernel.org,
	wangkefeng.wang@huawei.com,
	baohua@kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 119/642] riscv: Call secondary mmu notifier when flushing the tlb
Date: Mon,  5 May 2025 18:05:35 -0400
Message-Id: <20250505221419.2672473-119-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit d9be2b9b60497a82aeceec3a98d8b37fdd2960f2 ]

This is required to allow the IOMMU driver to correctly flush its own
TLB.

Reviewed-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://lore.kernel.org/r/20250113142424.30487-1-alexghiti@rivosinc.com
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/mm/tlbflush.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9b6e86ce38674..bb77607c87aa2 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/hugetlb.h>
+#include <linux/mmu_notifier.h>
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
@@ -78,10 +79,17 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static void __flush_tlb_range(const struct cpumask *cmask, unsigned long asid,
+static inline unsigned long get_mm_asid(struct mm_struct *mm)
+{
+	return mm ? cntx2asid(atomic_long_read(&mm->context.id)) : FLUSH_TLB_NO_ASID;
+}
+
+static void __flush_tlb_range(struct mm_struct *mm,
+			      const struct cpumask *cmask,
 			      unsigned long start, unsigned long size,
 			      unsigned long stride)
 {
+	unsigned long asid = get_mm_asid(mm);
 	unsigned int cpu;
 
 	if (cpumask_empty(cmask))
@@ -105,30 +113,26 @@ static void __flush_tlb_range(const struct cpumask *cmask, unsigned long asid,
 	}
 
 	put_cpu();
-}
 
-static inline unsigned long get_mm_asid(struct mm_struct *mm)
-{
-	return cntx2asid(atomic_long_read(&mm->context.id));
+	if (mm)
+		mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + size);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
-			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+	__flush_tlb_range(mm, mm_cpumask(mm), 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 }
 
 void flush_tlb_mm_range(struct mm_struct *mm,
 			unsigned long start, unsigned long end,
 			unsigned int page_size)
 {
-	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
-			  start, end - start, page_size);
+	__flush_tlb_range(mm, mm_cpumask(mm), start, end - start, page_size);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  addr, PAGE_SIZE, PAGE_SIZE);
 }
 
@@ -161,13 +165,13 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  start, end - start, stride_size);
 }
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	__flush_tlb_range(cpu_online_mask, FLUSH_TLB_NO_ASID,
+	__flush_tlb_range(NULL, cpu_online_mask,
 			  start, end - start, PAGE_SIZE);
 }
 
@@ -175,7 +179,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end)
 {
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  start, end - start, PMD_SIZE);
 }
 #endif
@@ -189,7 +193,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
 			       struct mm_struct *mm,
 			       unsigned long uaddr)
 {
+	unsigned long start = uaddr & PAGE_MASK;
+
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
+	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + PAGE_SIZE);
 }
 
 void arch_flush_tlb_batched_pending(struct mm_struct *mm)
@@ -199,7 +206,7 @@ void arch_flush_tlb_batched_pending(struct mm_struct *mm)
 
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 {
-	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
-			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
+	__flush_tlb_range(NULL, &batch->cpumask,
+			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
 	cpumask_clear(&batch->cpumask);
 }
-- 
2.39.5


