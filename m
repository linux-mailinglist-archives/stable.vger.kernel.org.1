Return-Path: <stable+bounces-135873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4880A9901E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 529AD7B005A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B4290BC5;
	Wed, 23 Apr 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JyIjc6P4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EHVZUP7k"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871128D849;
	Wed, 23 Apr 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421066; cv=none; b=s9EbO4SpOpTriTAR64K65B0KOh4bPIT6BW5idJYLOiM5YGU0uSZFbdImA/Ypsmg2o5HJHAowVMF6aDsujSkMIdPNSPrin+tjhZH5t/uUn3UwsablSlrKt9XSqzXP8zDOBuUvzmafIYTOSWozyByQNDdFAt9GHkJcOAJ+P6PDBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421066; c=relaxed/simple;
	bh=3Di99da41+qMjMtTmt4vHje94p895LiHCPSvw1Hu7lg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sRDsVY73KrkI1QYIshehQUCYwRvPz9Oo/JxqBIhb8DKR0goz8K8kky/Pisg907FdHObpkHADQN5xUfzJLJRMBjUZhkjM7aK+dTKQ0ZgTggAti3PQ3s5bdgydKDP6Gsd5yudxmKtaLHdDlT/VDhrhX+Fw1SO5HphDhPkL9lNXchs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JyIjc6P4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EHVZUP7k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Apr 2025 15:10:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745421062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BEGNVsuzeqAKKmzVHLqEk0GLgkV1Mzj2EoAKCSxOcAM=;
	b=JyIjc6P421JhU9WROCMGVeA2gp4FYBI1r0XP/R3Tou/QxAXLgTyEm7iAaK4dgu3c1cr6h8
	9g/3NbNtzq62Pq8ttRmtw8kuyl6uI8pFIf+SjGIZuVS1y39NZRt0dhZAhE/KkZpwb/Prod
	Q6minpkhbkxaNGngpHZCPgeZ3EUkEhUmoCjfk34IAumuJNnMJyd6Cf3/22sn+FXpvMEc5c
	aMpZNaP7lsLsDqQ8R4WgkKrBalSkGDydWQCe+KFF9vUfTtjKwKpjQH7etjl1PqvX2/OyY/
	Aikl/FAgqEOzTE0HFkCU+wlBVsXHl2mfpxE1AsEuUwH6mfDAe1IiUjJFIX123g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745421062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BEGNVsuzeqAKKmzVHLqEk0GLgkV1Mzj2EoAKCSxOcAM=;
	b=EHVZUP7kKwY5C8Q8ft5jKqp8QyeQQSbJqTpVfByV0Osh0Oor8Sw2CGykVt3aE7PQ5HCDU+
	m08ylTUSsjVQksDw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix _pgd_alloc() for Xen PV mode
Cc: arkamar@atlas.cz, Juergen Gross <jgross@suse.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174542105684.31282.17108172724272710051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4ce385f56434f3810ef103e1baea357ddcc6667e
Gitweb:        https://git.kernel.org/tip/4ce385f56434f3810ef103e1baea357ddcc=
6667e
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 22 Apr 2025 15:17:17 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 23 Apr 2025 07:49:14 -07:00

x86/mm: Fix _pgd_alloc() for Xen PV mode

Recently _pgd_alloc() was switched from using __get_free_pages() to
pagetable_alloc_noprof(), which might return a compound page in case
the allocation order is larger than 0.

On x86 this will be the case if CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
is set, even if PTI has been disabled at runtime.

When running as a Xen PV guest (this will always disable PTI), using
a compound page for a PGD will result in VM_BUG_ON_PGFLAGS being
triggered when the Xen code tries to pin the PGD.

Fix the Xen issue together with the not needed 8k allocation for a
PGD with PTI disabled by replacing PGD_ALLOCATION_ORDER with an
inline helper returning the needed order for PGD allocations.

Fixes: a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,free=
}")
Reported-by: Petr Van=C4=9Bk <arkamar@atlas.cz>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Petr Van=C4=9Bk <arkamar@atlas.cz>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250422131717.25724-1-jgross%40suse.com
---
 arch/x86/include/asm/pgalloc.h     | 19 +++++++++++--------
 arch/x86/kernel/machine_kexec_32.c |  4 ++--
 arch/x86/mm/pgtable.c              |  4 ++--
 arch/x86/platform/efi/efi_64.c     |  4 ++--
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index a331475..c88691b 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -6,6 +6,8 @@
 #include <linux/mm.h>		/* for struct page */
 #include <linux/pagemap.h>
=20
+#include <asm/cpufeature.h>
+
 #define __HAVE_ARCH_PTE_ALLOC_ONE
 #define __HAVE_ARCH_PGD_FREE
 #include <asm-generic/pgalloc.h>
@@ -29,16 +31,17 @@ static inline void paravirt_release_pud(unsigned long pfn=
) {}
 static inline void paravirt_release_p4d(unsigned long pfn) {}
 #endif
=20
-#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
- * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
- * both 8k in size and 8k-aligned.  That lets us just flip bit 12
- * in a pointer to swap between the two 4k halves.
+ * In case of Page Table Isolation active, we acquire two PGDs instead of on=
e.
+ * Being order-1, it is both 8k in size and 8k-aligned.  That lets us just
+ * flip bit 12 in a pointer to swap between the two 4k halves.
  */
-#define PGD_ALLOCATION_ORDER 1
-#else
-#define PGD_ALLOCATION_ORDER 0
-#endif
+static inline unsigned int pgd_allocation_order(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_PTI))
+		return 1;
+	return 0;
+}
=20
 /*
  * Allocate and free page tables.
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kex=
ec_32.c
index 8026516..1f32530 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -42,7 +42,7 @@ static void load_segments(void)
=20
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
-	free_pages((unsigned long)image->arch.pgd, PGD_ALLOCATION_ORDER);
+	free_pages((unsigned long)image->arch.pgd, pgd_allocation_order());
 	image->arch.pgd =3D NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
@@ -59,7 +59,7 @@ static void machine_kexec_free_page_tables(struct kimage *i=
mage)
 static int machine_kexec_alloc_page_tables(struct kimage *image)
 {
 	image->arch.pgd =3D (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						    PGD_ALLOCATION_ORDER);
+						    pgd_allocation_order());
 #ifdef CONFIG_X86_PAE
 	image->arch.pmd0 =3D (pmd_t *)get_zeroed_page(GFP_KERNEL);
 	image->arch.pmd1 =3D (pmd_t *)get_zeroed_page(GFP_KERNEL);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a05fcdd..f7ae44d 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -360,7 +360,7 @@ static inline pgd_t *_pgd_alloc(struct mm_struct *mm)
 	 * We allocate one page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return __pgd_alloc(mm, PGD_ALLOCATION_ORDER);
+		return __pgd_alloc(mm, pgd_allocation_order());
=20
 	/*
 	 * Now PAE kernel is not running as a Xen domain. We can allocate
@@ -380,7 +380,7 @@ static inline void _pgd_free(struct mm_struct *mm, pgd_t =
*pgd)
=20
 static inline pgd_t *_pgd_alloc(struct mm_struct *mm)
 {
-	return __pgd_alloc(mm, PGD_ALLOCATION_ORDER);
+	return __pgd_alloc(mm, pgd_allocation_order());
 }
=20
 static inline void _pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index ac57259..a4b4ebd 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -73,7 +73,7 @@ int __init efi_alloc_page_tables(void)
 	gfp_t gfp_mask;
=20
 	gfp_mask =3D GFP_KERNEL | __GFP_ZERO;
-	efi_pgd =3D (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
+	efi_pgd =3D (pgd_t *)__get_free_pages(gfp_mask, pgd_allocation_order());
 	if (!efi_pgd)
 		goto fail;
=20
@@ -96,7 +96,7 @@ free_p4d:
 	if (pgtable_l5_enabled())
 		free_page((unsigned long)pgd_page_vaddr(*pgd));
 free_pgd:
-	free_pages((unsigned long)efi_pgd, PGD_ALLOCATION_ORDER);
+	free_pages((unsigned long)efi_pgd, pgd_allocation_order());
 fail:
 	return -ENOMEM;
 }

