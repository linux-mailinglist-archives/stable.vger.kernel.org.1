Return-Path: <stable+bounces-204682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A82FCF3352
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A58E3027A7A
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C643164CD;
	Mon,  5 Jan 2026 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Di/8jz3L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF03164BE
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611034; cv=none; b=bWwMEJZf3WXVZZ8SVMMwD/AYUne4Jw4acKQcghioN5gtjvtIGvkYy9p9lm9DCIVtEcffefFMklDMDw2G3ueBqXN5d/iQ56wiP6L9yFZG2ZtKAs4a1QTtE8AVZCWnl5X7zClnRTgR329KzocoERW3xi9qV7WQP9RU7HQ10TjbKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611034; c=relaxed/simple;
	bh=aiv7dMTEMpsCuCMpPMpNy+31Y3hZcaJPyqVTCy9axxI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e6+nV2WWozWPoUV9AaVbwrtFMKtjZvLFVSjP8oUKrMnDw8U7PyJ5zEyeS5vc8nj+QfHNacc+gEvMtNP25JzTU++/k+kzb+yrdyWIj71siXezUesk8FvZ8qL7hzabroupAcWH0LdgTNYQCejPlakvvWDRm5sZwsIpyphShhHWhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Di/8jz3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19408C116D0;
	Mon,  5 Jan 2026 11:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611033;
	bh=aiv7dMTEMpsCuCMpPMpNy+31Y3hZcaJPyqVTCy9axxI=;
	h=Subject:To:Cc:From:Date:From;
	b=Di/8jz3LSih4iW1/5DZenZw5r3LAUcyspkpacwuUwC82wgP4/x3uC+hePDVx8opyT
	 rL3CJ9fZR90I7tMoByu6aQ6UXjrfxu2Vcke+83Hte05TL/Q2FTpE6tfxaqYTSQ4eKB
	 EVINVAxMPwHEME5GmolIlI6XMsdkhhYZH+SuLIpc=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failres in" failed to apply to 6.12-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:03:50 +0100
Message-ID: <2026010550-tank-repugnant-eee6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 28ab2265e9422ccd81e4beafc0ace90f78de04c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010550-tank-repugnant-eee6@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 28ab2265e9422ccd81e4beafc0ace90f78de04c4 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:07 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failres in
 damon_test_new_filter()

damon_test_new_filter() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-14-sj@kernel.org
Fixes: 2a158e956b98 ("mm/damon/core-test: add a test for damos_new_filter()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index b9bd69a57e62..03c7ac31db5c 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -505,6 +505,8 @@ static void damos_test_new_filter(struct kunit *test)
 	struct damos_filter *filter;
 
 	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, false);
+	if (!filter)
+		kunit_skip(test, "filter alloc fail");
 	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_ANON);
 	KUNIT_EXPECT_EQ(test, filter->matching, true);
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);


