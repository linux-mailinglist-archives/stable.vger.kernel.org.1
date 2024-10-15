Return-Path: <stable+bounces-85498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9FD99E793
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0809A1C203D7
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B921D90CD;
	Tue, 15 Oct 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UITTx9qB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112561D89F5;
	Tue, 15 Oct 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993318; cv=none; b=Q05VY98FNOgyeQOCySiLKy9oafcRaJ0wWxu284r7ogDPuamUCUB3cJxpS1+ijplYCf+bXx6PXpapYfKIxRqY6fs86snvKLbCpVjqzVicyP/ST2cl0n+tbbGwX5fVcxu1reKJnZtlGE0F9cydvlWoGWqgP03gs3zOWf3uOU/YLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993318; c=relaxed/simple;
	bh=K7QPzfqliaZxyvf1JDotmaV/d2FHDps8SDZjMileKIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aKqQKgFOqNq8G3VX5rxWfBllY7uOX1csvTz2zSrUHHeD/4XuzDMaHF/2d76ie/bpqk9Ov0C7fqCU4qy0kewaZSLRIC1SgrC76g8Y4sIjjwovdqfNmp4y/trIu2K+JdKDJfbBSCRY35Vc88jwBPHdMfy4l2Wrd22/RUIrBNOz2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UITTx9qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA52C4CEC6;
	Tue, 15 Oct 2024 11:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993317;
	bh=K7QPzfqliaZxyvf1JDotmaV/d2FHDps8SDZjMileKIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UITTx9qBTIJIBevBG/JP+vFFp41hxBvkQQ4iSsrGO1KhqQ1U/D7KVmM4CgVZfxJ9U
	 UQNwgnXPjMpuqKobV+8odkPj2yLLvdh9WtjMgqe6bMvBE4Zr9SkSz9cVs9QvFXhC+y
	 nAWWx90j60x7p61DVoCJuaOD2l0J56F/+WqLpvio=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Wahren <wahrenst@gmx.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 375/691] mailbox: bcm2835: Fix timeout during suspend mode
Date: Tue, 15 Oct 2024 13:25:23 +0200
Message-ID: <20241015112455.229627173@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit dc09f007caed3b2f6a3b6bd7e13777557ae22bfd ]

During noirq suspend phase the Raspberry Pi power driver suffer of
firmware property timeouts. The reason is that the IRQ of the underlying
BCM2835 mailbox is disabled and rpi_firmware_property_list() will always
run into a timeout [1].

Since the VideoCore side isn't consider as a wakeup source, set the
IRQF_NO_SUSPEND flag for the mailbox IRQ in order to keep it enabled
during suspend-resume cycle.

[1]
PM: late suspend of devices complete after 1.754 msecs
WARNING: CPU: 0 PID: 438 at drivers/firmware/raspberrypi.c:128
 rpi_firmware_property_list+0x204/0x22c
Firmware transaction 0x00028001 timeout
Modules linked in:
CPU: 0 PID: 438 Comm: bash Tainted: G         C         6.9.3-dirty #17
Hardware name: BCM2835
Call trace:
unwind_backtrace from show_stack+0x18/0x1c
show_stack from dump_stack_lvl+0x34/0x44
dump_stack_lvl from __warn+0x88/0xec
__warn from warn_slowpath_fmt+0x7c/0xb0
warn_slowpath_fmt from rpi_firmware_property_list+0x204/0x22c
rpi_firmware_property_list from rpi_firmware_property+0x68/0x8c
rpi_firmware_property from rpi_firmware_set_power+0x54/0xc0
rpi_firmware_set_power from _genpd_power_off+0xe4/0x148
_genpd_power_off from genpd_sync_power_off+0x7c/0x11c
genpd_sync_power_off from genpd_finish_suspend+0xcc/0xe0
genpd_finish_suspend from dpm_run_callback+0x78/0xd0
dpm_run_callback from device_suspend_noirq+0xc0/0x238
device_suspend_noirq from dpm_suspend_noirq+0xb0/0x168
dpm_suspend_noirq from suspend_devices_and_enter+0x1b8/0x5ac
suspend_devices_and_enter from pm_suspend+0x254/0x2e4
pm_suspend from state_store+0xa8/0xd4
state_store from kernfs_fop_write_iter+0x154/0x1a0
kernfs_fop_write_iter from vfs_write+0x12c/0x184
vfs_write from ksys_write+0x78/0xc0
ksys_write from ret_fast_syscall+0x0/0x54
Exception stack(0xcc93dfa8 to 0xcc93dff0)
[...]
PM: noirq suspend of devices complete after 3095.584 msecs

Link: https://github.com/raspberrypi/firmware/issues/1894
Fixes: 0bae6af6d704 ("mailbox: Enable BCM2835 mailbox support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/bcm2835-mailbox.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/bcm2835-mailbox.c b/drivers/mailbox/bcm2835-mailbox.c
index 86b7ce3549c5a..7b63967c30fab 100644
--- a/drivers/mailbox/bcm2835-mailbox.c
+++ b/drivers/mailbox/bcm2835-mailbox.c
@@ -146,7 +146,8 @@ static int bcm2835_mbox_probe(struct platform_device *pdev)
 	spin_lock_init(&mbox->lock);
 
 	ret = devm_request_irq(dev, irq_of_parse_and_map(dev->of_node, 0),
-			       bcm2835_mbox_irq, 0, dev_name(dev), mbox);
+			       bcm2835_mbox_irq, IRQF_NO_SUSPEND, dev_name(dev),
+			       mbox);
 	if (ret) {
 		dev_err(dev, "Failed to register a mailbox IRQ handler: %d\n",
 			ret);
-- 
2.43.0




