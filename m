Return-Path: <stable+bounces-245690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHIJG2U8A2oq2AEAu9opvQ
	(envelope-from <stable+bounces-245690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:42:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF37522C93
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D71C130E8D1B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8060E3998BE;
	Tue, 12 May 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k/0TNj0r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E423D290
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594750; cv=none; b=h/G+Jr4V6A7KhKXkYNGCNT8NlJIUYbwt88vwZAQwfZfEUwMe7LA96ZIFO9GO2oldbxXTrL7FxieTL72YxsqJNRLdy30lle1QjlobR/2aq4x5iqIiTVnMQoKrNpVD7mqGrC3VTVtazOqjkmmjrB3s75X405AbHBOGr/vLjwKUbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594750; c=relaxed/simple;
	bh=AvTnIOMUU3DX2j1M/sqyVT4b7KNoj+r5n3/05Fsivew=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TINLwXxQaMEqKSmTpmv8q1DYgEN1WVxH+98F7lnG7iJvspZ8UowJVN9svSbv/78gprOH89JLT+CM2Kv/1Wk8NWwZMA1nj8X+8GWUdE4ypE0fgn2ERBWT0Qp5yzmoaeW9zhlCJFLkXiOLV0wcjOpjYmaqKWN0bfZnz/mJyNup38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k/0TNj0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6554C2BCB0;
	Tue, 12 May 2026 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594750;
	bh=AvTnIOMUU3DX2j1M/sqyVT4b7KNoj+r5n3/05Fsivew=;
	h=Subject:To:Cc:From:Date:From;
	b=k/0TNj0rxCcSctLCvKKTT53z1OCYQI2g30jnThtjNZCgto2MY9oqA4Jg+RsJiE7OB
	 SXiu7g7RLHhn4EvGiJPSja7nyZuCto3M1zxHp/1BMt29qgDfLCXQX/c6mwsoWWWkdj
	 rJcf+6BK/fSlRGDv9KQ/6FlaqJNYhhHhby0bjDCo=
Subject: FAILED: patch "[PATCH] mm/damon/lru_sort: detect and use fresh enabled and" failed to apply to 6.1-stable tree
To: sj@kernel.org,aethernet65535@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:05:43 +0200
Message-ID: <2026051243-crevice-spool-75d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6BF37522C93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245690-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux-foundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,gregkh:email,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b98b7ff6025ae82570d4915e083f0cbd8d48b3cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051243-crevice-spool-75d8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b98b7ff6025ae82570d4915e083f0cbd8d48b3cf Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sun, 19 Apr 2026 09:10:01 -0700
Subject: [PATCH] mm/damon/lru_sort: detect and use fresh enabled and
 kdamond_pid values

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

Link: https://lore.kernel.org/20260419161003.79176-3-sj@kernel.org
Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Co-developed-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 554559d72976..8494040b1ee4 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -161,15 +161,6 @@ module_param(monitor_region_end, ulong, 0600);
  */
 static unsigned long addr_unit __read_mostly = 1;
 
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
@@ -386,12 +377,8 @@ static int damon_lru_sort_turn(bool on)
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
@@ -400,9 +387,6 @@ static int damon_lru_sort_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	kdamond_pid = damon_kdamond_pid(ctx);
-	if (kdamond_pid < 0)
-		return kdamond_pid;
 	return damon_call(ctx, &call_control);
 }
 
@@ -430,42 +414,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
 MODULE_PARM_DESC(addr_unit,
 	"Scale factor for DAMON_LRU_SORT to ops address conversion (default: 1)");
 
+static bool damon_lru_sort_enabled(void)
+{
+	if (!ctx)
+		return false;
+	return damon_is_running(ctx);
+}
+
 static int damon_lru_sort_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
-	bool is_enabled = enabled;
-	bool enable;
 	int err;
 
-	err = kstrtobool(val, &enable);
+	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (is_enabled == enable)
+	if (damon_lru_sort_enabled() == enabled)
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
 	if (!damon_initialized())
-		goto set_param_out;
+		return 0;
 
-	err = damon_lru_sort_turn(enable);
-	if (err)
-		return err;
+	return damon_lru_sort_turn(enabled);
+}
 
-set_param_out:
-	enabled = enable;
-	return err;
+static int damon_lru_sort_enabled_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_lru_sort_enabled() ? 'Y' : 'N');
 }
 
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
 static int __init damon_lru_sort_init(void)
 {
 	int err;


