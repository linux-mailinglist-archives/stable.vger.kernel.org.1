Return-Path: <stable+bounces-7239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32E817190
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3362F1C2439D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2411D137;
	Mon, 18 Dec 2023 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRN9fROQ"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B879101D4
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lk4ShxhGVru3Bk7ei2k86xrh9E3OhTWS1/aDPPIk7O8=; b=MRN9fROQ5pLlJRCR4KlgWLhKPg
	wdR5cGTZGP2N6uvHx24BwIKWTO5Qu4mmAE0Yl8zDP4JcDnWomX3F3XSDI1hTJOwchkpQjljgLaVJP
	LKJnH8i5pwqcYKW3GiAJsxA8vRrx5anMYlOARSITjSxOB2XvQWc98C2vICOHDCmA9XnVDzXzs8CC6
	BjOMaA7g+wU4Xdl/V2XwnGGD1YJnnpoIntlYiyS4+qZwpcgr+trJqf3SHwiLBvImUVNdWVf5Hf8xr
	5EDPy15+9WjPSgITT4Mgut90Bl18Wtsiid0W2P3LNv3rL4TJvF1Zf8Wtsr8TB0IPpJN/clCNkaXgc
	a47ii+Cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFE8l-00DtCQ-Hx; Mon, 18 Dec 2023 13:58:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Dan Williams <dan.j.williams@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] mm/memory-failure: Cast index to loff_t before shifting it
Date: Mon, 18 Dec 2023 13:58:37 +0000
Message-Id: <20231218135837.3310403-4-willy@infradead.org>
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

On 32-bit systems, we'll lose the top bits of index because arithmetic
will be performed in unsigned long instead of unsigned long long.  This
affects files over 4GB in size.

Fixes: 6100e34b2526 ("mm, memory_failure: Teach memory_failure() about dev_pagemap pages")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 82e15baabb48..455093f73a70 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1704,7 +1704,7 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 		 * mapping being torn down is communicated in siginfo, see
 		 * kill_proc()
 		 */
-		loff_t start = (index << PAGE_SHIFT) & ~(size - 1);
+		loff_t start = ((loff_t)index << PAGE_SHIFT) & ~(size - 1);
 
 		unmap_mapping_range(mapping, start, size, 0);
 	}
-- 
2.42.0


