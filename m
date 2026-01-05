Return-Path: <stable+bounces-204702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F824CF3316
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8190304DE26
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348A8331A65;
	Mon,  5 Jan 2026 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lfsX93O2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95C1331A62
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611137; cv=none; b=a3WnD7ae5GdZ5AyLFy8j0Gdj6gpNnsrS9yxywd2g8JpH2heDCQGIGcAyrYPkOLk3/163JIs63H/tyscKDLLILKsN375ooRUINk46HisCS/ZLOCI07//A2QcGKB7rRxxMYom21T6DfaAhTcbR1fYhHxhVXbunvufWa+nN76NHaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611137; c=relaxed/simple;
	bh=FvfqA0eLXpjHScWLLAbId5kbipt2YWs0vmeMJTBOo48=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kGQSXum7JRP4QYQB7xp05CXQJL84x0TBJXkNFulsI75bOs1/3Mjy12ut+KVZ1fbUpxR5ndruBmaAAMwz2jqirMoyiTTpsT3WDJp7wrdtIsx7ZEjig5teOtej1jDAlOmagM768+Pn45i9Pbg0apPWKXH2UjyuqGSM7SVLfvmPtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lfsX93O2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EB4C19425;
	Mon,  5 Jan 2026 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611136;
	bh=FvfqA0eLXpjHScWLLAbId5kbipt2YWs0vmeMJTBOo48=;
	h=Subject:To:Cc:From:Date:From;
	b=lfsX93O2GTHFFtbAc3jx4FEz1vYpwQfAwI4w9kVoLKtI11uIO0gHA5aOdS1jmTyIu
	 0/kawI14P894ZnyU3lGD9/88yRwpmdOeRRxXksjhXmTOfbBtTOm27hLOuly7TTtlBR
	 7hCHF8xwqBMFxsOVzcrq+AjUHS5W0q+EHm8jhfT0=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures on" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:05:33 +0100
Message-ID: <2026010533-uncounted-stuffing-5fb6@gregkh>
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
git cherry-pick -x eded254cb69044bd4abde87394ea44909708d7c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010533-uncounted-stuffing-5fb6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eded254cb69044bd4abde87394ea44909708d7c0 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:02 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures on
 damon_test_split_regions_of()

damon_test_split_regions_of() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-9-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 98f2a3de7cea..10618cdd188e 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -278,15 +278,35 @@ static void damon_test_split_regions_of(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
+	if (!c)
+		kunit_skip("ctx alloc fail");
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 22);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_regions_of(t, 2, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "second target alloc fail");
+	}
 	r = damon_new_region(0, 220);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_regions_of(t, 4, DAMON_MIN_REGION);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);


