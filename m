Return-Path: <stable+bounces-204964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2585CF619F
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C1F330049DD
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E91B0437;
	Tue,  6 Jan 2026 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUxUiFk0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8371BBBE5;
	Tue,  6 Jan 2026 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660276; cv=none; b=UlGqLFWg/A9olKPLA8yHsZQToftvFl0uzuvPPs6fuoSncNLy2+U9I4M59T29rVr7z/gpQz+lyH6AUEDZWrWJcv1dCruQ3kJWlOrLtqII8QwXtQecBB5+7KA+IZYNbuvl4d3HmOcAoITnSbH71FMpvFVreGUY7cLHxYKGt1ywaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660276; c=relaxed/simple;
	bh=rypRBbUhFmIhN9p1KepjqWnIuOGALigUlifp0Hm3Yr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCvaERGQnh4HCmZcTswfG22yJsx3oEU+a1165bHN/t/ErdPhTa1GirCm0ufSvwwqpey3NJaMrCmTw9Kj5BTz53xxsIdYngYLlmYc+AGWo/EiPfJcG+7mIRzy4mTE1wHr0S0yn87C1KJ9jHWJkQnfJSuUbRCblU8fvsMvdu/AJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUxUiFk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4608C116D0;
	Tue,  6 Jan 2026 00:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660275;
	bh=rypRBbUhFmIhN9p1KepjqWnIuOGALigUlifp0Hm3Yr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UUxUiFk0msCmCycXZMlIDli7WAfjBArkcR5DtQwQLusF5et+t7vSUKjfnmitnRUwl
	 CtsHBYQAXnQ7oiZoWuAVx60qAq6ayqVVShSn35wFxC1DN3hyaeV6Y9jBmUv5EOCXb4
	 eAbmZQe+MyrwjLNZKbMC2W7hzZEA9vxNAVpgtp9BG4DJHrrbOhkJID4cYKveC7Fm1u
	 qfuoC5QpSt0Lr0W4gwuRO+tBZZU1UL+AOr2Cqo12ul9V/SL+7TjBxGrAUfg/Oux+iG
	 Ne/YyWyOtw0LXceieK7THpzP1y4zBs1YyPeypequTQjfZ+yL0nmZvFuzOW6CU+QkLQ
	 Sa3hrtHCOcaag==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/vaddr-kunit: handle alloc failures in damon_test_split_evenly_fail()
Date: Mon,  5 Jan 2026 16:44:24 -0800
Message-ID: <20260106004428.101795-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010501-online-amenity-037a@gregkh>
References: <2026010501-online-amenity-037a@gregkh>
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
index b4fc21ef3c70..fdeaa32c23ab 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -250,7 +250,16 @@ static void damon_test_split_evenly_fail(struct kunit *test,
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


