Return-Path: <stable+bounces-9831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5F98255A1
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D412819DD
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067362E40F;
	Fri,  5 Jan 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1IvqZ0ew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB212D7AD;
	Fri,  5 Jan 2024 14:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B71C433C8;
	Fri,  5 Jan 2024 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465651;
	bh=4F0ss/H0V40VfEtY/0UPvpmp8izQv2QP8+mxtafkP1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1IvqZ0ewXK4PTKxFV/XbdKOmWCJsXEf5jdK9PtootUXfYeNViN26pqhCELPxyAi96
	 AAMgFDWBCTXGMy4MY2117UHZnDhm7n80INT5Azh2qeZ0TrdvvqTHJ1c/RQ7DwNLgGw
	 8HzjUNr8kLFQ8zJ5tCS4+3ST6kHl+y9/HwcSUGLQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 19/41] pinctrl: at91-pio4: use dedicated lock class for IRQ
Date: Fri,  5 Jan 2024 15:38:59 +0100
Message-ID: <20240105143814.805442264@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
References: <20240105143813.957669139@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit 14694179e561b5f2f7e56a0f590e2cb49a9cc7ab ]

Trying to suspend to RAM on SAMA5D27 EVK leads to the following lockdep
warning:

 ============================================
 WARNING: possible recursive locking detected
 6.7.0-rc5-wt+ #532 Not tainted
 --------------------------------------------
 sh/92 is trying to acquire lock:
 c3cf306c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xe8/0x100

 but task is already holding lock:
 c3d7c46c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xe8/0x100

 other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&irq_desc_lock_class);
   lock(&irq_desc_lock_class);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

 6 locks held by sh/92:
  #0: c3aa0258 (sb_writers#6){.+.+}-{0:0}, at: ksys_write+0xd8/0x178
  #1: c4c2df44 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x138/0x284
  #2: c32684a0 (kn->active){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x148/0x284
  #3: c232b6d4 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend+0x13c/0x4e8
  #4: c387b088 (&dev->mutex){....}-{3:3}, at: __device_suspend+0x1e8/0x91c
  #5: c3d7c46c (&irq_desc_lock_class){-.-.}-{2:2}, at: __irq_get_desc_lock+0xe8/0x100

 stack backtrace:
 CPU: 0 PID: 92 Comm: sh Not tainted 6.7.0-rc5-wt+ #532
 Hardware name: Atmel SAMA5
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x34/0x48
  dump_stack_lvl from __lock_acquire+0x19ec/0x3a0c
  __lock_acquire from lock_acquire.part.0+0x124/0x2d0
  lock_acquire.part.0 from _raw_spin_lock_irqsave+0x5c/0x78
  _raw_spin_lock_irqsave from __irq_get_desc_lock+0xe8/0x100
  __irq_get_desc_lock from irq_set_irq_wake+0xa8/0x204
  irq_set_irq_wake from atmel_gpio_irq_set_wake+0x58/0xb4
  atmel_gpio_irq_set_wake from irq_set_irq_wake+0x100/0x204
  irq_set_irq_wake from gpio_keys_suspend+0xec/0x2b8
  gpio_keys_suspend from dpm_run_callback+0xe4/0x248
  dpm_run_callback from __device_suspend+0x234/0x91c
  __device_suspend from dpm_suspend+0x224/0x43c
  dpm_suspend from dpm_suspend_start+0x9c/0xa8
  dpm_suspend_start from suspend_devices_and_enter+0x1e0/0xa84
  suspend_devices_and_enter from pm_suspend+0x460/0x4e8
  pm_suspend from state_store+0x78/0xe4
  state_store from kernfs_fop_write_iter+0x1a0/0x284
  kernfs_fop_write_iter from vfs_write+0x38c/0x6f4
  vfs_write from ksys_write+0xd8/0x178
  ksys_write from ret_fast_syscall+0x0/0x1c
 Exception stack(0xc52b3fa8 to 0xc52b3ff0)
 3fa0:                   00000004 005a0ae8 00000001 005a0ae8 00000004 00000001
 3fc0: 00000004 005a0ae8 00000001 00000004 00000004 b6c616c0 00000020 0059d190
 3fe0: 00000004 b6c61678 aec5a041 aebf1a26

This warning is raised because pinctrl-at91-pio4 uses chained IRQ. Whenever
a wake up source configures an IRQ through irq_set_irq_wake, it will
lock the corresponding IRQ desc, and then call irq_set_irq_wake on "parent"
IRQ which will do the same on its own IRQ desc, but since those two locks
share the same class, lockdep reports this as an issue.

Fix lockdep false positive by setting a different class for parent and
children IRQ

Fixes: 776180848b57 ("pinctrl: introduce driver for Atmel PIO4 controller")
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Link: https://lore.kernel.org/r/20231215-lockdep_warning-v1-1-8137b2510ed5@bootlin.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index cbbda24bf6a80..67befdce3805b 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -939,6 +939,13 @@ static const struct of_device_id atmel_pctrl_of_match[] = {
 	}
 };
 
+/*
+ * This lock class allows to tell lockdep that parent IRQ and children IRQ do
+ * not share the same class so it does not raise false positive
+ */
+static struct lock_class_key atmel_lock_key;
+static struct lock_class_key atmel_request_key;
+
 static int atmel_pinctrl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1089,6 +1096,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		irq_set_chip_and_handler(irq, &atmel_gpio_irq_chip,
 					 handle_simple_irq);
 		irq_set_chip_data(irq, atmel_pioctrl);
+		irq_set_lockdep_class(irq, &atmel_lock_key, &atmel_request_key);
 		dev_dbg(dev,
 			"atmel gpio irq domain: hwirq: %d, linux irq: %d\n",
 			i, irq);
-- 
2.43.0




