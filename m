Return-Path: <stable+bounces-56910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296D924D96
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 04:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41D1FB23E2D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0FA5228;
	Wed,  3 Jul 2024 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fYq6RcCN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B220946B5;
	Wed,  3 Jul 2024 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719972764; cv=none; b=rYzNV5dOT0J/cYZO5I9leVTXnGLj9dQ4yLzbOv/y0sg2EDK9/GmB8qLrpQY0fj1bhVzEhl9u/QWcVNB+JLg+ukB94G1hxjcQTrCEQ2kjccZt8rJzhFgoiCKrYt8fmv6zEcwPkfVcY2w8mCBVaxUMEWnoaIeF6NHfXjgd+K7sJP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719972764; c=relaxed/simple;
	bh=WMOGJM/eIvbSlzNXfRxZCrAPHE9Qou+Pouy5o1n7a5M=;
	h=Date:To:From:Subject:Message-Id; b=N11r8CIsnDaVKYp2bM8dDOAUpeSZEhE3++AMaLPHeZ00D3EN3n9Ps0h7T9s7QquCo0cFTvnM0DLGL+8+22NUda4PYhA6QVQpkLBV0U9UMVFElU/zrL93SdBV8jrhA2BFqdmedrQpEfXB70F0tzRSNlfFzYE9aoTFIFxKaCI/6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fYq6RcCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394BFC116B1;
	Wed,  3 Jul 2024 02:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719972764;
	bh=WMOGJM/eIvbSlzNXfRxZCrAPHE9Qou+Pouy5o1n7a5M=;
	h=Date:To:From:Subject:From;
	b=fYq6RcCNfTEIneJMUHvHnUFOSobHgMUcuejTgfkF1pRW+aho2luCrFgQiSU4Ndr5A
	 ahAl/o64XIVY4yplTkKvBZgxkH4KZymXJ93Y5l80BjzT6COqbb+tkvRZeakR+bTMKK
	 ZBkHISuyq8v4GfQ9IAMCQIek1oUVXr5qqElZ6XQs=
Date: Tue, 02 Jul 2024 19:12:43 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,willy@infradead.org,wangkefeng.wang@huawei.com,stable@vger.kernel.org,shy828301@gmail.com,nphamcs@gmail.com,david@redhat.com,baolin.wang@linux.alibaba.com,baohua@kernel.org,hughd@google.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-fix-crashes-from-deferred-split-racing-folio-migration.patch added to mm-hotfixes-unstable branch
Message-Id: <20240703021244.394BFC116B1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: fix crashes from deferred split racing folio migration
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-fix-crashes-from-deferred-split-racing-folio-migration.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-fix-crashes-from-deferred-split-racing-folio-migration.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Hugh Dickins <hughd@google.com>
Subject: mm: fix crashes from deferred split racing folio migration
Date: Tue, 2 Jul 2024 00:40:55 -0700 (PDT)

Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
flags when freeing, yet the flags shown are not bad: PG_locked had been
set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
symptoms implying double free by deferred split and large folio migration.

6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
folio migration") was right to fix the memcg-dependent locking broken in
85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
but missed a subtlety of deferred_split_scan(): it moves folios to its own
local list to work on them without split_queue_lock, during which time
folio->_deferred_list is not empty, but even the "right" lock does nothing
to secure the folio and the list it is on.

Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
while the old folio's reference count is temporarily frozen to 0 - adding
such a freeze in the !mapping case too (originally, folio lock and
unmapping and no swap cache left an anon folio unreachable, so no freezing
was needed there: but the deferred split queue offers a way to reach it).

Link: https://lkml.kernel.org/r/29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com
Fixes: 9bcef5973e31 ("mm: memcg: fix split queue list crash when large folio migration")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memcontrol.c |   11 -----------
 mm/migrate.c    |   13 +++++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

--- a/mm/memcontrol.c~mm-fix-crashes-from-deferred-split-racing-folio-migration
+++ a/mm/memcontrol.c
@@ -7823,17 +7823,6 @@ void mem_cgroup_migrate(struct folio *ol
 
 	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
-	/*
-	 * If the old folio is a large folio and is in the split queue, it needs
-	 * to be removed from the split queue now, in case getting an incorrect
-	 * split queue in destroy_large_folio() after the memcg of the old folio
-	 * is cleared.
-	 *
-	 * In addition, the old folio is about to be freed after migration, so
-	 * removing from the split queue a bit earlier seems reasonable.
-	 */
-	if (folio_test_large(old) && folio_test_large_rmappable(old))
-		folio_undo_large_rmappable(old);
 	old->memcg_data = 0;
 }
 
--- a/mm/migrate.c~mm-fix-crashes-from-deferred-split-racing-folio-migration
+++ a/mm/migrate.c
@@ -415,6 +415,15 @@ int folio_migrate_mapping(struct address
 		if (folio_ref_count(folio) != expected_count)
 			return -EAGAIN;
 
+		/* Take off deferred split queue while frozen and memcg set */
+		if (folio_test_large(folio) &&
+		    folio_test_large_rmappable(folio)) {
+			if (!folio_ref_freeze(folio, expected_count))
+				return -EAGAIN;
+			folio_undo_large_rmappable(folio);
+			folio_ref_unfreeze(folio, expected_count);
+		}
+
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
@@ -433,6 +442,10 @@ int folio_migrate_mapping(struct address
 		return -EAGAIN;
 	}
 
+	/* Take off deferred split queue while frozen and memcg set */
+	if (folio_test_large(folio) && folio_test_large_rmappable(folio))
+		folio_undo_large_rmappable(folio);
+
 	/*
 	 * Now we know that no one else is looking at the folio:
 	 * no turning back from here.
_

Patches currently in -mm which might be from hughd@google.com are

mm-fix-crashes-from-deferred-split-racing-folio-migration.patch


