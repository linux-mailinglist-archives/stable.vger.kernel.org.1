Return-Path: <stable+bounces-209961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19905D28CCE
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A87D9300816D
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57AE322B90;
	Thu, 15 Jan 2026 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DJB/VLUd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tCMODviO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378862BE7C3;
	Thu, 15 Jan 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513443; cv=none; b=IXbGwoN1Itbqlik4xiLBpgB7bC3WyziQyKJAIRDPcVeUGJmaruQgc/BJiah8/mzZfcWfURsz1ifMAbclV2XLajeB5jWkj//Xemk1c4nDetdrSb8tXykvxHjaew36OM/NM+f00I9nRCRMLN1wsOQ19uXbEENlI4aO/jAASLlS48s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513443; c=relaxed/simple;
	bh=lKu9rLAWJq4AhINx7Py2M7q0Q86grp5xMco5l1gaElQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WOT/c86VFTlrUj54eTLBctK4SVNFfjiZ3e4cTY2OzmQMHBC+DJUgWLvCLvumR+sagF4wqmkqlubLuVI44D1Ao0dGvVWXn8khmb+TzVryGUUTAzQrFMccGzN56yk/5dKlfXAB9SYhb/TIX2nvRLedJWidI2DWkRPNnb2wx8WRWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DJB/VLUd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tCMODviO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nql6VgCOPYqSEGHtSlW/hlvy+iC9VsuvjzGO9FVtO2w=;
	b=DJB/VLUdZdY0Ugc0fl9lpOJEdtkRITzzf/GkcbMb5qunHWgbyhElveO76dKuJ3aXMTwAOD
	C2Bnj+6YrT43B3Nxo73ggfQtc9nW60OE60KtZoLASQ4R/KVikJoSPhYlTbb8dNrw4D5E60
	rnZ1WEVNSo2VK7fBlGckGCcTFww1J5XCWO/lhtwctSxsvvTci9cLP5LQNPH642cwbAxcuc
	ebJxEes2xkVjM7bvOc7BthXoo7voRNhJopP5f6eSTQ1DgPEnJUzr0S3wMJIFApjfwwgrB2
	3SUYcGeDOVH8saV30IHATWoKZinDGTxLgyPXB6LtESAQdvTrZJjOg+g8Uc2I2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nql6VgCOPYqSEGHtSlW/hlvy+iC9VsuvjzGO9FVtO2w=;
	b=tCMODviOguMSimDMvgMWOQ+rphD/NCKjRAXhE6CGvHWgj4mfefcpiryLyCDrvcYMyn9/45
	epKNcyxECsTKD5CA==
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
Message-ID: <176851343815.510.11862479025865189952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     69044a0cbfdcc6e788c8a1f8e050d108038461d6
Gitweb:        https://git.kernel.org/tip/69044a0cbfdcc6e788c8a1f8e050d108038=
461d6
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 11 Jan 2026 16:00:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:28 +01:00

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

Fixes: 1b028f784e8c ("86/mm: Introduce mmap_compat_base() for 32-bit mmap()")
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
index 7be8e36..2dbd2e0 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1823,3 +1823,27 @@ bool is_uprobe_at_func_entry(struct pt_regs *regs)
=20
 	return false;
 }
+
+#ifdef CONFIG_IA32_EMULATION
+unsigned long __weak arch_uprobe_get_xol_area(void)
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

