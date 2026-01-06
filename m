Return-Path: <stable+bounces-205019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26153CF6782
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A56AE30262BA
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E794D1DFE12;
	Tue,  6 Jan 2026 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tA+AnWaN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858B18024
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 02:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666644; cv=none; b=MjUZ5UmBIRPIMCgGtvMoJo7pg1e60Us3QDffxxWBIaFYz56MJ4AzPbtocBAN+f2fBQbPmucbfgqg5ycnaOFyjCEYfitUg0GA5RC+S1sUcN4fJAojUQonRvs3uk61W8IyRGUM6qSQj8Z/Tflk3AwLRJr7uhykYMOifJUKJEeG8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666644; c=relaxed/simple;
	bh=4XeE/We5ICnms8RHZBWM5MWijDKyCsdQ1+US+uLncro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCjpa8CQjS4gtGSxlRSWsSc9HcjJVU1wcSj5V0FYPfm+napUH/2IliW8mWOqEIrJxH/gbUVMrgSa89d8D4SdRdjNEWawmyr7zTipANcgjp/Tu2uv8/JjJzV9JQbPLdfFkpBIx1h1rCWspFWc4qmfE32yoxuV99b1pbJUScLakXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tA+AnWaN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D2EC116D0;
	Tue,  6 Jan 2026 02:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767666644;
	bh=4XeE/We5ICnms8RHZBWM5MWijDKyCsdQ1+US+uLncro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tA+AnWaNpFlF5bfFex8AbWmJyR/e8wVMAP1zxGAyslvy9RNwHHyK4AJ7k3KozNijT
	 4lOy7iNIsQ3CI+Oe37hclgFKTIqHgwsvdcVc5h5qiO5Ja/3t9BXUJszWmHSiAeG4UL
	 1HcioRFFhPWi6Ayrzv2/biqgPDC9chNjmIuM7DYVOukvkjrNVczmiS711Mt1btSGrJ
	 s0N4yT+9xSXSXepLw+3m+AQ00eYjjyG6pYCu8RuwJtKT55I6lJmnlU/8VYqaokbSaW
	 R3JyT9CgpAB3sSvFR/1TeJ32gLn4pSg/Id4l2EYbHXHuKsM7lgf/GnAv7kG6rcASLS
	 6J7FL0b8GVF9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()
Date: Mon,  5 Jan 2026 21:30:41 -0500
Message-ID: <20260106023041.2916387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010546-myspace-powdering-7f2b@gregkh>
References: <2026010546-myspace-powdering-7f2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit f79f2fc44ebd0ed655239046be3e80e8804b5545 ]

damon_test_aggregate() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-5-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted file path from mm/damon/tests/core-kunit.h to mm/damon/core-test.h ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core-test.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 3db9b7368756..87d41fd98637 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -84,8 +84,15 @@ static void damon_test_aggregate(struct kunit *test)
 	struct damon_region *r;
 	int it, ir;
 
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
 	for (it = 0; it < 3; it++) {
 		t = damon_new_target();
+		if (!t) {
+			damon_destroy_ctx(ctx);
+			kunit_skip(test, "target alloc fail");
+		}
 		damon_add_target(ctx, t);
 	}
 
@@ -93,6 +100,10 @@ static void damon_test_aggregate(struct kunit *test)
 	damon_for_each_target(t, ctx) {
 		for (ir = 0; ir < 3; ir++) {
 			r = damon_new_region(saddr[it][ir], eaddr[it][ir]);
+			if (!r) {
+				damon_destroy_ctx(ctx);
+				kunit_skip(test, "region alloc fail");
+			}
 			r->nr_accesses = accesses[it][ir];
 			damon_add_region(r, t);
 		}
-- 
2.51.0


