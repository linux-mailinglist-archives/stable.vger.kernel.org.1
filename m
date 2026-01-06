Return-Path: <stable+bounces-204988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A860ECF64F5
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FC43042FE2
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC55313284;
	Tue,  6 Jan 2026 01:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM94V/Yk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52323314A62;
	Tue,  6 Jan 2026 01:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663290; cv=none; b=leuZAJ9qrv9kXLCc3Qui7e2Bn5aIdAHFQ6fgHl0w0tpLghVAqsfMovvVGfaoTT5FpHtkW0cx8qUvk+2vpPb7+AriICLLiW8YYz49fGptNUTrlZ0yWuqRQw99NjOf9fTd/evqoXPOE+CmNINWw6R1ckIazqMnnJFWj6FQe5SXObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663290; c=relaxed/simple;
	bh=TYGAjF/EMfMwcdaIDc1cALfyTquNVLUomCeOnLJuMFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7DekK5k++UJjnW4e3qkH1St0Ep1/Prpyj6trJ4CvaD0f7rT0G3XYZYvq7g3NnJrU99AsnNvaHTAXNEFnLuj4HrFeMKnyUhfsoycD0Yh3qmlUqtvMTLruZ6qtuBFA3l9dkLup+3141Wk/xOKFIn8cE+JNzLf8Wq7c4+NtbAOjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM94V/Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E24C116D0;
	Tue,  6 Jan 2026 01:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663289;
	bh=TYGAjF/EMfMwcdaIDc1cALfyTquNVLUomCeOnLJuMFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PM94V/Ykd3pHOJpjdmuYbqk1EBjuAaSE2tNaXopHoKXDX8CXTJRmQA2jxf1ehLdXr
	 ctLS9sfKPiB59h7T/FjWc1MLHwA8YMnrBGFH2HmPRC8+ITM4dWTIK5pr5BLo1Tv0ku
	 IvhMFE6dbdiuAI+bJG22gzEa/O6DtbS6eRNtLgRj6gmcRFHOHLx3LHWFyY1NopyBFW
	 8o3XPS0oXqXq53ry/jTpxrNkKm8dZf+t6BvlAfiv43ur4+6r8reyVjM3xgTAiOzPcN
	 Xo5FCwOli8AW1Lg5mCnkK9DvDXwjdyi/f3odw0kjOW1GyvCStWycIOEA1/QySksVk8
	 zEaSsAUE6y5bA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failures in damon_test_set_regions()
Date: Mon,  5 Jan 2026 17:34:37 -0800
Message-ID: <20260106013437.296300-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010548-consent-fried-e16b@gregkh>
References: <2026010548-consent-fried-e16b@gregkh>
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
---
 mm/damon/core-test.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..6629407cf986 100644
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


