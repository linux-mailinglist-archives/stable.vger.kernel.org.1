Return-Path: <stable+bounces-226037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M8IHr1ruWmvEQIAu9opvQ
	(envelope-from <stable+bounces-226037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F92AC7E3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 147B032C93CE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FA23E95B9;
	Tue, 17 Mar 2026 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeZVnw9x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CBD3E9296
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758585; cv=none; b=h/ZZulx3VDl+4YQRJDNGVox+Qfptr+FogkxVpQVnwoAOAlBfqAbpWtznNMRDnHHGdK6w1NJjS/gs+0kTezv6sNPOI0pQC1zq7yP2/aS6Ceinn5OatMYYRnhAnVXgzVWGsOCxkkT0H3dt8C2C1iGo/WHu57DQR2DaLN7XaFPeqpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758585; c=relaxed/simple;
	bh=E4+00j/ph5rT86L7zaZB4j9BDWHiAqTZyWSPJPAH7cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj9WbySKFk7Wuk+0b44OzXJJodOAg/uA5AnUbH5jAH/by2IUCoUHSyRtneVYctDoDnMQduf947BT0zAvoUxfi+lQUsGWlAo8lmdY9cPL39y9IKaT+slb197b7SeQigJiHkxsOkTE51liquy2waCKXlEeVPMyKhKWFw56wTUSYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeZVnw9x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9030FC19424;
	Tue, 17 Mar 2026 14:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773758585;
	bh=E4+00j/ph5rT86L7zaZB4j9BDWHiAqTZyWSPJPAH7cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aeZVnw9xWQEWFCqubX+ZVyWdOY5waXpnH79gIqMqQR1CCu9UFr4IVdeXJ1K36RYB5
	 2jZ0TCY3Gj7Qd6vOsSabAl+K9n+dRV3p3bLQpnYzAO/zW+wVJ8L6BPvS8iOYxz+rCg
	 tHSMZ6BYXSP8Z1VYSayJRokiup8C7++fPR/zQGyNg0C0mlNeI6bK0m+BMHR7hgg7tQ
	 Sm+j8LR0Hu7ZQ9sHeLzNXKDm7W2Od3P47rDOl/utFJf3ui1c4aGpcmiofmck07uJ8m
	 x+r4RN6sLI0pajHdkvsKC89RGleVsq0RxQ0mZzJSlP+wsYrXC4W8mty97Mpl8zstDT
	 zXJAfrnKdKPsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 2/3] mm/damon: rename min_sz_region of damon_ctx to min_region_sz
Date: Tue, 17 Mar 2026 10:43:01 -0400
Message-ID: <20260317144302.174364-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317144302.174364-1-sashal@kernel.org>
References: <2026031714-concept-seventh-df3c@gregkh>
 <20260317144302.174364-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226037-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 2D1F92AC7E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: SeongJae Park <sj@kernel.org>

[ Upstream commit cc1db8dff8e751ec3ab352483de366b7f23aefe2 ]

'min_sz_region' field of 'struct damon_ctx' represents the minimum size of
each DAMON region for the context.  'struct damos_access_pattern' has a
field of the same name.  It confuses readers and makes 'grep' less optimal
for them.  Rename it to 'min_region_sz'.

Link: https://lkml.kernel.org/r/20260117175256.82826-9-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: c80f46ac228b ("mm/damon/core: disallow non-power of two min_region_sz")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h |  8 ++---
 mm/damon/core.c       | 69 ++++++++++++++++++++++---------------------
 mm/damon/lru_sort.c   |  4 +--
 mm/damon/reclaim.c    |  4 +--
 mm/damon/stat.c       |  2 +-
 mm/damon/sysfs.c      |  9 +++---
 6 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index eed59ae0ec9a8..33e59d53d9f18 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -769,7 +769,7 @@ struct damon_attrs {
  *
  * @ops:	Set of monitoring operations for given use cases.
  * @addr_unit:	Scale factor for core to ops address conversion.
- * @min_sz_region:		Minimum region size.
+ * @min_region_sz:	Minimum region size.
  * @adaptive_targets:	Head of monitoring targets (&damon_target) list.
  * @schemes:		Head of schemes (&damos) list.
  */
@@ -812,7 +812,7 @@ struct damon_ctx {
 
 	struct damon_operations ops;
 	unsigned long addr_unit;
-	unsigned long min_sz_region;
+	unsigned long min_region_sz;
 
 	struct list_head adaptive_targets;
 	struct list_head schemes;
@@ -901,7 +901,7 @@ static inline void damon_insert_region(struct damon_region *r,
 void damon_add_region(struct damon_region *r, struct damon_target *t);
 void damon_destroy_region(struct damon_region *r, struct damon_target *t);
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
-		unsigned int nr_ranges, unsigned long min_sz_region);
+		unsigned int nr_ranges, unsigned long min_region_sz);
 void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
@@ -968,7 +968,7 @@ int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end,
-				unsigned long min_sz_region);
+				unsigned long min_region_sz);
 
 #endif	/* CONFIG_DAMON */
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 892bf704b3f03..04c3ffc55b705 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -197,7 +197,7 @@ static int damon_fill_regions_holes(struct damon_region *first,
  * @t:		the given target.
  * @ranges:	array of new monitoring target ranges.
  * @nr_ranges:	length of @ranges.
- * @min_sz_region:	minimum region size.
+ * @min_region_sz:	minimum region size.
  *
  * This function adds new regions to, or modify existing regions of a
  * monitoring target to fit in specific ranges.
@@ -205,7 +205,7 @@ static int damon_fill_regions_holes(struct damon_region *first,
  * Return: 0 if success, or negative error code otherwise.
  */
 int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
-		unsigned int nr_ranges, unsigned long min_sz_region)
+		unsigned int nr_ranges, unsigned long min_region_sz)
 {
 	struct damon_region *r, *next;
 	unsigned int i;
@@ -242,16 +242,16 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			/* no region intersects with this range */
 			newr = damon_new_region(
 					ALIGN_DOWN(range->start,
-						min_sz_region),
-					ALIGN(range->end, min_sz_region));
+						min_region_sz),
+					ALIGN(range->end, min_region_sz));
 			if (!newr)
 				return -ENOMEM;
 			damon_insert_region(newr, damon_prev_region(r), r, t);
 		} else {
 			/* resize intersecting regions to fit in this range */
 			first->ar.start = ALIGN_DOWN(range->start,
-					min_sz_region);
-			last->ar.end = ALIGN(range->end, min_sz_region);
+					min_region_sz);
+			last->ar.end = ALIGN(range->end, min_region_sz);
 
 			/* fill possible holes in the range */
 			err = damon_fill_regions_holes(first, last, t);
@@ -546,7 +546,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.max_nr_regions = 1000;
 
 	ctx->addr_unit = 1;
-	ctx->min_sz_region = DAMON_MIN_REGION_SZ;
+	ctx->min_region_sz = DAMON_MIN_REGION_SZ;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
@@ -1131,7 +1131,7 @@ static struct damon_target *damon_nth_target(int n, struct damon_ctx *ctx)
  * If @src has no region, @dst keeps current regions.
  */
 static int damon_commit_target_regions(struct damon_target *dst,
-		struct damon_target *src, unsigned long src_min_sz_region)
+		struct damon_target *src, unsigned long src_min_region_sz)
 {
 	struct damon_region *src_region;
 	struct damon_addr_range *ranges;
@@ -1148,7 +1148,7 @@ static int damon_commit_target_regions(struct damon_target *dst,
 	i = 0;
 	damon_for_each_region(src_region, src)
 		ranges[i++] = src_region->ar;
-	err = damon_set_regions(dst, ranges, i, src_min_sz_region);
+	err = damon_set_regions(dst, ranges, i, src_min_region_sz);
 	kfree(ranges);
 	return err;
 }
@@ -1156,11 +1156,11 @@ static int damon_commit_target_regions(struct damon_target *dst,
 static int damon_commit_target(
 		struct damon_target *dst, bool dst_has_pid,
 		struct damon_target *src, bool src_has_pid,
-		unsigned long src_min_sz_region)
+		unsigned long src_min_region_sz)
 {
 	int err;
 
-	err = damon_commit_target_regions(dst, src, src_min_sz_region);
+	err = damon_commit_target_regions(dst, src, src_min_region_sz);
 	if (err)
 		return err;
 	if (dst_has_pid)
@@ -1187,7 +1187,7 @@ static int damon_commit_targets(
 			err = damon_commit_target(
 					dst_target, damon_target_has_pid(dst),
 					src_target, damon_target_has_pid(src),
-					src->min_sz_region);
+					src->min_region_sz);
 			if (err)
 				return err;
 		} else {
@@ -1214,7 +1214,7 @@ static int damon_commit_targets(
 			return -ENOMEM;
 		err = damon_commit_target(new_target, false,
 				src_target, damon_target_has_pid(src),
-				src->min_sz_region);
+				src->min_region_sz);
 		if (err) {
 			damon_destroy_target(new_target, NULL);
 			return err;
@@ -1261,7 +1261,7 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	}
 	dst->ops = src->ops;
 	dst->addr_unit = src->addr_unit;
-	dst->min_sz_region = src->min_sz_region;
+	dst->min_region_sz = src->min_region_sz;
 
 	return 0;
 }
@@ -1294,8 +1294,8 @@ static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < ctx->min_sz_region)
-		sz = ctx->min_sz_region;
+	if (sz < ctx->min_region_sz)
+		sz = ctx->min_region_sz;
 
 	return sz;
 }
@@ -1668,7 +1668,7 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * @t:	The target of the region.
  * @rp:	The pointer to the region.
  * @s:	The scheme to be applied.
- * @min_sz_region:	minimum region size.
+ * @min_region_sz:	minimum region size.
  *
  * If a quota of a scheme has exceeded in a quota charge window, the scheme's
  * action would applied to only a part of the target access pattern fulfilling
@@ -1686,7 +1686,8 @@ static bool damos_valid_target(struct damon_ctx *c, struct damon_target *t,
  * Return: true if the region should be entirely skipped, false otherwise.
  */
 static bool damos_skip_charged_region(struct damon_target *t,
-		struct damon_region **rp, struct damos *s, unsigned long min_sz_region)
+		struct damon_region **rp, struct damos *s,
+		unsigned long min_region_sz)
 {
 	struct damon_region *r = *rp;
 	struct damos_quota *quota = &s->quota;
@@ -1708,11 +1709,11 @@ static bool damos_skip_charged_region(struct damon_target *t,
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
-					r->ar.start, min_sz_region);
+					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= min_sz_region)
+				if (damon_sz_region(r) <= min_region_sz)
 					return true;
-				sz_to_skip = min_sz_region;
+				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
 			r = damon_next_region(r);
@@ -1738,7 +1739,7 @@ static void damos_update_stat(struct damos *s,
 
 static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		struct damon_region *r, struct damos_filter *filter,
-		unsigned long min_sz_region)
+		unsigned long min_region_sz)
 {
 	bool matched = false;
 	struct damon_target *ti;
@@ -1755,8 +1756,8 @@ static bool damos_filter_match(struct damon_ctx *ctx, struct damon_target *t,
 		matched = target_idx == filter->target_idx;
 		break;
 	case DAMOS_FILTER_TYPE_ADDR:
-		start = ALIGN_DOWN(filter->addr_range.start, min_sz_region);
-		end = ALIGN_DOWN(filter->addr_range.end, min_sz_region);
+		start = ALIGN_DOWN(filter->addr_range.start, min_region_sz);
+		end = ALIGN_DOWN(filter->addr_range.end, min_region_sz);
 
 		/* inside the range */
 		if (start <= r->ar.start && r->ar.end <= end) {
@@ -1792,7 +1793,7 @@ static bool damos_filter_out(struct damon_ctx *ctx, struct damon_target *t,
 
 	s->core_filters_allowed = false;
 	damos_for_each_core_filter(filter, s) {
-		if (damos_filter_match(ctx, t, r, filter, ctx->min_sz_region)) {
+		if (damos_filter_match(ctx, t, r, filter, ctx->min_region_sz)) {
 			if (filter->allow)
 				s->core_filters_allowed = true;
 			return !filter->allow;
@@ -1927,7 +1928,7 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
 			sz = ALIGN_DOWN(quota->esz - quota->charged_sz,
-					c->min_sz_region);
+					c->min_region_sz);
 			if (!sz)
 				goto update_stat;
 			damon_split_region_at(t, r, sz);
@@ -1975,7 +1976,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (quota->esz && quota->charged_sz >= quota->esz)
 			continue;
 
-		if (damos_skip_charged_region(t, &r, s, c->min_sz_region))
+		if (damos_skip_charged_region(t, &r, s, c->min_region_sz))
 			continue;
 
 		if (!damos_valid_target(c, t, r, s))
@@ -2424,7 +2425,7 @@ static void damon_split_region_at(struct damon_target *t,
 
 /* Split every region in the given target into 'nr_subs' regions */
 static void damon_split_regions_of(struct damon_target *t, int nr_subs,
-				  unsigned long min_sz_region)
+				  unsigned long min_region_sz)
 {
 	struct damon_region *r, *next;
 	unsigned long sz_region, sz_sub = 0;
@@ -2434,13 +2435,13 @@ static void damon_split_regions_of(struct damon_target *t, int nr_subs,
 		sz_region = damon_sz_region(r);
 
 		for (i = 0; i < nr_subs - 1 &&
-				sz_region > 2 * min_sz_region; i++) {
+				sz_region > 2 * min_region_sz; i++) {
 			/*
 			 * Randomly select size of left sub-region to be at
 			 * least 10 percent and at most 90% of original region
 			 */
 			sz_sub = ALIGN_DOWN(damon_rand(1, 10) *
-					sz_region / 10, min_sz_region);
+					sz_region / 10, min_region_sz);
 			/* Do not allow blank region */
 			if (sz_sub == 0 || sz_sub >= sz_region)
 				continue;
@@ -2480,7 +2481,7 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 		nr_subregions = 3;
 
 	damon_for_each_target(t, ctx)
-		damon_split_regions_of(t, nr_subregions, ctx->min_sz_region);
+		damon_split_regions_of(t, nr_subregions, ctx->min_region_sz);
 
 	last_nr_regions = nr_regions;
 }
@@ -2850,7 +2851,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  * @t:		The monitoring target to set the region.
  * @start:	The pointer to the start address of the region.
  * @end:	The pointer to the end address of the region.
- * @min_sz_region:	Minimum region size.
+ * @min_region_sz:	Minimum region size.
  *
  * This function sets the region of @t as requested by @start and @end.  If the
  * values of @start and @end are zero, however, this function finds the biggest
@@ -2862,7 +2863,7 @@ static bool damon_find_biggest_system_ram(unsigned long *start,
  */
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 			unsigned long *start, unsigned long *end,
-			unsigned long min_sz_region)
+			unsigned long min_region_sz)
 {
 	struct damon_addr_range addr_range;
 
@@ -2875,7 +2876,7 @@ int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 
 	addr_range.start = *start;
 	addr_range.end = *end;
-	return damon_set_regions(t, &addr_range, 1, min_sz_region);
+	return damon_set_regions(t, &addr_range, 1, min_region_sz);
 }
 
 /*
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 290fcfb7685a8..9cef1619527f4 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -212,7 +212,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
+	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
@@ -243,7 +243,7 @@ static int damon_lru_sort_apply_parameters(void)
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end,
-					param_ctx->min_sz_region);
+					param_ctx->min_region_sz);
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 88e53393e3e0b..c262ec6cb5458 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -208,7 +208,7 @@ static int damon_reclaim_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
+	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
@@ -251,7 +251,7 @@ static int damon_reclaim_apply_parameters(void)
 	err = damon_set_region_biggest_system_ram_default(param_target,
 					&monitor_region_start,
 					&monitor_region_end,
-					param_ctx->min_sz_region);
+					param_ctx->min_region_sz);
 	if (err)
 		goto out;
 	err = damon_commit_ctx(ctx, param_ctx);
diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index ed8e3629d31a4..922a6a6e65dbd 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -189,7 +189,7 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 		goto free_out;
 	damon_add_target(ctx, target);
 	if (damon_set_region_biggest_system_ram_default(target, &start, &end,
-							ctx->min_sz_region))
+							ctx->min_region_sz))
 		goto free_out;
 	return ctx;
 free_out:
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e1b32472f686b..4a74c46770c06 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1365,7 +1365,7 @@ static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
 
 static int damon_sysfs_set_regions(struct damon_target *t,
 		struct damon_sysfs_regions *sysfs_regions,
-		unsigned long min_sz_region)
+		unsigned long min_region_sz)
 {
 	struct damon_addr_range *ranges = kmalloc_array(sysfs_regions->nr,
 			sizeof(*ranges), GFP_KERNEL | __GFP_NOWARN);
@@ -1387,7 +1387,7 @@ static int damon_sysfs_set_regions(struct damon_target *t,
 		if (ranges[i - 1].end > ranges[i].start)
 			goto out;
 	}
-	err = damon_set_regions(t, ranges, sysfs_regions->nr, min_sz_region);
+	err = damon_set_regions(t, ranges, sysfs_regions->nr, min_region_sz);
 out:
 	kfree(ranges);
 	return err;
@@ -1409,7 +1409,8 @@ static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
 			return -EINVAL;
 	}
 	t->obsolete = sys_target->obsolete;
-	return damon_sysfs_set_regions(t, sys_target->regions, ctx->min_sz_region);
+	return damon_sysfs_set_regions(t, sys_target->regions,
+			ctx->min_region_sz);
 }
 
 static int damon_sysfs_add_targets(struct damon_ctx *ctx,
@@ -1469,7 +1470,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	ctx->addr_unit = sys_ctx->addr_unit;
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
-		ctx->min_sz_region = max(
+		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
-- 
2.51.0


