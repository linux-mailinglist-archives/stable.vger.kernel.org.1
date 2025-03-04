Return-Path: <stable+bounces-120336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE5A4E7F1
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0FC19C514F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231628F924;
	Tue,  4 Mar 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gNK9CBbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FC4281539
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106599; cv=none; b=RLJVame15pKzjHBgyBJ5ILZceJAvDjGy6uxQE95SVoTiIoUQ0OLiVpicia1u8f+6fkP8kw94gVg2ZNadA+TnAWR4+u7l5oEtf5ORbtKABwWruh51l6D1M9rVP/ZsmKmLtwvf4AXFtEx9EUXB7CygmczCLBjNXzDoc+EirIU+NAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106599; c=relaxed/simple;
	bh=FKXqRaT1OfuHLKoIEvur6BMlnr5rW5zwINi3vYLKxMo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aF8ujyOEMKH5pLhA++IiNKs+r42qz+3EGeog/dQrzKIf6csagmuNUUpOPLjRx0GsTIalMILB6i0/ZBv1ZrtIUW2/c92x8qQh2zXrk2+5ko/jIN+1W18uGk+bW6mKNWRUwyg2Jf3D6kZCdcaoQ6kPqB8lGl0HJJpud7SJNMKnkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gNK9CBbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5C2C4CEE5;
	Tue,  4 Mar 2025 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106598;
	bh=FKXqRaT1OfuHLKoIEvur6BMlnr5rW5zwINi3vYLKxMo=;
	h=Subject:To:Cc:From:Date:From;
	b=gNK9CBbND6RyBv1Bo1+Db5zAMOGUxtSroi79P84+yrFPtMga02tWWT/1jwccIOgDP
	 gO6oU+ief613lfiMyR7W0b/XhUnZgwDaSW2LFLnc7Qm5NK69SFh4v8qQ30zU2wBfs7
	 zDNUaQOns90XS1noZR8KO2vzlxm2NohmfGSC/DUI=
Subject: FAILED: patch "[PATCH] riscv/atomic: Do proper sign extension also for unsigned in" failed to apply to 5.10-stable tree
To: schwab@suse.de,ajones@ventanamicro.com,alexghiti@rivosinc.com,palmer@rivosinc.com,xry111@xry111.site
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:43:09 +0100
Message-ID: <2025030409-senior-devotion-4685@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1898300abf3508bca152e65b36cce5bf93d7e63e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030409-senior-devotion-4685@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1898300abf3508bca152e65b36cce5bf93d7e63e Mon Sep 17 00:00:00 2001
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 30 Jan 2025 10:25:38 +0100
Subject: [PATCH] riscv/atomic: Do proper sign extension also for unsigned in
 arch_cmpxchg

Sign extend also an unsigned compare value to match what lr.w is doing.
Otherwise try_cmpxchg may spuriously return true when used on a u32 value
that has the sign bit set, as it happens often in inode_set_ctime_current.

Do this in three conversion steps.  The first conversion to long is needed
to avoid a -Wpointer-to-int-cast warning when arch_cmpxchg is used with a
pointer type.  Then convert to int and back to long to always sign extend
the 32-bit value to 64-bit.

Fixes: 6c58f25e6938 ("riscv/atomic: Fix sign extension for RV64I")
Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Tested-by: Xi Ruoyao <xry111@xry111.site>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/mvmed0k4prh.fsf@suse.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 4cadc56220fe..427c41dde643 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -231,7 +231,7 @@
 		__arch_cmpxchg(".w", ".w" sc_sfx, ".w" cas_sfx,		\
 			       sc_prepend, sc_append,			\
 			       cas_prepend, cas_append,			\
-			       __ret, __ptr, (long), __old, __new);	\
+			       __ret, __ptr, (long)(int)(long), __old, __new);	\
 		break;							\
 	case 8:								\
 		__arch_cmpxchg(".d", ".d" sc_sfx, ".d" cas_sfx,		\


