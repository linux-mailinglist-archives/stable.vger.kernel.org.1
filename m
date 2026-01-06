Return-Path: <stable+bounces-205018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53832CF6773
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 03:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C5C03035320
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 02:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A13202C5C;
	Tue,  6 Jan 2026 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bn8ZF/at"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5FF13B284;
	Tue,  6 Jan 2026 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666451; cv=none; b=pO5NT3V33b7qkDDYcm3ZSaU8PGMQTwEGIsb6d42QNWzDTfobwI1Hijs+KZBCtB7DoSvceS5SbgcmZyk+AcK0qF8FAnvQn43CjIPqAxTdD6UMZsGQ6z8Hql5mYF6Av/MOHHzpXX0pIQvtKClY424wChkBGLw4uIls8YnLU+qbtBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666451; c=relaxed/simple;
	bh=Fg2amvf7jYsIVYZtImXqwSmgtUUhbqhI3het9cDc4js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCVicyDig2dyuJQ2uPOSkABNQQjh1CEq1wu9crLf0N6I2QkLLEtbLMVtuPEesp0UnHpIHnt9lSWB3xpesac+uxgs3rq1idzT/xoYThDYBQT3jflFebx8D0JitR3bASd467aKMhvE0OSglK3IuFuhWEFD+2s6N1kFJl8PO4kI/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bn8ZF/at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC61DC116D0;
	Tue,  6 Jan 2026 02:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767666450;
	bh=Fg2amvf7jYsIVYZtImXqwSmgtUUhbqhI3het9cDc4js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bn8ZF/atkkUq/fJxEFW6dFaYKDpC2QIvNbNTMxTAdRSsoOulNUaqXRxxAizZTbCbq
	 3iLbJMU6erJk/iCRokCDxw1TueKAHYxYdrQOP3EO+V0ojAbuJt2stkdbqSDKsm+c/S
	 mR40mcf8oEW5vjF7a1C621gBGxRoCI93skAB0JJIczZmbv8zezjQh9K0BnjI9wVcV9
	 a0NFGhjIoO4dqUbZvDfFdBrQwuAKK+weqH7A+4pEkUj7UoVUsQYCZHwHG3fFdlk9aH
	 iuGChzmdvj3GiucwKjfFLwxbR9rvaKXngvsp1/i+aP4oJyBWQbMabhYQxMFI1O50z5
	 MsVdjpN4I/ZXQ==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm/damon/tests/core-kunit: handle alloc failures on damon_test_merge_two()
Date: Mon,  5 Jan 2026 18:27:22 -0800
Message-ID: <20260106022722.707215-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026010519-cathedral-cuddle-c32b@gregkh>
References: <2026010519-cathedral-cuddle-c32b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_merge_two() is assuming all dynamic memory allocation in it
will succeed.  Those are indeed likely in the real use cases since those
allocations are too small to fail, but theoretically those could fail.  In
the case, inappropriate memory access can happen.  Fix it by appropriately
cleanup pre-allocated memory and skip the execution of the remaining tests
in the failure cases.

Link: https://lkml.kernel.org/r/20251101182021.74868-7-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: <stable@vger.kernel.org>	[5.15+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3d443dd29a1db7efa587a4bb0c06a497e13ca9e4)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 7008c3735e99..d22c86d5148b 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -144,10 +144,20 @@ static void damon_test_merge_two(struct kunit *test)
 	int i;
 
 	t = damon_new_target(42);
+	if (!t)
+		kunit_skip(test, "target alloc fail");
 	r = damon_new_region(0, 100);
+	if (!r) {
+		damon_free_target(t);
+		kunit_skip(test, "region alloc fail");
+	}
 	r->nr_accesses = 10;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
+	if (!r2) {
+		damon_free_target(t);
+		kunit_skip(test, "second region alloc fail");
+	}
 	r2->nr_accesses = 20;
 	damon_add_region(r2, t);
 
-- 
2.47.3


