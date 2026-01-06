Return-Path: <stable+bounces-204977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BAACF63FF
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11BD304A8E7
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F55331217;
	Tue,  6 Jan 2026 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlbKrdc4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804A330B2C;
	Tue,  6 Jan 2026 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661474; cv=none; b=pUkpRO9mYTsfuuwOYbOHppKw8LzM4FJXWGxQpe1yzHAaIBX/NDLDqwSWcUEi6vyB09hULr3imMztdRsadBXeXM9oJtCONo4ub64xNQU2wditSEi4Vlpx8acfpuooXoXjyV5oiQgb76JKA/+S4GRZI7DPGFoxp5X/idY63YS4J7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661474; c=relaxed/simple;
	bh=EUduSVzP4Gg/uemCQp4DjijzVR+GlDMxekDvvjl8XEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAXJ69d+UaoutZKqC5k99nEXJr+ydg8OsDI9OVYXZsLHtTwRvZLyo/heEOCMLckutPbAbMKXo3x/9848nMzorNWqb9k5+P2O6frUjPb8meTTEm0aTZZya4B5wGSEDU+7EbKj0vlHT05oW1K455oLhBM9IsKj/QAHuQZk157z0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlbKrdc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B278C116D0;
	Tue,  6 Jan 2026 01:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661473;
	bh=EUduSVzP4Gg/uemCQp4DjijzVR+GlDMxekDvvjl8XEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RlbKrdc4f0Ed+xFnhl248HqmB2bjHItz+fKvbJt1cIhpl87uIIywEnJm6ReI3JHnE
	 eeWK4MIJGPcfvLx0znzRW7RSMgj3PJR+bBeh2lLJV+Mdwzfn8vFNo2kZItCiVtmPDW
	 KMmMJrzR0sAnbL5h6JwGChFGpl9ZF+60RJEvkccy3P6kunaf20HgGfqPNqyjcRjVoW
	 t2bTZixTC4331JLYRYJQbWLmriAOubOoAgDVWpAVpkwYkGtZEnHLK43q0fItpXAu8w
	 lcRy/199hk7ZUEd9r0nIzoa5d8N+cb0o2kn+aji6M5WFIrM9+5Zl/cWxXiWNQBj4ZO
	 3iveSkkbfZSgw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()
Date: Mon,  5 Jan 2026 17:04:25 -0800
Message-ID: <20260106010425.198945-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010545-sesame-antsy-7700@gregkh>
References: <2026010545-sesame-antsy-7700@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit f79f2fc44ebd0ed655239046be3e80e8804b5545)
---
 mm/damon/core-test.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..693cba98be50 100644
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
2.47.3


