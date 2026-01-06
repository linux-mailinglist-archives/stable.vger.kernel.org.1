Return-Path: <stable+bounces-204974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CC1CF62A7
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D11D30855AA
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616725DB0D;
	Tue,  6 Jan 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWeJe/x2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF19217723;
	Tue,  6 Jan 2026 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661099; cv=none; b=iLIUe2hMPnMnnasYPNVsPYcV7MpJiLMF6WeCfpvldtBl5ryqkILqMRqj8T+/XKxueFgzmPFLzK19J4W3e5gAWrkaAOerdsTMYb44okfgs0qx6LiQ7+cYS05B+MEDSyFt5Q7PM0+9pD2XnCkgs164lHyEKh6DxQZYFWwkhVLFK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661099; c=relaxed/simple;
	bh=F96fY7ioaBqAkDc315DEDOl6s985Nc+tkeDMynD7VOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjJGVB9VovoclkezUGBE9EtnrVdUj54XopN6P/5XiXUsM1SV7K5s+OCkTp7KHppH2X4ioBA0WLmaGDYMuMbaWNhZokzSgrj2Q/j/GPnlZgOIh5M6fKxeY/wkHACrik70kaQapsJ1srrNFvxJmClrvxhpk6wnfdfDxiKCMnaCSBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWeJe/x2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CC4C116D0;
	Tue,  6 Jan 2026 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661098;
	bh=F96fY7ioaBqAkDc315DEDOl6s985Nc+tkeDMynD7VOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWeJe/x2fSMnbEHoX/+edDSWYi2AmdHD1pHqeIThRaJhpvdy8WHOfOIu6l336QTh6
	 WEpElM8TbFTHG+mjwIPWY1BimXbCxB+Q/+sOrPOoU3yO9BebZjHa2EfYIGwgwJekyc
	 0ygNFY+Qu9L/1YC8jzKVEty3ZpA1Iv6TAC9+rjTnaZww7f4JtYpEtYABrVRdserd18
	 5icMls6xagTMYdvMSglV9uHJHEd3XnaFxUFaVE3DULU9iEHSGXgfHmtCW4QRpnFHV+
	 wQx16VGA1AwRgnCw48gL5n3z7BiGeLfSKLhoTaO83s6/7DKyX5xpto4AuyZuS/95as
	 rAlFFo0uyMn9g==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failres in damon_test_new_filter()
Date: Mon,  5 Jan 2026 16:58:09 -0800
Message-ID: <20260106005810.157672-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010551-reawake-rimless-688e@gregkh>
References: <2026010551-reawake-rimless-688e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 28ab2265e9422ccd81e4beafc0ace90f78de04c4)
Signed-off-by: SeongJae Park <sj@kernel.org>
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
2.47.3


