Return-Path: <stable+bounces-204999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEEACF6615
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F66E30A5E81
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191221018A;
	Tue,  6 Jan 2026 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhiiLrS2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB87640E;
	Tue,  6 Jan 2026 01:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664258; cv=none; b=q0vT3yAnLbjm6aQSt6dpFsUd5v/U+LsXdbt2aoVbBx93QfgqQQClDlP3edkFCQpLpfFQIlE5Ph/3NmJfs1EjA6sdZxdnpVG0K7wY5knEhsP4XhSLcc3sTdNaFXVabofWeIGgjNusFA+43mwq7qg/IolPkQM3xqUsDRgPYioCxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664258; c=relaxed/simple;
	bh=8LDIXigUmvOXk0kVNtQK8//9JfKJ+39d3l5otcOXLLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyDwG8H5HxjO1oy6h8Y+pOH54yAq6TRoxYbeSSPy/XE8hryOugZrdBwwbzBdtZTO3rOL4rciTme4ZLNkqm0TxWVtwu0iO4eUkJ23yr9MPCGpckphivr0n/e2CF5iPEba4bLCHGZj6OPQCd8bz8HgbH4RnB6+fj6WbGh9Df789/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhiiLrS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226C4C116D0;
	Tue,  6 Jan 2026 01:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664258;
	bh=8LDIXigUmvOXk0kVNtQK8//9JfKJ+39d3l5otcOXLLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lhiiLrS2OYvnzdnqu1kUrIhZMx3yG5E6hko+IOQgowAq/tpBxc+FekqflyneXqU5Q
	 3jUySwwG7Sxz+wQunmGTixNNK9NJmYyvETv3uuY6AoPSgc8F+qI/yz+sCi6JxF+abV
	 xFa3QLfp6pWOucMo2PSl+r4MdHsoovatFnJexwsjsf9ldeb9kn+6XVQATNVvetoxio
	 qce4tnmlpxOj+B2xRagvyyuYLwG0hg9X6acU/fUCvfFjTryvxW7bHGgsy85CUSEe/J
	 ZyagFoKLA4fPz4rEXDXuL6Wo5beI2WRMCtUmGBBljbadx/6wUUu3L8IuFJrXVHYrES
	 gFC80S0BdJNBA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Mon,  5 Jan 2026 17:50:51 -0800
Message-ID: <20260106015051.430918-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010548-collage-trekker-25c4@gregkh>
References: <2026010548-collage-trekker-25c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 2b22d0fcc6320ba29b2122434c1d2f0785fb0a25)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/tests/vaddr-kunit.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index a149e354bb26..2b7b5d4d4499 100644
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
+			damon_destroy_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
 		damon_add_region(r, t);
 	}
 
-- 
2.47.3


