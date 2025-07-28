Return-Path: <stable+bounces-164904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AACB13901
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 12:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF08A1893C4C
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 10:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624A8248F4B;
	Mon, 28 Jul 2025 10:31:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F619213E89;
	Mon, 28 Jul 2025 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698710; cv=none; b=Ysci7fVF+S6tUgGpzk+jH84+7nAzdRKhBnpJn1h66mDqqB5AYngz0ItM9Retqh22E71y42j8rdZMon4H+tCZgTt4Wj++gy1k2CgEpqnfdK2kan4x2vxaMl6MXU0NjxDg1DFP2dXDNjjRDW++b5Bj4qDGiDrfUECKxGYw9cvP+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698710; c=relaxed/simple;
	bh=1mIXaQLVma8tjoBewSPrGSnMUY8R39so72XipdZv+uM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EU5yzDKl5MJTGeHTG1dL6r0IrpJzMbMQtXUvLxlu95Gob86W+MZ+pIl4Qe6Aia7/xG+ORBT1mNZTWIV9SQyZ2fft6QVHSfrROrySXRYRMKZNNoZ9ltkjrcRiDODyroPnN276DI8pLW2YvBz68o6QKXYL+ub8RfNdsx0TkMI5L/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88D50153B;
	Mon, 28 Jul 2025 03:31:39 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (unknown [10.164.18.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 073EB3F673;
	Mon, 28 Jul 2025 03:31:42 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: anshuman.khandual@arm.com,
	quic_zhenhuah@quicinc.com,
	ryan.roberts@arm.com,
	kevin.brodsky@arm.com,
	yangyicong@hisilicon.com,
	joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	Dev Jain <dev.jain@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64/mm: Fix use-after-free due to race between memory hotunplug and ptdump
Date: Mon, 28 Jul 2025 16:01:37 +0530
Message-Id: <20250728103137.94726-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory hotunplug is done under the hotplug lock and ptdump walk is done
under the init_mm.mmap_lock. Therefore, ptdump and hotunplug can run
simultaneously without any synchronization. During hotunplug,
free_empty_tables() is ultimately called to free up the pagetables.
The following race can happen, where x denotes the level of the pagetable:

CPU1					CPU2
free_empty_pxd_table
					ptdump_walk_pgd()
					Get p(x+1)d table from pxd entry
pxd_clear
free_hotplug_pgtable_page(p(x+1)dp)
					Still using the p(x+1)d table

which leads to a user-after-free.

To solve this, we need to synchronize ptdump_walk_pgd() with
free_hotplug_pgtable_page() in such a way that ptdump never takes a
reference on a freed pagetable.

Since this race is very unlikely to happen in practice, we do not want to
penalize other code paths taking the init_mm mmap_lock. Therefore, we use
static keys. ptdump will enable the static key - upon observing that,
the free_empty_pxd_table() functions will get patched in with an
mmap_read_lock/unlock sequence. A code comment explains in detail, how
a combination of acquire semantics of static_branch_enable() and the
barriers in __flush_tlb_kernel_pgtable() ensures that ptdump will never
get a hold on the address of a freed pagetable - either ptdump will block
the table freeing path due to write locking the mmap_lock, or, the nullity
of the pxd entry will be observed by ptdump, therefore having no access to
the isolated p(x+1)d pagetable.

This bug was found by code inspection, as a result of working on [1].
1. https://lore.kernel.org/all/20250723161827.15802-1-dev.jain@arm.com/

Cc: <stable@vger.kernel.org>
Fixes: bbd6ec605c0f ("arm64/mm: Enable memory hot remove")
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
Rebased on Linux 6.16.

 arch/arm64/include/asm/ptdump.h |  2 ++
 arch/arm64/mm/mmu.c             | 61 +++++++++++++++++++++++++++++++++
 arch/arm64/mm/ptdump.c          | 11 ++++--
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index fded5358641f..4760168cbd6e 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -7,6 +7,8 @@
 
 #include <linux/ptdump.h>
 
+DECLARE_STATIC_KEY_FALSE(arm64_ptdump_key);
+
 #ifdef CONFIG_PTDUMP
 
 #include <linux/mm_types.h>
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 00ab1d648db6..d2feef270880 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -46,6 +46,8 @@
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
 
+DEFINE_STATIC_KEY_FALSE(arm64_ptdump_key);
+
 enum pgtable_type {
 	TABLE_PTE,
 	TABLE_PMD,
@@ -1002,6 +1004,61 @@ static void unmap_hotplug_range(unsigned long addr, unsigned long end,
 	} while (addr = next, addr < end);
 }
 
+/*
+ * Our objective is to prevent ptdump from reading a pagetable which has
+ * been freed.  Assume that ptdump_walk_pgd() (call this thread T1)
+ * executes completely on CPU1 and free_hotplug_pgtable_page() (call this
+ * thread T2) executes completely on CPU2. Let the region sandwiched by the
+ * mmap_write_lock/unlock in T1 be called CS (the critical section).
+ *
+ * Claim: The CS of T1 will never operate on a freed pagetable.
+ *
+ * Proof:
+ *
+ * Case 1: The static branch is visible to T2.
+ *
+ * Case 1 (a): T1 acquires the lock before T2 can.
+ * T2 will block until T1 drops the lock, so free_hotplug_pgtable_page() will
+ * only be executed after T1 exits CS.
+ *
+ * Case 1 (b): T2 acquires the lock before T1 can.
+ * The acquire semantics of mmap_read_lock() ensure that an empty pagetable
+ * entry (via pxd_clear()) is visible to T1 before T1 can enter CS, therefore
+ * it is impossible for the CS to get hold of the isolated level + 1 pagetable.
+ *
+ * Case 2: The static branch is not visible to T2.
+ *
+ * Since static_branch_enable() and mmap_write_lock() (via smp_mb()) have
+ * acquire semantics, it implies that the static branch will be visible to
+ * all CPUs before T1 can enter CS. The static branch not being visible to
+ * T2 therefore implies that T1 has not yet entered CS .... (i)
+ *
+ * The sequence of barriers via __flush_tlb_kernel_pgtable() in T2
+ * implies that if the invisibility of the static branch has been
+ * observed by T2 (i.e static_branch_unlikely() is observed as false),
+ * then all CPUs will have observed an empty pagetable entry via
+ * pxd_clear() ... (ii)
+ *
+ * Combining (i) and (ii), we conclude that T1 observes an empty pagetable
+ * entry before entering CS => it is impossible for the CS to get hold of
+ * the isolated level + 1 pagetable. Q.E.D
+ *
+ * We have proven that the claim is true on the assumption that
+ * there is no context switch for T1 and T2. Note that the reasoning
+ * of the proof uses barriers operating on the inner shareable domain,
+ * which means that they will affect all CPUs, and also a context switch
+ * will insert extra barriers into the code paths => the claim will
+ * stand true even if we drop the assumption.
+ */
+static void synchronize_with_ptdump(void)
+{
+	if (!static_branch_unlikely(&arm64_ptdump_key))
+		return;
+
+	mmap_read_lock(&init_mm);
+	mmap_read_unlock(&init_mm);
+}
+
 static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
 				 unsigned long end, unsigned long floor,
 				 unsigned long ceiling)
@@ -1036,6 +1093,7 @@ static void free_empty_pte_table(pmd_t *pmdp, unsigned long addr,
 
 	pmd_clear(pmdp);
 	__flush_tlb_kernel_pgtable(start);
+	synchronize_with_ptdump();
 	free_hotplug_pgtable_page(virt_to_page(ptep));
 }
 
@@ -1076,6 +1134,7 @@ static void free_empty_pmd_table(pud_t *pudp, unsigned long addr,
 
 	pud_clear(pudp);
 	__flush_tlb_kernel_pgtable(start);
+	synchronize_with_ptdump();
 	free_hotplug_pgtable_page(virt_to_page(pmdp));
 }
 
@@ -1116,6 +1175,7 @@ static void free_empty_pud_table(p4d_t *p4dp, unsigned long addr,
 
 	p4d_clear(p4dp);
 	__flush_tlb_kernel_pgtable(start);
+	synchronize_with_ptdump();
 	free_hotplug_pgtable_page(virt_to_page(pudp));
 }
 
@@ -1156,6 +1216,7 @@ static void free_empty_p4d_table(pgd_t *pgdp, unsigned long addr,
 
 	pgd_clear(pgdp);
 	__flush_tlb_kernel_pgtable(start);
+	synchronize_with_ptdump();
 	free_hotplug_pgtable_page(virt_to_page(p4dp));
 }
 
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 421a5de806c6..d543c9f8ffa8 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -283,6 +283,13 @@ void note_page_flush(struct ptdump_state *pt_st)
 	note_page(pt_st, 0, -1, pte_val(pte_zero));
 }
 
+static void arm64_ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm)
+{
+	static_branch_enable(&arm64_ptdump_key);
+	ptdump_walk_pgd(st, mm, NULL);
+	static_branch_disable(&arm64_ptdump_key);
+}
+
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 {
 	unsigned long end = ~0UL;
@@ -311,7 +318,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, info->mm, NULL);
+	arm64_ptdump_walk_pgd(&st.ptdump, info->mm);
 }
 
 static void __init ptdump_initialize(void)
@@ -353,7 +360,7 @@ bool ptdump_check_wx(void)
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
+	arm64_ptdump_walk_pgd(&st.ptdump, &init_mm);
 
 	if (st.wx_pages || st.uxn_pages) {
 		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found, %lu non-UXN pages found\n",
-- 
2.30.2


