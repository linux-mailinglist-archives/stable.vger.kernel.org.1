Return-Path: <stable+bounces-188029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4547BF0806
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B32E64EE169
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72073239E79;
	Mon, 20 Oct 2025 10:19:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B9D2E8B98
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955546; cv=none; b=m1lfNElIa+rKpBlOVBC3Vmcg7qXbua6FUoeH9Lrh0Sp6Q+2xW81ve3U8FaGSoq4G1gvRTZlJN1DiJMCWDyYzv/fpDqUybtvlOkHVi9rv9pFZUHTPWw3y3fvtmnos8RuBjMcjZrlqIMtP39QQa833FxX9PslrDOvwyqGSBognRdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955546; c=relaxed/simple;
	bh=a/JFl7OquLGXEnv5j8if6yrJQ6SSYvLks3FT7JZp+6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiaYkc/Uf7AObQnTfJne3ifJvVgOPDz1atXw+cbDz6OQFjlpSxg0KX0x8JKDjuvGrY7CWzLg9C59ORc99rmdpug2dXg3/qiLNad8WWmR+wyKQGl/p5qLIl+3FQv+fkbDAP4WC+u8VYhj6NOVM3YxPRiE6VBkJYOxONPthJcfvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 490F01063;
	Mon, 20 Oct 2025 03:18:56 -0700 (PDT)
Received: from e137867.arm.com (unknown [10.57.36.242])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECC233F63F;
	Mon, 20 Oct 2025 03:19:02 -0700 (PDT)
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.17.y] arm64: debug: always unmask interrupts in el0_softstp()
Date: Mon, 20 Oct 2025 11:18:56 +0100
Message-ID: <20251020101856.93528-1-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025102040-gopher-dipping-a96a@gregkh>
References: <2025102040-gopher-dipping-a96a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit ea0d55ae4b3207c33691a73da3443b1fd379f1d2)
[ada.coupriediaz@arm.com: Fix conflict for v6.17 stable]
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/kernel/entry-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 2b0c5925502e..db116a62ac95 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -832,6 +832,8 @@ static void noinstr el0_breakpt(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 {
+	bool step_done;
+
 	if (!is_ttbr0_addr(regs->pc))
 		arm64_apply_bp_hardening();
 
@@ -842,10 +844,10 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
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
 	exit_to_user_mode(regs);
 }
 
-- 
2.43.0


