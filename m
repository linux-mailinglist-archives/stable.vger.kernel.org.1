Return-Path: <stable+bounces-134850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CD2A95278
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A311894951
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBF26F31E;
	Mon, 21 Apr 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iqalFhPH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90A2A1BF
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244489; cv=none; b=uVmwL+9qP539Trk9EpJuTGbukawX5eY6gkXruT7eBKmxX/Nea7g6+1o9aZ1dkyw9DJc/DZAzzS0Kfkwy/OhLvbSp6mI9MyAEGEBSS2WPcBQC7FW3zOUyX5GBm6xpGgaoawjvn7/WZN0IAAcfhirIExJ8ousFumO7I5zcPSnwem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244489; c=relaxed/simple;
	bh=Vfnv02550F4EBS3Xp0UdQr1jlfnSyrnurfOdWVQQ1GA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M1KBUAuHmt8LlqWhnBRjufsDV/49adVF4PRio++9DWoFrC2QElbYrYXZsxnOWipd/3jMMVOarsvDdzQ8jWeTaH6Q0ZaWTCERlfYV4xI4YnW4hgt2CNOvDBWiKpUluSEQ5nJNTkYcdyaV+RM0yE4fxs2hRkYGXW9t6Y7oWkCLJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iqalFhPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B566EC4CEE4;
	Mon, 21 Apr 2025 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244489;
	bh=Vfnv02550F4EBS3Xp0UdQr1jlfnSyrnurfOdWVQQ1GA=;
	h=Subject:To:Cc:From:Date:From;
	b=iqalFhPHb9BsnLY5USSAIYBE48KFP9H67ILk8R9G3OnBVvRCSN5ecV+NHVcYT2y5e
	 ubSnbKnrBcwveGQEu7M8ypZiJoiMeDse9oJfQpvWONz76X0bPRxCJ/dDYjmEvZSbqQ
	 ZjryZKkcekG9rDdj2ql6XyAgRTLFg9Pv+KOZ7RXY=
Subject: FAILED: patch "[PATCH] net/niu: Niu requires MSIX ENTRY_DATA fields touch before" failed to apply to 6.12-stable tree
To: dullfire@yahoo.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:08:04 +0200
Message-ID: <2025042104-sabotage-vividly-1c95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x fbb429ddff5c8e479edcc7dde5a542c9295944e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042104-sabotage-vividly-1c95@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fbb429ddff5c8e479edcc7dde5a542c9295944e6 Mon Sep 17 00:00:00 2001
From: Jonathan Currier <dullfire@yahoo.com>
Date: Sun, 17 Nov 2024 17:48:43 -0600
Subject: [PATCH] net/niu: Niu requires MSIX ENTRY_DATA fields touch before
 entry reads

Fix niu_try_msix() to not cause a fatal trap on sparc systems.

Set PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST on the struct pci_dev to
work around a bug in the hardware or firmware.

For each vector entry in the msix table, niu chips will cause a fatal
trap if any registers in that entry are read before that entries'
ENTRY_DATA register is written to. Testing indicates writes to other
registers are not sufficient to prevent the fatal trap, however the value
does not appear to matter. This only needs to happen once after power up,
so simply rebooting into a kernel lacking this fix will NOT cause the
trap.

NON-RESUMABLE ERROR: Reporting on cpu 64
NON-RESUMABLE ERROR: TPC [0x00000000005f6900] <msix_prepare_msi_desc+0x90/0xa0>
NON-RESUMABLE ERROR: RAW [4010000000000016:00000e37f93e32ff:0000000202000080:ffffffffffffffff
NON-RESUMABLE ERROR:      0000000800000000:0000000000000000:0000000000000000:0000000000000000]
NON-RESUMABLE ERROR: handle [0x4010000000000016] stick [0x00000e37f93e32ff]
NON-RESUMABLE ERROR: type [precise nonresumable]
NON-RESUMABLE ERROR: attrs [0x02000080] < ASI sp-faulted priv >
NON-RESUMABLE ERROR: raddr [0xffffffffffffffff]
NON-RESUMABLE ERROR: insn effective address [0x000000c50020000c]
NON-RESUMABLE ERROR: size [0x8]
NON-RESUMABLE ERROR: asi [0x00]
CPU: 64 UID: 0 PID: 745 Comm: kworker/64:1 Not tainted 6.11.5 #63
Workqueue: events work_for_cpu_fn
TSTATE: 0000000011001602 TPC: 00000000005f6900 TNPC: 00000000005f6904 Y: 00000000    Not tainted
TPC: <msix_prepare_msi_desc+0x90/0xa0>
g0: 00000000000002e9 g1: 000000000000000c g2: 000000c50020000c g3: 0000000000000100
g4: ffff8000470307c0 g5: ffff800fec5be000 g6: ffff800047a08000 g7: 0000000000000000
o0: ffff800014feb000 o1: ffff800047a0b620 o2: 0000000000000011 o3: ffff800047a0b620
o4: 0000000000000080 o5: 0000000000000011 sp: ffff800047a0ad51 ret_pc: 00000000005f7128
RPC: <__pci_enable_msix_range+0x3cc/0x460>
l0: 000000000000000d l1: 000000000000c01f l2: ffff800014feb0a8 l3: 0000000000000020
l4: 000000000000c000 l5: 0000000000000001 l6: 0000000020000000 l7: ffff800047a0b734
i0: ffff800014feb000 i1: ffff800047a0b730 i2: 0000000000000001 i3: 000000000000000d
i4: 0000000000000000 i5: 0000000000000000 i6: ffff800047a0ae81 i7: 00000000101888b0
I7: <niu_try_msix.constprop.0+0xc0/0x130 [niu]>
Call Trace:
[<00000000101888b0>] niu_try_msix.constprop.0+0xc0/0x130 [niu]
[<000000001018f840>] niu_get_invariants+0x183c/0x207c [niu]
[<00000000101902fc>] niu_pci_init_one+0x27c/0x2fc [niu]
[<00000000005ef3e4>] local_pci_probe+0x28/0x74
[<0000000000469240>] work_for_cpu_fn+0x8/0x1c
[<000000000046b008>] process_scheduled_works+0x144/0x210
[<000000000046b518>] worker_thread+0x13c/0x1c0
[<00000000004710e0>] kthread+0xb8/0xc8
[<00000000004060c8>] ret_from_fork+0x1c/0x2c
[<0000000000000000>] 0x0
Kernel panic - not syncing: Non-resumable error.

Fixes: 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
Signed-off-by: Jonathan Currier <dullfire@yahoo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241117234843.19236-3-dullfire@yahoo.com

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 73c07f10f053..379b6e90121d 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9064,6 +9064,8 @@ static void niu_try_msix(struct niu *np, u8 *ldg_num_map)
 		msi_vec[i].entry = i;
 	}
 
+	pdev->dev_flags |= PCI_DEV_FLAGS_MSIX_TOUCH_ENTRY_DATA_FIRST;
+
 	num_irqs = pci_enable_msix_range(pdev, msi_vec, 1, num_irqs);
 	if (num_irqs < 0) {
 		np->flags &= ~NIU_FLAGS_MSIX;


