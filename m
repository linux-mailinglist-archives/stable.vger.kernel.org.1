Return-Path: <stable+bounces-100397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CF9EAE01
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6621882208
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E83E23DEB9;
	Tue, 10 Dec 2024 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="twU63iej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26523DE8F
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826802; cv=none; b=mTLLzSB3GXJqL/0q1YUTqNxEoFnXj6hotcKObZLldrTRI9y+EcnTyLm0PWata0k3rg0EB7YEIymU6SvdKiC5wbgjzA+KteY65ueB19/PFKAPnaYTsdMlgpkFnrN7yq/Z5Gy2jEFaHe8kIEKif7Kuq1ejZTiWy13CjvRGzlmg0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826802; c=relaxed/simple;
	bh=IkF5ZQf4vl3er1xVvDO5RSfZ8JkLuO3kwNst8kKi3hY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e299kRSOdQ0Y/84fOVraeCdqmd4WE3lP4qI0E6oTemdzSpCmju2nZZqVXsxFf+7NI1Fmpx3xMXdL6jwIFtFFsX1OhH492l5jq567MYOMS9N9VApkuCi1qDwi1BWoTO5ydNJ8JNgMVinLBZ4dC4NkukZVdBAi3Ym7bh4id+H/UpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=twU63iej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D62C4CED6;
	Tue, 10 Dec 2024 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733826801;
	bh=IkF5ZQf4vl3er1xVvDO5RSfZ8JkLuO3kwNst8kKi3hY=;
	h=Subject:To:Cc:From:Date:From;
	b=twU63iejtGaP+tlyxGM1rGOxXnf6NIkKYTconKe+HPuxnWUXwLGPT7lxU+AukESsU
	 /xwyynGrqMjyr2yqw/W7N1qM9mipHeV8uvYlbNX81LFBxEmxqgGJDqD9EoIwRlh6+d
	 NzRc6nFEODU1bLIOxHhbtK/7Dj5iLgGle7arnqOg=
Subject: FAILED: patch "[PATCH] x86/kexec: Restore GDT on return from ::preserve_context" failed to apply to 6.1-stable tree
To: dwmw@amazon.co.uk,mingo@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 11:32:46 +0100
Message-ID: <2024121045-limelight-gainfully-7197@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 07fa619f2a40c221ea27747a3323cabc59ab25eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121045-limelight-gainfully-7197@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07fa619f2a40c221ea27747a3323cabc59ab25eb Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Thu, 5 Dec 2024 15:05:07 +0000
Subject: [PATCH] x86/kexec: Restore GDT on return from ::preserve_context
 kexec

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

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index e9e88c342f75..1236f25fc8d1 100644
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


