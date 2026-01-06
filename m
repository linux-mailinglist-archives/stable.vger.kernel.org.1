Return-Path: <stable+bounces-205022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C6CF67B8
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A7E3015AB8
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D4221D96;
	Tue,  6 Jan 2026 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIHVkDeb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4713FEE;
	Tue,  6 Jan 2026 02:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667009; cv=none; b=D+b4p4Qkz9q6o80AWdh0BOI6jlHHuSM+dDzu87douaJALMHGOUczayEqJwyc9pAvuBY3SKIupdQoDA2/Wx9slyaHoEliVBBXLGvetvyGiGgTkrQbiLjQaZPs++yNANJ8Xen3craa6d30s+kjBRYLwb2gD9nepywFsKoYYDXLZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667009; c=relaxed/simple;
	bh=K77vRF2z+F2191owBGhkkmPoUEORvLNRHqWeHgS/rhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fShXTxr4a9q2BHZObWumxUK7Wlhlj1QLGgMP9XLw2JHt+Z8nepIiGVudmvE75llj1Ay87vdZaHrfkImHjvceVoeXA0RbYyDwizX3yrCaFWQwcQeB8NHEQoB+zYYoUBbr+chFfnKpgZr8eVWM4LFL2Cngr6DPssD+S1bwwzst8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIHVkDeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54D9C116D0;
	Tue,  6 Jan 2026 02:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767667009;
	bh=K77vRF2z+F2191owBGhkkmPoUEORvLNRHqWeHgS/rhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fIHVkDebqn6yQccrm8IyK1y9Y1RsyfiKBetDMZOS8oOzp0tLqTJI7F0fzmQbhB5kI
	 Uv/toRdGlYmGKOyaGh61l8tC6wWsy6g/TqVmVYm4NHM9qGlYeqMJsg9lNNkg4u163Z
	 frGtTCHaNXa2fntLMsdiBdziPF6fOVam92tcLRstj+nuQ8eCn+0RNGQ9GgKRBla8be
	 7beG7OVMDKuJVoVgM2sgmwUEOSg6oz8URcnY+/QKukokcnfhy8ZGwlPYtgskFWkx31
	 VYsAGrwqj9oFaqGq8Q/0fXLKOvmS+g7YjWiA2SnCaRLZpqGlzSeDY7N+/QzzIuPCC4
	 47tZGAqCO7eTQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle alloc failures on dasmon_test_merge_regions_of()
Date: Mon,  5 Jan 2026 18:36:41 -0800
Message-ID: <20260106023641.765797-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010500-endurance-wobble-1a3c@gregkh>
References: <2026010500-endurance-wobble-1a3c@gregkh>
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
index 3db9b7368756..a61697029d74 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -193,8 +193,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	int i;
 
 	t = damon_new_target();
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


