Return-Path: <stable+bounces-204980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B6CF6317
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0D71303CF67
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372A277CBF;
	Tue,  6 Jan 2026 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3OdCLoq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C290A1D5160;
	Tue,  6 Jan 2026 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661788; cv=none; b=Al6PWiyyzkFT20qA/XaH+UysYnZ94nplgSJP4zkgxZ/VUShyUzXhlhWRNf6//XvHDaTbTQeRTbMHKajsPy1T5munkR8607BoneIfwD/A4lnP8csaZfk8HBX6hTQwJ4V8sLfWi2B+UKMICi1hkHXMlGglLJOXUU5idADVmTw+Shw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661788; c=relaxed/simple;
	bh=kDg76bwpXNCBSJ6km9VSzTYrOBfw90zsahBJ2MgaxIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4ai4flpcF9px0h/FjFyEfQbgwg0meXX5dWPNkFCUEM1oIhHqjobchGyAbfXiLo5gRTKh3jQkJWmSHDlTqhXog62Tly0agS+Rb2DwvY/axndPN59nCI+g8N75UGEFmgzCEnl6MohdWcoq8tDV22XL9Jt+m/rK8ukepaJZYwqkMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3OdCLoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289F5C116D0;
	Tue,  6 Jan 2026 01:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767661788;
	bh=kDg76bwpXNCBSJ6km9VSzTYrOBfw90zsahBJ2MgaxIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3OdCLoqks0RV234aU6GmqTYzGC+E3fYzgY5ZLWWF20fxljOdJxDLPORjHstmsAto
	 LYHYAlZ5KnJp1pwd4lgqFOQIa3+NURQjEYlWmpozufUWKVX8EtM+NCCW5Ls9FifyvD
	 V01CgGzqTDCEmZk/VZ8bQRlOUVpu88mJ0vIcKPsRnavpQvtvgXrYhyCeEmuQN9wyH9
	 uVzAm2IXxtvdl9GaLPzCaCywSXsqJnJMAlDN4ibPDT/13ueNlO17mHT77Ek305NNfo
	 Nmnd5p+2nEo5SiO7BLvRTg334+SWKJNXCFoewwKYDUHGlRxtHcpr+sEDvQCYh+MMJR
	 g2cKPQ9l39TMg==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: handle alloc failures on dasmon_test_merge_regions_of()
Date: Mon,  5 Jan 2026 17:09:39 -0800
Message-ID: <20260106010939.226680-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010500-pamperer-electable-b002@gregkh>
References: <2026010500-pamperer-electable-b002@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_merge_regions_of() is assuming all dynamic memory allocation in
it will succeed.  Those are indeed likely in the real use cases since
those allocations are too small to fail, but theoretically those could
fail.  In the case, inappropriate memory access can happen.  Fix it by
appropriately cleanup pre-allocated memory and skip the execution of the
remaining tests in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-8-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 0998d2757218771c59d5ca59ccf13d1542a38f17)
---
 mm/damon/core-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 6cc8b245586d..7ebc76da95b9 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -193,8 +193,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	int i;
 
 	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	for (i = 0; i < ARRAY_SIZE(sa); i++) {
 		r = damon_new_region(sa[i], ea[i]);
+		if (!r) {
+			damon_free_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
 		r->nr_accesses = nrs[i];
 		damon_add_region(r, t);
 	}
-- 
2.47.3


