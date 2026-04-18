Return-Path: <stable+bounces-238538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGtGICLi4mkU/wAAu9opvQ
	(envelope-from <stable+bounces-238538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:45:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293141FA19
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051BE3078D0D
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 01:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC3E2C11E3;
	Sat, 18 Apr 2026 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL4dJZHW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D72BEC52;
	Sat, 18 Apr 2026 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776476684; cv=none; b=EAfSldaqdZuhG9edf9YeknHLSNXfabsqwMABRLKarL+pyHWanmxhS4zznz7zeaH/zr27BFJ/hulhGi0a6U6P4s70Wxp/50wJKV5wuOfgeW3QOjOYN3fgCvIMaIQpJ4NihKXeFJxHP77RF9gNH07fZejur2CX+t9r3znA8jmciwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776476684; c=relaxed/simple;
	bh=0iCEuf4xaBjkDEPNFCoYP43FOqLdY44ONYxZIt6nScU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsyntWstee4+zorV1j/AiYiwymMfKKmxgb0Cb9lbCHOnEwjeJhHkvv/eGF/AgLsv6pYvzAuxNyyE1NsLQhrCBbnFtbIPAhAAgJpAIIdxBM9RPKFC2w6+tWlLub4NEus3nqSCzJR2f+AO9E1cIvGq0Q9DCpBbDUOwpIfff8WwY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL4dJZHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7476FC2BCB6;
	Sat, 18 Apr 2026 01:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776476684;
	bh=0iCEuf4xaBjkDEPNFCoYP43FOqLdY44ONYxZIt6nScU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PL4dJZHWM60YVmlVra4uongRn4GagzsfxPKOjXLdLvyyG3mGaukrxjvWQ5UVJxvIu
	 VzJDf9sMIgcFQ3y52WO9r6Lz/gNkzYriurTXpHBAmx94AbZz3e4t7pO2uUlsxY3lsf
	 V/8SsnCdDKt0IPNw25W4C0eOVZ+oJaPACRpBv/h3hYWd3VjfGC5xTHjexXHI3VJSEX
	 gf5wQbYBgviS1wvPdmSsB4fs1Fg5UU+uwTGjR0A+mXuubiTU3O49GmK70tTwmGsWSM
	 eY4N/+4zmPI2x5qvUyAIe+e4DK8iNp5g3DmcA+Biv3NRG6sjZHVKGu2nmJT2GCPAym
	 bnuPRCV35G8Ew==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 3/3] mm/damon/stat: detect and use fresh enabled value
Date: Fri, 17 Apr 2026 18:44:37 -0700
Message-ID: <20260418014439.6353-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418014439.6353-1-sj@kernel.org>
References: <20260418014439.6353-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238538-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1293141FA19
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

