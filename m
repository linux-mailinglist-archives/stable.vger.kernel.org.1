Return-Path: <stable+bounces-205010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2033CF66CA
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3385130221BC
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E36822129F;
	Tue,  6 Jan 2026 02:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYQDlDEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B5853E0B;
	Tue,  6 Jan 2026 02:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665302; cv=none; b=Pt1gcC+RXRTEaBUVwBcnF0fvBu7plmgLj7kTwbxN8pODPj6g8+wJ1JhEwvZa4y4RX2B3eroiI0zjuyKBlOUP3KeE0ILFGIL7eZiJHms7pBV0iCVz5iGUMAX54QIgzXcAHsPh/zDPCFCK3sTb+yvO1HfvguU6rsYEBOrv9D7Tqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665302; c=relaxed/simple;
	bh=iseoCCYm9lmQhGVwn+rvy0B4L+l9mfb1IhMTRlaKrhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qajJPRGhNUdHr2GXlsVN4zbs66gLAIJFOh5zCjMGdkIPmg5GgafgUe/SiRNQTUADFV1Q1XNafiyzlo3tDRRb/7TkxIPLsJ0IM2sz7tlUT4fCnKAKSiA5kP1XBqDN89r7YfRQv44qcw3Pz7swHhNdvNFlDv5lgtNs7nP5P6Z8Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYQDlDEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B486C116D0;
	Tue,  6 Jan 2026 02:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767665301;
	bh=iseoCCYm9lmQhGVwn+rvy0B4L+l9mfb1IhMTRlaKrhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYQDlDEmHLhNfdIVvUT0OfDdP8zPs5HSgHS05IYl54HP8vExY9bYwRonYoekyvmY8
	 XkV1ENhYnTpmPbtHoYzTwFD6erTjx8PcA+9Ny1/qE+YdS1Gh46KOer554OrNU5+H07
	 6n2jARaK6FnuwXh5rStm8TZEr9PKi+VQAg49F9yr2ROC17tMoRaLqN1Ze/s+rCrS5T
	 w34TMuIiMbgiJfCaIxCJOcj19zXAP3vNaAUI4aUMQtm1ymtm+ExMdXSGPxsjw4LsIU
	 bx/w+C0oRGw0QQ1cjw3pCXO6lN1SKmOnhOQ/DHqrndGFFqH9H5QQ5edCrZTivB7tll
	 nNxDgm8TYp1dg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle alloc failures in damon_test_set_regions()
Date: Mon,  5 Jan 2026 18:08:18 -0800
Message-ID: <20260106020818.591986-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010549-bloated-activist-2c21@gregkh>
References: <2026010549-bloated-activist-2c21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_set_regions() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-11-sj@kernel.org
Fixes: 62f409560eb2 ("mm/damon/core-test: test damon_set_regions")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.1+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 74d5969995d129fd59dd93b9c7daa6669cb6810f)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 3db9b7368756..7e3ae12f6565 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -270,13 +270,26 @@ static void damon_test_ops_registration(struct kunit *test)
 static void damon_test_set_regions(struct kunit *test)
 {
 	struct damon_target *t = damon_new_target();
-	struct damon_region *r1 = damon_new_region(4, 16);
-	struct damon_region *r2 = damon_new_region(24, 32);
+	struct damon_region *r1, *r2;
 	struct damon_addr_range range = {.start = 8, .end = 28};
 	unsigned long expects[] = {8, 16, 16, 24, 24, 28};
 	int expect_idx = 0;
 	struct damon_region *r;
 
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+	r1 = damon_new_region(4, 16);
+	if (!r1) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
+	r2 = damon_new_region(24, 32);
+	if (!r2) {
+		damon_free_target(t);
+		damon_free_region(r1);
+		kunit_skip(test, "second region alloc fail");
+	}
+
 	damon_add_region(r1, t);
 	damon_add_region(r2, t);
 	damon_set_regions(t, &range, 1);
-- 
2.47.3


