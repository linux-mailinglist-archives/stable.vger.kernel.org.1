Return-Path: <stable+bounces-89983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D57B9BDC41
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836B0B23B20
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B841DD886;
	Wed,  6 Nov 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGQeYu2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E11DDA14;
	Wed,  6 Nov 2024 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859074; cv=none; b=DyBHluKUwrmfezNxDEpSSUD6Do/aIezRC6MOZNauQM1A07i3YoYmIDekvM0/izyidLajoarPlXnXUEFO9FsqaPnvd6MJkh7ANuDfcQaNAhBncJXqi/DDJonNyNR/Fz+r8nGGLEiJWVlUkjQCXAAnAAZiKqvwRXR21L6ykewYnww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859074; c=relaxed/simple;
	bh=fzCzDevYVLqItwXvQJgE6iP2JEYT39bi5k3NAHgpDWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MpYOcxkzZwCaQMoczrfFlMfYYr8akqxu3/rRHJgOFqG1tPUVVHUPvwz1i4AeAv9oYM2pG49CCKOdz50AmAuUajn5J5CvYhKMyODLDW3JoUQBSYRadJxYqNW6MpvcVzor/6AT2baHFqmY1uBzxTHrDMnrHKdxsfiy9FHyuwXVzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGQeYu2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622E8C4CECF;
	Wed,  6 Nov 2024 02:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859073;
	bh=fzCzDevYVLqItwXvQJgE6iP2JEYT39bi5k3NAHgpDWY=;
	h=From:To:Cc:Subject:Date:From;
	b=lGQeYu2/vMYJQxZOVQbvwSy5m/Yso0HevSW3nv/acTL05PotxjqzsewgCJDQ0Eryz
	 hW6bNpJk07u/yTL31nRB+fz33DwZui+N6K7D4AJfpAnPgmfBiHvMvaZZ+yeH03OJqP
	 P0I8i6H9PxE/GnXFF4GiSagGGgNOtHoW3YHEydDypGL0Q16s1dEDxfZmhXjsamE5kK
	 peKbcQKPXiTgxIiJcnY50nih89oQlprr2NQmCkjYU+F6ULdtYzvySgmrq9xmJYnmd3
	 JR8t9FdnDMwPCQORw/n4euibRR1xgQOMGocpY+kfcTsDVB/L3SHK7YhAwxeFrbplGn
	 5+XWP9Dodszyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	snovitoll@gmail.com
Cc: Alexander Potapenko <glider@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "x86/traps: move kmsan check after instrumentation_begin" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:11:10 -0500
Message-ID: <20241106021110.182083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1db272864ff250b5e607283eaec819e1186c8e26 Mon Sep 17 00:00:00 2001
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Wed, 16 Oct 2024 20:24:07 +0500
Subject: [PATCH] x86/traps: move kmsan check after instrumentation_begin

During x86_64 kernel build with CONFIG_KMSAN, the objtool warns following:

  AR      built-in.a
  AR      vmlinux.a
  LD      vmlinux.o
vmlinux.o: warning: objtool: handle_bug+0x4: call to
    kmsan_unpoison_entry_regs() leaves .noinstr.text section
  OBJCOPY modules.builtin.modinfo
  GEN     modules.builtin
  MODPOST Module.symvers
  CC      .vmlinux.export.o

Moving kmsan_unpoison_entry_regs() _after_ instrumentation_begin() fixes
the warning.

There is decode_bug(regs->ip, &imm) is left before KMSAN unpoisoining, but
it has the return condition and if we include it after
instrumentation_begin() it results the warning "return with
instrumentation enabled", hence, I'm concerned that regs will not be KMSAN
unpoisoned if `ud_type == BUG_NONE` is true.

Link: https://lkml.kernel.org/r/20241016152407.3149001-1-snovitoll@gmail.com
Fixes: ba54d194f8da ("x86/traps: avoid KMSAN bugs originating from handle_bug()")
Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/x86/kernel/traps.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d05392db5d0fe..2dbadf347b5f4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -261,12 +261,6 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	int ud_type;
 	u32 imm;
 
-	/*
-	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
-	 * is a rare case that uses @regs without passing them to
-	 * irqentry_enter().
-	 */
-	kmsan_unpoison_entry_regs(regs);
 	ud_type = decode_bug(regs->ip, &imm);
 	if (ud_type == BUG_NONE)
 		return handled;
@@ -275,6 +269,12 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 	 * All lies, just get the WARN/BUG out.
 	 */
 	instrumentation_begin();
+	/*
+	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
+	 * is a rare case that uses @regs without passing them to
+	 * irqentry_enter().
+	 */
+	kmsan_unpoison_entry_regs(regs);
 	/*
 	 * Since we're emulating a CALL with exceptions, restore the interrupt
 	 * state to what it was at the exception site.
-- 
2.43.0





