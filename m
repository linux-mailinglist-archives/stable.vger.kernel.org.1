Return-Path: <stable+bounces-204979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C1BCF6314
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EE6D3037CDE
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01532277037;
	Tue,  6 Jan 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOifvpJg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BEF1D5160
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661764; cv=none; b=F9uJnvU7D9B3+U4zioc7m8RrHeKdg+e1BmeHg1rR4/7JozHhVXyfdskEc6IFP53wgkiXA+pPnrSstp2QLBNGBl6DAGz0UZl3BXYaiTUXCssTawHvHcBaCM/jjAq2no9d5TfjIoSSINq+BPe/sEe33aj0QauKvN/tL8129WLod/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661764; c=relaxed/simple;
	bh=X2Xzs4zf5d+/aL9iNhKh4P/HMqyTpM2Eff/w2iy5fR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0T1XUABPxaabMHdnI9peTN8bNMVeyDUVcpxiaSiYakBxXqaekDWwVhQbZ6T6BKJGe0YR9xyzM+5wks6i3NmiUG0mk1N3FOk9gpxo4a1PDkZyh4+ZaD0bowxOBepX52BL1Mpq15VHUmSZMyAz3moWo5xD4KUvvjt+4VlGxwLSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOifvpJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE67C116D0;
	Tue,  6 Jan 2026 01:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661764;
	bh=X2Xzs4zf5d+/aL9iNhKh4P/HMqyTpM2Eff/w2iy5fR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qOifvpJgg1rulx0tjj0u95A/ApvtoJ4oIKBfwiFRH7ty8OlXTA4lgOdIKH3wniKnp
	 q6fDVHmI5eHoft8N3bMHTR9IyEybCzE2QcjZmJfJeU0drQ+3SGRhIuuDnzO229cLKt
	 lAkS118rHCn86gEINwZtbRXGkMb5XdW/9c7Qc6Rxb9302WQKcHkRffHvDQ2XezotNT
	 U7O2qOV3XjiVcCLwvDEIWGy5lqNTcSxL9YK1mzeBkP8Tln2EF9pqyZE1JoL6mcvADm
	 DCQXqTrJHkj8uWjqJ0t/6IbYwddPVezAUW5l+Xi66XlfOjYXMAudMIRPkEgmZ4aoxs
	 EfuBpDFKa0BsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
Date: Mon,  5 Jan 2026 20:09:21 -0500
Message-ID: <20260106010921.2870425-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010522-unrelated-secluded-4f8f@gregkh>
References: <2026010522-unrelated-secluded-4f8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit e16fdd4f754048d6e23c56bd8d920b71e41e3777 ]

damon_test_regions() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-3-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..23a6d3ae9aed 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -20,11 +20,17 @@ static void damon_test_regions(struct kunit *test)
 	struct damon_target *t;
 
 	r = damon_new_region(1, 2);
+	if (!r)
+		kunit_skip(test, "region alloc fail");
 	KUNIT_EXPECT_EQ(test, 1ul, r->ar.start);
 	KUNIT_EXPECT_EQ(test, 2ul, r->ar.end);
 	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_free_region(r);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_add_region(r, t);
-- 
2.51.0


