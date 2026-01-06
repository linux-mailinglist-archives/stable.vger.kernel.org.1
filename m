Return-Path: <stable+bounces-205026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 322FCCF6818
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029693013EE1
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE2321A95D;
	Tue,  6 Jan 2026 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG6g9TFH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DFB1F2B8D;
	Tue,  6 Jan 2026 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667692; cv=none; b=Nm/DqZ2ecc0Spsdxj2gE8iLRfjIKBDPfzWoRXHTY6v30LLCbVZd8vQXbywiKhG4qPb3uG5wLxwxwCMp4qcBu8ykmbpSfywQylOvMO25OuFu7Lxd+fNVxVCtp6sWARXC0e3022w4h0A8GQGwfRETz/bxKpLZ/d/dSyrf7iX4c+t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667692; c=relaxed/simple;
	bh=aVkBQdhJrZqDYwn27tPOSh6sJwxcdAfhE4AkEP4JkEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDxmWUSu9U+B+Et0YFaJSMDtmHTauh/bSl4becLzKTeCdKuUyVtZROBB1TFxMO+E1/hCB//j8pVebfqKLCc5Ahc/d5ErBJPi0ergmoJuxpo1hlu4oM8EKpCwLKEKGix6W2gJTgmN8QaCYOCl1klzrlRsikBSIxZwXF1rTUo9of0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG6g9TFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FB1C116D0;
	Tue,  6 Jan 2026 02:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767667691;
	bh=aVkBQdhJrZqDYwn27tPOSh6sJwxcdAfhE4AkEP4JkEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mG6g9TFHEKr4C1x0UiYNMOshLOVQqIAM+lnTSLCaxPuPqAMJ5iM0/qQiN2Dtb72Ur
	 98iwvsz/3QcR0l/ph4bnBIqgnQYEMzBDfwyJ4cz6uUs2XFHcG0fsEmd7X3vmqK5yDn
	 ZgdSCTwSj1LLF0ktxLxoTVr2y01HN+KDk0+AJXKxEN8le5iNIeabkrEDB/pKvuwhjy
	 Upu5jFD0b+Lu/abCwJ5Uz8M1eXUiFQAFarFUwkXr6umH+HyDOoX0H3vqnlhz95v32S
	 2J/dylnBaQRlpMCpV0iL+we7tjJnPAJ1w99vHmikihO4QsxzepjUpWQRiXkT+rxV11
	 PvrzM8Y6P/m3w==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Mon,  5 Jan 2026 18:48:03 -0800
Message-ID: <20260106024803.834441-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010548-handrail-gallantly-8186@gregkh>
References: <2026010548-handrail-gallantly-8186@gregkh>
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
index 5531766ff09f..ceb8368b9a36 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -141,8 +141,14 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 	int i;
 
 	t = damon_new_target(42);
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
 	damon_add_target(ctx, t);
-- 
2.47.3


