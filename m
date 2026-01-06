Return-Path: <stable+bounces-204961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21929CF6157
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83DD63004F4F
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E7149C7B;
	Tue,  6 Jan 2026 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXS+aqh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A84503B
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767659509; cv=none; b=hLNxZ2wI+hhkE88OZ5I3UXfOFAHBGtE9+F/ABGZJlq4p8Vmcu+D7+r65n3N+fgeTjgUGbg84OBVk2cjRYC6b9i2v7xy7i90mYZL6qwihvnZY3A8iRRPCGZq1jnnVoCH+eYMMEC0XQ5XTVMfm/jhLjQ09HNowRuLtjXy1PFy28/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767659509; c=relaxed/simple;
	bh=I5u2qjKXmYsQV9Z2o4wDYa50SKAvAm9YEa+jCPI2518=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGiMGD8j46tsmz9ewk8IJd5t1Qse2uacEIN/KdSUXU1tew8XH+zWwUgRt/8p8VaOG51R2y2aY71U/j4uiYMFO820COeSMbcQtc6LdCm1b+aFWIZeyWAQCaMn82z2PzAkt0ywR95JkZTzBVSTnP33lhTP5Jz94KbDlEWuTKKqKzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXS+aqh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B47C116D0;
	Tue,  6 Jan 2026 00:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767659506;
	bh=I5u2qjKXmYsQV9Z2o4wDYa50SKAvAm9YEa+jCPI2518=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXS+aqh0AfN2bsj8sCqjy4wa/e4fmslR3QnItrghk2/YzOX2CMUKBTDT30oobgGEz
	 lxABH/G3JvkondzAcneynLQtznaa6jgka7gpwF95sJpYJ23LPob7erLN5Oz/in0cgq
	 Xbhf2PeKPVYkl24f0Hcyc7nX0o8zuwblG/Nx4qc0DxGK6u6fOVX1pnYY2Bn8qNL2zQ
	 hOwo3cWcQJaiL23xndR3gaF19JXHrOqvGvs6DrC29uOlUBXfj2//0hhr5xOk0QBwe8
	 JBBvdlqhxJkwsOdkym8TH8eKsa4Qxddg+aAzyyWLn4eG9vJcae9wmBljs+nnRd1cP2
	 EZ06wuKYBzPyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Mon,  5 Jan 2026 19:31:44 -0500
Message-ID: <20260106003144.2858431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010547-stays-strewn-1e8b@gregkh>
References: <2026010547-stays-strewn-1e8b@gregkh>
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
index b4fc21ef3c70..b335f74e4e4e 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -136,8 +136,14 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
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


