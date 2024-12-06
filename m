Return-Path: <stable+bounces-98996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C09E6BBF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9390D1887BC7
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126D1FCD1B;
	Fri,  6 Dec 2024 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ftax5Gq6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/glm0KeH"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDEC1FCD0E;
	Fri,  6 Dec 2024 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480202; cv=none; b=NFc+W7CvFz3PNBiCCi7D6g476FOLdXBReni3iD3Xw3rYICyIq06KXgRklKXlYQbG4o4qlMhP8uJT2/zGYEPNPEFzgktejh5Ky4p3PwveBybxB+UxciCiRwGEFmo4KQh3ZVkaXIUUlbTnKxffiRVRpVKgkvS6Xlo9fyDs/BYN/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480202; c=relaxed/simple;
	bh=K+zGqI9q21uTonb7URHR/nkqCUTjh2uYwUvs/im7Yts=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sOhZ0r64pHTtsItYA6jKxy0eDac7s9ObNEmgB+vFlG3lHWAQo7CtxEA4CUEshlx28Fhfi2B5Mz+D+ioR9teoMOMVDaIzayQC/Ri+yK7U+Y0VEBiV8m0EyAR3w/qYjYRC6jqDMKYvmKVR6Q9p6Q3oskfApvMuNJhHOzoSOUaYbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ftax5Gq6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/glm0KeH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ys0FZid5GFWslTVF5iEhFlxma/b+XlUurBJ3vxqSlIM=;
	b=Ftax5Gq6y1mEjVnUc43XRVvLxgcLlPiKM/ap0vA+y0QZyvFLVQ3x0YhXVUB0qZTZ7LqEEK
	EL0fNvhxY84VJWqlBONndjxZcRY0h4RCkBA6eAERw8fCXO5dYE7p9lpg01nYQY469vW2on
	4oFgFnFO1uY+OAD1U8V+AyEDRvMUmGa7oQ93i/AHUDB94nZxMJWJlDQ0098nkoxg5sguGU
	P+JsCJgsRWq8ABD9T9xKDLAYjTF7fsl7F393vNWf5pZ0MTiZ54rIddP0lSW+ETsft8x6we
	KKG+NazUl13q8Fx8bUHwmcYPtaPUaJPse+xwbg4tpoYb6Uq6qbvFhZnPux9GIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ys0FZid5GFWslTVF5iEhFlxma/b+XlUurBJ3vxqSlIM=;
	b=/glm0KeHikOkzyg6ONCnt/Mwod8DajvRUQZn07BWcQAfQhA3m+k92jrFkRJrApd40qwb5Q
	TLyTyxaaSB/SPMCg==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kexec: Restore GDT on return from
 ::preserve_context kexec
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241205153343.3275139-2-dwmw2@infradead.org>
References: <20241205153343.3275139-2-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348019869.412.5731556015025742288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     07fa619f2a40c221ea27747a3323cabc59ab25eb
Gitweb:        https://git.kernel.org/tip/07fa619f2a40c221ea27747a3323cabc59ab25eb
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 05 Dec 2024 15:05:07 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:35:49 +01:00

x86/kexec: Restore GDT on return from ::preserve_context kexec

The restore_processor_state() function explicitly states that "the asm code
that gets us here will have restored a usable GDT". That wasn't true in the
case of returning from a ::preserve_context kexec. Make it so.

Without this, the kernel was depending on the called function to reload a
GDT which is appropriate for the kernel before returning.

Test program:

 #include <unistd.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <linux/kexec.h>
 #include <linux/reboot.h>
 #include <sys/reboot.h>
 #include <sys/syscall.h>

 int main (void)
 {
        struct kexec_segment segment = {};
	unsigned char purgatory[] = {
		0x66, 0xba, 0xf8, 0x03,	// mov $0x3f8, %dx
		0xb0, 0x42,		// mov $0x42, %al
		0xee,			// outb %al, (%dx)
		0xc3,			// ret
	};
	int ret;

	segment.buf = &purgatory;
	segment.bufsz = sizeof(purgatory);
	segment.mem = (void *)0x400000;
	segment.memsz = 0x1000;
	ret = syscall(__NR_kexec_load, 0x400000, 1, &segment, KEXEC_PRESERVE_CONTEXT);
	if (ret) {
		perror("kexec_load");
		exit(1);
	}

	ret = syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_KEXEC);
	if (ret) {
		perror("kexec reboot");
		exit(1);
	}
	printf("Success\n");
	return 0;
 }

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20241205153343.3275139-2-dwmw2@infradead.org
---
 arch/x86/kernel/relocate_kernel_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index e9e88c3..1236f25 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -242,6 +242,13 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movq	CR0(%r8), %r8
 	movq	%rax, %cr3
 	movq	%r8, %cr0
+
+#ifdef CONFIG_KEXEC_JUMP
+	/* Saved in save_processor_state. */
+	movq    $saved_context, %rax
+	lgdt    saved_context_gdt_desc(%rax)
+#endif
+
 	movq	%rbp, %rax
 
 	popf

