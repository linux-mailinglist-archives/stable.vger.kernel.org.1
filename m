Return-Path: <stable+bounces-204701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD30CF3400
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35CAD302BBB6
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA1331A46;
	Mon,  5 Jan 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZejiFn1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25283314DF
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611133; cv=none; b=N0AEOdMpgGx99Hv3jzbULxzD1m+vIkthECfDS75JWXeVCXIK7/uX6b+Ea2TRiN3MY1KIS+kTrCS3UHGa/7kjrMKuagJCAHaVbs322OfZAww8TQGp/MD9QuR8GZnn4r4qJxy6okbkflXlVbGoXUzw0a/toDhkwhX3qFvS9xO/OCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611133; c=relaxed/simple;
	bh=ng5CsAqkL11lz5p4nVbVxzmu7Rf0d4H+jrnePAfJ2Aw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JXJUhEEw4UQ7kl8k9KlWGzltS+ZGNkMQAV+ZEiiolOV/DNSlIXiUwojGHBdvOw9QHdE/ncIoUh2LU4pQl2e5VzOY62MiaRFevhsyZA1HxBHsvN6067CAHBa6oCxYdvXsqd1hxjilO+wYvZpcncARUaU57xTRB0zz/tzX3Vprwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZejiFn1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED46C19421;
	Mon,  5 Jan 2026 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611133;
	bh=ng5CsAqkL11lz5p4nVbVxzmu7Rf0d4H+jrnePAfJ2Aw=;
	h=Subject:To:Cc:From:Date:From;
	b=ZejiFn1rB5Q6CURjQV2UwbKr6VC6zTS2xzO70iGwBZ8cALJ22RHBdhc46l137B/G3
	 MkIIP17Qr40RMiv/q8/Mg8KB1AKNIDNgDz2YCVdoUiajkabDEByhH49t5TVSDGbif7
	 ELXf2FQ5H32+R548fVnlb3bNQX+YR5O6JPPULGoc=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures on" failed to apply to 5.15-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:05:19 +0100
Message-ID: <2026010519-cathedral-cuddle-c32b@gregkh>
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
git cherry-pick -x 3d443dd29a1db7efa587a4bb0c06a497e13ca9e4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010519-cathedral-cuddle-c32b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3d443dd29a1db7efa587a4bb0c06a497e13ca9e4 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:00 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures on
 damon_test_merge_two()

damon_test_merge_two() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-7-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index f5f3152cb8df..e8219fd23318 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -188,11 +188,21 @@ static void damon_test_merge_two(struct kunit *test)
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	r->nr_accesses = 10;
 	r->nr_accesses_bp = 100000;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
+	if (!r2) {
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	r2->nr_accesses = 20;
 	r2->nr_accesses_bp = 200000;
 	damon_add_region(r2, t);


