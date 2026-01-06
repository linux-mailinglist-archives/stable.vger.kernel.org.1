Return-Path: <stable+bounces-204992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4844CF6579
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D91C300753A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A67523C512;
	Tue,  6 Jan 2026 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUT38ufG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E8822D9F7;
	Tue,  6 Jan 2026 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663526; cv=none; b=Tahf+95dmaFrE+FzAJGjnuqdLqgIk5VM5bXaeD7A3CFlHodeeZeyKYKmAETjRhlshWdwKiGxYeZRxGneYOe4GJBooQZSQp0p8Qwq9wTqYTWN0B2tw7FrhHKmZkYgcMsuHzdxA9YonblCZ8IWeqAqde79cqWnj4WyjhqB8hmy6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663526; c=relaxed/simple;
	bh=BAQ2ZGWXTB4j3tXQOVBkwsegPmpfTCxpba2Mvbv8KAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKVb//yuby5YMwfvP+3utNClZGUdOSy14vduY5KZ5dU+r+ZH+JmJK2ve+aa+FHXXX04i4RczSdXOWZTf4DTNNyZemE1mIt+dG4EQueaJlUix2u1LvP5L2wrcAj5FssQfpQ+vPlfxtCGHMIm7z0DiLQ0c7ZD3rnYd+5dkAeD1Fm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUT38ufG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90501C116D0;
	Tue,  6 Jan 2026 01:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663525;
	bh=BAQ2ZGWXTB4j3tXQOVBkwsegPmpfTCxpba2Mvbv8KAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DUT38ufGY4Cfa50mCkxwp2xuSLRQt/j3aaD6uVRJz9PugqUAj714USXJ+NTd4B2eO
	 u++ajk9WcM6ZwhVp/62Qh8Ywgv3ZaQid0Pr+/12T6Tk4nrvIxFRE3LlSfJtpurqkP1
	 sMgJJoLqU8kK5+roruWcO6d18CRUGC+wlKnML5sVfKaIIHm/wtMz+A8xVQFHUl6xIh
	 Y0NAfNeHDla0JRA1HMSlxYYleeWrQw5T3S0iw8P+S36udMmq+9FVdQP6/4esublEI4
	 1cQyA9Vg8/BSH/CWTbz9d8WQGtlbvDb2sBRyx9haC6UJDbWAo1NXsjVapTLLRmlyof
	 8/6H/j/cph7+w==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failures in damon_test_ops_registration()
Date: Mon,  5 Jan 2026 17:38:42 -0800
Message-ID: <20260106013842.323402-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010539-very-stylized-a9ea@gregkh>
References: <2026010539-very-stylized-a9ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_ops_registration() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-10-sj@kernel.org
Fixes: 4f540f5ab4f2 ("mm/damon/core-test: add a kunit test case for ops registration")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.19+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 4f835f4e8c863985f15abd69db033c2f66546094)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..9d1a4073d0cc 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -237,6 +237,9 @@ static void damon_test_ops_registration(struct kunit *test)
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_operations ops, bak;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	/* DAMON_OPS_{V,P}ADDR are registered on subsys_initcall */
 	KUNIT_EXPECT_EQ(test, damon_select_ops(c, DAMON_OPS_VADDR), 0);
 	KUNIT_EXPECT_EQ(test, damon_select_ops(c, DAMON_OPS_PADDR), 0);
-- 
2.47.3


