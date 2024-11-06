Return-Path: <stable+bounces-89949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACF59BDBD6
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBE01F24537
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AD618FC6B;
	Wed,  6 Nov 2024 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+rWMte/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8193318F2F8;
	Wed,  6 Nov 2024 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858928; cv=none; b=N9EJcSbTyCAhJEcJ/qdNHsI0u8Jbtihk0Ywgdl8fO0ck33JT1t0wCelBhAtC/b6AMivb4ZiuC4ikbtcctDXjpkgnSMVLWsf22NwwnQ5fJ7M2zU8f/uwgBpKfjmHYTC0SrhQQHtR0Ldg1tSmMCkGvNf+wdw54ILvDMox4CgUgTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858928; c=relaxed/simple;
	bh=y633lpEFyHH8MzWJ9nz+N53GCqq0mDTqy0M+lzKqTAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syQ2B7psRNFqSCjijRshHc+FkA3J098yuzD3Zemrad+9ibAUmbFKdIFpiZRN2IDGBbMaxB+u07K210d2Kljy++C9AJtsDtlUY5IUAENAKOTeiNqi2lqWfQh5Jc7HE2Mcgu1qdSsL+st9yh4XGp0Q9n6SBUMeHU5yFNve+dV1N2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+rWMte/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C10EC4CECF;
	Wed,  6 Nov 2024 02:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858928;
	bh=y633lpEFyHH8MzWJ9nz+N53GCqq0mDTqy0M+lzKqTAA=;
	h=From:To:Cc:Subject:Date:From;
	b=U+rWMte/2MUJ7JnY25v4qIws8gct2Bes9nVV389irSKwWcXLWzvHiYJstLb0Im1jQ
	 drQ308378IMY6ch61nBPWpF2LUaZOifxtzfctftosU4Kwc/85+YNTJj7zi3RuHQtTW
	 VsrVKsX2swP1o7AjFEZ3Z4LAtQFc2WerzjI5exDAkuDgMov4s9HEFc0OhTFr4ZS4Pn
	 Qnl9Ur70wvaGPTF25FbGJrW3NgVrxAo1Ss0gwcIa+KYRU6SBmMdfnhwFnfL06EEMJA
	 04yjVPG/p61R0dhVo9Q/ygINkygzcblyzFh6d3HgZqqR2KzfsSttF0TbZCqgLi2JWK
	 rAsa7lWY5FUjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	baohua@kernel.org
Cc: Barry Song <v-songbaohua@oppo.com>,
	Oven Liyang <liyangouwen1@oppo.com>,
	Kairui Song <kasong@tencent.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Minchan Kim <minchan@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	SeongJae Park <sj@kernel.org>,
	Kalesh Singh <kaleshsingh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mm: avoid unconditional one-tick sleep when swapcache_prepare fails" failed to apply to v6.11-stable tree
Date: Tue,  5 Nov 2024 21:08:43 -0500
Message-ID: <20241106020843.164405-1-sashal@kernel.org>
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

From 01626a18230246efdcea322aa8f067e60ffe5ccd Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Fri, 27 Sep 2024 09:19:36 +1200
Subject: [PATCH] mm: avoid unconditional one-tick sleep when swapcache_prepare
 fails

Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
introduced an unconditional one-tick sleep when `swapcache_prepare()`
fails, which has led to reports of UI stuttering on latency-sensitive
Android devices.  To address this, we can use a waitqueue to wake up tasks
that fail `swapcache_prepare()` sooner, instead of always sleeping for a
full tick.  While tasks may occasionally be woken by an unrelated
`do_swap_page()`, this method is preferable to two scenarios: rapid
re-entry into page faults, which can cause livelocks, and multiple
millisecond sleeps, which visibly degrade user experience.

Oven's testing shows that a single waitqueue resolves the UI stuttering
issue.  If a 'thundering herd' problem becomes apparent later, a waitqueue
hash similar to `folio_wait_table[PAGE_WAIT_TABLE_SIZE]` for page bit
locks can be introduced.

[v-songbaohua@oppo.com: wake_up only when swapcache_wq waitqueue is active]
  Link: https://lkml.kernel.org/r/20241008130807.40833-1-21cnbao@gmail.com
Link: https://lkml.kernel.org/r/20240926211936.75373-1-21cnbao@gmail.com
Fixes: 13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reported-by: Oven Liyang <liyangouwen1@oppo.com>
Tested-by: Oven Liyang <liyangouwen1@oppo.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/memory.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 3ccee51adfbbd..bdf77a3ec47bc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4187,6 +4187,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -4199,6 +4201,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *swapcache, *folio = NULL;
+	DECLARE_WAITQUEUE(wait, current);
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
@@ -4297,7 +4300,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 					 * Relax a bit to prevent rapid
 					 * repeated page faults.
 					 */
+					add_wait_queue(&swapcache_wq, &wait);
 					schedule_timeout_uninterruptible(1);
+					remove_wait_queue(&swapcache_wq, &wait);
 					goto out_page;
 				}
 				need_clear_cache = true;
@@ -4604,8 +4609,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
-	if (need_clear_cache)
+	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
+		if (waitqueue_active(&swapcache_wq))
+			wake_up(&swapcache_wq);
+	}
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4620,8 +4628,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
-	if (need_clear_cache)
+	if (need_clear_cache) {
 		swapcache_clear(si, entry, nr_pages);
+		if (waitqueue_active(&swapcache_wq))
+			wake_up(&swapcache_wq);
+	}
 	if (si)
 		put_swap_device(si);
 	return ret;
-- 
2.43.0





