Return-Path: <stable+bounces-205013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19177CF66DC
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9A323015863
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C80E22FE11;
	Tue,  6 Jan 2026 02:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7NhV2II"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79B223DC1;
	Tue,  6 Jan 2026 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665642; cv=none; b=NKD1dG3TNiVQ4ZcbigedizS5GBsdnKuFJShcnNE/Q6e+Zc1osb5B13zIjEtTMiplmllqSX+pee+PFm/Tz8ZFA8YgSzGzAe3XUtOf10CXDut22DVv/3Kr3BnSg3E/n/DdE0i9bL45CYOg9QpkgMOOu78xD3EVXf+QbrKhe1JUfT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665642; c=relaxed/simple;
	bh=foo8dZ8ooZ361iItGG2DGnolXo5nfd6ojuACa7Piins=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plFP7qbCNZn7iQpJkfQ4aLLLnOXLPSob/5ImGTT6JbiU9vIRRdJ8TNqax37bpX5Fvc+VOpLSFJDDVY+JYq1tCSyekzAPmwukOUQO5BqvVhjV0jYLZePxNWxRYNVeCv5+ypifbRn/fV46SIujePLWrRt3jGxtvTdwUfmQt9w8+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7NhV2II; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9A4C116D0;
	Tue,  6 Jan 2026 02:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767665642;
	bh=foo8dZ8ooZ361iItGG2DGnolXo5nfd6ojuACa7Piins=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7NhV2II0w+UT/uGmvpxEMw+bjeN19ZIteSYs8gal2tFZggaQM5y0xHbGfsINanwQ
	 +T1l8tm/e9mCWckjwFGoFUG4bACxAiN1z2QowvN+jJllQlIufcaB2PWoDOU9Kee7r3
	 byUkLZe7i4YV/e5CZ60XB3BJkQ5WcvoCDAgSntvc1SdN1pqPQKJyFWaNR79YiiP3uD
	 dx6QbE/5Ifz0cu3VWkDjSoVwDLPygyKPyHF0oGhekSC/r+In7X1Pnhb3pUdNIXfpNc
	 hKPFQyGda0p3NKVZi7NJ0kYMFUw0zp29aIHW8oYANjIjVzkcW7tvu6qz9XgNIz95s+
	 cNOzkKiOc+Epg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
Date: Mon,  5 Jan 2026 18:13:53 -0800
Message-ID: <20260106021353.624886-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010523-shanty-awning-7093@gregkh>
References: <2026010523-shanty-awning-7093@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit e16fdd4f754048d6e23c56bd8d920b71e41e3777)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 7008c3735e99..e5917267551d 100644
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
 
 	t = damon_new_target(42);
+	if (!t) {
+		damon_free_region(r);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_add_region(r, t);
-- 
2.47.3


