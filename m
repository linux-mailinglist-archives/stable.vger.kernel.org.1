Return-Path: <stable+bounces-177989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788ECB476C3
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 21:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB225841FB
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 19:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB520285060;
	Sat,  6 Sep 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BGNVguWg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7920328504F
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757185699; cv=none; b=LG/EVY1K33BWjdJWPzIlYjZVpoGTXi+ib/+IWTdiqTrUlSMaRcen9KWveMEJnzPP5gHIo5flkpv3UitSIDgcejoqTZbHA2JPvs0P5t2tzolvSKmlT9Ikd0wopZeJ9My6eXcWNndL04CGfujTqzNFIY8VfCDV1gMDF73rfMW6XLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757185699; c=relaxed/simple;
	bh=42z8kyvXVlTK05M+jRYwPQk9VXT/bues5+o34YKVqgs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s4cqy1OHta3MYIrnoD5ZY6BzANFnd2ZoHIwWHcLnUsMyD90Zv/suwPpqPaoMwvwp3pbEPvSJQ06feqcqVmzAYAEKH3/CFBQyWbV+6giLZwNas8zZDTNE+5FIpk21lB9yj6+4Z1jK4lrGDQiJHkWuh2KYtwwT2EYyAK1AlS+TLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BGNVguWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96106C4CEE7;
	Sat,  6 Sep 2025 19:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757185699;
	bh=42z8kyvXVlTK05M+jRYwPQk9VXT/bues5+o34YKVqgs=;
	h=Subject:To:Cc:From:Date:From;
	b=BGNVguWgmGc3Axdn1EJ/24SVt0Lo8XBpTH86hQgUe2W2FSjxOeEZ8+76Aego4I7JS
	 eqm6oHCzsiNxvU0ZQIp/iSnmSLugAeTTf5OxmbSfPGPkizuEtTaRnmFeeB1zdcBQgG
	 sZ8tJkl2RB+mf1OzCTeRKFyv8pvHzxRi5hyr9enM=
Subject: FAILED: patch "[PATCH] kunit: kasan_test: disable fortify string checker on" failed to apply to 6.6-stable tree
To: yeoreum.yun@arm.com,akpm@linux-foundation.org,andreyknvl@gmail.com,dvyukov@google.com,glider@google.com,ryabinin.a.a@gmail.com,stable@vger.kernel.org,vincenzo.frascino@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 06 Sep 2025 21:08:14 +0200
Message-ID: <2025090614-jaws-chihuahua-c86c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7a19afee6fb39df63ddea7ce78976d8c521178c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025090614-jaws-chihuahua-c86c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


