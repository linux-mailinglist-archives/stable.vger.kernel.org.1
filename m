Return-Path: <stable+bounces-204975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 223BCCF62D5
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E9E030024D1
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4B2273D75;
	Tue,  6 Jan 2026 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG2AjUvp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC02701B8;
	Tue,  6 Jan 2026 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661254; cv=none; b=gWNEYeD5ZJTqb7Bfzh28cK/w8zaOglKNMUFYUm35O1BGEHDGDmSY6gwN82nhp0PiD/TwSouJqhm/KGSL5NHlN95t7L5/rDq1UjoTaKibZkcsao1+yrFCQDBlPk10k8t5erAa0RzqbjcDLNSTaPXbKA8GGv+jR0b4x8khEHVcXDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661254; c=relaxed/simple;
	bh=AK36CBSAFpVV65R0qdbXfYIHqqqPfWOtTd1MzKkxNBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co7GSBleQBBY8nWBjGYIP53D9x0AR3QSECspF8TGefZxLrqMg+hM9rOxRIe5CQmqA+fsyZRMS6NLBOQWi9iwGn1G5rJ5z5KWR7kkt7hxRDpbg0Wk3X9Cct/Lvol6Uvywwr3YsirWs9mu+jbbOArPEa9q+cCJnyL2Gp7zuA9dPqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG2AjUvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D640C116D0;
	Tue,  6 Jan 2026 01:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661253;
	bh=AK36CBSAFpVV65R0qdbXfYIHqqqPfWOtTd1MzKkxNBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lG2AjUvpxx1PIpV9zVamvO2z8kznU3LeKraHvlq/CKpSAbjSkHyFIKtmgpRdcZCbh
	 KkX5pxIJycFQUBut8KhKlf/s0ICt77ZT1rGKtJc5xJBXZAO1VQknKhhFuZWnvkAsCm
	 3GI8KKj4aDYM24WBGY9hiRsWJkAc+hw4qWCMxQRYzwZu/tpTIZJKQZ3dLueRx0M8rU
	 J+mF/8egd/Zi9aUADJNpXMy4r2X248jdhPU8x80cKM+GRu1og1wGrbruFKfGpQJJ+B
	 5eH41ivurDIP1mZXgMP4e4702aBrP9ECU+2JYYyXZME7RAyw5WjDVZS8Mr8WwLuhBD
	 GHQ2zdhPgnFXQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
Date: Mon,  5 Jan 2026 17:00:36 -0800
Message-ID: <20260106010036.171230-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010522-unrelated-secluded-4f8f@gregkh>
References: <2026010522-unrelated-secluded-4f8f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_regions() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-3-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit e16fdd4f754048d6e23c56bd8d920b71e41e3777)
---
 mm/damon/core-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..23a6d3ae9aed 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -20,11 +20,17 @@ static void damon_test_regions(struct kunit *test)
 	struct damon_target *t;
 
 	r = damon_new_region(1, 2);
+	if (!r)
+		kunit_skip(test, "region alloc fail");
 	KUNIT_EXPECT_EQ(test, 1ul, r->ar.start);
 	KUNIT_EXPECT_EQ(test, 2ul, r->ar.end);
 	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_free_region(r);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_add_region(r, t);
-- 
2.47.3


