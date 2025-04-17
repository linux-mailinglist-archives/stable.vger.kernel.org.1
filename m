Return-Path: <stable+bounces-133583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0831FA9264C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2553F4A05B0
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132962561B3;
	Thu, 17 Apr 2025 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9Kygdzq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395A223710;
	Thu, 17 Apr 2025 18:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913513; cv=none; b=chIpEOXb4W+xuCWRQyN688p+12rL1ei/nAV+RB7hv6jeF8uy6SrYXwdWg/BjXyzT2zUcxJf42EPdL0ReSjOSKpDrAkgpNlNJdPa6l2m7h3E8s1UnTmOmpxDQrRBo1nK1Wr3sAO7cU2G1ZJOLEisfXThGgVXDvnROUKdrPdO7+Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913513; c=relaxed/simple;
	bh=G9aL5VSHB1X1rz6KiH3NcmOumCHHaZwEuoBWSvp2VbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irsohv+3RKq9gqF1oV4VTdQT4xSXp71/hWuIGUm9pMJ5Nb5InkxRGv84/v8nV29fViSFW1MgkALwney1b2JMaQ1eIoAWrmd7d1m2Vg5l6KXmgVnmcKW3nFxHkzbjzYlRVRuZIr+ULRQ/n/Yi6M31AONUKTqWSa4amGFx2asB3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S9Kygdzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3997BC4CEE7;
	Thu, 17 Apr 2025 18:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913513;
	bh=G9aL5VSHB1X1rz6KiH3NcmOumCHHaZwEuoBWSvp2VbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S9KygdzqRpRa1eyDxQ389MRnwAwwzVNh0Ur5hkRR3pgq5C/FhwMXNpDsfT89XZckM
	 Fox4YYQm9JRYk0+TesrxQtbztZ00d7IGaxt5ChqIzFa9lg6/zkLT6gE3eSDkEgUcMW
	 fuzdDgu/N+9JhyPLAI4okPccbpqrfa1coR4EjuwE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.14 357/449] mm/damon: avoid applying DAMOS action to same entity multiple times
Date: Thu, 17 Apr 2025 19:50:45 +0200
Message-ID: <20250417175132.597105727@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit 94ba17adaba0f651fdcf745c8891a88e2e028cfa upstream.

'paddr' DAMON operations set can apply a DAMOS scheme's action to a large
folio multiple times in single DAMOS-regions-walk if the folio is laid on
multiple DAMON regions.  Add a field for DAMOS scheme object that can be
used by the underlying ops to know what was the last entity that the
scheme's action has applied.  The core layer unsets the field when each
DAMOS-regions-walk is done for the given scheme.  And update 'paddr' ops
to use the infrastructure to avoid the problem.

Link: https://lkml.kernel.org/r/20250207212033.45269-3-sj@kernel.org
Fixes: 57223ac29584 ("mm/damon/paddr: support the pageout scheme")
Signed-off-by: SeongJae Park <sj@kernel.org>
Reported-by: Usama Arif <usamaarif642@gmail.com>
Closes: https://lore.kernel.org/20250203225604.44742-3-usamaarif642@gmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/damon.h |   11 +++++++++++
 mm/damon/core.c       |    1 +
 mm/damon/paddr.c      |   39 +++++++++++++++++++++++++++------------
 3 files changed, 39 insertions(+), 12 deletions(-)

--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -432,6 +432,7 @@ struct damos_access_pattern {
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @target_nid:		Destination node if @action is "migrate_{hot,cold}".
  * @filters:		Additional set of &struct damos_filter for &action.
+ * @last_applied:	Last @action applied ops-managing entity.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
  *
@@ -454,6 +455,15 @@ struct damos_access_pattern {
  * implementation could check pages of the region and skip &action to respect
  * &filters
  *
+ * The minimum entity that @action can be applied depends on the underlying
+ * &struct damon_operations.  Since it may not be aligned with the core layer
+ * abstract, namely &struct damon_region, &struct damon_operations could apply
+ * @action to same entity multiple times.  Large folios that underlying on
+ * multiple &struct damon region objects could be such examples.  The &struct
+ * damon_operations can use @last_applied to avoid that.  DAMOS core logic
+ * unsets @last_applied when each regions walking for applying the scheme is
+ * finished.
+ *
  * After applying the &action to each region, &stat_count and &stat_sz is
  * updated to reflect the number of regions and total size of regions that the
  * &action is applied.
@@ -482,6 +492,7 @@ struct damos {
 		int target_nid;
 	};
 	struct list_head filters;
+	void *last_applied;
 	struct damos_stat stat;
 	struct list_head list;
 };
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1856,6 +1856,7 @@ static void kdamond_apply_schemes(struct
 		s->next_apply_sis = c->passed_sample_intervals +
 			(s->apply_interval_us ? s->apply_interval_us :
 			 c->attrs.aggr_interval) / sample_interval;
+		s->last_applied = NULL;
 	}
 }
 
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -246,6 +246,17 @@ static bool damos_pa_filter_out(struct d
 	return false;
 }
 
+static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
+{
+	if (!folio)
+		return true;
+	if (folio == s->last_applied) {
+		folio_put(folio);
+		return true;
+	}
+	return false;
+}
+
 static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		unsigned long *sz_filter_passed)
 {
@@ -253,6 +264,7 @@ static unsigned long damon_pa_pageout(st
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
+	struct folio *folio;
 
 	/* check access in page level again by default */
 	damos_for_each_filter(filter, s) {
@@ -271,9 +283,8 @@ static unsigned long damon_pa_pageout(st
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
-
-		if (!folio) {
+		folio = damon_get_folio(PHYS_PFN(addr));
+		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -299,6 +310,7 @@ put_folio:
 		damos_destroy_filter(filter);
 	applied = reclaim_pages(&folio_list);
 	cond_resched();
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -307,12 +319,12 @@ static inline unsigned long damon_pa_mar
 		unsigned long *sz_filter_passed)
 {
 	unsigned long addr, applied = 0;
+	struct folio *folio;
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
-
-		if (!folio) {
+		folio = damon_get_folio(PHYS_PFN(addr));
+		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -331,6 +343,7 @@ put_folio:
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -474,12 +487,12 @@ static unsigned long damon_pa_migrate(st
 {
 	unsigned long addr, applied;
 	LIST_HEAD(folio_list);
+	struct folio *folio;
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
-
-		if (!folio) {
+		folio = damon_get_folio(PHYS_PFN(addr));
+		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -498,6 +511,7 @@ put_folio:
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -515,15 +529,15 @@ static unsigned long damon_pa_stat(struc
 {
 	unsigned long addr;
 	LIST_HEAD(folio_list);
+	struct folio *folio;
 
 	if (!damon_pa_scheme_has_filter(s))
 		return 0;
 
 	addr = r->ar.start;
 	while (addr < r->ar.end) {
-		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
-
-		if (!folio) {
+		folio = damon_get_folio(PHYS_PFN(addr));
+		if (damon_pa_invalid_damos_folio(folio, s)) {
 			addr += PAGE_SIZE;
 			continue;
 		}
@@ -533,6 +547,7 @@ static unsigned long damon_pa_stat(struc
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
+	s->last_applied = folio;
 	return 0;
 }
 



