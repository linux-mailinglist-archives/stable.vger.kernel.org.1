Return-Path: <stable+bounces-186018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BABE352C
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 456354E9156
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB031196A;
	Thu, 16 Oct 2025 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="we57zu5L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098362DECD2
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617237; cv=none; b=nHGuAA6EQnIbrt+zF1Iq27R577kd6faa6S2w2MFuY91RPN6dNg8uIRfQUuTXz+XFqLP4WckJPZz7HDkIysoEDQdwpw/sen3dJa9B5xG7fuxnT+VMlBJjVo4qW6DYSMAxPRJsYViUWXKibUb22xFWC0WyDFfJyr3VcikpKnrwJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617237; c=relaxed/simple;
	bh=zgTeFPHgNn4/kM1WnPXJZeSTkbe5Kga1VOr8i0OTbN0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ezrXAV3CItbKo1KF2QWdelbJ7wo7xUt8iJkjHEE4iwSkVrzf2poGpq4t03DH/nfnwzhfEO3kWu3mr760klP7BV6180+XhcKsswsqgmubjIC2arrhcGPKxgbWy+V2diQ4kGyvpZkh+n5lt/oYyKysO3+vlsOx3f2+0bM8yAsPCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=we57zu5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BB6C4CEF1;
	Thu, 16 Oct 2025 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760617236;
	bh=zgTeFPHgNn4/kM1WnPXJZeSTkbe5Kga1VOr8i0OTbN0=;
	h=Subject:To:Cc:From:Date:From;
	b=we57zu5LbY1LLvUMGKk6Uie7wEGwdVn/vTLuFWZJ8ilB5afq5jlnYZ/dxIoVKNnLl
	 7xmgQPJ+HZVbdUYSH5FXjofKWfNkwYJbcdacFvKC7sjKsoonsxWCCdUeb9wpIaCwrS
	 U4PGMxw3Aefsn/44CE0XgO28YKSzgJUJSCPsC/ws=
Subject: FAILED: patch "[PATCH] arm64: kprobes: call set_memory_rox() for kprobe page" failed to apply to 6.1-stable tree
To: yang@os.amperecomputing.com,catalin.marinas@arm.com,stable@vger.kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:20:34 +0200
Message-ID: <2025101634-riveter-crust-f6b3@gregkh>
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
git cherry-pick -x 195a1b7d8388c0ec2969a39324feb8bebf9bb907
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101634-riveter-crust-f6b3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 195a1b7d8388c0ec2969a39324feb8bebf9bb907 Mon Sep 17 00:00:00 2001
From: Yang Shi <yang@os.amperecomputing.com>
Date: Thu, 18 Sep 2025 09:23:49 -0700
Subject: [PATCH] arm64: kprobes: call set_memory_rox() for kprobe page

The kprobe page is allocated by execmem allocator with ROX permission.
It needs to call set_memory_rox() to set proper permission for the
direct map too. It was missed.

Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 0c5d408afd95..8ab6104a4883 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "kprobes: " fmt
 
+#include <linux/execmem.h>
 #include <linux/extable.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void __kprobes
 post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
+void *alloc_insn_page(void)
+{
+	void *addr;
+
+	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
+	if (!addr)
+		return NULL;
+	set_memory_rox((unsigned long)addr, 1);
+	return addr;
+}
+
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	kprobe_opcode_t *addr = p->ainsn.xol_insn;


