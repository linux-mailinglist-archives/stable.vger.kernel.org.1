Return-Path: <stable+bounces-205015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FAFCF6767
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1EEB306DBEE
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D0B2D0C7B;
	Tue,  6 Jan 2026 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM9d+APK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE6242D98;
	Tue,  6 Jan 2026 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666066; cv=none; b=LfBwWvymiWaKFLyzKJSmLDf+sewampUFv7ZnYd6qA8QRDcGamD1wX3mXwwhVu8I42oj7fOH+MmFI/Gdx736KBLbrqHXDVkr03qDqNabQZaJuYC7MO1+wJtlWSm0SBdfRwePXaT2Vlf4Op9E5yYMTa/wWNmAZMWbfWyS1kfEsAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666066; c=relaxed/simple;
	bh=Q2M7M+yfC7QEXVcvijT4e1fppF7hqMyLD6nQdvN2Fzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5o3+7HsIR6A4uq9YWt1F31TXAQxmzEfRAP/nHBcmFNhx2HwAS3tNTQgfT59eB4mKOQlTmWz+/ZcT/ZCYizuKJmjJMpMup70PoMm0RQueBzqtICbJRZkVAXYV/ybayjrPOlmJVUf5PXf8DFPj23TeCqEbUm1lY6tRtLe7oFBG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM9d+APK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320C4C116D0;
	Tue,  6 Jan 2026 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767666065;
	bh=Q2M7M+yfC7QEXVcvijT4e1fppF7hqMyLD6nQdvN2Fzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SM9d+APKfWx6ea7pMjHHwCKHKfzRiD56UAtfNKkF+pniLkjEprAuhtwvI1p1ZjSFL
	 1VXw6qMTizki76mDZSnMYCR9FA8efH+rZVVwFlrI4PkoDMaFLuP67fqCMLSNZi3zLZ
	 YLgJEtQQc53UxX4KibblTjJNtOErtHstV9VLPcFtdITVvHovcLhFrRk9m+eDwCh85a
	 lbyvBz6Uyl2oDj7UBT/47ZxylwLTyaKqI/Mp46fdHvSJQp5KgH3dsW+OOE04W5xHuG
	 GHy9TRvN8wZNw5m7V7VdGK5xAhhmdgFErGlTcEN6g9bFmbk5l1gi8Zv7lrcRRU+h71
	 72fIeH7qOHzvw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/core-kunit: handle memory alloc failure from damon_test_aggregate()
Date: Mon,  5 Jan 2026 18:20:57 -0800
Message-ID: <20260106022058.657909-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010546-gibberish-fracture-b6c1@gregkh>
References: <2026010546-gibberish-fracture-b6c1@gregkh>
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
 mm/damon/core-test.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 7008c3735e99..e60d47b344b0 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -86,12 +86,22 @@ static void damon_test_aggregate(struct kunit *test)
 	struct damon_region *r;
 	int it, ir;
 
-	damon_set_targets(ctx, target_ids, 3);
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
+	if (damon_set_targets(ctx, target_ids, 3)) {
+		damon_destroy_ctx(ctx);
+		kunit_skip(test, "target alloc fail");
+	}
 
 	it = 0;
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


