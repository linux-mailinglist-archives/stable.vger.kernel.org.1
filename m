Return-Path: <stable+bounces-161770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC6B03164
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CAF18933F2
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 14:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC735280;
	Sun, 13 Jul 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KW5gw1jR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD558FC0B
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416158; cv=none; b=AytTQASgmJWLtNEgaMpKXc+lXqDtROd1JoBqypl0+pEzNtL1AZaHfCKf394vvvAASu1NGgE1Lab9uo5VfYv0fw5SzIHuStllX0i+HGQL+gkNV0+y0GI7Og4J/Q+Bj3hIcV7Hrv4nqiDi8cS8nRjarEDYkk3FhswKiPwHuyO7grM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416158; c=relaxed/simple;
	bh=LAjZJqKb1ycvaXOZ+Uj+5PS5RmtcRB4K8un2AUL6do8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L2ZjwE/qrAZf3CSEBVehoLV2dCJ/WX4O0Z0prnRZkN67PCIWNGss8Lx+/DFWAAExiagTEPu9cUAEwaQClVNMXLp/rLDU4V74B0DtgiBqJE/zgGPev6vZ8vJ0AnN6u8SQcW+RItRQklb08x+NgXxqH6hjnUufi9XVn66vRpgWQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KW5gw1jR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30A1C4CEE3;
	Sun, 13 Jul 2025 14:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752416158;
	bh=LAjZJqKb1ycvaXOZ+Uj+5PS5RmtcRB4K8un2AUL6do8=;
	h=Subject:To:Cc:From:Date:From;
	b=KW5gw1jRe+iyTwTPSJwXVwTsutMoWRK9rOhcQqrqnitnI2OZ7YFV2DMksiuGSfpWm
	 X1/dP0qX5kKoBkrit0mObePS2DCrQMY1959OQFUXtB7P/LMMa9eL//t1R2e+UIVz6j
	 dcE7F/l/7rS+wpe5waOPaRBltJwzJhAcGRIM3tI8=
Subject: FAILED: patch "[PATCH] kasan: remove kasan_find_vm_area() to prevent possible" failed to apply to 6.6-stable tree
To: yeoreum.yun@arm.com,akpm@linux-foundation.org,andreyknvl@gmail.com,bigeasy@linutronix.de,byungchul@sk.com,dvyukov@google.com,glider@google.com,rostedt@goodmis.org,ryabinin.a.a@gmail.com,stable@vger.kernel.org,vincenzo.frascino@arm.com,ysk@kzalloc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 13 Jul 2025 16:15:47 +0200
Message-ID: <2025071347-pregnant-dismount-40e9@gregkh>
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
git cherry-pick -x 6ee9b3d84775944fb8c8a447961cd01274ac671c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025071347-pregnant-dismount-40e9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ee9b3d84775944fb8c8a447961cd01274ac671c Mon Sep 17 00:00:00 2001
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Thu, 3 Jul 2025 19:10:18 +0100
Subject: [PATCH] kasan: remove kasan_find_vm_area() to prevent possible
 deadlock

find_vm_area() couldn't be called in atomic_context.  If find_vm_area() is
called to reports vm area information, kasan can trigger deadlock like:

CPU0                                CPU1
vmalloc();
 alloc_vmap_area();
  spin_lock(&vn->busy.lock)
                                    spin_lock_bh(&some_lock);
   <interrupt occurs>
   <in softirq>
   spin_lock(&some_lock);
                                    <access invalid address>
                                    kasan_report();
                                     print_report();
                                      print_address_description();
                                       kasan_find_vm_area();
                                        find_vm_area();
                                         spin_lock(&vn->busy.lock) // deadlock!

To prevent possible deadlock while kasan reports, remove kasan_find_vm_area().

Link: https://lkml.kernel.org/r/20250703181018.580833-1-yeoreum.yun@arm.com
Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reported-by: Yunseong Kim <ysk@kzalloc.com>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 8357e1a33699..b0877035491f 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -370,36 +370,6 @@ static inline bool init_task_stack_addr(const void *addr)
 			sizeof(init_thread_union.stack));
 }
 
-/*
- * This function is invoked with report_lock (a raw_spinlock) held. A
- * PREEMPT_RT kernel cannot call find_vm_area() as it will acquire a sleeping
- * rt_spinlock.
- *
- * For !RT kernel, the PROVE_RAW_LOCK_NESTING config option will print a
- * lockdep warning for this raw_spinlock -> spinlock dependency. This config
- * option is enabled by default to ensure better test coverage to expose this
- * kind of RT kernel problem. This lockdep splat, however, can be suppressed
- * by using DEFINE_WAIT_OVERRIDE_MAP() if it serves a useful purpose and the
- * invalid PREEMPT_RT case has been taken care of.
- */
-static inline struct vm_struct *kasan_find_vm_area(void *addr)
-{
-	static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
-	struct vm_struct *va;
-
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return NULL;
-
-	/*
-	 * Suppress lockdep warning and fetch vmalloc area of the
-	 * offending address.
-	 */
-	lock_map_acquire_try(&vmalloc_map);
-	va = find_vm_area(addr);
-	lock_map_release(&vmalloc_map);
-	return va;
-}
-
 static void print_address_description(void *addr, u8 tag,
 				      struct kasan_report_info *info)
 {
@@ -429,19 +399,8 @@ static void print_address_description(void *addr, u8 tag,
 	}
 
 	if (is_vmalloc_addr(addr)) {
-		struct vm_struct *va = kasan_find_vm_area(addr);
-
-		if (va) {
-			pr_err("The buggy address belongs to the virtual mapping at\n"
-			       " [%px, %px) created by:\n"
-			       " %pS\n",
-			       va->addr, va->addr + va->size, va->caller);
-			pr_err("\n");
-
-			page = vmalloc_to_page(addr);
-		} else {
-			pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
-		}
+		pr_err("The buggy address %px belongs to a vmalloc virtual mapping\n", addr);
+		page = vmalloc_to_page(addr);
 	}
 
 	if (page) {


