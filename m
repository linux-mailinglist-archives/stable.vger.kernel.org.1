Return-Path: <stable+bounces-118598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4349A3F777
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAB1860DF7
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6C21127B;
	Fri, 21 Feb 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="urlMX0uf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMQ96ddv"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE31210F7E;
	Fri, 21 Feb 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148667; cv=none; b=oOC6cGHqkaoI0jjfRu/QN/Vgoaa/iGwczLwjLw02Fj83U6qeQORecyQDr0iC3i4leC9bf0nL0f1OxbYDOxYNR7qmI4737q2A8LV69qJSipZCuHIctQvrakObtWNIjUMKX69ySFrvacsRY0x7xVz428EnpLFEs+BuZKSfNhUGu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148667; c=relaxed/simple;
	bh=bVcKOp7IeRqWfL3Zyw6j5EDAjnBwDLss90iFubdNemQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LxW4khjpfG0mAfNgTiIBX0srIncPzQJemtplB4bDKptLklyFKLOve6RK873G2IdlNWV3dJEreouIMQV/MZz8hHbvEmFeEYkETAd8ehMo3p+i8MXjUQUyZb96lOLR6pPYHOWXH4qV0O3nBX4MTKSeH3BDXuxHkgZi/dkJNMHQxug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=urlMX0uf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMQ96ddv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 14:37:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740148663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mL+e+11iRXnpGGfTcb2wVZDRgYJuRx6g93sQArL6ZGw=;
	b=urlMX0ufVcXh3LwtJFSCfRJdrHQhNUh+ldV0mKY2lkeGTnNYr6FpX55rKGCyHhGfr5hQpk
	Oc1sUcfdotUtoGl9ei+NSgf+dwWIQWW3VHLUtyyvP8ENDKSuxaLVg1WP3Ns3KHs3wc2DlD
	Ho4U8nXwF0onl+ohuf1JfytTcq+bw4YrqAJhQ6/cdotEG9e4wNTF1GhGs8I1mV6ezNrxYN
	0D1Ve8bGis3BlKKOSiu2TcV5RwpNgcnClqf0E7R01CXgRX01/c3kbiL+lt5xoYC6/o5Vqm
	hXMbOsr0mn/k3uYhWMupE2pZ6k1aEGTd7Or1T+iJh0AGAJpM1PqSCW2emuQguQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740148663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mL+e+11iRXnpGGfTcb2wVZDRgYJuRx6g93sQArL6ZGw=;
	b=sMQ96ddvoepdC22D4UFox3ZaoFsj5t6jzYF33tcNC2ZDxMWzT2xwd+BWoBu3duHYM9a/gd
	X7Iu10BD0aQS+bDg==
From: "tip-bot2 for Guilherme G. Piccoli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86/tsc: Always save/restore TSC sched_clock() on
 suspend/resume
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250215210314.351480-1-gpiccoli@igalia.com>
References: <20250215210314.351480-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014866289.10177.10974658062988825500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d90c9de9de2f1712df56de6e4f7d6982d358cabe
Gitweb:        https://git.kernel.org/tip/d90c9de9de2f1712df56de6e4f7d6982d358cabe
Author:        Guilherme G. Piccoli <gpiccoli@igalia.com>
AuthorDate:    Sat, 15 Feb 2025 17:58:16 -03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 15:27:38 +01:00

x86/tsc: Always save/restore TSC sched_clock() on suspend/resume

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
---
 arch/x86/kernel/tsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 34dec0b..88e5a4e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -959,7 +959,7 @@ static unsigned long long cyc2ns_suspend;
 
 void tsc_save_sched_clock_state(void)
 {
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -979,7 +979,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!sched_clock_stable())
+	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
 		return;
 
 	local_irq_save(flags);

