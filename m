Return-Path: <stable+bounces-130671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43502A805BC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8834A766F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED8E26A1D4;
	Tue,  8 Apr 2025 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oAYcEec0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC83268C4F;
	Tue,  8 Apr 2025 12:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114338; cv=none; b=Im/Owgr9vEGJ0ETrWTLYZeDyizLOlrc+SnjWdOWoMx1Kd4q420MsAsVBka7JyXJBIUkrXqP1Uaddw0liNWxmYY+Nxrm9ez77a0NVWF0psnKwncNUNoNqJR8zDHZGuBau9bqsHKzOrqfXvl+V+iza41PBeY/ag2c3CeP5xyKXVFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114338; c=relaxed/simple;
	bh=foSV95x2JuDOgY7XkOUNberfQ6ewirfYvkFF+/G4taU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWEBPZZKMXk9MogPHaRVvyJ8P/cncYJtI4tQiScicO03mc5REQ19IQBdZrCKWuLq38+x1Y8mr/pbBZ8jZK5LC3JJbXvGv5NxnL3kdAp8CL+MEjKskQAIgNeGFJ3G+9tGSyBPXYmvBI+Pen83zNSXdBt8piApSXYXm29VwRxFCec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oAYcEec0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B0FC4CEE5;
	Tue,  8 Apr 2025 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114337;
	bh=foSV95x2JuDOgY7XkOUNberfQ6ewirfYvkFF+/G4taU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAYcEec05ZnsT7onWoMTp7QMFLOMMp605sd7KjHZ31SP9TBmI1j3udO60mNOxQuJe
	 zbvtoJnBGNUu/PbmL2AYuiw0R8yAgwVWneax87wFdpFkHykuC3nLxMpi/j2omtBY9e
	 MLIWjhSBW/6x4AHRPZxRniLHY2rBKEkDSQq4Kjxc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 042/499] RISC-V: KVM: Teardown riscv specific bits after kvm_exit
Date: Tue,  8 Apr 2025 12:44:14 +0200
Message-ID: <20250408104852.295641919@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Atish Patra <atishp@rivosinc.com>

[ Upstream commit 2d117e67f318303f6ab699a5511d1fac3f170545 ]

During a module removal, kvm_exit invokes arch specific disable
call which disables AIA. However, we invoke aia_exit before kvm_exit
resulting in the following warning. KVM kernel module can't be inserted
afterwards due to inconsistent state of IRQ.

[25469.031389] percpu IRQ 31 still enabled on CPU0!
[25469.031732] WARNING: CPU: 3 PID: 943 at kernel/irq/manage.c:2476 __free_percpu_irq+0xa2/0x150
[25469.031804] Modules linked in: kvm(-)
[25469.031848] CPU: 3 UID: 0 PID: 943 Comm: rmmod Not tainted 6.14.0-rc5-06947-g91c763118f47-dirty #2
[25469.031905] Hardware name: riscv-virtio,qemu (DT)
[25469.031928] epc : __free_percpu_irq+0xa2/0x150
[25469.031976]  ra : __free_percpu_irq+0xa2/0x150
[25469.032197] epc : ffffffff8007db1e ra : ffffffff8007db1e sp : ff2000000088bd50
[25469.032241]  gp : ffffffff8131cef8 tp : ff60000080b96400 t0 : ff2000000088baf8
[25469.032285]  t1 : fffffffffffffffc t2 : 5249207570637265 s0 : ff2000000088bd90
[25469.032329]  s1 : ff60000098b21080 a0 : 037d527a15eb4f00 a1 : 037d527a15eb4f00
[25469.032372]  a2 : 0000000000000023 a3 : 0000000000000001 a4 : ffffffff8122dbf8
[25469.032410]  a5 : 0000000000000fff a6 : 0000000000000000 a7 : ffffffff8122dc10
[25469.032448]  s2 : ff60000080c22eb0 s3 : 0000000200000022 s4 : 000000000000001f
[25469.032488]  s5 : ff60000080c22e00 s6 : ffffffff80c351c0 s7 : 0000000000000000
[25469.032582]  s8 : 0000000000000003 s9 : 000055556b7fb490 s10: 00007ffff0e12fa0
[25469.032621]  s11: 00007ffff0e13e9a t3 : ffffffff81354ac7 t4 : ffffffff81354ac7
[25469.032664]  t5 : ffffffff81354ac8 t6 : ffffffff81354ac7
[25469.032698] status: 0000000200000100 badaddr: ffffffff8007db1e cause: 0000000000000003
[25469.032738] [<ffffffff8007db1e>] __free_percpu_irq+0xa2/0x150
[25469.032797] [<ffffffff8007dbfc>] free_percpu_irq+0x30/0x5e
[25469.032856] [<ffffffff013a57dc>] kvm_riscv_aia_exit+0x40/0x42 [kvm]
[25469.033947] [<ffffffff013b4e82>] cleanup_module+0x10/0x32 [kvm]
[25469.035300] [<ffffffff8009b150>] __riscv_sys_delete_module+0x18e/0x1fc
[25469.035374] [<ffffffff8000c1ca>] syscall_handler+0x3a/0x46
[25469.035456] [<ffffffff809ec9a4>] do_trap_ecall_u+0x72/0x134
[25469.035536] [<ffffffff809f5e18>] handle_exception+0x148/0x156

Invoke aia_exit and other arch specific cleanup functions after kvm_exit
so that disable gets a chance to be called first before exit.

Fixes: 54e43320c2ba ("RISC-V: KVM: Initial skeletal support for AIA")
Fixes: eded6754f398 ("riscv: KVM: add basic support for host vs guest profiling")
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20250317-kvm_exit_fix-v1-1-aa5240c5dbd2@rivosinc.com
Signed-off-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kvm/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 1fa8be5ee5097..4b24705dc63a9 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -172,8 +172,8 @@ module_init(riscv_kvm_init);
 
 static void __exit riscv_kvm_exit(void)
 {
-	kvm_riscv_teardown();
-
 	kvm_exit();
+
+	kvm_riscv_teardown();
 }
 module_exit(riscv_kvm_exit);
-- 
2.39.5




