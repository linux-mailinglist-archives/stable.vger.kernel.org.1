Return-Path: <stable+bounces-204982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05398CF63BA
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E6DC302427C
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0183128A7;
	Tue,  6 Jan 2026 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izAv/qqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A096531283B
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662037; cv=none; b=E6tfmpnahHiFzsbDZJ9p+A43746jEYTb5jrfBJwjCx/zTHNxbxYDeABjhu2BRT5grKiIZ96iHAh42To0gTMAfRVe6HDoKPjH1oi2fhYB9yAq+Ms/MA28iVYlPPJgS9ypvyefJs7CTU3x8u9Il9RXns3yaMu5vSp6Sg1IrGP+uGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662037; c=relaxed/simple;
	bh=4wNs6BeShIuYafzC57y6xYLPdz5HaR6DxxmRS+0wajE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwZfpRVKR38xUHt1zCR9TkuDfQ1m11oNgEaRQrdlVaLA+xeEJwAvK/givvuUjhp3kuO6AWU+nL1uTjCI20+hnnSQ4xsOEjPY0DJTboew6vWn8LOfk90ObqBoOjyaYlM7J/g98BDT8YVBuYRhvrHMo3lekfqCore5KiyNhIsgNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izAv/qqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AB3C19421;
	Tue,  6 Jan 2026 01:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767662037;
	bh=4wNs6BeShIuYafzC57y6xYLPdz5HaR6DxxmRS+0wajE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=izAv/qqLaBfGayC8+VLmiuVoZ3EMKPH2wHWt+3/NG2EPukMrPkxcCPFgH8PCbXVQx
	 rcw9F2hmwkKY++jrZrAMYKrWsJ+Mg0+uDGgszM6/a2Y9UkdkKQYqpUd7YMKMi8aU8A
	 IewrRntQyewnuwXX6iNZSA6vlgOZzvhU5byQHgsCGJFEwy9nDH6+coq2lJO3aLI4VO
	 fQMO/kDJnOAeymcFnYDwo5UEVr+WrtgQPd73NFZYbiYbDau8Pr8Ioox6GOT60446Ih
	 LrqrJRkbj89Zp7RKgmQwLo9z1LiEfeKPrBoEacmGGMEQPBKl8cRE24LdJ7YzqyTNHr
	 h5ppbvipbwzPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
Date: Mon,  5 Jan 2026 20:13:55 -0500
Message-ID: <20260106011355.2872643-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010535-tumbling-unread-bbf4@gregkh>
References: <2026010535-tumbling-unread-bbf4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit fafe953de2c661907c94055a2497c6b8dbfd26f3 ]

damon_test_target() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-4-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core-test.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..0ef2324e3422 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -52,7 +52,14 @@ static void damon_test_target(struct kunit *test)
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, nr_damon_targets(c));
 
 	damon_add_target(c, t);
-- 
2.51.0


