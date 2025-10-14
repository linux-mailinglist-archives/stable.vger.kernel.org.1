Return-Path: <stable+bounces-185610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16CBD86D9
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B631921818
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A463E2EA159;
	Tue, 14 Oct 2025 09:25:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AF2E8DFA
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433949; cv=none; b=RfiduYy4YB7rh7mY+G6sqBfBBfTHuaOM6mY9kqDJSI25YfrM/FGSO1Xw2QEQaogGfvT5K+PR19E4BFcP7rnnU43aHqT5HUjJckjPFjQwRvIihrhpEpwxJozv6ERqB+80ovOjLRcuRwEarKCgbSDLoOl9AWLR7xtPLNQgMH/NJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433949; c=relaxed/simple;
	bh=JU8rVZnGfRQxkLCnA4s/oqiy8szuhStY6WeXixcSkak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaXf/f5OS9VRgX0CkvCAXTq5ABTbmHXc9HWY+/Y3X+sN45R4Z2bAAGHNntFudkoP98Qe1QsDoZw5kK5ypSYHiLURqhVw9W1SlgJYLWl8zFznNoYysmeuIc0WPSpkd9rqSq0/jNiuP1qCGV1VsX5Wlspmmzb6W7iBScCPWire4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EFE61A9A;
	Tue, 14 Oct 2025 02:25:38 -0700 (PDT)
Received: from e137867.cambridge.arm.com (e137867.arm.com [10.1.25.198])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9BCBD3F66E;
	Tue, 14 Oct 2025 02:25:44 -0700 (PDT)
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] arm64: debug: always unmask interrupts in el0_softstp()
Date: Tue, 14 Oct 2025 10:25:36 +0100
Message-ID: <20251014092536.18831-1-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013174317.74791-1-ada.coupriediaz@arm.com>
References: <20251013174317.74791-1-ada.coupriediaz@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EL0 exception handlers should always call `exit_to_user_mode()` with
interrupts unmasked.
When handling a completed single-step, we skip the if block and
`local_daif_restore(DAIF_PROCCTX)` never gets called,
which ends up calling `exit_to_user_mode()` with interrupts masked.

This is broken if pNMI is in use, as `do_notify_resume()` will try
to enable interrupts, but `local_irq_enable()` will only change the PMR,
leaving interrupts masked via DAIF.

Move the call to `try_step_suspended_breakpoints()` outside of the check
so that interrupts can be unmasked even if we don't call the step handler.

Fixes: 0ac7584c08ce ("arm64: debug: split single stepping exception entry")
Cc: <stable@vger.kernel.org> # 6.17
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
----
This was already broken in a similar fashion in kernels prior to v6.17,
as `local_daif_restore()` was called _after_ the debug handlers, with some
calling `send_user_sigtrap()` which would unmask interrupts via PMR
while leaving them masked by DAIF.

v2: Add missing semicolon so that the patch compiles.
My mistake for rushing a fix late, apologies.
---
 arch/arm64/kernel/entry-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 2b0c5925502e..8473fe4791bc 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -832,6 +832,7 @@ static void noinstr el0_breakpt(struct pt_regs *regs, unsigned long esr)
 
 static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
 {
+	bool step_done;
 	if (!is_ttbr0_addr(regs->pc))
 		arm64_apply_bp_hardening();
 
@@ -842,10 +843,11 @@ static void noinstr el0_softstp(struct pt_regs *regs, unsigned long esr)
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
+
 	exit_to_user_mode(regs);
 }
 

base-commit: 449d48b1b99fdaa076166e200132705ac2bee711
-- 
2.43.0


