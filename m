Return-Path: <stable+bounces-204994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4E4CF6627
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D4B630D2EFC
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB976322A3F;
	Tue,  6 Jan 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR5gbj2T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0132277B;
	Tue,  6 Jan 2026 01:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663777; cv=none; b=Y7a/uEWPeqcK6lUvARxWY5lPP3qL8vdASY95bLYm8RBdmKpY2b1fQpeRsNjuWAelwdxN8TP6Fr+oTzCupnjI5P8HPoxdQ61UebAxKMif+2g/PiB6m/3wfeouZZ4HW+k+M1W8TabvPhWY8Thl1uyvidYzGv3ETpyNWnjYejOQuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663777; c=relaxed/simple;
	bh=m7nqpH/aJwrUB2y8KyqX/v/3t90qyP6nAInUznf3aJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSfriuhM/9a+nQFPGLy0LMY/A9z4gluLfq0L4zMjhUsZ2bF3c3MonSj2nQU7RtZEBNecwrpZohDFZnDQh1lIHMvuOkUjtKWeONrAZW/QF88+qsBEq6vQIAYEfrqt378MWIFfu3L0xHzP4/UuVy9CMFIm5hM/y1ky7LMFT3Mg390=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR5gbj2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5005C116D0;
	Tue,  6 Jan 2026 01:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663777;
	bh=m7nqpH/aJwrUB2y8KyqX/v/3t90qyP6nAInUznf3aJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WR5gbj2TUdMVd1i/tki2MltW1ZM6/s6yixusxw19hQ4CMBdygNW6BZ8pt1nfBurOU
	 0nAZqLXj4Gr9Pl+Ww6H/Zve7KyRoUrxad03T33xeCvtbC7naG3z+lMns30qH2eW9Zt
	 aV5DMkr9pVIgolKdXlg4CPtHJ9dRWUaRUTvaDNHIQozIzvAC2s0MhkxeP+BfgOdDvs
	 V5mKS/aPksUVXiSlGvHGgf8xB3GXULdvSv83RnlM1VH1Lvuop8qgtOpw62WLNJIlJ6
	 8w73yONS2qqERpQ4PBpkB4hzcTGrFWpG6KU3fmfZM707T/pQ4H+86adx5/y7e+S8bO
	 CGz9bE0LBE36w==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()
Date: Mon,  5 Jan 2026 17:42:49 -0800
Message-ID: <20260106014249.364220-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010500-nutmeg-nacho-e072@gregkh>
References: <2026010500-nutmeg-nacho-e072@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_regions_of() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-9-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit eded254cb69044bd4abde87394ea44909708d7c0)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 51369e35298b..000b11f891fe 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -227,15 +227,35 @@ static void damon_test_split_regions_of(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 22);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_regions_of(t, 2, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "second target alloc fail");
+	}
 	r = damon_new_region(0, 220);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_regions_of(t, 4, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
-- 
2.47.3


