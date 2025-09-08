Return-Path: <stable+bounces-178881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7BB48A0E
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC5F3B712A
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE32F3617;
	Mon,  8 Sep 2025 10:23:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C8136358
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757327019; cv=none; b=szKypcwfRnnrbHcVDyXHe84bvSN7xJvKjQUXBeZo8JnXQpdMTJ1dW9M/8R3ke5UWlfpEw8edzx2Pv0LVlWqWIg6leU1OvU+oB7deIbe3cz/2E4X3STdtSG1/aIP318xIlu1WFv2YCwSHkVOQ7CwHiR1b1tS8PU1le8zedyMADxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757327019; c=relaxed/simple;
	bh=OCjjoOWiS1Mht7qQGsB9juDWGtkaaeu0N/RI8kkbIzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uhIOnYlegEkNAT5CzyHiA/qEiSY6SYvPT6qGUjlfM1E9H/HEFc3sSlqz7+BzU+bGuNj5rlI0uP3Bju2K4XnG5mDWvBA4r4hgnTRI2Mk0aLcQgGoI7D+WtFLnG89blhrisRBT+sJxUbQZd1NusyBagVdOHWVoJ+sXLqIYiD7+YYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C503E1692;
	Mon,  8 Sep 2025 03:23:28 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A11BB3F66E;
	Mon,  8 Sep 2025 03:23:35 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: stable@vger.kernel.org
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Dmitriy Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] kunit: kasan_test: disable fortify string checker on kasan_strings() test
Date: Mon,  8 Sep 2025 11:23:24 +0100
Message-Id: <20250908102323.2187031-2-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025090617-define-clerical-52ff@gregkh>
References: <2025090617-define-clerical-52ff@gregkh>
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
 lib/test_kasan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index ffedc34714ba..70b567d03316 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -917,6 +917,7 @@ static void kasan_strings(struct kunit *test)

 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);

 	kfree(ptr);

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


