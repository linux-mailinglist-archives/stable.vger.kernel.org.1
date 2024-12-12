Return-Path: <stable+bounces-102486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A99EF318
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE401897432
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FAE242AB4;
	Thu, 12 Dec 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+YMSIjF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA9F242AAD;
	Thu, 12 Dec 2024 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021404; cv=none; b=GPM9xdqj3Fqw4yAnXvYSPJAyaBt2xV4BT+fPgZbt+X0gzSGAF7jOQ5acXiFN/2GiqybFzOy5evB/IoMTEN9vwNTogWUueYojJXqutSeRT3KhuhpQ/lEZmIdTooBDjR/7hKAoNodR0/nnH/X5L03RX+ecmBqEDC9ZBAj09LI8b0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021404; c=relaxed/simple;
	bh=IQwED83XV+d1H/AUB3tZC4DsSChVHmdtNq0xjzYqnHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcO1jFxXRys2iIOtUwDRV2a0xvg/d00DMWCCjT1l0sYfBWVDdc8vwzbOMBnUBrBddnPNM4+j0sl+jOf1n8Xms9JVoteUB0cnpbdMo18KmKffA7sZGXGueC/7MQrBGpW9OMYKNuL0mGpk4+AcnocizOuTe1ofSTvZsn5lSwOLq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L+YMSIjF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F73C4CECE;
	Thu, 12 Dec 2024 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734021404;
	bh=IQwED83XV+d1H/AUB3tZC4DsSChVHmdtNq0xjzYqnHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+YMSIjF5NQc2uiSaQpa9pQuk0PJh6J0xPSJ7O+8KNsJmzKhB/Vz3N9l2re75hGTr
	 5uKb5tNwoYUtVKWutXguxhYqfkDXt7611nPfeHRfsGM5WrKEz0Q1UEks7tTcuKRHj9
	 Ow1asxfTxcIRIHF7hwNC10d/RpjfhFeYTB82U55s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Konovalov <andreyknvl@google.com>,
	Weizhao Ouyang <ouyangweizhao@zeku.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Peter Collingbourne <pcc@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 729/772] kasan: suppress recursive reports for HW_TAGS
Date: Thu, 12 Dec 2024 16:01:14 +0100
Message-ID: <20241212144420.022501682@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@google.com>

[ Upstream commit c6a690e0c978bda8106e7a489c13323f90b087d0 ]

KASAN suppresses reports for bad accesses done by the KASAN reporting
code.  The reporting code might access poisoned memory for reporting
purposes.

Software KASAN modes do this by suppressing reports during reporting via
current->kasan_depth, the same way they suppress reports during accesses
to poisoned slab metadata.

Hardware Tag-Based KASAN does not use current->kasan_depth, and instead
resets pointer tags for accesses to poisoned memory done by the reporting
code.

Despite that, a recursive report can still happen:

1. On hardware with faulty MTE support. This was observed by Weizhao
   Ouyang on a faulty hardware that caused memory tags to randomly change
   from time to time.

2. Theoretically, due to a previous MTE-undetected memory corruption.

A recursive report can happen via:

1. Accessing a pointer with a non-reset tag in the reporting code, e.g.
   slab->slab_cache, which is what Weizhao Ouyang observed.

2. Theoretically, via external non-annotated routines, e.g. stackdepot.

To resolve this issue, resetting tags for all of the pointers in the
reporting code and all the used external routines would be impractical.

Instead, disable tag checking done by the CPU for the duration of KASAN
reporting for Hardware Tag-Based KASAN.

Without this fix, Hardware Tag-Based KASAN reporting code might deadlock.

[andreyknvl@google.com: disable preemption instead of migration, fix comment typo]
  Link: https://lkml.kernel.org/r/d14417c8bc5eea7589e99381203432f15c0f9138.1680114854.git.andreyknvl@google.com
Link: https://lkml.kernel.org/r/59f433e00f7fa985e8bf9f7caf78574db16b67ab.1678491668.git.andreyknvl@google.com
Fixes: 2e903b914797 ("kasan, arm64: implement HW_TAGS runtime")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reported-by: Weizhao Ouyang <ouyangweizhao@zeku.com>
Reviewed-by: Marco Elver <elver@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Evgenii Stepanov <eugenis@google.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: e30a0361b851 ("kasan: make report_lock a raw spinlock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/kasan/report.c | 59 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5d9ae80df4954..821cd12e8c8a7 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -73,10 +73,18 @@ static int __init kasan_set_multi_shot(char *str)
 __setup("kasan_multi_shot", kasan_set_multi_shot);
 
 /*
- * Used to suppress reports within kasan_disable/enable_current() critical
- * sections, which are used for marking accesses to slab metadata.
+ * This function is used to check whether KASAN reports are suppressed for
+ * software KASAN modes via kasan_disable/enable_current() critical sections.
+ *
+ * This is done to avoid:
+ * 1. False-positive reports when accessing slab metadata,
+ * 2. Deadlocking when poisoned memory is accessed by the reporting code.
+ *
+ * Hardware Tag-Based KASAN instead relies on:
+ * For #1: Resetting tags via kasan_reset_tag().
+ * For #2: Suppression of tag checks via CPU, see report_suppress_start/end().
  */
-static bool report_suppressed(void)
+static bool report_suppressed_sw(void)
 {
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (current->kasan_depth)
@@ -85,6 +93,30 @@ static bool report_suppressed(void)
 	return false;
 }
 
+static void report_suppress_start(void)
+{
+#ifdef CONFIG_KASAN_HW_TAGS
+	/*
+	 * Disable preemption for the duration of printing a KASAN report, as
+	 * hw_suppress_tag_checks_start() disables checks on the current CPU.
+	 */
+	preempt_disable();
+	hw_suppress_tag_checks_start();
+#else
+	kasan_disable_current();
+#endif
+}
+
+static void report_suppress_stop(void)
+{
+#ifdef CONFIG_KASAN_HW_TAGS
+	hw_suppress_tag_checks_stop();
+	preempt_enable();
+#else
+	kasan_enable_current();
+#endif
+}
+
 /*
  * Used to avoid reporting more than one KASAN bug unless kasan_multi_shot
  * is enabled. Note that KASAN tests effectively enable kasan_multi_shot
@@ -152,7 +184,7 @@ static void start_report(unsigned long *flags, bool sync)
 	/* Do not allow LOCKDEP mangling KASAN reports. */
 	lockdep_off();
 	/* Make sure we don't end up in loop. */
-	kasan_disable_current();
+	report_suppress_start();
 	spin_lock_irqsave(&report_lock, *flags);
 	pr_err("==================================================================\n");
 }
@@ -170,7 +202,7 @@ static void end_report(unsigned long *flags, void *addr)
 		panic("kasan.fault=panic set ...\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	lockdep_on();
-	kasan_enable_current();
+	report_suppress_stop();
 }
 
 static void print_error_description(struct kasan_report_info *info)
@@ -439,9 +471,13 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
 	struct kasan_report_info info;
 
 	/*
-	 * Do not check report_suppressed(), as an invalid-free cannot be
-	 * caused by accessing slab metadata and thus should not be
-	 * suppressed by kasan_disable/enable_current() critical sections.
+	 * Do not check report_suppressed_sw(), as an invalid-free cannot be
+	 * caused by accessing poisoned memory and thus should not be suppressed
+	 * by kasan_disable/enable_current() critical sections.
+	 *
+	 * Note that for Hardware Tag-Based KASAN, kasan_report_invalid_free()
+	 * is triggered by explicit tag checks and not by the ones performed by
+	 * the CPU. Thus, reporting invalid-free is not suppressed as well.
 	 */
 	if (unlikely(!report_enabled()))
 		return;
@@ -476,7 +512,7 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	unsigned long irq_flags;
 	struct kasan_report_info info;
 
-	if (unlikely(report_suppressed()) || unlikely(!report_enabled())) {
+	if (unlikely(report_suppressed_sw()) || unlikely(!report_enabled())) {
 		ret = false;
 		goto out;
 	}
@@ -508,8 +544,9 @@ void kasan_report_async(void)
 	unsigned long flags;
 
 	/*
-	 * Do not check report_suppressed(), as kasan_disable/enable_current()
-	 * critical sections do not affect Hardware Tag-Based KASAN.
+	 * Do not check report_suppressed_sw(), as
+	 * kasan_disable/enable_current() critical sections do not affect
+	 * Hardware Tag-Based KASAN.
 	 */
 	if (unlikely(!report_enabled()))
 		return;
-- 
2.43.0




