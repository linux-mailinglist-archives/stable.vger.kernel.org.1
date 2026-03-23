Return-Path: <stable+bounces-228742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LXWLbhTwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9F92F559D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64ACE3092FE6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133963ACEED;
	Mon, 23 Mar 2026 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n8nTsKDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD7387593;
	Mon, 23 Mar 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277000; cv=none; b=fLyjSJnIt6AjpNPfWYHOAWjvqYILE/ML8cr4fjIr1JUo0EOC/H5u2sIvQbXrjRjJcd4kOZ70yELJTyREPq+mEmPLNSc61A4VrbCMLPMxxLMJHmkY+05i6jjV48OJDAWSbbl2Fbmp8llJMhHbhpcng8u7dxtezyls6ENk6zzVT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277000; c=relaxed/simple;
	bh=tjz/uXlcYtFBZBGg1uf5qfwY2swGDdUB3UHvBp8sjSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBCh3XcyQAIOZ5flUrw/0hW++hgLDWTyRXfFwS8Zr3Ami0wWwHA0pNF1J0zWWF6etGFathADL8c0WTTn2OGLHB6gNsTuSqyU/Gb218/+U74S1XCk5CahkkD8X0U3473XCdQe9NsA4SXEsJw+Y3w4BYt2dUDnMy57mP7ao/OQpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n8nTsKDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60391C4CEF7;
	Mon, 23 Mar 2026 14:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277000;
	bh=tjz/uXlcYtFBZBGg1uf5qfwY2swGDdUB3UHvBp8sjSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8nTsKDedLH/PsU5t+jxraWbDW4mgXuygt/tLl9bWfC+RjUmVLxVtugsRqXUQRfpx
	 oXNZ4a1awdW5Hqry7AxLh79YcNfQImd9tas1nPzt7FBmMVDcFRdj50gHzBau9nZtdi
	 GnvAdooUw6e043fxAFuH8xLEGf58EeTp+wgmzq90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paulo Andrade <pandrade@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.12 282/460] x86/uprobes: Fix XOL allocation failure for 32-bit tasks
Date: Mon, 23 Mar 2026 14:44:38 +0100
Message-ID: <20260323134533.407124029@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228742-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5A9F92F559D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit d55c571e4333fac71826e8db3b9753fadfbead6a ]

This script

	#!/usr/bin/bash

	echo 0 > /proc/sys/kernel/randomize_va_space

	echo 'void main(void) {}' > TEST.c

	# -fcf-protection to ensure that the 1st endbr32 insn can't be emulated
	gcc -m32 -fcf-protection=branch TEST.c -o test

	bpftrace -e 'uprobe:./test:main {}' -c ./test

"hangs", the probed ./test task enters an endless loop.

The problem is that with randomize_va_space == 0
get_unmapped_area(TASK_SIZE - PAGE_SIZE) called by xol_add_vma() can not
just return the "addr == TASK_SIZE - PAGE_SIZE" hint, this addr is used
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
CONFIG_X86_X32_ABI=y, in_x32_syscall() falsely returns true in this case
because ->orig_ax = -1.

But we need a simple fix for -stable, so this patch just sets TS_COMPAT if
the probed task is 32-bit to make in_ia32_syscall() true.

Fixes: 1b028f784e8c ("x86/mm: Introduce mmap_compat_base() for 32-bit mmap()")
Reported-by: Paulo Andrade <pandrade@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/aV5uldEvV7pb4RA8@redhat.com/
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/aWO7Fdxn39piQnxu@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/uprobes.c |   24 ++++++++++++++++++++++++
 include/linux/uprobes.h   |    1 +
 kernel/events/uprobes.c   |   10 +++++++---
 3 files changed, 32 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1223,3 +1223,27 @@ bool arch_uretprobe_is_alive(struct retu
 	else
 		return regs->sp <= ret->stack;
 }
+
+#ifdef CONFIG_IA32_EMULATION
+unsigned long arch_uprobe_get_xol_area(void)
+{
+	struct thread_info *ti = current_thread_info();
+	unsigned long vaddr;
+
+	/*
+	 * HACK: we are not in a syscall, but x86 get_unmapped_area() paths
+	 * ignore TIF_ADDR32 and rely on in_32bit_syscall() to calculate
+	 * vm_unmapped_area_info.high_limit.
+	 *
+	 * The #ifdef above doesn't cover the CONFIG_X86_X32_ABI=y case,
+	 * but in this case in_32bit_syscall() -> in_x32_syscall() always
+	 * (falsely) returns true because ->orig_ax == -1.
+	 */
+	if (test_thread_flag(TIF_ADDR32))
+		ti->status |= TS_COMPAT;
+	vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE, PAGE_SIZE, 0, 0);
+	ti->status &= ~TS_COMPAT;
+
+	return vaddr;
+}
+#endif
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -146,6 +146,7 @@ extern void arch_uprobe_copy_ixol(struct
 extern void uprobe_handle_trampoline(struct pt_regs *regs);
 extern void *arch_uprobe_trampoline(unsigned long *psize);
 extern unsigned long uprobe_get_trampoline_vaddr(void);
+extern unsigned long arch_uprobe_get_xol_area(void);
 #else /* !CONFIG_UPROBES */
 struct uprobes_state {
 };
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1493,6 +1493,12 @@ static const struct vm_special_mapping x
 	.fault = xol_fault,
 };
 
+unsigned long __weak arch_uprobe_get_xol_area(void)
+{
+	/* Try to map as high as possible, this is only a hint. */
+	return get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE, PAGE_SIZE, 0, 0);
+}
+
 /* Slot allocation for XOL */
 static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 {
@@ -1508,9 +1514,7 @@ static int xol_add_vma(struct mm_struct
 	}
 
 	if (!area->vaddr) {
-		/* Try to map as high as possible, this is only a hint. */
-		area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
-						PAGE_SIZE, 0, 0);
+		area->vaddr = arch_uprobe_get_xol_area();
 		if (IS_ERR_VALUE(area->vaddr)) {
 			ret = area->vaddr;
 			goto fail;



