Return-Path: <stable+bounces-100379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0619E9EACA5
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC3188C034
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333D1DC980;
	Tue, 10 Dec 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z139/46J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFE78F54
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823551; cv=none; b=W01LEQzcKzCKm0zbOVed6p2D48WJjAFDUc5Oeue/m35RUHwXPBDLxOpIBjPFmGtWeHoyAW8yCAaGXIQEaqWAElo3ekn4emua0Yl+HLK6qyGQr613u2zZuIE0tnU/59X/L5+VppvNjfBKs3kePffnlrokXvGT9u/9sjhMaB8ZmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823551; c=relaxed/simple;
	bh=HQZUBB6ShpSfMfV2Ad3D8VIqgA6Gjky7V6CO4VNxuR4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tNMhCUNmD4/cSFnG0zGtX7VRnViPJYC53zG63vvaZnIb6sOK9U1gj+dnPB/26Z41ZZKUSH9rcPdh5HZ/6/7TFJR2Ssk8Fs0QeIjaQZqFuPzX+rP18ITUwoHdYaVz/t7m4VygmFv+g4QKye5h9GuwLu0wP4HFOblg1l0IUVKMTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z139/46J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493BDC4CEDD;
	Tue, 10 Dec 2024 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823551;
	bh=HQZUBB6ShpSfMfV2Ad3D8VIqgA6Gjky7V6CO4VNxuR4=;
	h=Subject:To:Cc:From:Date:From;
	b=z139/46JNZgx4OqQl2aVkDQYbEsecrADrwzqWt4wEP+jtOR4XAzzM3jHoWX0ncad2
	 In/A8BKMOCM9mF1cQZXiaRyQ3QJp1PdTHk5d7kiiVfQZuIGwv/ZnazjXBZZDhlD/Br
	 K2Wznou1T3Tu6uHpv6m2rRjLCffbD9lDlTsryzGA=
Subject: FAILED: patch "[PATCH] kasan: make report_lock a raw spinlock" failed to apply to 5.15-stable tree
To: jkangas@redhat.com,akpm@linux-foundation.org,andreyknvl@gmail.com,dvyukov@google.com,glider@google.com,ryabinin.a.a@gmail.com,stable@vger.kernel.org,vincenzo.frascino@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:38:10 +0100
Message-ID: <2024121010-gladiator-streak-993a@gregkh>
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
git cherry-pick -x e30a0361b8515d424c73c67de1a43e45a13b8ba2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121010-gladiator-streak-993a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


