Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744B3761478
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjGYLTq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjGYLTp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:19:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE14D10D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 733B36168E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560A2C433C8;
        Tue, 25 Jul 2023 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283982;
        bh=wvaZeiakGEAYzfhXoRC9SfusKiREChZNu5+5B7u8oKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwx5E2Mk9I/mAG5/x/ic+5stIZHe6S9qVcUKZulvoPKuQbV9gx5vIt4oAt014kJu7
         EVVCUQv07DGyTciljJKLtSsj9GMZkHfX7IWot5U2AtRN9HqCfr8nAI9A75LmFHaike
         wqmVK0IuZR+7/e/scRu0RArCRg9vptgdrg9Lebl4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Hugh Dickins <hughd@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 193/509] mm: rename p4d_page_vaddr to p4d_pgtable and make it return pud_t *
Date:   Tue, 25 Jul 2023 12:42:12 +0200
Message-ID: <20230725104602.574113172@linuxfoundation.org>
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

[ Upstream commit dc4875f0e791de554bdc45aa1dbd6e45e107e50f ]

No functional change in this patch.

[aneesh.kumar@linux.ibm.com: m68k build error reported by kernel robot]
  Link: https://lkml.kernel.org/r/87tulxnb2v.fsf@linux.ibm.com

Link: https://lkml.kernel.org/r/20210615110859.320299-2-aneesh.kumar@linux.ibm.com
Link: https://lore.kernel.org/linuxppc-dev/CAHk-=wi+J+iodze9FtjM3Zi4j4OeS+qqbKxME9QN4roxPEXH9Q@mail.gmail.com/
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
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
 arch/arm64/include/asm/pgtable.h                | 4 ++--
 arch/ia64/include/asm/pgtable.h                 | 2 +-
 arch/mips/include/asm/pgtable-64.h              | 4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h    | 5 ++++-
 arch/powerpc/include/asm/nohash/64/pgtable-4k.h | 6 +++++-
 arch/powerpc/mm/book3s64/radix_pgtable.c        | 2 +-
 arch/powerpc/mm/pgtable_64.c                    | 2 +-
 arch/sparc/include/asm/pgtable_64.h             | 4 ++--
 arch/x86/include/asm/pgtable.h                  | 4 ++--
 arch/x86/mm/init_64.c                           | 4 ++--
 include/asm-generic/pgtable-nop4d.h             | 2 +-
 include/asm-generic/pgtable-nopud.h             | 2 +-
 include/linux/pgtable.h                         | 2 +-
 13 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3635d48ada17d..4eedfd784cf63 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -694,9 +694,9 @@ static inline phys_addr_t p4d_page_paddr(p4d_t p4d)
 	return __p4d_to_phys(p4d);
 }
 
-static inline unsigned long p4d_page_vaddr(p4d_t p4d)
+static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
-	return (unsigned long)__va(p4d_page_paddr(p4d));
+	return (pud_t *)__va(p4d_page_paddr(p4d));
 }
 
 /* Find an entry in the frst-level page table. */
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index fd92792d148b4..6e5c387566573 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -287,7 +287,7 @@ extern unsigned long VMALLOC_END;
 #define p4d_bad(p4d)			(!ia64_phys_addr_valid(p4d_val(p4d)))
 #define p4d_present(p4d)		(p4d_val(p4d) != 0UL)
 #define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
-#define p4d_page_vaddr(p4d)		((unsigned long) __va(p4d_val(p4d) & _PFN_MASK))
+#define p4d_pgtable(p4d)		((pud_t *) __va(p4d_val(p4d) & _PFN_MASK))
 #define p4d_page(p4d)			virt_to_page((p4d_val(p4d) + PAGE_OFFSET))
 #endif
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index ab305453e90f8..b865edff2670e 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -210,9 +210,9 @@ static inline void p4d_clear(p4d_t *p4dp)
 	p4d_val(*p4dp) = (unsigned long)invalid_pud_table;
 }
 
-static inline unsigned long p4d_page_vaddr(p4d_t p4d)
+static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
-	return p4d_val(p4d);
+	return (pud_t *)p4d_val(p4d);
 }
 
 #define p4d_phys(p4d)		virt_to_phys((void *)p4d_val(p4d))
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 5ebf6450f6dad..2b4af824bdc55 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1030,7 +1030,10 @@ extern struct page *p4d_page(p4d_t p4d);
 /* Pointers in the page table tree are physical addresses */
 #define __pgtable_ptr_val(ptr)	__pa(ptr)
 
-#define p4d_page_vaddr(p4d)	__va(p4d_val(p4d) & ~P4D_MASKED_BITS)
+static inline pud_t *p4d_pgtable(p4d_t p4d)
+{
+	return (pud_t *)__va(p4d_val(p4d) & ~P4D_MASKED_BITS);
+}
 
 static inline pmd_t *pud_pgtable(pud_t pud)
 {
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
index fe2f4c9acd9ed..10f5cf444d72a 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
@@ -56,10 +56,14 @@
 #define p4d_none(p4d)		(!p4d_val(p4d))
 #define p4d_bad(p4d)		(p4d_val(p4d) == 0)
 #define p4d_present(p4d)	(p4d_val(p4d) != 0)
-#define p4d_page_vaddr(p4d)	(p4d_val(p4d) & ~P4D_MASKED_BITS)
 
 #ifndef __ASSEMBLY__
 
+static inline pud_t *p4d_pgtable(p4d_t p4d)
+{
+	return (pud_t *) (p4d_val(p4d) & ~P4D_MASKED_BITS);
+}
+
 static inline void p4d_clear(p4d_t *p4dp)
 {
 	*p4dp = __p4d(0);
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 605c770dd8191..44239e0acf8ea 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -898,7 +898,7 @@ static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 			continue;
 		}
 
-		pud_base = (pud_t *)p4d_page_vaddr(*p4d);
+		pud_base = p4d_pgtable(*p4d);
 		remove_pud_table(pud_base, addr, next);
 		free_pud_table(pud_base, p4d);
 	}
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index bd0d903196d98..175aabf101e87 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -106,7 +106,7 @@ struct page *p4d_page(p4d_t p4d)
 			VM_WARN_ON(!p4d_huge(p4d));
 		return pte_page(p4d_pte(p4d));
 	}
-	return virt_to_page(p4d_page_vaddr(p4d));
+	return virt_to_page(p4d_pgtable(p4d));
 }
 #endif
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index cac02ac301f13..5a1efd600f770 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -860,8 +860,8 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_present(pud)		(pud_val(pud) != 0U)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define p4d_page_vaddr(p4d)		\
-	((unsigned long) __va(p4d_val(p4d)))
+#define p4d_pgtable(p4d)		\
+	((pud_t *) __va(p4d_val(p4d)))
 #define p4d_present(p4d)		(p4d_val(p4d) != 0U)
 #define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a90f6d02fb961..9bacde3ff514a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -906,9 +906,9 @@ static inline int p4d_present(p4d_t p4d)
 	return p4d_flags(p4d) & _PAGE_PRESENT;
 }
 
-static inline unsigned long p4d_page_vaddr(p4d_t p4d)
+static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
-	return (unsigned long)__va(p4d_val(p4d) & p4d_pfn_mask(p4d));
+	return (pud_t *)__va(p4d_val(p4d) & p4d_pfn_mask(p4d));
 }
 
 /*
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 20951ab522a1d..acf4e50c5988b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -193,8 +193,8 @@ static void sync_global_pgds_l4(unsigned long start, unsigned long end)
 			spin_lock(pgt_lock);
 
 			if (!p4d_none(*p4d_ref) && !p4d_none(*p4d))
-				BUG_ON(p4d_page_vaddr(*p4d)
-				       != p4d_page_vaddr(*p4d_ref));
+				BUG_ON(p4d_pgtable(*p4d)
+				       != p4d_pgtable(*p4d_ref));
 
 			if (p4d_none(*p4d))
 				set_p4d(p4d, *p4d_ref);
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index ce2cbb3c380ff..2f1d0aad645cf 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -42,7 +42,7 @@ static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 #define __p4d(x)				((p4d_t) { __pgd(x) })
 
 #define pgd_page(pgd)				(p4d_page((p4d_t){ pgd }))
-#define pgd_page_vaddr(pgd)			(p4d_page_vaddr((p4d_t){ pgd }))
+#define pgd_page_vaddr(pgd)			((unsigned long)(p4d_pgtable((p4d_t){ pgd })))
 
 /*
  * allocating and freeing a p4d is trivial: the 1-entry p4d is
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index 7cbd15f70bf55..eb70c6d7ceff2 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -49,7 +49,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 #define __pud(x)				((pud_t) { __p4d(x) })
 
 #define p4d_page(p4d)				(pud_page((pud_t){ p4d }))
-#define p4d_page_vaddr(p4d)			(pud_pgtable((pud_t){ p4d }))
+#define p4d_pgtable(p4d)			((pud_t *)(pud_pgtable((pud_t){ p4d })))
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index f8570799bc263..f924468d84ec4 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -97,7 +97,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 #ifndef pud_offset
 static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 {
-	return (pud_t *)p4d_page_vaddr(*p4d) + pud_index(address);
+	return p4d_pgtable(*p4d) + pud_index(address);
 }
 #define pud_offset pud_offset
 #endif
-- 
2.39.2



