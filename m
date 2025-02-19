Return-Path: <stable+bounces-117301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D88A3B5F2
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5584D3B8A1E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AE1FAC31;
	Wed, 19 Feb 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZUz4a5P9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE271FA261;
	Wed, 19 Feb 2025 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954841; cv=none; b=A+m9l1mEOhSsf6QJANKw/s9Lh9PdCi25gZGJ7SApEaKWYBqCWDdywKV5qTeUWH25bVrd3J+yLkyTPXY+dk6t4gH6BLtSIJlNT1mitVgvQEq1Jp9CoMTi3HBLmbs1DPcDCiGolhP5ZWh5mbJ7FIvcn2ylXOMWIhkvX840MPk5yt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954841; c=relaxed/simple;
	bh=Ou4SgKjL/sOIf0han2P+e8E3jlgeYwbiTdqT3xS+dtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXU0uVQTw68covVocMdfuAVQd/lRhW3I9rClxELEpKE0R1cV4PdTYWzXF4Ix1J7435Xc449YDI24M17cfH7ujLZWvkUNb92K4sJNoUk9TmLfYpgqKUtivtg8Z2NhSy2IKsLFe/LRw5NIOENUoIKqYTGiek8vGvoZ4VOnFtJhrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZUz4a5P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC59C4CED1;
	Wed, 19 Feb 2025 08:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954841;
	bh=Ou4SgKjL/sOIf0han2P+e8E3jlgeYwbiTdqT3xS+dtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUz4a5P9tRtVHcsL7GjC/DAyUqz0blAJWTktWzWAbYd7Y9QGSaQHvYIUNr0wq9NZu
	 SzyRxKJ+hWPA097GGrNRdMroUaBTtRWahCUtjEAtHwMvvn9XNsoGFXdOcg1pHiuZOC
	 ix5saLfpv59Pmhvp306llrwqrK/z0u/ZIHVTuOHY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 026/230] LoongArch: Fix idle VS timer enqueue
Date: Wed, 19 Feb 2025 09:25:43 +0100
Message-ID: <20250219082602.731456941@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Crivellari <marco.crivellari@suse.com>

[ Upstream commit edb1942542bc538707cea221e9c7923a6270465f ]

LoongArch re-enables interrupts on its idle routine and performs a
TIF_NEED_RESCHED check afterwards before putting the CPU to sleep.

The IRQs firing between the check and the idle instruction may set the
TIF_NEED_RESCHED flag. In order to deal with such a race, IRQs
interrupting __arch_cpu_idle() rollback their return address to the
beginning of __arch_cpu_idle() so that TIF_NEED_RESCHED is checked
again before going back to sleep.

However idle IRQs can also queue timers that may require a tick
reprogramming through a new generic idle loop iteration but those timers
would go unnoticed here because __arch_cpu_idle() only checks
TIF_NEED_RESCHED. It doesn't check for pending timers.

Fix this with fast-forwarding idle IRQs return address to the end of the
idle routine instead of the beginning, so that the generic idle loop can
handle both TIF_NEED_RESCHED and pending timers.

Fixes: 0603839b18f4 ("LoongArch: Add exception/interrupt handling")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/genex.S | 28 +++++++++++++++-------------
 arch/loongarch/kernel/idle.c  |  3 +--
 arch/loongarch/kernel/reset.c |  6 +++---
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 86d5d90ebefe5..4f09121417818 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -18,16 +18,19 @@
 
 	.align	5
 SYM_FUNC_START(__arch_cpu_idle)
-	/* start of rollback region */
-	LONG_L	t0, tp, TI_FLAGS
-	nop
-	andi	t0, t0, _TIF_NEED_RESCHED
-	bnez	t0, 1f
-	nop
-	nop
-	nop
+	/* start of idle interrupt region */
+	ori	t0, zero, CSR_CRMD_IE
+	/* idle instruction needs irq enabled */
+	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
+	/*
+	 * If an interrupt lands here; between enabling interrupts above and
+	 * going idle on the next instruction, we must *NOT* go idle since the
+	 * interrupt could have set TIF_NEED_RESCHED or caused an timer to need
+	 * reprogramming. Fall through -- see handle_vint() below -- and have
+	 * the idle loop take care of things.
+	 */
 	idle	0
-	/* end of rollback region */
+	/* end of idle interrupt region */
 1:	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
 
@@ -35,11 +38,10 @@ SYM_CODE_START(handle_vint)
 	UNWIND_HINT_UNDEFINED
 	BACKUP_T0T1
 	SAVE_ALL
-	la_abs	t1, __arch_cpu_idle
+	la_abs	t1, 1b
 	LONG_L	t0, sp, PT_ERA
-	/* 32 byte rollback region */
-	ori	t0, t0, 0x1f
-	xori	t0, t0, 0x1f
+	/* 3 instructions idle interrupt region */
+	ori	t0, t0, 0b1100
 	bne	t0, t1, 1f
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
index 0b5dd2faeb90b..54b247d8cdb69 100644
--- a/arch/loongarch/kernel/idle.c
+++ b/arch/loongarch/kernel/idle.c
@@ -11,7 +11,6 @@
 
 void __cpuidle arch_cpu_idle(void)
 {
-	raw_local_irq_enable();
-	__arch_cpu_idle(); /* idle instruction needs irq enabled */
+	__arch_cpu_idle();
 	raw_local_irq_disable();
 }
diff --git a/arch/loongarch/kernel/reset.c b/arch/loongarch/kernel/reset.c
index 1ef8c63835351..de8fa5a8a825c 100644
--- a/arch/loongarch/kernel/reset.c
+++ b/arch/loongarch/kernel/reset.c
@@ -33,7 +33,7 @@ void machine_halt(void)
 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
 
 	while (true) {
-		__arch_cpu_idle();
+		__asm__ __volatile__("idle 0" : : : "memory");
 	}
 }
 
@@ -53,7 +53,7 @@ void machine_power_off(void)
 #endif
 
 	while (true) {
-		__arch_cpu_idle();
+		__asm__ __volatile__("idle 0" : : : "memory");
 	}
 }
 
@@ -74,6 +74,6 @@ void machine_restart(char *command)
 		acpi_reboot();
 
 	while (true) {
-		__arch_cpu_idle();
+		__asm__ __volatile__("idle 0" : : : "memory");
 	}
 }
-- 
2.39.5




