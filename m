Return-Path: <stable+bounces-95431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CBE9D8D50
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 21:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568B6162D23
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 20:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76221B4144;
	Mon, 25 Nov 2024 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TE0REL5d"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17ED195390
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565850; cv=none; b=SZqVypeq/w8aokkRpsT72T8lfYXNaqt4s/UBnVP7jml0LD7OwMkAqmuKRZhOBxOHrhFtVCzc1N1x24zjEd3Oi9a+qRkJSUDRDjUMxFfQyGHabTdxFI1S/9VmEoToCvHyp8Csk2d3b+lXl04vaCXc55N9WXTk19IDNB5Q2GknQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565850; c=relaxed/simple;
	bh=qTPFV3abrsDVhboYj4KCz8z5CyV2yd3jmGO/UsVBRYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhGBfiHG3YikuPzv/AIj7sUetbFf68JV22G0YM+9MUwMzlwkIm037SdDwR1njAFLzUSblyY1OxT4PXg/nI8/8iNnHy0bqE7sopyrx+rA4IyxUtdOAnbKcf0p1CClZx34ve+sJz9afS37o1Y7oLmNwmOGpac4hQHZg49c1M8lZ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TE0REL5d; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=K+++vtIZMVtt4Tc0tDY1EnZo4+FLY6a0tS3n2H/3/pI=; b=TE0REL5dlMeB2IYB6VZ27EWyoR
	aw7cQhTuZGScpzjNKdpGwgMgrCsMhX76XO7z6NYSjn61eRabWGYVhtLKQ91rNR3AkgeKEDkfruX//
	XGSC/p08fF6eQ26KyUnZZZQxsXwt8QrByUKains6OpVDNawQQYlQWG46naOfnf0/grk9JNSKlnA4y
	HG4tpT/Wnc59fuiDWTSvvVFezFYEx4/N/pVc6TnFL6YAGwPt45WK9AC0oj0TGFQQ5xYZXeaap0NFK
	p7hTeMcZYWmTDu3sxIX3nEDklNrSdJyCJWoARibvbG8kdk6sPI0wDIee43BuMgFl0cSJctCy/ntnq
	fzU/uLeg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFfWN-0000000CQt0-0Col;
	Mon, 25 Nov 2024 20:17:23 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm: Open-code page_folio() in dump_page()
Date: Mon, 25 Nov 2024 20:17:19 +0000
Message-ID: <20241125201721.2963278-2-willy@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125201721.2963278-1-willy@infradead.org>
References: <20241125201721.2963278-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

page_folio() calls page_fixed_fake_head() which will misidentify this
page as being a fake head and load off the end of 'precise'.  We may
have a pointer to a fake head, but that's OK because it contains the
right information for dump_page().

gcc-15 is smart enough to catch this with -Warray-bounds:

In function 'page_fixed_fake_head',
    inlined from '_compound_head' at ../include/linux/page-flags.h:251:24,
    inlined from '__dump_page' at ../mm/debug.c:123:11:
../include/asm-generic/rwonce.h:44:26: warning: array subscript 9 is outside
+array bounds of 'struct page[1]' [-Warray-bounds=]

Reported-by: Kees Cook <kees@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: fae7d834c43c (mm: add __dump_folio())
Cc: stable@vger.kernel.org
---
 mm/debug.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index aa57d3ffd4ed..95b6ab809c0e 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -124,19 +124,22 @@ static void __dump_page(const struct page *page)
 {
 	struct folio *foliop, folio;
 	struct page precise;
+	unsigned long head;
 	unsigned long pfn = page_to_pfn(page);
 	unsigned long idx, nr_pages = 1;
 	int loops = 5;
 
 again:
 	memcpy(&precise, page, sizeof(*page));
-	foliop = page_folio(&precise);
-	if (foliop == (struct folio *)&precise) {
+	head = precise.compound_head;
+	if ((head & 1) == 0) {
+		foliop = (struct folio *)&precise;
 		idx = 0;
 		if (!folio_test_large(foliop))
 			goto dump;
 		foliop = (struct folio *)page;
 	} else {
+		foliop = (struct folio *)(head - 1);
 		idx = folio_page_idx(foliop, page);
 	}
 
-- 
2.45.2


