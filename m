Return-Path: <stable+bounces-238612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MARRB40F5Gn+OwEAu9opvQ
	(envelope-from <stable+bounces-238612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 00:28:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FFE4226D9
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 00:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09F8230247F9
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 22:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D2235F611;
	Sat, 18 Apr 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgJulB/Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76A35F165;
	Sat, 18 Apr 2026 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776551289; cv=none; b=CCEJNQF54UqLOtK6bXROHRVLQB2hVqph9DiMKKKy++EjGOmxTv8oiLjbjUj0Qw89Ff/5bkUTXrgSW7KrF38Aodo8wZvwLh3g90G5nHqMfljZ1e/WdmZmDiVwqSSZZFZPt9GniUBjZZEWeX/P19j22eM30laWEsHR2lAxeqXIO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776551289; c=relaxed/simple;
	bh=xmi8JFCfIfNv/dt7D/wNwu1xStprbRBK6+QIpOf/ZP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGZ1ZhMUYgUWWRH3s8OIe9JULXulz7ofiI5cypc4gzosJOgS7u/gORgZXTA2/0mfyl2wWIQOzbO0LbMqEsBO5nWDr5ScFZ9LMQHfXeNd6+LdYbc5BZYvR3WUkTzHOEy7wNq9CwwNth2ql2sUmbo8SK4NAMzZpMFG1ZDMTAN3Jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgJulB/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C27C2BCB4;
	Sat, 18 Apr 2026 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776551289;
	bh=xmi8JFCfIfNv/dt7D/wNwu1xStprbRBK6+QIpOf/ZP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RgJulB/QlVPZkbcLBOsOt8Gm/b/BJl4fPldMonDkzGJyPtRLCjznipVXYgjA7rafp
	 WTAh25UctVfgM56yDu3RseKl5rv3IUHbZdIfOf9zlcKqJNU3VklpplXBkeE2XkZhjR
	 13fgU/opF9piYEEAgfAaWcPis4U1r8oJKX8uclVXa4ttFUkT1TqD5KHJQ/UG9wRcnC
	 Iw+BAdj8P/y7idK1zFeJLz1TTGKz5ZjJ3XaSVlxtsCUNm0346BlJIuB4Af3h3XllgZ
	 U52mH2rZZLQ7bKVdTU8fJfELQSnXR2b0MAeUkj3IBaQYyHy0EQppORbmzLu+ywYoUy
	 NiDJS87qrW8nQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Liew Rui Yan <aethernet65535@gmail.com>
Subject: [RFC PATCH v2.1 1/3] mm/damon/reclaim: detect and use fresh enabled and kdamond_pid values
Date: Sat, 18 Apr 2026 15:27:54 -0700
Message-ID: <20260418222758.39795-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418222758.39795-1-sj@kernel.org>
References: <20260418222758.39795-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux-foundation.org,lists.linux.dev,kvack.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238612-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1FFE4226D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_RECLAIM updates 'enabled' and 'kdamond_pid' parameter values,
which represents the running status of its kdamond, when the user
explicitly requests start/stop of the kdamond.  The kdamond can,
however, be stopped in events other than the explicit user request in
the following three events.

1. ctx->regions_score_histogram allocation failure at beginning of the
   execution,
2. damon_commit_ctx() failure due to invalid user input, and
3. damon_commit_ctx() failure due to its internal allocation failures.

Hence, if the kdamond is stopped by the above three events, the values
of the status parameters can be stale.  Users could show the stale
values and be confused.  This is already bad, but the real consequence
is worse.  DAMON_RECLAIM avoids unnecessary damon_start() and
damon_stop() calls based on the 'enabled' parameter value.  And the
update of 'enabled' parameter value depends on the damon_start() and
damon_stop() call results.  Hence, once the kdamond has stopped by the
unintentional events, the user cannot restart the kdamond before the
system reboot.  For example, the issue can be reproduced via below
steps.

    # cd /sys/module/damon_reclaim/parameters
    #
    # # start DAMON_RECLAIM
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
But once it happens, the consequence is quite bad.  And the bug is a
bug.

The issue stems from the fact that there are multiple events that can
change the status, and following all the events is challenging.
Dynamically detect and use the fresh status for the parameters when
those are requested.

Fixes: e035c280f6df ("mm/damon/reclaim: support online inputs update")
Cc: <stable@vger.kernel.org> # 5.19.x
Co-developed-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 85 ++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 86da147786583..fe7fce26cf6ce 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -144,15 +144,6 @@ static unsigned long addr_unit __read_mostly = 1;
 static bool skip_anon __read_mostly;
 module_param(skip_anon, bool, 0600);
 
-/*
- * PID of the DAMON thread
- *
- * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
- * Else, -1.
- */
-static int kdamond_pid __read_mostly = -1;
-module_param(kdamond_pid, int, 0400);
-
 static struct damos_stat damon_reclaim_stat;
 DEFINE_DAMON_MODULES_DAMOS_STATS_PARAMS(damon_reclaim_stat,
 		reclaim_tried_regions, reclaimed_regions, quota_exceeds);
@@ -288,12 +279,8 @@ static int damon_reclaim_turn(bool on)
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
 
 	err = damon_reclaim_apply_parameters();
 	if (err)
@@ -302,9 +289,6 @@ static int damon_reclaim_turn(bool on)
 	err = damon_start(&ctx, 1, true);
 	if (err)
 		return err;
-	kdamond_pid = damon_kdamond_pid(ctx);
-	if (kdamond_pid < 0)
-		return kdamond_pid;
 	return damon_call(ctx, &call_control);
 }
 
@@ -332,42 +316,83 @@ module_param_cb(addr_unit, &addr_unit_param_ops, &addr_unit, 0600);
 MODULE_PARM_DESC(addr_unit,
 	"Scale factor for DAMON_RECLAIM to ops address conversion (default: 1)");
 
+static bool damon_reclaim_enabled(void)
+{
+	if (!ctx)
+		return false;
+	return damon_is_running(ctx);
+}
+
 static int damon_reclaim_enabled_store(const char *val,
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
+	if (damon_reclaim_enabled() == enabled)
 		return 0;
 
 	/* Called before init function.  The function will handle this. */
 	if (!damon_initialized())
-		goto set_param_out;
+		return 0;
 
-	err = damon_reclaim_turn(enable);
-	if (err)
-		return err;
+	return damon_reclaim_turn(enabled);
+}
 
-set_param_out:
-	enabled = enable;
-	return err;
+static int damon_reclaim_enabled_load(char *buffer,
+		const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_reclaim_enabled() ? 'Y' : 'N');
 }
 
 static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_reclaim_enabled_store,
-	.get = param_get_bool,
+	.get = damon_reclaim_enabled_load,
 };
 
 module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
 MODULE_PARM_DESC(enabled,
 	"Enable or disable DAMON_RECLAIM (default: disabled)");
 
+static int damon_reclaim_kdamond_pid_store(const char *val,
+		const struct kernel_param *kp)
+{
+	/*
+	 * kdamond_pid is read-only, but kernel command line could write it.
+	 * Do nothing here.
+	 */
+	return 0;
+}
+
+static int damon_reclaim_kdamond_pid_load(char *buffer,
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
+	.set = damon_reclaim_kdamond_pid_store,
+	.get = damon_reclaim_kdamond_pid_load,
+};
+
+/*
+ * PID of the DAMON thread
+ *
+ * If DAMON_RECLAIM is enabled, this becomes the PID of the worker thread.
+ * Else, -1.
+ */
+module_param_cb(kdamond_pid, &kdamond_pid_param_ops, NULL, 0400);
+
 static int __init damon_reclaim_init(void)
 {
 	int err;
-- 
2.47.3

