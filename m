Return-Path: <stable+bounces-139291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DAEAA5BA8
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 09:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0114C3EF3
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5481C277012;
	Thu,  1 May 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dI2U2ca5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479F276053
	for <stable@vger.kernel.org>; Thu,  1 May 2025 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746086079; cv=none; b=tgbTTFOS0HDu4Ruq4sCwzIgn78xrhgtNBEjvGHH0O4TFl0pkJpUitWSxY9KER8mghFWFas0v9qP+9lTbc5P9J5PvPZFy1UriBxf4Dqve5f34raBt2vMEJ9ifqIWP1/KRS5AwsfWY5+3CuVNvfIk2u2ZCKm8h8RBqMuMHxnoDRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746086079; c=relaxed/simple;
	bh=aEbNfgyNDYB/Mjvo7DL9N5dPmf1a/ANQnyzKeDFPuxo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=frjj9hNta74DAzEqr3Y9NQM1KSdPxwQNt+b9MC1q9+ZfreS8CT8GDojW05Hi2+CY/UDCTcqhKBCz6T1C0aQho4bkK00mbs5eDlKV8G09Y4sAcqSCHpZ3BkaT2j6LePcKpcGwY7YP3IRKmTo3Kh2VqDrF/b9gQ70kdAA7gb9JVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dI2U2ca5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D4FC4CEE9;
	Thu,  1 May 2025 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746086078;
	bh=aEbNfgyNDYB/Mjvo7DL9N5dPmf1a/ANQnyzKeDFPuxo=;
	h=Subject:To:Cc:From:Date:From;
	b=dI2U2ca5bGgvo8TNN4NBVtSt3HQka7G9wnygUF2ioGHSvMJGTLrMm03+aqEOtipRu
	 J0Dh/6ie3t/gXV3SR2KEOrd4dTitUd+VsYCNHSk+jN3ei5C42JJxE+MQQ47T1wuyGz
	 qRAs81wmLpla9AciSpumzZxnnbYR9owj46OFnXi0=
Subject: FAILED: patch "[PATCH] riscv: uprobes: Add missing fence.i after building the XOL" failed to apply to 6.6-stable tree
To: bjorn@rivosinc.com,guoren@kernel.org,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 09:54:27 +0200
Message-ID: <2025050127-hamster-fester-8089@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7d1d19a11cfbfd8bae1d89cc010b2cc397cd0c48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050127-hamster-fester-8089@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


