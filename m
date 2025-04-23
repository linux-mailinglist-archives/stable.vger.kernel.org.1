Return-Path: <stable+bounces-135806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6921EA990C3
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B061BA1B16
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4448E284B4B;
	Wed, 23 Apr 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZmKKASRv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F398C284698;
	Wed, 23 Apr 2025 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420893; cv=none; b=jvASOjKbWRJ420lqFY2WL0TTFkQyklIo11kRXw5DzJ2eSZQWZC6LxaZm7lAaj4RoDQrm8djjLEJpga94KJ0NVJDfeq5rX77K/CEQniVq2LwxREr5Og1mFsdF8CHfrrtEfH+BRly9faAZc4YBfCYfJbVa0s3wxPbNGXuBdIQeYKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420893; c=relaxed/simple;
	bh=vXtCxqga/G+2aumls3cfw23AwTP1ZRdKD+Y6nVaBi4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOkoWP1yHnnNmRFUwiwBCPrOcbzk2OX/7LKhbs1NkJW0+az7mE7Frj7vSbc00FetyJsqUhUSKFVFbK5JioOd8t/1vW6lGiU1uOe7LcOkPkESYxx/STtVdllI4eQNv4GfA3Ehuo2x1E+U8+7uNVN2nlgvVim6NQwtAoPILthMr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZmKKASRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279F9C4CEE2;
	Wed, 23 Apr 2025 15:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420892;
	bh=vXtCxqga/G+2aumls3cfw23AwTP1ZRdKD+Y6nVaBi4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmKKASRvW8Gxgpnpr5cz5qFBpNv4MR1mI/uWXyfVkydDxLFj2yr2chCfwGQ3hpQtu
	 UAhJEpKwjlKC+tR9MA4+p3G6MhTpVK85/HrNA5A63Lg6lruOR9/c//o4bkT726HNc8
	 0VnouWws0yv+a6/YsgFyPBI2izD6v0NKEF4vKDJk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.1 090/291] mtd: rawnand: brcmnand: fix PM resume warning
Date: Wed, 23 Apr 2025 16:41:19 +0200
Message-ID: <20250423142628.036342637@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamal Dasu <kamal.dasu@broadcom.com>

commit ddc210cf8b8a8be68051ad958bf3e2cef6b681c2 upstream.

Fixed warning on PM resume as shown below caused due to uninitialized
struct nand_operation that checks chip select field :
WARN_ON(op->cs >= nanddev_ntargets(&chip->base)

[   14.588522] ------------[ cut here ]------------
[   14.588529] WARNING: CPU: 0 PID: 1392 at drivers/mtd/nand/raw/internals.h:139 nand_reset_op+0x1e0/0x1f8
[   14.588553] Modules linked in: bdc udc_core
[   14.588579] CPU: 0 UID: 0 PID: 1392 Comm: rtcwake Tainted: G        W          6.14.0-rc4-g5394eea10651 #16
[   14.588590] Tainted: [W]=WARN
[   14.588593] Hardware name: Broadcom STB (Flattened Device Tree)
[   14.588598] Call trace:
[   14.588604]  dump_backtrace from show_stack+0x18/0x1c
[   14.588622]  r7:00000009 r6:0000008b r5:60000153 r4:c0fa558c
[   14.588625]  show_stack from dump_stack_lvl+0x70/0x7c
[   14.588639]  dump_stack_lvl from dump_stack+0x18/0x1c
[   14.588653]  r5:c08d40b0 r4:c1003cb0
[   14.588656]  dump_stack from __warn+0x84/0xe4
[   14.588668]  __warn from warn_slowpath_fmt+0x18c/0x194
[   14.588678]  r7:c08d40b0 r6:c1003cb0 r5:00000000 r4:00000000
[   14.588681]  warn_slowpath_fmt from nand_reset_op+0x1e0/0x1f8
[   14.588695]  r8:70c40dff r7:89705f41 r6:36b4a597 r5:c26c9444 r4:c26b0048
[   14.588697]  nand_reset_op from brcmnand_resume+0x13c/0x150
[   14.588714]  r9:00000000 r8:00000000 r7:c24f8010 r6:c228a3f8 r5:c26c94bc r4:c26b0040
[   14.588717]  brcmnand_resume from platform_pm_resume+0x34/0x54
[   14.588735]  r5:00000010 r4:c0840a50
[   14.588738]  platform_pm_resume from dpm_run_callback+0x5c/0x14c
[   14.588757]  dpm_run_callback from device_resume+0xc0/0x324
[   14.588776]  r9:c24f8054 r8:c24f80a0 r7:00000000 r6:00000000 r5:00000010 r4:c24f8010
[   14.588779]  device_resume from dpm_resume+0x130/0x160
[   14.588799]  r9:c22539e4 r8:00000010 r7:c22bebb0 r6:c24f8010 r5:c22539dc r4:c22539b0
[   14.588802]  dpm_resume from dpm_resume_end+0x14/0x20
[   14.588822]  r10:c2204e40 r9:00000000 r8:c228a3fc r7:00000000 r6:00000003 r5:c228a414
[   14.588826]  r4:00000010
[   14.588828]  dpm_resume_end from suspend_devices_and_enter+0x274/0x6f8
[   14.588848]  r5:c228a414 r4:00000000
[   14.588851]  suspend_devices_and_enter from pm_suspend+0x228/0x2bc
[   14.588868]  r10:c3502910 r9:c3501f40 r8:00000004 r7:c228a438 r6:c0f95e18 r5:00000000
[   14.588871]  r4:00000003
[   14.588874]  pm_suspend from state_store+0x74/0xd0
[   14.588889]  r7:c228a438 r6:c0f934c8 r5:00000003 r4:00000003
[   14.588892]  state_store from kobj_attr_store+0x1c/0x28
[   14.588913]  r9:00000000 r8:00000000 r7:f09f9f08 r6:00000004 r5:c3502900 r4:c0283250
[   14.588916]  kobj_attr_store from sysfs_kf_write+0x40/0x4c
[   14.588936]  r5:c3502900 r4:c0d92a48
[   14.588939]  sysfs_kf_write from kernfs_fop_write_iter+0x104/0x1f0
[   14.588956]  r5:c3502900 r4:c3501f40
[   14.588960]  kernfs_fop_write_iter from vfs_write+0x250/0x420
[   14.588980]  r10:c0e14b48 r9:00000000 r8:c25f5780 r7:00443398 r6:f09f9f68 r5:c34f7f00
[   14.588983]  r4:c042a88c
[   14.588987]  vfs_write from ksys_write+0x74/0xe4
[   14.589005]  r10:00000004 r9:c25f5780 r8:c02002fA0 r7:00000000 r6:00000000 r5:c34f7f00
[   14.589008]  r4:c34f7f00
[   14.589011]  ksys_write from sys_write+0x10/0x14
[   14.589029]  r7:00000004 r6:004421c0 r5:00443398 r4:00000004
[   14.589032]  sys_write from ret_fast_syscall+0x0/0x5c
[   14.589044] Exception stack(0xf09f9fa8 to 0xf09f9ff0)
[   14.589050] 9fa0:                   00000004 00443398 00000004 00443398 00000004 00000001
[   14.589056] 9fc0: 00000004 00443398 004421c0 00000004 b6ecbd58 00000008 bebfbc38 0043eb78
[   14.589062] 9fe0: 00440eb0 bebfbaf8 b6de18a0 b6e579e8
[   14.589065] ---[ end trace 0000000000000000 ]---

The fix uses the higher level nand_reset(chip, chipnr); where chipnr = 0, when
doing PM resume operation in compliance with the controller support for single
die nand chip. Switching from nand_reset_op() to nand_reset() implies more
than just setting the cs field op->cs, it also reconfigures the data interface
(ie. the timings). Tested and confirmed the NAND chip is in sync timing wise
with host after the fix.

Fixes: 97d90da8a886 ("mtd: nand: provide several helpers to do common NAND operations")
Cc: stable@vger.kernel.org
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2968,7 +2968,7 @@ static int brcmnand_resume(struct device
 		brcmnand_save_restore_cs_config(host, 1);
 
 		/* Reset the chip, required by some chips after power-up */
-		nand_reset_op(chip);
+		nand_reset(chip, 0);
 	}
 
 	return 0;



