Return-Path: <stable+bounces-204967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6E7CF6202
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 885B93050584
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED11F0E29;
	Tue,  6 Jan 2026 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kARgBpbx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C924A3C;
	Tue,  6 Jan 2026 00:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660902; cv=none; b=HwRjWzUZLjvLs0mKMhZxeBkmMkKyGBJuo0c7n6K2ez+ChXLW9afGlYxX74jaG+aaLjJ28+BjZ7Za065xcbsAn7Wkk4L+tKc8MYNX2ozushqRMTsbfnvRdNFbtsfnJGGdyA6lZDEP9PHbhGzmr++cFj0eFvxn/SF6vvX5tomD8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660902; c=relaxed/simple;
	bh=EBuLOWMz/1O9AEfxfMF4jsQ50nr4wyVXe3et10FcT70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CeeW9VHaoygkSHTFl3sYZ4h3H52eYbjDhKqw2igtzfI84JOKuKqcoTCOdvJWPNQv4wM/v1aY7C8lKM9iRaRk8XB342/6BtknuX5O0JVSyp6LeJhbaoSnKHa6lOx+tVjbV0hvUpAuobTGce3OQ/l6tUNSze52lHcwuJYUOHDAySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kARgBpbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F45C116D0;
	Tue,  6 Jan 2026 00:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660902;
	bh=EBuLOWMz/1O9AEfxfMF4jsQ50nr4wyVXe3et10FcT70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kARgBpbx4dcqPnk0taZE7b88dZ4lqE+izbsXdl0UPP2XmYjVtK6yV9dHhxCctNn3T
	 9tFhKByVdnkJ1+4MhQou994Q3OcIjuQv9tSeHinOhzZPD89ZlImMEuj6/zg0D8BM/n
	 974fmk6G/tKovMQgu1MIm5QRvVeqVyfBz6cB3fk4+Ur1TxwU80QOPfomc2dujl6zGX
	 ezPzk0FsJNPdHDSdoUNxZ9ne8Ek5Ic3ILd6L1Hfbxdd/g1Zl6scwhxl4yPPyhDj5yr
	 0GvhJtb69JTh54RLjZ+ZhPWqLV/Qn1s3JGEE0Y/JZ5TMKsux4BtuPYRUv4T8rh9rzS
	 eRlFJbMO1ALuw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_test_split_evenly_succ()
Date: Mon,  5 Jan 2026 16:54:53 -0800
Message-ID: <20260106005453.143393-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010512-stainless-reliance-2417@gregkh>
References: <2026010512-stainless-reliance-2417@gregkh>
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
---
 mm/damon/vaddr-test.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index b4fc21ef3c70..9813002a981c 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -269,10 +269,17 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 	unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
 	struct damon_target *t = damon_new_target();
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


