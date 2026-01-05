Return-Path: <stable+bounces-204691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12286CF331D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1C573133859
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9183203B2;
	Mon,  5 Jan 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DiQ2yuNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889131ED63
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767611083; cv=none; b=Lg8BjuZI3B0s4bssWmAHBh5uq0OgvM60S8bUZzP8ARvLl44FfTkvnd045NymrkgaGNE17NcFHSOW5E0mT9bzHa2iYDXOaLHrj9JNxrogeJ+NgRkL+KmVFAwZKDZ0qgpWSHAqvcbEb6xQnihUHOkQQtpaQvriPynqcy6CE/4YsVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767611083; c=relaxed/simple;
	bh=V9i7p+IPf4aOaMLeRyHC2hXslBLnPvajkHE/8LihUR4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VSVlMF8tJTnbEZyLk8USp9Ebe7u4MGyOi4WyMuFrmNbIFYu7rL9CVwsAKLtz2rgnJfvQdmGHsH6g7NEpy5Y2kBoBSfa874t3keTRRjBu9UaccJAVFpWQ7ivScsQPciWPHla6Xi+7AMOSgOFmJP6isOHErQFYcBsR6nL+O23jrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DiQ2yuNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569F8C19425;
	Mon,  5 Jan 2026 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767611082;
	bh=V9i7p+IPf4aOaMLeRyHC2hXslBLnPvajkHE/8LihUR4=;
	h=Subject:To:Cc:From:Date:From;
	b=DiQ2yuNrhBjkPbvcnaXchPdo5/xhj802WMs69zw+3K2hrffnEnFJ8KNFFM1AAcLrL
	 1xWobRIIuF7M+JibRxZB/iyIRitSLmeZQtGdmbRun9oYzKUKS1w3ZIBE2NZrg+iL+W
	 v0m+GrRChwQiUTUYK+sN+v66Oaewv4HaHHBA+o6w=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: handle memory failure from" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,davidgow@google.com,stable@vger.kernel.org,wangkefeng.wang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:04:35 +0100
Message-ID: <2026010535-convent-enigmatic-f417@gregkh>
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
git cherry-pick -x fafe953de2c661907c94055a2497c6b8dbfd26f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010535-convent-enigmatic-f417@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fafe953de2c661907c94055a2497c6b8dbfd26f3 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 1 Nov 2025 11:19:57 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: handle memory failure from
 damon_test_target()

damon_test_target() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-4-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index a2c9ee7a5de1..6e8a605277a3 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -58,7 +58,14 @@ static void damon_test_target(struct kunit *test)
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, nr_damon_targets(c));
 
 	damon_add_target(c, t);


