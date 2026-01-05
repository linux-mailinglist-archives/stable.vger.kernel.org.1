Return-Path: <stable+bounces-204708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1BFCF32AF
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58182301E6F1
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F833554F;
	Mon,  5 Jan 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jyuWtL00"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3433554B
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611169; cv=none; b=SPD/Qd+tAiYSlQbVhO52DKZJa+X+R2jsaj0QYdziAg0RvD4cULAKtknnyiL2dfy+TtfVOHxgsK8sOAuaoCd7vRyb9cQ1u/1PHNUUZxeyc9CPmlUFjB4E0W+mB2PU5me14Hingl6VS5VGMflbdT+pwLa5/VRyyjZroS8xlpUUZQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611169; c=relaxed/simple;
	bh=Nu8O57vTlis9wFrQvHZqPoRyQ+P46GCT26rzCcC4fpQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YKVsYF6g4uPPodLIQijrxHLPkfJcdRSPv7FqOdXX7jlaOkfbN6T4IWheoe5aL5dFuFIeJJO6xxXNz8AmHeF73EmGL9qEqbpwnizzA26sXYvmoc3OX4uBb7hqsYGpPRdaQKGjg8yKzxHYMHMnbUQvXqFyGj1Sy8PyD4ZLVf396Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jyuWtL00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6030C19425;
	Mon,  5 Jan 2026 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611169;
	bh=Nu8O57vTlis9wFrQvHZqPoRyQ+P46GCT26rzCcC4fpQ=;
	h=Subject:To:Cc:From:Date:From;
	b=jyuWtL00Jb0tbTfMCFJfmiHPtlJN1u5TgqUhCrDgAKtd5CbLS6QJvmNmt08yMCKTn
	 GfemfuhLXDkDkKhzl0YrBdhg6W9xuT+Z1nJIKxNv6ZlqgS3vA8zOL0ggJAKTNwXOLD
	 STnl+BDCBIDCq5QHQWwwDGz26yqSLFf47FDMcN6w=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle alloc failures in" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:06:05 +0100
Message-ID: <2026010505-yiddish-alienable-7ae9@gregkh>
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
git cherry-pick -x 8cf298c01b7fdb08eef5b6b26d0fe98d48134d72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010505-yiddish-alienable-7ae9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8cf298c01b7fdb08eef5b6b26d0fe98d48134d72 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:05 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle alloc failures in
 damon_test_update_monitoring_result()

damon_test_update_monitoring_result() is assuming all dynamic memory
allocation in it will succeed.  Those are indeed likely in the real use
cases since those allocations are too small to fail, but theoretically
those could fail.  In the case, inappropriate memory access can happen.
Fix it by appropriately cleanup pre-allocated memory and skip the
execution of the remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-12-sj@kernel.org
Fixes: f4c978b6594b ("mm/damon/core-test: add a test for damon_update_monitoring_results()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.3+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index e38c95f86a68..10c9953581ee 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -429,6 +429,9 @@ static void damon_test_update_monitoring_result(struct kunit *test)
 	struct damon_attrs new_attrs;
 	struct damon_region *r = damon_new_region(3, 7);
 
+	if (!r)
+		kunit_skip(test, "region alloc fail");
+
 	r->nr_accesses = 15;
 	r->nr_accesses_bp = 150000;
 	r->age = 20;


