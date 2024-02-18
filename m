Return-Path: <stable+bounces-20425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2385942A
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 03:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CF91C20C0B
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 02:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A615C0;
	Sun, 18 Feb 2024 02:49:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AF7F6
	for <stable@vger.kernel.org>; Sun, 18 Feb 2024 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708224557; cv=none; b=aZk6xeVgugQ2o/5mhwQ4Px5IUOqMOfcf3qEE6Vi9IpmQ+Fn/FknKe4hFQZ4dHzXIdix/Plc5z78BJ/TMHI97RwFDYuOnc/cD/l1vdJ5Htad4A2LcbRss8bgO0pCUrpL8ZvdesBQaqlyBdCAmKzlYD4QG8JZpk1Etr/pIKn0PYqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708224557; c=relaxed/simple;
	bh=Ch+KPMAfZbjpeoHV2JqF6Lj0VTFv4h0rsOlzB6XoXJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qvk5Qu7Q94iE2V1zJCbL2RrQXom9xR9pMkIb5tgt4GDN80TIVhbqNWtoLF2hMz1LYEAVVDsCjdN/8HO62WGHKyKp6NiaMwGtYorEm4kTNB+rV8VbSJWuOaHXa66cZGuhIMpoaFRNxId+cmcN4M5rLSAP84khyoM9b0kdUTLxO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4TcqRn1FLTz1Q8p8;
	Sun, 18 Feb 2024 10:31:33 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 32B9914011B;
	Sun, 18 Feb 2024 10:33:08 +0800 (CST)
Received: from canpemm500004.china.huawei.com (7.192.104.92) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 10:33:08 +0800
Received: from huawei.com (10.67.174.111) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 10:33:07 +0800
From: Xiang Yang <xiangyang3@huawei.com>
To: <ardb@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>
CC: <keescook@chromium.org>, <linux-arm-kernel@lists.infradead.org>,
	<stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<xiangyang3@huawei.com>, <xiujianfeng@huawei.com>, <liaochang1@huawei.com>
Subject: [PATCH 5.10.y 5/5] arm64: Stash shadow stack pointer in the task struct on interrupt
Date: Sun, 18 Feb 2024 10:30:55 +0800
Message-ID: <20240218023055.145519-6-xiangyang3@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218023055.145519-1-xiangyang3@huawei.com>
References: <20240218023055.145519-1-xiangyang3@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500004.china.huawei.com (7.192.104.92)

From: Ard Biesheuvel <ardb@kernel.org>

commit 59b37fe52f49955791a460752c37145f1afdcad1 upstream.

Instead of reloading the shadow call stack pointer from the ordinary
stack, which may be vulnerable to the kind of gadget based attacks
shadow call stacks were designed to prevent, let's store a task's shadow
call stack pointer in the task struct when switching to the shadow IRQ
stack.

Given that currently, the task_struct::scs_sp field is only used to
preserve the shadow call stack pointer while a task is scheduled out or
running in user space, reusing this field to preserve and restore it
while running off the IRQ stack must be safe, as those occurrences are
guaranteed to never overlap. (The stack switching logic only switches
stacks when running from the task stack, and so the value being saved
here always corresponds to the task mode shadow stack)

While at it, fold a mov/add/mov sequence into a single add.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20230109174800.3286265-3-ardb@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
---
 arch/arm64/kernel/entry.S | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index b0d102669dde..e35f3cec74d9 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -1011,19 +1011,19 @@ NOKPROBE(ret_from_fork)
  */
 SYM_FUNC_START(call_on_irq_stack)
 #ifdef CONFIG_SHADOW_CALL_STACK
-	stp	scs_sp, xzr, [sp, #-16]!
+	get_current_task x16
+	scs_save x16
 	adr_this_cpu scs_sp, irq_shadow_call_stack, x17
 #endif
+
 	/* Create a frame record to save our LR and SP (implicit in FP) */
 	stp	x29, x30, [sp, #-16]!
 	mov	x29, sp
 
 	ldr_this_cpu x16, irq_stack_ptr, x17
-	mov	x15, #IRQ_STACK_SIZE
-	add	x16, x16, x15
 
 	/* Move to the new stack and call the function there */
-	mov	sp, x16
+	add	sp, x16, #IRQ_STACK_SIZE
 	blr	x1
 
 	/*
@@ -1032,9 +1032,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	 */
 	mov	sp, x29
 	ldp	x29, x30, [sp], #16
-#ifdef CONFIG_SHADOW_CALL_STACK
-	ldp	scs_sp, xzr, [sp], #16
-#endif
+	scs_load_current
 	ret
 SYM_FUNC_END(call_on_irq_stack)
 NOKPROBE(call_on_irq_stack)
-- 
2.34.1


