Return-Path: <stable+bounces-180815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9DAB8DCE6
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6141E189B17E
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091341A704B;
	Sun, 21 Sep 2025 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVlFGt3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD951A0BE0
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758465601; cv=none; b=Urc/AE0iWAYIscXZH6KYJ5LdmEQ+lRXIortctUyZ+JA1fbGRJHpvz2+D913ONp7yQIRMIt5FFIX6GWErl6MV1Rcp/C1hIaVtJKGVlL31hZHNQeHNnAVKKzN4qFJMpVlBbxEszUoALisyCP9mqUHXZZ88KZeBvKTiKcUhLCMNvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758465601; c=relaxed/simple;
	bh=fvFLykW6sheujlXfjQUPbX4LkWcD409c52HLe5d9alI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMPLzUehQfqx9d4ksyAvp/f1r0ZEgohvFvmJ7JHl5RDFbpzgP0q6ezr3MERu4tnUNts144rLAS/9ENv4/vWVbou6GxJhsMAh0+BABWiD/L+Oj3S196iWlpR0crEG5W8F+0v00q6FrtpEmo1kojoAcuafYiv8EgV1hIxhQ1oWOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVlFGt3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ADAC116B1;
	Sun, 21 Sep 2025 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758465601;
	bh=fvFLykW6sheujlXfjQUPbX4LkWcD409c52HLe5d9alI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVlFGt3iVZwIcbxag3MZeMJ8UqTP9aKnUX2jm7UfR816HjQPGzwJ1GqyKCJKUyplj
	 yaUM2V4rls46KVW8tOXJjw8CI65KwtsdvF3/8cwwOUuZCmPfw+MPbYgWHPRYC5lCL+
	 0Z5y2Q1M2ryv6XG5MuVsoqoIBgF7k9BtBpcAKu3wXu2PCMEwa+wI1te0DPh2bzIQ8J
	 o49ZHrm2FrqBopuZcXtOSb6erMOO52Lg4kU+810gWeMnnURIGvPwbysOg9g7goNhR1
	 0gyzXfcahfCMzwGzr8JUnxhy5sVJK7qFNG9mpgcnP8msJtKP8ltRXtpvitSjWUeRRv
	 tiyFv9KqhF+aQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
	Will Deacon <will@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Chris Li <chrisl@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Keir Fraser <keirf@google.com>,
	Konstantin Khlebnikov <koct9i@gmail.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Rik van Riel <riel@surriel.com>,
	Shivank Garg <shivankg@amd.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Wei Xu <weixugc@google.com>,
	yangge <yangge1116@126.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Yu Zhao <yuzhao@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] mm/gup: check ref_count instead of lru before migration
Date: Sun, 21 Sep 2025 10:39:54 -0400
Message-ID: <20250921143954.2925079-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250921143954.2925079-1-sashal@kernel.org>
References: <2025092158-payee-omega-5893@gregkh>
 <20250921143954.2925079-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugh Dickins <hughd@google.com>

[ Upstream commit 98c6d259319ecf6e8d027abd3f14b81324b8c0ad ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/gup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index e323843cc5dd8..e010173b24c39 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2354,7 +2354,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (!folio_test_lru(folio) && drain_allow) {
+		if (drain_allow && folio_ref_count(folio) !=
+				   folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
 			drain_allow = false;
 		}
-- 
2.51.0


