Return-Path: <stable+bounces-24480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E18694B4
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E901C26393
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4701420A3;
	Tue, 27 Feb 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dnsAxz2b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F814533E;
	Tue, 27 Feb 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042121; cv=none; b=HxLnVsouzPY7PCorZR2XgSuj0CFJ3H6WdeTmmdeqzCPsbWyKPfRdVdElhJR/rWfys6YRt4+DW2M/6L+jcZxKMT2i+qJ0byXl+p1IdeeEAG/5tSGP0vu6gF25l8heP9wyRlZoc0g2RqFW2Umy9YsMg+T3AEKMue4AJBDa/pJxIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042121; c=relaxed/simple;
	bh=HXbMIeAfjAeJJ949pWg4Ghe7PAESmwtUZY9GZtrrhTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWzdz+o/9sNAi9ueNyhs6qmp0+mfORr4loG7GL/2eMaaBPXQf61vu8vBEJ4o7C9qbYiZ/fCIEypt8KJFoSc80Vd+8oR8/yNiHxSidq2BppOuCtObAofLjkvvRabK//CdiYy1NpjcCiVhsVXSC97j7HMigwlFmf4etNvj0Yg7mIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dnsAxz2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D9AC433C7;
	Tue, 27 Feb 2024 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042121;
	bh=HXbMIeAfjAeJJ949pWg4Ghe7PAESmwtUZY9GZtrrhTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnsAxz2bIOekBdBOok65nQI49bNcZVnVB6L9ZBmK4O5n9CRQsEjbphrAzVmmkclLA
	 Pu80Ff4LFULLV1gjhBpEY74Ub6bWdKhv6cqvYh/woBn/4hPzQwzbtYzLhnuWlKmFCX
	 i/BoZs0Gxun0ik7xwMznfp9ydBTPRNL61zd3vnWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 159/299] mm/damon/lru_sort: fix quota status loss due to online tunings
Date: Tue, 27 Feb 2024 14:24:30 +0100
Message-ID: <20240227131630.972857586@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

commit 13d0599ab3b2ff17f798353f24bcbef1659d3cfc upstream.

For online parameters change, DAMON_LRU_SORT creates new schemes based on
latest values of the parameters and replaces the old schemes with the new
one.  When creating it, the internal status of the quotas of the old
schemes is not preserved.  As a result, charging of the quota starts from
zero after the online tuning.  The data that collected to estimate the
throughput of the scheme's action is also reset, and therefore the
estimation should start from the scratch again.  Because the throughput
estimation is being used to convert the time quota to the effective size
quota, this could result in temporal time quota inaccuracy.  It would be
recovered over time, though.  In short, the quota accuracy could be
temporarily degraded after online parameters update.

Fix the problem by checking the case and copying the internal fields for
the status.

Link: https://lkml.kernel.org/r/20240216194025.9207-3-sj@kernel.org
Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.0+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/lru_sort.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -183,9 +183,21 @@ static struct damos *damon_lru_sort_new_
 	return damon_lru_sort_new_scheme(&pattern, DAMOS_LRU_DEPRIO);
 }
 
+static void damon_lru_sort_copy_quota_status(struct damos_quota *dst,
+		struct damos_quota *src)
+{
+	dst->total_charged_sz = src->total_charged_sz;
+	dst->total_charged_ns = src->total_charged_ns;
+	dst->charged_sz = src->charged_sz;
+	dst->charged_from = src->charged_from;
+	dst->charge_target_from = src->charge_target_from;
+	dst->charge_addr_from = src->charge_addr_from;
+}
+
 static int damon_lru_sort_apply_parameters(void)
 {
-	struct damos *scheme;
+	struct damos *scheme, *hot_scheme, *cold_scheme;
+	struct damos *old_hot_scheme = NULL, *old_cold_scheme = NULL;
 	unsigned int hot_thres, cold_thres;
 	int err = 0;
 
@@ -193,18 +205,35 @@ static int damon_lru_sort_apply_paramete
 	if (err)
 		return err;
 
+	damon_for_each_scheme(scheme, ctx) {
+		if (!old_hot_scheme) {
+			old_hot_scheme = scheme;
+			continue;
+		}
+		old_cold_scheme = scheme;
+	}
+
 	hot_thres = damon_max_nr_accesses(&damon_lru_sort_mon_attrs) *
 		hot_thres_access_freq / 1000;
-	scheme = damon_lru_sort_new_hot_scheme(hot_thres);
-	if (!scheme)
+	hot_scheme = damon_lru_sort_new_hot_scheme(hot_thres);
+	if (!hot_scheme)
 		return -ENOMEM;
-	damon_set_schemes(ctx, &scheme, 1);
+	if (old_hot_scheme)
+		damon_lru_sort_copy_quota_status(&hot_scheme->quota,
+				&old_hot_scheme->quota);
 
 	cold_thres = cold_min_age / damon_lru_sort_mon_attrs.aggr_interval;
-	scheme = damon_lru_sort_new_cold_scheme(cold_thres);
-	if (!scheme)
+	cold_scheme = damon_lru_sort_new_cold_scheme(cold_thres);
+	if (!cold_scheme) {
+		damon_destroy_scheme(hot_scheme);
 		return -ENOMEM;
-	damon_add_scheme(ctx, scheme);
+	}
+	if (old_cold_scheme)
+		damon_lru_sort_copy_quota_status(&cold_scheme->quota,
+				&old_cold_scheme->quota);
+
+	damon_set_schemes(ctx, &hot_scheme, 1);
+	damon_add_scheme(ctx, cold_scheme);
 
 	return damon_set_region_biggest_system_ram_default(target,
 					&monitor_region_start,



