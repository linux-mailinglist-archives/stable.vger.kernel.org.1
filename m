Return-Path: <stable+bounces-205021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F0CF67B2
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FC20301F27F
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7A022A4E1;
	Tue,  6 Jan 2026 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX5Pq5Ea"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836F021FF46;
	Tue,  6 Jan 2026 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666889; cv=none; b=mHX9H3mHzhRR6jLQPQVd//gxcuSfiaRB5sCKbpHFx5WAwvPpMV6kzhsygRZtDRl2lV+kBO952lPcaXhwygH2SSEmwhFxPX+U4eMrXYt7ixPBAD9G08sX1iMtXNaGRmK0wbeGvtw2kFPjvtmvTb+ZRkJMKDbufGj9Il3gBHgw53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666889; c=relaxed/simple;
	bh=z8Y8AsBC8QxiZa0A+c+9pVzVjq6iXKgyDsrVpmBPEHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/JBr/Ih0qP/+SZQPCRFLfKRA+L2mQmiowUbuPi5Q58khA/T9j0xcuUxuXYxKETasLoOEDI7ZzpFNQOwAiEYDQfO94KXzZSNn4W9COdeYyDubjtlj8mUqTRBQqLgyS33sf/DqNhurOJqMl4S24B51CiLr/YsCicd9nyCH7yxE7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX5Pq5Ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7FEC116D0;
	Tue,  6 Jan 2026 02:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767666889;
	bh=z8Y8AsBC8QxiZa0A+c+9pVzVjq6iXKgyDsrVpmBPEHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XX5Pq5Ea9QYoaARlrV9r8tbC9qlr4QNER1LTHvSsx/v4eYltWyHZqYYrqStaHa53k
	 0J2xCd7csbBrCdsp5uO1RABBQmz94P3Lr4f/gbrTyMIiT+wRX728t+MHR/184z3zOY
	 kXvCYjegXlBJJFqauGVBFYLJF8IwCzGfDvwq3Hdy6cmxtQjs5GZ8s3C8LMRA0Gw41R
	 nwarYdhZbTC/T8QQTKvhcycMFKSJ6RuSPzR2o/o7rLNZPghAJmw3gianSNqzTyI3iQ
	 rptJWrucgoe96mZ7FaQj8HnDLRdos3zFevZTsjVSqJ42Y68j6Y/ow99xOH1sL4/mfp
	 tr8NfBX/ZNUAQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_at()
Date: Mon,  5 Jan 2026 18:34:44 -0800
Message-ID: <20260106023444.744762-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010508-trapper-petite-82ff@gregkh>
References: <2026010508-trapper-petite-82ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_at() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-6-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5e80d73f22043c59c8ad36452a3253937ed77955)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 3db9b7368756..4846d645d278 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -123,8 +123,19 @@ static void damon_test_split_at(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
-- 
2.47.3


