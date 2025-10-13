Return-Path: <stable+bounces-185490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D2BD58FD
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 19:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12B594E79D9
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB54304BDD;
	Mon, 13 Oct 2025 17:43:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332431A23A0
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377408; cv=none; b=Hjifd3+9IhLprMY06edA5Pd6PqjXfs9M0gLPEbO+mzb6Azjy3kgXhlIHgN/qSxY3IKYdN9UEW/AMLiCb6GIHpci4PWUHMOKGP0B1nQLfN/YKBYYpg0zpp8FiNzgveEJ6jjga0TenyYA5n01SK4YtYPaWNxCKkqyNA5V/3uDg4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377408; c=relaxed/simple;
	bh=w/CWRQ4+Yh109UMB+ginDZIxXzHTiyzRKP33YxgpgKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrzSkvj9139pxk1RkZsDjNyYq/NXrVpCdd/rjzKjvCDmHcWkWgFIaQiaNCM3/P8sNo16IsK3PzN4jllcIsC8aWVfkjFMETp3QOtcbPfl3FdmoizYJvEKToZnAyzo7+k8a3G31yEeLhqHBxqXvYYt4M5o23byDSHJCLOUcILmXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22C38113E;
	Mon, 13 Oct 2025 10:43:17 -0700 (PDT)
Received: from e137867.cambridge.arm.com (e137867.arm.com [10.1.31.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D12D3F66E;
	Mon, 13 Oct 2025 10:43:23 -0700 (PDT)
From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: debug: always unmask interrupts in el0_softstp()
Date: Mon, 13 Oct 2025 18:43:17 +0100
Message-ID: <20251013174317.74791-1-ada.coupriediaz@arm.com>
X-Mailer: git-send-email 2.43.0
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
---
 arch/arm64/kernel/entry-common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 2b0c5925502e..780cbcf12695 100644
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
+	step_done = try_step_suspended_breakpoints(regs)
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


