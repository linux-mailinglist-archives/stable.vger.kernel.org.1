Return-Path: <stable+bounces-119862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EEFA48992
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 21:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2365C3B71B1
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 20:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD7B26FA68;
	Thu, 27 Feb 2025 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbJJKtPe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wBRbC0VT"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9A26A0BF;
	Thu, 27 Feb 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687038; cv=none; b=QTEucjNkqxUAhebRBMp2T0QOYuujouMdD9+0XDnDMn2D2cC2NWrvOmKNLl/AKiOg/G6L4ttkWq/cRWoX2+vzw7wkgQ8QyDMIcKO28aDl3Ak10+Vt1WtH5XFN2awozs10BH79QdH5zo/j5uV3hD6OBu5MAkVt91okNVOn3/efHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687038; c=relaxed/simple;
	bh=IIhv31tHm5nbcYXmnEy2mJ0BZBhMjxvw6fk3HPAcah4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CjSydbpsr3rXHllNVkiYjGY09U9zjj7ZLW6FfrW4M028t/nmUOCGqGliPHjWTDQ6Nct2u8y1pTQNGBfnSACqA0dzLEyGjawhki5IP+0ERvnqyMaOnfJPCmOWtZ5R/+F+4TUtrNsq0zfqnTcXoSoxCVrtZaBovyAJq9+IH5Wh0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbJJKtPe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wBRbC0VT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 20:10:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740687034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=t9+V8RePVjSPDpuIDIZ3RFGMA2w2/OJO32B8KrynrsE=;
	b=vbJJKtPejnkgi1nCm7HXD57VphdQ0yCu6hr+cyJDX58836LY8K1g0eh7506Te7bMoISWgv
	YJMTpcBDYo/bAVYnKFba4vIutGZ8HBS4HVusYdHoroPBB7HdtCvlFSxvXF1eL8MOC2gZEO
	rc6DGFka62twIlZy4oaw1YR7IRf4rC7uoRwCEH4LTAuuUujX/w07SgkP4UncAsyCziExc2
	7jrWwarGI0eIU8oUnPHFHfVfCSwg5meKRd3+pa8OsENpx5ZXzwKTm1XbyBpLXz2R0c9rw1
	/jixwxC5PYd1vCSezXaC0BawZwmR0HE1SujkadOqRcQlLhJ3wuChpva3VCn8Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740687034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=t9+V8RePVjSPDpuIDIZ3RFGMA2w2/OJO32B8KrynrsE=;
	b=wBRbC0VTLIdmwgHuIyatirgeO9kJCV70RPFyTY9XXLczsMvLQtn70MFrWBEBnmWs2qUlk9
	OruKBkbmMILkHWBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Prevent rescheduling when interrupts
 are disabled
Cc: David Woodhouse <dwmw@amazon.co.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174068702952.10177.18201689881316002263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     c092dc7d88c1214e109591790c9021a0f734677a
Gitweb:        https://git.kernel.org/tip/c092dc7d88c1214e109591790c9021a0f734677a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 16 Dec 2024 14:20:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 20:55:16 +01:00

sched/core: Prevent rescheduling when interrupts are disabled

David reported a warning observed while loop testing kexec jump:

  Interrupts enabled after irqrouter_resume+0x0/0x50
  WARNING: CPU: 0 PID: 560 at drivers/base/syscore.c:103 syscore_resume+0x18a/0x220
   kernel_kexec+0xf6/0x180
   __do_sys_reboot+0x206/0x250
   do_syscall_64+0x95/0x180

The corresponding interrupt flag trace:

  hardirqs last  enabled at (15573): [<ffffffffa8281b8e>] __up_console_sem+0x7e/0x90
  hardirqs last disabled at (15580): [<ffffffffa8281b73>] __up_console_sem+0x63/0x90

That means __up_console_sem() was invoked with interrupts enabled. Further
instrumentation revealed that in the interrupt disabled section of kexec
jump one of the syscore_suspend() callbacks woke up a task, which set the
NEED_RESCHED flag. A later callback in the resume path invoked
cond_resched() which in turn led to the invocation of the scheduler:

  __cond_resched+0x21/0x60
  down_timeout+0x18/0x60
  acpi_os_wait_semaphore+0x4c/0x80
  acpi_ut_acquire_mutex+0x3d/0x100
  acpi_ns_get_node+0x27/0x60
  acpi_ns_evaluate+0x1cb/0x2d0
  acpi_rs_set_srs_method_data+0x156/0x190
  acpi_pci_link_set+0x11c/0x290
  irqrouter_resume+0x54/0x60
  syscore_resume+0x6a/0x200
  kernel_kexec+0x145/0x1c0
  __do_sys_reboot+0xeb/0x240
  do_syscall_64+0x95/0x180

This is a long standing problem, which probably got more visible with
the recent printk changes. Something does a task wakeup and the
scheduler sets the NEED_RESCHED flag. cond_resched() sees it set and
invokes schedule() from a completely bogus context. The scheduler
enables interrupts after context switching, which causes the above
warning at the end.

Quite some of the code paths in syscore_suspend()/resume() can result in
triggering a wakeup with the exactly same consequences. They might not
have done so yet, but as they share a lot of code with normal operations
it's just a question of time.

The problem only affects the PREEMPT_NONE and PREEMPT_VOLUNTARY scheduling
models. Full preemption is not affected as cond_resched() is disabled and
the preemption check preemptible() takes the interrupt disabled flag into
account.

Cure the problem by adding a corresponding check into cond_resched().

Reported-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd91..6718990 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7285,7 +7285,7 @@ out_unlock:
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 int __sched __cond_resched(void)
 {
-	if (should_resched(0)) {
+	if (should_resched(0) && !irqs_disabled()) {
 		preempt_schedule_common();
 		return 1;
 	}

