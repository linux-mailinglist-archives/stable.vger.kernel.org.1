Return-Path: <stable+bounces-178017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC6B478B7
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 04:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF7B1B2183C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 02:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3C71ABED9;
	Sun,  7 Sep 2025 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxLh08xb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E127707
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 02:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757212171; cv=none; b=JOsJleM1kVqJiIQmzqTbAUxOu5kFfP1CjGG2lAZBaTaEiy7zxnVTG4gx0wXCmX7HaV9KGH04FJS0c/k+U0gLBWXAfK3fQ4kirPw7H2qTUb00OfamWgZENZIkiwHaLL1m15Kmt2eK54VZtyWLydL8MLPdQY6VSP6wpSXhT0v/t4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757212171; c=relaxed/simple;
	bh=m5Ne66XKzshnEtNIRdi1WUU79N2nFiCbSprR+6vvlNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/iVi+FBGVdYnWjqHJD+4wdKPKjupkgnKGBPnfWJsI3/k848ZxrTyVfO5GHbew+8ZHMbXv4mR/yYAgxhb3/vERBRiP9akNL0fu7avFKZvQSB1lnsKjzf7fVoHdHQK3wRi28ywnqv4jBbZ6bLfi9r+pzFSOOxgFumP6Z6tyZiTJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxLh08xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23A9C4CEE7;
	Sun,  7 Sep 2025 02:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757212170;
	bh=m5Ne66XKzshnEtNIRdi1WUU79N2nFiCbSprR+6vvlNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxLh08xb79RV9SBvXQjqzuq+byA7FAMogaT6PtHCN46acqP7pDsx96lRzvZ9EzVVU
	 cI1e/PG3OETVv7yy1WxOF32ZpDzUaSMRFsf+AunzzXZk78GRS3UjxPGO9I7UTNpYFo
	 ege10xZ3A91cnVmf/Ij983R0wuJjVfL4wLljGPPlLGzOtgPA0h18SNiQxzP/BA1G6I
	 aZfefGDv2dSNmpxK5BgDfV88A+D8AdpXoRyRNMdjPfohyaTP5flHgfcLzppYGt71pi
	 nM/wCgB2yrXfaL5i3M75kqCUhIdxHvKGK77BDNiMuGyUx7Y3E8O1XbPC+YWCtzo5B3
	 CitsdEQHhOjWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y] kunit: kasan_test: disable fortify string checker on kasan_strings() test
Date: Sat,  6 Sep 2025 22:29:28 -0400
Message-ID: <20250907022928.412807-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025090612-washhouse-palpitate-525c@gregkh>
References: <2025090612-washhouse-palpitate-525c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yeoreum Yun <yeoreum.yun@arm.com>

Similar to commit 09c6304e38e4 ("kasan: test: fix compatibility with
FORTIFY_SOURCE") the kernel is panicing in kasan_string().

This is due to the `src` and `ptr` not being hidden from the optimizer
which would disable the runtime fortify string checker.

Call trace:
  __fortify_panic+0x10/0x20 (P)
  kasan_strings+0x980/0x9b0
  kunit_try_run_case+0x68/0x190
  kunit_generic_run_threadfn_adapter+0x34/0x68
  kthread+0x1c4/0x228
  ret_from_fork+0x10/0x20
 Code: d503233f a9bf7bfd 910003fd 9424b243 (d4210000)
 ---[ end trace 0000000000000000 ]---
 note: kunit_try_catch[128] exited with irqs disabled
 note: kunit_try_catch[128] exited with preempt_count 1
     # kasan_strings: try faulted: last
** replaying previous printk message **
     # kasan_strings: try faulted: last line seen mm/kasan/kasan_test_c.c:1600
     # kasan_strings: internal error occurred preventing test case from running: -4

Link: https://lkml.kernel.org/r/20250801120236.2962642-1-yeoreum.yun@arm.com
Fixes: 73228c7ecc5e ("KASAN: port KASAN Tests to KUnit")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
[ One less test in older trees ]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kasan/kasan_test_c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index d8fb281e439d5..d4ac26ad1d3e5 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1548,6 +1548,7 @@ static void kasan_strings(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
 
 	kfree(ptr);
 
-- 
2.51.0


