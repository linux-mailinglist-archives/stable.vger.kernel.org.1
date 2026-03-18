Return-Path: <stable+bounces-226969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKFRNDtIumkFTwIAu9opvQ
	(envelope-from <stable+bounces-226969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:37:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 956842B67E1
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A15943020201
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F4C368277;
	Wed, 18 Mar 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7Iqb/Rp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A065363084
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815861; cv=none; b=pexZ3dN/8+E5HYCYWYDQvZ8+mXQLKoJYK5APlrHD7aDFyzXKB/GGvDwDHGDvZUH8Dk/1unL7IqOrT+Ax/0tocwCurNRxux9SP1g0UBNmo46MxbdSj3dDSy8Vm3OYQimozSmUhNayUkn1VMASnDlT8NIay4QBBtv3G9P4I5k18ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815861; c=relaxed/simple;
	bh=2tbsYy2Mku8qTrVZCtuP7abbjxmrsPE3moRK/3+c5kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sD4jJrq9A1LCLd3f8rf4WZOQczfFUunOhKMi7JWYXpm0keMcd6GZd/Zk7Acuf1v4GrZmAXmi4+7Zq4diaaW4uJncsJIoe2h4zTPQNkotsQvtp+X29Vqjw7CJtGhrkJk0j7kDO3lojl5gJJCZ7s5TUodwDT4UGnim7qT5+63u7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7Iqb/Rp; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-509006c070eso56731341cf.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 23:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773815858; x=1774420658; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHAN2RjWd47ozI2jbJBMDIBVL7XJnDdwoQ9790Qp7pI=;
        b=J7Iqb/RprgQJLv3JHwYVvOY79oeNBBC8AHLyjpIsBPOhYPGltm8fWoB72UngtumLue
         woNV0/8o4BK4hM0a3zxaQDuGf8u7GQvMaQULOVFz7mdFg5An261NrX5p/UcqhRO5nllB
         A7KZWzdNbpfABrvea0asMJX9vyjSTlLrEm1+EzzsgtvN164pkR69xshWChzUVZRWC5yl
         U5eYGX94j3+x+VaWpkeVoqrTgMYdPQvz0bnhrTznTzX3e5GB7s3oc8AcFsHHir9q7FLK
         d8ZPfnnOGjWJ8+OQ0tEB/6FUe7BeiQjXihrKE9tHQEjbMXHsfeVi/rP+9eoW/Lvyfkbh
         Kwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815858; x=1774420658;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MHAN2RjWd47ozI2jbJBMDIBVL7XJnDdwoQ9790Qp7pI=;
        b=YenZq133iZxZYIPrghYdTDBUn0dIvCt+gG3r9aG1itqnIW0ZHlZ4kBKliEMUK6i3Wx
         0/QsYQzKm6IScn/dOL66GhHN/AJi1yhMzZJG6vahJsMDGm2E0W/TSWFfquU266umTmQG
         rceDkxoiASkskWtwDykm1Kg0lvy3VOBSE7xt/lCWMxXJdNy+3g3QLXNdJD5BwhNpIIG3
         zqsCV9pIxGs7M3/c5BAFl3upryL0XaBbQ2rY0N7Z0U9sT1QXyCvvR+pGJ7d3kIWaAAmb
         jpLdClmd0uJiWoH8rZHk/B17azDg+us+ERubW8FUlx3pJeahsKAkOGjuBBW5IKRBIujn
         OM8A==
X-Forwarded-Encrypted: i=1; AJvYcCWzPB/cm5/uk3TMEyfQ+91qsfE+NEmZCjZxXSmKo2BTv1mdlvcDIgZfAMYlTyYunN1aowa4kuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYDxle6rY70hMIyLwlz9mF4eECdHTNFDU0cRQylZWqjz3Jt+N
	bkPmqdCJ0HksbVoNRGJXe9Uq21clqg79B5kxPUOeWTZW5BqCTJ8Y42lA
X-Gm-Gg: ATEYQzwb75LwAvTGyQvXVkvSe1H1vUcvUqFWMkkTQR43YGEfD7J2PI/ZPCXpFOXcpPS
	n1cPKKX/ercJ0AYNRQa9AaBnpKZqFM/nbKx5sz7LMZD6Q0saNRL16Y87rUWgrqv18+fXTlrp6rY
	ageU2AqXIWK4JA2WTBV5BIqoBSzOuXzKHxlQYmJ6YjdEByM9yzQ4QyQwcmZ+lZiUmZwbh3hS9Eq
	i58gXwlPbGhkPHl3STtlnQZfvfXGCuEgS/hXhHook9M+qLuIQsZfYJSrB6EdsY7wjLlEJZG6jMU
	au0t64jXYnWreH+w5Dc2lsW9YBb5bAreXeDD3WIHJiWh9yvYKRfNc4rOwLDYclEM4MzbrEaVV+i
	LZyUUiLQkkIcXa8+AjDHR7qEX9vutflYs5d78xIe7TXjX3Xc3svQAsef0F2CTqY7gqjFbDIvzJY
	p50Y5Cb1LskrqzxTKZH4gieOOfiL2uDMukfqcKGxg6HLw=
X-Received: by 2002:a05:622a:146:b0:509:2222:4202 with SMTP id d75a77b69052e-50b149046demr25233221cf.71.1773815857714;
        Tue, 17 Mar 2026 23:37:37 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b135b875esm15235351cf.25.2026.03.17.23.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:37:37 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Wed, 18 Mar 2026 14:36:58 +0800
Subject: [PATCH net v2 1/2] net: macb: Move devm_{free,request}_irq() out
 of spin lock area
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-macb-irq-v2-1-f1179768ab24@gmail.com>
References: <20260318-macb-irq-v2-0-f1179768ab24@gmail.com>
In-Reply-To: <20260318-macb-irq-v2-0-f1179768ab24@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
 Harini Katakam <harini.katakam@amd.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226969-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,bootlin.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 956842B67E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
---
 drivers/net/ethernet/cadence/macb_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 36ab3b7e1feabd295be35152f0b464bba6fcbe18..2d4304331e297accd91ab48813a9bd4722ce72dc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5968,6 +5968,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			/* write IP address into register */
 			tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
 		}
+		spin_unlock_irqrestore(&bp->lock, flags);
 
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
@@ -5980,11 +5981,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
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
@@ -5992,13 +5994,13 @@ static int __maybe_unused macb_suspend(struct device *dev)
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
@@ -6065,6 +6067,8 @@ static int __maybe_unused macb_resume(struct device *dev)
 		queue_readl(bp->queues, ISR);
 		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 			queue_writel(bp->queues, ISR, -1);
+		spin_unlock_irqrestore(&bp->lock, flags);
+
 		/* Replace interrupt handler on queue 0 */
 		devm_free_irq(dev, bp->queues[0].irq, bp->queues);
 		err = devm_request_irq(dev, bp->queues[0].irq, macb_interrupt,
@@ -6073,10 +6077,8 @@ static int __maybe_unused macb_resume(struct device *dev)
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


