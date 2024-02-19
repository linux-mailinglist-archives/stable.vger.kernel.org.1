Return-Path: <stable+bounces-20700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1F885AB56
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116B71F23EA4
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE4F9E0;
	Mon, 19 Feb 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FXWo0BNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C84878A
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368265; cv=none; b=AGrHJ7AkeXPB1WoGasWd7eeQU+p/xyq5EQJHz2mAW2TwZ5q20EFzRADoe8dQVcRbywIz1pVjtss3jwz8TwkAINB7a8q6LmJhjvWToKIy42CbFpvpRXyiqxBl32RqGAgtEM9ZPUrb1ctlnLnP6teTN8V6nk4TDThXx3JtxIybKiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368265; c=relaxed/simple;
	bh=+r/Rhlm93M5FhjDKOX/aTcgz5A7sdqyP/1TXmfCrX/g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F4EvIS1jgHEBA3o7msi6rqoF8P4408My8JViQeOchwMewmmhWhK+AnHg3qg66WodfDdvEeQSs1R2ADTURAeXG+7T/77Psw9uUUGLnh2ez3P6vyFaCF/noY0ai4cmE7ANzBhHEjeHE3Ezp2hrlI4VUzA/5fTWXSlLUsJADJZz7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FXWo0BNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C60C433C7;
	Mon, 19 Feb 2024 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368264;
	bh=+r/Rhlm93M5FhjDKOX/aTcgz5A7sdqyP/1TXmfCrX/g=;
	h=Subject:To:Cc:From:Date:From;
	b=FXWo0BNvWJgtEtlDsFAebFyYS11Pb5OZRsKJAGl1ROWFBxDDe8W5QT3NYQOiXBmOd
	 t8Od1bDulo3s62hMxFrlXnWQBR+uuLr38zKRndpHE8rERFcqjsp12ELQGSNYT94Q3l
	 DIOSxhEeNYVEtWAZNsw7a7toypOpS1dNeSjsIbtQ=
Subject: FAILED: patch "[PATCH] arch/arm/mm: fix major fault accounting when retrying under" failed to apply to 6.7-stable tree
To: surenb@google.com,agordeev@linux.ibm.com,akpm@linux-foundation.org,catalin.marinas@arm.com,christophe.leroy@csgroup.eu,dave.hansen@linux.intel.com,gerald.schaefer@linux.ibm.com,luto@kernel.org,mpe@ellerman.id.au,palmer@dabbelt.com,peterz@infradead.org,rmk+kernel@armlinux.org.uk,stable@vger.kernel.org,will@kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:44:21 +0100
Message-ID: <2024021921-bleak-sputter-5ecf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x e870920bbe68e52335a4c31a059e6af6a9a59dbb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021921-bleak-sputter-5ecf@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

e870920bbe68 ("arch/arm/mm: fix major fault accounting when retrying under per-VMA lock")
c16af1212479 ("ARM: 9328/1: mm: try VMA lock-based page fault handling first")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e870920bbe68e52335a4c31a059e6af6a9a59dbb Mon Sep 17 00:00:00 2001
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Jan 2024 22:43:05 -0800
Subject: [PATCH] arch/arm/mm: fix major fault accounting when retrying under
 per-VMA lock

The change [1] missed ARM architecture when fixing major fault accounting
for page fault retry under per-VMA lock.

The user-visible effects is that it restores correct major fault
accounting that was broken after [2] was merged in 6.7 kernel. The
more detailed description is in [3] and this patch simply adds the
same fix to ARM architecture which I missed in [3].

Add missing code to fix ARM architecture fault accounting.

[1] 46e714c729c8 ("arch/mm/fault: fix major fault accounting when retrying under per-VMA lock")
[2] https://lore.kernel.org/all/20231006195318.4087158-6-willy@infradead.org/
[3] https://lore.kernel.org/all/20231226214610.109282-1-surenb@google.com/

Link: https://lkml.kernel.org/r/20240123064305.2829244-1-surenb@google.com
Fixes: 12214eba1992 ("mm: handle read faults under the VMA lock")
Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index e96fb40b9cc3..07565b593ed6 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -298,6 +298,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 		goto done;
 	}
 	count_vm_vma_lock_event(VMA_LOCK_RETRY);
+	if (fault & VM_FAULT_MAJOR)
+		flags |= FAULT_FLAG_TRIED;
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {


