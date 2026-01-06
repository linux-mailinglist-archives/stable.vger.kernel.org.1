Return-Path: <stable+bounces-204986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B455FCF644A
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860D8305B597
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58D1D5160;
	Tue,  6 Jan 2026 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot9GTP0L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7419005E;
	Tue,  6 Jan 2026 01:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767662896; cv=none; b=jd9iUtWh2EZbKoiaAn54qLJYBXfISexzNX7E/PZC6X+7/YBJo2qTBf5ufsbkNn0M+Paj40T6YQBHkEJSG5TCKKcHDYfyTkaEU073XYwZrcQlfboCpAqaZV4QT6LAb1Xz4CL6/w4wkCBn39s/vwe0LvEYTPEWC1n4Jph7CotOhno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767662896; c=relaxed/simple;
	bh=jRbLr/vFdmc7H7zJR5iEEpMCWfu8hjpCIOBnBCTpJjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDbrlEK6oqFVbVIVmLXGnHHlABb7nsstgDw6uXQ8rBGun10Cj/DDkJNA+UOTzGMVMsWiOcsAqx5oLYbvHzJ/9brfOctNpHY5LL33XRAbX9vEiamG/l3u5FynG/851mgxV2+/+JaSwhABvIdcnVbt3dUmGPXtDDb2iJse5dPcjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot9GTP0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80DC116D0;
	Tue,  6 Jan 2026 01:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767662896;
	bh=jRbLr/vFdmc7H7zJR5iEEpMCWfu8hjpCIOBnBCTpJjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ot9GTP0L9kCiCXB16ciNs/3EmqNnhxZO0MHqi5iB1MnrxnSgHQDFMv07AlQzCgDta
	 dvt8pWSp+leN/rBrWT/LIbLijDbEFpjRmU/Di54lnJuMPIovo9nyNoKfGPMByPJpgq
	 J6wtI5s3Km8mlDC7K3CPb+DMY33wo+SrjC1E8ttDJdy6vvX3lFCU6+goYZJIo/fz8k
	 +8XcIxzLk4MyCj01EzoZaM741KmpRGPa5iOYeB7Q95eBgnVWjQPccMEETdH+u8pMhC
	 SbIbMICIbPzJE+mKl95qbZQoXeqOqn40XtjDaVv+WT3OOjuC70kB4Lez0qTVBeL1ZL
	 ZC9tZtyaAxRqQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failures on damos_test_filter_out()
Date: Mon,  5 Jan 2026 17:28:05 -0800
Message-ID: <20260106012805.282751-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010525-threaten-recliner-cac7@gregkh>
References: <2026010525-threaten-recliner-cac7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_filter_out() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-16-sj@kernel.org
Fixes: 26713c890875 ("mm/damon/core-test: add a unit test for __damos_filter_out()")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit d14d5671e7c9cc788c5a1edfa94e6f9064275905)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..7ed28bf9704a 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -360,11 +360,22 @@ static void damos_test_filter_out(struct kunit *test)
 	struct damos_filter *f;
 
 	f = damos_new_filter(DAMOS_FILTER_TYPE_ADDR, true);
+	if (!f)
+		kunit_skip(test, "filter alloc fail");
 	f->addr_range = (struct damon_addr_range){
 		.start = DAMON_MIN_REGION * 2, .end = DAMON_MIN_REGION * 6};
 
 	t = damon_new_target();
+	if (!t) {
+		damos_destroy_filter(f);
+		kunit_skip(test, "target alloc fail");
+	}
 	r = damon_new_region(DAMON_MIN_REGION * 3, DAMON_MIN_REGION * 5);
+	if (!r) {
+		damos_destroy_filter(f);
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	damon_add_region(r, t);
 
 	/* region in the range */
-- 
2.47.3


