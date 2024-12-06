Return-Path: <stable+bounces-99980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA959E77B9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FE518851F3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712C2206B4;
	Fri,  6 Dec 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0VwMMwK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF422068F
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733507631; cv=none; b=qFykyhjU5lTO/VOq+g2efxjO4SvnwfsZuLZKYcnJ4uXyLcVCdV371rygaaKaIUjlReZPjMQRYDfAmjzR5qra56yu3vgRHnIRIZyWfTw2+mubcdByArn0XtrHhHmctf6VFWiPz8woE0yuB3oG79SDU+fu22Y/0POVUi08zYHHLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733507631; c=relaxed/simple;
	bh=3KzmO2rKt6/Nnmiu2Dwo3tpt3qgeSc8eB8qyjNWbUuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0fgVaqmVDbUZX6vrXjA4NlYcRagqftrYrJpvzkmPQQVG5hBONUdYkvxlM7SNNGBcfNEJ+v/lVTl6BTXP5fzCiH0naUgnXlQZXGXY4HG/REF9AqC/xSDQrEpTmyveXLlMN8cnLDeHkQFDUQ5fybBFUcmB0rHWd4Pq+6Viao58N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0VwMMwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1624C4CED1;
	Fri,  6 Dec 2024 17:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733507631;
	bh=3KzmO2rKt6/Nnmiu2Dwo3tpt3qgeSc8eB8qyjNWbUuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r0VwMMwKIaxdkJD+xFi5w6oHC75IE83RPrXhBhMyrAdzX3PBuHGSDBssrAEBXUrQw
	 e7o3KElJerlt/0o4bLY6+AwIqkIdMnEcNshInca7ROpkGRdA0qi3ErJyszmQ9CGLHU
	 TLURX3hgFmKFg7WCdCX2w+/KwkdqKk0lrpzBqNoeVa6pxGwWUSKDpCjdHp9khYBtHR
	 MGVfbKVntMV1rrtfdTuoTZ6MTJhDPn/Ri9ohCoLHgxSQ4tbOiGqUD5VGoAzZEgeTZQ
	 AWq6DlHHaVkfPeQR9/YswzmfTv46Byb0rmYAjFx6vr8pMCThO3H3Inf1uz6PekhhlD
	 OsyDjbT7SWwdg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: Zheng Yejian <zhengyejian@huaweicloud.com>,
	SeongJae Park <sj@kernel.org>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Ye Weihua <yeweihua4@huawei.com>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()
Date: Fri,  6 Dec 2024 09:53:46 -0800
Message-Id: <20241206175346.114805-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2024120624-repeater-require-e263@gregkh>
References: <2024120624-repeater-require-e263@gregkh>
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
FYI, the cherry-pick was conflict-free, maybe because my git was able to
know the vaddr-test.h path change[1].

[1] https://lore.kernel.org/20241206173426.75223-1-sj@kernel.org

 mm/damon/vaddr-test.h | 1 +
 mm/damon/vaddr.c      | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index e939598aff94..cfb3ba80a642 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -292,6 +292,7 @@ static void damon_test_split_evenly(struct kunit *test)
 	damon_test_split_evenly_fail(test, 0, 100, 0);
 	damon_test_split_evenly_succ(test, 0, 100, 10);
 	damon_test_split_evenly_succ(test, 5, 59, 5);
+	damon_test_split_evenly_succ(test, 0, 3, 2);
 	damon_test_split_evenly_fail(test, 5, 6, 2);
 }
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 260f0b775bfa..708f281c1b6b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -67,6 +67,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 	unsigned long sz_orig, sz_piece, orig_end;
 	struct damon_region *n = NULL, *next;
 	unsigned long start;
+	unsigned int i;
 
 	if (!r || !nr_pieces)
 		return -EINVAL;
@@ -80,8 +81,7 @@ static int damon_va_evenly_split_region(struct damon_target *t,
 
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


