Return-Path: <stable+bounces-164917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C54B139F4
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 13:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B8318927F7
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE325C70C;
	Mon, 28 Jul 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c9ngnB29"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2F21CA0C
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753702512; cv=none; b=F7za/x2pCUDJML/D5xAXjf/PL6sZ2xjLq3i7yy5AllB08GWLjhv4nN1A6vBDPtLe+xzrhxCgsFKPieLYYBL82BVRfkWyfwUix5jYq2BdY6KdR2SVpE957b/B0/VH4gcbsc06lcy8OK+nlhcw24KiGC08kvu3aHPvLQ+J60QF+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753702512; c=relaxed/simple;
	bh=DSzpAclM/p9KzoOKP0KR+82Hzm6GPdekidBc+ioj8Z8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U3xA6Qgbfc/JXzltMVUkWMwhHg5XLEnE6rbj+FdDiOw8cCGvGl9FKbF1eLgHWXnCd5u5P0RHw2+BoDTdi54S9bLZsvvFHRr8IgYSBJTOXC4gXzwYPsCP2z0zmVo8xSYR3OcmgItxJ2aQEv5ZscitsauTKHKuYFJaEKDiOByocvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c9ngnB29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B70EC4CEE7;
	Mon, 28 Jul 2025 11:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753702512;
	bh=DSzpAclM/p9KzoOKP0KR+82Hzm6GPdekidBc+ioj8Z8=;
	h=Subject:To:Cc:From:Date:From;
	b=c9ngnB29AvKPbfz3oAN342fiovpJ0yOzs5TgeMfbjjBhJchAjiSfJMoy/6WhNyEdY
	 28jTLPmkcRmBWSy0DifrzFKtU++cS/tmVa4Lk4R5mhG6LhdyY0n73CbcPcADUJbLQA
	 2auJ/yOp26yBX4/qQgNDIB8VTa1VwYqE75uh9k9U=
Subject: FAILED: patch "[PATCH] ARM: 9448/1: Use an absolute path to unified.h in" failed to apply to 5.15-stable tree
To: nathan@kernel.org,bot@kernelci.org,masahiroy@kernel.org,rmk+kernel@armlinux.org.uk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Jul 2025 13:34:55 +0200
Message-ID: <2025072855-footbath-stooge-3311@gregkh>
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
git cherry-pick -x 87c4e1459e80bf65066f864c762ef4dc932fad4b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072855-footbath-stooge-3311@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87c4e1459e80bf65066f864c762ef4dc932fad4b Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Fri, 20 Jun 2025 19:08:09 +0100
Subject: [PATCH] ARM: 9448/1: Use an absolute path to unified.h in
 KBUILD_AFLAGS

After commit d5c8d6e0fa61 ("kbuild: Update assembler calls to use proper
flags and language target"), which updated as-instr to use the
'assembler-with-cpp' language option, the Kbuild version of as-instr
always fails internally for arch/arm with

  <command-line>: fatal error: asm/unified.h: No such file or directory
  compilation terminated.

because '-include' flags are now taken into account by the compiler
driver and as-instr does not have '$(LINUXINCLUDE)', so unified.h is not
found.

This went unnoticed at the time of the Kbuild change because the last
use of as-instr in Kbuild that arch/arm could reach was removed in 5.7
by commit 541ad0150ca4 ("arm: Remove 32bit KVM host support") but a
stable backport of the Kbuild change to before that point exposed this
potential issue if one were to be reintroduced.

Follow the general pattern of '-include' paths throughout the tree and
make unified.h absolute using '$(srctree)' to ensure KBUILD_AFLAGS can
be used independently.

Closes: https://lore.kernel.org/CACo-S-1qbCX4WAVFA63dWfHtrRHZBTyyr2js8Lx=Az03XHTTHg@mail.gmail.com/

Cc: stable@vger.kernel.org
Fixes: d5c8d6e0fa61 ("kbuild: Update assembler calls to use proper flags and language target")
Reported-by: KernelCI bot <bot@kernelci.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4808d3ed98e4..e31e95ffd33f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -149,7 +149,7 @@ endif
 # Need -Uarm for gcc < 3.x
 KBUILD_CPPFLAGS	+=$(cpp-y)
 KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
-KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
+KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include $(srctree)/arch/arm/include/asm/unified.h -msoft-float
 KBUILD_RUSTFLAGS += --target=arm-unknown-linux-gnueabi
 
 CHECKFLAGS	+= -D__arm__


