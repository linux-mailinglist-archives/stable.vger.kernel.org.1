Return-Path: <stable+bounces-204981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A0CF6320
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C233B3040A63
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A59274B3B;
	Tue,  6 Jan 2026 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYbEgjbo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E4C2B9BA;
	Tue,  6 Jan 2026 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661884; cv=none; b=lxIxupegAJhKwEqgsHS+iN4xljJ4Cc+hswde1wuHmasuAysNW6uLMmUGy8e6Ktpw0L/qOa1TpsltP/oOTJoPp0Zw3+NF3iykGVXEZwJYEOoCk4vGEPjOO+vRfXic2n1JD4yxWa45EjfS8iuHZrqblKhFEaFjkqqh0++K6UR8tfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661884; c=relaxed/simple;
	bh=PAvU1Kx4xGbF0cjgosGw4kTvZZk9bqu7fFhC2vPDYf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umxgJk6zhrE5BhUwLiGwvxeBU3Q/KA4bK1dmR8YiJk+C3lxU52EQAHpNcXYV2QDtNwRqDFur4Tc27ORHkuoL8CXSALmQGYoDkpfgostaGpVqLpLuhRKIq5xWzXJoCVTHpFLZSRLPJ0KI2fARWJaQeY9HHdPOZ8g3EFXXcPfmIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYbEgjbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA08CC116D0;
	Tue,  6 Jan 2026 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661883;
	bh=PAvU1Kx4xGbF0cjgosGw4kTvZZk9bqu7fFhC2vPDYf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oYbEgjboVqfV9vG9RTWDGb3ZFil9zEzvBXzY8Y8zaTUzrgRTcGYmesbhENtaisIDS
	 XkBM5nc4KwcMaazdbc0vOGSJ8wRRsTd2xqulWaJ74/7+jOYl0zSAFCrRdecjcbIj0D
	 rfjUq8r3JCRYgGdYMN9sobeQX3CRqHHoLdd6qgoU8qt9ejreAhtJtpMkPKkWK3nG3t
	 Hlc15ZsCSLQZXhDWVqQi9O6cxwczuJFdR6JQxaa6j3oY+GejmbfFLueZtkDCgo18py
	 jabUx8WfpPpu4KJ5bN8pWwnz7kQFa7OvB4SHSMfGUBt5znia4OLjdvIhhDGDlkzoz5
	 BBz4SoGZCZnwQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failures on damon_test_merge_two()
Date: Mon,  5 Jan 2026 17:11:15 -0800
Message-ID: <20260106011115.240757-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010518-overflow-headgear-2f02@gregkh>
References: <2026010518-overflow-headgear-2f02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_merge_two() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-7-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3d443dd29a1db7efa587a4bb0c06a497e13ca9e4)
---
 mm/damon/core-test.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..c20f6bd11f36 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -145,10 +145,20 @@ static void damon_test_merge_two(struct kunit *test)
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	r->nr_accesses = 10;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
+	if (!r2) {
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	r2->nr_accesses = 20;
 	damon_add_region(r2, t);
 
-- 
2.47.3


