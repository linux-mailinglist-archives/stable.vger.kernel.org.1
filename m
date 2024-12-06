Return-Path: <stable+bounces-99984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53F39E77F1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 19:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86265285928
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C811F3D35;
	Fri,  6 Dec 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9pxE4Gg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EEE256E;
	Fri,  6 Dec 2024 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509007; cv=none; b=YVwylflXfT67C/I2wYk2/B2qRPNNarrGqmJk1P50bslW0/S4mtvME7N9rv3EhE8/y2jV+Uqg3AnjO9Om89/ZfoMuCEZ7DDeDJepULLTcyqdt1oUx4YeifKqw5OuAeq41zHYKK+E7Q7m2eRgm87fSeoDaomDDoGDqEHJG2Y6Mf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509007; c=relaxed/simple;
	bh=lGINZh+0lSO+fouVKk+htbdhq62SzZUm82oIXJU7XWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cxe+6vf9JuGO3XM2ptfOan3Hh4bYOIV+MBCVuDwanPhvDlCnOC5wDyZahm8OtJBKHSfljvjrBDbPghpYF5X5LeolXvmqBi06LQmka7RayIAgrE05Txidz3Lw3F3h1a+uDLaNouzyS1/QaQsiC/yjjQy6A7sO2uCLVGCw9mUPc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9pxE4Gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C15C4CED1;
	Fri,  6 Dec 2024 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733509006;
	bh=lGINZh+0lSO+fouVKk+htbdhq62SzZUm82oIXJU7XWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P9pxE4GgBC5HXHNSVIq9zZOVCAgT0XffH+dkwiQCo9OcjFcz3VYBd22OdR6uVr+5f
	 enw4DQK6w6c5vpJpM755jmWxa7h1vwhFJigKEJ3XTjTA2TJwAM+1QNepx2J91ewqvS
	 r3zp0tyMb2A/6ZO2BohYpiUpdtq0C4hxsz+wmmNS0neQn4WOI378HiU6a7+ZPWxt82
	 xOPq8C3RpxJmNEhpt7vxQ3Odn0qgAgJeMMFJtnGlmYvyze661Umr7QjuywxDukWiNu
	 npq4lU9wNmr2GaB6wN72J0moTvFFmPd0ThX64AawhHw82vOMx1gXKXjNVYytaCZgtm
	 V4IrBTMb4PcBg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	SeongJae Park <sj@kernel.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Ye Weihua <yeweihua4@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y 2/2] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()
Date: Fri,  6 Dec 2024 10:16:20 -0800
Message-Id: <20241206181620.91603-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206181620.91603-1-sj@kernel.org>
References: <2024120625-recycling-till-0cca@gregkh>
 <20241206181620.91603-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zheng Yejian <zhengyejian@huaweicloud.com>

Patch series "mm/damon/vaddr: Fix issue in
damon_va_evenly_split_region()".  v2.

According to the logic of damon_va_evenly_split_region(), currently
following split case would not meet the expectation:

  Suppose DAMON_MIN_REGION=0x1000,
  Case: Split [0x0, 0x3000) into 2 pieces, then the result would be
        acutually 3 regions:
          [0x0, 0x1000), [0x1000, 0x2000), [0x2000, 0x3000)
        but NOT the expected 2 regions:
          [0x0, 0x1000), [0x1000, 0x3000) !!!

The root cause is that when calculating size of each split piece in
damon_va_evenly_split_region():

  `sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);`

both the dividing and the ALIGN_DOWN may cause loss of precision, then
each time split one piece of size 'sz_piece' from origin 'start' to 'end'
would cause more pieces are split out than expected!!!

To fix it, count for each piece split and make sure no more than
'nr_pieces'.  In addition, add above case into damon_test_split_evenly().

And add 'nr_piece == 1' check in damon_va_evenly_split_region() for better
code readability and add a corresponding kunit testcase.

This patch (of 2):

According to the logic of damon_va_evenly_split_region(), currently
following split case would not meet the expectation:

  Suppose DAMON_MIN_REGION=0x1000,
  Case: Split [0x0, 0x3000) into 2 pieces, then the result would be
        acutually 3 regions:
          [0x0, 0x1000), [0x1000, 0x2000), [0x2000, 0x3000)
        but NOT the expected 2 regions:
          [0x0, 0x1000), [0x1000, 0x3000) !!!

The root cause is that when calculating size of each split piece in
damon_va_evenly_split_region():

  `sz_piece = ALIGN_DOWN(sz_orig / nr_pieces, DAMON_MIN_REGION);`

both the dividing and the ALIGN_DOWN may cause loss of precision,
then each time split one piece of size 'sz_piece' from origin 'start' to
'end' would cause more pieces are split out than expected!!!

To fix it, count for each piece split and make sure no more than
'nr_pieces'. In addition, add above case into damon_test_split_evenly().

After this patch, damon-operations test passed:

 # ./tools/testing/kunit/kunit.py run damon-operations
 [...]
 ============== damon-operations (6 subtests) ===============
 [PASSED] damon_test_three_regions_in_vmas
 [PASSED] damon_test_apply_three_regions1
 [PASSED] damon_test_apply_three_regions2
 [PASSED] damon_test_apply_three_regions3
 [PASSED] damon_test_apply_three_regions4
 [PASSED] damon_test_split_evenly
 ================ [PASSED] damon-operations =================

Link: https://lkml.kernel.org/r/20241022083927.3592237-1-zhengyejian@huaweicloud.com
Link: https://lkml.kernel.org/r/20241022083927.3592237-2-zhengyejian@huaweicloud.com
Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: Fernand Sieber <sieberf@amazon.com>
Cc: Leonard Foerster <foersleo@amazon.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Ye Weihua <yeweihua4@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1)
---
 mm/damon/vaddr-test.h | 1 +
 mm/damon/vaddr.c      | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 95ec362cdc37..5531766ff09f 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -306,6 +306,7 @@ static void damon_test_split_evenly(struct kunit *test)
 	damon_test_split_evenly_fail(test, 0, 100, 0);
 	damon_test_split_evenly_succ(test, 0, 100, 10);
 	damon_test_split_evenly_succ(test, 5, 59, 5);
+	damon_test_split_evenly_succ(test, 0, 3, 2);
 	damon_test_split_evenly_fail(test, 5, 6, 2);
 
 	damon_destroy_ctx(c);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 6ad96da15081..6d8036671e60 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -69,6 +69,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 	unsigned long sz_orig, sz_piece, orig_end;
 	struct damon_region *n = NULL, *next;
 	unsigned long start;
+	unsigned int i;
 
 	if (!r || !nr_pieces)
 		return -EINVAL;
@@ -82,8 +83,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
 	r->ar.end = r->ar.start + sz_piece;
 	next = damon_next_region(r);
-	for (start = r->ar.end; start + sz_piece <= orig_end;
-			start += sz_piece) {
+	for (start = r->ar.end, i = 1; i < nr_pieces; start += sz_piece, i++) {
 		n = damon_new_region(start, start + sz_piece);
 		if (!n)
 			return -ENOMEM;
-- 
2.39.5


