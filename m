Return-Path: <stable+bounces-180801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C9B8DB4C
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E813BB7C9
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A4259CA3;
	Sun, 21 Sep 2025 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJMEakon"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E571E51D
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758459122; cv=none; b=qfAkAeRdj87buhYW9NeWj6oSE8VLn9h7Q+IuvTy6zRLN09HyawF9NVZCA9kZPPZ5LLHk4J94pByCwh/1CSvTsE0c0EX+FOLbvv7nkwGhtr8FpamA1bzzl+p0xaUuItqLrTJmcGxI0sl/gyNazNJmEZmgbBZqcs7o9N8hGwPJ7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758459122; c=relaxed/simple;
	bh=qXHqRX2HSyq9XsGdQfdHgz72GuuiTh4S50J2sA/x4Dk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hp0vHZUa4KGuZHH7e/JdYgfL5AsWy1vcfECFy69KwJ7nzn0ckECA/vupJHIuJ7i1rHr4MFc17ZzGDFu2DjeKHeNaKy0Iqtz8iRIxKW3V6fbNBKggyXzFCXhApgmS9F1WK7IvZ/N0xDUQI3g4v+dsUUtdk0pMFKhaH9YO+/x01Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dJMEakon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51237C4CEE7;
	Sun, 21 Sep 2025 12:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758459120;
	bh=qXHqRX2HSyq9XsGdQfdHgz72GuuiTh4S50J2sA/x4Dk=;
	h=Subject:To:Cc:From:Date:From;
	b=dJMEakonPwIMiUv299IVM9cqULkEi+h9abh8ddlxrVsjQz+r6yy8kSYrNsaV25zos
	 sEHLSU8nB9zZ0C5LOhV6A4oO+g2LnvLE7CfcIr0z9/vplY9LzQuMRJHL2jkOh1wuXp
	 fdUCSplAnhSQCvqCTC2+jqtUMmj4LvucZzNM5wd8=
Subject: FAILED: patch "[PATCH] mm/gup: check ref_count instead of lru before migration" failed to apply to 6.12-stable tree
To: hughd@google.com,akpm@linux-foundation.org,aneesh.kumar@kernel.org,axelrasmussen@google.com,chrisl@kernel.org,david@redhat.com,hannes@cmpxchg.org,hch@infradead.org,jgg@ziepe.ca,jhubbard@nvidia.com,kas@kernel.org,keirf@google.com,koct9i@gmail.com,lizhe.67@bytedance.com,peterx@redhat.com,riel@surriel.com,shivankg@amd.com,stable@vger.kernel.org,vbabka@suse.cz,weixugc@google.com,will@kernel.org,willy@infradead.org,yangge1116@126.com,yuanchu@google.com,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:51:58 +0200
Message-ID: <2025092158-payee-omega-5893@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 98c6d259319ecf6e8d027abd3f14b81324b8c0ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092158-payee-omega-5893@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 98c6d259319ecf6e8d027abd3f14b81324b8c0ad Mon Sep 17 00:00:00 2001
From: Hugh Dickins <hughd@google.com>
Date: Mon, 8 Sep 2025 15:15:03 -0700
Subject: [PATCH] mm/gup: check ref_count instead of lru before migration

Patch series "mm: better GUP pin lru_add_drain_all()", v2.

Series of lru_add_drain_all()-related patches, arising from recent mm/gup
migration report from Will Deacon.


This patch (of 5):

Will Deacon reports:-

When taking a longterm GUP pin via pin_user_pages(),
__gup_longterm_locked() tries to migrate target folios that should not be
longterm pinned, for example because they reside in a CMA region or
movable zone.  This is done by first pinning all of the target folios
anyway, collecting all of the longterm-unpinnable target folios into a
list, dropping the pins that were just taken and finally handing the list
off to migrate_pages() for the actual migration.

It is critically important that no unexpected references are held on the
folios being migrated, otherwise the migration will fail and
pin_user_pages() will return -ENOMEM to its caller.  Unfortunately, it is
relatively easy to observe migration failures when running pKVM (which
uses pin_user_pages() on crosvm's virtual address space to resolve stage-2
page faults from the guest) on a 6.15-based Pixel 6 device and this
results in the VM terminating prematurely.

In the failure case, 'crosvm' has called mlock(MLOCK_ONFAULT) on its
mapping of guest memory prior to the pinning.  Subsequently, when
pin_user_pages() walks the page-table, the relevant 'pte' is not present
and so the faulting logic allocates a new folio, mlocks it with
mlock_folio() and maps it in the page-table.

Since commit 2fbb0c10d1e8 ("mm/munlock: mlock_page() munlock_page() batch
by pagevec"), mlock/munlock operations on a folio (formerly page), are
deferred.  For example, mlock_folio() takes an additional reference on the
target folio before placing it into a per-cpu 'folio_batch' for later
processing by mlock_folio_batch(), which drops the refcount once the
operation is complete.  Processing of the batches is coupled with the LRU
batch logic and can be forcefully drained with lru_add_drain_all() but as
long as a folio remains unprocessed on the batch, its refcount will be
elevated.

This deferred batching therefore interacts poorly with the pKVM pinning
scenario as we can find ourselves in a situation where the migration code
fails to migrate a folio due to the elevated refcount from the pending
mlock operation.

Hugh Dickins adds:-

!folio_test_lru() has never been a very reliable way to tell if an
lru_add_drain_all() is worth calling, to remove LRU cache references to
make the folio migratable: the LRU flag may be set even while the folio is
held with an extra reference in a per-CPU LRU cache.

5.18 commit 2fbb0c10d1e8 may have made it more unreliable.  Then 6.11
commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding
to LRU batch") tried to make it reliable, by moving LRU flag clearing; but
missed the mlock/munlock batches, so still unreliable as reported.

And it turns out to be difficult to extend 33dfe9204f29's LRU flag
clearing to the mlock/munlock batches: if they do benefit from batching,
mlock/munlock cannot be so effective when easily suppressed while !LRU.

Instead, switch to an expected ref_count check, which was more reliable
all along: some more false positives (unhelpful drains) than before, and
never a guarantee that the folio will prove migratable, but better.

Note on PG_private_2: ceph and nfs are still using the deprecated
PG_private_2 flag, with the aid of netfs and filemap support functions.
Although it is consistently matched by an increment of folio ref_count,
folio_expected_ref_count() intentionally does not recognize it, and ceph
folio migration currently depends on that for PG_private_2 folios to be
rejected.  New references to the deprecated flag are discouraged, so do
not add it into the collect_longterm_unpinnable_folios() calculation: but
longterm pinning of transiently PG_private_2 ceph and nfs folios (an
uncommon case) may invoke a redundant lru_add_drain_all().  And this makes
easy the backport to earlier releases: up to and including 6.12, btrfs
also used PG_private_2, but without a ref_count increment.

Note for stable backports: requires 6.16 commit 86ebd50224c0 ("mm:
add folio_expected_ref_count() for reference count calculation").

Link: https://lkml.kernel.org/r/41395944-b0e3-c3ac-d648-8ddd70451d28@google.com
Link: https://lkml.kernel.org/r/bd1f314a-fca1-8f19-cac0-b936c9614557@google.com
Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reported-by: Will Deacon <will@kernel.org>
Closes: https://lore.kernel.org/linux-mm/20250815101858.24352-1-will@kernel.org/
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Keir Fraser <keirf@google.com>
Cc: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Li Zhe <lizhe.67@bytedance.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shivank Garg <shivankg@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Xu <weixugc@google.com>
Cc: yangge <yangge1116@126.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/gup.c b/mm/gup.c
index adffe663594d..82aec6443c0a 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2307,7 +2307,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (drain_allow && folio_ref_count(folio) !=
+				   folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}


