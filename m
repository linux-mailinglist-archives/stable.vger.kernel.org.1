Return-Path: <stable+bounces-94273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D818A9D3C38
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7407B249E5
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A91C8773;
	Wed, 20 Nov 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CTzZ4OZH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EC61A7AF5;
	Wed, 20 Nov 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107605; cv=none; b=OLe5vXbfTetZZyHDO0MhgVlq/djvRhRH+jMUOyVpJRJdAGHKI2NnqGRaGds7NyMLh5HicZxyl+2yoaQA3/ZmSpSe8qjOLquNvOfeHvxlPfg9JsfnqIcwa7NaBuqCbj0+S0aGWJjfzY8a+4l4YgRV4DAY1/Ai5dLO6nmFwJlpnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107605; c=relaxed/simple;
	bh=aiwHG1yj2pTiAsnnUhfQAoI6E+9jVFjm8niCFEziHaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcvMDpJ57dNNQObvV1Qxuur5qTTu12f+NbmR/8r7RxEK7dStKxW+ofymdV2Gakx+9pk57k5cI3j8dxOwh6ANCcdgXgye79XVRKDT0Vrcu6FtyTksiPGCFWGAK/O/vs2DaRYNTLuzeF1JAablqxTZLV32G5Sep/isnD3dytib3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CTzZ4OZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94F3C4CECD;
	Wed, 20 Nov 2024 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107604;
	bh=aiwHG1yj2pTiAsnnUhfQAoI6E+9jVFjm8niCFEziHaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTzZ4OZHtzr62bdwZXrDT+ADgUd0KgzAonTdz9jjZh/wb1ByN4osCDM6sbHQvLBgX
	 tHM4CFuAG5rHyhbv45DJqsOGs+2oWj+T+3WnGvBXofvXD7LFHz62Pg5FRfUh1Ko037
	 7nRB1lfdL0s+lO9x6jsJ1CqbRueC8f9o5LuW+az8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 55/82] mm/damon/core: implement scheme-specific apply interval
Date: Wed, 20 Nov 2024 13:57:05 +0100
Message-ID: <20241120125630.852360284@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
References: <20241120125629.623666563@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 42f994b71404b17abcd6b170de7a6aa95ffe5d4a ]

DAMON-based operation schemes are applied for every aggregation interval.
That was mainly because schemes were using nr_accesses, which be complete
to be used for every aggregation interval.  However, the schemes are now
using nr_accesses_bp, which is updated for each sampling interval in a way
that reasonable to be used.  Therefore, there is no reason to apply
schemes for each aggregation interval.

The unnecessary alignment with aggregation interval was also making some
use cases of DAMOS tricky.  Quotas setting under long aggregation interval
is one such example.  Suppose the aggregation interval is ten seconds, and
there is a scheme having CPU quota 100ms per 1s.  The scheme will actually
uses 100ms per ten seconds, since it cannobe be applied before next
aggregation interval.  The feature is working as intended, but the results
might not that intuitive for some users.  This could be fixed by updating
the quota to 1s per 10s.  But, in the case, the CPU usage of DAMOS could
look like spikes, and would actually make a bad effect to other
CPU-sensitive workloads.

Implement a dedicated timing interval for each DAMON-based operation
scheme, namely apply_interval.  The interval will be sampling interval
aligned, and each scheme will be applied for its apply_interval.  The
interval is set to 0 by default, and it means the scheme should use the
aggregation interval instead.  This avoids old users getting any
behavioral difference.

Link: https://lkml.kernel.org/r/20230916020945.47296-5-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3488af097044 ("mm/damon/core: handle zero {aggregation,ops_update} intervals")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h    | 17 ++++++++--
 mm/damon/core.c          | 72 ++++++++++++++++++++++++++++++++++++----
 mm/damon/dbgfs.c         |  3 +-
 mm/damon/lru_sort.c      |  2 ++
 mm/damon/reclaim.c       |  2 ++
 mm/damon/sysfs-schemes.c |  2 +-
 6 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index a953d7083cd59..343132a146cf0 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -298,16 +298,19 @@ struct damos_access_pattern {
  * struct damos - Represents a Data Access Monitoring-based Operation Scheme.
  * @pattern:		Access pattern of target regions.
  * @action:		&damo_action to be applied to the target regions.
+ * @apply_interval_us:	The time between applying the @action.
  * @quota:		Control the aggressiveness of this scheme.
  * @wmarks:		Watermarks for automated (in)activation of this scheme.
  * @filters:		Additional set of &struct damos_filter for &action.
  * @stat:		Statistics of this scheme.
  * @list:		List head for siblings.
  *
- * For each aggregation interval, DAMON finds regions which fit in the
+ * For each @apply_interval_us, DAMON finds regions which fit in the
  * &pattern and applies &action to those. To avoid consuming too much
  * CPU time or IO resources for the &action, &quota is used.
  *
+ * If @apply_interval_us is zero, &damon_attrs->aggr_interval is used instead.
+ *
  * To do the work only when needed, schemes can be activated for specific
  * system situations using &wmarks.  If all schemes that registered to the
  * monitoring context are inactive, DAMON stops monitoring either, and just
@@ -327,6 +330,14 @@ struct damos_access_pattern {
 struct damos {
 	struct damos_access_pattern pattern;
 	enum damos_action action;
+	unsigned long apply_interval_us;
+/* private: internal use only */
+	/*
+	 * number of sample intervals that should be passed before applying
+	 * @action
+	 */
+	unsigned long next_apply_sis;
+/* public: */
 	struct damos_quota quota;
 	struct damos_watermarks wmarks;
 	struct list_head filters;
@@ -627,7 +638,9 @@ void damos_add_filter(struct damos *s, struct damos_filter *f);
 void damos_destroy_filter(struct damos_filter *f);
 
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
-			enum damos_action action, struct damos_quota *quota,
+			enum damos_action action,
+			unsigned long apply_interval_us,
+			struct damos_quota *quota,
 			struct damos_watermarks *wmarks);
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ae55f20835b06..a29390fd55935 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -312,7 +312,9 @@ static struct damos_quota *damos_quota_init_priv(struct damos_quota *quota)
 }
 
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
-			enum damos_action action, struct damos_quota *quota,
+			enum damos_action action,
+			unsigned long apply_interval_us,
+			struct damos_quota *quota,
 			struct damos_watermarks *wmarks)
 {
 	struct damos *scheme;
@@ -322,6 +324,13 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 		return NULL;
 	scheme->pattern = *pattern;
 	scheme->action = action;
+	scheme->apply_interval_us = apply_interval_us;
+	/*
+	 * next_apply_sis will be set when kdamond starts.  While kdamond is
+	 * running, it will also updated when it is added to the DAMON context,
+	 * or damon_attrs are updated.
+	 */
+	scheme->next_apply_sis = 0;
 	INIT_LIST_HEAD(&scheme->filters);
 	scheme->stat = (struct damos_stat){};
 	INIT_LIST_HEAD(&scheme->list);
@@ -334,9 +343,21 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	return scheme;
 }
 
+static void damos_set_next_apply_sis(struct damos *s, struct damon_ctx *ctx)
+{
+	unsigned long sample_interval = ctx->attrs.sample_interval ?
+		ctx->attrs.sample_interval : 1;
+	unsigned long apply_interval = s->apply_interval_us ?
+		s->apply_interval_us : ctx->attrs.aggr_interval;
+
+	s->next_apply_sis = ctx->passed_sample_intervals +
+		apply_interval / sample_interval;
+}
+
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s)
 {
 	list_add_tail(&s->list, &ctx->schemes);
+	damos_set_next_apply_sis(s, ctx);
 }
 
 static void damon_del_scheme(struct damos *s)
@@ -548,6 +569,7 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 {
 	unsigned long sample_interval = attrs->sample_interval ?
 		attrs->sample_interval : 1;
+	struct damos *s;
 
 	if (attrs->min_nr_regions < 3)
 		return -EINVAL;
@@ -563,6 +585,10 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 
 	damon_update_monitoring_results(ctx, attrs);
 	ctx->attrs = *attrs;
+
+	damon_for_each_scheme(s, ctx)
+		damos_set_next_apply_sis(s, ctx);
+
 	return 0;
 }
 
@@ -1055,14 +1081,29 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	struct damon_target *t;
 	struct damon_region *r, *next_r;
 	struct damos *s;
+	unsigned long sample_interval = c->attrs.sample_interval ?
+		c->attrs.sample_interval : 1;
+	bool has_schemes_to_apply = false;
 
 	damon_for_each_scheme(s, c) {
+		if (c->passed_sample_intervals != s->next_apply_sis)
+			continue;
+
+		s->next_apply_sis +=
+			(s->apply_interval_us ? s->apply_interval_us :
+			 c->attrs.aggr_interval) / sample_interval;
+
 		if (!s->wmarks.activated)
 			continue;
 
+		has_schemes_to_apply = true;
+
 		damos_adjust_quota(c, s);
 	}
 
+	if (!has_schemes_to_apply)
+		return;
+
 	damon_for_each_target(t, c) {
 		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
@@ -1348,11 +1389,19 @@ static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
 {
 	unsigned long sample_interval = ctx->attrs.sample_interval ?
 		ctx->attrs.sample_interval : 1;
+	unsigned long apply_interval;
+	struct damos *scheme;
 
 	ctx->passed_sample_intervals = 0;
 	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
 		sample_interval;
+
+	damon_for_each_scheme(scheme, ctx) {
+		apply_interval = scheme->apply_interval_us ?
+			scheme->apply_interval_us : ctx->attrs.aggr_interval;
+		scheme->next_apply_sis = apply_interval / sample_interval;
+	}
 }
 
 /*
@@ -1405,19 +1454,28 @@ static int kdamond_fn(void *data)
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-		sample_interval = ctx->attrs.sample_interval ?
-			ctx->attrs.sample_interval : 1;
 		if (ctx->passed_sample_intervals == next_aggregation_sis) {
-			ctx->next_aggregation_sis = next_aggregation_sis +
-				ctx->attrs.aggr_interval / sample_interval;
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
 			if (ctx->callback.after_aggregation &&
 					ctx->callback.after_aggregation(ctx))
 				break;
-			if (!list_empty(&ctx->schemes))
-				kdamond_apply_schemes(ctx);
+		}
+
+		/*
+		 * do kdamond_apply_schemes() after kdamond_merge_regions() if
+		 * possible, to reduce overhead
+		 */
+		if (!list_empty(&ctx->schemes))
+			kdamond_apply_schemes(ctx);
+
+		sample_interval = ctx->attrs.sample_interval ?
+			ctx->attrs.sample_interval : 1;
+		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+			ctx->next_aggregation_sis = next_aggregation_sis +
+				ctx->attrs.aggr_interval / sample_interval;
+
 			kdamond_reset_aggregated(ctx);
 			kdamond_split_regions(ctx);
 			if (ctx->ops.reset_aggregated)
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 124f0f8c97b75..dc0ea1fc30ca5 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -278,7 +278,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 			goto fail;
 
 		pos += parsed;
-		scheme = damon_new_scheme(&pattern, action, &quota, &wmarks);
+		scheme = damon_new_scheme(&pattern, action, 0, &quota,
+				&wmarks);
 		if (!scheme)
 			goto fail;
 
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index e84495ab92cf3..3de2916a65c38 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -158,6 +158,8 @@ static struct damos *damon_lru_sort_new_scheme(
 			pattern,
 			/* (de)prioritize on LRU-lists */
 			action,
+			/* for each aggregation interval */
+			0,
 			/* under the quota. */
 			&quota,
 			/* (De)activate this according to the watermarks. */
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index eca9d000ecc53..66e190f0374ac 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -142,6 +142,8 @@ static struct damos *damon_reclaim_new_scheme(void)
 			&pattern,
 			/* page out those, as soon as found */
 			DAMOS_PAGEOUT,
+			/* for each aggregation interval */
+			0,
 			/* under the quota. */
 			&damon_reclaim_quota,
 			/* (De)activate this according to the watermarks. */
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 36dcd881a19c0..26c948f87489e 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1613,7 +1613,7 @@ static struct damos *damon_sysfs_mk_scheme(
 		.low = sysfs_wmarks->low,
 	};
 
-	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, &quota,
+	scheme = damon_new_scheme(&pattern, sysfs_scheme->action, 0, &quota,
 			&wmarks);
 	if (!scheme)
 		return NULL;
-- 
2.43.0




