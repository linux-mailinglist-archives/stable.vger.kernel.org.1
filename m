Return-Path: <stable+bounces-204673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06ACF3210
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FDA3300BA18
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ABA242D88;
	Mon,  5 Jan 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EjqFIUCf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849584C98
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610971; cv=none; b=o02MVZBTIvsqwqvkuCX+1bZ3JmSlgwvEYNbqSumlgJXwfEsx4DyBTLS+4qRfJVIuL9K8/czQaXehexn6iDoVldAQMmVBjxDAD//jJ6e6Ia9jIX+MyP9pcQmA/F0RqD3D1JOd75/52xUDKL7hHPUdoGdNL9YcSi6zMQghXkGYEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610971; c=relaxed/simple;
	bh=Zsxkb8egsmCT1JRCDIly077sQZQ4nIb+3FphM1njohc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fShxq9gndeSXSNAbiOH7qcPh14erdQu5qGn3nYtvpNZKINH/HZuhB1uGwUdivWkFj8ZoGPn0RwHGneR18iD8igjSdLnwIZiXwAEMy4qkHjQBgfJZa9QjYDFay2TWik2Ns2yhsYtXCNIfoYLxv8Dx2YcoWVSgmducCZsFkN6XbLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EjqFIUCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4579C116D0;
	Mon,  5 Jan 2026 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610970;
	bh=Zsxkb8egsmCT1JRCDIly077sQZQ4nIb+3FphM1njohc=;
	h=Subject:To:Cc:From:Date:From;
	b=EjqFIUCfmEhPkjd2WjglBBzbr+jhrqXDsN511UB9ThEEY3oEEiBE9AnhDnqXdJWh4
	 LoMNE4Px4JQ90/WTWfT8PtSIYJx1jTPtTqYUVbE/yAbwZGenKqXxF1z0fMef66Yzbp
	 pL8g5tMJosuXNHYTmout3/s3ok3DxFgvQQdLw7CI=
Subject: FAILED: patch "[PATCH] mm/damon/tests/vaddr-kunit: handle alloc failures on" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:02:47 +0100
Message-ID: <2026010547-stays-strewn-1e8b@gregkh>
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
git cherry-pick -x 2b22d0fcc6320ba29b2122434c1d2f0785fb0a25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010547-stays-strewn-1e8b@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2b22d0fcc6320ba29b2122434c1d2f0785fb0a25 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:20:11 -0700
Subject: [PATCH] mm/damon/tests/vaddr-kunit: handle alloc failures on
 damon_do_test_apply_three_regions()

damon_do_test_apply_three_regions() is assuming all dynamic memory
allocation in it will succeed.  Those are indeed likely in the real use
cases since those allocations are too small to fail, but theoretically
those could fail.  In the case, inappropriate memory access can happen.
Fix it by appropriately cleanup pre-allocated memory and skip the
execution of the remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-18-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index fce38dd53cf8..484223f19545 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -136,8 +136,14 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	for (i = 0; i < nr_regions / 2; i++) {
 		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
+		if (!r) {
+			damon_destroy_target(t, NULL);
+			kunit_skip(test, "region alloc fail");
+		}
 		damon_add_region(r, t);
 	}
 


