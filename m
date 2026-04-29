Return-Path: <stable+bounces-241874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP4vJB/y8WmElwEAu9opvQ
	(envelope-from <stable+bounces-241874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:57:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB0493C82
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88BB6305C49F
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2513A1A21;
	Wed, 29 Apr 2026 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CIyg/cMq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188273E8C49;
	Wed, 29 Apr 2026 11:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463695; cv=none; b=TONuP6+QqEEQP0a0DlVu7nbe55+esAk3KFSVyL+u1k3H5MI+MqEVJORyL6LxR1mfKoEjPQ/Qspqy33Uhu6tA6BvHx371Pk0r6q4IYjoUsixURLlQ8HkjW7IwbwtBcuBdnQzeo9DHPyZbnnyMe18mpdPCRVCJoXoM5xa0NG9Y42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463695; c=relaxed/simple;
	bh=FdZn2aKtKAfbY3SHzbUAI2dxsrv/92v7leXVaVUavoc=;
	h=Date:To:From:Subject:Message-Id; b=PF+bjoG9k2kftv0qfKPQYxZqtX2n3eXHTeHd+Y9q6YZcADv5i8m7ldTrlytvDLpFQLkQok3TO3a857MON7R/1xsJazKcC5b+JwGiiua0uThX6TQR/sWbwM+VOOsPk2gxK/8Ybn1Vtw0ASrKA2JqYjDrbU5AT35Q+9ZHucqAgN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CIyg/cMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F26AC19425;
	Wed, 29 Apr 2026 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777463694;
	bh=FdZn2aKtKAfbY3SHzbUAI2dxsrv/92v7leXVaVUavoc=;
	h=Date:To:From:Subject:From;
	b=CIyg/cMqPMd8QePSJMPAwuhKCNk8z78Yl5uIiruoSVX89OjhDEy9L6HzbzSDfHW6C
	 bqc0RRhnY5PvW9oml94paQ238yuQphOHtty6JFxK8TA+yIYn9SHlsiSpcDJEETc79Y
	 VQfDYfJGb9p50dXjVInv6wUYM7R4JGlqdOfkMcK0=
Date: Wed, 29 Apr 2026 04:54:54 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,rppt@kernel.org,peterz@infradead.org,mingo@redhat.com,luto@kernel.org,lance.yang@linux.dev,jgg@ziepe.ca,hpa@zytor.com,bp@alien8.de,baolu.lu@linux.intel.com,david@kernel.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + x86-mm-fix-freeing-of-pmd-sized-vmemmap-pages.patch added to mm-hotfixes-unstable branch
Message-Id: <20260429115454.9F26AC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 10DB0493C82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241874-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch titled
     Subject: x86/mm: fix freeing of PMD-sized vmemmap pages
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     x86-mm-fix-freeing-of-pmd-sized-vmemmap-pages.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/x86-mm-fix-freeing-of-pmd-sized-vmemmap-pages.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: x86/mm: fix freeing of PMD-sized vmemmap pages
Date: Wed, 29 Apr 2026 12:49:14 +0200

In commit bf9e4e30f353 ("x86/mm: use pagetable_free()"), we switched from
freeing non-boot page tables through __free_pages() to pagetable_free().

However, the function is also called to free vmemmap pages.

Given that vmemmap pages are not page tables, already the
page_ptdesc(page) is wrong.  But worse, pagetable_free() calls

	__free_pages(page, compound_order(page));

As vmemmap pages are not compound pages (see vmemmap_alloc_block()) --
except for HVO, which doesn't apply here -- we will only free the first
page when freeing a PMD-sized vmemmap page, leaking the other ones.

Fix it by properly decoupling pagetable and vmemmap freeing. 
free_pagetable() no longer has to mess with SECTION_INFO, as only the
vmemmap is marked like that in register_page_bootmem_memmap().

The indentation in remove_pmd_table() is messed up, let's fix that while
touching it.

Note that we'll try to get rid of that bootmem info handling soon.  For
now, we'll handle it similar to free_pagetable(), just avoiding the ifdef.

Link: https://lore.kernel.org/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org
Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Tested-by: Lance Yang <lance.yang@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/mm/init_64.c |   40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

--- a/arch/x86/mm/init_64.c~x86-mm-fix-freeing-of-pmd-sized-vmemmap-pages
+++ a/arch/x86/mm/init_64.c
@@ -1014,7 +1014,7 @@ static void __meminit free_pagetable(str
 #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
 		enum bootmem_type type = bootmem_type(page);
 
-		if (type == SECTION_INFO || type == MIX_SECTION_INFO) {
+		if (type == MIX_SECTION_INFO) {
 			while (nr_pages--)
 				put_page_bootmem(page++);
 		} else {
@@ -1028,13 +1028,24 @@ static void __meminit free_pagetable(str
 	}
 }
 
-static void __meminit free_hugepage_table(struct page *page,
+static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
 		struct vmem_altmap *altmap)
 {
-	if (altmap)
-		vmem_altmap_free(altmap, PMD_SIZE / PAGE_SIZE);
-	else
-		free_pagetable(page, get_order(PMD_SIZE));
+	unsigned long nr_pages = 1u << order;
+
+	if (altmap) {
+		vmem_altmap_free(altmap, nr_pages);
+	} else if (PageReserved(page)) {
+		if (IS_ENABLED(CONFIG_HAVE_BOOTMEM_INFO_NODE) &&
+		    bootmem_type(page) == SECTION_INFO) {
+			while (nr_pages--)
+				put_page_bootmem(page++);
+		} else {
+			free_reserved_pages(page, nr_pages);
+		}
+	} else {
+		__free_pages(page, order);
+	}
 }
 
 static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
@@ -1118,7 +1129,8 @@ remove_pte_table(pte_t *pte_start, unsig
 			return;
 
 		if (!direct)
-			free_pagetable(pte_page(*pte), 0);
+			/* We never populate base pages from the altmap. */
+			free_vmemmap_pages(pte_page(*pte), 0, NULL);
 
 		spin_lock(&init_mm.page_table_lock);
 		pte_clear(&init_mm, addr, pte);
@@ -1153,19 +1165,19 @@ remove_pmd_table(pmd_t *pmd_start, unsig
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE)) {
 				if (!direct)
-					free_hugepage_table(pmd_page(*pmd),
-							    altmap);
+					free_vmemmap_pages(pmd_page(*pmd),
+							   PMD_ORDER, altmap);
 
 				spin_lock(&init_mm.page_table_lock);
 				pmd_clear(pmd);
 				spin_unlock(&init_mm.page_table_lock);
 				pages++;
 			} else if (vmemmap_pmd_is_unused(addr, next)) {
-					free_hugepage_table(pmd_page(*pmd),
-							    altmap);
-					spin_lock(&init_mm.page_table_lock);
-					pmd_clear(pmd);
-					spin_unlock(&init_mm.page_table_lock);
+				free_vmemmap_pages(pmd_page(*pmd), PMD_ORDER,
+						   altmap);
+				spin_lock(&init_mm.page_table_lock);
+				pmd_clear(pmd);
+				spin_unlock(&init_mm.page_table_lock);
 			}
 			continue;
 		}
_

Patches currently in -mm which might be from david@kernel.org are

mm-page_alloc-fix-initialization-of-tags-of-the-huge-zero-folio-with-init_on_free.patch
x86-mm-fix-freeing-of-pmd-sized-vmemmap-pages.patch
sh-use-folio_mapped-instead-of-page_mapped-in-sh4_flush_cache_page.patch
bpf-arena-use-page_ref_count-instead-of-page_mapped-in-arena_free_pages.patch
mm-remove-page_mapped.patch


