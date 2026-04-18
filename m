Return-Path: <stable+bounces-238614-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEMVFbUF5Gn+OwEAu9opvQ
	(envelope-from <stable+bounces-238614-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 00:29:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAF4226EE
	for <lists+stable@lfdr.de>; Sun, 19 Apr 2026 00:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B7343039892
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF4363C48;
	Sat, 18 Apr 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgzeQhsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E48B362153;
	Sat, 18 Apr 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776551290; cv=none; b=R48mwInrKRuHvhb+Zb7mK88gFCpi9Y+AOqPhVCrMNZDHYvOYfSPZzkiucxsFdMEIO3vnOVi8xQxMf9BoTYxfoMINoNN8utv7ZPwFCJG43yKPw+m6nCCr1RkVzy0iiDNBRbBT8uIUMyoNZ2SZhgGBXj2P39dgdV3ALE3Cequ8nO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776551290; c=relaxed/simple;
	bh=rIOaDq/KHXQ6SzD1AFFL4LR91YKZhChannZeLdJ236k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2AlRKxWy+UbtdmwrRkZBKV4hledpg8DuOJwiPDU54VcdzlRc88FjPbic/E7awEFMn2rNGm4Q0jgFawHo9j6NXhF5j+S1zQsJ+lu0rARgOK1KzooU9YVQN9B/cimekBqtTNN8CThCT9R092Th4FFVx0NxBeob7ijQhGyA0E86+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgzeQhsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F1CC2BCB4;
	Sat, 18 Apr 2026 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776551290;
	bh=rIOaDq/KHXQ6SzD1AFFL4LR91YKZhChannZeLdJ236k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgzeQhsgwKIuFRBvvHZolXJF/06P/JDgwT3aJST88LE7fcVv1eKQYKncqNr42bhml
	 BzOIp00zv3NQHb210ksIQY/TPGaI24eFwHZ32uV3AHjUk1wK/D5Lm24Z89IM1SRAs/
	 /Brp8h71+ItRBHnFgTikuflLqQq9EahrkX3n8lYWwKSsU5yJ25gNTkf/Y1zqD5Q4Tf
	 1YSk5fPdFKOgdIrD5GlvrEGzFaKS+goYxdhxKY7kryG0f6csSaFV8ikL7Uu1WTul9Z
	 6CDnHzdqd4FNNk2truBk0SZ51xS8k76kxVde4aA8WRPvAGqOCvRduXoeNr6CuyagBW
	 adXiCi1qWjpTQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 3/3] mm/damon/stat: detect and use fresh enabled value
Date: Sat, 18 Apr 2026 15:27:56 -0700
Message-ID: <20260418222758.39795-4-sj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-238614-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1AAF4226EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON_STAT updates 'enabled' parameter value, which represents the
running status of its kdamond, when the user explicitly requests
start/stop of the kdamond.  The kdamond can, however, be stopped even if
the user explicitly requested the stop, if ctx->regions_score_histogram
allocation failure at beginning of the execution of the kdamond.  Hence,
if the kdamond is stopped by the allocation failure, the value of the
parameter can be stale.

Users could show the stale value and be confused.  The problem will only
rarely happen in real and common setups because the allocation is
arguably too small to fail.  Also, unlike the similar bugs that are now
fixed in DAMON_RECLAIM and DAMON_LRU_SORT, kdamond can be restarted in
this case, because DAMON_STAT force-updates the enabled parameter value
for user inputs.  The bug is a bug, though.

The issue stems from the fact that there are multiple events that can
change the status, and following all the events is challenging.
Dynamically detect and use the fresh status for the parameters when
those are requested.

The issue was dicovered [1] by Sashiko.

[1] https://lore.kernel.org/20260416040602.88665-1-sj@kernel.org

Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 99ba346f9e325..3951b762cbddf 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -19,14 +19,17 @@
 static int damon_stat_enabled_store(
 		const char *val, const struct kernel_param *kp);
 
+static int damon_stat_enabled_load(char *buffer,
+		const struct kernel_param *kp);
+
 static const struct kernel_param_ops enabled_param_ops = {
 	.set = damon_stat_enabled_store,
-	.get = param_get_bool,
+	.get = damon_stat_enabled_load,
 };
 
 static bool enabled __read_mostly = IS_ENABLED(
 	CONFIG_DAMON_STAT_ENABLED_DEFAULT);
-module_param_cb(enabled, &enabled_param_ops, &enabled, 0600);
+module_param_cb(enabled, &enabled_param_ops, NULL, 0600);
 MODULE_PARM_DESC(enabled, "Enable of disable DAMON_STAT");
 
 static unsigned long estimated_memory_bandwidth __read_mostly;
@@ -273,17 +276,23 @@ static void damon_stat_stop(void)
 	damon_stat_context = NULL;
 }
 
+static bool damon_stat_enabled(void)
+{
+	if (!damon_stat_context)
+		return false;
+	return damon_is_running(damon_stat_context);
+}
+
 static int damon_stat_enabled_store(
 		const char *val, const struct kernel_param *kp)
 {
-	bool is_enabled = enabled;
 	int err;
 
 	err = kstrtobool(val, &enabled);
 	if (err)
 		return err;
 
-	if (is_enabled == enabled)
+	if (damon_stat_enabled() == enabled)
 		return 0;
 
 	if (!damon_initialized())
@@ -293,16 +302,17 @@ static int damon_stat_enabled_store(
 		 */
 		return 0;
 
-	if (enabled) {
-		err = damon_stat_start();
-		if (err)
-			enabled = false;
-		return err;
-	}
+	if (enabled)
+		return damon_stat_start();
 	damon_stat_stop();
 	return 0;
 }
 
+static int damon_stat_enabled_load(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n", damon_stat_enabled() ? 'Y' : 'N');
+}
+
 static int __init damon_stat_init(void)
 {
 	int err = 0;
-- 
2.47.3

