Return-Path: <stable+bounces-186019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83125BE353E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3F240819F
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 12:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1CC32BF48;
	Thu, 16 Oct 2025 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jxrpTypQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AD3277B1
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617269; cv=none; b=Q3Qi74Q+4pawLIB130+RIWixAqDPsU+CsyXiWPAgr0rGpkMxI/RD3B63KqRWJHmxL0eAJIGhnrViOGl6qVZ75jQasilo+aSWjjXOVAQhUcitPjmdk2udBI52HLiklufKvJ7sWPNyZ+WhMeCn/L8cKWfth9gUilr7jPHYlYh/36w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617269; c=relaxed/simple;
	bh=VkzLVJ9FiInL+EJq1A089X6IIkZs48HUOiBo/36ktdA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f5V9pf7Um5PZePPH37+qQvr8FtlWnd2/KEcyc0nLxB2OHr8jLwIhAJBJpjnJvsrWMb1diDzJfnyN1mKG6pIWUyyXgDQpqnb3U4o32uBGPfhX2K7yuTIO2k+PZfVBKUFhYtqMYaJfYFatqqLDAnyzaTCH30KcgwrTXYmiZlXowU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jxrpTypQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B90C4CEF9;
	Thu, 16 Oct 2025 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760617266;
	bh=VkzLVJ9FiInL+EJq1A089X6IIkZs48HUOiBo/36ktdA=;
	h=Subject:To:Cc:From:Date:From;
	b=jxrpTypQRhnKdejr9UNovHvHXIl4xvdVWrss1QFU8oPuIdjtyQ0ZNlIVdqBFIsmlQ
	 LZROT5g0hHKNQ5a8URiLiXDGRLOM2q/JmNyBJGDgeLkJdANwcwocF6SpsYuH1LLtJt
	 9wa7VCg+mwUiDqgdHyF8t5Tl9t/RZCTaKTqhFuPU=
Subject: FAILED: patch "[PATCH] arm64: kprobes: call set_memory_rox() for kprobe page" failed to apply to 6.6-stable tree
To: yang@os.amperecomputing.com,catalin.marinas@arm.com,stable@vger.kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:20:58 +0200
Message-ID: <2025101658-gladiator-reheat-eca3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 195a1b7d8388c0ec2969a39324feb8bebf9bb907
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101658-gladiator-reheat-eca3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


