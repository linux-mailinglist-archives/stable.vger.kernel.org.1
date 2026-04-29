Return-Path: <stable+bounces-241803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGVEOmVu8WkIgwEAu9opvQ
	(envelope-from <stable+bounces-241803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:35:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583F48E5BC
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E340301A980
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 02:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC738236B;
	Wed, 29 Apr 2026 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="REKOUE9E"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2973603DF
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429832; cv=none; b=sl57l2ZUy6L5GC4TwjKb/wvjeDWBDAe/NE/RFekSQIvERBKzfug6wQF1pG8pxZVNoB6TE3AEyZC+FAQMZZBSu3scQaS1zUCR4UDeJcLBPd2kEFQ49T37TPm8ZgcpOHh7jgJp88+gAtJM+rF0eeegnpznExW0t9NkbabfFCChmV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429832; c=relaxed/simple;
	bh=Rk28/oAVOGSphzuQH/rLpJJfl/q7GoYZWz06DK0WnSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7eYyR9NWN6Xj6orqnSHXm9xER2AY1+NXixfhAuonWSSObSfNxH8ykhMe1NjQxb0PEMFhmacC7Nr2CELUZw9rF9Fb5O5QhLGrQHAmyAmdrGz5ZbeCR30rbr0oxU4Is/sb4uZ6FCa1ELEOA9quxIa387hrbObcUgihsnPrOfbbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=REKOUE9E; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777429828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWZbALr0HrmNzgjYbWhwVubSzNlQAWhMuIrGVyyObI4=;
	b=REKOUE9Et33cUnFrVRGJb+pgigmxP0NXNeSwlsNnbMPEvV6Rmc+K3EFV3uRu40p1SlfyWr
	ZaTkwkajaXWhwKm3W+31KKI86oCsxH9QvCRd6u7mc1enKJJErIY2BWEn/gJZCRChIlcApj
	VOl/40KvzGVSnzeGMwaN+yCewfVCkxM=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	rppt@kernel.org,
	jgg@ziepe.ca,
	baolu.lu@linux.intel.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] x86/mm: fix freeing of PMD-sized vmemmap pages
Date: Wed, 29 Apr 2026 10:30:08 +0800
Message-Id: <20260429023008.61378-1-lance.yang@linux.dev>
In-Reply-To: <20260429021224.39916-1-lance.yang@linux.dev>
References: <20260429021224.39916-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 1583F48E5BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241803-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


On Wed, Apr 29, 2026 at 10:12:24AM +0800, Lance Yang wrote:
>
>On Tue, Apr 28, 2026 at 12:29:36PM +0200, David Hildenbrand (Arm) wrote:
>>In commit bf9e4e30f353 ("x86/mm: use pagetable_free()"), we switched
>>from freeing non-boot page tables through __free_pages() to
>>pagetable_free().
>>
>>However, the function is also called to free vmemmap pages.
>>
>>Given that vmemmap pages are not page tables, already the page_ptdesc(page)
>>is wrong. But worse, pagetable_free() calls
>>
>>	__free_pages(page, compound_order(page));
>>
>>As vmemmap pages are not compound pages (see vmemmap_alloc_block()) --
>>except for HVO, which doesn't apply here -- we will only free the first
>>page when freeing a PMD-sized vmemmap page, leaking the other ones.
>>
>>Fix it by properly decoupling pagetable and vmemmap freeing.
>>free_pagetable() no longer has to mess with SECTION_INFO, as only the
>>vmemmap is marked like that in register_page_bootmem_memmap().
>>
>>While at it, just wire up the altmap parameter for remove_pte_table().
>>Also, the indentation in remove_pmd_table() is messed up, let's fix that
>>while touching it.
>
>One thing I'm not sure about is passing altmap down into
>remove_pte_table().
>
>Do we actually know that a non-NULL altmap means that the vmemmap
>backing page came from that altmap?
>
>On x86 we still have in vmemmap_populate():
>
>	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
>		err = vmemmap_populate_basepages(start, end, node, NULL);
>
>So for smaller-than-section vmemmap ranges, even if the caller has an
>altmap, the backing pages are allocated from normal memory. But with
>this fix the PTE removal path would now call vmem_altmap_free() just
>because altmap is non-NULL, and would not free the actual backing page,
>IIUC :)
>
>Maybe free_vmemmap_pages() should first check that the backing page is
>really inside the altmap range before using vmem_altmap_free()?
>
>Hopefully I didn't miss anything :)

I played a bit with the following on top of this fix (untested):

---8<---
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8d03e44a7fb9..9a52f9424a07 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1028,14 +1028,33 @@ static void __meminit free_pagetable(struct page *page, int order)
 	}
 }

+static bool __meminit vmemmap_page_is_altmap(struct page *page,
+		unsigned long nr_pages, struct vmem_altmap *altmap)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+
+	if (!altmap)
+		return false;
+
+	start_pfn = altmap->base_pfn + altmap->reserve;
+	end_pfn = altmap->base_pfn + vmem_altmap_offset(altmap);
+
+	if (pfn < start_pfn || pfn >= end_pfn)
+		return false;
+
+	return nr_pages <= end_pfn - pfn;
+}
+
 static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
 		struct vmem_altmap *altmap)
 {
-	if (altmap) {
-		vmem_altmap_free(altmap, 1u << order);
-	} else if (PageReserved(page)) {
-		unsigned long nr_pages = 1 << order;
+	unsigned long nr_pages = 1 << order;

+	if (vmemmap_page_is_altmap(page, nr_pages, altmap)) {
+		vmem_altmap_free(altmap, nr_pages);
+	} else if (PageReserved(page)) {
 		if (IS_ENABLED(CONFIG_HAVE_BOOTMEM_INFO_NODE) &&
 		    bootmem_type(page) == SECTION_INFO) {
 			while (nr_pages--)
--

Thanks,
Lance

>Thanks,
>Lance
>
>>Note that we'll try to get rid of that bootmem info handling soon. For
>>now, we'll handle it similar to free_pagetable(), just avoiding the
>>ifdef.
>>
>>Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
>>Cc: stable@vger.kernel.org
>>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>---
>>Reproduced and tested with a simple VM with a virtio-mem device,
>>repeatedly adding and removing memory.
>>
>>Found by code inspection while working on bootmem_info removal.
>>---
>> arch/x86/mm/init_64.c | 43 +++++++++++++++++++++++++++----------------
>> 1 file changed, 27 insertions(+), 16 deletions(-)
>>
>>diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>index df2261fa4f98..8d03e44a7fb9 100644
>>--- a/arch/x86/mm/init_64.c
>>+++ b/arch/x86/mm/init_64.c
>>@@ -1014,7 +1014,7 @@ static void __meminit free_pagetable(struct page *page, int order)
>> #ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
>> 		enum bootmem_type type = bootmem_type(page);
>> 
>>-		if (type == SECTION_INFO || type == MIX_SECTION_INFO) {
>>+		if (type == MIX_SECTION_INFO) {
>> 			while (nr_pages--)
>> 				put_page_bootmem(page++);
>> 		} else {
>>@@ -1028,13 +1028,24 @@ static void __meminit free_pagetable(struct page *page, int order)
>> 	}
>> }
>> 
>>-static void __meminit free_hugepage_table(struct page *page,
>>+static void __meminit free_vmemmap_pages(struct page *page, unsigned int order,
>> 		struct vmem_altmap *altmap)
>> {
>>-	if (altmap)
>>-		vmem_altmap_free(altmap, PMD_SIZE / PAGE_SIZE);
>>-	else
>>-		free_pagetable(page, get_order(PMD_SIZE));
>>+	if (altmap) {
>>+		vmem_altmap_free(altmap, 1u << order);
>>+	} else if (PageReserved(page)) {
>>+		unsigned long nr_pages = 1 << order;
>>+
>>+		if (IS_ENABLED(CONFIG_HAVE_BOOTMEM_INFO_NODE) &&
>>+		    bootmem_type(page) == SECTION_INFO) {
>>+			while (nr_pages--)
>>+				put_page_bootmem(page++);
>>+		} else {
>>+			free_reserved_pages(page, nr_pages);
>>+		}
>>+	} else {
>>+		__free_pages(page, order);
>>+	}
>> }
>> 
>> static void __meminit free_pte_table(pte_t *pte_start, pmd_t *pmd)
>>@@ -1093,7 +1104,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
>> 
>> static void __meminit
>> remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
>>-		 bool direct)
>>+		 bool direct, struct vmem_altmap *altmap)
>> {
>> 	unsigned long next, pages = 0;
>> 	pte_t *pte;
>>@@ -1118,7 +1129,7 @@ remove_pte_table(pte_t *pte_start, unsigned long addr, unsigned long end,
>> 			return;
>> 
>> 		if (!direct)
>>-			free_pagetable(pte_page(*pte), 0);
>>+			free_vmemmap_pages(pte_page(*pte), 0, altmap);
>> 
>> 		spin_lock(&init_mm.page_table_lock);
>> 		pte_clear(&init_mm, addr, pte);
>>@@ -1153,25 +1164,25 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>> 			if (IS_ALIGNED(addr, PMD_SIZE) &&
>> 			    IS_ALIGNED(next, PMD_SIZE)) {
>> 				if (!direct)
>>-					free_hugepage_table(pmd_page(*pmd),
>>-							    altmap);
>>+					free_vmemmap_pages(pmd_page(*pmd),
>>+							   PMD_ORDER, altmap);
>> 
>> 				spin_lock(&init_mm.page_table_lock);
>> 				pmd_clear(pmd);
>> 				spin_unlock(&init_mm.page_table_lock);
>> 				pages++;
>> 			} else if (vmemmap_pmd_is_unused(addr, next)) {
>>-					free_hugepage_table(pmd_page(*pmd),
>>-							    altmap);
>>-					spin_lock(&init_mm.page_table_lock);
>>-					pmd_clear(pmd);
>>-					spin_unlock(&init_mm.page_table_lock);
>>+				free_vmemmap_pages(pmd_page(*pmd), PMD_ORDER,
>>+						   altmap);
>>+				spin_lock(&init_mm.page_table_lock);
>>+				pmd_clear(pmd);
>>+				spin_unlock(&init_mm.page_table_lock);
>> 			}
>> 			continue;
>> 		}
>> 
>> 		pte_base = (pte_t *)pmd_page_vaddr(*pmd);
>>-		remove_pte_table(pte_base, addr, next, direct);
>>+		remove_pte_table(pte_base, addr, next, direct, altmap);
>> 		free_pte_table(pte_base, pmd);
>> 	}
>> 
>>
>>---
>>
>>base-commit: a2ddbfd1af0f54ea84bf17f0400088815d012e8d
>>
>>change-id: 20260428-vmemmap-ab4b949aa727
>>
>>--
>>
>>Cheers,
>>
>>David
>>
>>
>

