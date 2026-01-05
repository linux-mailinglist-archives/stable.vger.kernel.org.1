Return-Path: <stable+bounces-204693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9DCF32F4
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C98CF30B65F8
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07613328B4E;
	Mon,  5 Jan 2026 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/cGpfU/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53622322B70
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611090; cv=none; b=EoUpeLxc4AKW346z03U1Jf9wvGffjOd+Vm5ZypbRe7JaPy+J9xjQtVFTrs8Zzcujg6stFaY52gLR9L9LSocH9ICOGqJBVLvPSJEUQ5/1CwsYdtNdEgpi/0+4vTY/qaiJfxRbti98AFrfOBun5OJci9UDb4Yu7A/jK0I+chJCbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611090; c=relaxed/simple;
	bh=YHqJAVzPllRQBpXzIAI4nx693BV66CGNQ+k7FnbaEjI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lcX15/DUPfuLexda8mXfiHMEyfDXuqVGW/I8wbyiELnV9ZoV2upN5+0dCxwihV+bUnJbMIrzYi9HQnwIERO2R18rnrjoIKWaa+6+L6hzl3O9qRMtS1yfp5U2ays7jhUAuFKA28TLC2KZqYlhj9GHNQt2xfOfs/pnX9qKcf7u0rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a/cGpfU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C40C116D0;
	Mon,  5 Jan 2026 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611089;
	bh=YHqJAVzPllRQBpXzIAI4nx693BV66CGNQ+k7FnbaEjI=;
	h=Subject:To:Cc:From:Date:From;
	b=a/cGpfU/wFtBeER+eUTd3nlA+71rEOJhHJ68qOEvrspDYLGd17AZDAaINAWmNS0/L
	 eQs0jyaXXHfKwVRo/YiuqbsyfQ5ImfznxKi6Y9QiS2s8DR3yKPsyXNn3gART8FowSe
	 NZkJeJr9DNz5c4wtH/Jm7bX1Ldb3gKuPwSf9cdsk=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle memory alloc failure from" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:04:45 +0100
Message-ID: <2026010545-sesame-antsy-7700@gregkh>
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
git cherry-pick -x f79f2fc44ebd0ed655239046be3e80e8804b5545
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010545-sesame-antsy-7700@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f79f2fc44ebd0ed655239046be3e80e8804b5545 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:19:58 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle memory alloc failure from
 damon_test_aggregate()

damon_test_aggregate() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-5-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6e8a605277a3..fd1e1ecaa2c9 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -97,8 +97,15 @@ static void damon_test_aggregate(struct kunit *test)
 	struct damon_region *r;
 	int it, ir;
 
+	if (!ctx)
+		kunit_skip(test, "ctx alloc fail");
+
 	for (it = 0; it < 3; it++) {
 		t = damon_new_target();
+		if (!t) {
+			damon_destroy_ctx(ctx);
+			kunit_skip(test, "target alloc fail");
+		}
 		damon_add_target(ctx, t);
 	}
 
@@ -106,6 +113,10 @@ static void damon_test_aggregate(struct kunit *test)
 	damon_for_each_target(t, ctx) {
 		for (ir = 0; ir < 3; ir++) {
 			r = damon_new_region(saddr[it][ir], eaddr[it][ir]);
+			if (!r) {
+				damon_destroy_ctx(ctx);
+				kunit_skip(test, "region alloc fail");
+			}
 			r->nr_accesses = accesses[it][ir];
 			r->nr_accesses_bp = accesses[it][ir] * 10000;
 			damon_add_region(r, t);


