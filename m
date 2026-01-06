Return-Path: <stable+bounces-204993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 761EFCF657C
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E75A6300EE77
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D02D5926;
	Tue,  6 Jan 2026 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uuaj6w8E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6312D3ECF;
	Tue,  6 Jan 2026 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663609; cv=none; b=hi7z/BdqEJcfz+kWTwpCK6OQGZZUoR84uSRI3qCVs3NeO37o7m8d8xDnGlE63UaIINi+NURUij33vycasikI9QSrISNtrFJw1PMi09Iu18lmzn48X2trZkrXd3AFSRzazXc0QKTTps7H3cYe72IUzIBBTp2mpPE1Gl64xVyWea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663609; c=relaxed/simple;
	bh=jbHewUdkzdHYPbuOJL7+w2va5A0HR07Xx44pP0YSHFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZL3o0AEMIBfuqEE8gqWW3rg9gP0N3UXQQJ+FVwvz3io6u8FM0xpSoIhyLftjk4KncjlhKqBLK19i9YwMkhG8WnDg+cEdZfHFfFwgHblkh0zpQTyeEjMmejyH26jqVsp0pGXUFPlJB0hECfLkGRxKdHHRwDG0WpHNlqnI9WHPkcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uuaj6w8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E69C116D0;
	Tue,  6 Jan 2026 01:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663608;
	bh=jbHewUdkzdHYPbuOJL7+w2va5A0HR07Xx44pP0YSHFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uuaj6w8EaLWNMgWWjmUGzGG/yFmzOJRzIn2YGBmbosCaUuQcNlZuIE9KNqPfgVH/L
	 d3LbT6IfPaciwDKNP/HwIVgrwsUlDE/LehBjtxHSbD3Es1M3U7NPpu1OpOBh3cRT3J
	 TDrs25rll1IO8DTKqjWycPLMJRlUYbY8DOoyK24FoyZrqMDIj/U4ZSXVfiagBY4R9N
	 Q/j+6si4hGErJyuYbwWpBS419zv7+wpZwdHqdi9Ro+qhtNASi1tH3cOlkWfW1rIhKN
	 JsO5Z2Ba+yXMnd8irH7uZwcs9OmtCwNQyUvjWSZvqVY40KhLDjyZj9Ik/dLm5r9hG/
	 ofVmGsS40eVJQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failure on damon_test_set_attrs()
Date: Mon,  5 Jan 2026 17:40:01 -0800
Message-ID: <20260106014001.336894-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010552-thickness-copper-cc49@gregkh>
References: <2026010552-thickness-copper-cc49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_set_attrs() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-13-sj@kernel.org
Fixes: aa13779be6b7 ("mm/damon/core-test: add a test for damon_set_attrs()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 915a2453d824a9b6bf724e3f970d86ae1d092a61)
---
 mm/damon/core-test.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..454e9e0b525e 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -326,6 +326,9 @@ static void damon_test_set_attrs(struct kunit *test)
 		.sample_interval = 5000, .aggr_interval = 100000,};
 	struct damon_attrs invalid_attrs;
 
+	if (!c)
+		kunit_skip(test, "ctx alloc fail");
+
 	KUNIT_EXPECT_EQ(test, damon_set_attrs(c, &valid_attrs), 0);
 
 	invalid_attrs = valid_attrs;
-- 
2.47.3


