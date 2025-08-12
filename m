Return-Path: <stable+bounces-167181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1679CB22D0B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4BB3A2D65
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D32285C87;
	Tue, 12 Aug 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hjin2WVI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0C23D7DF
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015186; cv=none; b=XEoVyiFuVdQMTjmoJ2hJkLvCo89ElN97a/3Igl9oGvAdkFpQ/NFJREgb1zM3oWc2t+FbI7SXwg6wMH/Gw6/i7SXDPyNFKTQdjy+LITgs+1tqFUzmiHB9v1s4tzGj0b2JLzOPtyVQodyGLHBgQW5gGF0N3/h/4+wPVyyH+D/ZcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015186; c=relaxed/simple;
	bh=ht/Ym5tuH2dNR5AZyI7gGCN/jkxuOAunZYzb8T1u8Xw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K5ZgBuuo25rMpznxKvZa9m8K7fhoKOW6A6fIr4oL/10OkxxSoFmRHwWIc7PVwc0rD29fQN1pTs9811xn4ItWWpr7Q1V6vYchDZI7IulmtYQycYpmcCJU7eFgZ4YnSApK91lRN/ctSsFtOBShBpE1LHvqb7pn3FjAhkX/Rlii4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hjin2WVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC19C4CEF0;
	Tue, 12 Aug 2025 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015186;
	bh=ht/Ym5tuH2dNR5AZyI7gGCN/jkxuOAunZYzb8T1u8Xw=;
	h=Subject:To:Cc:From:Date:From;
	b=Hjin2WVIaxQaJh3XgzsMdeoJgZahIYLhMXe/2RaCmxPV+CzAXrjd69qEk5o1JMFxD
	 RW3IgmYZeDRQqn+smnmYJZt8sdAUGlUKA++Of34qLAdd4zoVMRPRuZybqfOw59eaFe
	 dXkaUCXlnrLrpV54SOLFXCmQtUwA8uUw3fpYdLVY=
Subject: FAILED: patch "[PATCH] x86/fpu: Delay instruction pointer fixup until after warning" failed to apply to 5.4-stable tree
To: dave.hansen@linux.intel.com,alison.schofield@intel.com,chao.gao@intel.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:12:52 +0200
Message-ID: <2025081252-serotonin-cranium-3e92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1cec9ac2d071cfd2da562241aab0ef701355762a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081252-serotonin-cranium-3e92@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1cec9ac2d071cfd2da562241aab0ef701355762a Mon Sep 17 00:00:00 2001
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:01:48 -0700
Subject: [PATCH] x86/fpu: Delay instruction pointer fixup until after warning

Right now, if XRSTOR fails a console message like this is be printed:

	Bad FPU state detected at restore_fpregs_from_fpstate+0x9a/0x170, reinitializing FPU registers.

However, the text location (...+0x9a in this case) is the instruction
*AFTER* the XRSTOR. The highlighted instruction in the "Code:" dump
also points one instruction late.

The reason is that the "fixup" moves RIP up to pass the bad XRSTOR and
keep on running after returning from the #GP handler. But it does this
fixup before warning.

The resulting warning output is nonsensical because it looks like the
non-FPU-related instruction is #GP'ing.

Do not fix up RIP until after printing the warning. Do this by using
the more generic and standard ex_handler_default().

Fixes: d5c8028b4788 ("x86/fpu: Reinitialize FPU registers if restoring FPU state fails")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Acked-by: Alison Schofield <alison.schofield@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250624210148.97126F9E%40davehans-spike.ostc.intel.com

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index bf8dab18be97..2fdc1f1f5adb 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -122,13 +122,12 @@ static bool ex_handler_sgx(const struct exception_table_entry *fixup,
 static bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 				 struct pt_regs *regs)
 {
-	regs->ip = ex_fixup_addr(fixup);
-
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
 	fpu_reset_from_exception_fixup();
-	return true;
+
+	return ex_handler_default(fixup, regs);
 }
 
 /*


