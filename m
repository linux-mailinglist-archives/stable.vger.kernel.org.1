Return-Path: <stable+bounces-146382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EEAC424B
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 17:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6E31796DE
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA5C1A5BA9;
	Mon, 26 May 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F2qWBagz"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7E6D17
	for <stable@vger.kernel.org>; Mon, 26 May 2025 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748273531; cv=none; b=ir27LxkTLzqmGeVPkKd3JlOgWi6LKFMLsUUe8brVz1G+NipphEFrVOjIxhG2hMLHAynRBg4BqsMHdVI9VIv6ImAm1K6Yb+JNqujooyfQTEnLY3twQkytmnmiSJ3lzf2d3XgHsDY8K/+9z0qJwzpp97PrllXeklRPsZohIZms3Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748273531; c=relaxed/simple;
	bh=sgutTgYoZZpIn5/SwVVHPrO4OkA8/KBF/wtKWspfD1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsibCpB0Oi7q8Q5NoebtoRxyjP6TyGkjBZuupIdiLtYNyCD2/wgOk9JBoDEuVfFwmoQY37kY7P1q3q/h7RMboVpVCgrUF6XUBFXDD93QHng8+W32pVUw9hF0tQdxxtAhpyG9/M0SaWl0CzuVfDgRfjsWbhB2+ahJQoH0eNO3pEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F2qWBagz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=nvA8qE94V7G27iDIlckE2UqeLIBGo0MrBFjov57WZ0M=; b=F2qWBagzmv7oBrOMwrMxehNBj6
	VHj7bqYkyd5fA4BYaCuDUQnuh/IeRBOfvMcprWC+IEkQwOEBtpWly/4wQ1Tx/gEpnp4k+huuSw/X6
	IgwXb4Cvf/gMH1WNLsdkHEV4QoxKJche4TkZvN9Yt3pCniKaO/3hGYDLFre1doP6Ke0BF/BLq7Ulc
	o5CjErbec24dkybwGTxtreUo51fr4bAyX/OPfg210L1trCbCtIzFd0NOhgr5fh66FGMPYzSv/r09v
	aiydlgmtyCRdkvPfUEXs++bNrps6CuMkCuezOCvjYFQDyDXpHORLO4GiAICn5yyU3TeGSkxBo/EWG
	Gq07YzrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJZo4-0000000BYNU-3OCg;
	Mon, 26 May 2025 15:32:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] highmem: add folio_test_partial_kmap()
Date: Mon, 26 May 2025 16:32:02 +0100
Message-ID: <20250526153202.2753751-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025052622-segment-presuming-e4c6@gregkh>
References: <2025052622-segment-presuming-e4c6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit c749d9b7ebbc ("iov_iter: fix copy_page_from_iter_atomic() if
KMAP_LOCAL_FORCE_MAP"), Hugh correctly noted that if KMAP_LOCAL_FORCE_MAP
is enabled, we must limit ourselves to PAGE_SIZE bytes per call to
kmap_local().  The same problem exists in memcpy_from_folio(),
memcpy_to_folio(), folio_zero_tail(), folio_fill_tail() and
memcpy_from_file_folio(), so add folio_test_partial_kmap() to do this more
succinctly.

Link: https://lkml.kernel.org/r/20250514170607.3000994-2-willy@infradead.org
Fixes: 00cdf76012ab ("mm: add memcpy_from_file_folio()")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 97dfbbd135cb5e4426f37ca53a8fa87eaaa4e376)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h    | 6 +++---
 include/linux/page-flags.h | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 75607d4ba26c..714966d5701e 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -448,7 +448,7 @@ static inline void memcpy_from_folio(char *to, struct folio *folio,
 		const char *from = kmap_local_folio(folio, offset);
 		size_t chunk = len;
 
-		if (folio_test_highmem(folio) &&
+		if (folio_test_partial_kmap(folio) &&
 		    chunk > PAGE_SIZE - offset_in_page(offset))
 			chunk = PAGE_SIZE - offset_in_page(offset);
 		memcpy(to, from, chunk);
@@ -469,7 +469,7 @@ static inline void memcpy_to_folio(struct folio *folio, size_t offset,
 		char *to = kmap_local_folio(folio, offset);
 		size_t chunk = len;
 
-		if (folio_test_highmem(folio) &&
+		if (folio_test_partial_kmap(folio) &&
 		    chunk > PAGE_SIZE - offset_in_page(offset))
 			chunk = PAGE_SIZE - offset_in_page(offset);
 		memcpy(to, from, chunk);
@@ -501,7 +501,7 @@ static inline size_t memcpy_from_file_folio(char *to, struct folio *folio,
 	size_t offset = offset_in_folio(folio, pos);
 	char *from = kmap_local_folio(folio, offset);
 
-	if (folio_test_highmem(folio)) {
+	if (folio_test_partial_kmap(folio)) {
 		offset = offset_in_page(offset);
 		len = min_t(size_t, len, PAGE_SIZE - offset);
 	} else
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a77f3a7d21d1..36d0961f1672 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -551,6 +551,13 @@ PAGEFLAG(Readahead, readahead, PF_NO_COMPOUND)
 PAGEFLAG_FALSE(HighMem, highmem)
 #endif
 
+/* Does kmap_local_folio() only allow access to one page of the folio? */
+#ifdef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
+#define folio_test_partial_kmap(f)	true
+#else
+#define folio_test_partial_kmap(f)	folio_test_highmem(f)
+#endif
+
 #ifdef CONFIG_SWAP
 static __always_inline bool folio_test_swapcache(struct folio *folio)
 {
-- 
2.47.2


