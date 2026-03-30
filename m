Return-Path: <stable+bounces-231095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG+lDtZEymm/7AUAu9opvQ
	(envelope-from <stable+bounces-231095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:39:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 412E1358529
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A1F03001394
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88593B4E8E;
	Mon, 30 Mar 2026 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvV1SdOY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629A3B4EAB
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863552; cv=none; b=ZD/1woqio1GTiecNOLVoGEJVRJmygpclrHesRcZlT/uj7hCBq53S6Mt7SbRIdjYLOz34SBzFefIaPgBn0vVAvAm3776ucsOgY+KO/zqagWWgXv8kerlFkYN6x9/pRVCmYd4W+i/Zas1M+dKeoMUT1ZWTjeJNlvHMGmITqHs7yzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863552; c=relaxed/simple;
	bh=a35WYfTAxOAZluvb+QXoURtPKsCyREGQiyzPpeQ8kIo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F6PFT1GVHXcxcw56bfkFjf5e/2VZLWzL0TQw3yXDjYAexO8wnYTDXkJuyJJZMoy+bx3JWCzX9SoUgSfoazWDPGfTdci90HA1w8TqiRfQXpmWq3q2URmRT2B5SuWhe0+f17dmO3yIjALXHg15cTvX3v6BakfsT81D4YrcwEbcMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvV1SdOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9078BC4CEF7;
	Mon, 30 Mar 2026 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863551;
	bh=a35WYfTAxOAZluvb+QXoURtPKsCyREGQiyzPpeQ8kIo=;
	h=Subject:To:Cc:From:Date:From;
	b=bvV1SdOY6fZhwNExkhXEKi5XYJHSaWw6jnC4dPmmCTRX6EEVzm4uDQgV6SVadBLV1
	 tu/rlaq18XQogG0zX4GwZ1CQ65gnbgDPNt/VOFMshbHcd+zvZDiR7XM5/TTTnL8Lc9
	 kg/mt60iX8NRCJpAabZoPWKCTx3dp43ecbPY5LWU=
Subject: FAILED: patch "[PATCH] net: macb: Move devm_{free,request}_irq() out of spin lock" failed to apply to 6.1-stable tree
To: haokexin@gmail.com,kuba@kernel.org,theo.lebrun@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:39:00 +0200
Message-ID: <2026033000-dove-underwire-bd5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231095-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,bootlin.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 412E1358529
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 317e49358ebbf6390fa439ef3c142f9239dd25fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033000-dove-underwire-bd5c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 317e49358ebbf6390fa439ef3c142f9239dd25fb Mon Sep 17 00:00:00 2001
From: Kevin Hao <haokexin@gmail.com>
Date: Wed, 18 Mar 2026 14:36:58 +0800
Subject: [PATCH] net: macb: Move devm_{free,request}_irq() out of spin lock
 area
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index c16ac9c76aa3..1b95226ae696 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5835,6 +5835,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			/* write IP address into register */
 			tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
 		}
+		spin_unlock_irqrestore(&bp->lock, flags);
 
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
@@ -5847,11 +5848,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				dev_err(dev,
 					"Unable to request IRQ %d (error %d)\n",
 					bp->queues[0].irq, err);
-				spin_unlock_irqrestore(&bp->lock, flags);
 				return err;
 			}
+			spin_lock_irqsave(&bp->lock, flags);
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
 			gem_writel(bp, WOL, tmp);
+			spin_unlock_irqrestore(&bp->lock, flags);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5859,13 +5861,13 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				dev_err(dev,
 					"Unable to request IRQ %d (error %d)\n",
 					bp->queues[0].irq, err);
-				spin_unlock_irqrestore(&bp->lock, flags);
 				return err;
 			}
+			spin_lock_irqsave(&bp->lock, flags);
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
 			macb_writel(bp, WOL, tmp);
+			spin_unlock_irqrestore(&bp->lock, flags);
 		}
-		spin_unlock_irqrestore(&bp->lock, flags);
 
 		enable_irq_wake(bp->queues[0].irq);
 	}
@@ -5932,6 +5934,8 @@ static int __maybe_unused macb_resume(struct device *dev)
 		queue_readl(bp->queues, ISR);
 		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 			queue_writel(bp->queues, ISR, -1);
+		spin_unlock_irqrestore(&bp->lock, flags);
+
 		/* Replace interrupt handler on queue 0 */
 		devm_free_irq(dev, bp->queues[0].irq, bp->queues);
 		err = devm_request_irq(dev, bp->queues[0].irq, macb_interrupt,
@@ -5940,10 +5944,8 @@ static int __maybe_unused macb_resume(struct device *dev)
 			dev_err(dev,
 				"Unable to request IRQ %d (error %d)\n",
 				bp->queues[0].irq, err);
-			spin_unlock_irqrestore(&bp->lock, flags);
 			return err;
 		}
-		spin_unlock_irqrestore(&bp->lock, flags);
 
 		disable_irq_wake(bp->queues[0].irq);
 


