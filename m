Return-Path: <stable+bounces-205017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB1CF674F
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51F823004E36
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767D92E88B6;
	Tue,  6 Jan 2026 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmokXseF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7DF2192F9;
	Tue,  6 Jan 2026 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666327; cv=none; b=WXPwTm5tyd8J4rx90Aco7UzEoWVi+pmjDng17iTuIg+qReMgQodMwm0uPCkIu6qgWKkjRZisbpSWJJeerUvwcrDlVS2/n23dosUiAZ/+EK86er3sp2N4rTUsz+DxBk2p0ct3x/ybZksUGcUZJ95pVf4UeR4CFVT101rxbHUNR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666327; c=relaxed/simple;
	bh=YM+JpBV0Fa+HCpitzh+NwewML1vDryfR81MbcCc9LZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKcAL7yT3oHb06mAh7TmtmU4NKC5aUCIM1nPGO99YVTSMkVUfKY4c4Bn6AqhXpZZ4PHlEGvQXtV34g1429ov4bBsPyOS4GfarNyguEe3NujEssFk9imPLmJvVfSN+bFPjF+52sMvyrok1J3DOnUrVCzUaEmLJSdELmxBgkmLHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmokXseF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816DDC116D0;
	Tue,  6 Jan 2026 02:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767666326;
	bh=YM+JpBV0Fa+HCpitzh+NwewML1vDryfR81MbcCc9LZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmokXseFab65E6QX8293jvVXskcaMbmUVMHxFdFThCzc1NJSmOwSpoZF7beevFffP
	 j3eug925dImBr5PU20D9f27SYDbI1BWUXT9l74J1OGNVDIzPui52OgUVVsuNyneF2H
	 AMVdXpuujEAmqpu5FY8dzHUdFCz2f8jVi6Pzq5DFwFV6RDwXXxs7qUY/eEOTa2hQpQ
	 7t+0acSLn8MR5Op0y4xsB2iIzhgsYzFliVK3lQqHi2bE/hswf76lB83Ei80RqJOhp+
	 OKFRlo8m4B8r9xzTdd2Zr/fUOPB2KzoYYoNou4qeK5QWHoGQX+eS37xU8TpyWDSlWJ
	 BFbG0MxH2m2ww==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/core-kunit: handle alloc failures on dasmon_test_merge_regions_of()
Date: Mon,  5 Jan 2026 18:25:18 -0800
Message-ID: <20260106022518.690796-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010501-sensitive-t-shirt-be57@gregkh>
References: <2026010501-sensitive-t-shirt-be57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_merge_regions_of() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-8-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0998d2757218771c59d5ca59ccf13d1542a38f17)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 7008c3735e99..92539b6aeb65 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -192,8 +192,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	int i;
 
 	t = damon_new_target(42);
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	for (i = 0; i < ARRAY_SIZE(sa); i++) {
 		r = damon_new_region(sa[i], ea[i]);
+		if (!r) {
+			damon_free_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
 		r->nr_accesses = nrs[i];
 		damon_add_region(r, t);
 	}
-- 
2.47.3


