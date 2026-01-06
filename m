Return-Path: <stable+bounces-205004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99BCF6624
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A62D30042BB
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3521FF47;
	Tue,  6 Jan 2026 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS1SNVbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8621771B;
	Tue,  6 Jan 2026 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664569; cv=none; b=Xuhg4gz6yrHHyytKdg6kePO2ItWTa5yAWCvVOi2WEzPbeRQ4Qa2wcBEqNcTIJ9NbxRL78jptfTz1Gdjr3vKvOjw+mF4HYQuj0bMNxvFTHYPt+JZCQjJN1oJg2AGLsxbuXCdhIYWpA37eVoq1Y0PhGWYGsEX2++A4PB6T5VmEg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664569; c=relaxed/simple;
	bh=yg0l5b/YlhCk1namQN79MCEVjyqtc5zx28apkNKmtwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LC/Tz2O5qwz4yAVt0gXjYWD/+KG1KeaMwf10glo3nh4sL6XI3vXgg1fGo7pvtbU8br7hDzdgVMXMjY7NOrLZyhrtaZrdw/S4HOOlzBgXHTD78oqWjhhTqGQJvNWVpcjpjd4iLXIN6wGrT6MESMqHnAyEajejcqaXxe474TVm33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS1SNVbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C98C16AAE;
	Tue,  6 Jan 2026 01:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664568;
	bh=yg0l5b/YlhCk1namQN79MCEVjyqtc5zx28apkNKmtwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iS1SNVbZRk64xR0pat/iXCGmrgMPH5MdKqOO+MPJSbaA1oWvy7X/RhOzXwqBbya5h
	 j0N42zH+pOyYdoGeLJ6BOZV7OQFEGty4zDn1Dx7g12aeJDwzO+9QJMF7uMaonONBsL
	 ru2Crs6kFsuOBnXs7/R75bI1YvUAA8nmSqn6juOq2Oh7iANDHw0zB4v7dF78zFhCVS
	 40hXPw9Mp9hYwNwtUsZgKIDVbLusqk249Uo51qgWg1zrtPX8DsDW0JEP2ON1VmoBkH
	 CfYtYaSmlw8VqY55brkrmgDXlcBXbbIGO1RIEnhFXo+vNE5vmoUUIwGDLWyi9X181V
	 T5hTZMsQrmXMA==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_test_split_evenly_succ()
Date: Mon,  5 Jan 2026 17:56:01 -0800
Message-ID: <20260106015601.507249-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010513-icon-slit-98fa@gregkh>
References: <2026010513-icon-slit-98fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_evenly_succ() is assuming all dynamic memory allocation
in it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-20-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0a63a0e7570b9b2631dfb8d836dc572709dce39e)
---
 mm/damon/vaddr-test.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index cfb3ba80a642..283f2828da01 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -261,10 +261,17 @@ static void damon_test_split_evenly_succ(struct kunit *test,
 	unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
 	struct damon_target *t = damon_new_target();
-	struct damon_region *r = damon_new_region(start, end);
+	struct damon_region *r;
 	unsigned long expected_width = (end - start) / nr_pieces;
 	unsigned long i = 0;
 
+	if (!t)
+		kunit_skip(test, "target alloc fail");
+	r = damon_new_region(start, end);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 	KUNIT_EXPECT_EQ(test,
 			damon_va_evenly_split_region(t, r, nr_pieces), 0);
-- 
2.47.3


