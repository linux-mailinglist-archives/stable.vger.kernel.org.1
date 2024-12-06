Return-Path: <stable+bounces-98993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B509E6BC0
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1B516DAE4
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488321FCCFC;
	Fri,  6 Dec 2024 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lGfdY9I/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD01FCCF3
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480186; cv=none; b=njWKX7H2ozLYRm41gP82lMPM27ILXYLYtRZc/gbDb4qmPupAG/CF2stD4X+Xc8/cv4uMPyekc2DAraCZuIupcjszT+kdbRnKeV/i03AnyRgrbE+5DKo6POTUKYKY5zFKdgenB5ehyj4Hi4JuashifhjD62YzQU9mS50zxx/IFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480186; c=relaxed/simple;
	bh=NflfNIHMo7C4HRPvvHHlvdanxaC4O9uE0yYoWeWO8mc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LcT+1MbQguobS8AjJ1bNdwQD3N8dOFifDkw0KpeQGeTRXXtlJ8kGOBjGVqWmjP/HW3Guw2CgQoVWvsYbyfX8ieNNN+bXkXLYH7tm3TkCiAednLA4SpQVtlOYD9F7BDKE1XuXPujBEIDrr8GjWFm4NrtXOsBcCthZgqHihCeWyho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lGfdY9I/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6285BC4CED1;
	Fri,  6 Dec 2024 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733480185;
	bh=NflfNIHMo7C4HRPvvHHlvdanxaC4O9uE0yYoWeWO8mc=;
	h=Subject:To:Cc:From:Date:From;
	b=lGfdY9I/NtnJNFm5FFEAza7yn1mxD8mLeQ5scmQb8RCZexQV0eK6CuDWaUuAxIj+O
	 kzO27j05RR1ti6Tked/L3P/iql4iKd/eES+H3TGvRdIpM0mf65BS/oZkD8DfQcT7AD
	 NnzFDQMd5/nQNM9GZIXJB6tghvUyAKwtUVZFZxiw=
Subject: FAILED: patch "[PATCH] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()" failed to apply to 6.6-stable tree
To: zhengyejian@huaweicloud.com,akpm@linux-foundation.org,foersleo@amazon.de,shakeel.butt@linux.dev,sieberf@amazon.com,sj@kernel.org,stable@vger.kernel.org,yeweihua4@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 11:16:22 +0100
Message-ID: <2024120622-postcard-cringe-b986@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120622-postcard-cringe-b986@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1 Mon Sep 17 00:00:00 2001
From: Zheng Yejian <zhengyejian@huaweicloud.com>
Date: Tue, 22 Oct 2024 16:39:26 +0800
Subject: [PATCH] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()

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

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 3dad8dfd9005..fcdccb614fd8 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -300,6 +300,7 @@ static void damon_test_split_evenly(struct kunit *test)
 	damon_test_split_evenly_fail(test, 0, 100, 0);
 	damon_test_split_evenly_succ(test, 0, 100, 10);
 	damon_test_split_evenly_succ(test, 5, 59, 5);
+	damon_test_split_evenly_succ(test, 0, 3, 2);
 	damon_test_split_evenly_fail(test, 5, 6, 2);
 }
 
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 821990d0141a..86f612fbf886 100644
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


