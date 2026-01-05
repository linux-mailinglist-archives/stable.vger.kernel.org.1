Return-Path: <stable+bounces-204707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA76CF32BE
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 847DA300B8BD
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875B5334C3B;
	Mon,  5 Jan 2026 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E76iWtqq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471CB334C34
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611161; cv=none; b=GT3gjLhcZJ+S2GyY1tocQ0dWctxK5+17BZ5387ZEQasRHSVqxaceEBRpaH+EVKSMrfE/HOEE4RRNk2F95vbCZAPfMkESt/S+zjegd5IRwjpwKvFKCxxMMWEU4c+HhlCaTi1Pa8wdLaJt5/W7i5bGwbhg5Q4Uqc7e+9r5EDizS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611161; c=relaxed/simple;
	bh=3Dm1sSunPB/bfmenNm5vRGeQVZsAFP0WzNEEYwmAsTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qv0c7T68ffiBEFpil9avljtXRYo/PtTj1I46AjTwfNbjffxrWnxKsZVZx5d2Jt7GzCAJriw/hHcbVQFJIyTcfUzm5ZxTM1veIkQZexbYfCDEBf2hebZmXHzBgTQomMbC7W7ZwBhQXyRg1DQXVQIzxv0c5e502Smp5SpwOWMEPS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E76iWtqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33299C116D0;
	Mon,  5 Jan 2026 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611160;
	bh=3Dm1sSunPB/bfmenNm5vRGeQVZsAFP0WzNEEYwmAsTc=;
	h=Subject:To:Cc:From:Date:From;
	b=E76iWtqqRv9mVphGrjv2PTdWjr6xZBnclapCC3Z9ahNn4FDduanP7Y4Tr61h9OJyW
	 c/2bQ8Kae+sluwahE3u0l0gWiNiFso/Awn0uGFQlJsx833hs4LDuDHGZPY18fv9h4J
	 x37t/WC5CumI77acSh2JsH0bqjmViIaClcf4TZGQ=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures in" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:05:49 +0100
Message-ID: <2026010549-bloated-activist-2c21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 74d5969995d129fd59dd93b9c7daa6669cb6810f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010549-bloated-activist-2c21@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74d5969995d129fd59dd93b9c7daa6669cb6810f Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:04 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures in
 damon_test_set_regions()

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

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 96c8f1269f44..e38c95f86a68 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -368,13 +368,26 @@ static void damon_test_ops_registration(struct kunit *test)
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
 	damon_set_regions(t, &range, 1, DAMON_MIN_REGION);


