Return-Path: <stable+bounces-205014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7519CF6743
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAD62313D859
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A6F258CE5;
	Tue,  6 Jan 2026 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oThEww/G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF53246798;
	Tue,  6 Jan 2026 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665764; cv=none; b=eh+OY7fDW1nP6LdHLFCYo4NYP7C7u0u33hLtN8Dw6F+jgt9O4v/0NSZW/l841d0xX1QV1sXAMz+7uCl5pQPyE5gGfaxaEmSBCz9EXxiab6yNG2l11pMD+osECHFWkT4BM5D3Mhpge9nNMUTNEuUXAF7nspe2oYpFC0ACWa5F3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665764; c=relaxed/simple;
	bh=5mBA4qQoaLhtHK6guNOG9XhDZbhfx40o7HEw3pkKXh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqVgn+RLk6Qiqn07P7XVQFe09ON/YsUwapcTSJtz5rcimdH92AbIzcO07QYZrB/25ORRBa5dSbhduL53JmJK78Vfoa1kIfbFvVvnSGRguYYiI+mvTtdJuGon6+tuFU9GpWpGBAwy2Kdv32jzZH4xkEBgEusFknk+T+Cd5Tl2gF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oThEww/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278FCC116D0;
	Tue,  6 Jan 2026 02:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767665763;
	bh=5mBA4qQoaLhtHK6guNOG9XhDZbhfx40o7HEw3pkKXh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oThEww/GvrNYys/xrgnOUoZV+EQ/Ve4hgtm4zoGpnFvVI1/mbVXZtQkKwNp/Q8aaS
	 a9nNincMS35ISFevT29yI6Amqb6MZJutIsQJampfSCKJCpm00dDR20Ed56Ofk3foF5
	 4KQ9ZOcuYf8RaWBdp7bYUVrJsKw3MTSMpWTy6+91H70vjFSCrA9FL0vKFKbGE2LZ20
	 9D6jBV82d/XJGEu2Fd/Rz57/0Zeguk6EBUNt5fGxOk9WmyNY7sR5GwYMHrWAeiHzHd
	 p/AOv3mhx5eTKuZCa0QzAklmdbnW1EU/Hu9wDqKutNI9qr0ST5VZuZYHS7kJw7HO3b
	 7ycWZTGnuLYkQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/core-kunit: handle memory failure from damon_test_target()
Date: Mon,  5 Jan 2026 18:16:00 -0800
Message-ID: <20260106021600.641343-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010536-cape-action-3dcb@gregkh>
References: <2026010536-cape-action-3dcb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit fafe953de2c661907c94055a2497c6b8dbfd26f3)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 7008c3735e99..a2b19a137269 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -52,7 +52,14 @@ static void damon_test_target(struct kunit *test)
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	t = damon_new_target(42);
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 42ul, t->id);
 	KUNIT_EXPECT_EQ(test, 0u, nr_damon_targets(c));
 
-- 
2.47.3


