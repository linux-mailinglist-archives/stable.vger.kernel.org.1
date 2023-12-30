Return-Path: <stable+bounces-8754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EAF8204BD
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5167D281FE6
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201279EE;
	Sat, 30 Dec 2023 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b2yBDqVi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA179DC;
	Sat, 30 Dec 2023 12:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5189AC433C8;
	Sat, 30 Dec 2023 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937676;
	bh=J8/qmqIF0UUb/NeK3Ao4ZpR76faoyNf967Qc7Cwc4FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2yBDqVi6I0RY/EUFvN4zPnu+y6xEqhqPKcRi/A+1nMaWlNZ3BCTzotebIUWW6ES3
	 8jCvcFYmxQVSIpQNfmuXcRb05KXLAfQFLLhIV9LF4odZ8WFn4MqSUr9836UMXw9bLN
	 BRHOLfDffIKZCUp7hzkaZoWWo3cPRG4pDzwZJDtI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 002/156] mm/damon/core: use number of passed access sampling as a timer
Date: Sat, 30 Dec 2023 11:57:36 +0000
Message-ID: <20231230115812.427401825@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
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

[ Upstream commit 4472edf63d6630e6cf65e205b4fc8c3c94d0afe5 ]

DAMON sleeps for sampling interval after each sampling, and check if the
aggregation interval and the ops update interval have passed using
ktime_get_coarse_ts64() and baseline timestamps for the intervals.  That
design is for making the operations occur at deterministic timing
regardless of the time that spend for each work.  However, it turned out
it is not that useful, and incur not-that-intuitive results.

After all, timer functions, and especially sleep functions that DAMON uses
to wait for specific timing, are not necessarily strictly accurate.  It is
legal design, so no problem.  However, depending on such inaccuracies, the
nr_accesses can be larger than aggregation interval divided by sampling
interval.  For example, with the default setting (5 ms sampling interval
and 100 ms aggregation interval) we frequently show regions having
nr_accesses larger than 20.  Also, if the execution of a DAMOS scheme
takes a long time, next aggregation could happen before enough number of
samples are collected.  This is not what usual users would intuitively
expect.

Since access check sampling is the smallest unit work of DAMON, using the
number of passed sampling intervals as the DAMON-internal timer can easily
avoid these problems.  That is, convert aggregation and ops update
intervals to numbers of sampling intervals that need to be passed before
those operations be executed, count the number of passed sampling
intervals, and invoke the operations as soon as the specific amount of
sampling intervals passed.  Make the change.

Note that this could make a behavioral change to settings that using
intervals that not aligned by the sampling interval.  For example, if the
sampling interval is 5 ms and the aggregation interval is 12 ms, DAMON
effectively uses 15 ms as its aggregation interval, because it checks
whether the aggregation interval after sleeping the sampling interval.
This change will make DAMON to effectively use 10 ms as aggregation
interval, since it uses 'aggregation interval / sampling interval *
sampling interval' as the effective aggregation interval, and we don't use
floating point types.  Usual users would have used aligned intervals, so
this behavioral change is not expected to make any meaningful impact, so
just make this change.

Link: https://lkml.kernel.org/r/20230914021523.60649-1-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 6376a8245956 ("mm/damon/core: make damon_start() waits until kdamond_fn() starts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h | 14 ++++++-
 mm/damon/core.c       | 96 +++++++++++++++++++++----------------------
 2 files changed, 59 insertions(+), 51 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c70cca8a839f7..506118916378b 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -522,8 +522,18 @@ struct damon_ctx {
 	struct damon_attrs attrs;
 
 /* private: internal use only */
-	struct timespec64 last_aggregation;
-	struct timespec64 last_ops_update;
+	/* number of sample intervals that passed since this context started */
+	unsigned long passed_sample_intervals;
+	/*
+	 * number of sample intervals that should be passed before next
+	 * aggregation
+	 */
+	unsigned long next_aggregation_sis;
+	/*
+	 * number of sample intervals that should be passed before next ops
+	 * update
+	 */
+	unsigned long next_ops_update_sis;
 
 /* public: */
 	struct task_struct *kdamond;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fd5be73f699f4..30c93de59475f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -427,8 +427,10 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
 
-	ktime_get_coarse_ts64(&ctx->last_aggregation);
-	ctx->last_ops_update = ctx->last_aggregation;
+	ctx->passed_sample_intervals = 0;
+	/* These will be set from kdamond_init_intervals_sis() */
+	ctx->next_aggregation_sis = 0;
+	ctx->next_ops_update_sis = 0;
 
 	mutex_init(&ctx->kdamond_lock);
 
@@ -542,6 +544,9 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
  */
 int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 {
+	unsigned long sample_interval = attrs->sample_interval ?
+		attrs->sample_interval : 1;
+
 	if (attrs->min_nr_regions < 3)
 		return -EINVAL;
 	if (attrs->min_nr_regions > attrs->max_nr_regions)
@@ -549,6 +554,11 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 	if (attrs->sample_interval > attrs->aggr_interval)
 		return -EINVAL;
 
+	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
+		attrs->aggr_interval / sample_interval;
+	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
+		attrs->ops_update_interval / sample_interval;
+
 	damon_update_monitoring_results(ctx, attrs);
 	ctx->attrs = *attrs;
 	return 0;
@@ -722,38 +732,6 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 	return err;
 }
 
-/*
- * damon_check_reset_time_interval() - Check if a time interval is elapsed.
- * @baseline:	the time to check whether the interval has elapsed since
- * @interval:	the time interval (microseconds)
- *
- * See whether the given time interval has passed since the given baseline
- * time.  If so, it also updates the baseline to current time for next check.
- *
- * Return:	true if the time interval has passed, or false otherwise.
- */
-static bool damon_check_reset_time_interval(struct timespec64 *baseline,
-		unsigned long interval)
-{
-	struct timespec64 now;
-
-	ktime_get_coarse_ts64(&now);
-	if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
-			interval * 1000)
-		return false;
-	*baseline = now;
-	return true;
-}
-
-/*
- * Check whether it is time to flush the aggregated information
- */
-static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
-{
-	return damon_check_reset_time_interval(&ctx->last_aggregation,
-			ctx->attrs.aggr_interval);
-}
-
 /*
  * Reset the aggregated monitoring results ('nr_accesses' of each region).
  */
@@ -1234,18 +1212,6 @@ static void kdamond_split_regions(struct damon_ctx *ctx)
 	last_nr_regions = nr_regions;
 }
 
-/*
- * Check whether it is time to check and apply the operations-related data
- * structures.
- *
- * Returns true if it is.
- */
-static bool kdamond_need_update_operations(struct damon_ctx *ctx)
-{
-	return damon_check_reset_time_interval(&ctx->last_ops_update,
-			ctx->attrs.ops_update_interval);
-}
-
 /*
  * Check whether current monitoring should be stopped
  *
@@ -1357,6 +1323,17 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 	return -EBUSY;
 }
 
+static void kdamond_init_intervals_sis(struct damon_ctx *ctx)
+{
+	unsigned long sample_interval = ctx->attrs.sample_interval ?
+		ctx->attrs.sample_interval : 1;
+
+	ctx->passed_sample_intervals = 0;
+	ctx->next_aggregation_sis = ctx->attrs.aggr_interval / sample_interval;
+	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
+		sample_interval;
+}
+
 /*
  * The monitoring daemon that runs as a kernel thread
  */
@@ -1370,6 +1347,8 @@ static int kdamond_fn(void *data)
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
+	kdamond_init_intervals_sis(ctx);
+
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);
 	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
@@ -1378,6 +1357,17 @@ static int kdamond_fn(void *data)
 	sz_limit = damon_region_sz_limit(ctx);
 
 	while (!kdamond_need_stop(ctx)) {
+		/*
+		 * ctx->attrs and ctx->next_{aggregation,ops_update}_sis could
+		 * be changed from after_wmarks_check() or after_aggregation()
+		 * callbacks.  Read the values here, and use those for this
+		 * iteration.  That is, damon_set_attrs() updated new values
+		 * are respected from next iteration.
+		 */
+		unsigned long next_aggregation_sis = ctx->next_aggregation_sis;
+		unsigned long next_ops_update_sis = ctx->next_ops_update_sis;
+		unsigned long sample_interval = ctx->attrs.sample_interval;
+
 		if (kdamond_wait_activation(ctx))
 			break;
 
@@ -1387,12 +1377,17 @@ static int kdamond_fn(void *data)
 				ctx->callback.after_sampling(ctx))
 			break;
 
-		kdamond_usleep(ctx->attrs.sample_interval);
+		kdamond_usleep(sample_interval);
+		ctx->passed_sample_intervals++;
 
 		if (ctx->ops.check_accesses)
 			max_nr_accesses = ctx->ops.check_accesses(ctx);
 
-		if (kdamond_aggregate_interval_passed(ctx)) {
+		sample_interval = ctx->attrs.sample_interval ?
+			ctx->attrs.sample_interval : 1;
+		if (ctx->passed_sample_intervals == next_aggregation_sis) {
+			ctx->next_aggregation_sis = next_aggregation_sis +
+				ctx->attrs.aggr_interval / sample_interval;
 			kdamond_merge_regions(ctx,
 					max_nr_accesses / 10,
 					sz_limit);
@@ -1407,7 +1402,10 @@ static int kdamond_fn(void *data)
 				ctx->ops.reset_aggregated(ctx);
 		}
 
-		if (kdamond_need_update_operations(ctx)) {
+		if (ctx->passed_sample_intervals == next_ops_update_sis) {
+			ctx->next_ops_update_sis = next_ops_update_sis +
+				ctx->attrs.ops_update_interval /
+				sample_interval;
 			if (ctx->ops.update)
 				ctx->ops.update(ctx);
 			sz_limit = damon_region_sz_limit(ctx);
-- 
2.43.0




