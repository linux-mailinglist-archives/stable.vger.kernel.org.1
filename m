Return-Path: <stable+bounces-187968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAC2BEFD44
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE09E4EB762
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1C2DFA29;
	Mon, 20 Oct 2025 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qAQk6E2n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9D2BE639
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947843; cv=none; b=tAh2zgVDfe1Ahbf5COTXdFVWUKqlRextjKUSBZ4sdYVJUX6KEdMStN8BW7SjW/dJ8nstrITnSGg6sFItFqdNyXyRQ6RICcLHu1cIo3+LRcS+3l791E18hlwSieH47+BMHfl4x8zFT8+LgLviSEI7pBjPoS3WmkniJgPTRmiAq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947843; c=relaxed/simple;
	bh=hedUl11LhdJPxdJYTasDSpiEQPsnUJCFY16uOxNasWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Xj238Am+HV6nMguB2q2aeB6ychtuS4hSOlpZZLtNMlLuWvO8MH+Oe/MG32lgzoHAnDdjCaFwd66W465MuQ6DSo3y0Dbzel+CQhuCT2Lt6jY8Q048dv/g7fyN+2XV1NmoK3QAHDTevAxlZlJtYj8iW80+xoIze375FbEiDuvmji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qAQk6E2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A06C4CEF9;
	Mon, 20 Oct 2025 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947843;
	bh=hedUl11LhdJPxdJYTasDSpiEQPsnUJCFY16uOxNasWE=;
	h=Subject:To:Cc:From:Date:From;
	b=qAQk6E2nVL41MO6P3aDJo+8r2A5L1MeVN4RMoR2hf//qDrteCf1HkR2y3XodQcWTm
	 /b+9EePQr+JbPEPnAP7iDApKA4rfREmhNfZjC94YuAoVnF1FJYEWxDWMStFTgnxriL
	 gGekUCo9VKCZvn39qzs6tRHYjcBwH+5agz0moA9I=
Subject: FAILED: patch "[PATCH] arm64: debug: always unmask interrupts in el0_softstp()" failed to apply to 6.17-stable tree
To: ada.coupriediaz@arm.com,catalin.marinas@arm.com,mark.rutland@arm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:10:40 +0200
Message-ID: <2025102040-gopher-dipping-a96a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x ea0d55ae4b3207c33691a73da3443b1fd379f1d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102040-gopher-dipping-a96a@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea0d55ae4b3207c33691a73da3443b1fd379f1d2 Mon Sep 17 00:00:00 2001
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Date: Tue, 14 Oct 2025 10:25:36 +0100
Subject: [PATCH] arm64: debug: always unmask interrupts in el0_softstp()

We intend that EL0 exception handlers unmask all DAIF exceptions
before calling exit_to_user_mode().

When completing single-step of a suspended breakpoint, we do not call
local_daif_restore(DAIF_PROCCTX) before calling exit_to_user_mode(),
leaving all DAIF exceptions masked.

When pseudo-NMIs are not in use this is benign.

When pseudo-NMIs are in use, this is unsound. At this point interrupts
are masked by both DAIF.IF and PMR_EL1, and subsequent irq flag
manipulation may not work correctly. For example, a subsequent
local_irq_enable() within exit_to_user_mode_loop() will only unmask
interrupts via PMR_EL1 (leaving those masked via DAIF.IF), and
anything depending on interrupts being unmasked (e.g. delivery of
signals) will not work correctly.

This was detected by CONFIG_ARM64_DEBUG_PRIORITY_MASKING.

Move the call to `try_step_suspended_breakpoints()` outside of the check
so that interrupts can be unmasked even if we don't call the step handler.

Fixes: 0ac7584c08ce ("arm64: debug: split single stepping exception entry")
Cc: <stable@vger.kernel.org> # 6.17
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
[catalin.marinas@arm.com: added Mark's rewritten commit log and some whitespace]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index f546a914f041..a9c81715ce59 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -697,6 +697,8 @@ static void noinstr el0_breakpt(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 {
+	bool step_done;
+
 	if (!is_ttbr0_addr(regs->pc))
 		arm64_apply_bp_hardening();
 
@@ -707,10 +709,10 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 	 * If we are stepping a suspended breakpoint there's nothing more to do:
 	 * the single-step is complete.
 	 */
-	if (!try_step_suspended_breakpoints(regs)) {
-		local_daif_restore(DAIF_PROCCTX);
+	step_done = try_step_suspended_breakpoints(regs);
+	local_daif_restore(DAIF_PROCCTX);
+	if (!step_done)
 		do_el0_softstep(esr, regs);
-	}
 	arm64_exit_to_user_mode(regs);
 }
 


