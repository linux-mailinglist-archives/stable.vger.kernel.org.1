Return-Path: <stable+bounces-7240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7110F817191
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971AA1C242C8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9BB1D13A;
	Mon, 18 Dec 2023 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lj7R6Q+G"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BE129EF7
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 13:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=y48/RgxA4nfcI2a4m0fGd6f8VrRcn5zgGTlb3Ss4JS8=; b=lj7R6Q+Gh/P4ky+VC2j7LwEvYI
	wDbJ31fFiEvtIKehx+Q6fCRtVx9Z++4gkzRKJNSo1F2cq18NcCB1CkOozGh3OHZTyY7tXcLk9Npmc
	FG/YsObFXeN7Pz+XWQsxJeqBxw5I4hk/JDGeGE0648cOzSgdhSFg8d9Lys1jJb54FZrDZwcvXVN/G
	WQpV9A1AxcCpex4F3gBh1Zvc5msenhmhJ3HZgDWFe8o9WK4+CLC0fqlW/lzpW0KrOzVJY3/un/xig
	ovMvr1DEO8Ok8I7wB9Xb3PJ0H7k9GFqGPOM8YGmYMyapM/CEbMu/Rv1zjGQi8DUz5i5ioDbZ9DzkB
	sr7ivZRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFE8l-00DtCO-F4; Mon, 18 Dec 2023 13:58:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Dan Williams <dan.j.williams@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] mm/memory-failure: Check the mapcount of the precise page
Date: Mon, 18 Dec 2023 13:58:36 +0000
Message-Id: <20231218135837.3310403-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231218135837.3310403-1-willy@infradead.org>
References: <20231218135837.3310403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A process may map only some of the pages in a folio, and might be missed
if it maps the poisoned page but not the head page.  Or it might be
unnecessarily hit if it maps the head page, but not the poisoned page.

Fixes: 7af446a841a2 ("HWPOISON, hugetlb: enable error handling path for hugepage")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6953bda11e6e..82e15baabb48 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1570,7 +1570,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(hpage))
+	if (!page_mapped(p))
 		return true;
 
 	if (PageSwapCache(p)) {
@@ -1621,10 +1621,10 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 		try_to_unmap(folio, ttu);
 	}
 
-	unmap_success = !page_mapped(hpage);
+	unmap_success = !page_mapped(p);
 	if (!unmap_success)
 		pr_err("%#lx: failed to unmap page (mapcount=%d)\n",
-		       pfn, page_mapcount(hpage));
+		       pfn, page_mapcount(p));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
-- 
2.42.0


