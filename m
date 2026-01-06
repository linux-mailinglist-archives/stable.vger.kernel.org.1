Return-Path: <stable+bounces-204968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9960CF61FF
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D94F930215DB
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4E1F0E29;
	Tue,  6 Jan 2026 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/ZvBwZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE34A3C
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660918; cv=none; b=NrIveYGO6/e7H+nqFK4WZuhqpPsa3Fh+X7fPIsvK1/zxEXJZIDQdlOiiEbhIBqhuanvYNZmwoony4bjPerzdUSVBpxkzW8s9lG3E4yDPeQvzXjnXF1cmojYztEwoqeEn056/ISaSqNCKS1AyTpwA9QPDUlibSoJ9SMFd+wqXx7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660918; c=relaxed/simple;
	bh=mHWVZd2KXER1x1IfTvb/j9xyrtvExO/0m/3yvZYuC6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFGVVcFYEL9wkjAXG45XONMmXl+PLpSmXpWrA/e6h00i0FjSxlU0zN8JRJy0a/lc6DeKk0YAzeWzMVVV9P4a0djOsVvhKE9Qh0/KVi2CkRoU2dTeDKANOFkkWffYHwr2J8rQZlTGXqZnHZiieEytcZzfYEsdsq/Bls9vV3/OFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/ZvBwZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB041C116D0;
	Tue,  6 Jan 2026 00:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660918;
	bh=mHWVZd2KXER1x1IfTvb/j9xyrtvExO/0m/3yvZYuC6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/ZvBwZfjKlxKzduTo5cX7KAThCCeesQzgFkUUdvu85wUL5Ut/ZbAXjIUqGDYVj8Q
	 mn8u/+6CfbHkwlvQYt0eqUcbSk826w+qHzjckG0jiVjgKEKfc4pKiJ4NZHulVjYB6t
	 41Fpayy0UZl5bDjW0BJtTXJZg15yRzishWMLZqUKHbDI5i7Q3cG/o6jiQ3myrbDPMn
	 U1CAoBG9MFuZrzd5kzRpMV41bvyi0FwLIb/Wbf6Oivo6V5qRU/NOQdlpaRebHc874F
	 W4UHmeI2L8+CwUN5/qw+HeNmTjYT94ncnyfkoPstnMgAk0RioT1SLCUdBYg38i2Cmt
	 N6TtOFZr/fpWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Mon,  5 Jan 2026 19:55:15 -0500
Message-ID: <20260106005515.2865529-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010547-prankish-amuck-8ac0@gregkh>
References: <2026010547-prankish-amuck-8ac0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 2b22d0fcc6320ba29b2122434c1d2f0785fb0a25 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/vaddr-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index cfb3ba80a642..6af42ef7bff4 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -128,8 +128,14 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
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
 
-- 
2.51.0


