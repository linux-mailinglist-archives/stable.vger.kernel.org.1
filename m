Return-Path: <stable+bounces-205027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C4CF6836
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D1D30204AD
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055FD21D3C0;
	Tue,  6 Jan 2026 02:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqXhvgVC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5C13C918;
	Tue,  6 Jan 2026 02:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667780; cv=none; b=DKQW6vINOU+MyvtQ77YU91NzumwPP4UVvwuRkBTvVM2epv1HJRcPljKgeFZDahjrA0qU0HRMRD/iKHxum4A1vxnHKwwLVyQoLKe4FzGff7OT8dQtlJgT55n6NDM3CDdGc0e8V3jyKfoGltCe4dWVlc4OfTCZRlmEZO8DIARuWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667780; c=relaxed/simple;
	bh=zg/9X94gNdRg2GZTX9IWKS6ggfxIfG4V440gh+ew5TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvtGfwuIwzVe2Mnsta/nV9zmS5wt9BS/FIYtmHbfx2cGkfgTEVUsCPmqSkwMhUEdziyRYD7x/rjPeG7AwdBTc5EsYj/6B786Tk7NkUetf+qjVZyz713rw6L475C0ONatbrh06cn7i+j7MI+kWmTTD1r7FK+NP5OQk9e517eUGkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqXhvgVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1F8C116D0;
	Tue,  6 Jan 2026 02:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767667780;
	bh=zg/9X94gNdRg2GZTX9IWKS6ggfxIfG4V440gh+ew5TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqXhvgVCwaJ4lIaUhHySg/lBwOLKZnI8TlYmgrse49py606wHW4J7HX9C+8wtuj8e
	 8r5JhCyY/Ai4BJMCss4FGYssrO6hpqYgoYgGan55g/965tVQQG4ncSoxDU/cgPdkoS
	 xpjyoYo1z2J2ndb36qgb9oapkRgwHQiIQNUFkylKpS13rgA46LTQ3nRp/2iu1zsQJn
	 bNLcGSgm1k2x9rNU96nB+9jItoskvit8xef/k639b91P+sdwwtVpz1VGQAHTNUU6Y9
	 wyXSjFZuyNqgN36K81cwIs7+x8kQ6+NVU03TlBrC5ipLvc/ebVBqic5vHiRxcK48u5
	 7v76MGnpzwDMg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_test_split_evenly_succ()
Date: Mon,  5 Jan 2026 18:49:33 -0800
Message-ID: <20260106024933.850848-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010513-quickness-paging-fee4@gregkh>
References: <2026010513-quickness-paging-fee4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_evenly_succ() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-20-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0a63a0e7570b9b2631dfb8d836dc572709dce39e)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 5531766ff09f..b23073e52a95 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -275,10 +275,17 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 	unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
 	struct damon_target *t = damon_new_target(42);
-	struct damon_region *r = damon_new_region(start, end);
+	struct damon_region *r;
 	unsigned long expected_width = (end - start) / nr_pieces;
 	unsigned long i = 0;
 
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+	r = damon_new_region(start, end);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
 			damon_va_evenly_split_region(t, r, nr_pieces), 0);
-- 
2.47.3


