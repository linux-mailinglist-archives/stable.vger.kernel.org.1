Return-Path: <stable+bounces-121220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3342DA5493E
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 12:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD84189122A
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FBE2080C8;
	Thu,  6 Mar 2025 11:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZZUwjdE1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qBfNQ4Bp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232E20ADC9;
	Thu,  6 Mar 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260607; cv=none; b=o/RA4Jz9iYWt2UzbbOBUHNWwAyqKADjtkmPP14QO9QZieQzQ1l0K7WakYr85X4lqEyqfMvBCFOJ4+0GC0zxqvRvdxIcFVU7iwhFsfcxyAJXfB6MuNAp+1TlHqsaSA4HW4XfMI8I+u/pBTQnXYNKj/A2bMnYQv0Wo4oh/aPv0VaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260607; c=relaxed/simple;
	bh=OpJrKTIFzZ5pckjudi3Qin4EgJkRHJdkbCYsaO+8+/E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L2vOMEzW30Ns+WzijtUN6lpvUVGC5CkLLzm1CsggXtpDFVKy9REsvSIlotdUGZCb4C2CilhfhkUc85X308NzjAQpBr6WdFtIWAFBwgDJCuPnuiDtlYCzjXmSncXa2PzBtgSKZdjlDLgSJpfqmviSM9fiq4dA92ca30pbVWrRQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZZUwjdE1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qBfNQ4Bp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 11:30:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741260604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NdCogl1ODaHR/OAf9QpmrH+l5xcgxjNSNuiCkD2Hn8=;
	b=ZZUwjdE137yKZD+ExuxH6v4eTf56vE7QF4nmnNP8QQJQ3MtkvgOF4HJ93hENavhTmIHdPK
	GsEY8KDgvZvZxnknZXz68+SROSzlPtzQjMRftLw+9g5Xobf9YrE+1kYCh41TpIm2ri2GMU
	qDqEly49yyTyhrA6bGrL7cfeXQ51CE/d+eB7luJTPje/ZUQT/h96Nsi+0ecCnwDbmTks9k
	gaBaDNDzwFRL0M/foPXBJ9OyQmv8J02rJwjkQNO5Wh1+yqkHe1gQs7Xj9wd57lOygBL5Re
	ZKV83vhShqcNZY4ZBHq6g7E7KMMqsLybVtA/2An/gmZuxIuQMF0rX0/pILVADw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741260604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NdCogl1ODaHR/OAf9QpmrH+l5xcgxjNSNuiCkD2Hn8=;
	b=qBfNQ4Bp5xJmWqiW+NECXOZqYZPqE1vH5opXz1Ove/f77XPCa/pK3zuw8qLYjLa5XYbmoW
	Am03WtcDc6+cpLAA==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes/x86: Harden uretprobe syscall trampoline check
Cc: Jann Horn <jannh@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Kees Cook <kees@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212220433.3624297-1-jolsa@kernel.org>
References: <20250212220433.3624297-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174126060240.14745.15365015848455636391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fa6192adc32f4fdfe5b74edd5b210e12afd6ecc0
Gitweb:        https://git.kernel.org/tip/fa6192adc32f4fdfe5b74edd5b210e12afd6ecc0
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 12 Feb 2025 23:04:33 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 12:22:45 +01:00

uprobes/x86: Harden uretprobe syscall trampoline check

Jann reported a possible issue when trampoline_check_ip returns
address near the bottom of the address space that is allowed to
call into the syscall if uretprobes are not set up:

   https://lore.kernel.org/bpf/202502081235.5A6F352985@keescook/T/#m9d416df341b8fbc11737dacbcd29f0054413cbbf

Though the mmap minimum address restrictions will typically prevent
creating mappings there, let's make sure uretprobe syscall checks
for that.

Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250212220433.3624297-1-jolsa@kernel.org
---
 arch/x86/kernel/uprobes.c | 14 +++++++++-----
 include/linux/uprobes.h   |  2 ++
 kernel/events/uprobes.c   |  2 +-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5..9194695 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -357,19 +357,23 @@ void *arch_uprobe_trampoline(unsigned long *psize)
 	return &insn;
 }
 
-static unsigned long trampoline_check_ip(void)
+static unsigned long trampoline_check_ip(unsigned long tramp)
 {
-	unsigned long tramp = uprobe_get_trampoline_vaddr();
-
 	return tramp + (uretprobe_syscall_check - uretprobe_trampoline_entry);
 }
 
 SYSCALL_DEFINE0(uretprobe)
 {
 	struct pt_regs *regs = task_pt_regs(current);
-	unsigned long err, ip, sp, r11_cx_ax[3];
+	unsigned long err, ip, sp, r11_cx_ax[3], tramp;
+
+	/* If there's no trampoline, we are called from wrong place. */
+	tramp = uprobe_get_trampoline_vaddr();
+	if (unlikely(tramp == UPROBE_NO_TRAMPOLINE_VADDR))
+		goto sigill;
 
-	if (regs->ip != trampoline_check_ip())
+	/* Make sure the ip matches the only allowed sys_uretprobe caller. */
+	if (unlikely(regs->ip != trampoline_check_ip(tramp)))
 		goto sigill;
 
 	err = copy_from_user(r11_cx_ax, (void __user *)regs->sp, sizeof(r11_cx_ax));
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index a40efdd..2e46b69 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -39,6 +39,8 @@ struct page;
 
 #define MAX_URETPROBE_DEPTH		64
 
+#define UPROBE_NO_TRAMPOLINE_VADDR	(~0UL)
+
 struct uprobe_consumer {
 	/*
 	 * handler() can return UPROBE_HANDLER_REMOVE to signal the need to
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 921ad91..70c84b9 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2169,8 +2169,8 @@ void uprobe_copy_process(struct task_struct *t, unsigned long flags)
  */
 unsigned long uprobe_get_trampoline_vaddr(void)
 {
+	unsigned long trampoline_vaddr = UPROBE_NO_TRAMPOLINE_VADDR;
 	struct xol_area *area;
-	unsigned long trampoline_vaddr = -1;
 
 	/* Pairs with xol_add_vma() smp_store_release() */
 	area = READ_ONCE(current->mm->uprobes_state.xol_area); /* ^^^ */

