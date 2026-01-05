Return-Path: <stable+bounces-204955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD63DCF5FD6
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 00:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A7A30635D5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A78253340;
	Mon,  5 Jan 2026 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bda0/7w3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426B3A1E7F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767655883; cv=none; b=cqKaOelbCAztlhkZ5ziA/q7EafO2zs+skTC7bKA1V9tUn3pmPeOmN2Gs4oWerhMpRM0KATFYBMAWUnF7JnWLszVFBjb+t8DgogMgH/4Dp1nwbGeRFn0r9t6teVJwJY5UnvgjflkTN8JA5lGmdhvCNrIpDCuOjpIQ92kDqhibSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767655883; c=relaxed/simple;
	bh=/Jw5Uw3PUn7VRU4dlV54sSwJf6pVUArjZEQDV4JofG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4qY+B1aAUAlILMyOK+bIV2RswhkRx94tG4MWG2DtSE9zvopqKY+grAHtZHcc+9uJh8Z2SjJ3Cus88trur3eyM/fn5j6MnyEkrS3ts5C21yTvHrXy84dY6wW7RiFwNLlb1PYWu1Sy28aiXt0FNxP35LGKo+ifE++F4ivP44ZwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bda0/7w3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F97C16AAE;
	Mon,  5 Jan 2026 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767655883;
	bh=/Jw5Uw3PUn7VRU4dlV54sSwJf6pVUArjZEQDV4JofG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bda0/7w3a1n92Ic9mcZvsnjBbH6KoD+D2ULHCsLRrnxNdqZALG+3UQ33tCJOW6Gex
	 b8ZEULsrHURDq024Du0ed3PsVHf3WftCiRFWhktATn3S4HMMSKI1mDRJNDtiZ4264q
	 fQqXnhWhBSp60G6stszjBKWkdA/+/KNdLieg9SKm4Mjp7iMaw3DHubi/RDjfXPKwsW
	 3fhS2ngdOu2oABmsG1L2fxGwA871ob4aoiRKPsf37j2sGf+UYJS/nG3dYKpvMAQD/d
	 HzSgTaIml03YTRBrDuP4IVvOM4aFGme8rw/BWaBZSIIiFKUQu31GixJ5hzQPf7fSoa
	 LrqmyI/eLpEFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Mon,  5 Jan 2026 18:31:20 -0500
Message-ID: <20260105233120.2845486-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010548-collage-trekker-25c4@gregkh>
References: <2026010548-collage-trekker-25c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 2b22d0fcc6320ba29b2122434c1d2f0785fb0a25 ]

damon_do_test_apply_three_regions() is assuming all dynamic memory
allocation in it will succeed.  Those are indeed likely in the real use
cases since those allocations are too small to fail, but theoretically
those could fail.  In the case, inappropriate memory access can happen.
Fix it by appropriately cleanup pre-allocated memory and skip the
execution of the remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-18-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a149e354bb26..7367c1e29112 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -136,8 +136,14 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	for (i = 0; i < nr_regions / 2; i++) {
 		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
+		if (!r) {
+			damon_destroy_target(t, NULL);
+			kunit_skip(test, "region alloc fail");
+		}
 		damon_add_region(r, t);
 	}
 
-- 
2.51.0


