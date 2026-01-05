Return-Path: <stable+bounces-204680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666FECF327C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9846230C7F1B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0387313558;
	Mon,  5 Jan 2026 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQvneGyb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAA03101D4
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611001; cv=none; b=gvZIsualFTOXnXZjWPYhL8a03vbFVUJ+jcyOBjnPQDFxLOhnXfPvFakEWjw4QHWXubIgECU+z/4DhLpP8/rmnHrw7b9i31oAT+Cjq6M/Z5b4qs1sD8w5KXNBmjygFVge9WCfXF6gJB12X8DZ87NjHo3rlLqM9Piv0NlYngfZ/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611001; c=relaxed/simple;
	bh=bUBJcYs8L4xvXtFCLSiC9JtEdZkVxEQH+xtced7Fx9o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YQPgUV/p/i00KX7Z1jKDeKuMjRgMIKdDj+f0urrvmKwiRTTAjgkcsXvGh88k+vlqVt/OhGAZdQc/LSHkIm0PdtEAP/TZQ5ZutUgrXTqVpLR1+aIFL3GcvmME7N2uLkaCQnTB1A14GoiVM3WqaLlOJIUx2l/WRgvU3KcL3bzF4Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQvneGyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C89C116D0;
	Mon,  5 Jan 2026 11:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611000;
	bh=bUBJcYs8L4xvXtFCLSiC9JtEdZkVxEQH+xtced7Fx9o=;
	h=Subject:To:Cc:From:Date:From;
	b=rQvneGybnwy/QLIAFlLk6EqSDzB02dnxrSWEO7+bmwYrvYPFBdSw2LobmBDk27Ubl
	 j0Z9cHvExS8iUF/yJa8z05nV45LRk7262F5ocnrb2DT9wVpmhDZwiwYAxyCltEaTyt
	 phcImwOlu3t/FqgV0YNtSKrejtgjEO+6FSkXa7bM=
Subject: FAILED: patch "[PATCH] mm/damon/tests/vaddr-kunit: handle alloc failures on" failed to apply to 5.15-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:03:13 +0100
Message-ID: <2026010513-quickness-paging-fee4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0a63a0e7570b9b2631dfb8d836dc572709dce39e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010513-quickness-paging-fee4@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a63a0e7570b9b2631dfb8d836dc572709dce39e Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:13 -0700
Subject: [PATCH] mm/damon/tests/vaddr-kunit: handle alloc failures on
 damon_test_split_evenly_succ()

damon_test_split_evenly_succ() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-20-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 1b0f21c2e376..30dc5459f1d2 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -284,10 +284,17 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 	unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
 	struct damon_target *t = damon_new_target();
-	struct damon_region *r = damon_new_region(start, end);
+	struct damon_region *r;
 	unsigned long expected_width = (end - start) / nr_pieces;
 	unsigned long i = 0;
 
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+	r = damon_new_region(start, end);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
 			damon_va_evenly_split_region(t, r, nr_pieces), 0);


