Return-Path: <stable+bounces-129155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18097A7FE77
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B49189511F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167F26A091;
	Tue,  8 Apr 2025 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLwWQPqA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CD2135CD;
	Tue,  8 Apr 2025 11:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110264; cv=none; b=YDMC+nKqEH6JIcmkPiZhbXFiRoE4LwwbMbqbm5NtSscxauh99eYXw4qOIqD61/78iDszwPw9Jd3NyUpjnrb00f2jGFCaoONG09Xt/PA0YMCMZzntRee9neyNZa13+w5LehvUpMObIW4o6+cNehA4sVuK6r4EFOLEU5lt1XA/9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110264; c=relaxed/simple;
	bh=J4J6M4l/LcdJ3pncMNtbtwSaYHG58sZKdFmqXZ2jq1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxoaq1Tcf7BEUtgdGqJyZ+Qc6f5eve4NtkFB0H/mSzv9sHB5afN6mw+iCEsx26QylKDwB/wjuWwHs6kanqFYgUN4ankJ1aFWWyqXIDTKoKd+v+aN9DDdzjQORpMNZ8rnz3A8qttIvXldDnzOnfW9hPwxqSuChdNJ3cokdlHHTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLwWQPqA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C60C4CEE5;
	Tue,  8 Apr 2025 11:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110264;
	bh=J4J6M4l/LcdJ3pncMNtbtwSaYHG58sZKdFmqXZ2jq1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLwWQPqAGaZIdCw0i33H4dfn4BKCKNpSPb71jLC+YPvcnx6XhOJJ2Y+rSEi5CrOI/
	 YGrkQn2Av6U7qGwwd8ypFDeZlZ87Z88UVJTIiz++76+OnZ/kRzK6Jy740iDqIB1ztg
	 l7Q46R0R+Du5yT9A92Yg0afQYnE+KR0VOHXpx7J0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.10 213/227] x86/tsc: Always save/restore TSC sched_clock() on suspend/resume
Date: Tue,  8 Apr 2025 12:49:51 +0200
Message-ID: <20250408104826.701581199@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guilherme G. Piccoli <gpiccoli@igalia.com>

commit d90c9de9de2f1712df56de6e4f7d6982d358cabe upstream.

TSC could be reset in deep ACPI sleep states, even with invariant TSC.

That's the reason we have sched_clock() save/restore functions, to deal
with this situation. But what happens is that such functions are guarded
with a check for the stability of sched_clock - if not considered stable,
the save/restore routines aren't executed.

On top of that, we have a clear comment in native_sched_clock() saying
that *even* with TSC unstable, we continue using TSC for sched_clock due
to its speed.

In other words, if we have a situation of TSC getting detected as unstable,
it marks the sched_clock as unstable as well, so subsequent S3 sleep cycles
could bring bogus sched_clock values due to the lack of the save/restore
mechanism, causing warnings like this:

  [22.954918] ------------[ cut here ]------------
  [22.954923] Delta way too big! 18446743750843854390 ts=18446744072977390405 before=322133536015 after=322133536015 write stamp=18446744072977390405
  [22.954923] If you just came from a suspend/resume,
  [22.954923] please switch to the trace global clock:
  [22.954923]   echo global > /sys/kernel/tracing/trace_clock
  [22.954923] or add trace_clock=global to the kernel command line
  [22.954937] WARNING: CPU: 2 PID: 5728 at kernel/trace/ring_buffer.c:2890 rb_add_timestamp+0x193/0x1c0

Notice that the above was reproduced even with "trace_clock=global".

The fix for that is to _always_ save/restore the sched_clock on suspend
cycle _if TSC is used_ as sched_clock - only if we fallback to jiffies
the sched_clock_stable() check becomes relevant to save/restore the
sched_clock.

Debugged-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250215210314.351480-1-gpiccoli@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/tsc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -919,7 +919,7 @@ static unsigned long long cyc2ns_suspend
 
 void tsc_save_sched_clock_state(void)
 {
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -939,7 +939,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	local_irq_save(flags);



