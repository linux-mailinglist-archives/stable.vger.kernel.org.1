Return-Path: <stable+bounces-226036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDksA29quWmZDwIAu9opvQ
	(envelope-from <stable+bounces-226036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:51:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 967902AC5EB
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB4D632C8DAE
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F10369239;
	Tue, 17 Mar 2026 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmXP8x27"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3D3E9296
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758584; cv=none; b=pzMlHZOlym/0/mP+kiWUnzo/ZJEVNIm6a0FdqTizUAbRfOFUIxpoVLnhCW/pxzfQ8cwq8S99bfeIYRosD2yIXqZYXbdEnlSKMJLgtuju3rAgNutIsTDaiCTbQC3H4H/X31yX5aVRLBzgnPQjVbAqu0MYuzpMjfJjAs2NQXl7Iro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758584; c=relaxed/simple;
	bh=yOeTNATEa3HnYJGlt38Yw9mKBHm6w53KAxnYBwDlWmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQ+MV+Mww7tthoBPHoUTKWXydohx3hcXXbvbcL7zRUj4nPhX6JQzYZzSEmNl5DC2imnj0kZI6eErKJnWnaq/w7e0m8iWZFwTP4vPxbrwPMGSMZ3aM8nCDDf9J9BM/4AWtwUMiZ3Mabm//zuy/cyuaBqVQSoh+0PIH4eZNtUh+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmXP8x27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BF4C4CEF7;
	Tue, 17 Mar 2026 14:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773758584;
	bh=yOeTNATEa3HnYJGlt38Yw9mKBHm6w53KAxnYBwDlWmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmXP8x27WdpG4IGOaZAFLBKZuEvaFzjyhB/4dsDS847tSdD64dobpcEh+qHEooKUt
	 7PRFEaT1XQfzEBi8LRx1A7yYJLa/abxr5lMb/5udlQ2RCoGyrwTECMRfh1cR/TIg+c
	 l+3I/69Q0ClRHm1O5rCyARfP8bnClWKlhu1iLeWDOWcdDoxZhKxl1MZ/pifWCVjVuw
	 n23wv05auBbYNFNeVri1MXZTk09p5ILfx7H/w/jmC2ZIjLmpgK2CHXzH75kAvGIz7M
	 rpEo1NHdCjN3UUEqoQbj09vp7NjuX3pJZF5MJqFwkFQfNe0edmmm44PphTiAa6v1aa
	 dMbvV0qa2mZRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y 1/3] mm/damon: rename DAMON_MIN_REGION to DAMON_MIN_REGION_SZ
Date: Tue, 17 Mar 2026 10:43:00 -0400
Message-ID: <20260317144302.174364-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031714-concept-seventh-df3c@gregkh>
References: <2026031714-concept-seventh-df3c@gregkh>
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
	TAGGED_FROM(0.00)[bounces-226036-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 967902AC5EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: SeongJae Park <sj@kernel.org>

[ Upstream commit dfb1b0c9dc0d61e422905640e1e7334b3cf6f384 ]

The macro is for the default minimum size of each DAMON region.  There was
a case that a reader was confused if it is the minimum number of total
DAMON regions, which is set on damon_attrs->min_nr_regions.  Make the name
more explicit.

Link: https://lkml.kernel.org/r/20260117175256.82826-8-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: c80f46ac228b ("mm/damon/core: disallow non-power of two min_region_sz")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h        |  2 +-
 mm/damon/core.c              |  2 +-
 mm/damon/lru_sort.c          |  2 +-
 mm/damon/reclaim.c           |  2 +-
 mm/damon/sysfs.c             |  2 +-
 mm/damon/tests/vaddr-kunit.h |  2 +-
 mm/damon/vaddr.c             | 24 ++++++++++++------------
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 3813373a9200c..eed59ae0ec9a8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -15,7 +15,7 @@
 #include <linux/random.h>
 
 /* Minimal region size.  Every damon_region is aligned by this. */
-#define DAMON_MIN_REGION	PAGE_SIZE
+#define DAMON_MIN_REGION_SZ	PAGE_SIZE
 /* Max priority score for DAMON-based operation schemes */
 #define DAMOS_MAX_SCORE		(99)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 84f80a20f2336..892bf704b3f03 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -546,7 +546,7 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.max_nr_regions = 1000;
 
 	ctx->addr_unit = 1;
-	ctx->min_sz_region = DAMON_MIN_REGION;
+	ctx->min_sz_region = DAMON_MIN_REGION_SZ;
 
 	INIT_LIST_HEAD(&ctx->adaptive_targets);
 	INIT_LIST_HEAD(&ctx->schemes);
diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 49b4bc294f4e1..290fcfb7685a8 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -212,7 +212,7 @@ static int damon_lru_sort_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION / addr_unit, 1);
+	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_lru_sort_mon_attrs.sample_interval) {
 		err = -EINVAL;
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 36a582e09eaef..88e53393e3e0b 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -208,7 +208,7 @@ static int damon_reclaim_apply_parameters(void)
 	if (!monitor_region_start && !monitor_region_end)
 		addr_unit = 1;
 	param_ctx->addr_unit = addr_unit;
-	param_ctx->min_sz_region = max(DAMON_MIN_REGION / addr_unit, 1);
+	param_ctx->min_sz_region = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
 
 	if (!damon_reclaim_mon_attrs.aggr_interval) {
 		err = -EINVAL;
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 95fd9375a7d84..e1b32472f686b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1470,7 +1470,7 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
 		ctx->min_sz_region = max(
-				DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
+				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)
 		return err;
diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 30dc5459f1d2c..cfae870178bfd 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -147,7 +147,7 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		damon_add_region(r, t);
 	}
 
-	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
+	damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
 
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 23ed738a0bd6f..226a3f0c9b4a7 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -19,8 +19,8 @@
 #include "ops-common.h"
 
 #ifdef CONFIG_DAMON_VADDR_KUNIT_TEST
-#undef DAMON_MIN_REGION
-#define DAMON_MIN_REGION 1
+#undef DAMON_MIN_REGION_SZ
+#define DAMON_MIN_REGION_SZ 1
 #endif
 
 /*
@@ -78,7 +78,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
 	orig_end = r->ar.end;
 	sz_orig = damon_sz_region(r);
-	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);
+	sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION_SZ);
 
 	if (!sz_piece)
 		return -EINVAL;
@@ -161,12 +161,12 @@ static int __damon_va_three_regions(struct mm_struct *mm,
 		swap(first_gap, second_gap);
 
 	/* Store the result */
-	regions[0].start = ALIGN(start, DAMON_MIN_REGION);
-	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION);
-	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION);
-	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION);
-	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION);
+	regions[0].start = ALIGN(start, DAMON_MIN_REGION_SZ);
+	regions[0].end = ALIGN(first_gap.start, DAMON_MIN_REGION_SZ);
+	regions[1].start = ALIGN(first_gap.end, DAMON_MIN_REGION_SZ);
+	regions[1].end = ALIGN(second_gap.start, DAMON_MIN_REGION_SZ);
+	regions[2].start = ALIGN(second_gap.end, DAMON_MIN_REGION_SZ);
+	regions[2].end = ALIGN(prev->vm_end, DAMON_MIN_REGION_SZ);
 
 	return 0;
 }
@@ -259,8 +259,8 @@ static void __damon_va_init_regions(struct damon_ctx *ctx,
 		sz += regions[i].end - regions[i].start;
 	if (ctx->attrs.min_nr_regions)
 		sz /= ctx->attrs.min_nr_regions;
-	if (sz < DAMON_MIN_REGION)
-		sz = DAMON_MIN_REGION;
+	if (sz < DAMON_MIN_REGION_SZ)
+		sz = DAMON_MIN_REGION_SZ;
 
 	/* Set the initial three regions of the target */
 	for (i = 0; i < 3; i++) {
@@ -299,7 +299,7 @@ static void damon_va_update(struct damon_ctx *ctx)
 	damon_for_each_target(t, ctx) {
 		if (damon_va_three_regions(t, three_regions))
 			continue;
-		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION);
+		damon_set_regions(t, three_regions, 3, DAMON_MIN_REGION_SZ);
 	}
 }
 
-- 
2.51.0


