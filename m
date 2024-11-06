Return-Path: <stable+bounces-90928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFD9BEBB2
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9150BB2493B
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD21F8F1C;
	Wed,  6 Nov 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hf7BB8Ff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79131E0B62;
	Wed,  6 Nov 2024 12:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897229; cv=none; b=f3SrYP1pJ33hm8BsZ9HT1nLZ9rv7CyH4jLrYIfbliDJPLjcWrA+uN727GoRUVmo0CjELFMlqNyE37iCXV4/UPuXMjeVdw4YrmaqjH9OOcn2iYqq5vDTJqtjr9zyhheUcrw6TF68UWfjJoaqmn8BZnlBIi1mLAPOgmSKDjfWZk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897229; c=relaxed/simple;
	bh=kxYX+p16lqJYNgWMcPvgP/Yzcc9NmqpQsq32keG6t9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfN4d6R0hJ05pvybwkowuDtKkH1/9rQh2dor7iSvRaUT9mwhMaQ5HntDAz6Q6+Oi4gec7kZLcu6CoWVxYigVxNZauhFBSwxLyuPNxOl5V4J86IGbzDqD1zvOv3/vmSB0Vv/g/8SkvDhGFgbMj8RELXjG5qAmNq+QcZSaRKWHn44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hf7BB8Ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDC6C4CECD;
	Wed,  6 Nov 2024 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897229;
	bh=kxYX+p16lqJYNgWMcPvgP/Yzcc9NmqpQsq32keG6t9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hf7BB8Ff2tXiNFSws3HlJJ1sxFit5LK/lDFWvBPD5pLyJoqOK/SrmXaQeQsZlq3Gg
	 1SGvIhm8cPAVLANV5Q4bdb4sPyROFyfpmiUhY6bE1tAdwIlFaaOxWsrWXQy1Qf8ZA7
	 F87fIuISABwjVmzolGO0PI+XrOMVqe19d4dGLCho=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Huang, Ying" <ying.huang@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Yang Shi <shy828301@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Bharata B Rao <bharata@amd.com>,
	Minchan Kim <minchan@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 109/126] migrate_pages: organize stats with struct migrate_pages_stats
Date: Wed,  6 Nov 2024 13:05:10 +0100
Message-ID: <20241106120309.004895689@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Ying <ying.huang@intel.com>

[ Upstream commit 5b855937096aea7f81e73ad6d40d433c9dd49577 ]

Patch series "migrate_pages(): batch TLB flushing", v5.

Now, migrate_pages() migrates folios one by one, like the fake code as
follows,

  for each folio
    unmap
    flush TLB
    copy
    restore map

If multiple folios are passed to migrate_pages(), there are opportunities
to batch the TLB flushing and copying.  That is, we can change the code to
something as follows,

  for each folio
    unmap
  for each folio
    flush TLB
  for each folio
    copy
  for each folio
    restore map

The total number of TLB flushing IPI can be reduced considerably.  And we
may use some hardware accelerator such as DSA to accelerate the folio
copying.

So in this patch, we refactor the migrate_pages() implementation and
implement the TLB flushing batching.  Base on this, hardware accelerated
folio copying can be implemented.

If too many folios are passed to migrate_pages(), in the naive batched
implementation, we may unmap too many folios at the same time.  The
possibility for a task to wait for the migrated folios to be mapped again
increases.  So the latency may be hurt.  To deal with this issue, the max
number of folios be unmapped in batch is restricted to no more than
HPAGE_PMD_NR in the unit of page.  That is, the influence is at the same
level of THP migration.

We use the following test to measure the performance impact of the
patchset,

On a 2-socket Intel server,

 - Run pmbench memory accessing benchmark

 - Run `migratepages` to migrate pages of pmbench between node 0 and
   node 1 back and forth.

With the patch, the TLB flushing IPI reduces 99.1% during the test and
the number of pages migrated successfully per second increases 291.7%.

Xin Hao helped to test the patchset on an ARM64 server with 128 cores,
2 NUMA nodes.  Test results show that the page migration performance
increases up to 78%.

This patch (of 9):

Define struct migrate_pages_stats to organize the various statistics in
migrate_pages().  This makes it easier to collect and consume the
statistics in multiple functions.  This will be needed in the following
patches in the series.

Link: https://lkml.kernel.org/r/20230213123444.155149-1-ying.huang@intel.com
Link: https://lkml.kernel.org/r/20230213123444.155149-2-ying.huang@intel.com
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 35e41024c4c2 ("vmscan,migrate: fix page count imbalance on node stats when demoting pages")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 60 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 81444abf54dba..b7596a0b4445f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1398,6 +1398,16 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
 	return rc;
 }
 
+struct migrate_pages_stats {
+	int nr_succeeded;	/* Normal and large folios migrated successfully, in
+				   units of base pages */
+	int nr_failed_pages;	/* Normal and large folios failed to be migrated, in
+				   units of base pages.  Untried folios aren't counted */
+	int nr_thp_succeeded;	/* THP migrated successfully */
+	int nr_thp_failed;	/* THP failed to be migrated */
+	int nr_thp_split;	/* THP split before migrating */
+};
+
 /*
  * migrate_pages - migrate the folios specified in a list, to the free folios
  *		   supplied as the target for the page migration
@@ -1432,13 +1442,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	int large_retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
-	int nr_failed_pages = 0;
 	int nr_retry_pages = 0;
-	int nr_succeeded = 0;
-	int nr_thp_succeeded = 0;
 	int nr_large_failed = 0;
-	int nr_thp_failed = 0;
-	int nr_thp_split = 0;
 	int pass = 0;
 	bool is_large = false;
 	bool is_thp = false;
@@ -1448,9 +1453,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	LIST_HEAD(split_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
 	bool no_split_folio_counting = false;
+	struct migrate_pages_stats stats;
 
 	trace_mm_migrate_pages_start(mode, reason);
 
+	memset(&stats, 0, sizeof(stats));
 split_folio_migration:
 	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
 		retry = 0;
@@ -1504,9 +1511,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				/* Large folio migration is unsupported */
 				if (is_large) {
 					nr_large_failed++;
-					nr_thp_failed += is_thp;
+					stats.nr_thp_failed += is_thp;
 					if (!try_split_folio(folio, &split_folios)) {
-						nr_thp_split += is_thp;
+						stats.nr_thp_split += is_thp;
 						break;
 					}
 				/* Hugetlb migration is unsupported */
@@ -1514,7 +1521,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_pages;
+				stats.nr_failed_pages += nr_pages;
 				list_move_tail(&folio->lru, &ret_folios);
 				break;
 			case -ENOMEM:
@@ -1524,13 +1531,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_large) {
 					nr_large_failed++;
-					nr_thp_failed += is_thp;
+					stats.nr_thp_failed += is_thp;
 					/* Large folio NUMA faulting doesn't split to retry. */
 					if (!nosplit) {
 						int ret = try_split_folio(folio, &split_folios);
 
 						if (!ret) {
-							nr_thp_split += is_thp;
+							stats.nr_thp_split += is_thp;
 							break;
 						} else if (reason == MR_LONGTERM_PIN &&
 							   ret == -EAGAIN) {
@@ -1548,7 +1555,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_pages + nr_retry_pages;
+				stats.nr_failed_pages += nr_pages + nr_retry_pages;
 				/*
 				 * There might be some split folios of fail-to-migrate large
 				 * folios left in split_folios list. Move them back to migration
@@ -1558,7 +1565,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				list_splice_init(&split_folios, from);
 				/* nr_failed isn't updated for not used */
 				nr_large_failed += large_retry;
-				nr_thp_failed += thp_retry;
+				stats.nr_thp_failed += thp_retry;
 				goto out;
 			case -EAGAIN:
 				if (is_large) {
@@ -1570,8 +1577,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				nr_retry_pages += nr_pages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
-				nr_succeeded += nr_pages;
-				nr_thp_succeeded += is_thp;
+				stats.nr_succeeded += nr_pages;
+				stats.nr_thp_succeeded += is_thp;
 				break;
 			default:
 				/*
@@ -1582,20 +1589,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 				 */
 				if (is_large) {
 					nr_large_failed++;
-					nr_thp_failed += is_thp;
+					stats.nr_thp_failed += is_thp;
 				} else if (!no_split_folio_counting) {
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_pages;
+				stats.nr_failed_pages += nr_pages;
 				break;
 			}
 		}
 	}
 	nr_failed += retry;
 	nr_large_failed += large_retry;
-	nr_thp_failed += thp_retry;
-	nr_failed_pages += nr_retry_pages;
+	stats.nr_thp_failed += thp_retry;
+	stats.nr_failed_pages += nr_retry_pages;
 	/*
 	 * Try to migrate split folios of fail-to-migrate large folios, no
 	 * nr_failed counting in this round, since all split folios of a
@@ -1628,16 +1635,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
 	if (list_empty(from))
 		rc = 0;
 
-	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
-	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
-	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
-	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
-	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
-			       nr_thp_failed, nr_thp_split, mode, reason);
+	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
+	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
+	count_vm_events(THP_MIGRATION_SUCCESS, stats.nr_thp_succeeded);
+	count_vm_events(THP_MIGRATION_FAIL, stats.nr_thp_failed);
+	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
+	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
+			       stats.nr_thp_succeeded, stats.nr_thp_failed,
+			       stats.nr_thp_split, mode, reason);
 
 	if (ret_succeeded)
-		*ret_succeeded = nr_succeeded;
+		*ret_succeeded = stats.nr_succeeded;
 
 	return rc;
 }
-- 
2.43.0




