Return-Path: <stable+bounces-204972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EF1CF6214
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E664E3058A17
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225FD1F8BD6;
	Tue,  6 Jan 2026 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU0u+0Vw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB01F4CBC
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660933; cv=none; b=gL/0+aA263PxpEVeEHU1kNFiPlnbkaIYC6eVV/YFAmMjEYFUVZh4mu2zlyBnq+91mz9wToHCr6TnK8JvlHolwizyfGgrAEDjUiopru0eGR68Wh/wNC4D9Tvmoexs5+soSr9Fq/AsuclDSuyc+Zrxaw+OT4mAQShvpG+F3H10Id8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660933; c=relaxed/simple;
	bh=THu4IqrjHTWARL/ECJDl/BmGYN9FdKUztIaFNExWDfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryveIEVuRDJq778B6Hwgk0XqUxeA1FgqrQWkHOhBxel6a48DGRZjQyDrukilasW/YQCYxKNvedjGNqN6O6H3WwgsDIbee3ogENRfe4HnVVXOVNZaPHmPQlwuOiLg0kvI2RTBh8yZ68nU6v3Pd0l43CSbwnMwHJfhiZodqWIDSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU0u+0Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7B8C116D0;
	Tue,  6 Jan 2026 00:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660933;
	bh=THu4IqrjHTWARL/ECJDl/BmGYN9FdKUztIaFNExWDfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GU0u+0VwZ8XOA18DdJZyzL+3/bEWfR2BbsYQ2rW5m1tT8yUZN0koqwvhbeSeu+Enc
	 NKXK6BxpMAY0YxdY9Zk3QI/+JJVzy22Mf61ZGzEOwXwdbemYiiI1mpdRqqWNleCp0z
	 uVB7RodrMHtp7ybfUtLIMF84Et6QSe8b/IeYdLQwB7Z9XHg7KJ4g3rZoAP5zsPeVsg
	 P/7LXecNLkooO0Yojb1jM6YY++i8VBp682GdYKR6Hr0hh+Fzy6sfFst4ZhvfdZ+RDB
	 TD6atX9h0CPrfL4u11lQZCMU3gOebwtfDRqwUstjh4GkbNUeAI1Sdgn4A3AyqOmhQT
	 aZSg6Qmq27i6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()
Date: Mon,  5 Jan 2026 19:55:28 -0500
Message-ID: <20260106005528.2865815-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106005528.2865815-1-sashal@kernel.org>
References: <2026010550-tank-repugnant-eee6@gregkh>
 <20260106005528.2865815-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 28ab2265e9422ccd81e4beafc0ace90f78de04c4 ]

damon_test_new_filter() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-14-sj@kernel.org
Fixes: 2a158e956b98 ("mm/damon/core-test: add a test for damos_new_filter()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/tests/core-kunit.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 2329158c6f5d..cd27f0e8f840 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -412,6 +412,8 @@ static void damos_test_new_filter(struct kunit *test)
 	struct damos_filter *filter;
 
 	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true, false);
+	if (!filter)
+		kunit_skip(test, "filter alloc fail");
 	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_ANON);
 	KUNIT_EXPECT_EQ(test, filter->matching, true);
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
-- 
2.51.0


