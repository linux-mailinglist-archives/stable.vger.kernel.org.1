Return-Path: <stable+bounces-78390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E298B90B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF5828430A
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4C1A08B1;
	Tue,  1 Oct 2024 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h8R5xvHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305EC19DFB5
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777708; cv=none; b=HvrwKhKzMgf/pjDhQZiHxlpCLJzhqmvto6gMjhtocLDKCQSC4FO9lpdANAWEx8qNC1ovz5ztJmOkGOL8eGWf8Cs2ycakOQk29Ck7uukgQ63AW9upOTq34BbA+3QOTifMbwa88SiUx3es8tP57SVN2KpPTJddWluoA39QlIKOoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777708; c=relaxed/simple;
	bh=QUq1Q1nmyvrIGSWMF/tZi9HGwn72/FT4ZIvM3Xmw8HE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VGjX2J/KYDaDlprLsL/y+ufUr55Qfx+IFMobvF4CUn3EyKzEnqBegvPQFdAtswaHyrWlhqiw9yhYF4Ie0VxVgex03kc/qwE5o3gTQWG98xRz1TVqoJ7eq9/8ggE0wFv7fKd5wSqX+4JUYaeDe4NHJwkERMigxGSGNvU0lABcwrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h8R5xvHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E049C4CECE;
	Tue,  1 Oct 2024 10:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727777707;
	bh=QUq1Q1nmyvrIGSWMF/tZi9HGwn72/FT4ZIvM3Xmw8HE=;
	h=Subject:To:Cc:From:Date:From;
	b=h8R5xvHIP4j9DrqPWq4DXgQtaPcUbbp6dWl2S6vHbsduD7PGUCxA8URSqddN0T/n4
	 jDP6a8tAS7TZEbsf1aG6bPBqGsa94xtfY9o3ZvBqPaYNb2KC59l++zVRBHlRim0IkW
	 ciuauh0aZGeRODY5eCWskL2NorJe1bD5MwdM34vc=
Subject: FAILED: patch "[PATCH] x86/tdx: Fix "in-kernel MMIO" check" failed to apply to 6.1-stable tree
To: legion@kernel.org,dave.hansen@linux.intel.com,kirill.shutemov@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:15:04 +0200
Message-ID: <2024100104-everybody-retrace-89ed@gregkh>
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
git cherry-pick -x d4fc4d01471528da8a9797a065982e05090e1d81
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100104-everybody-retrace-89ed@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

d4fc4d014715 ("x86/tdx: Fix "in-kernel MMIO" check")
859e63b789d6 ("x86/tdx: Convert shared memory back to private on kexec")
533c67e63584 ("mm/mglru: add dummy pmd_dirty()")
df57721f9a63 ("Merge tag 'x86_shstk_for_6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

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


