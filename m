Return-Path: <stable+bounces-78388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2753098B909
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA221F23174
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CCB1A0739;
	Tue,  1 Oct 2024 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="znKluIxy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE71A0733
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777701; cv=none; b=uMTY5t83nnrXNb7pcnBD3e1BsMWG6a3zfg02DUnyKomYmKSF+1Uzq0u9Ra0BTsCML8IdFDzd/KBPGsRAjpEbhwnLGvqT8d9rhsCqBA36hN4JTqESCwzJX4J4SFY2+ilqAOMC1Kevu+x4LbAEMgQ1n04Lx78uZqFhYMcIY306ZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777701; c=relaxed/simple;
	bh=UasM8A5U1v2k70BKEI20tEwExLiN4Y5nagJMdSP5x1Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AdUBDOHiVRVNTzn0obeqJMSdq5lrAy5rKpXhZXP1L/TTHx1wKPiY+Cs7d49ScF62JntPjlBdd1I0w7LyqY5JYseee0U9HsQFwXKuS/82qO7NXcNwvnulR+VGoZZe9z49x1vYTMoqECdXoIaDJG824ncybNXm3lyp3jes0RqRB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=znKluIxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7732BC4CEC6;
	Tue,  1 Oct 2024 10:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777700;
	bh=UasM8A5U1v2k70BKEI20tEwExLiN4Y5nagJMdSP5x1Y=;
	h=Subject:To:Cc:From:Date:From;
	b=znKluIxyFMIRaOl/bT1V+bUZkEX9kvUOHwj6HjC1KYWWT83ysuQxfTbhsTDrdhGJG
	 ZCZSvMSv09qR3k6LUEBUIlwb36u/GRb1PcXPQcmV6/yBLZCQtuhWeBSl87sJev5ca/
	 j9jmjhvmr3JOeRMN4sPND/CASuNIz5iCX+zdWksQ=
Subject: FAILED: patch "[PATCH] x86/tdx: Fix "in-kernel MMIO" check" failed to apply to 6.10-stable tree
To: legion@kernel.org,dave.hansen@linux.intel.com,kirill.shutemov@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:14:57 +0200
Message-ID: <2024100156-dumping-crib-574c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x d4fc4d01471528da8a9797a065982e05090e1d81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100156-dumping-crib-574c@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

d4fc4d014715 ("x86/tdx: Fix "in-kernel MMIO" check")
859e63b789d6 ("x86/tdx: Convert shared memory back to private on kexec")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d4fc4d01471528da8a9797a065982e05090e1d81 Mon Sep 17 00:00:00 2001
From: "Alexey Gladkov (Intel)" <legion@kernel.org>
Date: Fri, 13 Sep 2024 19:05:56 +0200
Subject: [PATCH] x86/tdx: Fix "in-kernel MMIO" check

TDX only supports kernel-initiated MMIO operations. The handle_mmio()
function checks if the #VE exception occurred in the kernel and rejects
the operation if it did not.

However, userspace can deceive the kernel into performing MMIO on its
behalf. For example, if userspace can point a syscall to an MMIO address,
syscall does get_user() or put_user() on it, triggering MMIO #VE. The
kernel will treat the #VE as in-kernel MMIO.

Ensure that the target MMIO address is within the kernel before decoding
instruction.

Fixes: 31d58c4e557d ("x86/tdx: Handle in-kernel MMIO")
Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/565a804b80387970460a4ebc67c88d1380f61ad1.1726237595.git.legion%40kernel.org

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index da8b66dce0da..327c45c5013f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -16,6 +16,7 @@
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
+#include <asm/traps.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -433,6 +434,11 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 			return -EINVAL;
 	}
 
+	if (!fault_in_kernel_space(ve->gla)) {
+		WARN_ONCE(1, "Access to userspace address is not supported");
+		return -EINVAL;
+	}
+
 	/*
 	 * Reject EPT violation #VEs that split pages.
 	 *


