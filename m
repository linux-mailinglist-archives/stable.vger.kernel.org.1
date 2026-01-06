Return-Path: <stable+bounces-205006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A65CF6654
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C172530049C6
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD1535972;
	Tue,  6 Jan 2026 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNhUNr+f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FEB223708;
	Tue,  6 Jan 2026 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664786; cv=none; b=SFLdC53KKAaFH7CUatBuJJE7AFAy+w2DrcFj+bQyRncY3j/7YAPA/YOqcn3RMWlyfdZGt07Eqt0Cd9K1dhMpXeZYD+91CRnU5p+sN8bDGcfQRwfk0mEGZxEDbXNAgLcx5ShXxjW+3qg0k/QWlHLFtjzD2QH2KJOcA52qrdcM1mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664786; c=relaxed/simple;
	bh=Ab4WDO7JMGWXOeGJdqyJ22YBPsXg8Ugj+SNZfW3HaLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmWKLoiNKcgosnxIi1hgmnMiJqzdxTz+mLNuSGoq9bIcyMCuKAN0dGfYdT3imp1RC+3TyzrnZsNkWRNnaoEAiGTVNFnxkn3ARZlOX1F6X4IRn/CDiUz5WfXzJxYPRRAgLJa9y8DdebtdRALAJffBswUdYllIOwNN8v6NejSBRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNhUNr+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633CFC116D0;
	Tue,  6 Jan 2026 01:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664785;
	bh=Ab4WDO7JMGWXOeGJdqyJ22YBPsXg8Ugj+SNZfW3HaLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNhUNr+fwzfYQSRP5AfCeVxAsLmMU1bJ6PjZcMDPcLczVhIJFOjMBSOiSoZProRe8
	 gg4L2HluY1UeSLSx3o/fhxbdClUcFKmA0A/cuJwaiBXXtclCHzI06mpPNb75AyjZD7
	 I+Wnckw9uwnl/JMa8Kpl4YbCNSkewjD5T6R0XRy8l/Dh85ZNUep1lRU1S9FEHTfisj
	 rzuPNhmAt185O2wQIujRBv7I55ydNn/lM5ijdPQGkvm0beih9sUHd0fcDllIsaDWyv
	 rInvZAqn20TkdWl8S6WDIKf1+8lzpdfRRfCQhiYQfrBH2Q0nlkLSJMbPF2UIMinknK
	 9CltTgevZ51IA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
Date: Mon,  5 Jan 2026 17:59:36 -0800
Message-ID: <20260106015936.528512-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010523-protozoan-pelt-bf14@gregkh>
References: <2026010523-protozoan-pelt-bf14@gregkh>
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
index 3db9b7368756..48624cccf0fb 100644
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
2.47.3


