Return-Path: <stable+bounces-133069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0862A91B3B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6675719E4084
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9060D238164;
	Thu, 17 Apr 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HplA9+jN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E24C22B594
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744890551; cv=none; b=qsZVSO1jsXKgvzivmmtDozMF4IHJmvlPA56ZgrNWTk0QLwrxHe7lsAu92HOzzYmQCEMPd81T+FtwCh2ID+WEfCDnIO5lTsoPxV6r8GEf9seJDeDg7xdp8yhWJ4KqHGRCYBOwBVEqaKQJeMzpdsXysJ2zcYSX2jJg3zqA6OcR7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744890551; c=relaxed/simple;
	bh=+FKpn4bKUq3gbHn2Eqi9GH5n7Tf8fGfMDLMp80umXPo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WSGIJl93syr1sKqgA6lN1dRGcxJqdlzDe7x78y3bVTlg/dewOw5TYAzv2Ksl9Eo++Xgf4ZjB5mt28oqCNu2O4w5Rrlf+H1Wg5G/JuP44l8LFCXx+OQNvLhuJ2xYY7UfhVEVxH6vssxURtQ0DQthJp66+vPTMO+SwoPZPBBxM7C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HplA9+jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AB4C4CEE4;
	Thu, 17 Apr 2025 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744890551;
	bh=+FKpn4bKUq3gbHn2Eqi9GH5n7Tf8fGfMDLMp80umXPo=;
	h=Subject:To:Cc:From:Date:From;
	b=HplA9+jNlshm+/gnhyyiHIKZn0ZHxIc2T+oqdZYyu+ARPyYXWvZiHIEvGoA9ABxbP
	 /GyDju8CY+D94N6rlnTd8owk4HAYx2068Kh0tSldx7Nd59BcJAC3LghH7EO1yKMgWq
	 DEEwtirvbROixMEg7mYo7JsyBd3r9bDNVRvbgFYE=
Subject: FAILED: patch "[PATCH] mm/damon: avoid applying DAMOS action to same entity multiple" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org,usamaarif642@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:45:26 +0200
Message-ID: <2025041726-diffuser-spud-36df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 94ba17adaba0f651fdcf745c8891a88e2e028cfa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041726-diffuser-spud-36df@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94ba17adaba0f651fdcf745c8891a88e2e028cfa Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Fri, 7 Feb 2025 13:20:33 -0800
Subject: [PATCH] mm/damon: avoid applying DAMOS action to same entity multiple
 times

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

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c9074d569596..b4d37d9b9221 100644
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
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 384935ef4e65..dc8f94fe7c3b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1856,6 +1856,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		s->next_apply_sis = c->passed_sample_intervals +
 			(s->apply_interval_us ? s->apply_interval_us :
 			 c->attrs.aggr_interval) / sample_interval;
+		s->last_applied = NULL;
 	}
 }
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 2ac19ebc7076..eb10a723b0a7 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -254,6 +254,17 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
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
@@ -261,6 +272,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 	LIST_HEAD(folio_list);
 	bool install_young_filter = true;
 	struct damos_filter *filter;
+	struct folio *folio;
 
 	/* check access in page level again by default */
 	damos_for_each_filter(filter, s) {
@@ -279,9 +291,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 
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
@@ -307,6 +318,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 		damos_destroy_filter(filter);
 	applied = reclaim_pages(&folio_list);
 	cond_resched();
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -315,12 +327,12 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
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
@@ -339,6 +351,7 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -482,12 +495,12 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
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
@@ -506,6 +519,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
 	}
 	applied = damon_pa_migrate_pages(&folio_list, s->target_nid);
 	cond_resched();
+	s->last_applied = folio;
 	return applied * PAGE_SIZE;
 }
 
@@ -523,15 +537,15 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
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
@@ -541,6 +555,7 @@ static unsigned long damon_pa_stat(struct damon_region *r, struct damos *s,
 		addr += folio_size(folio);
 		folio_put(folio);
 	}
+	s->last_applied = folio;
 	return 0;
 }
 


