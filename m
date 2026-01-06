Return-Path: <stable+bounces-204965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C83DCF61CF
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F711302954E
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11577260D;
	Tue,  6 Jan 2026 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvDjdF1k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73D533D6;
	Tue,  6 Jan 2026 00:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660757; cv=none; b=HwhCMXVg+0aceEqNoRUirl2Rg+RwuSxWLWiI7owiKsl/0TWn4NJ9HXq/afyh29sLosqE5w8LTylIxzPFtIfJkPpuZaotklT5JRdSRxaPw016nHIxlU1gArnjnGkARgUHBNW9xUNwJRSmh5coP2Hy3v1pszjI60nCrT1yf8yXfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660757; c=relaxed/simple;
	bh=vTsJ2G1Q9TQJfo3pMoQqiMpn0wGcHpai1csSJ3EpRbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmVAoYoAD7BFy6HOo1JVhum3EtpuYu/aXmmY+ReE4/NNfLz9T8+32dPB6GwOSweP+H79fhO2Eau1bHEVIgzN1f+Df7PgRS9leqKPds0QQVAwXvFyLhzD9aUx5hyHaohdp2hvNJTItKWyoWV1YW/YBI+iDClkRI5OR+o2M79S7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvDjdF1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02C9C116D0;
	Tue,  6 Jan 2026 00:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767660757;
	bh=vTsJ2G1Q9TQJfo3pMoQqiMpn0wGcHpai1csSJ3EpRbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvDjdF1ktwmpPBES8Whnw2dN5zuXJN1X3tFdoosc65emjGUvs5DSQe1io+Uve0upp
	 pt5cjLmuiSsblUCbuBRl/eoPMjH3iTBQcd6yVYzmHMEDjekSpwP9tdtInWzqlfO5C3
	 Le/H+p9FXF8K5L687guIWAuDqEBhkAMz4yf23IaAHkDs8n7fsBcdQ1rNhiLTtKUzMw
	 GEmq5VksOa7BeuTKj0MyqS/2K0uHoF7Fgyuq7cWtRaYWECgD49TCdvB4m/yxbkFXoM
	 ToLgxOWOPt4pZY9U/+11Z/4zkiK2EE6bgldYEpqZoZAnXrWDVzALOmbureaUTeCkam
	 eHw9zSh4nnhMw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Mon,  5 Jan 2026 16:52:32 -0800
Message-ID: <20260106005234.129270-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010547-stays-strewn-1e8b@gregkh>
References: <2026010547-stays-strewn-1e8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 2b22d0fcc6320ba29b2122434c1d2f0785fb0a25)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index b4fc21ef3c70..8d59e9cc57e5 100644
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
+			damon_destroy_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
 		damon_add_region(r, t);
 	}
 
-- 
2.47.3


