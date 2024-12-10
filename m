Return-Path: <stable+bounces-100378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0875A9EAC9B
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C0B294D7E
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7299922331C;
	Tue, 10 Dec 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qax24rrm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3270278F2D
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823549; cv=none; b=BA+IacfunRZsDjzjVklDAJSZ14o5FFwiW1MkN8kPobO+31KHuAMtqr8SucoQiJ8G+2FEAxUZSlVeXpnVGh2xTU+bAgBtboUMac2mX6hQSDVH51buxzxplGBgxCMV3+R0g0dIv+A3ZDhv4hnhFEk0JkhPT+GH4I4Jtl16smJJcBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823549; c=relaxed/simple;
	bh=6Y2hEAcz6j8B/p2YeEn356fm3AKNNxt3G9ispCKbJVk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZenTmQqYSwzsPRj20dCxwAGR1L4mnW8ZNshr7lpcm/lVKdfI+WcyVXuuxsm2GHk0FzCzThVMal/2keE7qut3Kel1WpL3lM+bQaBsmbNmA/tKi/3zFH1w7RHugdDqGcEJ3J1TmtRXsuizSKZ1gkfLOFEZhIy3xtOD0X1Tv3+j920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qax24rrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF402C4CED6;
	Tue, 10 Dec 2024 09:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823549;
	bh=6Y2hEAcz6j8B/p2YeEn356fm3AKNNxt3G9ispCKbJVk=;
	h=Subject:To:Cc:From:Date:From;
	b=Qax24rrmzHU3keGeyeorqoHJQT/mK5KU6yoD42DNVctvcQTy5IVP59VMXmoL4ftfZ
	 0mdP5LZni3E0G4j2dBeBk+gLY0UPxNcBOVwAKJOAfJMADNiDEbN8N3DWEwXOK/2Lhu
	 pBCLfWSy/arCvDphVQabIktd/AcUcPMe9wYmuzfM=
Subject: FAILED: patch "[PATCH] kasan: make report_lock a raw spinlock" failed to apply to 6.1-stable tree
To: jkangas@redhat.com,akpm@linux-foundation.org,andreyknvl@gmail.com,dvyukov@google.com,glider@google.com,ryabinin.a.a@gmail.com,stable@vger.kernel.org,vincenzo.frascino@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:38:09 +0100
Message-ID: <2024121008-yelling-swear-a95b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e30a0361b8515d424c73c67de1a43e45a13b8ba2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121008-yelling-swear-a95b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e30a0361b8515d424c73c67de1a43e45a13b8ba2 Mon Sep 17 00:00:00 2001
From: Jared Kangas <jkangas@redhat.com>
Date: Tue, 19 Nov 2024 13:02:34 -0800
Subject: [PATCH] kasan: make report_lock a raw spinlock

If PREEMPT_RT is enabled, report_lock is a sleeping spinlock and must not
be locked when IRQs are disabled.  However, KASAN reports may be triggered
in such contexts.  For example:

        char *s = kzalloc(1, GFP_KERNEL);
        kfree(s);
        local_irq_disable();
        char c = *s;  /* KASAN report here leads to spin_lock() */
        local_irq_enable();

Make report_spinlock a raw spinlock to prevent rescheduling when
PREEMPT_RT is enabled.

Link: https://lkml.kernel.org/r/20241119210234.1602529-1-jkangas@redhat.com
Fixes: 342a93247e08 ("locking/spinlock: Provide RT variant header: <linux/spinlock_rt.h>")
Signed-off-by: Jared Kangas <jkangas@redhat.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 50fb19ad4388..3fe77a360f1c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -201,7 +201,7 @@ static inline void fail_non_kasan_kunit_test(void) { }
 
 #endif /* CONFIG_KUNIT */
 
-static DEFINE_SPINLOCK(report_lock);
+static DEFINE_RAW_SPINLOCK(report_lock);
 
 static void start_report(unsigned long *flags, bool sync)
 {
@@ -212,7 +212,7 @@ static void start_report(unsigned long *flags, bool sync)
 	lockdep_off();
 	/* Make sure we don't end up in loop. */
 	report_suppress_start();
-	spin_lock_irqsave(&report_lock, *flags);
+	raw_spin_lock_irqsave(&report_lock, *flags);
 	pr_err("==================================================================\n");
 }
 
@@ -222,7 +222,7 @@ static void end_report(unsigned long *flags, const void *addr, bool is_write)
 		trace_error_report_end(ERROR_DETECTOR_KASAN,
 				       (unsigned long)addr);
 	pr_err("==================================================================\n");
-	spin_unlock_irqrestore(&report_lock, *flags);
+	raw_spin_unlock_irqrestore(&report_lock, *flags);
 	if (!test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
 		check_panic_on_warn("KASAN");
 	switch (kasan_arg_fault) {


