Return-Path: <stable+bounces-205002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFF2CF65F1
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 404DA3016EF6
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665321E08D;
	Tue,  6 Jan 2026 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqK/T0FB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABF21CC58;
	Tue,  6 Jan 2026 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664374; cv=none; b=j/i3kKf8Ugj3OklhFe+NYEvEnlWOzXffWjXbAa0ncNY7b5TTd8yt4FDTy6ilFY6W2FCjN59I5P3mwKxSNaoT3xuIDK4NQNBnkqMqWWG968jj4GfcORtvYQf3qedXrfJzFsctl43z8Y6snp+3MTX2AgunUBNc6OBjdm4Y8wJ6fdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664374; c=relaxed/simple;
	bh=Ho9VhnQYhFmNQHv4aKj1rzcirvBmSo49AaAqgnUDBwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4cFqkHRPVLjKD4h1LHbe95hV0GNI0pN2B863I9+FMCp2aO9tWVKe8z3WULMqbFwh4WkkzAOvxUKVYbW7MIi+ijuTxToSmyAAuMLB3Su2D97L+iScH3Qn0UfrHvyMFoS5EK8y0/ijCX1jjW896yK4xpkO/zBFBCp+dkvuSrPeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqK/T0FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE38C16AAE;
	Tue,  6 Jan 2026 01:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664374;
	bh=Ho9VhnQYhFmNQHv4aKj1rzcirvBmSo49AaAqgnUDBwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqK/T0FBV+dUlaodq9DRpKnn0Twree05ZaXLqDmKX8ZTXlUTKbuX4vlGkevCHGRSu
	 VndrHRvvhg9jrLaa5UInHctwhFZwYVcnKjATAusyl/qq11ZgNrzIZtqAPlVtxE2rgT
	 VF/dAtOkabpSrvsyEb5ab/2usAp4mLcAlgwQPbSq2l5P9nhyAOktl1eohMQMzAPoX5
	 IcwYfvNM/cfJO5Fcj4lIN1Y4Kul203rCJD8rj/O6iRGHKT10eh10ixYdvTfKfTiJGq
	 32Aj8UMhFOeS/g7GiFIebusQ8gOU2yGmiEynm+xnE6wJJ3NW2Y0fphRKy/4jv9wfYs
	 ou+1TU+smmwog==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/vaddr-kunit: handle alloc failures in damon_test_split_evenly_fail()
Date: Mon,  5 Jan 2026 17:52:46 -0800
Message-ID: <20260106015246.451905-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010502-dispersed-paper-9a89@gregkh>
References: <2026010502-dispersed-paper-9a89@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_evenly_fail() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-19-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7890e5b5bb6e386155c6e755fe70e0cdcc77f18e)
---
 mm/damon/vaddr-test.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index cfb3ba80a642..996fc14d2289 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -242,7 +242,16 @@ static void damon_test_split_evenly_fail(struct kunit *test,
 		unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
 	struct damon_target *t = damon_new_target();
-	struct damon_region *r = damon_new_region(start, end);
+	struct damon_region *r;
+
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+
+	r = damon_new_region(start, end);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
-- 
2.47.3


