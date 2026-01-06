Return-Path: <stable+bounces-205000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E313CF65E2
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47CAA301F3C0
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5178621B9F5;
	Tue,  6 Jan 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBs60Huo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CB218AAB
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 01:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664321; cv=none; b=FIRKoYZx+aZAj/aDdV/oGjVWhrOiIZ/gF0H0ZMUowDfJ/zE3tQiBV0VFfULyDT2EebnuJJPRgdEQ/NpYE4q2aGTNdvmS9ypmEnXvp25KM4EcqwpLaZdPacgwGiI8JZxUZTRomEJMHAbfTWFZoWiBpKovHxbOdJk3qfEjtQA0v14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664321; c=relaxed/simple;
	bh=hHwcZIBh754A48IBp9O2EJHX2vrIuRRGSkD5Pn61G30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxJ7WXuVyQIWYWs2m8Xem4vUDZlzBUMlw1FX7FcGvO00soGDKuJQIhmAcCmNdkRshfPtDda+o4girhI4pjF6CREoCapCQ8Q11X+0wFSbwXEoPoNQj6fDOnUWLDqDHSsGtg3Z2rliQDZlr5QeYiWngLebYOfS/eOCRVPB4O074EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBs60Huo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF08AC116D0;
	Tue,  6 Jan 2026 01:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664320;
	bh=hHwcZIBh754A48IBp9O2EJHX2vrIuRRGSkD5Pn61G30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBs60HuozAXETKioWI2Bajk2tfDOUizYFnzaIienwRwTutB9ttq/IORBqHKtfF7lA
	 luyyQXjErP00qqmGBgR2TsCQsWxqjm+8FM5WrrqytwX5bFkWScguXet3b1HylwKmTG
	 s/1MDlq6MhSz+dT6xrONJVLOm4XP9CJLimI5EU9lY+nzPmduP21FRs7ITJMB3uNxNO
	 82Olz3+kCOr68Rcc5vgIzfyKM2SxwiBH1J0Fe7pE0DkLOUT+DUF+b6IEfjqyo/ULjO
	 Y0hs+PutH0bENEhGCA0+uMzFopVFJMszfDsy/khlSRBqZQWy5wFC5rFnNNQe51BZVz
	 4+W9/clgrXVUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()
Date: Mon,  5 Jan 2026 20:51:58 -0500
Message-ID: <20260106015158.2896483-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010551-reawake-rimless-688e@gregkh>
References: <2026010551-reawake-rimless-688e@gregkh>
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
[ adapted 3-argument damos_new_filter() call to 2-argument version ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core-test.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..2bd14d2bfdbb 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -346,6 +346,8 @@ static void damos_test_new_filter(struct kunit *test)
 	struct damos_filter *filter;
 
 	filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
+	if (!filter)
+		kunit_skip(test, "filter alloc fail");
 	KUNIT_EXPECT_EQ(test, filter->type, DAMOS_FILTER_TYPE_ANON);
 	KUNIT_EXPECT_EQ(test, filter->matching, true);
 	KUNIT_EXPECT_PTR_EQ(test, filter->list.prev, &filter->list);
-- 
2.51.0


