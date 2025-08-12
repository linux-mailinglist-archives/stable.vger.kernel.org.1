Return-Path: <stable+bounces-167180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB3B22CFF
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E271625A1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A3305E31;
	Tue, 12 Aug 2025 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RbUlzqb1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60956305E08
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015183; cv=none; b=ozJI626gRoqgHv8IjxKW81CSbXuEtwrpBWMShz2q9Prs3bHY9Wx10/CxBlxw5ud1342xtzCBeiaiZAiJ13kvdXrLsaqaPDgWf9F+nMSjiilPtvkM6qDOpQ9aiAd5gfh08b+JOMyOsteAlHt7lOYHxbOAMjRr2PNwuHwJL59s2zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015183; c=relaxed/simple;
	bh=tL9qGh95nWQIn+uTxft9vQdSYbnPAVw/9EDh+xgO/8A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cwIgfAIRJJ4w5zMbv7yJQ1BjeDGnOQFGbOvJ3u+jXwPdJ858KUTiO5tA1TjhVKFvvKqomNl+aux8ayyolTwW8YhB3/W+tvqqzRsg/1aZLVYNvlXUT7tEbe1TWqN95krilvTf+ZhUR7Gv7O/5M9gFlmLbOFK3+OctgUfhF8t+lJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RbUlzqb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FE1C4CEF0;
	Tue, 12 Aug 2025 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755015182;
	bh=tL9qGh95nWQIn+uTxft9vQdSYbnPAVw/9EDh+xgO/8A=;
	h=Subject:To:Cc:From:Date:From;
	b=RbUlzqb1xEPFcymgqBEFrU7mjbpHiXpBoZuaezyZjN2Nfr3oxea7udQtRiWojFYcV
	 b+lAei1d3cpDFF+1bxfPAgBPFuDzqdLKFqW/7jgQA5UeyJ27eoRoFzx4x3e2S8PrZH
	 r69tzESjOk2zDhP8gpS8uzXONoj+pE/P/5nRmieo=
Subject: FAILED: patch "[PATCH] x86/fpu: Delay instruction pointer fixup until after warning" failed to apply to 5.10-stable tree
To: dave.hansen@linux.intel.com,alison.schofield@intel.com,chao.gao@intel.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 18:12:51 +0200
Message-ID: <2025081251-sitter-agreed-26a4@gregkh>
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
git cherry-pick -x 1cec9ac2d071cfd2da562241aab0ef701355762a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081251-sitter-agreed-26a4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


