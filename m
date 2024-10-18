Return-Path: <stable+bounces-86731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0359A3391
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 06:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E8CB23259
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 04:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C40157A5C;
	Fri, 18 Oct 2024 04:00:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AE20E31C;
	Fri, 18 Oct 2024 04:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729224022; cv=none; b=stj6ejEai/B0EWhabSjd/UeHC33N5IymTTrmQYGoXzkQ7k5V0X37z74iy7FeuNkIzeGlw99lk6qVa7ycmCY7m+WXNvP2i6mQLjeWE1KXQSnDEHqqBWlgOztDGB+qLy43kwWX+VGZWFInyxeRGJD3dCRKMRc/9vlkU/SqTjPPS1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729224022; c=relaxed/simple;
	bh=zZfKZPP8l5MYfycDoWo016AHW6/wjb6VKMtMwKgqboQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYPlVOxWxCussnXDCSecngnFSKdxg6mRnRM5YQQQesXe1pB8vUfpr70mNah+umelq3qC4G7i5Haj7bqQzRg0RISfHeh30wTlhhm2nIiZj6vUoEJ2RkOlUKYRFxVYKxwf+zkTWIbFwifsPCqhtSJ97EiOHcyCGteKP3o1BBvZUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D979C4CEC3;
	Fri, 18 Oct 2024 04:00:19 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH] LoongArch: Enable IRQ if do_ale() triggered in irq-enabled context
Date: Fri, 18 Oct 2024 11:59:58 +0800
Message-ID: <20241018035958.1060381-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unaligned access exception can be triggered in irq-enabled context such
as user mode, in this case do_ale() may call get_user() which may cause
sleep. Then we will get:

 BUG: sleeping function called from invalid context at arch/loongarch/kernel/access-helper.h:7
 in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 129, name: modprobe
 preempt_count: 0, expected: 0
 RCU nest depth: 0, expected: 0
 CPU: 0 UID: 0 PID: 129 Comm: modprobe Tainted: G        W          6.12.0-rc1+ #1723
 Tainted: [W]=WARN
 Stack : 9000000105e0bd48 0000000000000000 9000000003803944 9000000105e08000
         9000000105e0bc70 9000000105e0bc78 0000000000000000 0000000000000000
         9000000105e0bc78 0000000000000001 9000000185e0ba07 9000000105e0b890
         ffffffffffffffff 9000000105e0bc78 73924b81763be05b 9000000100194500
         000000000000020c 000000000000000a 0000000000000000 0000000000000003
         00000000000023f0 00000000000e1401 00000000072f8000 0000007ffbb0e260
         0000000000000000 0000000000000000 9000000005437650 90000000055d5000
         0000000000000000 0000000000000003 0000007ffbb0e1f0 0000000000000000
         0000005567b00490 0000000000000000 9000000003803964 0000007ffbb0dfec
         00000000000000b0 0000000000000007 0000000000000003 0000000000071c1d
         ...
 Call Trace:
 [<9000000003803964>] show_stack+0x64/0x1a0
 [<9000000004c57464>] dump_stack_lvl+0x74/0xb0
 [<9000000003861ab4>] __might_resched+0x154/0x1a0
 [<900000000380c96c>] emulate_load_store_insn+0x6c/0xf60
 [<9000000004c58118>] do_ale+0x78/0x180
 [<9000000003801bc8>] handle_ale+0x128/0x1e0

So enable IRQ if unaligned access exception is triggered in irq-enabled
context to fix it.

Cc: stable@vger.kernel.org
Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/traps.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index f9f4eb00c92e..c57b4134f3e8 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -555,6 +555,9 @@ asmlinkage void noinstr do_ale(struct pt_regs *regs)
 #else
 	unsigned int *pc;
 
+	if (regs->csr_prmd & CSR_PRMD_PIE)
+		local_irq_enable();
+
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, regs->csr_badvaddr);
 
 	/*
@@ -579,6 +582,8 @@ asmlinkage void noinstr do_ale(struct pt_regs *regs)
 	die_if_kernel("Kernel ale access", regs);
 	force_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)regs->csr_badvaddr);
 out:
+	if (regs->csr_prmd & CSR_PRMD_PIE)
+		local_irq_disable();
 #endif
 	irqentry_exit(regs, state);
 }
-- 
2.43.5


