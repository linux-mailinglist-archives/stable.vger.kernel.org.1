Return-Path: <stable+bounces-205012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AECDCF66D3
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B2183013EB9
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DF322D9F7;
	Tue,  6 Jan 2026 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDNsxC4n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEF4223DC1;
	Tue,  6 Jan 2026 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665475; cv=none; b=PD6pY4DXWoVheS3uSGevFaWJ3bORpGq7uzU4uzP20gko89aMaVqXb+nCnTuXZgLRHHvKSOn69quBrNlFfdkWKlQeLrdWjBEYG4gbpKd9Vjip+rK410h8yGiBtvkBvzXwJHGVk9gEIzF2jFIfwV5rwAJio4RUfEF5uFBgtzTKrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665475; c=relaxed/simple;
	bh=UIITIbJmLpB1fxHoQ4xiPhYM8+gal3Je19wQmLilpLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7jR/EKWBEPNBJuza6j9M2XCS+sPtI7VODR7hsjbPMyMggleASqXITurQYQpz4jit8lP8poXosWLpgISWwNEBovrE1YAcPIgrDpRegSI5QXVwaG4cJCytY1DvCv2qs6A31Io/u/66gQbgIhTrFi1ANcvMsmTQoL5VlObRk8vwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDNsxC4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A475C16AAE;
	Tue,  6 Jan 2026 02:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767665474;
	bh=UIITIbJmLpB1fxHoQ4xiPhYM8+gal3Je19wQmLilpLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDNsxC4ny4XfKgFbXiD5Ve6A9Yfc4+coF/7boes3ducDa4JxznICdrtf+oQSwxyXb
	 qvfyYolAeP8KX1zyktr5sph0QWeyiRZju09rWlAswnXAawySYUNHap+141m/aEg3yo
	 BD2aoLJ5JfP7f0DQZfv7Xyi1CWYKFA1RE2LvG69K7rpP38lhZAuxT4Dwf/Iip0QDuT
	 aAGiN2kgbh1+ktNFPl2JitOe2ma/GiszEikgjFcTm8zS+lAeeYm/JfdlWsyy3FboyN
	 cnldaV6EDqyW4RiVxE+robvtfrBCIMOD8pS5gmPvFIHSK0Gskpxf8mJp7wQuzCUKaQ
	 N7U9pZdqQS6vA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/vaddr-kunit: handle alloc failures in damon_test_split_evenly_fail()
Date: Mon,  5 Jan 2026 18:11:06 -0800
Message-ID: <20260106021106.608431-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010502-turbojet-conducive-b2be@gregkh>
References: <2026010502-turbojet-conducive-b2be@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_evenly_fail() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-19-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7890e5b5bb6e386155c6e755fe70e0cdcc77f18e)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 5531766ff09f..eaf579a054b4 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -256,7 +256,16 @@ static void damon_test_split_evenly_fail(struct kunit *test,
 		unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
 	struct damon_target *t = damon_new_target(42);
-	struct damon_region *r = damon_new_region(start, end);
+	struct damon_region *r;
+
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+
+	r = damon_new_region(start, end);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
-- 
2.47.3


