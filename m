Return-Path: <stable+bounces-204676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E8CF325E
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D2A302D288
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9CA314A6F;
	Mon,  5 Jan 2026 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwryR4aS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7AA2F28EA
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610987; cv=none; b=toynPEDautstM+g0VHeAO4HOlI7/ck/rMVCl0HyIGHGktZG6PvKxXU8KUDxTJnsfng+XNKvnVI/l3Xf7PQRW47TBooZMQkNeRlGWJh1N6oISd0cMCtj5P+2r5boD3pbz16YmHoR4T5px5/OOFcfKYImOPA8cxp0Iw1PVx6JwxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610987; c=relaxed/simple;
	bh=IvGbODj75Oyip8x4mEJqI4uFyyYQ4K2YSSzkjHm60ds=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WnsQp3RYfLJphxQrp3qwrA5p+BxlPsL5j9HpDSCAoLyOn8EF1aLHn9MserslUVYHgqEpTknThBqwjanXwNNF60mAO2rCqiqomPqRTTbY+xyaEOoMv47PnrxL37VxIoTFAPnKJBE4D2ibntUso/mnk/DJI/GJzBSYx+0XWu1iDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwryR4aS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E25C19421;
	Mon,  5 Jan 2026 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610985;
	bh=IvGbODj75Oyip8x4mEJqI4uFyyYQ4K2YSSzkjHm60ds=;
	h=Subject:To:Cc:From:Date:From;
	b=IwryR4aS1ltxDOP4kMXeR7CHUeaznGgM6IL5OLhP+uzJHcFXMZZhNWOy2bqmaZsLK
	 W74R2uYm3/nwO4mw6JrpLv43KqLZyPGvfliHAXSr8uJQDaTkFxxa/ABLw+2XSbAaN+
	 er/UKc8zxaNH/vegnDZQSuOVJSHQOZWJ8Xofqekk=
Subject: FAILED: patch "[PATCH] mm/damon/tests/vaddr-kunit: handle alloc failures in" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:03:01 +0100
Message-ID: <2026010501-online-amenity-037a@gregkh>
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
git cherry-pick -x 7890e5b5bb6e386155c6e755fe70e0cdcc77f18e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010501-online-amenity-037a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7890e5b5bb6e386155c6e755fe70e0cdcc77f18e Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:12 -0700
Subject: [PATCH] mm/damon/tests/vaddr-kunit: handle alloc failures in
 damon_test_split_evenly_fail()

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

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 484223f19545..1b0f21c2e376 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -256,7 +256,16 @@ static void damon_test_split_evenly_fail(struct kunit *test,
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


