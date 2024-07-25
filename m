Return-Path: <stable+bounces-61786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA2993C872
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 20:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9864A1F21ABC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07841770E2;
	Thu, 25 Jul 2024 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5Uyqllc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08C76036
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932814; cv=none; b=b9keFrjRhuI6rNfE5lZICHiWcWDvvM0V+J90V9NMvRW1ATCUy25XhZQX4cLvrwHQsKhuBU6AYPXRUvpzXK9J3y99M9uSz1+T3j8XsS1d+fZRH/vFBxW/lzYfkpd02JTbdMTrRVln9B56jhgQvTFN52kO34lB9S0vtW0SoKvYIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932814; c=relaxed/simple;
	bh=Pzr0Lnb/iiSYZSUYC2A4aMRyI4aM5W7rhKE1A2lGBzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDGHb9S7EkZ8xIiianQYZJGJ0roN1gmgHMDmHZrcxLSvLibyrNeOQTvSxV96Wpm+FyqBBjUdR1daa4PgYZY/HT6xrxFngEkn2j3w9Q4OLH4B0r41VXGEVsGBepW0udgy2xDRGda04cIhVEGAR03/RitMZpnqTKsnyJVq8Zr6qNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5Uyqllc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721932812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=825KmH6PFbzryItWTiXJBmfjya/+p9AIE9EWqywGW+c=;
	b=N5UyqllcEKBKb51EAUWoZnN3KR7C6qdVcz6JvKj5W9QfZflONX1yvDDvVopnrtlA8tlS8D
	spmX2bcxbIy0ws79L7MtDwMsRJcFBLYameW8pMRKXGTe1PbmUDJl1tveF0vNsTFGeb1CkW
	s7L/C5ua+XOTnExHAhGeMBY6jC8Uj58=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-s1hCBgoxNB6O3FQHM27urw-1; Thu,
 25 Jul 2024 14:40:08 -0400
X-MC-Unique: s1hCBgoxNB6O3FQHM27urw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB20F1955D4B;
	Thu, 25 Jul 2024 18:40:06 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE23F1955D42;
	Thu, 25 Jul 2024 18:40:03 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
Date: Thu, 25 Jul 2024 20:39:55 +0200
Message-ID: <20240725183955.2268884-3-david@redhat.com>
In-Reply-To: <20240725183955.2268884-1-david@redhat.com>
References: <20240725183955.2268884-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

We recently made GUP's common page table walking code to also walk
hugetlb VMAs without most hugetlb special-casing, preparing for the
future of having less hugetlb-specific page table walking code in the
codebase. Turns out that we missed one page table locking detail: page
table locking for hugetlb folios that are not mapped using a single
PMD/PUD.

Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
page tables, will perform a pte_offset_map_lock() to grab the PTE table
lock.

However, hugetlb that concurrently modifies these page tables would
actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
locks would differ. Something similar can happen right now with hugetlb
folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.

Let's make huge_pte_lockptr() effectively uses the same PT locks as any
core-mm page table walker would.

There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
folio being mapped using two PTE page tables. While hugetlb wants to take
the PMD table lock, core-mm would grab the PTE table lock of one of both
PTE page tables. In such corner cases, we have to make sure that both
locks match, which is (fortunately!) currently guaranteed for 8xx as it
does not support SMP.

Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/hugetlb.h | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c9bf68c239a01..da800e56fe590 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -944,10 +944,29 @@ static inline bool htlb_allow_alloc_fallback(int reason)
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
+	if (huge_page_size(h) < PMD_SIZE)
+		return pte_lockptr(mm, pte);
+	else if (huge_page_size(h) < PUD_SIZE)
 		return pmd_lockptr(mm, (pmd_t *) pte);
-	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
-	return &mm->page_table_lock;
+	return pud_lockptr(mm, (pud_t *) pte);
 }
 
 #ifndef hugepages_supported
-- 
2.45.2


