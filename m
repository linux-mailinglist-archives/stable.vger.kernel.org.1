Return-Path: <stable+bounces-139290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 935E6AA5BA4
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 09:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9501BC5146
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 07:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF822A4E0;
	Thu,  1 May 2025 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qeEAQRxE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C6242A9D
	for <stable@vger.kernel.org>; Thu,  1 May 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746086069; cv=none; b=Aixs7k6DOFxbvd92HwBblRM70FolopyKI20Qi2GrBjRtW5JgxYuUPd+v/CeI0OIyshPzOfsoty8xlcqlMHLuQiFmwOPY9fbQenF3v2exK72kiKa3XnvK2G3t0Lu4vZJvpEx/26eLxt1qSEnOY57EQknux+KEpSjfxuzW1nFU7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746086069; c=relaxed/simple;
	bh=fSEhE5YsQjXRyGSieq3grK2CkkO36GlQ/IFVgT/sqV0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=INeRb6i0u5U3JsDlglFQ/R9YD2mvSUBUM+W90Ug0bRcQbZRBMf3Cc6tEQn6yLYgzWAd6XLZU+PJviCFv1FHM8N3y8k5hP/7dW7gIoowHMvJuY5f1BQeKqSCyQKLlkuhBF1WVEQ+moJf41vuy+KvJpJrhqrfEHlJ4lVixZhB1lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qeEAQRxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4392EC4CEE3;
	Thu,  1 May 2025 07:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746086069;
	bh=fSEhE5YsQjXRyGSieq3grK2CkkO36GlQ/IFVgT/sqV0=;
	h=Subject:To:Cc:From:Date:From;
	b=qeEAQRxEz2szPBksKesiIanDABj5tzcDQXAfEy5uJU8Ts5QsEGO2xV3jLyMesxHus
	 8nnBgghrMxaQVNdtv9musCAOZuVJXFc1SYlaNan19qRccPkH+WGNmrXd+76f2xYjD9
	 pfizy92BOQY6c7alOxrmd0YzrGBQURyUZZ7H+ZvQ=
Subject: FAILED: patch "[PATCH] riscv: uprobes: Add missing fence.i after building the XOL" failed to apply to 5.15-stable tree
To: bjorn@rivosinc.com,guoren@kernel.org,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 09:54:26 +0200
Message-ID: <2025050126-joyride-preorder-06e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7d1d19a11cfbfd8bae1d89cc010b2cc397cd0c48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050126-joyride-preorder-06e9@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d1d19a11cfbfd8bae1d89cc010b2cc397cd0c48 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Date: Sat, 19 Apr 2025 13:14:00 +0200
Subject: [PATCH] riscv: uprobes: Add missing fence.i after building the XOL
 buffer
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The XOL (execute out-of-line) buffer is used to single-step the
replaced instruction(s) for uprobes. The RISC-V port was missing a
proper fence.i (i$ flushing) after constructing the XOL buffer, which
can result in incorrect execution of stale/broken instructions.

This was found running the BPF selftests "test_progs:
uprobe_autoattach, attach_probe" on the Spacemit K1/X60, where the
uprobes tests randomly blew up.

Reviewed-by: Guo Ren <guoren@kernel.org>
Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20250419111402.1660267-2-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 4b3dc8beaf77..cc15f7ca6cc1 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -167,6 +167,7 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	/* Initialize the slot */
 	void *kaddr = kmap_atomic(page);
 	void *dst = kaddr + (vaddr & ~PAGE_MASK);
+	unsigned long start = (unsigned long)dst;
 
 	memcpy(dst, src, len);
 
@@ -176,13 +177,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 		*(uprobe_opcode_t *)dst = __BUG_INSN_32;
 	}
 
+	flush_icache_range(start, start + len);
 	kunmap_atomic(kaddr);
-
-	/*
-	 * We probably need flush_icache_user_page() but it needs vma.
-	 * This should work on most of architectures by default. If
-	 * architecture needs to do something different it can define
-	 * its own version of the function.
-	 */
-	flush_dcache_page(page);
 }


