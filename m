Return-Path: <stable+bounces-204678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D8CF3273
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B3430A50D5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4B7313E03;
	Mon,  5 Jan 2026 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XpPok+Ta"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDB3101B8
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610993; cv=none; b=kai5VGvSGdYQnbE4jgdAk2iWT3yLdt56mmJi6E8GcUjh8hwu+pejcMqV/7WBMiegTaBGHtuFApfwKESKMxTeLbc3MGP5/9gijXtPFy3zvHd3vUJOYJoPDoDDZ7tLvflLfRyr/aHEUouJH3bPdDkChxyIKmvCIP8f/A5eOTXmoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610993; c=relaxed/simple;
	bh=UWIFBuY6hU54l0F1b+nXU7VpTgskr3srVlYQm16xJ44=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KIvBcYSRxnAQACaAgYRcfjBtMrAmtcA0f/t/k/opZWVYL1jYMR22BdHpaGN0CY7hSPKEM/XXzyEYqyu0JG2+EBhm7hhcQUKKDDBGkm6Pmock2Ddmh4wh9A10y9o48zulx98Cgg7CS9xEtIyiUGRTl/ShTMN/JRTs9pgALZemM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XpPok+Ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A27C116D0;
	Mon,  5 Jan 2026 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610992;
	bh=UWIFBuY6hU54l0F1b+nXU7VpTgskr3srVlYQm16xJ44=;
	h=Subject:To:Cc:From:Date:From;
	b=XpPok+TarNIHBXuhP2Su8FjfxEyITmPxXg10yevDJTWdZGfW63+ZuRp2U/WPP7IJF
	 ocEKCdDaBOkLsiEYqMMrAwAUjtMt8cDwzSgDj93kqmsaqii3MqT1176ZcH+4+pOMrj
	 Z8FZ9PrRao0IY93OmLmqYwg77gUlFpauhdGZwJTM=
Subject: FAILED: patch "[PATCH] mm/damon/tests/vaddr-kunit: handle alloc failures in" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:03:02 +0100
Message-ID: <2026010502-dispersed-paper-9a89@gregkh>
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
git cherry-pick -x 7890e5b5bb6e386155c6e755fe70e0cdcc77f18e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010502-dispersed-paper-9a89@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


