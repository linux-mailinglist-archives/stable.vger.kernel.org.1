Return-Path: <stable+bounces-119863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCDA489B2
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 21:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAB17A3B2E
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E5B26A0FD;
	Thu, 27 Feb 2025 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OP2kf5q0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbjwaJxd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF601A841B;
	Thu, 27 Feb 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687665; cv=none; b=Q6GkgkvCqzdHjm3cpWMit/yc1v/CWWkuT5YNyJvjZT8Kv52MJgsLNHTCno8mAb8+sLeHh3pCS6L+LaNxBF/UT58XYOo19uy2zr8qg3OjrA7B4BNzw+xQdSuMEojLP/bbVbHXBM9F1i+ZwOD8G+CAz57v6sYgX8pqVxwKO5PzONo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687665; c=relaxed/simple;
	bh=MtJTpeWFMmC6NvtMRah9y80RKfrLTo6oD9RpFUOhNG0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ItmObFcbgayCt7eJBr531UCuLrjviwqsk1DTK200FZe29H6dIYfunegfzzx80oBXr0O1zHAunoQwoC5eEF7yUgzr35fliELDmWyGLAixzE4L8eSYsrtOC4xaVX3BOfBr7dqPGAOhCO3IpDgLASOENwbj5Lf9ZAnsG+8pe8EH7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OP2kf5q0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbjwaJxd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 20:20:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740687659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=N5GBxKj2vN1YefaqwaNRI9BMN2xaspLBJCa8Im2OHcY=;
	b=OP2kf5q0IVeIGBHGUNHPGQaoASvAs2GP1C6inMAcWzKuUXpeaU7gBRXqaVy65B4Lx7tcOK
	+gi6unj2/buKh8hZJmQ6cp9sZQDZC0uKOpaaXWkU3v85bZfy81D+sKNkJCmOioVZlEQbcr
	VnlcXybIxNX1sMg3LlWpVVqsrE3gcTHbKcRXDQnHE04k5Wr2VLcWayzhEOsH6+wq74bjoh
	QgzaHKPBL0GNBONeD786XYKdtFhbNsGEQkYGNU8tRtapXVjZiZtFxzxqQKEH3FnqLXRNp0
	uzJnGMmfZncEFXSc+bwcNXqnxRb1TOa+SWQGcVw+u0VOYqSK1f2VIHz0eMv/2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740687659;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=N5GBxKj2vN1YefaqwaNRI9BMN2xaspLBJCa8Im2OHcY=;
	b=RbjwaJxdXIQx/ehHvdy0foLj6BocsnX5q679cM3v5zSwK7xNE+ujmDI4IWvY6dqpunzXKO
	onqB0mUADF5uj3CA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Prevent rescheduling when interrupts
 are disabled
Cc: David Woodhouse <dwmw@amazon.co.uk>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174068765743.10177.15505690433402162747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     82c387ef7568c0d96a918a5a78d9cad6256cfa15
Gitweb:        https://git.kernel.org/tip/82c387ef7568c0d96a918a5a78d9cad6256cfa15
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 16 Dec 2024 14:20:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 21:13:57 +01:00

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
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: David Woodhouse <dwmw@amazon.co.uk>
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

