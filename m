Return-Path: <stable+bounces-205020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71294CF6785
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 27F92300B032
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06421DFE12;
	Tue,  6 Jan 2026 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="im2CHHda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7553A1E92;
	Tue,  6 Jan 2026 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666649; cv=none; b=mxm5MEyb+zMPrUh9/8KOW+Ph2G6KjTOqVox/7rI8ZEUBuEc0tuaoBkpQMBKiwCM92Z+jtWPZYM+Jtf8b0XRG4bIjo09WGKQ3ra5qiOYdu4JZNyX3K8Pw0K0bvK9A6ckkt4RDHwBAyLmYa1An25jnI+pI6WNFMd0x4gN82Ph/rAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666649; c=relaxed/simple;
	bh=filNyQeztsiNwgd4b3gX3hNfPQnopNSNlKFjfYOXyfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2ZdrbnP+WP5UTeiOrPAMwTFbvRng/9rA6gWfwZBYuegIbNixuPoOS5fgghleumkmjqIlr5AmgjhZ8EcWg2nZQ8upqzOsKsSe6VPqcHDkyR2QcQUH/Oo6G0vDkMMmyqLSL7a1ewBeBoGXct1TESjjHoP7Tda7/Hh59+Pp98UVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=im2CHHda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35CBC19421;
	Tue,  6 Jan 2026 02:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767666647;
	bh=filNyQeztsiNwgd4b3gX3hNfPQnopNSNlKFjfYOXyfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=im2CHHdap8IuLzXJgOuiSUzoVrpyl+ma8+7WAGfDUjqxmNVR3V0Hr9Uc3FyRGTbLH
	 aGszmbUtuXa0GrqOM4FMMGwH3OKig8nYNQLnUyTE7zHas6W0M8+M7GtNwwA++MGviA
	 1w0EoRDKbCW7MZoxeRJHMVYN68d/LXTjAC5Ztlqp+vwmxUkwvIH9LbsHVJDgIwY+vc
	 XDS9gH7edsgHDWUSQGfoaRwuNb0An2ELbZS4NlZeVpwXU5ZMQ9ChZfpDc4VpxiTg+/
	 ev7Aaeis444b/Or12jM1cmgOwnvNgA3uH30ZyBkwf+2gNc2DgM77GfArCVPBg9EQVd
	 +B+CciYOIgV8Q==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_regions_of()
Date: Mon,  5 Jan 2026 18:30:39 -0800
Message-ID: <20260106023039.723600-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010534-channel-backward-c4df@gregkh>
References: <2026010534-channel-backward-c4df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit eded254cb69044bd4abde87394ea44909708d7c0)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 7008c3735e99..5741d08bfe0e 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -215,15 +215,36 @@ static void damon_test_split_regions_of(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	t = damon_new_target(42);
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
 	damon_split_regions_of(c, t, 2);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
 	t = damon_new_target(42);
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
 	damon_split_regions_of(c, t, 4);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
-- 
2.47.3


