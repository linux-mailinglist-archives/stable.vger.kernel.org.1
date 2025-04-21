Return-Path: <stable+bounces-134853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2285A9527B
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 16:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7703AC7E9
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 14:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1485B55897;
	Mon, 21 Apr 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8eLrFK2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D734545
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745244503; cv=none; b=g3SO95rwXW9qrPZYNjNyI/2KCixct7yS8vE+a73MzUn2o9p6IA+RckhvwX8YD95+IeO09Eo/t47HgSMjDa4JdvB95W2qKRQUFuD27JSBexbPi85Jh/oe0DFiRSOc1VUzcNCLvoJsqo7E1Qcfisc+X31QgDUfrO4w06gh3BbbTY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745244503; c=relaxed/simple;
	bh=7CTK+ZAoF6IIiUlPEvwtUKENnaXYACvgpCzSI7J2LFU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FGcUM+YES2Wt8zeCZ9UZh7nAZhb4u6/v0yOktoRRLJwmoj3jmhndMr8nh+0u7IXKx9njSLdO1qyvb6IYFlq8PG+xGDirQfZKyQHW2rgCxubTBrV+Odl8NAyQv4+qDbMLm8pbz+XjRUPP9Z/cRk7wCGaiEWEOaKgGpZKgyLqbkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8eLrFK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4433C4CEE4;
	Mon, 21 Apr 2025 14:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745244503;
	bh=7CTK+ZAoF6IIiUlPEvwtUKENnaXYACvgpCzSI7J2LFU=;
	h=Subject:To:Cc:From:Date:From;
	b=N8eLrFK2BrVZj1l/JpekGJgNoyAaLqvl18URnbzIdY1tnlDNm1hpwwWfMW4dwGaM/
	 8f/OKrUtM7hEmYLGEKHYYm5etpriMV5LugPMHklW6C7++7Cr85T+P8gpjwijCVQFUk
	 3SWQ5HXvRcBiEJD7OSzgfRKgENBacxjLGx7xEbaU=
Subject: FAILED: patch "[PATCH] net/niu: Niu requires MSIX ENTRY_DATA fields touch before" failed to apply to 5.15-stable tree
To: dullfire@yahoo.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 16:08:07 +0200
Message-ID: <2025042107-kinship-yin-a982@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fbb429ddff5c8e479edcc7dde5a542c9295944e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042107-kinship-yin-a982@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


