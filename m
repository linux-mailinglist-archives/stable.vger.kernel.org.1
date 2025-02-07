Return-Path: <stable+bounces-114311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79676A2CEEF
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0889916C7BD
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CBF1BCA0A;
	Fri,  7 Feb 2025 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsdU3gjN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A01B87C8;
	Fri,  7 Feb 2025 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963241; cv=none; b=VTcxT11FeOopChUF9aa8W6SC7u9651Jcl6kGk2J7Wn8TW3U+5xu/OzX+szxkwaaKeMBQ//RB8ikMboGY5bsm0uiXZex2XwU2OUai9Zh5HqqGlptUx3zZi1JETafUc8eAnDZ6UQzz46tvVuvORsGybQewR9A1ozFj9WiubxYkS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963241; c=relaxed/simple;
	bh=fyST1HHL6q047gB18uKbWH4029DtMjp2p7R3Opvgd7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCsQj0sYVgOtDP/OOFW1ylkPEMfEHOfc9Afp3LoxtTbwNrJW9SG00vGVSsc7Gyd6DGSZ98J9lbAnhpx4kjgoPoa1WSe+EBl1lJBomtDIppfs+OO26eplOJOqgUnMZmp0H4F5yosiElLL9OWvxpljgpcy1oY3pk6nU6AUG1MaMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsdU3gjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B9DC4CEE4;
	Fri,  7 Feb 2025 21:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738963241;
	bh=fyST1HHL6q047gB18uKbWH4029DtMjp2p7R3Opvgd7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fsdU3gjNMTuUnmQTkW1xAAT5TFFwXAoonivQvChRLfq+mJd3OPoHqQzNm5fBtIriI
	 iTVfvestb/Xi8dhUqc8z7FMr/r1QkgUzUzSYpu19+ZmlsgvIEYsTExs65tzSFrKZl9
	 9bjYO2ZMXgaM0pmvOTHYHHVorxI6I5mowQSrhWPp8RacrQNqfWzQJOMmeZ4fpIObjv
	 qKFPX9PYmbBPqAIWdJ0RU/QB4FJ3RYQAEngzGmiIjb3hfd7cljcRFbxhaUj79y2GJN
	 X0U2soxDxFlnIXTIDyZ4KVpuivdhVUkYx8xtwE26faz03XyNC0Q14yKHywgwwbpbiH
	 /HwVAArSqXyTg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mm/damon: avoid applying DAMOS action to same entity multiple times
Date: Fri,  7 Feb 2025 13:20:33 -0800
Message-Id: <20250207212033.45269-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207212033.45269-1-sj@kernel.org>
References: <20250207212033.45269-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'paddr' DAMON operations set can apply a DAMOS scheme's action to a
large folio multiple times in single DAMOS-regions-walk if the folio is
laid on multiple DAMON regions.  Add a field for DAMOS scheme object
that can be used by the underlying ops to know what was the last entity
that the scheme's action has applied.  The core layer unsets the field
when each DAMOS-regions-walk is done for the given scheme.  And update
'paddr' ops to use the infrastructure to avoid the problem.

Fixes: 57223ac29584 ("mm/damon/paddr: support the pageout scheme")
Cc: <stable@vger.kernel.org>
Reported-by: Usama Arif <usamaarif642@gmail.com>
Closes: https://lore.kernel.org/20250203225604.44742-3-usamaarif642@gmail.com
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 11 +++++++++++
 mm/damon/core.c       |  1 +
 mm/damon/paddr.c      | 39 +++++++++++++++++++++++++++------------
 3 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index af525252b853..a390af84cf0f 100644
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
@@ -477,6 +487,7 @@ struct damos {
 		int target_nid;
 	};
 	struct list_head filters;
+	void *last_applied;
 	struct damos_stat stat;
 	struct list_head list;
 };
diff --git a/mm/damon/core.c b/mm/damon/core.c
index c7b981308862..1a4dd644949b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1851,6 +1851,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		s->next_apply_sis = c->passed_sample_intervals +
 			(s->apply_interval_us ? s->apply_interval_us :
 			 c->attrs.aggr_interval) / sample_interval;
+		s->last_applied = NULL;
 	}
 }
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 0fb61f6ddb8d..d64c6fe28667 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -243,6 +243,17 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
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
@@ -250,6 +261,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
+	struct folio *folio;
 
 	/* check access in page level again by default */
 	damos_for_each_filter(filter, s) {
@@ -268,9 +280,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 
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
@@ -296,6 +307,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		damos_destroy_filter(filter);
 	applied = reclaim_pages(&folio_list);
 	cond_resched();
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -304,12 +316,12 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
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
@@ -328,6 +340,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -471,12 +484,12 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
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
@@ -495,6 +508,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -512,15 +526,15 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
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
@@ -530,6 +544,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
+	s->last_applied = folio;
 	return 0;
 }
 
-- 
2.39.5

