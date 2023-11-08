Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608437E5D30
	for <lists+stable@lfdr.de>; Wed,  8 Nov 2023 19:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjKHS2d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 8 Nov 2023 13:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHS2c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 8 Nov 2023 13:28:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7B72105
        for <stable@vger.kernel.org>; Wed,  8 Nov 2023 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Hh7iR22H/bMBGg1WTep51qz0ES5l/FVjx1m1RYU2PfQ=; b=vbaruzZi/nRV0eD5bIifbhL48M
        lrsEFUNwWq7APBHxiX/omLWGhaMszAff2PpF8eYHbnXmrIvbDx1WWo5yq0yCn6qTLK0Utd+fLTWax
        a5Y7SkOOj83Jpdw2Ndn7xGpTVs5z+KNqqpjHV9bChnAavQP9fL/xf9DdIjgWfcgT00+LpWfkImjz1
        C8jiymDHrQ8luWORDfZL9iisCP3FUwGIeXWi0kJNQjzYEOJ700dDpPNmS+53X/yfm9GfNxM+u1ZeN
        8vWwmtyUZll+1thVFzvLzBLj7V1bUQtxdpECKQfXJI4VztC/c87t1OGEctUFM/Z4cNQkhCizbO1Ot
        ImvwbaxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0nHf-002WdI-1E; Wed, 08 Nov 2023 18:28:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: [PATCH 2/6] mm: Convert __do_fault() to use a folio
Date:   Wed,  8 Nov 2023 18:28:05 +0000
Message-Id: <20231108182809.602073-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108182809.602073-1-willy@infradead.org>
References: <20231108182809.602073-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Convert vmf->page to a folio as soon as we're going to use it.  This fixes
a bug if the fault handler returns a tail page with hardware poison;
tail pages have an invalid page->index, so we would fail to unmap the
page from the page tables.  We actually have to unmap the entire folio (or
mapping_evict_folio() will fail), so use unmap_mapping_folio() instead.

This also saves various calls to compound_head() hidden in lock_page(),
put_page(), etc.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
---
 mm/memory.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..c2ee303ba6b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4239,6 +4239,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 static vm_fault_t __do_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
 	vm_fault_t ret;
 
 	/*
@@ -4267,27 +4268,26 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 			    VM_FAULT_DONE_COW)))
 		return ret;
 
+	folio = page_folio(vmf->page);
 	if (unlikely(PageHWPoison(vmf->page))) {
-		struct page *page = vmf->page;
 		vm_fault_t poisonret = VM_FAULT_HWPOISON;
 		if (ret & VM_FAULT_LOCKED) {
-			if (page_mapped(page))
-				unmap_mapping_pages(page_mapping(page),
-						    page->index, 1, false);
-			/* Retry if a clean page was removed from the cache. */
-			if (invalidate_inode_page(page))
+			if (page_mapped(vmf->page))
+				unmap_mapping_folio(folio);
+			/* Retry if a clean folio was removed from the cache. */
+			if (mapping_evict_folio(folio->mapping, folio))
 				poisonret = VM_FAULT_NOPAGE;
-			unlock_page(page);
+			folio_unlock(folio);
 		}
-		put_page(page);
+		folio_put(folio);
 		vmf->page = NULL;
 		return poisonret;
 	}
 
 	if (unlikely(!(ret & VM_FAULT_LOCKED)))
-		lock_page(vmf->page);
+		folio_lock(folio);
 	else
-		VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page);
+		VM_BUG_ON_PAGE(!folio_test_locked(folio), vmf->page);
 
 	return ret;
 }
-- 
2.42.0

