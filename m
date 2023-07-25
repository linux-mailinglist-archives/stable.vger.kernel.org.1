Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BDE761477
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjGYLTo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjGYLTn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA1499
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6D396168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9056DC433C8;
        Tue, 25 Jul 2023 11:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283980;
        bh=aK+x63domwVTfHN72Kq6a905RE+a+zxaRR4V0FeP5Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8oecZdkfp18LcOyyOgNaM0LVodhPB+mNdUE7SScRmEWM+ygeRrXc3mgembEA5y0m
         chvS9c9RDCQq6bsJgA8J0k8qFWGjfs69xdiTtBJkbQC15RkZAo6gv2VeocnPbdWfOr
         Ta3cHyqKOslLyejafa8Tr28W4g00uu6+83aT3JFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Hugh Dickins <hughd@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 192/509] mm: rename pud_page_vaddr to pud_pgtable and make it return pmd_t *
Date:   Tue, 25 Jul 2023 12:42:11 +0200
Message-ID: <20230725104602.520980582@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

[ Upstream commit 9cf6fa2458443118b84090aa1bf7a3630b5940e8 ]

No functional change in this patch.

[aneesh.kumar@linux.ibm.com: fix]
  Link: https://lkml.kernel.org/r/87wnqtnb60.fsf@linux.ibm.com
[sfr@canb.auug.org.au: another fix]
  Link: https://lkml.kernel.org/r/20210619134410.89559-1-aneesh.kumar@linux.ibm.com

Link: https://lkml.kernel.org/r/20210615110859.320299-1-aneesh.kumar@linux.ibm.com
Link: https://lore.kernel.org/linuxppc-dev/CAHk-=wi+J+iodze9FtjM3Zi4j4OeS+qqbKxME9QN4roxPEXH9Q@mail.gmail.com/
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Hugh Dickins <hughd@google.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 0da90af431ab ("powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/include/asm/pgtable.h             | 8 +++++---
 arch/arm/include/asm/pgtable-3level.h        | 2 +-
 arch/arm64/include/asm/pgtable.h             | 4 ++--
 arch/ia64/include/asm/pgtable.h              | 2 +-
 arch/m68k/include/asm/motorola_pgtable.h     | 2 +-
 arch/mips/include/asm/pgtable-64.h           | 4 ++--
 arch/parisc/include/asm/pgtable.h            | 4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h | 6 +++++-
 arch/powerpc/include/asm/nohash/64/pgtable.h | 6 +++++-
 arch/powerpc/mm/book3s64/radix_pgtable.c     | 4 ++--
 arch/powerpc/mm/pgtable_64.c                 | 2 +-
 arch/riscv/include/asm/pgtable-64.h          | 4 ++--
 arch/sh/include/asm/pgtable-3level.h         | 4 ++--
 arch/sparc/include/asm/pgtable_32.h          | 6 +++---
 arch/sparc/include/asm/pgtable_64.h          | 6 +++---
 arch/um/include/asm/pgtable-3level.h         | 2 +-
 arch/x86/include/asm/pgtable.h               | 4 ++--
 arch/x86/mm/pat/set_memory.c                 | 4 ++--
 arch/x86/mm/pgtable.c                        | 2 +-
 include/asm-generic/pgtable-nopmd.h          | 2 +-
 include/asm-generic/pgtable-nopud.h          | 2 +-
 include/linux/pgtable.h                      | 2 +-
 22 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 660b14ce13179..12c120e436a24 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -241,8 +241,10 @@ pmd_page_vaddr(pmd_t pmd)
 #define pud_page(pud)	(mem_map + ((pud_val(pud) & _PFN_MASK) >> 32))
 #endif
 
-extern inline unsigned long pud_page_vaddr(pud_t pgd)
-{ return PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
+extern inline pmd_t *pud_pgtable(pud_t pgd)
+{
+	return (pmd_t *)(PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)));
+}
 
 extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
 extern inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_VALID; }
@@ -292,7 +294,7 @@ extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; retu
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pud_t * dir, unsigned long address)
 {
-	pmd_t *ret = (pmd_t *) pud_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
+	pmd_t *ret = pud_pgtable(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
 	smp_rmb(); /* see above */
 	return ret;
 }
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 2b85d175e9996..4487aea88477d 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -130,7 +130,7 @@
 		flush_pmd_entry(pudp);	\
 	} while (0)
 
-static inline pmd_t *pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
 }
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3f74db7b0a31d..3635d48ada17d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -633,9 +633,9 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 	return __pud_to_phys(pud);
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)__va(pud_page_paddr(pud));
+	return (pmd_t *)__va(pud_page_paddr(pud));
 }
 
 /* Find an entry in the second-level page table. */
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 9f64fdfbf2750..fd92792d148b4 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -279,7 +279,7 @@ extern unsigned long VMALLOC_END;
 #define pud_bad(pud)			(!ia64_phys_addr_valid(pud_val(pud)))
 #define pud_present(pud)		(pud_val(pud) != 0UL)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define pud_page_vaddr(pud)		((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_pgtable(pud)		((pmd_t *) __va(pud_val(pud) & _PFN_MASK))
 #define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
 
 #if CONFIG_PGTABLE_LEVELS == 4
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 8076467eff4b0..956c80874f98b 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -129,7 +129,7 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
 
 #define __pte_page(pte) ((unsigned long)__va(pte_val(pte) & PAGE_MASK))
 #define pmd_page_vaddr(pmd) ((unsigned long)__va(pmd_val(pmd) & _TABLE_MASK))
-#define pud_page_vaddr(pud) ((unsigned long)__va(pud_val(pud) & _TABLE_MASK))
+#define pud_pgtable(pud) ((pmd_t *)__va(pud_val(pud) & _TABLE_MASK))
 
 
 #define pte_none(pte)		(!pte_val(pte))
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 1e7d6ce9d8d62..ab305453e90f8 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -314,9 +314,9 @@ static inline void pud_clear(pud_t *pudp)
 #endif
 
 #ifndef __PAGETABLE_PMD_FOLDED
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return pud_val(pud);
+	return (pmd_t *)pud_val(pud);
 }
 #define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 8964798b8274e..ade591927cbff 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -330,8 +330,8 @@ static inline void pmd_clear(pmd_t *pmd) {
 
 
 #if CONFIG_PGTABLE_LEVELS == 3
-#define pud_page_vaddr(pud) ((unsigned long) __va(pud_address(pud)))
-#define pud_page(pud)	virt_to_page((void *)pud_page_vaddr(pud))
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_address(pud)))
+#define pud_page(pud)	virt_to_page((void *)pud_pgtable(pud))
 
 /* For 64 bit we have three level tables */
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 71e2c524f1eea..5ebf6450f6dad 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1030,9 +1030,13 @@ extern struct page *p4d_page(p4d_t p4d);
 /* Pointers in the page table tree are physical addresses */
 #define __pgtable_ptr_val(ptr)	__pa(ptr)
 
-#define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
 #define p4d_page_vaddr(p4d)	__va(p4d_val(p4d) & ~P4D_MASKED_BITS)
 
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)__va(pud_val(pud) & ~PUD_MASKED_BITS);
+}
+
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 1eacff0fff029..a4d475c0fc2c0 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -164,7 +164,11 @@ static inline void pud_clear(pud_t *pudp)
 #define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
 				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
-#define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)(pud_val(pud) & ~PUD_MASKED_BITS);
+}
 
 extern struct page *pud_page(pud_t pud);
 
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 5f0a2fa611fa2..605c770dd8191 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -864,7 +864,7 @@ static void __meminit remove_pud_table(pud_t *pud_start, unsigned long addr,
 			continue;
 		}
 
-		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
+		pmd_base = pud_pgtable(*pud);
 		remove_pmd_table(pmd_base, addr, next);
 		free_pmd_table(pmd_base, pud);
 	}
@@ -1156,7 +1156,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	pmd_t *pmd;
 	int i;
 
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd = pud_pgtable(*pud);
 	pud_clear(pud);
 
 	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index aefc2bfdf1049..bd0d903196d98 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -117,7 +117,7 @@ struct page *pud_page(pud_t pud)
 			VM_WARN_ON(!pud_huge(pud));
 		return pte_page(pud_pte(pud));
 	}
-	return virt_to_page(pud_page_vaddr(pud));
+	return virt_to_page(pud_pgtable(pud));
 }
 
 /*
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index f3b0da64c6c8f..0e863f3f7187a 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -60,9 +60,9 @@ static inline void pud_clear(pud_t *pudp)
 	set_pud(pudp, __pud(0));
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
+	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
 }
 
 static inline struct page *pud_page(pud_t pud)
diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index 82d74472dfcda..56bf35c2f29c2 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -32,9 +32,9 @@ typedef struct { unsigned long long pmd; } pmd_t;
 #define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) } )
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return pud_val(pud);
+	return (pmd_t *)pud_val(pud);
 }
 
 /* only used by the stubbed out hugetlb gup code, should never be called */
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 632cdb959542c..7d1d10a8fd937 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -152,13 +152,13 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return (unsigned long)__nocache_va(v << 4);
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	if (srmmu_device_memory(pud_val(pud))) {
-		return ~0;
+		return (pmd_t *)~0;
 	} else {
 		unsigned long v = pud_val(pud) & SRMMU_PTD_PMASK;
-		return (unsigned long)__nocache_va(v << 4);
+		return (pmd_t *)__nocache_va(v << 4);
 	}
 }
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 7ef6affa105e4..cac02ac301f13 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -845,18 +845,18 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return ((unsigned long) __va(pfn << PAGE_SHIFT));
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
 	unsigned long pfn;
 
 	pfn = pte_pfn(pte);
 
-	return ((unsigned long) __va(pfn << PAGE_SHIFT));
+	return ((pmd_t *) __va(pfn << PAGE_SHIFT));
 }
 
 #define pmd_page(pmd) 			virt_to_page((void *)pmd_page_vaddr(pmd))
-#define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
+#define pud_page(pud)			virt_to_page((void *)pud_pgtable(pud))
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_present(pud)		(pud_val(pud) != 0U)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 7e6a4180db9d3..091bff319ccdf 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -84,7 +84,7 @@ static inline void pud_clear (pud_t *pud)
 }
 
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
-#define pud_page_vaddr(pud) ((unsigned long) __va(pud_val(pud) & PAGE_MASK))
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_val(pud) & PAGE_MASK))
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 87de9f2d71cf2..a90f6d02fb961 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -865,9 +865,9 @@ static inline int pud_present(pud_t pud)
 	return pud_flags(pud) & _PAGE_PRESENT;
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)__va(pud_val(pud) & pud_pfn_mask(pud));
+	return (pmd_t *)__va(pud_val(pud) & pud_pfn_mask(pud));
 }
 
 /*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 40baa90e74f4c..217dda690ed82 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1126,7 +1126,7 @@ static void __unmap_pmd_range(pud_t *pud, pmd_t *pmd,
 			      unsigned long start, unsigned long end)
 {
 	if (unmap_pte_range(pmd, start, end))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
 
@@ -1170,7 +1170,7 @@ static void unmap_pmd_range(pud_t *pud, unsigned long start, unsigned long end)
 	 * Try again to free the PMD page if haven't succeeded above.
 	 */
 	if (!pud_none(*pud))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index f6a9e2e366425..204b25ee26f0b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -805,7 +805,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	pte_t *pte;
 	int i;
 
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd = pud_pgtable(*pud);
 	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
 	if (!pmd_sv)
 		return 0;
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 3e13acd019aef..10789cf51d160 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -51,7 +51,7 @@ static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
 #define __pmd(x)				((pmd_t) { __pud(x) } )
 
 #define pud_page(pud)				(pmd_page((pmd_t){ pud }))
-#define pud_page_vaddr(pud)			(pmd_page_vaddr((pmd_t){ pud }))
+#define pud_pgtable(pud)			((pmd_t *)(pmd_page_vaddr((pmd_t){ pud })))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index a9d751fbda9e8..7cbd15f70bf55 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -49,7 +49,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 #define __pud(x)				((pud_t) { __p4d(x) })
 
 #define p4d_page(p4d)				(pud_page((pud_t){ p4d }))
-#define p4d_page_vaddr(p4d)			(pud_page_vaddr((pud_t){ p4d }))
+#define p4d_page_vaddr(p4d)			(pud_pgtable((pud_t){ p4d }))
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 9def1ac19546b..f8570799bc263 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -89,7 +89,7 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 #ifndef pmd_offset
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 {
-	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
+	return pud_pgtable(*pud) + pmd_index(address);
 }
 #define pmd_offset pmd_offset
 #endif
-- 
2.39.2



