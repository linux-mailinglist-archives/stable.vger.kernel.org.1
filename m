Return-Path: <stable+bounces-240323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LwXBtG46GmgPAIAu9opvQ
	(envelope-from <stable+bounces-240323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:02:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D9445AB1
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 14:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 223E4304C96A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E9D3D1CB5;
	Wed, 22 Apr 2026 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AsxkL0i3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C5E3C279B;
	Wed, 22 Apr 2026 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859228; cv=none; b=qtc+jcFDme3KLGLuE8M6Wtul7f4kI4NJzQQBNnhdxQMK08VnFH+UdWAOkSUUVlA+C+4hTNZSE+UmiyfODg5WDf2wjJPnChy0po3XfPzuFsQqnh2nE6QsItapUXGN0CZ8+/EXrha50D8VdPlf2y+CGtjwvby54tUJYrAcSClKtDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859228; c=relaxed/simple;
	bh=gHSlzivMKvY21monBYTSs4n74FswDAc5Wpjw+gqnvO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcBPHsoNAZ7Eq93IUVH7gdKHc2D0pHljaHoy8xAeuFHhXqMcWggBfdJoga8dkKdTjMsLuxv6U3erSPdtiT27qoaa5Cs50KOl3+0mGI1F7qBV8SggnJaEUsUYosw0ljvClZjuogd7hyfZLxmmoIk+n6v+pziUb4ye+uKn34tsf38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AsxkL0i3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2D3C19425;
	Wed, 22 Apr 2026 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776859228;
	bh=gHSlzivMKvY21monBYTSs4n74FswDAc5Wpjw+gqnvO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsxkL0i3e/SsoFGs5qODNCwssHtZB9SCm4vcAcuN5KnO0JubHRwtWHG/mhOGbJ6iu
	 rHeDkPH0z3I7SY4qJNZWSMAT8UvBn9DZ7hiej8QOW6wQl5g1Tkc3KeRwepMefMLxL8
	 cvMD9O3HchBYjZHtheQprklzz/PKRtCAzHAsc5v4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.1
Date: Wed, 22 Apr 2026 14:00:13 +0200
Message-ID: <2026042213-glitter-happily-aad9@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026042213-wish-lizard-f678@gregkh>
References: <2026042213-wish-lizard-f678@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240323-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vacharakis.de:email,args.pid:url]
X-Rspamd-Queue-Id: AE5D9445AB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

diff --git a/Documentation/admin-guide/mm/damon/lru_sort.rst b/Documentation/admin-guide/mm/damon/lru_sort.rst
index 20a8378d5a94..63977a89025e 100644
--- a/Documentation/admin-guide/mm/damon/lru_sort.rst
+++ b/Documentation/admin-guide/mm/damon/lru_sort.rst
@@ -79,6 +79,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_LRU_SORT will be disabled.
 
+Once ``Y`` is written to this parameter, the user must not write to any
+parameters until reading ``commit_inputs`` again returns ``N``.  If users
+violate this rule, the kernel may exhibit undefined behavior.
+
 active_mem_bp
 -------------
 
diff --git a/Documentation/admin-guide/mm/damon/reclaim.rst b/Documentation/admin-guide/mm/damon/reclaim.rst
index 8eba3da8dcee..1d68db2aa27e 100644
--- a/Documentation/admin-guide/mm/damon/reclaim.rst
+++ b/Documentation/admin-guide/mm/damon/reclaim.rst
@@ -71,6 +71,10 @@ of parametrs except ``enabled`` again.  Once the re-reading is done, this
 parameter is set as ``N``.  If invalid parameters are found while the
 re-reading, DAMON_RECLAIM will be disabled.
 
+Once ``Y`` is written to this parameter, the user must not write to any
+parameters until reading ``commit_inputs`` again returns ``N``.  If users
+violate this rule, the kernel may exhibit undefined behavior.
+
 min_age
 -------
 
diff --git a/Makefile b/Makefile
index 36d0a32fbe49..edd04bdf3a39 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 0
+SUBLEVEL = 1
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index f560e6420267..212ce1b02e15 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -25,6 +25,8 @@
  */
 #define PTE_PRESENT_INVALID	(PTE_NG)		 /* only when !PTE_VALID */
 
+#define PTE_PRESENT_VALID_KERNEL (PTE_VALID | PTE_MAYBE_NG)
+
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 #define PTE_UFFD_WP		(_AT(pteval_t, 1) << 58) /* uffd-wp tracking */
 #define PTE_SWP_UFFD_WP		(_AT(pteval_t, 1) << 3)	 /* only for swp ptes */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b3e58735c49b..dd062179b9b6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -322,9 +322,11 @@ static inline pte_t pte_mknoncont(pte_t pte)
 	return clear_pte_bit(pte, __pgprot(PTE_CONT));
 }
 
-static inline pte_t pte_mkvalid(pte_t pte)
+static inline pte_t pte_mkvalid_k(pte_t pte)
 {
-	return set_pte_bit(pte, __pgprot(PTE_VALID));
+	pte = clear_pte_bit(pte, __pgprot(PTE_PRESENT_INVALID));
+	pte = set_pte_bit(pte, __pgprot(PTE_PRESENT_VALID_KERNEL));
+	return pte;
 }
 
 static inline pte_t pte_mkinvalid(pte_t pte)
@@ -594,6 +596,7 @@ static inline int pmd_protnone(pmd_t pmd)
 #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
 #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
+#define pmd_mkvalid_k(pmd)	pte_pmd(pte_mkvalid_k(pmd_pte(pmd)))
 #define pmd_mkinvalid(pmd)	pte_pmd(pte_mkinvalid(pmd_pte(pmd)))
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 #define pmd_uffd_wp(pmd)	pte_uffd_wp(pmd_pte(pmd))
@@ -635,6 +638,8 @@ static inline pmd_t pmd_mkspecial(pmd_t pmd)
 
 #define pud_young(pud)		pte_young(pud_pte(pud))
 #define pud_mkyoung(pud)	pte_pud(pte_mkyoung(pud_pte(pud)))
+#define pud_mkwrite_novma(pud)	pte_pud(pte_mkwrite_novma(pud_pte(pud)))
+#define pud_mkvalid_k(pud)	pte_pud(pte_mkvalid_k(pud_pte(pud)))
 #define pud_write(pud)		pte_write(pud_pte(pud))
 
 static inline pud_t pud_mkhuge(pud_t pud)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 9810106a3f66..eafc83d255d8 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -478,7 +478,7 @@ extern __must_check long strnlen_user(const char __user *str, long n);
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 extern unsigned long __must_check __copy_user_flushcache(void *to, const void __user *from, unsigned long n);
 
-static inline int __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
+static inline size_t copy_from_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	kasan_check_write(dst, size);
 	return __copy_user_flushcache(dst, __uaccess_mask_ptr(src), size);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a6a00accf4f9..089ff2afc752 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -602,6 +602,8 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 		tableprot |= PMD_TABLE_PXN;
 
 	prot = __pgprot((pgprot_val(prot) & ~PTE_TYPE_MASK) | PTE_TYPE_PAGE);
+	if (!pmd_valid(pmd))
+		prot = pte_pgprot(pte_mkinvalid(pfn_pte(0, prot)));
 	prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
 	if (to_cont)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
@@ -647,6 +649,8 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 		tableprot |= PUD_TABLE_PXN;
 
 	prot = __pgprot((pgprot_val(prot) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
+	if (!pud_valid(pud))
+		prot = pmd_pgprot(pmd_mkinvalid(pfn_pmd(0, prot)));
 	prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
 	if (to_cont)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 358d1dc9a576..ce035e1b4eaf 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -25,6 +25,11 @@ static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
 {
 	struct page_change_data *masks = walk->private;
 
+	/*
+	 * Some users clear and set bits which alias each other (e.g. PTE_NG and
+	 * PTE_PRESENT_INVALID). It is therefore important that we always clear
+	 * first then set.
+	 */
 	val &= ~(pgprot_val(masks->clear_mask));
 	val |= (pgprot_val(masks->set_mask));
 
@@ -36,7 +41,7 @@ static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
 {
 	pud_t val = pudp_get(pud);
 
-	if (pud_sect(val)) {
+	if (pud_leaf(val)) {
 		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
 			return -EINVAL;
 		val = __pud(set_pageattr_masks(pud_val(val), walk));
@@ -52,7 +57,7 @@ static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
 {
 	pmd_t val = pmdp_get(pmd);
 
-	if (pmd_sect(val)) {
+	if (pmd_leaf(val)) {
 		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
 			return -EINVAL;
 		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
@@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start, unsigned long size,
 	ret = update_range_prot(start, size, set_mask, clear_mask);
 
 	/*
-	 * If the memory is being made valid without changing any other bits
-	 * then a TLBI isn't required as a non-valid entry cannot be cached in
-	 * the TLB.
+	 * If the memory is being switched from present-invalid to valid without
+	 * changing any other bits then a TLBI isn't required as a non-valid
+	 * entry cannot be cached in the TLB.
 	 */
-	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
+	if (pgprot_val(set_mask) != PTE_PRESENT_VALID_KERNEL ||
+	    pgprot_val(clear_mask) != PTE_PRESENT_INVALID)
 		flush_tlb_kernel_range(start, start + size);
 	return ret;
 }
@@ -237,18 +243,18 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 {
 	if (enable)
 		return __change_memory_common(addr, PAGE_SIZE * numpages,
-					__pgprot(PTE_VALID),
-					__pgprot(0));
+					__pgprot(PTE_PRESENT_VALID_KERNEL),
+					__pgprot(PTE_PRESENT_INVALID));
 	else
 		return __change_memory_common(addr, PAGE_SIZE * numpages,
-					__pgprot(0),
-					__pgprot(PTE_VALID));
+					__pgprot(PTE_PRESENT_INVALID),
+					__pgprot(PTE_PRESENT_VALID_KERNEL));
 }
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
-	pgprot_t clear_mask = __pgprot(PTE_VALID);
-	pgprot_t set_mask = __pgprot(0);
+	pgprot_t clear_mask = __pgprot(PTE_PRESENT_VALID_KERNEL);
+	pgprot_t set_mask = __pgprot(PTE_PRESENT_INVALID);
 
 	if (!can_set_direct_map())
 		return 0;
@@ -259,8 +265,8 @@ int set_direct_map_invalid_noflush(struct page *page)
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
-	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
+	pgprot_t set_mask = __pgprot(PTE_PRESENT_VALID_KERNEL | PTE_WRITE);
+	pgprot_t clear_mask = __pgprot(PTE_PRESENT_INVALID | PTE_RDONLY);
 
 	if (!can_set_direct_map())
 		return 0;
@@ -296,8 +302,8 @@ static int __set_memory_enc_dec(unsigned long addr,
 	 * entries or Synchronous External Aborts caused by RIPAS_EMPTY
 	 */
 	ret = __change_memory_common(addr, PAGE_SIZE * numpages,
-				     __pgprot(set_prot),
-				     __pgprot(clear_prot | PTE_VALID));
+				     __pgprot(set_prot | PTE_PRESENT_INVALID),
+				     __pgprot(clear_prot | PTE_PRESENT_VALID_KERNEL));
 
 	if (ret)
 		return ret;
@@ -311,8 +317,8 @@ static int __set_memory_enc_dec(unsigned long addr,
 		return ret;
 
 	return __change_memory_common(addr, PAGE_SIZE * numpages,
-				      __pgprot(PTE_VALID),
-				      __pgprot(0));
+				      __pgprot(PTE_PRESENT_VALID_KERNEL),
+				      __pgprot(PTE_PRESENT_INVALID));
 }
 
 static int realm_set_memory_encrypted(unsigned long addr, int numpages)
@@ -404,15 +410,15 @@ bool kernel_page_present(struct page *page)
 	pud = READ_ONCE(*pudp);
 	if (pud_none(pud))
 		return false;
-	if (pud_sect(pud))
-		return true;
+	if (pud_leaf(pud))
+		return pud_valid(pud);
 
 	pmdp = pmd_offset(pudp, addr);
 	pmd = READ_ONCE(*pmdp);
 	if (pmd_none(pmd))
 		return false;
-	if (pmd_sect(pmd))
-		return true;
+	if (pmd_leaf(pmd))
+		return pmd_valid(pmd);
 
 	ptep = pte_offset_kernel(pmdp, addr);
 	return pte_valid(__ptep_get(ptep));
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 18543b603c77..cca9706a875c 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -31,36 +31,6 @@ static void *trans_alloc(struct trans_pgd_info *info)
 	return info->trans_alloc_page(info->trans_alloc_arg);
 }
 
-static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
-{
-	pte_t pte = __ptep_get(src_ptep);
-
-	if (pte_valid(pte)) {
-		/*
-		 * Resume will overwrite areas that may be marked
-		 * read only (code, rodata). Clear the RDONLY bit from
-		 * the temporary mappings we use during restore.
-		 */
-		__set_pte(dst_ptep, pte_mkwrite_novma(pte));
-	} else if (!pte_none(pte)) {
-		/*
-		 * debug_pagealloc will removed the PTE_VALID bit if
-		 * the page isn't in use by the resume kernel. It may have
-		 * been in use by the original kernel, in which case we need
-		 * to put it back in our copy to do the restore.
-		 *
-		 * Other cases include kfence / vmalloc / memfd_secret which
-		 * may call `set_direct_map_invalid_noflush()`.
-		 *
-		 * Before marking this entry valid, check the pfn should
-		 * be mapped.
-		 */
-		BUG_ON(!pfn_valid(pte_pfn(pte)));
-
-		__set_pte(dst_ptep, pte_mkvalid(pte_mkwrite_novma(pte)));
-	}
-}
-
 static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 		    pmd_t *src_pmdp, unsigned long start, unsigned long end)
 {
@@ -76,7 +46,11 @@ static int copy_pte(struct trans_pgd_info *info, pmd_t *dst_pmdp,
 
 	src_ptep = pte_offset_kernel(src_pmdp, start);
 	do {
-		_copy_pte(dst_ptep, src_ptep, addr);
+		pte_t pte = __ptep_get(src_ptep);
+
+		if (pte_none(pte))
+			continue;
+		__set_pte(dst_ptep, pte_mkvalid_k(pte_mkwrite_novma(pte)));
 	} while (dst_ptep++, src_ptep++, addr += PAGE_SIZE, addr != end);
 
 	return 0;
@@ -109,8 +83,7 @@ static int copy_pmd(struct trans_pgd_info *info, pud_t *dst_pudp,
 			if (copy_pte(info, dst_pmdp, src_pmdp, addr, next))
 				return -ENOMEM;
 		} else {
-			set_pmd(dst_pmdp,
-				__pmd(pmd_val(pmd) & ~PMD_SECT_RDONLY));
+			set_pmd(dst_pmdp, pmd_mkvalid_k(pmd_mkwrite_novma(pmd)));
 		}
 	} while (dst_pmdp++, src_pmdp++, addr = next, addr != end);
 
@@ -145,8 +118,7 @@ static int copy_pud(struct trans_pgd_info *info, p4d_t *dst_p4dp,
 			if (copy_pmd(info, dst_pudp, src_pudp, addr, next))
 				return -ENOMEM;
 		} else {
-			set_pud(dst_pudp,
-				__pud(pud_val(pud) & ~PUD_SECT_RDONLY));
+			set_pud(dst_pudp, pud_mkvalid_k(pud_mkwrite_novma(pud)));
 		}
 	} while (dst_pudp++, src_pudp++, addr = next, addr != end);
 
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 17e63244e885..e98c628e3899 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -434,8 +434,7 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
 }
 #endif
 
-extern long __copy_from_user_flushcache(void *dst, const void __user *src,
-		unsigned size);
+extern size_t copy_from_user_flushcache(void *dst, const void __user *src, size_t size);
 
 static __must_check __always_inline bool __user_access_begin(const void __user *ptr, size_t len,
 							     unsigned long dir)
diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
index 4e724c4c01ad..0f0f2d851ac6 100644
--- a/arch/powerpc/lib/pmem.c
+++ b/arch/powerpc/lib/pmem.c
@@ -66,15 +66,16 @@ EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 /*
  * CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE symbols
  */
-long __copy_from_user_flushcache(void *dest, const void __user *src,
-		unsigned size)
+size_t copy_from_user_flushcache(void *dest, const void __user *src,
+				 size_t size)
 {
-	unsigned long copied, start = (unsigned long) dest;
+	unsigned long not_copied, start = (unsigned long) dest;
 
-	copied = __copy_from_user(dest, src, size);
+	src = mask_user_address(src);
+	not_copied = __copy_from_user(dest, src, size);
 	clean_pmem_range(start, start + size);
 
-	return copied;
+	return not_copied;
 }
 
 void memcpy_flushcache(void *dest, const void *src, size_t size)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6673601246b3..92bb6b2f778e 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -674,6 +674,9 @@
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_TW_CFG		0xc0011023
 
+#define MSR_AMD64_FP_CFG		0xc0011028
+#define MSR_AMD64_FP_CFG_ZEN1_DENORM_FIX_BIT	9
+
 #define MSR_AMD64_DE_CFG		0xc0011029
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT	 1
 #define MSR_AMD64_DE_CFG_LFENCE_SERIALIZE	BIT_ULL(MSR_AMD64_DE_CFG_LFENCE_SERIALIZE_BIT)
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 367297b188c3..3a0dd3c2b233 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -507,7 +507,7 @@ extern struct movsl_mask {
 } ____cacheline_aligned_in_smp movsl_mask;
 #endif
 
-#define ARCH_HAS_NOCACHE_UACCESS 1
+#define ARCH_HAS_NONTEMPORAL_UACCESS 1
 
 /*
  * The "unsafe" user accesses aren't really "unsafe", but the naming
diff --git a/arch/x86/include/asm/uaccess_32.h b/arch/x86/include/asm/uaccess_32.h
index 40379a1adbb8..fff19e73ccb3 100644
--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -26,13 +26,7 @@ raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 	return __copy_user_ll(to, (__force const void *)from, n);
 }
 
-static __always_inline unsigned long
-__copy_from_user_inatomic_nocache(void *to, const void __user *from,
-				  unsigned long n)
-{
-       return __copy_from_user_ll_nocache_nozero(to, from, n);
-}
-
+unsigned long __must_check copy_from_user_inatomic_nontemporal(void *, const void __user *, unsigned long n);
 unsigned long __must_check clear_user(void __user *mem, unsigned long len);
 unsigned long __must_check __clear_user(void __user *mem, unsigned long len);
 
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 915124011c27..20de34cc9aa6 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -147,26 +147,28 @@ raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
 	return copy_user_generic((__force void *)dst, src, size);
 }
 
-extern long __copy_user_nocache(void *dst, const void __user *src, unsigned size);
-extern long __copy_user_flushcache(void *dst, const void __user *src, unsigned size);
+#define copy_to_nontemporal copy_to_nontemporal
+extern size_t copy_to_nontemporal(void *dst, const void *src, size_t size);
+extern size_t copy_user_flushcache(void *dst, const void __user *src, size_t size);
 
 static inline int
-__copy_from_user_inatomic_nocache(void *dst, const void __user *src,
+copy_from_user_inatomic_nontemporal(void *dst, const void __user *src,
 				  unsigned size)
 {
 	long ret;
 	kasan_check_write(dst, size);
+	src = mask_user_address(src);
 	stac();
-	ret = __copy_user_nocache(dst, src, size);
+	ret = copy_to_nontemporal(dst, (__force const void *)src, size);
 	clac();
 	return ret;
 }
 
-static inline int
-__copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
+static inline size_t
+copy_from_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	kasan_check_write(dst, size);
-	return __copy_user_flushcache(dst, src, size);
+	return copy_user_flushcache(dst, src, size);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 09de584e4c8f..9b9bf7df7aad 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -943,6 +943,9 @@ static void init_amd_zen1(struct cpuinfo_x86 *c)
 		msr_clear_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 		clear_cpu_cap(c, X86_FEATURE_IRPERF);
 	}
+
+	pr_notice_once("AMD Zen1 FPDSS bug detected, enabling mitigation.\n");
+	msr_set_bit(MSR_AMD64_FP_CFG, MSR_AMD64_FP_CFG_ZEN1_DENORM_FIX_BIT);
 }
 
 static const struct x86_cpu_id amd_zenbleed_microcode[] = {
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 3f9c1aa39a0a..fb278fb1652d 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -690,10 +690,16 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	if (ulen == 0 || uaddr + ulen < uaddr)
 		return ERR_PTR(-EINVAL);
 
-	/* Calculate number of pages. */
+	/*
+	 * Calculate the number of pages that need to be pinned to cover the
+	 * entire range.  Note!  This isn't simply ulen >> PAGE_SHIFT, as KVM
+	 * doesn't require the incoming address+size to be page aligned!
+	 */
 	first = (uaddr & PAGE_MASK) >> PAGE_SHIFT;
 	last = ((uaddr + ulen - 1) & PAGE_MASK) >> PAGE_SHIFT;
 	npages = (last - first + 1);
+	if (npages > INT_MAX)
+		return ERR_PTR(-EINVAL);
 
 	locked = sev->pages_locked + npages;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
@@ -702,9 +708,6 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (WARN_ON_ONCE(npages > INT_MAX))
-		return ERR_PTR(-EINVAL);
-
 	/* Avoid using vmalloc for smaller buffers. */
 	size = npages * sizeof(struct page *);
 	if (size > PAGE_SIZE)
@@ -882,6 +885,11 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	u8 *d;
 	int i;
 
+	lockdep_assert_held(&vcpu->mutex);
+
+	if (vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	/* Check some debug related fields before encrypting the VMSA */
 	if (svm->vcpu.guest_debug || (svm->vmcb->save.dr7 & ~DR7_FIXED_1))
 		return -EINVAL;
@@ -1027,6 +1035,9 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_es_guest(kvm))
 		return -ENOTTY;
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		ret = mutex_lock_killable(&vcpu->mutex);
 		if (ret)
@@ -2047,8 +2058,8 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	struct kvm_vcpu *src_vcpu;
 	unsigned long i;
 
-	if (src->created_vcpus != atomic_read(&src->online_vcpus) ||
-	    dst->created_vcpus != atomic_read(&dst->online_vcpus))
+	if (kvm_is_vcpu_creation_in_progress(src) ||
+	    kvm_is_vcpu_creation_in_progress(dst))
 		return -EBUSY;
 
 	if (!sev_es_guest(src))
@@ -2447,6 +2458,13 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	unsigned long i;
 	int ret;
 
+	if (kvm_is_vcpu_creation_in_progress(kvm))
+		return -EBUSY;
+
+	ret = kvm_lock_all_vcpus(kvm);
+	if (ret)
+		return ret;
+
 	data.gctx_paddr = __psp_pa(sev->snp_context);
 	data.page_type = SNP_PAGE_TYPE_VMSA;
 
@@ -2456,12 +2474,12 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 		ret = sev_es_sync_vmsa(svm);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Transition the VMSA page to a firmware state. */
 		ret = rmp_make_private(pfn, INITIAL_VMSA_GPA, PG_LEVEL_4K, sev->asid, true);
 		if (ret)
-			return ret;
+			goto out;
 
 		/* Issue the SNP command to encrypt the VMSA */
 		data.address = __sme_pa(svm->sev_es.vmsa);
@@ -2470,7 +2488,7 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		if (ret) {
 			snp_page_reclaim(kvm, pfn);
 
-			return ret;
+			goto out;
 		}
 
 		svm->vcpu.arch.guest_state_protected = true;
@@ -2484,7 +2502,9 @@ static int snp_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		svm_enable_lbrv(vcpu);
 	}
 
-	return 0;
+out:
+	kvm_unlock_all_vcpus(kvm);
+	return ret;
 }
 
 static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
@@ -2701,6 +2721,8 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	struct enc_region *region;
 	int ret = 0;
 
+	guard(mutex)(&kvm->lock);
+
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
@@ -2715,12 +2737,10 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	if (!region)
 		return -ENOMEM;
 
-	mutex_lock(&kvm->lock);
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
 				       FOLL_WRITE | FOLL_LONGTERM);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
-		mutex_unlock(&kvm->lock);
 		goto e_free;
 	}
 
@@ -2738,8 +2758,6 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	region->size = range->size;
 
 	list_add_tail(&region->list, &sev->regions_list);
-	mutex_unlock(&kvm->lock);
-
 	return ret;
 
 e_free:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fd1c4a36b593..56347520858e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8225,7 +8225,13 @@ static int emulator_read_write_onepage(unsigned long addr, void *val,
 	WARN_ON(vcpu->mmio_nr_fragments >= KVM_MAX_MMIO_FRAGMENTS);
 	frag = &vcpu->mmio_fragments[vcpu->mmio_nr_fragments++];
 	frag->gpa = gpa;
-	frag->data = val;
+	if (write && bytes <= 8u) {
+		frag->val = 0;
+		frag->data = &frag->val;
+		memcpy(&frag->val, val, bytes);
+	} else {
+		frag->data = val;
+	}
 	frag->len = bytes;
 	return X86EMUL_CONTINUE;
 }
@@ -8240,6 +8246,9 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
 	gpa_t gpa;
 	int rc;
 
+	if (WARN_ON_ONCE((bytes > 8u || !ops->write) && object_is_on_stack(val)))
+		return X86EMUL_UNHANDLEABLE;
+
 	if (ops->read_write_prepare &&
 		  ops->read_write_prepare(vcpu, val, bytes))
 		return X86EMUL_CONTINUE;
@@ -11846,6 +11855,9 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 		frag++;
 		vcpu->mmio_cur_fragment++;
 	} else {
+		if (WARN_ON_ONCE(frag->data == &frag->val))
+			return -EIO;
+
 		/* Go forward to the next mmio piece. */
 		frag->data += len;
 		frag->gpa += len;
diff --git a/arch/x86/lib/copy_user_uncached_64.S b/arch/x86/lib/copy_user_uncached_64.S
index 18350b343c2a..8ed0ce3ad227 100644
--- a/arch/x86/lib/copy_user_uncached_64.S
+++ b/arch/x86/lib/copy_user_uncached_64.S
@@ -27,7 +27,7 @@
  * Output:
  * rax uncopied bytes or 0 if successful.
  */
-SYM_FUNC_START(__copy_user_nocache)
+SYM_FUNC_START(copy_to_nontemporal)
 	ANNOTATE_NOENDBR
 	/* If destination is not 7-byte aligned, we'll have to align it */
 	testb $7,%dil
@@ -240,5 +240,5 @@ _ASM_EXTABLE_UA(95b, .Ldone)
 _ASM_EXTABLE_UA(52b, .Ldone0)
 _ASM_EXTABLE_UA(53b, .Ldone0)
 
-SYM_FUNC_END(__copy_user_nocache)
-EXPORT_SYMBOL(__copy_user_nocache)
+SYM_FUNC_END(copy_to_nontemporal)
+EXPORT_SYMBOL(copy_to_nontemporal)
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index f6f436f1d573..ac27e39fc993 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -322,10 +322,11 @@ unsigned long __copy_user_ll(void *to, const void *from, unsigned long n)
 }
 EXPORT_SYMBOL(__copy_user_ll);
 
-unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *from,
+unsigned long copy_from_user_inatomic_nontemporal(void *to, const void __user *from,
 					unsigned long n)
 {
-	__uaccess_begin_nospec();
+	if (!user_access_begin(from, n))
+		return n;
 #ifdef CONFIG_X86_INTEL_USERCOPY
 	if (n > 64 && static_cpu_has(X86_FEATURE_XMM2))
 		n = __copy_user_intel_nocache(to, from, n);
@@ -334,7 +335,7 @@ unsigned long __copy_from_user_ll_nocache_nozero(void *to, const void __user *fr
 #else
 	__copy_user(to, from, n);
 #endif
-	__uaccess_end();
+	user_access_end();
 	return n;
 }
-EXPORT_SYMBOL(__copy_from_user_ll_nocache_nozero);
+EXPORT_SYMBOL(copy_from_user_inatomic_nontemporal);
diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index 654280aaa3e9..c47d8cd0e243 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -43,17 +43,17 @@ void arch_wb_cache_pmem(void *addr, size_t size)
 }
 EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
 
-long __copy_user_flushcache(void *dst, const void __user *src, unsigned size)
+size_t copy_user_flushcache(void *dst, const void __user *src, size_t size)
 {
 	unsigned long flushed, dest = (unsigned long) dst;
-	long rc;
+	unsigned long rc;
 
-	stac();
-	rc = __copy_user_nocache(dst, src, size);
-	clac();
+	src = masked_user_access_begin(src);
+	rc = copy_to_nontemporal(dst, (__force const void *)src, size);
+	user_access_end();
 
 	/*
-	 * __copy_user_nocache() uses non-temporal stores for the bulk
+	 * copy_to_nontemporal() uses non-temporal stores for the bulk
 	 * of the transfer, but we need to manually flush if the
 	 * transfer is unaligned. A cached memory copy is used when
 	 * destination or size is not naturally aligned. That is:
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 160733619a4a..3cfa1344b1b2 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -520,7 +520,7 @@ ggtt_write(struct io_mapping *mapping,
 
 	/* We can use the cpu mem copy function because this is X86. */
 	vaddr = io_mapping_map_atomic_wc(mapping, base);
-	unwritten = __copy_from_user_inatomic_nocache((void __force *)vaddr + offset,
+	unwritten = copy_from_user_inatomic_nontemporal((void __force *)vaddr + offset,
 						      user_data, length);
 	io_mapping_unmap_atomic(vaddr);
 	if (unwritten) {
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 4ee2b5acf2e0..591b026ceff9 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -183,7 +183,7 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 
 	/* TODO copy slow path code from i915 */
 	fb_cmd = qxl_bo_kmap_atomic_page(qdev, cmd_bo, (release->release_offset & PAGE_MASK));
-	unwritten = __copy_from_user_inatomic_nocache
+	unwritten = copy_from_user_inatomic_nontemporal
 		(fb_cmd + sizeof(union qxl_release_info) + (release->release_offset & ~PAGE_MASK),
 		 u64_to_user_ptr(cmd->command), cmd->command_size);
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index fda214b5a466..2b0ba80ab4b0 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2449,17 +2449,23 @@ static int vc4_hdmi_hotplug_init(struct vc4_hdmi *vc4_hdmi)
 	int ret;
 
 	if (vc4_hdmi->variant->external_irq_controller) {
-		unsigned int hpd_con = platform_get_irq_byname(pdev, "hpd-connected");
-		unsigned int hpd_rm = platform_get_irq_byname(pdev, "hpd-removed");
+		int hpd = platform_get_irq_byname(pdev, "hpd-connected");
 
-		ret = devm_request_threaded_irq(&pdev->dev, hpd_con,
+		if (hpd < 0)
+			return hpd;
+
+		ret = devm_request_threaded_irq(&pdev->dev, hpd,
 						NULL,
 						vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
 						"vc4 hdmi hpd connected", vc4_hdmi);
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&pdev->dev, hpd_rm,
+		hpd = platform_get_irq_byname(pdev, "hpd-removed");
+		if (hpd < 0)
+			return hpd;
+
+		ret = devm_request_threaded_irq(&pdev->dev, hpd,
 						NULL,
 						vc4_hdmi_hpd_irq_thread, IRQF_ONESHOT,
 						"vc4 hdmi hpd disconnected", vc4_hdmi);
diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 21e55f3d0d1b..67179e3fe39b 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -437,6 +437,9 @@ static int alps_raw_event(struct hid_device *hdev,
 	int ret = 0;
 	struct alps_dev *hdata = hid_get_drvdata(hdev);
 
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !hdata->input)
+		return 0;
+
 	switch (hdev->product) {
 	case HID_PRODUCT_ID_T4_BTNLESS:
 		ret = t4_raw_event(hdata, data, size);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 833df14ef68f..868c65684aa8 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -71,6 +71,9 @@ static u32 s32ton(__s32 value, unsigned int n)
 	if (!value || !n)
 		return 0;
 
+	if (n > 32)
+		n = 32;
+
 	a = value >> (n - 1);
 	if (a && a != -1)
 		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
index 4e663d5b4e33..a75b941bd6e2 100644
--- a/drivers/hwmon/powerz.c
+++ b/drivers/hwmon/powerz.c
@@ -108,6 +108,9 @@ static int powerz_read_data(struct usb_device *udev, struct powerz_priv *priv)
 {
 	int ret;
 
+	if (!priv->urb)
+		return -ENODEV;
+
 	priv->status = -ETIMEDOUT;
 	reinit_completion(&priv->completion);
 
@@ -224,6 +227,8 @@ static int powerz_probe(struct usb_interface *intf,
 	mutex_init(&priv->mutex);
 	init_completion(&priv->completion);
 
+	usb_set_intfdata(intf, priv);
+
 	hwmon_dev =
 	    devm_hwmon_device_register_with_info(parent, DRIVER_NAME, priv,
 						 &powerz_chip_info, NULL);
@@ -232,8 +237,6 @@ static int powerz_probe(struct usb_interface *intf,
 		return PTR_ERR(hwmon_dev);
 	}
 
-	usb_set_intfdata(intf, priv);
-
 	return 0;
 }
 
@@ -244,6 +247,7 @@ static void powerz_disconnect(struct usb_interface *intf)
 	mutex_lock(&priv->mutex);
 	usb_kill_urb(priv->urb);
 	usb_free_urb(priv->urb);
+	priv->urb = NULL;
 	mutex_unlock(&priv->mutex);
 }
 
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 8138f5ef40f0..15e14a6fe6dc 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -503,8 +503,13 @@ static void i2c_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
 		i2c->msg->buf[i2c->msg_ptr++] = byte;
 
 		/* Add actual length to read for smbus block read */
-		if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1)
+		if (i2c->msg->flags & I2C_M_RECV_LEN && i2c->msg->len == 1) {
+			if (byte == 0 || byte > I2C_SMBUS_BLOCK_MAX) {
+				s3c24xx_i2c_stop(i2c, -EPROTO);
+				break;
+			}
 			i2c->msg->len += byte;
+		}
  prepare_read:
 		if (is_msglast(i2c)) {
 			/* last byte of buffer */
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index c1199ea5d41f..3c7ee7ddc5dd 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -92,12 +92,10 @@ static int rvt_wss_llc_size(void)
 static void cacheless_memcpy(void *dst, void *src, size_t n)
 {
 	/*
-	 * Use the only available X64 cacheless copy.  Add a __user cast
-	 * to quiet sparse.  The src agument is already in the kernel so
-	 * there are no security issues.  The extra fault recovery machinery
-	 * is not invoked.
+	 * Use the only available X64 cacheless copy.
+	 * The extra fault recovery machinery is not invoked.
 	 */
-	__copy_user_nocache(dst, (void __user *)src, n);
+	copy_to_nontemporal(dst, src, n);
 }
 
 void rvt_wss_exit(struct rvt_dev_info *rdi)
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 64bb38c95895..6627a381f65a 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1373,6 +1373,13 @@ static CLOSURE_CALLBACK(cached_dev_free)
 
 	mutex_unlock(&bch_register_lock);
 
+	/*
+	 * Wait for any pending sb_write to complete before free.
+	 * The sb_bio is embedded in struct cached_dev, so we must
+	 * ensure no I/O is in progress.
+	 */
+	closure_sync(&dc->sb_write);
+
 	if (dc->sb_disk)
 		folio_put(virt_to_folio(dc->sb_disk));
 
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
index c977ed0c09b6..4e4541b2fc8e 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_drv.c
@@ -215,6 +215,15 @@ static int fops_vcodec_release(struct file *file)
 	v4l2_fh_exit(&ctx->fh);
 	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
 
+	/*
+	 * Cancel any pending encode work before freeing the context.
+	 * Although v4l2_m2m_ctx_release() waits for m2m job completion,
+	 * the workqueue handler (mtk_venc_worker) may still be accessing
+	 * the context after v4l2_m2m_job_finish() returns. Without this,
+	 * a use-after-free occurs when the worker accesses ctx after kfree.
+	 */
+	cancel_work_sync(&ctx->encode_work);
+
 	spin_lock_irqsave(&dev->dev_ctx_lock, flags);
 	list_del_init(&ctx->list);
 	spin_unlock_irqrestore(&dev->dev_ctx_lock, flags);
diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index b6203e10e37a..a8a76434989c 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -237,8 +237,10 @@ static int vidtv_start_feed(struct dvb_demux_feed *feed)
 
 	if (dvb->nfeeds == 1) {
 		ret = vidtv_start_streaming(dvb);
-		if (ret < 0)
+		if (ret < 0) {
+			dvb->nfeeds--;
 			rc = ret;
+		}
 	}
 
 	mutex_unlock(&dvb->feed_lock);
diff --git a/drivers/media/test-drivers/vidtv/vidtv_channel.c b/drivers/media/test-drivers/vidtv/vidtv_channel.c
index da20657adc74..5f8c3af87171 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_channel.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_channel.c
@@ -341,6 +341,10 @@ vidtv_channel_pmt_match_sections(struct vidtv_channel *channels,
 					tail = vidtv_psi_pmt_stream_init(tail,
 									 s->type,
 									 e_pid);
+					if (!tail) {
+						vidtv_psi_pmt_stream_destroy(head);
+						return;
+					}
 
 					if (!head)
 						head = tail;
diff --git a/drivers/media/test-drivers/vidtv/vidtv_mux.c b/drivers/media/test-drivers/vidtv/vidtv_mux.c
index 403fbedb8663..f0134e38a1fb 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_mux.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_mux.c
@@ -233,7 +233,7 @@ static u32 vidtv_mux_push_pcr(struct vidtv_mux *m)
 	/* the 27Mhz clock will feed both parts of the PCR bitfield */
 	args.pcr = m->timing.clk;
 
-	nbytes += vidtv_ts_pcr_write_into(args);
+	nbytes += vidtv_ts_pcr_write_into(&args);
 	m->mux_buf_offset += nbytes;
 
 	m->num_streamed_pcr++;
@@ -363,7 +363,7 @@ static u32 vidtv_mux_pad_with_nulls(struct vidtv_mux *m, u32 npkts)
 	args.continuity_counter = &ctx->cc;
 
 	for (i = 0; i < npkts; ++i) {
-		m->mux_buf_offset += vidtv_ts_null_write_into(args);
+		m->mux_buf_offset += vidtv_ts_null_write_into(&args);
 		args.dest_offset  = m->mux_buf_offset;
 	}
 
diff --git a/drivers/media/test-drivers/vidtv/vidtv_ts.c b/drivers/media/test-drivers/vidtv/vidtv_ts.c
index ca4bb9c40b78..cbe9aff9ffb5 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_ts.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_ts.c
@@ -48,7 +48,7 @@ void vidtv_ts_inc_cc(u8 *continuity_counter)
 		*continuity_counter = 0;
 }
 
-u32 vidtv_ts_null_write_into(struct null_packet_write_args args)
+u32 vidtv_ts_null_write_into(const struct null_packet_write_args *args)
 {
 	u32 nbytes = 0;
 	struct vidtv_mpeg_ts ts_header = {};
@@ -56,21 +56,21 @@ u32 vidtv_ts_null_write_into(struct null_packet_write_args args)
 	ts_header.sync_byte          = TS_SYNC_BYTE;
 	ts_header.bitfield           = cpu_to_be16(TS_NULL_PACKET_PID);
 	ts_header.payload            = 1;
-	ts_header.continuity_counter = *args.continuity_counter;
+	ts_header.continuity_counter = *args->continuity_counter;
 
 	/* copy TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_header,
 			       sizeof(ts_header));
 
-	vidtv_ts_inc_cc(args.continuity_counter);
+	vidtv_ts_inc_cc(args->continuity_counter);
 
 	/* fill the rest with empty data */
-	nbytes += vidtv_memset(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memset(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       TS_FILL_BYTE,
 			       TS_PACKET_LEN - nbytes);
 
@@ -83,17 +83,17 @@ u32 vidtv_ts_null_write_into(struct null_packet_write_args args)
 	return nbytes;
 }
 
-u32 vidtv_ts_pcr_write_into(struct pcr_write_args args)
+u32 vidtv_ts_pcr_write_into(const struct pcr_write_args *args)
 {
 	u32 nbytes = 0;
 	struct vidtv_mpeg_ts ts_header = {};
 	struct vidtv_mpeg_ts_adaption ts_adap = {};
 
 	ts_header.sync_byte     = TS_SYNC_BYTE;
-	ts_header.bitfield      = cpu_to_be16(args.pid);
+	ts_header.bitfield      = cpu_to_be16(args->pid);
 	ts_header.scrambling    = 0;
 	/* cc is not incremented, but it is needed. see 13818-1 clause 2.4.3.3 */
-	ts_header.continuity_counter = *args.continuity_counter;
+	ts_header.continuity_counter = *args->continuity_counter;
 	ts_header.payload            = 0;
 	ts_header.adaptation_field   = 1;
 
@@ -102,27 +102,27 @@ u32 vidtv_ts_pcr_write_into(struct pcr_write_args args)
 	ts_adap.PCR    = 1;
 
 	/* copy TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_header,
 			       sizeof(ts_header));
 
 	/* write the adap after the TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_adap,
 			       sizeof(ts_adap));
 
 	/* write the PCR optional */
-	nbytes += vidtv_ts_write_pcr_bits(args.dest_buf,
-					  args.dest_offset + nbytes,
-					  args.pcr);
+	nbytes += vidtv_ts_write_pcr_bits(args->dest_buf,
+					  args->dest_offset + nbytes,
+					  args->pcr);
 
-	nbytes += vidtv_memset(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memset(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       TS_FILL_BYTE,
 			       TS_PACKET_LEN - nbytes);
 
diff --git a/drivers/media/test-drivers/vidtv/vidtv_ts.h b/drivers/media/test-drivers/vidtv/vidtv_ts.h
index 09b4ffd02829..3606398e160d 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_ts.h
+++ b/drivers/media/test-drivers/vidtv/vidtv_ts.h
@@ -90,7 +90,7 @@ void vidtv_ts_inc_cc(u8 *continuity_counter);
  *
  * Return: The number of bytes written into the buffer.
  */
-u32 vidtv_ts_null_write_into(struct null_packet_write_args args);
+u32 vidtv_ts_null_write_into(const struct null_packet_write_args *args);
 
 /**
  * vidtv_ts_pcr_write_into - Write a PCR  packet into a buffer.
@@ -101,6 +101,6 @@ u32 vidtv_ts_null_write_into(struct null_packet_write_args args);
  *
  * Return: The number of bytes written into the buffer.
  */
-u32 vidtv_ts_pcr_write_into(struct pcr_write_args args);
+u32 vidtv_ts_pcr_write_into(const struct pcr_write_args *args);
 
 #endif //VIDTV_TS_H
diff --git a/drivers/media/usb/as102/as102_usb_drv.c b/drivers/media/usb/as102/as102_usb_drv.c
index 8e480ab78f9b..a11024451ceb 100644
--- a/drivers/media/usb/as102/as102_usb_drv.c
+++ b/drivers/media/usb/as102/as102_usb_drv.c
@@ -403,7 +403,9 @@ static int as102_usb_probe(struct usb_interface *intf,
 failed_dvb:
 	as102_free_usb_stream_buffer(as102_dev);
 failed_stream:
+	usb_set_intfdata(intf, NULL);
 	usb_deregister_dev(intf, &as102_usb_class_driver);
+	return ret;
 failed:
 	usb_put_dev(as102_dev->bus_adap.usb_dev);
 	usb_set_intfdata(intf, NULL);
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index b0c184f237a7..5f13f63fbdee 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -2126,7 +2126,7 @@ static int em28xx_v4l2_open(struct file *filp)
 {
 	struct video_device *vdev = video_devdata(filp);
 	struct em28xx *dev = video_drvdata(filp);
-	struct em28xx_v4l2 *v4l2 = dev->v4l2;
+	struct em28xx_v4l2 *v4l2;
 	enum v4l2_buf_type fh_type = 0;
 	int ret;
 
@@ -2143,13 +2143,19 @@ static int em28xx_v4l2_open(struct file *filp)
 		return -EINVAL;
 	}
 
+	if (mutex_lock_interruptible(&dev->lock))
+		return -ERESTARTSYS;
+
+	v4l2 = dev->v4l2;
+	if (!v4l2) {
+		mutex_unlock(&dev->lock);
+		return -ENODEV;
+	}
+
 	em28xx_videodbg("open dev=%s type=%s users=%d\n",
 			video_device_node_name(vdev), v4l2_type_names[fh_type],
 			v4l2->users);
 
-	if (mutex_lock_interruptible(&dev->lock))
-		return -ERESTARTSYS;
-
 	ret = v4l2_fh_open(filp);
 	if (ret) {
 		dev_err(&dev->intf->dev,
diff --git a/drivers/media/usb/hackrf/hackrf.c b/drivers/media/usb/hackrf/hackrf.c
index 94d356fba612..a15829a60e88 100644
--- a/drivers/media/usb/hackrf/hackrf.c
+++ b/drivers/media/usb/hackrf/hackrf.c
@@ -1485,7 +1485,7 @@ static int hackrf_probe(struct usb_interface *intf,
 	if (ret) {
 		dev_err(dev->dev,
 			"Failed to register as video device (%d)\n", ret);
-		goto err_v4l2_device_unregister;
+		goto err_v4l2_device_put;
 	}
 	dev_info(dev->dev, "Registered as %s\n",
 		 video_device_node_name(&dev->rx_vdev));
@@ -1513,8 +1513,9 @@ static int hackrf_probe(struct usb_interface *intf,
 	return 0;
 err_video_unregister_device_rx:
 	video_unregister_device(&dev->rx_vdev);
-err_v4l2_device_unregister:
-	v4l2_device_unregister(&dev->v4l2_dev);
+err_v4l2_device_put:
+	v4l2_device_put(&dev->v4l2_dev);
+	return ret;
 err_v4l2_ctrl_handler_free_tx:
 	v4l2_ctrl_handler_free(&dev->tx_ctrl_handler);
 err_v4l2_ctrl_handler_free_rx:
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
index b942076762ef..67e93e17d4d9 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
@@ -194,6 +194,7 @@ void bnge_rdma_aux_device_add(struct bnge_dev *bd)
 		dev_warn(bd->dev, "Failed to add auxiliary device for ROCE\n");
 		auxiliary_device_uninit(aux_dev);
 		bd->flags &= ~BNGE_EN_ROCE;
+		return;
 	}
 
 	bd->auxr_dev->net = bd->netdev;
diff --git a/drivers/net/usb/cdc-phonet.c b/drivers/net/usb/cdc-phonet.c
index ad5121e9cf5d..165650ecef64 100644
--- a/drivers/net/usb/cdc-phonet.c
+++ b/drivers/net/usb/cdc-phonet.c
@@ -157,11 +157,16 @@ static void rx_complete(struct urb *req)
 						PAGE_SIZE);
 				page = NULL;
 			}
-		} else {
+		} else if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					page, 0, req->actual_length,
 					PAGE_SIZE);
 			page = NULL;
+		} else {
+			dev_kfree_skb_any(skb);
+			pnd->rx_skb = NULL;
+			skb = NULL;
+			dev->stats.rx_length_errors++;
 		}
 		if (req->actual_length < PAGE_SIZE)
 			pnd->rx_skb = NULL; /* Last fragment */
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 46a71ec36af8..67b07ee2d660 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -411,12 +411,11 @@ static struct rtnl_link_ops link_ops __read_mostly = {
 	.newlink		= wg_newlink,
 };
 
-static void wg_netns_pre_exit(struct net *net)
+static void __net_exit wg_netns_exit_rtnl(struct net *net, struct list_head *dev_kill_list)
 {
 	struct wg_device *wg;
 	struct wg_peer *peer;
 
-	rtnl_lock();
 	list_for_each_entry(wg, &device_list, device_list) {
 		if (rcu_access_pointer(wg->creating_net) == net) {
 			pr_debug("%s: Creating namespace exiting\n", wg->dev->name);
@@ -429,11 +428,10 @@ static void wg_netns_pre_exit(struct net *net)
 			mutex_unlock(&wg->device_update_lock);
 		}
 	}
-	rtnl_unlock();
 }
 
-static struct pernet_operations pernet_ops = {
-	.pre_exit = wg_netns_pre_exit
+static struct pernet_operations pernet_ops __read_mostly = {
+	.exit_rtnl = wg_netns_exit_rtnl
 };
 
 int __init wg_device_init(void)
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 433b06c8d8a6..718940ebba31 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -1041,7 +1041,7 @@ static int rtw_usb_intf_init(struct rtw_dev *rtwdev,
 			     struct usb_interface *intf)
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
-	struct usb_device *udev = usb_get_dev(interface_to_usbdev(intf));
+	struct usb_device *udev = interface_to_usbdev(intf);
 	int ret;
 
 	rtwusb->udev = udev;
@@ -1067,7 +1067,6 @@ static void rtw_usb_intf_deinit(struct rtw_dev *rtwdev,
 {
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 
-	usb_put_dev(rtwusb->udev);
 	kfree(rtwusb->usb_data);
 	usb_set_intfdata(intf, NULL);
 }
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 78e02fe6caba..2e77b699be2a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1779,12 +1779,13 @@ static void ntb_tx_copy_callback(void *data,
 
 static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *offset)
 {
-#ifdef ARCH_HAS_NOCACHE_UACCESS
+#ifdef copy_to_nontemporal
 	/*
 	 * Using non-temporal mov to improve performance on non-cached
-	 * writes, even though we aren't actually copying from user space.
+	 * writes. This only works if __iomem is strictly memory-like,
+	 * but that is the case on x86-64
 	 */
-	__copy_from_user_inatomic_nocache(offset, entry->buf, entry->len);
+	copy_to_nontemporal(offset, entry->buf, entry->len);
 #else
 	memcpy_toio(offset, entry->buf, entry->len);
 #endif
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 20a400e83439..65f5bbf28480 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -763,19 +763,6 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	}
 }
 
-/**
- * epf_ntb_epc_destroy() - Cleanup NTB EPC interface
- * @ntb: NTB device that facilitates communication between HOST and VHOST
- *
- * Wrapper for epf_ntb_epc_destroy_interface() to cleanup all the NTB interfaces
- */
-static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
-{
-	pci_epc_remove_epf(ntb->epf->epc, ntb->epf, 0);
-	pci_epc_put(ntb->epf->epc);
-}
-
-
 /**
  * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
  * @ntb: NTB device that facilitates communication between HOST and VHOST
@@ -955,6 +942,7 @@ static int epf_ntb_epc_init(struct epf_ntb *ntb)
  */
 static void epf_ntb_epc_cleanup(struct epf_ntb *ntb)
 {
+	disable_delayed_work_sync(&ntb->cmd_handler);
 	epf_ntb_mw_bar_clear(ntb, ntb->num_mws);
 	epf_ntb_db_bar_clear(ntb);
 	epf_ntb_config_sspad_bar_clear(ntb);
@@ -1525,7 +1513,7 @@ static int epf_ntb_bind(struct pci_epf *epf)
 	ret = epf_ntb_init_epc_bar(ntb);
 	if (ret) {
 		dev_err(dev, "Failed to create NTB EPC\n");
-		goto err_bar_init;
+		return ret;
 	}
 
 	ret = epf_ntb_config_spad_bar_alloc(ntb);
@@ -1565,9 +1553,6 @@ static int epf_ntb_bind(struct pci_epf *epf)
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
-err_bar_init:
-	epf_ntb_epc_destroy(ntb);
-
 	return ret;
 }
 
@@ -1583,7 +1568,6 @@ static void epf_ntb_unbind(struct pci_epf *epf)
 
 	epf_ntb_epc_cleanup(ntb);
 	epf_ntb_config_spad_bar_free(ntb);
-	epf_ntb_epc_destroy(ntb);
 
 	pci_unregister_driver(&vntb_pci_driver);
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index b489babe7432..c3f5fc4abd17 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -1291,7 +1291,7 @@ u32 rtw_BIP_verify(struct adapter *padapter, u8 *precvframe)
 	u8 mic[16];
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	__le16 le_tmp;
-	__le64 le_tmp64;
+	__le64 le_tmp64 = 0;
 
 	ori_len = pattrib->pkt_len - WLAN_HDR_A3_LEN + BIP_AAD_SIZE;
 	BIP_AAD = kzalloc(ori_len, GFP_KERNEL);
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 62f6e0cdff4d..04e45e2bc958 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -481,6 +481,9 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	struct lynxfb_crtc *crtc;
 	resource_size_t request;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	ret = 0;
 	par = info->par;
 	crtc = &par->crtc;
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index cf3c3eede1a5..54059e4fc6ed 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -114,6 +114,8 @@ static int acm_ctrl_msg(struct acm *acm, int request, int value,
 	int retval;
 
 	retval = usb_autopm_get_interface(acm->control);
+#define VENDOR_CLASS_DATA_IFACE		BIT(9)  /* data interface uses vendor-specific class */
+#define ALWAYS_POLL_CTRL		BIT(10) /* keep ctrl URB active even without an open TTY */
 	if (retval)
 		return retval;
 
@@ -710,12 +712,14 @@ static int acm_port_activate(struct tty_port *port, struct tty_struct *tty)
 	set_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
 	acm->control->needs_remote_wakeup = 1;
 
-	acm->ctrlurb->dev = acm->dev;
-	retval = usb_submit_urb(acm->ctrlurb, GFP_KERNEL);
-	if (retval) {
-		dev_err(&acm->control->dev,
-			"%s - usb_submit_urb(ctrl irq) failed\n", __func__);
-		goto error_submit_urb;
+	if (!(acm->quirks & ALWAYS_POLL_CTRL)) {
+		acm->ctrlurb->dev = acm->dev;
+		retval = usb_submit_urb(acm->ctrlurb, GFP_KERNEL);
+		if (retval) {
+			dev_err(&acm->control->dev,
+				"%s - usb_submit_urb(ctrl irq) failed\n", __func__);
+			goto error_submit_urb;
+		}
 	}
 
 	acm_tty_set_termios(tty, NULL);
@@ -788,6 +792,14 @@ static void acm_port_shutdown(struct tty_port *port)
 
 	acm_unpoison_urbs(acm);
 
+	if (acm->quirks & ALWAYS_POLL_CTRL) {
+		acm->ctrlurb->dev = acm->dev;
+		if (usb_submit_urb(acm->ctrlurb, GFP_KERNEL))
+			dev_dbg(&acm->control->dev,
+				"ctrl polling restart failed after port close\n");
+		/* port_shutdown() cleared DTR/RTS; restore them */
+		acm_set_control(acm, USB_CDC_CTRL_DTR | USB_CDC_CTRL_RTS);
+	}
 }
 
 static void acm_tty_cleanup(struct tty_struct *tty)
@@ -1328,6 +1340,9 @@ static int acm_probe(struct usb_interface *intf,
 			dev_dbg(&intf->dev,
 				"Your device has switched interfaces.\n");
 			swap(control_interface, data_interface);
+		} else if (quirks & VENDOR_CLASS_DATA_IFACE) {
+			dev_dbg(&intf->dev,
+				"Vendor-specific data interface class, continuing.\n");
 		} else {
 			return -EINVAL;
 		}
@@ -1522,6 +1537,9 @@ static int acm_probe(struct usb_interface *intf,
 	acm->line.bDataBits = 8;
 	acm_set_line(acm, &acm->line);
 
+	if (quirks & ALWAYS_POLL_CTRL)
+		acm_set_control(acm, USB_CDC_CTRL_DTR | USB_CDC_CTRL_RTS);
+
 	if (!acm->combined_interfaces) {
 		rv = usb_driver_claim_interface(&acm_driver, data_interface, acm);
 		if (rv)
@@ -1543,6 +1561,13 @@ static int acm_probe(struct usb_interface *intf,
 
 	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
+	if (acm->quirks & ALWAYS_POLL_CTRL) {
+		acm->ctrlurb->dev = acm->dev;
+		if (usb_submit_urb(acm->ctrlurb, GFP_KERNEL))
+			dev_warn(&intf->dev,
+				 "failed to start persistent ctrl polling\n");
+	}
+
 	return 0;
 
 err_release_data_interface:
@@ -1669,7 +1694,7 @@ static int acm_resume(struct usb_interface *intf)
 
 	acm_unpoison_urbs(acm);
 
-	if (tty_port_initialized(&acm->port)) {
+	if (tty_port_initialized(&acm->port) || (acm->quirks & ALWAYS_POLL_CTRL)) {
 		rv = usb_submit_urb(acm->ctrlurb, GFP_ATOMIC);
 
 		for (;;) {
@@ -2016,6 +2041,20 @@ static const struct usb_device_id acm_ids[] = {
 	/* CH343 supports CAP_BRK, but doesn't advertise it */
 	{ USB_DEVICE(0x1a86, 0x55d3), .driver_info = MISSING_CAP_BRK, },
 
+	/*
+	 * Lenovo Yoga Book 9 14IAH10 (83KJ) — INGENIC 17EF:6161 touchscreen
+	 * composite device.  The CDC ACM control interface (0) uses a standard
+	 * Union descriptor, but the data interface (1) is declared as vendor-
+	 * specific class (0xff) with no CDC data descriptors, so cdc-acm would
+	 * normally reject it.  The firmware also requires continuous polling of
+	 * the notification endpoint (EP 0x82) to suppress a 20-second watchdog
+	 * reset; ALWAYS_POLL_CTRL keeps the ctrlurb active even when no TTY is
+	 * open.  Match only the control interface by class to avoid probing the
+	 * vendor-specific data interface.
+	 */
+	{ USB_DEVICE_INTERFACE_CLASS(0x17ef, 0x6161, USB_CLASS_COMM),
+	  .driver_info = VENDOR_CLASS_DATA_IFACE | ALWAYS_POLL_CTRL },
+
 	/* control interfaces without any protocol set */
 	{ USB_INTERFACE_INFO(USB_CLASS_COMM, USB_CDC_SUBCLASS_ACM,
 		USB_CDC_PROTO_NONE) },
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 44e38f922bc5..027a5f21c5f7 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -141,6 +141,7 @@ static ssize_t disable_store(struct device *dev, struct device_attribute *attr,
 		usb_disconnect(&port_dev->child);
 
 	rc = usb_hub_set_port_power(hdev, hub, port1, !disabled);
+	msleep(2 * hub_power_on_good_delay(hub));
 
 	if (disabled) {
 		usb_clear_port_feature(hdev, port1, USB_PORT_FEAT_C_CONNECTION);
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index e5ccaec7750c..e0c3f39ee95e 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -106,7 +106,7 @@ struct f_hidg {
 	struct list_head		report_list;
 
 	struct device			dev;
-	struct cdev			cdev;
+	struct cdev			*cdev;
 	struct usb_function		func;
 
 	struct usb_ep			*in_ep;
@@ -749,8 +749,9 @@ static int f_hidg_release(struct inode *inode, struct file *fd)
 
 static int f_hidg_open(struct inode *inode, struct file *fd)
 {
+	struct kobject *parent = inode->i_cdev->kobj.parent;
 	struct f_hidg *hidg =
-		container_of(inode->i_cdev, struct f_hidg, cdev);
+		container_of(parent, struct f_hidg, dev.kobj);
 
 	fd->private_data = hidg;
 
@@ -1276,8 +1277,12 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 
 	/* create char device */
-	cdev_init(&hidg->cdev, &f_hidg_fops);
-	status = cdev_device_add(&hidg->cdev, &hidg->dev);
+	hidg->cdev = cdev_alloc();
+	if (!hidg->cdev)
+		goto fail_free_all;
+	hidg->cdev->ops = &f_hidg_fops;
+
+	status = cdev_device_add(hidg->cdev, &hidg->dev);
 	if (status)
 		goto fail_free_all;
 
@@ -1579,7 +1584,7 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_hidg *hidg = func_to_hidg(f);
 
-	cdev_device_del(&hidg->cdev, &hidg->dev);
+	cdev_device_del(hidg->cdev, &hidg->dev);
 	destroy_workqueue(hidg->workqueue);
 	usb_free_all_descriptors(f);
 }
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index a6fa5ed3d6cb..c5bf8a448d64 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1210,8 +1210,8 @@ static int ncm_unwrap_ntb(struct gether *port,
 
 	block_len = get_ncm(&tmp, opts->block_length);
 	/* (d)wBlockLength */
-	if (block_len > ntb_max) {
-		INFO(port->func.config->cdev, "OUT size exceeded\n");
+	if ((block_len < opts->nth_size + opts->ndp_size) || (block_len > ntb_max)) {
+		INFO(port->func.config->cdev, "Bad block length: %#X\n", block_len);
 		goto err;
 	}
 
diff --git a/drivers/usb/gadget/function/f_phonet.c b/drivers/usb/gadget/function/f_phonet.c
index 2c007790ead2..b1ee9a7c2e94 100644
--- a/drivers/usb/gadget/function/f_phonet.c
+++ b/drivers/usb/gadget/function/f_phonet.c
@@ -333,6 +333,15 @@ static void pn_rx_complete(struct usb_ep *ep, struct usb_request *req)
 		if (unlikely(!skb))
 			break;
 
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {
+			/* Frame count from host exceeds frags[] capacity */
+			dev_kfree_skb_any(skb);
+			if (fp->rx.skb == skb)
+				fp->rx.skb = NULL;
+			dev->stats.rx_length_errors++;
+			break;
+		}
+
 		if (skb->len == 0) { /* First fragment */
 			skb->protocol = htons(ETH_P_PHONET);
 			skb_reset_mac_header(skb);
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index b0b264d34919..2c9c3e935a5e 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -1669,6 +1669,10 @@ static bool usb3_std_req_get_status(struct renesas_usb3 *usb3,
 		break;
 	case USB_RECIP_ENDPOINT:
 		num = le16_to_cpu(ctrl->wIndex) & USB_ENDPOINT_NUMBER_MASK;
+		if (num >= usb3->num_usb3_eps) {
+			stall = true;
+			break;
+		}
 		usb3_ep = usb3_get_ep(usb3, num);
 		if (usb3_ep->halt)
 			status |= 1 << USB_ENDPOINT_HALT;
@@ -1781,7 +1785,8 @@ static bool usb3_std_req_feature_endpoint(struct renesas_usb3 *usb3,
 	struct renesas_usb3_ep *usb3_ep;
 	struct renesas_usb3_request *usb3_req;
 
-	if (le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT)
+	if ((le16_to_cpu(ctrl->wValue) != USB_ENDPOINT_HALT) ||
+	    (num >= usb3->num_usb3_eps))
 		return true;	/* stall */
 
 	usb3_ep = usb3_get_ep(usb3, num);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 313612114db9..c71461893d20 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1383,6 +1383,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) | RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1073, 0xff),	/* Telit FN990A (ECM) */
 	  .driver_info = NCTRL(0) | RSVD(1) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1074, 0xff),	/* Telit FN990A (MBIM) */
+	  .driver_info = NCTRL(5) | RSVD(6) | RSVD(7) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1075, 0xff),	/* Telit FN990A (PCIe) */
 	  .driver_info = RSVD(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1077, 0xff),	/* Telit FN990A (rmnet + audio) */
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 47f50d7a385c..255968f9ca42 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2350,10 +2350,11 @@ UNUSUAL_DEV(  0x2027, 0xa001, 0x0000, 0x9999,
 		US_FL_SCM_MULT_TARG ),
 
 /*
- * Reported by DocMAX <mail@vacharakis.de>
- * and Thomas Weißschuh <linux@weissschuh.net>
+ * Reported by DocMAX <mail@vacharakis.de>,
+ * Thomas Weißschuh <linux@weissschuh.net>
+ * and Daniel Brát <danek.brat@gmail.com>
  */
-UNUSUAL_DEV( 0x2109, 0x0715, 0x9999, 0x9999,
+UNUSUAL_DEV( 0x2109, 0x0715, 0x0000, 0x9999,
 		"VIA Labs, Inc.",
 		"VL817 SATA Bridge",
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 19ff8217818e..5b1f2750cfc3 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1755,8 +1755,9 @@ static int fusb302_probe(struct i2c_client *client)
 		goto destroy_workqueue;
 	}
 
-	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
-			  IRQF_TRIGGER_LOW, "fsc_interrupt_int_n", chip);
+	ret = request_threaded_irq(chip->gpio_int_n_irq, NULL, fusb302_irq_intn,
+				   IRQF_ONESHOT | IRQF_TRIGGER_LOW,
+				   "fsc_interrupt_int_n", chip);
 	if (ret < 0) {
 		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
 		goto tcpm_unregister_port;
diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
index a2b2da1255dd..ba9e7c616e12 100644
--- a/drivers/usb/usbip/usbip_common.c
+++ b/drivers/usb/usbip/usbip_common.c
@@ -470,6 +470,18 @@ static void usbip_pack_ret_submit(struct usbip_header *pdu, struct urb *urb,
 		urb->status		= rpdu->status;
 		urb->actual_length	= rpdu->actual_length;
 		urb->start_frame	= rpdu->start_frame;
+		/*
+		 * The number_of_packets field determines the length of
+		 * iso_frame_desc[], which is a flexible array allocated
+		 * at URB creation time. A response must never claim more
+		 * packets than originally submitted; doing so would cause
+		 * an out-of-bounds write in usbip_recv_iso() and
+		 * usbip_pad_iso(). Clamp to zero on violation so both
+		 * functions safely return early.
+		 */
+		if (rpdu->number_of_packets < 0 ||
+		    rpdu->number_of_packets > urb->number_of_packets)
+			rpdu->number_of_packets = 0;
 		urb->number_of_packets = rpdu->number_of_packets;
 		urb->error_count	= rpdu->error_count;
 	}
diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index fff95b2d5dde..409fa22dfc78 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -454,39 +454,46 @@ static const struct vfio_migration_ops xe_vfio_pci_migration_ops = {
 static void xe_vfio_pci_migration_init(struct xe_vfio_pci_core_device *xe_vdev)
 {
 	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
-	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
-	struct xe_device *xe = xe_sriov_vfio_get_pf(pdev);
 
-	if (!xe)
+	if (!xe_sriov_vfio_migration_supported(xe_vdev->xe))
 		return;
-	if (!xe_sriov_vfio_migration_supported(xe))
-		return;
-
-	mutex_init(&xe_vdev->state_mutex);
-	spin_lock_init(&xe_vdev->reset_lock);
-
-	/* PF internal control uses vfid index starting from 1 */
-	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
-	xe_vdev->xe = xe;
 
 	core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_P2P;
 	core_vdev->mig_ops = &xe_vfio_pci_migration_ops;
 }
 
-static void xe_vfio_pci_migration_fini(struct xe_vfio_pci_core_device *xe_vdev)
+static int xe_vfio_pci_vf_init(struct xe_vfio_pci_core_device *xe_vdev)
 {
-	if (!xe_vdev->vfid)
-		return;
+	struct vfio_device *core_vdev = &xe_vdev->core_device.vdev;
+	struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
+	struct xe_device *xe = xe_sriov_vfio_get_pf(pdev);
 
-	mutex_destroy(&xe_vdev->state_mutex);
+	if (!pdev->is_virtfn)
+		return 0;
+	if (!xe)
+		return -ENODEV;
+	xe_vdev->xe = xe;
+
+	/* PF internal control uses vfid index starting from 1 */
+	xe_vdev->vfid = pci_iov_vf_id(pdev) + 1;
+
+	xe_vfio_pci_migration_init(xe_vdev);
+
+	return 0;
 }
 
 static int xe_vfio_pci_init_dev(struct vfio_device *core_vdev)
 {
 	struct xe_vfio_pci_core_device *xe_vdev =
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
+	int ret;
 
-	xe_vfio_pci_migration_init(xe_vdev);
+	mutex_init(&xe_vdev->state_mutex);
+	spin_lock_init(&xe_vdev->reset_lock);
+
+	ret = xe_vfio_pci_vf_init(xe_vdev);
+	if (ret)
+		return ret;
 
 	return vfio_pci_core_init_dev(core_vdev);
 }
@@ -496,7 +503,7 @@ static void xe_vfio_pci_release_dev(struct vfio_device *core_vdev)
 	struct xe_vfio_pci_core_device *xe_vdev =
 		container_of(core_vdev, struct xe_vfio_pci_core_device, core_device.vdev);
 
-	xe_vfio_pci_migration_fini(xe_vdev);
+	mutex_destroy(&xe_vdev->state_mutex);
 }
 
 static const struct vfio_device_ops xe_vfio_pci_ops = {
diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 51ebe78359ec..531fb8478e20 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -496,6 +496,9 @@ static int tdfxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		}
 	}
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	if (PICOS2KHZ(var->pixclock) > par->max_pixclock) {
 		DPRINTK("pixclock too high (%ldKHz)\n",
 			PICOS2KHZ(var->pixclock));
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 3c6a9b5758d9..c341d76bc564 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1018,6 +1018,9 @@ static int dlfb_ops_check_var(struct fb_var_screeninfo *var,
 	struct fb_videomode mode;
 	struct dlfb_data *dlfb = info->par;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* set device-specific elements of var unrelated to mode */
 	dlfb_var_color_format(var);
 
diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..24f4f3acaa8c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3257,7 +3257,7 @@ static void __init dcache_init_early(void)
 					HASH_EARLY | HASH_ZERO,
 					&d_hash_shift,
 					NULL,
-					0,
+					2,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
 
@@ -3289,7 +3289,7 @@ static void __init dcache_init(void)
 					HASH_ZERO,
 					&d_hash_shift,
 					NULL,
-					0,
+					2,
 					0);
 	d_hash_shift = 32 - d_hash_shift;
 
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 674380837ab9..888dc1831c86 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -524,6 +524,9 @@ int nilfs_dat_read(struct super_block *sb, size_t entry_size,
 	if (err)
 		goto failed;
 
+	err = nilfs_attach_btree_node_cache(dat);
+	if (err)
+		goto failed;
 	err = nilfs_read_inode_common(dat, raw_inode);
 	if (err)
 		goto failed;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 17ba79f443ee..09146b43d1f0 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2294,8 +2294,6 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 		goto out;
 	}
 
-	down_write(&oi->ip_alloc_sem);
-
 	/* Delete orphan before acquire i_rwsem. */
 	if (dwc->dw_orphaned) {
 		BUG_ON(dwc->dw_writer_pid != task_pid_nr(current));
@@ -2308,6 +2306,7 @@ static int ocfs2_dio_end_io_write(struct inode *inode,
 			mlog_errno(ret);
 	}
 
+	down_write(&oi->ip_alloc_sem);
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 
 	ocfs2_init_dinode_extent_tree(&et, INODE_CACHE(inode), di_bh);
diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
index 50e2faf64c19..6c570157caf1 100644
--- a/fs/ocfs2/mmap.c
+++ b/fs/ocfs2/mmap.c
@@ -30,7 +30,8 @@
 
 static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
+	unsigned long long ip_blkno =
+		OCFS2_I(file_inode(vmf->vma->vm_file))->ip_blkno;
 	sigset_t oldset;
 	vm_fault_t ret;
 
@@ -38,11 +39,9 @@ static vm_fault_t ocfs2_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	ocfs2_unblock_signals(&oldset);
 
-	trace_ocfs2_fault(OCFS2_I(vma->vm_file->f_mapping->host)->ip_blkno,
-			  vma, vmf->page, vmf->pgoff);
+	trace_ocfs2_fault(ip_blkno, vmf->page, vmf->pgoff);
 	return ret;
 }
-
 static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
 			struct buffer_head *di_bh, struct folio *folio)
 {
diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
index 4b32fb5658ad..6c2c97a9804f 100644
--- a/fs/ocfs2/ocfs2_trace.h
+++ b/fs/ocfs2/ocfs2_trace.h
@@ -1246,22 +1246,20 @@ TRACE_EVENT(ocfs2_write_end_inline,
 
 TRACE_EVENT(ocfs2_fault,
 	TP_PROTO(unsigned long long ino,
-		 void *area, void *page, unsigned long pgoff),
-	TP_ARGS(ino, area, page, pgoff),
+		 void *page, unsigned long pgoff),
+	TP_ARGS(ino, page, pgoff),
 	TP_STRUCT__entry(
 		__field(unsigned long long, ino)
-		__field(void *, area)
 		__field(void *, page)
 		__field(unsigned long, pgoff)
 	),
 	TP_fast_assign(
 		__entry->ino = ino;
-		__entry->area = area;
 		__entry->page = page;
 		__entry->pgoff = pgoff;
 	),
-	TP_printk("%llu %p %p %lu",
-		  __entry->ino, __entry->area, __entry->page, __entry->pgoff)
+	TP_printk("%llu %p %lu",
+		  __entry->ino, __entry->page, __entry->pgoff)
 );
 
 /* End of trace events for fs/ocfs2/mmap.c. */
diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index ac3ec2c21119..09724e7dc01b 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -303,9 +303,13 @@ int ocfs2_group_extend(struct inode * inode, int new_clusters)
 
 	fe = (struct ocfs2_dinode *)main_bm_bh->b_data;
 
-	/* main_bm_bh is validated by inode read inside ocfs2_inode_lock(),
-	 * so any corruption is a code bug. */
-	BUG_ON(!OCFS2_IS_VALID_DINODE(fe));
+	/* JBD-managed buffers can bypass validation, so treat this as corruption. */
+	if (!OCFS2_IS_VALID_DINODE(fe)) {
+		ret = ocfs2_error(main_bm_inode->i_sb,
+				  "Invalid dinode #%llu\n",
+				  (unsigned long long)OCFS2_I(main_bm_inode)->ip_blkno);
+		goto out_unlock;
+	}
 
 	if (le16_to_cpu(fe->id2.i_chain.cl_cpg) !=
 		ocfs2_group_bitmap_size(osb->sb, 0,
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index ed651c946251..b292aa94a593 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -27,10 +27,11 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 {
 	struct smb2_err_rsp *err = iov->iov_base;
 	struct smb2_symlink_err_rsp *sym = ERR_PTR(-EINVAL);
+	u8 *end = (u8 *)err + iov->iov_len;
 	u32 len;
 
 	if (err->ErrorContextCount) {
-		struct smb2_error_context_rsp *p, *end;
+		struct smb2_error_context_rsp *p;
 
 		len = (u32)err->ErrorContextCount * (offsetof(struct smb2_error_context_rsp,
 							      ErrorContextData) +
@@ -39,8 +40,7 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 			return ERR_PTR(-EINVAL);
 
 		p = (struct smb2_error_context_rsp *)err->ErrorData;
-		end = (struct smb2_error_context_rsp *)((u8 *)err + iov->iov_len);
-		do {
+		while ((u8 *)p + sizeof(*p) <= end) {
 			if (le32_to_cpu(p->ErrorId) == SMB2_ERROR_ID_DEFAULT) {
 				sym = (struct smb2_symlink_err_rsp *)p->ErrorContextData;
 				break;
@@ -50,14 +50,16 @@ static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 
 			len = ALIGN(le32_to_cpu(p->ErrorDataLength), 8);
 			p = (struct smb2_error_context_rsp *)(p->ErrorContextData + len);
-		} while (p < end);
+		}
 	} else if (le32_to_cpu(err->ByteCount) >= sizeof(*sym) &&
 		   iov->iov_len >= SMB2_SYMLINK_STRUCT_SIZE) {
 		sym = (struct smb2_symlink_err_rsp *)err->ErrorData;
 	}
 
-	if (!IS_ERR(sym) && (le32_to_cpu(sym->SymLinkErrorTag) != SYMLINK_ERROR_TAG ||
-			     le32_to_cpu(sym->ReparseTag) != IO_REPARSE_TAG_SYMLINK))
+	if (!IS_ERR(sym) &&
+	    ((u8 *)sym + sizeof(*sym) > end ||
+	     le32_to_cpu(sym->SymLinkErrorTag) != SYMLINK_ERROR_TAG ||
+	     le32_to_cpu(sym->ReparseTag) != IO_REPARSE_TAG_SYMLINK))
 		sym = ERR_PTR(-EINVAL);
 
 	return sym;
@@ -128,8 +130,10 @@ int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec
 	print_len = le16_to_cpu(sym->PrintNameLength);
 	print_offs = le16_to_cpu(sym->PrintNameOffset);
 
-	if (iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + sub_offs + sub_len ||
-	    iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + print_offs + print_len)
+	if ((char *)sym->PathBuffer + sub_offs + sub_len >
+		(char *)iov->iov_base + iov->iov_len ||
+	    (char *)sym->PathBuffer + print_offs + print_len >
+		(char *)iov->iov_base + iov->iov_len)
 		return -EINVAL;
 
 	return smb2_parse_native_symlink(path,
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 364bdcff9c9d..fe1c9d776580 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -128,7 +128,7 @@ static int check_wsl_eas(struct kvec *rsp_iov)
 		nlen = ea->ea_name_length;
 		vlen = le16_to_cpu(ea->ea_value_length);
 		if (nlen != SMB2_WSL_XATTR_NAME_LEN ||
-		    (u8 *)ea + nlen + 1 + vlen > end)
+		    (u8 *)ea->ea_data + nlen + 1 + vlen > end)
 			return -EINVAL;
 
 		switch (vlen) {
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index c79304012b08..461658105013 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1551,17 +1551,25 @@ static int smbd_post_send_iter(struct smbdirect_socket *sc,
 
 	rc = smbd_post_send(sc, batch, request);
 	if (!rc) {
+		/*
+		 * From here request is moved to batch
+		 * and we should not free it explicitly.
+		 */
+
 		if (batch != &_batch)
 			return 0;
 
 		rc = smbd_send_batch_flush(sc, batch, true);
 		if (!rc)
 			return 0;
+
+		goto err_flush;
 	}
 
 err_dma:
 	smbd_free_send_io(request);
 
+err_flush:
 err_alloc:
 	atomic_inc(&sc->send_io.credits.count);
 	wake_up(&sc->send_io.credits.wait_queue);
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 1bb2081c492c..26cfce344861 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -96,6 +96,7 @@ void ksmbd_conn_free(struct ksmbd_conn *conn)
 	xa_destroy(&conn->sessions);
 	kvfree(conn->request_buf);
 	kfree(conn->preauth_info);
+	kfree(conn->mechToken);
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		conn->transport->ops->free_transport(conn->transport);
 		kfree(conn);
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8e4cfdc0ba02..a344937595f4 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1915,7 +1915,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	else if (rc)
 		rsp->hdr.Status = STATUS_LOGON_FAILURE;
 
-	if (conn->use_spnego && conn->mechToken) {
+	if (conn->mechToken) {
 		kfree(conn->mechToken);
 		conn->mechToken = NULL;
 	}
@@ -4716,6 +4716,11 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 		ea_req = (struct smb2_ea_info_req *)((char *)req +
 						     le16_to_cpu(req->InputBufferOffset));
+
+		if (le32_to_cpu(req->InputBufferLength) <
+		    offsetof(struct smb2_ea_info_req, name) +
+		    ea_req->EaNameLength)
+			return -EINVAL;
 	} else {
 		/* need to send all EAs, if no specific EA is requested*/
 		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c30d01877c41..061a305bf9c8 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -451,7 +451,8 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		ppace[i]->access_req =
 			smb_map_generic_desired_access(ppace[i]->access_req);
 
-		if (!(compare_sids(&ppace[i]->sid, &sid_unix_NFS_mode))) {
+		if (ppace[i]->sid.num_subauth >= 3 &&
+		    !(compare_sids(&ppace[i]->sid, &sid_unix_NFS_mode))) {
 			fattr->cf_mode =
 				le32_to_cpu(ppace[i]->sid.sub_auth[2]);
 			break;
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 188572491d53..dbc8dedb85dc 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1588,15 +1588,21 @@ static int smb_direct_post_send_data(struct smbdirect_socket *sc,
 	if (ret)
 		goto err;
 
+	/*
+	 * From here msg is moved to send_ctx
+	 * and we should not free it explicitly.
+	 */
+
 	if (send_ctx == &_send_ctx) {
 		ret = smb_direct_flush_send_list(sc, send_ctx, true);
 		if (ret)
-			goto err;
+			goto flush_failed;
 	}
 
 	return 0;
 err:
 	smb_direct_free_sendmsg(sc, msg);
+flush_failed:
 header_failed:
 	atomic_inc(&sc->send_io.credits.count);
 credit_failed:
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 65910437be1c..67d4f0924646 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -796,6 +796,23 @@ static inline unsigned huge_page_shift(struct hstate *h)
 	return h->order + PAGE_SHIFT;
 }
 
+/**
+ * hugetlb_linear_page_index() - linear_page_index() but in hugetlb
+ *				 page size granularity.
+ * @vma: the hugetlb VMA
+ * @address: the virtual address within the VMA
+ *
+ * Return: the page offset within the mapping in huge page units.
+ */
+static inline pgoff_t hugetlb_linear_page_index(struct vm_area_struct *vma,
+		unsigned long address)
+{
+	struct hstate *h = hstate_vma(vma);
+
+	return ((address - vma->vm_start) >> huge_page_shift(h)) +
+		(vma->vm_pgoff >> huge_page_order(h));
+}
+
 static inline bool order_is_gigantic(unsigned int order)
 {
 	return order > MAX_PAGE_ORDER;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6b76e7a6f4c2..8c13426f4117 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -318,7 +318,8 @@ static inline bool kvm_vcpu_can_poll(ktime_t cur, ktime_t stop)
 struct kvm_mmio_fragment {
 	gpa_t gpa;
 	void *data;
-	unsigned len;
+	u64 val;
+	unsigned int len;
 };
 
 struct kvm_vcpu {
@@ -1029,6 +1030,13 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 	return NULL;
 }
 
+static inline bool kvm_is_vcpu_creation_in_progress(struct kvm *kvm)
+{
+	lockdep_assert_held(&kvm->lock);
+
+	return kvm->created_vcpus != atomic_read(&kvm->online_vcpus);
+}
+
 void kvm_destroy_vcpus(struct kvm *kvm);
 
 int kvm_trylock_all_vcpus(struct kvm *kvm);
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 4fe63169d5a2..56328601218c 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -331,16 +331,21 @@ static inline size_t probe_subpage_writeable(char __user *uaddr, size_t size)
 
 #endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
 
-#ifndef ARCH_HAS_NOCACHE_UACCESS
+#ifndef ARCH_HAS_NONTEMPORAL_UACCESS
 
 static inline __must_check unsigned long
-__copy_from_user_inatomic_nocache(void *to, const void __user *from,
+copy_from_user_inatomic_nontemporal(void *to, const void __user *from,
 				  unsigned long n)
 {
+	if (can_do_masked_user_access())
+		from = mask_user_address(from);
+	else
+		if (!access_ok(from, n))
+			return n;
 	return __copy_from_user_inatomic(to, from, n);
 }
 
-#endif		/* ARCH_HAS_NOCACHE_UACCESS */
+#endif		/* ARCH_HAS_NONTEMPORAL_UACCESS */
 
 extern __must_check int check_zeroed_user(const void __user *from, size_t size);
 
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 38570998a19b..69379b34bcc9 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -94,6 +94,9 @@ static int __clockevents_switch_state(struct clock_event_device *dev,
 	if (dev->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
 
+	/* On state transitions clear the forced flag unconditionally */
+	dev->next_event_forced = 0;
+
 	/* Transition with new state-specific callbacks */
 	switch (state) {
 	case CLOCK_EVT_STATE_DETACHED:
@@ -332,8 +335,10 @@ int clockevents_program_event(struct clock_event_device *dev, ktime_t expires,
 	if (delta > (int64_t)dev->min_delta_ns) {
 		delta = min(delta, (int64_t) dev->max_delta_ns);
 		clc = ((unsigned long long) delta * dev->mult) >> dev->shift;
-		if (!dev->set_next_event((unsigned long) clc, dev))
+		if (!dev->set_next_event((unsigned long) clc, dev)) {
+			dev->next_event_forced = 0;
 			return 0;
+		}
 	}
 
 	if (dev->next_event_forced)
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 7e57fa31ee26..115e0bf01276 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -108,6 +108,7 @@ static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
 
 static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
 {
+	wd->next_event_forced = 0;
 	/*
 	 * If we woke up early and the tick was reprogrammed in the
 	 * meantime then this may be spurious but harmless.
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 0a63c7fba313..243662af1af7 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -277,7 +277,7 @@ static __always_inline
 size_t copy_from_user_iter_nocache(void __user *iter_from, size_t progress,
 				   size_t len, void *to, void *priv2)
 {
-	return __copy_from_user_inatomic_nocache(to + progress, iter_from, len);
+	return copy_from_user_inatomic_nontemporal(to + progress, iter_from, len);
 }
 
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i)
@@ -296,7 +296,7 @@ static __always_inline
 size_t copy_from_user_iter_flushcache(void __user *iter_from, size_t progress,
 				      size_t len, void *to, void *priv2)
 {
-	return __copy_from_user_flushcache(to + progress, iter_from, len);
+	return copy_from_user_flushcache(to + progress, iter_from, len);
 }
 
 static __always_inline
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7a18fa6c7272..cecbcf9060a6 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -618,12 +618,13 @@ static void cgwb_release_workfn(struct work_struct *work)
 	wb_shutdown(wb);
 
 	css_put(wb->memcg_css);
-	css_put(wb->blkcg_css);
-	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
 	/* triggers blkg destruction if no online users left */
 	blkcg_unpin_online(wb->blkcg_css);
 
+	css_put(wb->blkcg_css);
+	mutex_unlock(&wb->bdi->cgwb_release_mutex);
+
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 
 	spin_lock_irq(&cgwb_lock);
diff --git a/mm/filemap.c b/mm/filemap.c
index 3c1e785542dd..793bf4816ea3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -228,7 +228,8 @@ void __filemap_remove_folio(struct folio *folio, void *shadow)
 	page_cache_delete(mapping, folio, shadow);
 }
 
-void filemap_free_folio(struct address_space *mapping, struct folio *folio)
+static void filemap_free_folio(const struct address_space *mapping,
+		struct folio *folio)
 {
 	void (*free_folio)(struct folio *);
 
diff --git a/mm/internal.h b/mm/internal.h
index cb0af847d7d9..546114d3ee44 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -540,7 +540,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
-void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
 		loff_t end);
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index f084e7a5df1e..9c880f607c6a 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -292,7 +292,7 @@ static void kasan_free_pte(pte_t *pte_start, pmd_t *pmd)
 			return;
 	}
 
-	pte_free_kernel(&init_mm, (pte_t *)page_to_virt(pmd_page(*pmd)));
+	pte_free_kernel(&init_mm, pte_start);
 	pmd_clear(pmd);
 }
 
@@ -307,7 +307,7 @@ static void kasan_free_pmd(pmd_t *pmd_start, pud_t *pud)
 			return;
 	}
 
-	pmd_free(&init_mm, (pmd_t *)page_to_virt(pud_page(*pud)));
+	pmd_free(&init_mm, pmd_start);
 	pud_clear(pud);
 }
 
@@ -322,7 +322,7 @@ static void kasan_free_pud(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
-	pud_free(&init_mm, (pud_t *)page_to_virt(p4d_page(*p4d)));
+	pud_free(&init_mm, pud_start);
 	p4d_clear(p4d);
 }
 
@@ -337,7 +337,7 @@ static void kasan_free_p4d(p4d_t *p4d_start, pgd_t *pgd)
 			return;
 	}
 
-	p4d_free(&init_mm, (p4d_t *)page_to_virt(pgd_page(*pgd)));
+	p4d_free(&init_mm, p4d_start);
 	pgd_clear(pgd);
 }
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 12467c1bd711..8617a12cb169 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -622,6 +622,7 @@ static int folio_launder(struct address_space *mapping, struct folio *folio)
 int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 			   gfp_t gfp)
 {
+	void (*free_folio)(struct folio *);
 	int ret;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -648,9 +649,12 @@ int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
 	xa_unlock_irq(&mapping->i_pages);
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
+	free_folio = mapping->a_ops->free_folio;
 	spin_unlock(&mapping->host->i_lock);
 
-	filemap_free_folio(mapping, folio);
+	if (free_folio)
+		free_folio(folio);
+	folio_put_refs(folio, folio_nr_pages(folio));
 	return 1;
 failed:
 	xa_unlock_irq(&mapping->i_pages);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 927086bb4a3c..5590989e18c7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -573,7 +573,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		 * in the case of shared pmds.  fault mutex prevents
 		 * races with other faulting threads.
 		 */
-		idx = linear_page_index(dst_vma, dst_addr);
+		idx = hugetlb_linear_page_index(dst_vma, dst_addr);
 		mapping = dst_vma->vm_file->f_mapping;
 		hash = hugetlb_fault_mutex_hash(mapping, idx);
 		mutex_lock(&hugetlb_fault_mutex_table[hash]);
diff --git a/net/can/raw.c b/net/can/raw.c
index eee244ffc31e..58a96e933deb 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -361,6 +361,14 @@ static int raw_notifier(struct notifier_block *nb, unsigned long msg,
 	return NOTIFY_DONE;
 }
 
+static void raw_sock_destruct(struct sock *sk)
+{
+	struct raw_sock *ro = raw_sk(sk);
+
+	free_percpu(ro->uniq);
+	can_sock_destruct(sk);
+}
+
 static int raw_init(struct sock *sk)
 {
 	struct raw_sock *ro = raw_sk(sk);
@@ -387,6 +395,8 @@ static int raw_init(struct sock *sk)
 	if (unlikely(!ro->uniq))
 		return -ENOMEM;
 
+	sk->sk_destruct = raw_sock_destruct;
+
 	/* set notifier */
 	spin_lock(&raw_notifier_lock);
 	list_add_tail(&ro->notifier, &raw_notifier_list);
@@ -436,7 +446,6 @@ static int raw_release(struct socket *sock)
 	ro->bound = 0;
 	ro->dev = NULL;
 	ro->count = 0;
-	free_percpu(ro->uniq);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index 63f1b721c71d..ae63c5eb06fa 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -424,6 +424,12 @@ static void digital_in_recv_sdd_res(struct nfc_digital_dev *ddev, void *arg,
 		size = 4;
 	}
 
+	if (target->nfcid1_len + size > NFC_NFCID1_MAXSIZE) {
+		PROTOCOL_ERR("4.7.2.1");
+		rc = -EPROTO;
+		goto exit;
+	}
+
 	memcpy(target->nfcid1 + target->nfcid1_len, sdd_res->nfcid1 + offset,
 	       size);
 	target->nfcid1_len += size;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 366d7566308c..db5bc6a878dd 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1091,6 +1091,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
@@ -1182,6 +1183,7 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	if (sk->sk_state == LLCP_CONNECTED) {
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e56374662ff7..27a43a4d9c43 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -641,6 +641,7 @@ our $signature_tags = qr{(?xi:
 	Reviewed-by:|
 	Reported-by:|
 	Suggested-by:|
+	Assisted-by:|
 	To:|
 	Cc:
 )};
@@ -3105,6 +3106,15 @@ sub process {
 				}
 			}
 
+			# Assisted-by uses AGENT_NAME:MODEL_VERSION format, not email
+			if ($sign_off =~ /^Assisted-by:/i) {
+				if ($email !~ /^\S+:\S+/) {
+					WARN("BAD_SIGN_OFF",
+					     "Assisted-by expects 'AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]' format\n" . $herecurr);
+				}
+				next;
+			}
+
 			my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
 			my $suggested_email = format_email(($email_name, $name_comment, $email_address, $comment));
 			if ($suggested_email eq "") {
diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index d4308b726183..943ff1228b48 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -298,7 +298,7 @@ are loaded as well."""
             if p == "-bpf":
                 monitor_bpf = True
             else:
-                p.append(os.path.abspath(os.path.expanduser(p)))
+                self.module_paths.append(os.path.abspath(os.path.expanduser(p)))
         self.module_paths.append(os.getcwd())
 
         if self.breakpoint is not None:
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index f9b545104f21..bd42f06bb8ed 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -190,9 +190,10 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs, core_edit
 
     def is_root_crate(build_file, target):
         try:
-            return f"{target}.o" in open(build_file).read()
+            contents = build_file.read_text()
         except FileNotFoundError:
             return False
+        return f"{target}.o" in contents
 
     # Then, the rest outside of `rust/`.
     #
diff --git a/sound/firewire/fireworks/fireworks_command.c b/sound/firewire/fireworks/fireworks_command.c
index 2b595ee0bc35..05550f36fac5 100644
--- a/sound/firewire/fireworks/fireworks_command.c
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -151,10 +151,13 @@ efw_transaction(struct snd_efw *efw, unsigned int category,
 	    (be32_to_cpu(header->category) != category) ||
 	    (be32_to_cpu(header->command) != command) ||
 	    (be32_to_cpu(header->status) != EFR_STATUS_OK)) {
+		u32 st = be32_to_cpu(header->status);
+
 		dev_err(&efw->unit->device, "EFW command failed [%u/%u]: %s\n",
 			be32_to_cpu(header->category),
 			be32_to_cpu(header->command),
-			efr_status_names[be32_to_cpu(header->status)]);
+			st < ARRAY_SIZE(efr_status_names) ?
+				efr_status_names[st] : "unknown");
 		err = -EIO;
 		goto end;
 	}
diff --git a/sound/pci/ctxfi/ctvmem.h b/sound/pci/ctxfi/ctvmem.h
index da54cbcdb0be..43a0065b40c3 100644
--- a/sound/pci/ctxfi/ctvmem.h
+++ b/sound/pci/ctxfi/ctvmem.h
@@ -15,7 +15,7 @@
 #ifndef CTVMEM_H
 #define CTVMEM_H
 
-#define CT_PTP_NUM	4	/* num of device page table pages */
+#define CT_PTP_NUM	1	/* num of device page table pages */
 
 #include <linux/mutex.h>
 #include <linux/list.h>
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 970b08c89bb3..069048db5367 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -747,13 +747,22 @@ static int apm_probe(gpr_device_t *gdev)
 
 	q6apm_get_apm_state(apm);
 
-	ret = devm_snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
+	ret = snd_soc_register_component(dev, &q6apm_audio_component, NULL, 0);
 	if (ret < 0) {
 		dev_err(dev, "failed to register q6apm: %d\n", ret);
 		return ret;
 	}
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret)
+		snd_soc_unregister_component(dev);
+
+	return ret;
+}
+
+static void apm_remove(gpr_device_t *gdev)
+{
+	snd_soc_unregister_component(&gdev->dev);
 }
 
 struct audioreach_module *q6apm_find_module_by_mid(struct q6apm_graph *graph, uint32_t mid)
@@ -820,6 +829,7 @@ MODULE_DEVICE_TABLE(of, apm_device_id);
 
 static gpr_driver_t apm_driver = {
 	.probe = apm_probe,
+	.remove = apm_remove,
 	.gpr_callback = apm_callback,
 	.driver = {
 		.name = "qcom-apm",
diff --git a/sound/usb/6fire/chip.c b/sound/usb/6fire/chip.c
index 5ff78814e687..874f6cd503ca 100644
--- a/sound/usb/6fire/chip.c
+++ b/sound/usb/6fire/chip.c
@@ -53,11 +53,6 @@ static void usb6fire_chip_abort(struct sfire_chip *chip)
 			usb6fire_comm_abort(chip);
 		if (chip->control)
 			usb6fire_control_abort(chip);
-		if (chip->card) {
-			snd_card_disconnect(chip->card);
-			snd_card_free_when_closed(chip->card);
-			chip->card = NULL;
-		}
 	}
 }
 
@@ -168,6 +163,7 @@ static int usb6fire_chip_probe(struct usb_interface *intf,
 static void usb6fire_chip_disconnect(struct usb_interface *intf)
 {
 	struct sfire_chip *chip;
+	struct snd_card *card;
 
 	chip = usb_get_intfdata(intf);
 	if (chip) { /* if !chip, fw upload has been performed */
@@ -178,8 +174,19 @@ static void usb6fire_chip_disconnect(struct usb_interface *intf)
 				chips[chip->regidx] = NULL;
 			}
 
+			/*
+			 * Save card pointer before teardown.
+			 * snd_card_free_when_closed() may free card (and
+			 * the embedded chip) immediately, so it must be
+			 * called last and chip must not be accessed after.
+			 */
+			card = chip->card;
 			chip->shutdown = true;
+			if (card)
+				snd_card_disconnect(card);
 			usb6fire_chip_abort(chip);
+			if (card)
+				snd_card_free_when_closed(card);
 		}
 	}
 }
diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 0cf4fa74e210..94553b61013c 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -420,7 +420,11 @@ static int tascam_probe(struct usb_interface *intf,
 
 	/* The device has two interfaces; we drive both from this driver. */
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
-		tascam = usb_get_intfdata(usb_ifnum_to_if(dev, 0));
+		struct usb_interface *intf_zero = usb_ifnum_to_if(dev, 0);
+
+		if (!intf_zero)
+			return -ENODEV;
+		tascam = usb_get_intfdata(intf_zero);
 		if (tascam) {
 			usb_set_intfdata(intf, tascam);
 			tascam->iface1 = intf;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b6765e876507..731fd595ac45 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1301,7 +1301,7 @@ static const char *uaccess_safe_builtin[] = {
 	"copy_mc_enhanced_fast_string",
 	"rep_stos_alternative",
 	"rep_movs_alternative",
-	"__copy_user_nocache",
+	"copy_to_nontemporal",
 	NULL
 };
 
diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
index 0a6dfba3905b..6b0928e69051 100644
--- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
@@ -36,8 +36,6 @@ static struct kvm_vm *sev_vm_create(bool es)
 
 	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
 
-	if (es)
-		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
 	return vm;
 }
 
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index e8328c89d855..788689497e92 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -34,6 +34,7 @@
  */
 #include <lib/test_hmm_uapi.h>
 #include <mm/gup_test.h>
+#include <mm/vm_util.h>
 
 struct hmm_buffer {
 	void		*ptr;
@@ -548,7 +549,7 @@ TEST_F(hmm, anon_write_child)
 
 	for (migrate = 0; migrate < 2; ++migrate) {
 		for (use_thp = 0; use_thp < 2; ++use_thp) {
-			npages = ALIGN(use_thp ? TWOMEG : HMM_BUFFER_SIZE,
+			npages = ALIGN(use_thp ? read_pmd_pagesize() : HMM_BUFFER_SIZE,
 				       self->page_size) >> self->page_shift;
 			ASSERT_NE(npages, 0);
 			size = npages << self->page_shift;
@@ -728,7 +729,7 @@ TEST_F(hmm, anon_write_huge)
 	int *ptr;
 	int ret;
 
-	size = 2 * TWOMEG;
+	size = 2 * read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -744,7 +745,7 @@ TEST_F(hmm, anon_write_huge)
 			   buffer->fd, 0);
 	ASSERT_NE(buffer->ptr, MAP_FAILED);
 
-	size = TWOMEG;
+	size /= 2;
 	npages = size >> self->page_shift;
 	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
 	ret = madvise(map, size, MADV_HUGEPAGE);
@@ -770,54 +771,6 @@ TEST_F(hmm, anon_write_huge)
 	hmm_buffer_free(buffer);
 }
 
-/*
- * Read numeric data from raw and tagged kernel status files.  Used to read
- * /proc and /sys data (without a tag) and from /proc/meminfo (with a tag).
- */
-static long file_read_ulong(char *file, const char *tag)
-{
-	int fd;
-	char buf[2048];
-	int len;
-	char *p, *q;
-	long val;
-
-	fd = open(file, O_RDONLY);
-	if (fd < 0) {
-		/* Error opening the file */
-		return -1;
-	}
-
-	len = read(fd, buf, sizeof(buf));
-	close(fd);
-	if (len < 0) {
-		/* Error in reading the file */
-		return -1;
-	}
-	if (len == sizeof(buf)) {
-		/* Error file is too large */
-		return -1;
-	}
-	buf[len] = '\0';
-
-	/* Search for a tag if provided */
-	if (tag) {
-		p = strstr(buf, tag);
-		if (!p)
-			return -1; /* looks like the line we want isn't there */
-		p += strlen(tag);
-	} else
-		p = buf;
-
-	val = strtol(p, &q, 0);
-	if (*q != ' ') {
-		/* Error parsing the file */
-		return -1;
-	}
-
-	return val;
-}
-
 /*
  * Write huge TLBFS page.
  */
@@ -826,15 +779,13 @@ TEST_F(hmm, anon_write_hugetlbfs)
 	struct hmm_buffer *buffer;
 	unsigned long npages;
 	unsigned long size;
-	unsigned long default_hsize;
+	unsigned long default_hsize = default_huge_page_size();
 	unsigned long i;
 	int *ptr;
 	int ret;
 
-	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
-	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
+	if (!default_hsize)
 		SKIP(return, "Huge page size could not be determined");
-	default_hsize = default_hsize*1024; /* KB to B */
 
 	size = ALIGN(TWOMEG, default_hsize);
 	npages = size >> self->page_shift;
@@ -1606,7 +1557,7 @@ TEST_F(hmm, compound)
 	struct hmm_buffer *buffer;
 	unsigned long npages;
 	unsigned long size;
-	unsigned long default_hsize;
+	unsigned long default_hsize = default_huge_page_size();
 	int *ptr;
 	unsigned char *m;
 	int ret;
@@ -1614,10 +1565,8 @@ TEST_F(hmm, compound)
 
 	/* Skip test if we can't allocate a hugetlbfs page. */
 
-	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
-	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
+	if (!default_hsize)
 		SKIP(return, "Huge page size could not be determined");
-	default_hsize = default_hsize*1024; /* KB to B */
 
 	size = ALIGN(TWOMEG, default_hsize);
 	npages = size >> self->page_shift;
@@ -2106,7 +2055,7 @@ TEST_F(hmm, migrate_anon_huge_empty)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2158,7 +2107,7 @@ TEST_F(hmm, migrate_anon_huge_zero)
 	int ret;
 	int val;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2221,7 +2170,7 @@ TEST_F(hmm, migrate_anon_huge_free)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2280,7 +2229,7 @@ TEST_F(hmm, migrate_anon_huge_fault)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2332,7 +2281,7 @@ TEST_F(hmm, migrate_partial_unmap_fault)
 {
 	struct hmm_buffer *buffer;
 	unsigned long npages;
-	unsigned long size = TWOMEG;
+	unsigned long size = read_pmd_pagesize();
 	unsigned long i;
 	void *old_ptr;
 	void *map;
@@ -2398,7 +2347,7 @@ TEST_F(hmm, migrate_remap_fault)
 {
 	struct hmm_buffer *buffer;
 	unsigned long npages;
-	unsigned long size = TWOMEG;
+	unsigned long size = read_pmd_pagesize();
 	unsigned long i;
 	void *old_ptr, *new_ptr = NULL;
 	void *map;
@@ -2498,7 +2447,7 @@ TEST_F(hmm, migrate_anon_huge_err)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);
@@ -2593,7 +2542,7 @@ TEST_F(hmm, migrate_anon_huge_zero_err)
 	int *ptr;
 	int ret;
 
-	size = TWOMEG;
+	size = read_pmd_pagesize();
 
 	buffer = malloc(sizeof(*buffer));
 	ASSERT_NE(buffer, NULL);

