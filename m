Return-Path: <stable+bounces-99983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92B9E77F0
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 19:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E99E18833F2
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1789B1F3D35;
	Fri,  6 Dec 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+hQjPCJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6753256E;
	Fri,  6 Dec 2024 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509000; cv=none; b=RzVYAapDE5luyXKw/kNgISeh/viQZzwY6fe/6kzM8eAxpgz75j6/j+yA9TXYjSiaEyOUE9P+d8GjVlfwhlSz3HIUBle5lkFV5sC4Tz7vcsbcvuKYoMbVjkVEj17XUCjXTkFHiEiEqSTgSi1OORoV7Z1yRW4R1qQNTO33ME28eE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509000; c=relaxed/simple;
	bh=5pUCOmO26Nd3bpuwEx9+UO+/wAuFr0DwltCsV9SFGcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AIrSKAm0Vk3VzZLPCVcwTAFnG7rq9MpqmjC2wRghtVLYFO7rh/uu3ZZ0SBggQ3HpYbZnimx8YiZrrT30KTnab2KjD/IaS2SsOHXLvWWiabg7lmrtCTV22V0vYcvNRqe3C64b9RYFD5tmH1feyVeRRRUjys9+ZZ+gVIB8qi/g73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+hQjPCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE47C4CED1;
	Fri,  6 Dec 2024 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733509000;
	bh=5pUCOmO26Nd3bpuwEx9+UO+/wAuFr0DwltCsV9SFGcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i+hQjPCJwTLMGDNySEgbFPriLF74/Q25ftZO6x9pTNMs6Ox/Sx4VcbFjkDT/7Tlyc
	 UCfD1IUXUuPP2/Znd3BeClZn26SHD/8v5VnN4cnZSZcF4TvFdYksuNKSwcJjeUfYUd
	 4MjrNH6hO6eHIDWRnUcjIDgoiJsYa9aRttWLTLqq13nQ1EqYtFhejv/adni0i35F8O
	 8RKeikTmCZ9aU85RjQzXusscGadatipw1kjlrxJy7wFC4Jgd4YnEWrwH4+U8eqObQI
	 6QT9n2t4rkqPTtshrMcCTr1SvTqFQhF7Wi7gHUMTXckE41zRWCy3urmQwJ6+wRjEkq
	 OYwVhQaIAFfsw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	kernel test robot <lkp@intel.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.15.y 1/2] mm/damon/vaddr-test: split a test function having >1024 bytes frame size
Date: Fri,  6 Dec 2024 10:16:19 -0800
Message-Id: <20241206181620.91603-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206181620.91603-1-sj@kernel.org>
References: <2024120625-recycling-till-0cca@gregkh>
 <20241206181620.91603-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some configuration[1], 'damon_test_split_evenly()' kunit test
function has >1024 bytes frame size, so below build warning is
triggered:

      CC      mm/damon/vaddr.o
    In file included from mm/damon/vaddr.c:672:
    mm/damon/vaddr-test.h: In function 'damon_test_split_evenly':
    mm/damon/vaddr-test.h:309:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
      309 | }
          | ^

This commit fixes the warning by separating the common logic in the
function.

[1] https://lore.kernel.org/linux-mm/202111182146.OV3C4uGr-lkp@intel.com/

Link: https://lkml.kernel.org/r/20211201150440.1088-6-sj@kernel.org
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SeongJae Park <sj@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 044cd9750fe010170f5dc812e4824d98f5ea928c)
---
 mm/damon/vaddr-test.h | 77 ++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 1f5c13257dba..95ec362cdc37 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -252,59 +252,62 @@ static void damon_test_apply_three_regions4(struct kunit *test)
 			new_three_regions, expected, ARRAY_SIZE(expected));
 }
 
-static void damon_test_split_evenly(struct kunit *test)
+static void damon_test_split_evenly_fail(struct kunit *test,
+		unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
-	struct damon_ctx *c = damon_new_ctx();
-	struct damon_target *t;
-	struct damon_region *r;
-	unsigned long i;
-
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
-			-EINVAL);
-
-	t = damon_new_target(42);
-	r = damon_new_region(0, 100);
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 0), -EINVAL);
+	struct damon_target *t = damon_new_target(42);
+	struct damon_region *r = damon_new_region(start, end);
 
 	damon_add_region(r, t);
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 10), 0);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 10u);
+	KUNIT_EXPECT_EQ(test,
+			damon_va_evenly_split_region(t, r, nr_pieces), -EINVAL);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1u);
 
-	i = 0;
 	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->ar.start, i++ * 10);
-		KUNIT_EXPECT_EQ(test, r->ar.end, i * 10);
+		KUNIT_EXPECT_EQ(test, r->ar.start, start);
+		KUNIT_EXPECT_EQ(test, r->ar.end, end);
 	}
+
 	damon_free_target(t);
+}
+
+static void damon_test_split_evenly_succ(struct kunit *test,
+	unsigned long start, unsigned long end, unsigned int nr_pieces)
+{
+	struct damon_target *t = damon_new_target(42);
+	struct damon_region *r = damon_new_region(start, end);
+	unsigned long expected_width = (end - start) / nr_pieces;
+	unsigned long i = 0;
 
-	t = damon_new_target(42);
-	r = damon_new_region(5, 59);
 	damon_add_region(r, t);
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 5), 0);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
+	KUNIT_EXPECT_EQ(test,
+			damon_va_evenly_split_region(t, r, nr_pieces), 0);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_pieces);
 
-	i = 0;
 	damon_for_each_region(r, t) {
-		if (i == 4)
+		if (i == nr_pieces - 1)
 			break;
-		KUNIT_EXPECT_EQ(test, r->ar.start, 5 + 10 * i++);
-		KUNIT_EXPECT_EQ(test, r->ar.end, 5 + 10 * i);
+		KUNIT_EXPECT_EQ(test,
+				r->ar.start, start + i++ * expected_width);
+		KUNIT_EXPECT_EQ(test, r->ar.end, start + i * expected_width);
 	}
-	KUNIT_EXPECT_EQ(test, r->ar.start, 5 + 10 * i);
-	KUNIT_EXPECT_EQ(test, r->ar.end, 59ul);
+	KUNIT_EXPECT_EQ(test, r->ar.start, start + i * expected_width);
+	KUNIT_EXPECT_EQ(test, r->ar.end, end);
 	damon_free_target(t);
+}
 
-	t = damon_new_target(42);
-	r = damon_new_region(5, 6);
-	damon_add_region(r, t);
-	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(t, r, 2), -EINVAL);
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 1u);
+static void damon_test_split_evenly(struct kunit *test)
+{
+	struct damon_ctx *c = damon_new_ctx();
+
+	KUNIT_EXPECT_EQ(test, damon_va_evenly_split_region(NULL, NULL, 5),
+			-EINVAL);
+
+	damon_test_split_evenly_fail(test, 0, 100, 0);
+	damon_test_split_evenly_succ(test, 0, 100, 10);
+	damon_test_split_evenly_succ(test, 5, 59, 5);
+	damon_test_split_evenly_fail(test, 5, 6, 2);
 
-	damon_for_each_region(r, t) {
-		KUNIT_EXPECT_EQ(test, r->ar.start, 5ul);
-		KUNIT_EXPECT_EQ(test, r->ar.end, 6ul);
-	}
-	damon_free_target(t);
 	damon_destroy_ctx(c);
 }
 
-- 
2.39.5


