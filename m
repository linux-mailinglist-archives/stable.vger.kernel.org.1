Return-Path: <stable+bounces-204689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD80CF32FE
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20CD30C902C
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D9831A07F;
	Mon,  5 Jan 2026 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BqrvX6mR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25305235063
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611074; cv=none; b=ITG0Vy0PmXibclfcxUXCKCx2t5NKjRR58eqsW/ScOSaN+60benQayiMmDHuu9DwhsSbHzmzR2grZwD0NNTrZqINBtQL+vI7pc+OK1xAy1tDvAchU5ZSlNzXpLw4fRZmPRso+vusXdQuR5sWn8SzysDMr3IOnVp/sNeEyRuGb7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611074; c=relaxed/simple;
	bh=Pd+2XfROedQeX/3LKBff/QzIrodDo+420PcS6riwf7w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vh2WGzYyVgeRccIXKLyrAX8OIF9AMuYGubL2AzD7kqNoBXOwTNtSjEDXou4optcfvXLklTV/qmJc/GISoNAj0CRA1rW+pmcPN7KI13XWLbvFxPyhyWiXCI5Zmtr9B4TptDnVCoP8miXUos7sk5Ej7i5MznpO7/wIO1PqotUENvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BqrvX6mR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864F0C116D0;
	Mon,  5 Jan 2026 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611074;
	bh=Pd+2XfROedQeX/3LKBff/QzIrodDo+420PcS6riwf7w=;
	h=Subject:To:Cc:From:Date:From;
	b=BqrvX6mRattqCJBc4iT9EoFdyXwMJoIir65+srmQlwz3CctlZ37kMDH9n5A0UGQ5s
	 yMAKKghHmeaKWnE7CWXCPJ6zXtyoxfV/kEbJQzTMluCam3zoEWBvnO4XtfnQqSFloH
	 Ps13u7hWlCI4EAAQbTingSH4koHpFbP2NNg/qn0I=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle allocation failures in" failed to apply to 5.15-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:04:23 +0100
Message-ID: <2026010523-shanty-awning-7093@gregkh>
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
git cherry-pick -x e16fdd4f754048d6e23c56bd8d920b71e41e3777
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010523-shanty-awning-7093@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e16fdd4f754048d6e23c56bd8d920b71e41e3777 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:19:56 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle allocation failures in
 damon_test_regions()

damon_test_regions() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-3-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 69ca44f9270b..a2c9ee7a5de1 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -20,11 +20,17 @@ static void damon_test_regions(struct kunit *test)
 	struct damon_target *t;
 
 	r = damon_new_region(1, 2);
+	if (!r)
+		kunit_skip(test, "region alloc fail");
 	KUNIT_EXPECT_EQ(test, 1ul, r->ar.start);
 	KUNIT_EXPECT_EQ(test, 2ul, r->ar.end);
 	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_free_region(r);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_add_region(r, t);


