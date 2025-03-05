Return-Path: <stable+bounces-120602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19462A50795
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13407A9A2A
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80675250C1D;
	Wed,  5 Mar 2025 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QbO/WmeP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5225179E;
	Wed,  5 Mar 2025 17:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741197436; cv=none; b=oi8JMYHAV9Am/LqV6zH3wPg9F7PrDIRGBPJumh0xYRbAfNR+2ufeL26LJdQxPCnXMe8IqUSNPcABmApIv+uGIqrCJS+BKS/Lq0aoSnI1TSevl1JUUcr7CAfdhh0CFFbeQ99cPoJczRCjHDEO3JYmPNiNBtKPJZBJNq36XF62oiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741197436; c=relaxed/simple;
	bh=2AUyZfb+0HbaiiZnkUdir0Ho36jq2ZeLp/hR+gwl3IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKW66P9rnhu1hoQePyDD5fnAR+LkGpvAtoikHi9xF5yP5qrMvlodbA0IUXe6Oia98xDKT1ZE6tP6G4NWMGWgTPkao+aw3ZnN01wUt+hPpkB3cUbZ+uorLwxd5VbRCuAI/OdY87PIGa/QCLno6s/fv7h70PTOAsOZOG+afFlRbDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QbO/WmeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CC3C4CEE0;
	Wed,  5 Mar 2025 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741197436;
	bh=2AUyZfb+0HbaiiZnkUdir0Ho36jq2ZeLp/hR+gwl3IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbO/WmePcDktodsyrC0rUm5wcvxN2y43bpv8vbGdR13Xs6bTq+MkLGCwbbmtBcQz0
	 x6Md1w3buPrVMfRVSaM9fFZV5yIyMCZFTfjfldfiRLaHw2c6rlA4YJ72khMGnjC3/3
	 IFBZkY4uHzp0jvdiK+LRGB/NVYnHfUCJfzQTX9MA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tyrone Ting <kfting@nuvoton.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.1 155/176] i2c: npcm: disable interrupt enable bit before devm_request_irq
Date: Wed,  5 Mar 2025 18:48:44 +0100
Message-ID: <20250305174511.662543033@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
References: <20250305174505.437358097@linuxfoundation.org>
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

From: Tyrone Ting <kfting@nuvoton.com>

commit dd1998e243f5fa25d348a384ba0b6c84d980f2b2 upstream.

The customer reports that there is a soft lockup issue related to
the i2c driver. After checking, the i2c module was doing a tx transfer
and the bmc machine reboots in the middle of the i2c transaction, the i2c
module keeps the status without being reset.

Due to such an i2c module status, the i2c irq handler keeps getting
triggered since the i2c irq handler is registered in the kernel booting
process after the bmc machine is doing a warm rebooting.
The continuous triggering is stopped by the soft lockup watchdog timer.

Disable the interrupt enable bit in the i2c module before calling
devm_request_irq to fix this issue since the i2c relative status bit
is read-only.

Here is the soft lockup log.
[   28.176395] watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [swapper/0:1]
[   28.183351] Modules linked in:
[   28.186407] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.15.120-yocto-s-dirty-bbebc78 #1
[   28.201174] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   28.208128] pc : __do_softirq+0xb0/0x368
[   28.212055] lr : __do_softirq+0x70/0x368
[   28.215972] sp : ffffff8035ebca00
[   28.219278] x29: ffffff8035ebca00 x28: 0000000000000002 x27: ffffff80071a3780
[   28.226412] x26: ffffffc008bdc000 x25: ffffffc008bcc640 x24: ffffffc008be50c0
[   28.233546] x23: ffffffc00800200c x22: 0000000000000000 x21: 000000000000001b
[   28.240679] x20: 0000000000000000 x19: ffffff80001c3200 x18: ffffffffffffffff
[   28.247812] x17: ffffffc02d2e0000 x16: ffffff8035eb8b40 x15: 00001e8480000000
[   28.254945] x14: 02c3647e37dbfcb6 x13: 02c364f2ab14200c x12: 0000000002c364f2
[   28.262078] x11: 00000000fa83b2da x10: 000000000000b67e x9 : ffffffc008010250
[   28.269211] x8 : 000000009d983d00 x7 : 7fffffffffffffff x6 : 0000036d74732434
[   28.276344] x5 : 00ffffffffffffff x4 : 0000000000000015 x3 : 0000000000000198
[   28.283476] x2 : ffffffc02d2e0000 x1 : 00000000000000e0 x0 : ffffffc008bdcb40
[   28.290611] Call trace:
[   28.293052]  __do_softirq+0xb0/0x368
[   28.296625]  __irq_exit_rcu+0xe0/0x100
[   28.300374]  irq_exit+0x14/0x20
[   28.303513]  handle_domain_irq+0x68/0x90
[   28.307440]  gic_handle_irq+0x78/0xb0
[   28.311098]  call_on_irq_stack+0x20/0x38
[   28.315019]  do_interrupt_handler+0x54/0x5c
[   28.319199]  el1_interrupt+0x2c/0x4c
[   28.322777]  el1h_64_irq_handler+0x14/0x20
[   28.326872]  el1h_64_irq+0x74/0x78
[   28.330269]  __setup_irq+0x454/0x780
[   28.333841]  request_threaded_irq+0xd0/0x1b4
[   28.338107]  devm_request_threaded_irq+0x84/0x100
[   28.342809]  npcm_i2c_probe_bus+0x188/0x3d0
[   28.346990]  platform_probe+0x6c/0xc4
[   28.350653]  really_probe+0xcc/0x45c
[   28.354227]  __driver_probe_device+0x8c/0x160
[   28.358578]  driver_probe_device+0x44/0xe0
[   28.362670]  __driver_attach+0x124/0x1d0
[   28.366589]  bus_for_each_dev+0x7c/0xe0
[   28.370426]  driver_attach+0x28/0x30
[   28.373997]  bus_add_driver+0x124/0x240
[   28.377830]  driver_register+0x7c/0x124
[   28.381662]  __platform_driver_register+0x2c/0x34
[   28.386362]  npcm_i2c_init+0x3c/0x5c
[   28.389937]  do_one_initcall+0x74/0x230
[   28.393768]  kernel_init_freeable+0x24c/0x2b4
[   28.398126]  kernel_init+0x28/0x130
[   28.401614]  ret_from_fork+0x10/0x20
[   28.405189] Kernel panic - not syncing: softlockup: hung tasks
[   28.411011] SMP: stopping secondary CPUs
[   28.414933] Kernel Offset: disabled
[   28.418412] CPU features: 0x00000000,00000802
[   28.427644] Rebooting in 20 seconds..

Fixes: 56a1485b102e ("i2c: npcm7xx: Add Nuvoton NPCM I2C controller driver")
Signed-off-by: Tyrone Ting <kfting@nuvoton.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Tali Perry <tali.perry1@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20250220040029.27596-2-kfting@nuvoton.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-npcm7xx.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -2335,6 +2335,13 @@ static int npcm_i2c_probe_bus(struct pla
 	if (irq < 0)
 		return irq;
 
+	/*
+	 * Disable the interrupt to avoid the interrupt handler being triggered
+	 * incorrectly by the asynchronous interrupt status since the machine
+	 * might do a warm reset during the last smbus/i2c transfer session.
+	 */
+	npcm_i2c_int_enable(bus, false);
+
 	ret = devm_request_irq(bus->dev, irq, npcm_i2c_bus_irq, 0,
 			       dev_name(bus->dev), bus);
 	if (ret)



