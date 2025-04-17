Return-Path: <stable+bounces-133996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA5A928DA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110994A3750
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EBB263C78;
	Thu, 17 Apr 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lJo9f0hT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9542571A2;
	Thu, 17 Apr 2025 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914779; cv=none; b=sW3Zx9dVC4Q9gq31xpjUv6e9friMCM0zBVyRoPm6N6EthRFm4DaWAIOr6NJSEfKnySm+POoaHtWT+6V48P8qrMOIjFvsduiAmCQyT7ufITzfEWKK4Q26AAIK7AeQ/1gE55q80s09n/QnotRZGDl7UjqqTtmTTRYb/mJ6NcsOZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914779; c=relaxed/simple;
	bh=G9PB5d/FD2t3H2hIS13UsesXoO6YJq/RFaJN5lXh2es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVC5F/B8TkTZJwMgPBVYrj5+jXIfyL75XPz8DTEDZrL5SlpVc2zph2Cur9ESewcSLI3POD6f8P3XbITr9iRmwdxbSDBflE/xnO6ttjeQFqV5DB2WRMSipG+3h698t74pxbI7NL1kJmSbXs+XmPd0BjwG+oqVVH90sX+RcqZ3fiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lJo9f0hT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D6CC4CEE4;
	Thu, 17 Apr 2025 18:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914779;
	bh=G9PB5d/FD2t3H2hIS13UsesXoO6YJq/RFaJN5lXh2es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJo9f0hTwJyZ/gWHikfoaBOPYpxeP4lVWoQjWbZfW88TXK9v8zM0SNkE5OvZkx9T7
	 HPHFcS4UIhzxSwP7Tz1DJTaJ6Wo5dsugCYq1R0GHEEUdzCeaYbHMV2ysswSUwsjcFK
	 WoiH329PBT2JkqtWs9K8G8Gy9tEjq5J1HfGOg8FE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jane Chu <jane.chu@oracle.com>,
	Hugh Dickins <hughd@google.com>,
	"Kirill A. Shuemov" <kirill.shutemov@linux.intel.com>,
	linmiaohe <linmiaohe@huawei.com>,
	"Matthew Wilcow (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.13 327/414] mm: make page_mapped_in_vma() hugetlb walk aware
Date: Thu, 17 Apr 2025 19:51:25 +0200
Message-ID: <20250417175124.585701477@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jane Chu <jane.chu@oracle.com>

commit 442b1eca223b4860cc85ef970ae602d125aec5a4 upstream.

When a process consumes a UE in a page, the memory failure handler
attempts to collect information for a potential SIGBUS.  If the page is an
anonymous page, page_mapped_in_vma(page, vma) is invoked in order to

  1. retrieve the vaddr from the process' address space,

  2. verify that the vaddr is indeed mapped to the poisoned page,
     where 'page' is the precise small page with UE.

It's been observed that when injecting poison to a non-head subpage of an
anonymous hugetlb page, no SIGBUS shows up, while injecting to the head
page produces a SIGBUS.  The cause is that, though hugetlb_walk() returns
a valid pmd entry (on x86), but check_pte() detects mismatch between the
head page per the pmd and the input subpage.  Thus the vaddr is considered
not mapped to the subpage and the process is not collected for SIGBUS
purpose.  This is the calling stack:

      collect_procs_anon
        page_mapped_in_vma
          page_vma_mapped_walk
            hugetlb_walk
              huge_pte_lock
                check_pte

check_pte() header says that it
"check if [pvmw->pfn, @pvmw->pfn + @pvmw->nr_pages) is mapped at the @pvmw->pte"
but practically works only if pvmw->pfn is the head page pfn at pvmw->pte.
Hindsight acknowledging that some pvmw->pte could point to a hugepage of
some sort such that it makes sense to make check_pte() work for hugepage.

Link: https://lkml.kernel.org/r/20250224211445.2663312-1-jane.chu@oracle.com
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kirill A. Shuemov <kirill.shutemov@linux.intel.com>
Cc: linmiaohe <linmiaohe@huawei.com>
Cc: Matthew Wilcow (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page_vma_mapped.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -84,6 +84,7 @@ again:
  * mapped at the @pvmw->pte
  * @pvmw: page_vma_mapped_walk struct, includes a pair pte and pfn range
  * for checking
+ * @pte_nr: the number of small pages described by @pvmw->pte.
  *
  * page_vma_mapped_walk() found a place where pfn range is *potentially*
  * mapped. check_pte() has to validate this.
@@ -100,7 +101,7 @@ again:
  * Otherwise, return false.
  *
  */
-static bool check_pte(struct page_vma_mapped_walk *pvmw)
+static bool check_pte(struct page_vma_mapped_walk *pvmw, unsigned long pte_nr)
 {
 	unsigned long pfn;
 	pte_t ptent = ptep_get(pvmw->pte);
@@ -133,7 +134,11 @@ static bool check_pte(struct page_vma_ma
 		pfn = pte_pfn(ptent);
 	}
 
-	return (pfn - pvmw->pfn) < pvmw->nr_pages;
+	if ((pfn + pte_nr - 1) < pvmw->pfn)
+		return false;
+	if (pfn > (pvmw->pfn + pvmw->nr_pages - 1))
+		return false;
+	return true;
 }
 
 /* Returns true if the two ranges overlap.  Careful to not overflow. */
@@ -208,7 +213,7 @@ bool page_vma_mapped_walk(struct page_vm
 			return false;
 
 		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
-		if (!check_pte(pvmw))
+		if (!check_pte(pvmw, pages_per_huge_page(hstate)))
 			return not_found(pvmw);
 		return true;
 	}
@@ -291,7 +296,7 @@ restart:
 			goto next_pte;
 		}
 this_pte:
-		if (check_pte(pvmw))
+		if (check_pte(pvmw, 1))
 			return true;
 next_pte:
 		do {



