Return-Path: <stable+bounces-204683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E145CF3282
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3B8B30049E6
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CAD318121;
	Mon,  5 Jan 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lQHYJ3p8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F2317700
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611042; cv=none; b=ahrT8JKuA76G9fwGowLK2bg3EdnUlMmSdAvFLewA+Hd4WuaQwnyLlnh7Xm+F1M1hMX7hV6dIoYKhGmZk11unkkFDnVq5ym05d4v6ykIpE92qclRL7PO0b9JBnYhSdtuhfWpQ6DeAVyCGTFJkn34gJKKWwBNzd9ObzyOfgg+Reuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611042; c=relaxed/simple;
	bh=07wz9XXQQQzKFKiA/CivI+TvKBY55A1jLyapWWHZOqc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CvnCVbOpNU8v79sDrE3YGZDPxjtnWlgqEmZF2pzRSp3d7wNh+xPUyKhCCPa4mPK1FVV7AHSCmsNU9ewPZxdl4ec5RWajAIIO5vdZ4gakPR2y9yiI08x0ebGSCf/+RPqi7/XE3OQFJu/SeFF65O7rEQlRQMjrQ3cnuSuMSQ7nN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lQHYJ3p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6B4C19421;
	Mon,  5 Jan 2026 11:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611042;
	bh=07wz9XXQQQzKFKiA/CivI+TvKBY55A1jLyapWWHZOqc=;
	h=Subject:To:Cc:From:Date:From;
	b=lQHYJ3p8ayRjbSddWuXYQ/s823WZwkDePIcwXtC0von2SiCQQvOIQ+BNzyIJSC89Z
	 EWP0BmR/EV6NfsaPEPt35ZV8q64OlIpebL1YjIg4r/ohix3a7Y2QZgFbY5n8J27CPb
	 DhTU0L52R62EQueABmC4iyryfZNLvrv4+4Z4rnKs=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failres in" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:03:51 +0100
Message-ID: <2026010551-reawake-rimless-688e@gregkh>
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
git cherry-pick -x 28ab2265e9422ccd81e4beafc0ace90f78de04c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010551-reawake-rimless-688e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


