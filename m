Return-Path: <stable+bounces-186017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A9BE3529
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A31A19C769A
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFB2E6CCA;
	Thu, 16 Oct 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v8MDmOkM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A42DECD2
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617211; cv=none; b=aGuPhVezOHbiJoktLz6HE2smTxtYzG7ZYlIL5J96jZIoCY1BlY6IMUNm3VJRl6g18LFHodVmRf8jUak0ilH5kTfbmTJkXTOyazUd2euzd4T6rnh6WqzhjVjQQoSyaMyhnbdpG2fcr9U2qP7DCPy/itgRwPnEj4u/hIi6oW5oaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617211; c=relaxed/simple;
	bh=7IHLganPNxjEu0la1sgSBmmAkvwChGC/8emtkZSQ5uE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HGdKELX9aiFo/tOCexQKq3ouhpiZZVGWA8MYhwKGubc5xIi2ugwBEehUh4gcnxgRfY0bG+AXR51li3uOdD0hTNfxwGlcvXtoWWQn6GMwdsK/4AyAc4MJFz+MbNILiyxdxRky+QDZ5EktrgEkFl3DFaNrs96nzFWDv8iN0mTR55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v8MDmOkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA62C4CEF1;
	Thu, 16 Oct 2025 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760617211;
	bh=7IHLganPNxjEu0la1sgSBmmAkvwChGC/8emtkZSQ5uE=;
	h=Subject:To:Cc:From:Date:From;
	b=v8MDmOkMhrMGi6cA49mcZtm1vA9f4pS3+xC6eNzyBSqK3gb4HMBsk71yNWxuSVu/n
	 9sCCBF6SsE9Hhu7O7LgUGinDo2v/FIU8Ll3FMCWH6wOjgQLMFP9oc+IMjr8HExjWb8
	 rW5sc3bGoWh0p6Thq071so3DFqLn4PlbMUYRn4E0=
Subject: FAILED: patch "[PATCH] arm64: kprobes: call set_memory_rox() for kprobe page" failed to apply to 5.15-stable tree
To: yang@os.amperecomputing.com,catalin.marinas@arm.com,stable@vger.kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:20:08 +0200
Message-ID: <2025101608-fastball-thaw-dc90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 195a1b7d8388c0ec2969a39324feb8bebf9bb907
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101608-fastball-thaw-dc90@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


