Return-Path: <stable+bounces-205003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FECF665D
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C6F1307BE7A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE86F223DE7;
	Tue,  6 Jan 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+PTyfOb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6912248BE;
	Tue,  6 Jan 2026 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664493; cv=none; b=AcBiDE8I3rJ2suheSBw0GeOGyh+t4axrkmNBsF85+UDuXsPt588pb103ppC05Aopv38uRmFj89ryw82cRYTzMhd1mZXtKvPRI85EYYbPravc4IKs4L8g5Wf6o1D7TeXfmY38vLhV/KffLlerr6yqgOCiaIT5iuBa3d8dZryIRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664493; c=relaxed/simple;
	bh=ar0hp0CUqBZiWV82FqfGDwRrL3OzvDOWSXVvpNwQ1HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6QW9Ibaj01fDP/kjpPD0l/TaCcbJaBDFxsOA6exgk0UxLkqYQ9isY9PVGQEJ9v9LSEe29UulcnAHbY5zdchdmh5Lsu3UoZJxYCSLnAqY1mgCGCTpongrxGJucqMG0dEmm9ue968iSQsba97dpNWFuLSU+Wv0nR/AfPNUA6LKcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+PTyfOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD23C116D0;
	Tue,  6 Jan 2026 01:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664493;
	bh=ar0hp0CUqBZiWV82FqfGDwRrL3OzvDOWSXVvpNwQ1HU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+PTyfObavF+RUquZt1HK8xxKQ6xW4pNpRwUr39RSp/b3HmPm6pxnytkYxPo6Laga
	 dnIip6lqEOPxpI1lWxKVd+UXmq+3V92/Uz0Dm2NaAr0Q18eY+JBRfmn2aQFPl2mdgO
	 8CLZfG0NB3mrILhIgmN39BD/nBskIMVJheVDyym91c9i0ITQn016j/NOb76uK/uPAw
	 kkmr/ED6whWsAkpZIK1hp050w6KkNPv8BWDAFLXb/4uXbEXccKKxMkRwNk3S0auiOj
	 HQLpizmVmY91RbbSW+75rWChJocmBaQl14X4pYsGGX36wSLp618HNH1ixmaMeYQ5iS
	 3zlWl7Ba0NjCw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Mon,  5 Jan 2026 17:54:45 -0800
Message-ID: <20260106015445.486289-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010547-prankish-amuck-8ac0@gregkh>
References: <2026010547-prankish-amuck-8ac0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 2b22d0fcc6320ba29b2122434c1d2f0785fb0a25)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index cfb3ba80a642..4bed5f327dfe 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -128,8 +128,14 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	for (i = 0; i < nr_regions / 2; i++) {
 		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
+		if (!r) {
+			damon_destroy_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
 		damon_add_region(r, t);
 	}
 
-- 
2.47.3


