Return-Path: <stable+bounces-204710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA5CF343F
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70F4F30081AE
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E26337B97;
	Mon,  5 Jan 2026 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtA2TYNY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD21337B91
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611196; cv=none; b=jjDXxjwb1YnojW/RbKWLjw13BsVof8PoeOl8udV9w/uOkdVrMag+MuoLdE850hH1Wv+sAAJaIV8A8OrZCLSSkcV/SCoxaiqRNFf4O86Dw3EpoNNPLM4y3DiONOEUiMOnqj+7nIUxWP2h4QqKb71wAnC6VlgODQY8vSBebWm8SdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611196; c=relaxed/simple;
	bh=WjwwI+0E3j/dCiw8tV4jv5hSzJcR1lDhmxyG8z+S5MM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ugKFRVGRtPfrZy5VTh9FjYhJd2ZXSoElDXu05EA5DemVrQsihiiVtdF1QkU+E+kLJ8vbyJQWt4JGpWBbYOvens33OrLTlIdiJKt10C/YqrRRp9Geq/6HOv29MlCLzMN3ftl16VjcR2PG8pH5w6uk+8ldosT8d1wlykvutaOCsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CtA2TYNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3776DC116D0;
	Mon,  5 Jan 2026 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611196;
	bh=WjwwI+0E3j/dCiw8tV4jv5hSzJcR1lDhmxyG8z+S5MM=;
	h=Subject:To:Cc:From:Date:From;
	b=CtA2TYNY0Mc9zQK7U3c3yRND82zvOpgnQ2SA6f4+LEU0p1PQUxu24nH5KllGNJ0ve
	 WdZY1TPZs4L8EMS9hJFyHcnEzzKJgnCk0K0g6vP6/F9NV5CP7stckMDOx0zMA/heB7
	 IHm9D9zmiIYJH8Gf5s/Q9VIiZ8vvpknLQ4aCp9xU=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures on" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:06:25 +0100
Message-ID: <2026010525-threaten-recliner-cac7@gregkh>
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
git cherry-pick -x d14d5671e7c9cc788c5a1edfa94e6f9064275905
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010525-threaten-recliner-cac7@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d14d5671e7c9cc788c5a1edfa94e6f9064275905 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:09 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures on
 damos_test_filter_out()

damon_test_filter_out() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-16-sj@kernel.org
Fixes: 26713c890875 ("mm/damon/core-test: add a unit test for __damos_filter_out()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 5af8275ffd7d..a03ae9ddd88a 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -542,11 +542,22 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damos_filter *f;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true, false);
+	if (!f)
+		kunit_skip(test, "filter alloc fail");
 	f->addr_range = (struct damon_addr_range){
 		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
 
 	t = damon_new_target();
+	if (!t) {
+		damos_destroy_filter(f);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
+	if (!r) {
+		damos_destroy_filter(f);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 
 	/* region in the range */


