Return-Path: <stable+bounces-89950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2808D9BDBD8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E5A284627
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12B190470;
	Wed,  6 Nov 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dypJVbS4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC618FC7E;
	Wed,  6 Nov 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858932; cv=none; b=HhEfEUjuN7fDuNDOt87G/8UoG2I563cP5tEKP09cm7KzpkGNeRYP1aDqWW6RNlBlwR2rh1oAICgiywgm5REL5CbnhAdVdbtdzxEJ2FDWx41ZKVkAYPy1agst4AGNQgmyG/FiD69y3IlWna/2fUbfEoDmCw6SgWusCjgB9CrJFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858932; c=relaxed/simple;
	bh=eNKDvFM9I+ksQdkaL8Q2vFoYiN47/P3HtWvaJX1cbI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knvdm8pfHe2808r9aluV+8Wldu14CMe+AVjWrSCWSUgp4UZcIIacyhj5kMYq6KMHHryxFwoMuN9K592J1bom4ZG0VecLobNugIN8SGWq0dlnoMSLc6NH4X+a8QFJe2oYovO/ShLPyiu/N4Yq7av3e5UFIZuWMcYvxCoZSs7nPoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dypJVbS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4786C4CECF;
	Wed,  6 Nov 2024 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858931;
	bh=eNKDvFM9I+ksQdkaL8Q2vFoYiN47/P3HtWvaJX1cbI8=;
	h=From:To:Cc:Subject:Date:From;
	b=dypJVbS4/YRSf07/VfIrGx14mEBGuXz6sUwnKJWtwajGSH8+xY+Rxkx7acnFtQLRk
	 86cSoS+ZuVLBh4ZZTZqAm3SKbqgGWeGSi/A6eerFVZxzsbqtDcnD1gf1zffGJAqO/O
	 Q4qK7UceMmMgln7MZ2khYORpWRsv2oaEi8sF/wYEnTQa39ldOci/t3qxQ+tJVuWYpX
	 6EpSSrG1gw6YUA2g5eS2oFpp/dZLXthF9YU59OpPt+lXNlt0lq1OFOzDyMiG6iPez7
	 rlKeKNNPa5dDGQF8uzRAp3XY9lbuADFPxxbCGhkjPCQ8AWmK67+9G3OBO32j5bsw3X
	 k3WOceZdxANQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yuzhao@google.com
Cc: Matthew Wilcox <willy@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mm: allow set/clear page_type again" failed to apply to v6.11-stable tree
Date: Tue,  5 Nov 2024 21:08:48 -0500
Message-ID: <20241106020849.164447-1-sashal@kernel.org>
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

The patch below does not apply to the v6.11-stable tree.
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





