Return-Path: <stable+bounces-210065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 160E5D3333E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B25A630A7D57
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891A338916;
	Fri, 16 Jan 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QHC3Brnq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/XKr/9s"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2E204F93;
	Fri, 16 Jan 2026 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577243; cv=none; b=Q26loyGHhjcYsmjrJh60zF8C5nrZ3Vdk4ZpZtSpaauNho7yLDBP1+P8HMhi3bT+4cxB9+rZC5igcIavvj7sLb5/RVmt5mNIdXgKPKSIeCJd63mBk+Kn8YuWhsF39ahcWyAvUAWPc69/xI2RXwV1QuIIrr/pGU9XBtSEf9j0HiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577243; c=relaxed/simple;
	bh=31c1DeC91a09f42O0ek5nz13JU6eqdoFA/urQj3o8VA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=crplepFIKOq6HaYReDmCBn9dzrDQySRO/KKkospVjgsFBg3Q/dJOtWJGjMHPNwFe+3zhTeNP1gALWBOCbCQc1rQ9vJOQ04ULCd/N3tTG4y2P0k7iMtpGAg3Fc5WgREvOHN2lf7EjH2QDtgrEqagCs4JUeDqI3PXVkQh+bKcS1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QHC3Brnq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/XKr/9s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 15:27:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768577240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtY0sgtQTI5Q94iRvgcX3+6Tm2+EaMbLFKclrW6HaKE=;
	b=QHC3BrnqvuGF0DGOJSoq4/+9sZy6yq6g7cIq6ZSNCffhuAQNkOcWsm9xgPTEd1PQu1sGqk
	r9eNn4m1NvMykQNVxHms3dsrrYH4heBCTlK67WvlJ6blTMvbKlyTvDgvxrvaxFm8RIY6yA
	qJHN3sAWzHA3Jbwff3zDIpKrDpX6ISWkKGqCeroXqou5svJnA+/lHavEdCpxrkJa841ixa
	Fy+t7tmh273UuZXD705ogPK+EB7keyfGbD0V7b/RjBpgPMBfCsjDXtMXxUjpNroNdggBRU
	aBmy9n9gCRjNgoU3fiXuZDMqy04T1MnMVX9AyixQPsIgvuxmJ6BfH1a6p+xJ4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768577240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtY0sgtQTI5Q94iRvgcX3+6Tm2+EaMbLFKclrW6HaKE=;
	b=N/XKr/9sK18bbtAV9n7uT2locscTiaK5ztWj5AO9fT0Rhkwf5Y6T1rjVNFxG4HFsvs/ZCb
	sez971OE2cvbegDA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] x86/uprobes: Fix XOL allocation failure for 32-bit tasks
Cc: Paulo Andrade <pandrade@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aWO7Fdxn39piQnxu@redhat.com>
References: <aWO7Fdxn39piQnxu@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176857723836.510.4242271338759775529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d55c571e4333fac71826e8db3b9753fadfbead6a
Gitweb:        https://git.kernel.org/tip/d55c571e4333fac71826e8db3b9753fadfb=
ead6a
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 11 Jan 2026 16:00:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jan 2026 16:23:54 +01:00

x86/uprobes: Fix XOL allocation failure for 32-bit tasks

This script

	#!/usr/bin/bash

	echo 0 > /proc/sys/kernel/randomize_va_space

	echo 'void main(void) {}' > TEST.c

	# -fcf-protection to ensure that the 1st endbr32 insn can't be emulated
	gcc -m32 -fcf-protection=3Dbranch TEST.c -o test

	bpftrace -e 'uprobe:./test:main {}' -c ./test

"hangs", the probed ./test task enters an endless loop.

The problem is that with randomize_va_space =3D=3D 0
get_unmapped_area(TASK_SIZE - PAGE_SIZE) called by xol_add_vma() can not
just return the "addr =3D=3D TASK_SIZE - PAGE_SIZE" hint, this addr is used
by the stack vma.

arch_get_unmapped_area_topdown() doesn't take TIF_ADDR32 into account and
in_32bit_syscall() is false, this leads to info.high_limit > TASK_SIZE.
vm_unmapped_area() happily returns the high address > TASK_SIZE and then
get_unmapped_area() returns -ENOMEM after the "if (addr > TASK_SIZE - len)"
check.

handle_swbp() doesn't report this failure (probably it should) and silently
restarts the probed insn. Endless loop.

I think that the right fix should change the x86 get_unmapped_area() paths
to rely on TIF_ADDR32 rather than in_32bit_syscall(). Note also that if
CONFIG_X86_X32_ABI=3Dy, in_x32_syscall() falsely returns true in this case
because ->orig_ax =3D -1.

But we need a simple fix for -stable, so this patch just sets TS_COMPAT if
the probed task is 32-bit to make in_ia32_syscall() true.

Fixes: 1b028f784e8c ("x86/mm: Introduce mmap_compat_base() for 32-bit mmap()")
Reported-by: Paulo Andrade <pandrade@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/aV5uldEvV7pb4RA8@redhat.com/
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/aWO7Fdxn39piQnxu@redhat.com
---
 arch/x86/kernel/uprobes.c | 24 ++++++++++++++++++++++++
 include/linux/uprobes.h   |  1 +
 kernel/events/uprobes.c   | 10 +++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 7be8e36..619dddf 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1823,3 +1823,27 @@ bool is_uprobe_at_func_entry(struct pt_regs *regs)
=20
 	return false;
 }
+
+#ifdef CONFIG_IA32_EMULATION
+unsigned long arch_uprobe_get_xol_area(void)
+{
+	struct thread_info *ti =3D current_thread_info();
+	unsigned long vaddr;
+
+	/*
+	 * HACK: we are not in a syscall, but x86 get_unmapped_area() paths
+	 * ignore TIF_ADDR32 and rely on in_32bit_syscall() to calculate
+	 * vm_unmapped_area_info.high_limit.
+	 *
+	 * The #ifdef above doesn't cover the CONFIG_X86_X32_ABI=3Dy case,
+	 * but in this case in_32bit_syscall() -> in_x32_syscall() always
+	 * (falsely) returns true because ->orig_ax =3D=3D -1.
+	 */
+	if (test_thread_flag(TIF_ADDR32))
+		ti->status |=3D TS_COMPAT;
+	vaddr =3D get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE, PAGE_SIZE, 0, 0);
+	ti->status &=3D ~TS_COMPAT;
+
+	return vaddr;
+}
+#endif
diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index ee3d36e..f548fea 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -242,6 +242,7 @@ extern void arch_uprobe_clear_state(struct mm_struct *mm);
 extern void arch_uprobe_init_state(struct mm_struct *mm);
 extern void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vad=
dr);
 extern void arch_uprobe_optimize(struct arch_uprobe *auprobe, unsigned long =
vaddr);
+extern unsigned long arch_uprobe_get_xol_area(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a7d7d83..dfbce02 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1694,6 +1694,12 @@ static const struct vm_special_mapping xol_mapping =3D=
 {
 	.mremap =3D xol_mremap,
 };
=20
+unsigned long __weak arch_uprobe_get_xol_area(void)
+{
+	/* Try to map as high as possible, this is only a hint. */
+	return get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE, PAGE_SIZE, 0, 0);
+}
+
 /* Slot allocation for XOL */
 static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 {
@@ -1709,9 +1715,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol=
_area *area)
 	}
=20
 	if (!area->vaddr) {
-		/* Try to map as high as possible, this is only a hint. */
-		area->vaddr =3D get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
-						PAGE_SIZE, 0, 0);
+		area->vaddr =3D arch_uprobe_get_xol_area();
 		if (IS_ERR_VALUE(area->vaddr)) {
 			ret =3D area->vaddr;
 			goto fail;

