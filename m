Return-Path: <stable+bounces-205009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA674CF6684
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08BE3301514F
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A40224AF2;
	Tue,  6 Jan 2026 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuXez5sI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241021C9FD;
	Tue,  6 Jan 2026 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665081; cv=none; b=Tk1tyHX8xb1XTMVZlTUAh9LmHLeTPG7wd6jp8TYv8s+KyQVTiyY/T5VY+d0miigDy3ane48v5927bA6tIBCTEYfp3obJkEukRdNwRpfNr741E91h6lWODHCZIfGYzgsElEr93VmqjapwJAlENfpyZyTu3EARCPIdBw2IC3+x6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665081; c=relaxed/simple;
	bh=L9N9xtBPO6ovigV2wFwF1y59qA+OThqlo6SU7EK6SOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h23RdJyg7RbB0Re3HUJQ54BQfFyPp/7KV24nNi/rO6iv6pu0coGxhrUgei8RJQSUa5h9eiLkoz3ulObFh5kZbQIZ5gBBzFhLa/0bwhkwYV4pGdrbmubKMeruen9B11fSLU1MdSPBeL+P6yhKioaNW23X46q5W/XvJisaRFU3ZXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuXez5sI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328B6C4AF09;
	Tue,  6 Jan 2026 02:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767665081;
	bh=L9N9xtBPO6ovigV2wFwF1y59qA+OThqlo6SU7EK6SOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TuXez5sIZNgrhDz3IA+fKYonuBj/O2Jyn7an+G4Yb5FoN0Y3Pepeac6RYtBtvF6wU
	 PSOsJt2jcOVJ2RZO0P1DYeIiFncf5nWUk50050ejvDujztU1tmcmxgUQnfm2IOY9bM
	 Jo0MNnrJjKELI4jasLGYbsW+NqsYMHFR/ea+ZGrNuV/snTJUmfeKwFiBQ4p4Grme0m
	 JSdFBsukKmlH1V95WEjYgIuGXnVcuEgIp+4J/uQWKSzo5ed3B7YYlRkNAdsDOc4O9h
	 Gvrxf8tFquErZYZb9bUvuAGr+m190HN78qnprWZQhmdTybXFa9Mb8cJf9baIcRW2Fx
	 Z97299vOzlMsw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()
Date: Mon,  5 Jan 2026 18:04:33 -0800
Message-ID: <20260106020433.570784-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010546-myspace-powdering-7f2b@gregkh>
References: <2026010546-myspace-powdering-7f2b@gregkh>
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
Signed-off-by: SeongJae Park <sj@kernel.org>
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
2.47.3


