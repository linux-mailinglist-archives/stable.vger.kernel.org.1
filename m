Return-Path: <stable+bounces-204978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6795CF630E
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8245303A19F
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D7E3101D0;
	Tue,  6 Jan 2026 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCOnZxgr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA188277CBF;
	Tue,  6 Jan 2026 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661693; cv=none; b=gYp68aeVWzN3PNGRwK0NwEecq8burnp6Cy3as2j/ujxa4XWVXOCIKAR1lpZvjDKVLU8NAkg8ZaGIS8gapDQ9d6eHWXlooUn1Icnt/QvGpjPvfsT5DW6khWWZe3LlY56V4RTEWqFcFKz2tk+YEQqWYdFYXDf+KjIfdnQbwxd8Lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661693; c=relaxed/simple;
	bh=Nqe1OtbWoGQxa9B8RvzMhi3i5vGgIXegG8AJFLHfaLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVtoRQGWSReKaCi6ejoYNQsCt1Fh2i7lSFUmZwN7CjDcZOvklXCViKXRPDfnbkT82nRkgIBjI4Uy5P0Z7316QwOWm+4Ow9pGJ5GRsCkW6tzrm9U1KdcNKh7caiokiO5jUo1PB2qfhOoj+GnrS0iyljLM0S5R0XRyy0bb7CWmYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCOnZxgr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5D4C116D0;
	Tue,  6 Jan 2026 01:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661693;
	bh=Nqe1OtbWoGQxa9B8RvzMhi3i5vGgIXegG8AJFLHfaLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCOnZxgrhkLkg1OEJ4/Pbmz2nR7qN3NaN578gAW0hKyEO9YcdJeqJ7zAqgfse0fEA
	 eVr6waETs+ofsPTeXQ64O70lKoIVwd6xStQUsI99ddNW+zQ7HxOIKCYyeNmciIUAYu
	 6zrSGOXm6hF9MsfUq53enx8CuQy22oqB7ekAQZglOnMX/XdUUVCSN2y5hQJE3N3TmW
	 IB5To4tGUxCtCk3YBzpD5+nTlPfOTL9ofgVvecei8nWBDc71GcYFDGTA7olKrrA2Xb
	 QWtaar3XvJ6vkK87PJnP3UFI1lp2fiu/0HiHe0FNa6CdU7PGwTJV+NpVJXOFh0aNlb
	 y7SV+OxO2VvSQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failures on damon_test_split_at()
Date: Mon,  5 Jan 2026 17:08:05 -0800
Message-ID: <20260106010805.213189-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010507-underfed-amends-4275@gregkh>
References: <2026010507-underfed-amends-4275@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_at() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-6-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 5e80d73f22043c59c8ad36452a3253937ed77955)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..7968458d9ed5 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -123,8 +123,19 @@ static void damon_test_split_at(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
 	t = damon_new_target();
+	if (!t) {
+		damon_destroy_ctx(c);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_destroy_ctx(c);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
-- 
2.47.3


