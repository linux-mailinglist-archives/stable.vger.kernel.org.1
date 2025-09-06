Return-Path: <stable+bounces-177991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FDFB476C4
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B7CA019AA
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 19:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B665B285060;
	Sat,  6 Sep 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oOWpFmTf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B525A326
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757185705; cv=none; b=KlZJdzIp1/gXF3ksWlI0QNUTtOzQRssdFEuKbvewsqmiYXLCKN0X0WgikKb26AOhIWl8NKzxoTssMN8nWY/LNO7iN5pQPe05A/t/IdwEvem3FZBm1UDq81hSYFcSGdvNdIsx2vpSxxIsO/LCRz24YhQUntqjVVk5vTmHDDI6EsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757185705; c=relaxed/simple;
	bh=anxZV+X+OyMo+DTq6vnyFhZ5eYcaq1quPR8+sBUbQAE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A1XI89utbRrO5F/KxfDbRxaNCE+b72OKkDxSUNrC1d9+zMQoIhuF3/iQJB313bBSc3/1i1Ce3qpUWJDuzGf5U5+qQ7BHMOohBTStNEo4Y3ryRdQsVxIVaovNT0u5fDpYoFmh1wWGIGtCqWp86zR7/zRhYQlHvzCivQgVSpzY610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oOWpFmTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9688C4CEE7;
	Sat,  6 Sep 2025 19:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757185705;
	bh=anxZV+X+OyMo+DTq6vnyFhZ5eYcaq1quPR8+sBUbQAE=;
	h=Subject:To:Cc:From:Date:From;
	b=oOWpFmTflzu4Dk6umAeUg8G7iEnhQk8L5oDlrUbMzrKEOK8XzEo21Qbb7RKMd37Da
	 79y+vFlxrU1bobDZFvh7/3nI6JPdETRb2Gblv36Elj6gkEGN23NgF+/cGneMErQgHw
	 nq7GWHvyK7Ht9r7drZRqiDuKPvkgK55ehVRNTmhY=
Subject: FAILED: patch "[PATCH] kunit: kasan_test: disable fortify string checker on" failed to apply to 5.15-stable tree
To: yeoreum.yun@arm.com,akpm@linux-foundation.org,andreyknvl@gmail.com,dvyukov@google.com,glider@google.com,ryabinin.a.a@gmail.com,stable@vger.kernel.org,vincenzo.frascino@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 Sep 2025 21:08:17 +0200
Message-ID: <2025090617-define-clerical-52ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7a19afee6fb39df63ddea7ce78976d8c521178c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025090617-define-clerical-52ff@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a19afee6fb39df63ddea7ce78976d8c521178c6 Mon Sep 17 00:00:00 2001
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 1 Aug 2025 13:02:36 +0100
Subject: [PATCH] kunit: kasan_test: disable fortify string checker on
 kasan_strings() test

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

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index e0968acc03aa..f4b17984b627 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1578,9 +1578,11 @@ static void kasan_strings(struct kunit *test)
 
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
+	OPTIMIZER_HIDE_VAR(ptr);
 
 	src = kmalloc(KASAN_GRANULE_SIZE, GFP_KERNEL | __GFP_ZERO);
 	strscpy(src, "f0cacc1a0000000", KASAN_GRANULE_SIZE);
+	OPTIMIZER_HIDE_VAR(src);
 
 	/*
 	 * Make sure that strscpy() does not trigger KASAN if it overreads into


