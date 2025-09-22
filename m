Return-Path: <stable+bounces-181332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE5FB930AD
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E8D2A74F6
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACB2F3C23;
	Mon, 22 Sep 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HuZKcq3B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892A2F1FE3;
	Mon, 22 Sep 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570275; cv=none; b=fqVrN04z+ncxcQxCBmtBR8OPAfYLXRoyGPO8gCYFb9kKXQPjKjKVTGzcpIdroyRPTNpxm0feJJ7lTId++nSlW1LFAY4gqdkCNrEpG/A3tq1yFiAPmN2EqulHtfQKkOkt8eYAhIlvweem83OPFtf3KYA2O3nZSDKgenX/sWs5+W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570275; c=relaxed/simple;
	bh=OtfqAJ00uK+ouLD518GyRXh8dA02PbWugBxDhnreusI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmGH1tecT+n2ysL+TCgqw+aBTR4tZ+3u/o34/71VWsreVQl0PUlxpESiRD7PLg7/VebgaJJ05KyuMSNpTtK1ZQG/AAylGhkqwrrsnVRAHKMZuLi9aTbTtLbD8bVbnKl3437V1o0bw5y+FJ4L4WShAnM4hGqgLsGXb1CjVlf/ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HuZKcq3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68450C4CEF0;
	Mon, 22 Sep 2025 19:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570274;
	bh=OtfqAJ00uK+ouLD518GyRXh8dA02PbWugBxDhnreusI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HuZKcq3BT9PbaVs/cBq67aGHDpAq9v70ftmsITfikcxKcQs7nhuNLbXkiGB+MGHG+
	 ZZpax9K/GiHF/ZAfcnXASzbPkE18xMXOp9oMbUpo4nnYb+qY0muCnd8Jpqz8fxVoUz
	 SFIwKrv9hzoMveNSHXhP5bKVNUCdJYORWsnQ32lk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.16 073/149] LoongArch: KVM: Avoid copy_*_user() with lock hold in kvm_eiointc_ctrl_access()
Date: Mon, 22 Sep 2025 21:29:33 +0200
Message-ID: <20250922192414.723234811@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bibo Mao <maobibo@loongson.cn>

commit 47256c4c8b1bfbc63223a0da2d4fa90b6ede5cbb upstream.

Function copy_from_user() and copy_to_user() may sleep because of page
fault, and they cannot be called in spin_lock hold context. Here move
function calling of copy_from_user() and copy_to_user() before spinlock
context in function kvm_eiointc_ctrl_access().

Otherwise there will be possible warning such as:

BUG: sleeping function called from invalid context at include/linux/uaccess.h:192
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6292, name: qemu-system-loo
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<0000000000000000>] 0x0
hardirqs last disabled at (0): [<9000000004c4a554>] copy_process+0x90c/0x1d40
softirqs last  enabled at (0): [<9000000004c4a554>] copy_process+0x90c/0x1d40
softirqs last disabled at (0): [<0000000000000000>] 0x0
CPU: 41 UID: 0 PID: 6292 Comm: qemu-system-loo Tainted: G W 6.17.0-rc3+ #31 PREEMPT(full)
Tainted: [W]=WARN
Stack : 0000000000000076 0000000000000000 9000000004c28264 9000100092ff4000
        9000100092ff7b80 9000100092ff7b88 0000000000000000 9000100092ff7cc8
        9000100092ff7cc0 9000100092ff7cc0 9000100092ff7a00 0000000000000001
        0000000000000001 9000100092ff7b88 947d2f9216a5e8b9 900010008773d880
        00000000ffff8b9f fffffffffffffffe 0000000000000ba1 fffffffffffffffe
        000000000000003e 900000000825a15b 000010007ad38000 9000100092ff7ec0
        0000000000000000 0000000000000000 9000000006f3ac60 9000000007252000
        0000000000000000 00007ff746ff2230 0000000000000053 9000200088a021b0
        0000555556c9d190 0000000000000000 9000000004c2827c 000055556cfb5f40
        00000000000000b0 0000000000000007 0000000000000007 0000000000071c1d
Call Trace:
[<9000000004c2827c>] show_stack+0x5c/0x180
[<9000000004c20fac>] dump_stack_lvl+0x94/0xe4
[<9000000004c99c7c>] __might_resched+0x26c/0x290
[<9000000004f68968>] __might_fault+0x20/0x88
[<ffff800002311de0>] kvm_eiointc_ctrl_access.isra.0+0x88/0x380 [kvm]
[<ffff8000022f8514>] kvm_device_ioctl+0x194/0x290 [kvm]
[<900000000506b0d8>] sys_ioctl+0x388/0x1010
[<90000000063ed210>] do_syscall+0xb0/0x2d8
[<9000000004c25ef8>] handle_syscall+0xb8/0x158

Cc: stable@vger.kernel.org
Fixes: 1ad7efa552fd5 ("LoongArch: KVM: Add EIOINTC user mode read and write functions")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kvm/intc/eiointc.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/arch/loongarch/kvm/intc/eiointc.c
+++ b/arch/loongarch/kvm/intc/eiointc.c
@@ -810,21 +810,26 @@ static int kvm_eiointc_ctrl_access(struc
 	struct loongarch_eiointc *s = dev->kvm->arch.eiointc;
 
 	data = (void __user *)attr->addr;
-	spin_lock_irqsave(&s->lock, flags);
 	switch (type) {
 	case KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_NUM_CPU:
+	case KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_FEATURE:
 		if (copy_from_user(&val, data, 4))
-			ret = -EFAULT;
-		else {
-			if (val >= EIOINTC_ROUTE_MAX_VCPUS)
-				ret = -EINVAL;
-			else
-				s->num_cpu = val;
-		}
+			return -EFAULT;
+		break;
+	default:
+		break;
+	}
+
+	spin_lock_irqsave(&s->lock, flags);
+	switch (type) {
+	case KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_NUM_CPU:
+		if (val >= EIOINTC_ROUTE_MAX_VCPUS)
+			ret = -EINVAL;
+		else
+			s->num_cpu = val;
 		break;
 	case KVM_DEV_LOONGARCH_EXTIOI_CTRL_INIT_FEATURE:
-		if (copy_from_user(&s->features, data, 4))
-			ret = -EFAULT;
+		s->features = val;
 		if (!(s->features & BIT(EIOINTC_HAS_VIRT_EXTENSION)))
 			s->status |= BIT(EIOINTC_ENABLE);
 		break;



