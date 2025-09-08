Return-Path: <stable+bounces-178878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54206B489D1
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 12:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE591887623
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 10:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C912EC543;
	Mon,  8 Sep 2025 10:15:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF09F510
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326543; cv=none; b=iBKzI8fP1JHMrD/QaPAthw9vG+GNbVd0FNWj/UQPRcArxM/RfGceJ+a06W3bsWTDEJQAgwwdqvUWJosb+S28EIiacib4qbf4cxETnoMAtxpu47aozYU6mzZS+oYeg60S1JtfKQtB7NZbz2YMD/FhGfCz2JyeEaiRGxwTk69Olc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326543; c=relaxed/simple;
	bh=ycVUpcXTYQR0Q2Vc8ivcDnIY4lH1zsQjabtXfnTzHLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Whlr5IZncor7IkpY3n5UNBdEqRcsxuEznwBn5nV9QBq6c20Ovg8eapVN4NRFANvupI0njHiWjwiuiiQBdHlsuWvhZNfxXyVzxjjAp2lTdA/No2JXPZdHDZPknTriOG5EnL/Sg4xQ4eUp6zKbL2o+R82C7K2FHVJVLjK6sngyezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94FBE1692;
	Mon,  8 Sep 2025 03:15:31 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 712333F66E;
	Mon,  8 Sep 2025 03:15:38 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] kunit: kasan_test: disable fortify string checker on kasan_strings() test
Date: Mon,  8 Sep 2025 11:15:20 +0100
Message-Id: <20250908101519.2184527-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025090614-jaws-chihuahua-c86c@gregkh>
References: <2025090614-jaws-chihuahua-c86c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7a19afee6fb39df63ddea7ce78976d8c521178c6)
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 mm/kasan/kasan_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index ecf9f5aa3520..9ca21d1e10ac 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1053,6 +1053,7 @@ static void kasan_strings(struct kunit *test)

 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);

 	kfree(ptr);

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


