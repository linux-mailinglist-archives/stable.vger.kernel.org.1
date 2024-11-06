Return-Path: <stable+bounces-89962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2A9BDC02
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AC61F26BEA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BED81D079F;
	Wed,  6 Nov 2024 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1sX9AKJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA16190676;
	Wed,  6 Nov 2024 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858993; cv=none; b=BWbtXYrPH/DdG0AkO3q5Es1GKMCEX+yJCgJwaQacbdHh0hHCezvEsUxRFt4XHQZxgAV0I7TJfMvNJP/XDAK7mmCI0PF9XNkHBO2D+JEpF6PmItoFljfJjEqMo/4sI5FMJR1ndnOXAgCVeGxZjvjfsVeEmOPRbt3Sw68UmO5G230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858993; c=relaxed/simple;
	bh=kV2fAIghnGPusjLtFBOK8Mq7voh7UMy0XjPiuOjfqxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HrzDKt+jGl+6gBE8T90eTZsWkfnnzMP0Kz20t1qGJWuW/+PIXFNOroVdgZw2Ec8ZtcQJP5ErpGj/7cJfGT9gJ4MdGlMDQdSsDidygd8k4tIdHElReO450PfX3LkqgZPaQJzdrHJZS5aeLvKnaFp9c00ecd+gcLBJM3Tw2DKozlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1sX9AKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009BBC4CECF;
	Wed,  6 Nov 2024 02:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858992;
	bh=kV2fAIghnGPusjLtFBOK8Mq7voh7UMy0XjPiuOjfqxA=;
	h=From:To:Cc:Subject:Date:From;
	b=t1sX9AKJaAohFfzzOys5q67cFM4mKBUnw1428X65MqzJ2doIRj8H9bpL4lbQYIfyd
	 0U2k/LGt1UuwWJ0y5g6yf0cMKUj2gfi8nFrYzpEhMh59tvh/sZWXAXRReYZqrQc8PX
	 haGeMymGgN9TijsxGN8tYNYlkHYpgC+rE2JDtmzJ/i2fxrQIudC6ndg9uXu6I5CMwf
	 iUNmsQ6jIF+ze6/G1mbM4qFVCJWUi+/zMdKfDjtaPuAPc8Ri4wp8owatiKheT2nm96
	 ecHuliMwsRaboMPN3CCSsidXKesWQG10CkBXmcry+0APlUc+id+Q3nwsNY1uei37BR
	 zOFkhazq9+NIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yuzhao@google.com
Cc: Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mm: allow set/clear page_type again" failed to apply to v6.6-stable tree
Date: Tue,  5 Nov 2024 21:09:48 -0500
Message-ID: <20241106020949.173366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9d08ec41a0645283d79a2e642205d488feaceacf Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 19 Oct 2024 22:22:12 -0600
Subject: [PATCH] mm: allow set/clear page_type again

Some page flags (page->flags) were converted to page types
(page->page_types).  A recent example is PG_hugetlb.

From the exclusive writer's perspective, e.g., a thread doing
__folio_set_hugetlb(), there is a difference between the page flag and
type APIs: the former allows the same non-atomic operation to be repeated
whereas the latter does not.  For example, calling __folio_set_hugetlb()
twice triggers VM_BUG_ON_FOLIO(), since the second call expects the type
(PG_hugetlb) not to be set previously.

Using add_hugetlb_folio() as an example, it calls __folio_set_hugetlb() in
the following error-handling path.  And when that happens, it triggers the
aforementioned VM_BUG_ON_FOLIO().

  if (folio_test_hugetlb(folio)) {
    rc = hugetlb_vmemmap_restore_folio(h, folio);
    if (rc) {
      spin_lock_irq(&hugetlb_lock);
      add_hugetlb_folio(h, folio, false);
      ...

It is possible to make hugeTLB comply with the new requirements from the
page type API.  However, a straightforward fix would be to just allow the
same page type to be set or cleared again inside the API, to avoid any
changes to its callers.

Link: https://lkml.kernel.org/r/20241020042212.296781-1-yuzhao@google.com
Fixes: d99e3140a4d3 ("mm: turn folio_test_hugetlb into a PageType")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/page-flags.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1b3a767104878..cc839e4365c18 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -975,12 +975,16 @@ static __always_inline bool folio_test_##fname(const struct folio *folio) \
 }									\
 static __always_inline void __folio_set_##fname(struct folio *folio)	\
 {									\
+	if (folio_test_##fname(folio))					\
+		return;							\
 	VM_BUG_ON_FOLIO(data_race(folio->page.page_type) != UINT_MAX,	\
 			folio);						\
 	folio->page.page_type = (unsigned int)PGTY_##lname << 24;	\
 }									\
 static __always_inline void __folio_clear_##fname(struct folio *folio)	\
 {									\
+	if (folio->page.page_type == UINT_MAX)				\
+		return;							\
 	VM_BUG_ON_FOLIO(!folio_test_##fname(folio), folio);		\
 	folio->page.page_type = UINT_MAX;				\
 }
@@ -993,11 +997,15 @@ static __always_inline int Page##uname(const struct page *page)		\
 }									\
 static __always_inline void __SetPage##uname(struct page *page)		\
 {									\
+	if (Page##uname(page))						\
+		return;							\
 	VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);	\
 	page->page_type = (unsigned int)PGTY_##lname << 24;		\
 }									\
 static __always_inline void __ClearPage##uname(struct page *page)	\
 {									\
+	if (page->page_type == UINT_MAX)				\
+		return;							\
 	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
 	page->page_type = UINT_MAX;					\
 }
-- 
2.43.0





