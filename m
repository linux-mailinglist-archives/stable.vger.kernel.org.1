Return-Path: <stable+bounces-204685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8068CF32C0
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB375300BA2D
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C9319867;
	Mon,  5 Jan 2026 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLqR/LkI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182073A1E69
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611060; cv=none; b=ni2r8GOTYzK3ryi+KTUIXRtC1FVcFi6WBAgr1FU5TUOwRH8duSWDnHb8BqqlhRGWC4xHWGtV2oD2/3lTVySuk6o5wanBUTCoiIffOryXBGgLYlx2tyARkXaJzngJ613dFSLuFdvkNPfhVNtIF8SwmbXjwjbaEmW5KQgNHC/H5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611060; c=relaxed/simple;
	bh=AYW5Uhh4jJ4nc9w5VXvp2+n8qxhs1FJRb627pOeD+YQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HTYLAReP/eee+n8tuu2VpSMeSVuBBTW1zMtSHQ7BiNoZOkYJGOC1CaFe8LqYW/tJVzJMRGoo5bMm89WBXyhQxGrmAIRpyF9ohz1hohwF4v3XQ4O64yMl4ddUQik8r41X+8homQYHM1A/PKrczgmNAxrJNRoRowjd/j9jCqhkkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLqR/LkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280CEC19421;
	Mon,  5 Jan 2026 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611059;
	bh=AYW5Uhh4jJ4nc9w5VXvp2+n8qxhs1FJRb627pOeD+YQ=;
	h=Subject:To:Cc:From:Date:From;
	b=xLqR/LkI0E2ZyVFHXTJN72hkqb48Fr8S4tbjzOLL3NfsZZC1xDgcKH0lBx2tKTrr0
	 csenntFa3/3ylGbq6Xwa9jV6MT4HJh2CK5KAfQu90lgu1oAYE+NMmae75eS1aW+mnD
	 4pTDhCaU0OE/B2MLIji6WMb9A7iNCz7sRgF6r0GY=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures on" failed to apply to 5.15-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:04:08 +0100
Message-ID: <2026010508-outnumber-condense-f43a@gregkh>
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
git cherry-pick -x 5e80d73f22043c59c8ad36452a3253937ed77955
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010508-outnumber-condense-f43a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e80d73f22043c59c8ad36452a3253937ed77955 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:19:59 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures on
 damon_test_split_at()

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

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index fd1e1ecaa2c9..f5f3152cb8df 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -148,8 +148,19 @@ static void damon_test_split_at(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r, *r_new;
 
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
 	r->nr_accesses_bp = 420000;
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;


