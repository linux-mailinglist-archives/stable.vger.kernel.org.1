Return-Path: <stable+bounces-69475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9433956688
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8ADB2323D
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9339015C12C;
	Mon, 19 Aug 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rFjB3T60"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994315B987
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058800; cv=none; b=dACZEPIcfv9PZrtC0QviHXNvVRX+D73iYl60WzcdCMgDqAaN7889N/Myk/4nUPw3YB2pevTwh/S0sFGGF0EyoShHcOmolOIGkC/D2liMY9NypSVEUZ4SpnWr1DqXkfqmJ/8RlH12p953vJlNu23nHpDJV6RrlVJHBJ29u35LkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058800; c=relaxed/simple;
	bh=0gIlzfpKvttEjmooz8gUJYEZgQ24RLommFGrxRLdlDk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pxoSmfrTh0a4xVAw7lRxnT7OsVHRA+jvioY8IJrQkWUPOhjjdnwkOvA/9lAJW4JrbrjuXwhW2XBjD1u6LE/d1miazfP9Cdi6CDG/Id8nkg1PAHzhpSPKS3ljMrYEvpV5+rXvI6ZM7VNbNdFyWL4S7zaIY47MnWPQOWyd0OmUhl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rFjB3T60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51DCC32782;
	Mon, 19 Aug 2024 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724058800;
	bh=0gIlzfpKvttEjmooz8gUJYEZgQ24RLommFGrxRLdlDk=;
	h=Subject:To:Cc:From:Date:From;
	b=rFjB3T60wanVudpyLQXPBMy7m0/iO/YlDu1DTsIuSOsAorPZGqk18G/kthUvQF92/
	 OQN7AOLtfP02lz1W0NY2pE8r+GhOp/TR6yIVgDz0b0cMsK4iFURz5NWORSm9gGKUl3
	 0PxzQg66mQBfy3CDlFJzTguDfJdFAcG04NQ4vzHU=
Subject: FAILED: patch "[PATCH] riscv: entry: always initialize regs->a0 to -ENOSYS" failed to apply to 6.6-stable tree
To: coelacanthushex@gmail.com,CoelacanthusHex@gmail.com,bjorn@rivosinc.com,ldv@strace.io,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:13:17 +0200
Message-ID: <2024081917-flanked-clear-e564@gregkh>
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
git cherry-pick -x 61119394631f219e23ce98bcc3eb993a64a8ea64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081917-flanked-clear-e564@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

61119394631f ("riscv: entry: always initialize regs->a0 to -ENOSYS")
05d450aabd73 ("riscv: Support RANDOMIZE_KSTACK_OFFSET")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61119394631f219e23ce98bcc3eb993a64a8ea64 Mon Sep 17 00:00:00 2001
From: Celeste Liu <coelacanthushex@gmail.com>
Date: Thu, 27 Jun 2024 22:23:39 +0800
Subject: [PATCH] riscv: entry: always initialize regs->a0 to -ENOSYS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Otherwise when the tracer changes syscall number to -1, the kernel fails
to initialize a0 with -ENOSYS and subsequently fails to return the error
code of the failed syscall to userspace. For example, it will break
strace syscall tampering.

Fixes: 52449c17bdd1 ("riscv: entry: set a0 = -ENOSYS only when syscall != -1")
Reported-by: "Dmitry V. Levin" <ldv@strace.io>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
Link: https://lore.kernel.org/r/20240627142338.5114-2-CoelacanthusHex@gmail.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 05a16b1f0aee..51ebfd23e007 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -319,6 +319,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		regs->epc += 4;
 		regs->orig_a0 = regs->a0;
+		regs->a0 = -ENOSYS;
 
 		riscv_v_vstate_discard(regs);
 
@@ -328,8 +329,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		if (syscall >= 0 && syscall < NR_syscalls)
 			syscall_handler(regs, syscall);
-		else if (syscall != -1)
-			regs->a0 = -ENOSYS;
+
 		/*
 		 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
 		 * so the maximum stack offset is 1k bytes (10 bits).


