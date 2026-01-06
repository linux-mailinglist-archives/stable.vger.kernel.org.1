Return-Path: <stable+bounces-205008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EAFCF6681
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43C1301765C
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E723183B;
	Tue,  6 Jan 2026 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXSpU2+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB602135D7
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665038; cv=none; b=Qgh9fl+0G/JSsK39mYAw2mfVN4JsfyxaWnWdUwRC/YQdZnOUrsAc9UtBgiPzTbgf+1RHSRDbYjmJ04QSyiaQ8i3c0lzMAjdpkj84QGrWrMJjbrXJ6RZ8D5ksrjpY8hlOMvWRmLLnq8uEoCZG6ujNWCsJAk+Ex4kQrqs9DONpWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665038; c=relaxed/simple;
	bh=TpIRhkp4UFifXQAB8MXJ62xT/UNOnEGHN139WLLFr5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXGuf7hPY+nGtohb4rEAG2fjOmYWykFZjfWt2ceKvVgrs7dtCjluo19SYA0NPPrMV5uXlYQ6Db7fAgdzMgfmUGFdPjZ75hhpsKdqApDsQtX537JcKtV8jeh7GQffHrPmVV24WNfW2YHfNGwxQ6jirZBjPtrBXv/3jwWMG8GKYxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXSpU2+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F2BC116D0;
	Tue,  6 Jan 2026 02:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767665038;
	bh=TpIRhkp4UFifXQAB8MXJ62xT/UNOnEGHN139WLLFr5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXSpU2+GxfqqkAv6DQLTmX7MGP8aRn+32/n8QpJVKcBpQYFdcojFE6akTiijc+8pC
	 9qHj1boB8XFOQOIH1d9W4SMexJRFabJ76P0xnQgcNSjeRnQaA/ucZms1n4H4KYtRUK
	 4js45yeWxTX5KnT3i6e1f1bd9Vw0rEy+uYc5uD9aVxXQ5KAvmA4aE+PaEiFyWGcXS3
	 oOtv4hp8F3Vmg2VRq5iuC4fUTr4uVKlWdF7yOEH77gOPVkyVi2sYpFTlK1rUO2lZFk
	 gP4xewZXTecOYpMt7j01y4mBPzAbpVJXXFtPWgKWVdu0ic+C0scc2O0E5PLQQQ+/eo
	 BsxbPzzk+vZ1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/damon/tests/vaddr-kunit: handle alloc failures on damon_do_test_apply_three_regions()
Date: Mon,  5 Jan 2026 21:03:56 -0500
Message-ID: <20260106020356.2904257-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010548-handrail-gallantly-8186@gregkh>
References: <2026010548-handrail-gallantly-8186@gregkh>
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
[ adapted damon_new_target() call to damon_new_target(42) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/vaddr-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 5531766ff09f..4ffdb9e57d98 100644
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
+			damon_destroy_target(t, NULL);
+			kunit_skip(test, "region alloc fail");
+		}
 		damon_add_region(r, t);
 	}
 	damon_add_target(ctx, t);
-- 
2.51.0


