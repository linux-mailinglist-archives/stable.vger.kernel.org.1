Return-Path: <stable+bounces-247120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKKBC2JeBWqJVgIAu9opvQ
	(envelope-from <stable+bounces-247120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:32:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579553E03A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 07:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 156EB30480AC
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 05:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDDA3559F2;
	Thu, 14 May 2026 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPZsB/FE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B6399CEE
	for <stable@vger.kernel.org>; Thu, 14 May 2026 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778736683; cv=none; b=Jq0vfnilBU6rm4t7yniWetrIxJmzxpLvXsQpv1XoelGMgPYT9M09eP12VHORtakvmuEl9f05RAc1X4U9DUYEXZQZB00Ho8uAyK459tLVHLGhN+uNwVcyTuzRSxuqITMirftLvcalIJtXth2c4gK2KKbnB4IpXKx+/P9VmEpu0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778736683; c=relaxed/simple;
	bh=JsomeIRICQlehsF0G2zNmqKM+KSdVC0iG8Ig5JaQLz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/TBmp2bo4s3mSgf34yjc902Qz3YPz3QyEGG9rh14iO2bH1UQcQdOpszOIJzF5uYkH0rigo0EX+hMFYyNv4CkZHagyVN5enodl7yncIxHbmH1YgGtfmbYcF5MGeGKGwGZSYfmXZ8wArefiS8OmoofRBXmdcfd/VqthgLRaamZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPZsB/FE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F41C2BCC6;
	Thu, 14 May 2026 05:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778736682;
	bh=JsomeIRICQlehsF0G2zNmqKM+KSdVC0iG8Ig5JaQLz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPZsB/FELoKZueJwfsfDN6UE0FT2c2wii8MPAo+dM+6Bd9k13qiZlJAuMSdz8mzjo
	 33mt2MS7YV5uTp0oKStg3JIELGNUrnzRXLWCBO2XQM5dz1CzYWv9OI96S+43zAHBui
	 PB1f4zz7puE46MzNc1ORpS6+uJb+/0c6i0ZBf2gEp5NxjX0i3Y++ehjQ5lj9fw0xka
	 dwn4VCyefzCMtzv6CItBHA4VeAqDp0BBvfGibst/D4+AVpgqnsh1AbTRoVxxT1YvU+
	 gVxiLC2Clv8QFJVwHzgOv84JApfhZbNdweas2FxFOjS/TQok/DUMp2mMsRbyIs2sgX
	 92b+XE3Oy8lQQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux-dev,
	Liew Rui Yan <aethernet65535@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y 2/2 v2] mm/damon/lru_sort: detect and use fresh enabled and kdamond_pid values
Date: Wed, 13 May 2026 22:31:13 -0700
Message-ID: <20260514053115.112102-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514052917.111980-1-sj@kernel.org>
References: <20260514052917.111980-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8579553E03A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-dev,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247120-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

DAMON_LRU_SORT updates 'enabled' and 'kdamond_pid' parameter values, which
represents the running status of its kdamond, when the user explicitly
requests start/stop of the kdamond.  The kdamond can, however, be stopped
in events other than the explicit user request in the following three
events.

1. ctx->regions_score_histogram allocation failure at beginning of the
   execution,
2. damon_commit_ctx() failure due to invalid user input, and
3. damon_commit_ctx() failure due to its internal allocation failures.

Hence, if the kdamond is stopped by the above three events, the values of
the status parameters can be stale.  Users could show the stale values and
be confused.  This is already bad, but the real consequence is worse.
DAMON_LRU_SORT avoids unnecessary damon_start() and damon_stop() calls
based on the 'enabled' parameter value.  And the update of 'enabled'
parameter value depends on the damon_start() and damon_stop() call
results.  Hence, once the kdamond has stopped by the unintentional events,
the user cannot restart the kdamond before the system reboot.  For
example, the issue can be reproduced via below steps.

    # cd /sys/module/damon_lru_sort/parameters
    #
    # # start DAMON_LRU_SORT
    # echo Y > enabled
    # ps -ef | grep kdamond
    root         806       2  0 17:53 ?        00:00:00 [kdamond.0]
    root         808     803  0 17:53 pts/4    00:00:00 grep kdamond
    #
    # # commit wrong input to stop kdamond withou explicit stop request
    # echo 3 > addr_unit
    # echo Y > commit_inputs
    bash: echo: write error: Invalid argument
    #
    # # confirm kdamond is stopped
    # ps -ef | grep kdamond
    root         811     803  0 17:53 pts/4    00:00:00 grep kdamond
    #
    # # users casn now show stable status
    # cat enabled
    Y
    # cat kdamond_pid
    806
    #
    # # even after fixing the wrong parameter,
    # # kdamond cannot be restarted.
    # echo 1 > addr_unit
    # echo Y > enabled
    # ps -ef | grep kdamond
    root         815     803  0 17:54 pts/4    00:00:00 grep kdamond

The problem will only rarely happen in real and common setups for the
following reasons.  The allocation failures are unlikely in such setups
since those allocations are arguably too small to fail.  Also sane users
on real production environments may not commit wrong input parameters.
But once it happens, the consequence is quite bad.  And the bug is a bug.

The issue stems from the fact that there are multiple events that can
change the status, and following all the events is challenging.
Dynamically detect and use the fresh status for the parameters when those
are requested.

Link: https://lore.kernel.org/20260513043039.173237-2-sj@kernel.org
Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org
Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Co-developed-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit b98b7ff6025ae82570d4915e083f0cbd8d48b3cf)
Signed-off-by: SeongJae Park <sj@kernel.org>
(port parts of 42b7491af14c ("mm/damon/core: introduce damon_call()")
and d2b5be741a50 ("mm/damon/sysfs: use DAMON core API
damon_is_running()") for damon_is_running() dependency)
Cc: Liew Rui Yan <aethernet65535@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260513043039.173237-2-sj@kernel.org
- Fixup incomplete enabled_store() part porting

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 16 +++++++++
 mm/damon/lru_sort.c   | 84 ++++++++++++++++++++++++++++---------------
 3 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7eeec0eaaf1f5..7133131433547 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -572,6 +572,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+bool damon_is_running(struct damon_ctx *ctx);
 int damon_kdamond_pid(struct damon_ctx *ctx);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fc68364c9ad2e..1c041d011b8ef 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -643,6 +643,22 @@ static bool damon_check_reset_time_interval(struct timespec64 *baseline,
 	return true;
 }
 
+/**
+ * damon_is_running() - Returns if a given DAMON context is running.
+ * @ctx:	The DAMON context to see if running.
+ *
+ * Return: true if @ctx is running, false otherwise.
+ */
+bool damon_is_running(struct damon_ctx *ctx)
+{
+	bool running;
+
+	mutex_lock(&ctx->kdamond_lock);
+	running = ctx->kdamond != NULL;
+	mutex_unlock(&ctx->kdamond_lock);
+	return running;
+}
+
 /**
  * damon_kdamond_pid() - Return pid of a given DAMON context's worker thread.
  * @ctx:	The DAMON context of the question.
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 61311800abc98..43dd27f3934d9 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -113,15 +113,6 @@ module_param(monitor_region_start, ulong, 0600);
 static unsigned long monitor_region_end __read_mostly;
 module_param(monitor_region_end, ulong, 0600);
 
-/*
- * PID of the DAMON thread
- *
- * If DAMON_LRU_SORT is enabled, this becomes the PID of the worker thread.
- * Else, -1.
- */
-static int kdamond_pid __read_mostly = -1;
-module_param(kdamond_pid, int, 0400);
-
 static struct damos_stat damon_lru_sort_hot_stat;
 DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_lru_sort_hot_stat,
 		lru_sort_tried_hot_regions, lru_sorted_hot_regions,
@@ -249,37 +240,32 @@ static int damon_lru_sort_turn(bool on)
 {
 	int err;
 
-	if (!on) {
-		err = damon_stop(&ctx, 1);
-		if (!err)
-			kdamond_pid = -1;
-		return err;
-	}
+	if (!on)
+		return damon_stop(&ctx, 1);
 
 	err = damon_lru_sort_apply_parameters();
 	if (err)
 		return err;
 
-	err = damon_start(&ctx, 1, true);
-	if (err)
-		return err;
-	kdamond_pid = ctx->kdamond->pid;
-	return 0;
+	return damon_start(&ctx, 1, true);
+}
+
+static bool damon_lru_sort_enabled(void)
+{
+	if (!ctx)
+		return false;
+	return damon_is_running(ctx);
 }
 
 static struct delayed_work damon_lru_sort_timer;
 static void damon_lru_sort_timer_fn(struct work_struct *work)
 {
-	static bool last_enabled;
 	bool now_enabled;
 
 	now_enabled = enabled;
-	if (last_enabled != now_enabled) {
-		if (!damon_lru_sort_turn(now_enabled))
-			last_enabled = now_enabled;
-		else
-			enabled = last_enabled;
-	}
+	if (damon_lru_sort_enabled() == now_enabled)
+		return;
+	damon_lru_sort_turn(now_enabled);
 }
 static DECLARE_DELAYED_WORK(damon_lru_sort_timer, damon_lru_sort_timer_fn);
 
@@ -301,15 +287,57 @@ static int damon_lru_sort_enabled_store(const char *val,
 	return 0;
 }
 
+static int damon_lru_sort_enabled_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_lru_sort_enabled() ? 'Y' : 'N');
+}
+
 static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_lru_sort_enabled_store,
-	.get = param_get_bool,
+	.get = damon_lru_sort_enabled_load,
 };
 
 module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
 	"Enable or disable DAMON_LRU_SORT (default: disabled)");
 
+static int damon_lru_sort_kdamond_pid_store(const char *val,
+		const struct kernel_param *kp)
+{
+	/*
+	 * kdamond_pid is read-only, but kernel command line could write it.
+	 * Do nothing here.
+	 */
+	return 0;
+}
+
+static int damon_lru_sort_kdamond_pid_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	int kdamond_pid = -1;
+
+	if (ctx) {
+		kdamond_pid = damon_kdamond_pid(ctx);
+		if (kdamond_pid < 0)
+			kdamond_pid = -1;
+	}
+	return sprintf(buffer, "%d\n", kdamond_pid);
+}
+
+static const struct kernel_param_ops kdamond_pid_param_ops = {
+	.set = damon_lru_sort_kdamond_pid_store,
+	.get = damon_lru_sort_kdamond_pid_load,
+};
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_LRU_SORT is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);
+
 static int damon_lru_sort_handle_commit_inputs(void)
 {
 	int err;
-- 
2.47.3


