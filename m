Return-Path: <stable+bounces-64666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0027942144
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 22:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F46286A05
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335618C923;
	Tue, 30 Jul 2024 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeB8F3UA"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036901AA3C1
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369833; cv=none; b=MN93rvRQlHdg27rjp8L3GjZzT+CJLNdEdWfN6O0WzMHWZF9QwXfPG2ikacBvctDiQtZYizhso9wfhqRW0Efbq7fDsTK0EW2YZ0X6v5RBe6FaCWLVOxEKywo6s0F4tW25/McNfeUUVqafmfQWHqECB9uGuVJRnX0Oiu1f0MY5e20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369833; c=relaxed/simple;
	bh=Yi6MtglJfFTX0vys+U6z6d8VAtHQmCP2PVigIZRM9oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=em3OB5TKeO63SEYaEbmeWKPwPR18aVDH9TiA9SrJHcpoqE7OvgSwObejmwfpUEX3gz65n1y6o0DKzV9Yw87p8EewOl5We5ABbMhEih8ei1fk0t5RrZFok2wMR+5JkkzX0jIQPV7h1ThJlN29GcHCuvZ+6DPxfHMT9Ym0vrrSVQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NeB8F3UA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722369831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/gxfuKJD8hnhbSrwyVXjwcDnAiiLt3on755V01mHK1c=;
	b=NeB8F3UAHGOcUwRPPzGhiJ3D3HAEIxF5Oz/LfPO9J99hWFNAYUv17K/qCmIaR77cg9HPsG
	2Tfr7oFZNnpC1xL4XJzoEROpCK1zKOScHpw70d7B2RSrCkAidPisBx5NZwxBZvfvQCZCzB
	iyCVrcuOs/xZya0gxGXHoVaF9MG+uLM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-FOQSop7AOc-pGjbXLkFAxw-1; Tue,
 30 Jul 2024 16:03:48 -0400
X-MC-Unique: FOQSop7AOc-pGjbXLkFAxw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DB0C1955D4A;
	Tue, 30 Jul 2024 20:03:47 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87FF41955F3B;
	Tue, 30 Jul 2024 20:03:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	stable@vger.kernel.org,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: [PATCH v2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Date: Tue, 30 Jul 2024 22:03:41 +0200
Message-ID: <20240730200341.1642904-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We recently made GUP's common page table walking code to also walk hugetlb
VMAs without most hugetlb special-casing, preparing for the future of
having less hugetlb-specific page table walking code in the codebase.
Turns out that we missed one page table locking detail: page table locking
for hugetlb folios that are not mapped using a single PMD/PUD.

Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
page tables, will perform a pte_offset_map_lock() to grab the PTE table
lock.

However, hugetlb that concurrently modifies these page tables would
actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
locks would differ. Something similar can happen right now with hugetlb
folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.

This issue can be reproduced [1], for example triggering:

[ 3105.936100] ------------[ cut here ]------------
[ 3105.939323] WARNING: CPU: 31 PID: 2732 at mm/gup.c:142 try_grab_folio+0x11c/0x188
[ 3105.944634] Modules linked in: [...]
[ 3105.974841] CPU: 31 PID: 2732 Comm: reproducer Not tainted 6.10.0-64.eln141.aarch64 #1
[ 3105.980406] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-4.fc40 05/24/2024
[ 3105.986185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 3105.991108] pc : try_grab_folio+0x11c/0x188
[ 3105.994013] lr : follow_page_pte+0xd8/0x430
[ 3105.996986] sp : ffff80008eafb8f0
[ 3105.999346] x29: ffff80008eafb900 x28: ffffffe8d481f380 x27: 00f80001207cff43
[ 3106.004414] x26: 0000000000000001 x25: 0000000000000000 x24: ffff80008eafba48
[ 3106.009520] x23: 0000ffff9372f000 x22: ffff7a54459e2000 x21: ffff7a546c1aa978
[ 3106.014529] x20: ffffffe8d481f3c0 x19: 0000000000610041 x18: 0000000000000001
[ 3106.019506] x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000000
[ 3106.024494] x14: ffffb85477fdfe08 x13: 0000ffff9372ffff x12: 0000000000000000
[ 3106.029469] x11: 1fffef4a88a96be1 x10: ffff7a54454b5f0c x9 : ffffb854771b12f0
[ 3106.034324] x8 : 0008000000000000 x7 : ffff7a546c1aa980 x6 : 0008000000000080
[ 3106.038902] x5 : 00000000001207cf x4 : 0000ffff9372f000 x3 : ffffffe8d481f000
[ 3106.043420] x2 : 0000000000610041 x1 : 0000000000000001 x0 : 0000000000000000
[ 3106.047957] Call trace:
[ 3106.049522]  try_grab_folio+0x11c/0x188
[ 3106.051996]  follow_pmd_mask.constprop.0.isra.0+0x150/0x2e0
[ 3106.055527]  follow_page_mask+0x1a0/0x2b8
[ 3106.058118]  __get_user_pages+0xf0/0x348
[ 3106.060647]  faultin_page_range+0xb0/0x360
[ 3106.063651]  do_madvise+0x340/0x598

Let's make huge_pte_lockptr() effectively uses the same PT locks as any
core-mm page table walker would. Add ptep_lockptr() to obtain the PTE
page table lock using a pte pointer -- unfortunately we cannot convert
pte_lockptr() because virt_to_page() doesn't work with kmap'ed page
tables we can have with CONFIG_HIGHPTE.

There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
folio being mapped using two PTE page tables.  While hugetlb wants to take
the PMD table lock, core-mm would grab the PTE table lock of one of both
PTE page tables.  In such corner cases, we have to make sure that both
locks match, which is (fortunately!) currently guaranteed for 8xx as it
does not support SMP and consequently doesn't use split PT locks.

[1] https://lore.kernel.org/all/1bbfcc7f-f222-45a5-ac44-c5a1381c596d@redhat.com/

Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
Cc: <stable@vger.kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Still busy runtime-testing of this version -- have to set up my ARM
environment again. Dropped the RB's/ACKs because there was significant
change in the pte_lockptr() handling.

v1 -> 2:
* Extend patch description
* Drop "mm: let pte_lockptr() consume a pte_t pointer"
* Introduce ptep_lockptr() in this patch

I wish there was a nicer way to avoid messing with CONFIG_HIGHPTE ...

---
 include/linux/hugetlb.h | 26 +++++++++++++++++++++++---
 include/linux/mm.h      | 10 ++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c9bf68c239a01..dd6d4ee5ee59c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -944,10 +944,30 @@ static inline bool htlb_allow_alloc_fallback(int reason)
 static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 					   struct mm_struct *mm, pte_t *pte)
 {
-	if (huge_page_size(h) == PMD_SIZE)
+	VM_WARN_ON(huge_page_size(h) == PAGE_SIZE);
+	VM_WARN_ON(huge_page_size(h) >= P4D_SIZE);
+
+	/*
+	 * hugetlb must use the exact same PT locks as core-mm page table
+	 * walkers would. When modifying a PTE table, hugetlb must take the
+	 * PTE PT lock, when modifying a PMD table, hugetlb must take the PMD
+	 * PT lock etc.
+	 *
+	 * The expectation is that any hugetlb folio smaller than a PMD is
+	 * always mapped into a single PTE table and that any hugetlb folio
+	 * smaller than a PUD (but at least as big as a PMD) is always mapped
+	 * into a single PMD table.
+	 *
+	 * If that does not hold for an architecture, then that architecture
+	 * must disable split PT locks such that all *_lockptr() functions
+	 * will give us the same result: the per-MM PT lock.
+	 */
+	if (huge_page_size(h) < PMD_SIZE && !IS_ENABLED(CONFIG_HIGHPTE))
+		/* pte_alloc_huge() only applies with !CONFIG_HIGHPTE */
+		return ptep_lockptr(mm, pte);
+	else if (huge_page_size(h) < PUD_SIZE)
 		return pmd_lockptr(mm, (pmd_t *) pte);
-	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
-	return &mm->page_table_lock;
+	return pud_lockptr(mm, (pud_t *) pte);
 }
 
 #ifndef hugepages_supported
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b100df8cb5857..1b1f40ff00b7d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2926,6 +2926,12 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
 }
 
+static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
+{
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
+	return ptlock_ptr(virt_to_ptdesc(pte));
+}
+
 static inline bool ptlock_init(struct ptdesc *ptdesc)
 {
 	/*
@@ -2950,6 +2956,10 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
 	return &mm->page_table_lock;
 }
+static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
+{
+	return &mm->page_table_lock;
+}
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void ptlock_free(struct ptdesc *ptdesc) {}
-- 
2.45.2


