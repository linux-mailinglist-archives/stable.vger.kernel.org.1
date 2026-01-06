Return-Path: <stable+bounces-204991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A245BCF6585
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 02:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A8DC3031A14
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 01:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2681E1DFC;
	Tue,  6 Jan 2026 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVM0IzWr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2B1E0E14
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663425; cv=none; b=UuO7ao5scbptj8Q6J5CVXWCikCHFhBQeYiiORwm5hHsbYoDutr9R0nCbkpE7GrH3Msu/FI24UXFjkbEaswddLwQrMGOrmjn2iHeiK5PlZN+kLryI/L/0j7cENaYn58cfyCk1Qp+y53h7X15jYl6NaXAfkyB4Q85Qe+yh7QAnB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663425; c=relaxed/simple;
	bh=Xp14ePexeCOYdZ38QZb+leMXElT11MjMuqVFwO35QyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X//ZyCt2zLpRzu4utewizc0Fh86Qb93HUdV0uIr5/n8K7CRlZzBXNOlyk6OwPfLzG0elX7k7mMPBhkHtk3CfOQE7LwjZ2cThbfTAIA1c3HQXR5DxgOQABOHv4ywGhl4s6odB1JKzAgfBtmG2oR87fH/PwjBwatx2Y9CUBGPw3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVM0IzWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA84C116D0;
	Tue,  6 Jan 2026 01:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663424;
	bh=Xp14ePexeCOYdZ38QZb+leMXElT11MjMuqVFwO35QyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVM0IzWrOKRsd8qHIq5OjwCWKpM141Iv+po9dwn1Al0XV/vPHYy2wj4MkRs88A7oC
	 mPOvn0HE8w+yXis3MX8JGNt0d2MyXMaLiXzLppG583Th7stkvCi4UgAVnKeujShP3Z
	 yd92FpGiYhf0D167l32pdx9MMYTYu0wD5lRL3PmAxv04kUi14KCvPJKrbR/tLD1SmS
	 Ougo80ELll/QVTrGx37Hgo+pE8JFdPGEj4QZLgJgLUXRBsGtes4E5mSS4c9H6UtoXf
	 jdliAUakOeVUAuUvPlOPEr54NL4vtdSwJWb3Hj30NzyRNlvTs4ntcaribQ4ZGv4vME
	 EkofxqaygdJaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/damon/tests/core-kunit: handle allocation failures in damon_test_regions()
Date: Mon,  5 Jan 2026 20:37:01 -0500
Message-ID: <20260106013701.2888077-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010523-protozoan-pelt-bf14@gregkh>
References: <2026010523-protozoan-pelt-bf14@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

[ Upstream commit e16fdd4f754048d6e23c56bd8d920b71e41e3777 ]

damon_test_regions() is assuming all dynamic memory allocation in it will
succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-3-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core-test.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 3db9b7368756..48624cccf0fb 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -20,11 +20,17 @@ static void damon_test_regions(struct kunit *test)
 	struct damon_target *t;
 
 	r = damon_new_region(1, 2);
+	if (!r)
+		kunit_skip(test, "region alloc fail");
 	KUNIT_EXPECT_EQ(test, 1ul, r->ar.start);
 	KUNIT_EXPECT_EQ(test, 2ul, r->ar.end);
 	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
 
 	t = damon_new_target();
+	if (!t) {
+		damon_free_region(r);
+		kunit_skip(test, "target alloc fail");
+	}
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_add_region(r, t);
-- 
2.51.0


