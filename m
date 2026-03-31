Return-Path: <stable+bounces-232568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHejDj0jzGnHPgYAu9opvQ
	(envelope-from <stable+bounces-232568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 21:40:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E3370AC7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 21:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E8F43001D62
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1573A0E84;
	Tue, 31 Mar 2026 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMKIOT92"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F891267386
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986042; cv=none; b=k8hDPSdbVKmPrHFGeIXtEdlhoTm0vwqev8qnnmkeWhPHuXlJY0sxYz4YLTR4Fffz1RUxKKnPMs8UDOEOVH5bQlYTRUnj5KCpgUfbdz8UKsqvc+Owz/GeehMVbzVtnUcLQNIydn86g3NG4PmbXxb6MKrnhBO/RxxDfDp5+Ywa0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986042; c=relaxed/simple;
	bh=Vg+UxfwHzdhzBH/w1dHcBvPtPkIKPXSWJF4r5+XuREo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDn6Xm7lSfvbtnvpp4LKr2tL7vy+gdDNHJe0v1WAq6hsfMkRVUDqhk6qQYV+1NeCr5/xaKaOLYu2plGv6hCtsWxg5N+o9ZvZuYANK2EgD3ffj9eQQmGQhtIeI6b21CXtEWi9cgs6D88EGuRlzvb5iBY1PHitiqklIeCMD9/bhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMKIOT92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FDBC19423;
	Tue, 31 Mar 2026 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774986042;
	bh=Vg+UxfwHzdhzBH/w1dHcBvPtPkIKPXSWJF4r5+XuREo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMKIOT92aBQ1ts+BftI6o2hEpLKxgN5O6WYSYZI+jrbcFfLZ7AloJ2WE0CniEaHr0
	 8u+o7IHsFxd4FZGRGXhJDNw5Tk/lcoStqA306ZL9z10EjYtNuAeQLAj/q/lL5D9t51
	 rJvcYDgTi3vwlc1eHyCseCYRCUDbYm1zU2zJ6MN45cWY+h+ZaOIvS9zLQiJca5D5mi
	 4xQksLYgk0BVeDy4egbF/i5TNxMWTflfGw/ffS/Uc8TsBuMum9gWSyd75KoVr34xtX
	 IQ9kj5NH9hSzcHlwuVw/sEv3Trewp5kb6/cc/2rQeeYaNMGIGz5DYaT+GubSq/Sw3Q
	 aPkAkrejNi1AQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: macb: Move devm_{free,request}_irq() out of spin lock area
Date: Tue, 31 Mar 2026 15:40:40 -0400
Message-ID: <20260331194040.3090422-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033059-able-shelf-2460@gregkh>
References: <2026033059-able-shelf-2460@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bootlin.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-232568-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.989];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email,msgid.link:url]
X-Rspamd-Queue-Id: D05E3370AC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 317e49358ebbf6390fa439ef3c142f9239dd25fb ]

The devm_free_irq() and devm_request_irq() functions should not be
executed in an atomic context.

During device suspend, all userspace processes and most kernel threads
are frozen. Additionally, we flush all tx/rx status, disable all macb
interrupts, and halt rx operations. Therefore, it is safe to split the
region protected by bp->lock into two independent sections, allowing
devm_free_irq() and devm_request_irq() to run in a non-atomic context.
This modification resolves the following lockdep warning:
  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 501, name: rtcwake
  preempt_count: 1, expected: 0
  RCU nest depth: 1, expected: 0
  7 locks held by rtcwake/501:
   #0: ffff0008038c3408 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0xf8/0x368
   #1: ffff0008049a5e88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xbc/0x1c8
   #2: ffff00080098d588 (kn->active#70){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xcc/0x1c8
   #3: ffff800081c84888 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspend+0x1ec/0x290
   #4: ffff0008009ba0f8 (&dev->mutex){....}-{4:4}, at: device_suspend+0x118/0x4f0
   #5: ffff800081d00458 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
   #6: ffff0008031fb9e0 (&bp->lock){-.-.}-{3:3}, at: macb_suspend+0x144/0x558
  irq event stamp: 8682
  hardirqs last  enabled at (8681): [<ffff8000813c7d7c>] _raw_spin_unlock_irqrestore+0x44/0x88
  hardirqs last disabled at (8682): [<ffff8000813c7b58>] _raw_spin_lock_irqsave+0x38/0x98
  softirqs last  enabled at (7322): [<ffff8000800f1b4c>] handle_softirqs+0x52c/0x588
  softirqs last disabled at (7317): [<ffff800080010310>] __do_softirq+0x20/0x2c
  CPU: 1 UID: 0 PID: 501 Comm: rtcwake Not tainted 7.0.0-rc3-next-20260310-yocto-standard+ #125 PREEMPT
  Hardware name: ZynqMP ZCU102 Rev1.1 (DT)
  Call trace:
   show_stack+0x24/0x38 (C)
   __dump_stack+0x28/0x38
   dump_stack_lvl+0x64/0x88
   dump_stack+0x18/0x24
   __might_resched+0x200/0x218
   __might_sleep+0x38/0x98
   __mutex_lock_common+0x7c/0x1378
   mutex_lock_nested+0x38/0x50
   free_irq+0x68/0x2b0
   devm_irq_release+0x24/0x38
   devres_release+0x40/0x80
   devm_free_irq+0x48/0x88
   macb_suspend+0x298/0x558
   device_suspend+0x218/0x4f0
   dpm_suspend+0x244/0x3a0
   dpm_suspend_start+0x50/0x78
   suspend_devices_and_enter+0xec/0x560
   pm_suspend+0x194/0x290
   state_store+0x110/0x158
   kobj_attr_store+0x1c/0x30
   sysfs_kf_write+0xa8/0xd0
   kernfs_fop_write_iter+0x11c/0x1c8
   vfs_write+0x248/0x368
   ksys_write+0x7c/0xf8
   __arm64_sys_write+0x28/0x40
   invoke_syscall+0x4c/0xe8
   el0_svc_common+0x98/0xf0
   do_el0_svc+0x28/0x40
   el0_svc+0x54/0x1e0
   el0t_64_sync_handler+0x84/0x130
   el0t_64_sync+0x198/0x1a0

Fixes: 558e35ccfe95 ("net: macb: WoL support for GEM type of Ethernet controller")
Cc: stable@vger.kernel.org
Reviewed-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Link: https://patch.msgid.link/20260318-macb-irq-v2-1-f1179768ab24@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ replaced `tmp` variable with direct `MACB_BIT(MAG)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 693688a580022..454b2aac34d72 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5384,6 +5384,8 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		macb_writel(bp, TSR, -1);
 		macb_writel(bp, RSR, -1);
 
+		spin_unlock_irqrestore(&bp->lock, flags);
+
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
 		 */
@@ -5395,11 +5397,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				dev_err(dev,
 					"Unable to request IRQ %d (error %d)\n",
 					bp->queues[0].irq, err);
-				spin_unlock_irqrestore(&bp->lock, flags);
 				return err;
 			}
+			spin_lock_irqsave(&bp->lock, flags);
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
 			gem_writel(bp, WOL, MACB_BIT(MAG));
+			spin_unlock_irqrestore(&bp->lock, flags);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5407,13 +5410,13 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				dev_err(dev,
 					"Unable to request IRQ %d (error %d)\n",
 					bp->queues[0].irq, err);
-				spin_unlock_irqrestore(&bp->lock, flags);
 				return err;
 			}
+			spin_lock_irqsave(&bp->lock, flags);
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
 			macb_writel(bp, WOL, MACB_BIT(MAG));
+			spin_unlock_irqrestore(&bp->lock, flags);
 		}
-		spin_unlock_irqrestore(&bp->lock, flags);
 
 		enable_irq_wake(bp->queues[0].irq);
 	}
@@ -5480,6 +5483,8 @@ static int __maybe_unused macb_resume(struct device *dev)
 		queue_readl(bp->queues, ISR);
 		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 			queue_writel(bp->queues, ISR, -1);
+		spin_unlock_irqrestore(&bp->lock, flags);
+
 		/* Replace interrupt handler on queue 0 */
 		devm_free_irq(dev, bp->queues[0].irq, bp->queues);
 		err = devm_request_irq(dev, bp->queues[0].irq, macb_interrupt,
@@ -5488,10 +5493,8 @@ static int __maybe_unused macb_resume(struct device *dev)
 			dev_err(dev,
 				"Unable to request IRQ %d (error %d)\n",
 				bp->queues[0].irq, err);
-			spin_unlock_irqrestore(&bp->lock, flags);
 			return err;
 		}
-		spin_unlock_irqrestore(&bp->lock, flags);
 
 		disable_irq_wake(bp->queues[0].irq);
 
-- 
2.53.0


