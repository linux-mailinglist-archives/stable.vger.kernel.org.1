Return-Path: <stable+bounces-204971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A88CF620E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE393305675C
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC61F7916;
	Tue,  6 Jan 2026 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSUFtIcT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E049F4A3C
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660933; cv=none; b=JZB2N0oewkEa79ajnv5hIxloETplBCODsHxZe0KCpc516+FiqhntZEphVLRJteS2JQvbMEPuTQMfVPLr7L+w6TybJS0ym3V5h4kH1p/joWglvYAM4yHRmmmk6j+HmhlXRvD/6KFmhdlu4eya4fyY4bcIEbyM4TphjCYT01cnsNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660933; c=relaxed/simple;
	bh=y3+YK5rC1pH89oWfO2VObfquev5Rym8xDhOTyIW+oMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkM1ZmXJZqfpUdo53W/MUoWjmZ90wGhc/IB5RDcAvflmN9sr08iacQ2BOl8N/37eYGZmQwO+1uaiErRrB7tjgZX8a1AycoSHWwKjCAJi4fFUBRz89w85MvGvuaymI2XUhhDDHdYH4yX7q/y4hYHHtZ8v4v0W9lOl61dT42YEHSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSUFtIcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D52C19424;
	Tue,  6 Jan 2026 00:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660932;
	bh=y3+YK5rC1pH89oWfO2VObfquev5Rym8xDhOTyIW+oMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSUFtIcTJ3+QuETUYKBy+oIcYoJMqmahrIQseI88VoXComGehRnCe0GpOth4oQHye
	 CCpNhd49USHjVI67xGf0p/njPyg/Wr02bdv0Z+0SVjKgE1ZzRyY12iKMyegjPNc2gh
	 tnXMIiH4oJsBNIOzhdoTSKkKZZgtz0Yv0M/2rmUXReqciV/UTKmfsKN9q3iTme4aAm
	 mGwRwXZ9LXBgZ0r/yacXlYQalwgaW/JJ2Cfs0EywiQzxa4d0jj1gjuOHQ/AV2S4ZMe
	 11wh0H+XYQJddBI0Kv7gu3QCkHLwwZUSG5ZmQ4xpl8VcYbY7iaymqOrvYBCGrMBuSI
	 OZupRWIye0ycw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] mm/damon: add 'allow' argument to damos_new_filter()
Date: Mon,  5 Jan 2026 19:55:27 -0500
Message-ID: <20260106005528.2865815-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106005528.2865815-1-sashal@kernel.org>
References: <2026010550-tank-repugnant-eee6@gregkh>
 <20260106005528.2865815-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit e2fbfedad03401a38b8c3b7fd52d8fdcd039d0bc ]

DAMON API users should set damos_filter->allow manually to use a DAMOS
allow-filter, since damos_new_filter() unsets the field always.  It is
cumbersome and easy to mistake.  Add an arugment for setting the field to
damos_new_filter().

Link: https://lkml.kernel.org/r/20250109175126.57878-6-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 28ab2265e942 ("mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/damon.h       | 2 +-
 mm/damon/core.c             | 7 ++++---
 mm/damon/paddr.c            | 3 ++-
 mm/damon/reclaim.c          | 2 +-
 mm/damon/sysfs-schemes.c    | 2 +-
 mm/damon/tests/core-kunit.h | 4 ++--
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 0da1397cd719..58aff70fd622 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -728,7 +728,7 @@ void damon_update_region_access_rate(struct damon_region *r, bool accessed,
 		struct damon_attrs *attrs);
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
-		bool matching);
+		bool matching, bool allow);
 void damos_add_filter(struct damos *s, struct damos_filter *f);
 void damos_destroy_filter(struct damos_filter *f);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 17a9fe18c069..5017ba453688 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -266,7 +266,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 }
 
 struct damos_filter *damos_new_filter(enum damos_filter_type type,
-		bool matching)
+		bool matching, bool allow)
 {
 	struct damos_filter *filter;
 
@@ -275,7 +275,7 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 		return NULL;
 	filter->type = type;
 	filter->matching = matching;
-	filter->allow = false;
+	filter->allow = allow;
 	INIT_LIST_HEAD(&filter->list);
 	return filter;
 }
@@ -804,7 +804,8 @@ static int damos_commit_filters(struct damos *dst, struct damos *src)
 			continue;
 
 		new_filter = damos_new_filter(
-				src_filter->type, src_filter->matching);
+				src_filter->type, src_filter->matching,
+				src_filter->allow);
 		if (!new_filter)
 			return -ENOMEM;
 		damos_commit_filter_arg(new_filter, src_filter);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 4120a73f4933..f9a0a6eb6630 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -258,7 +258,8 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 		}
 	}
 	if (install_young_filter) {
-		filter = damos_new_filter(DAMOS_FILTER_TYPE_YOUNG, true);
+		filter = damos_new_filter(
+				DAMOS_FILTER_TYPE_YOUNG, true, false);
 		if (!filter)
 			return 0;
 		damos_add_filter(s, filter);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 65842e6854fd..ade3ff724b24 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -226,7 +226,7 @@ static int damon_reclaim_apply_parameters(void)
 	}
 
 	if (skip_anon) {
-		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+		filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, false);
 		if (!filter)
 			goto out;
 		damos_add_filter(scheme, filter);
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index d9e01648db70..5893b40dcd1f 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1919,7 +1919,7 @@ static int damon_sysfs_add_scheme_filters(struct damos *scheme,
 			sysfs_filters->filters_arr[i];
 		struct damos_filter *filter =
 			damos_new_filter(sysfs_filter->type,
-					sysfs_filter->matching);
+					sysfs_filter->matching, false);
 		int err;
 
 		if (!filter)
diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index cf22e09a3507..2329158c6f5d 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -411,7 +411,7 @@ static void damos_test_new_filter(struct kunit *test)
 {
 	struct damos_filter *filter;
 
-	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, false);
 	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_ANON);
 	KUNIT_EXPECT_EQ(test, filter->matching, true);
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
@@ -425,7 +425,7 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damon_region *r, *r2;
 	struct damos_filter *f;
 
-	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
+	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
 	f->addr_range = (struct damon_addr_range){
 		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
 
-- 
2.51.0


