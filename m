Return-Path: <stable+bounces-226970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM2bHRBJumkFTwIAu9opvQ
	(envelope-from <stable+bounces-226970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:41:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C22B682A
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 919E6304653E
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF555362132;
	Wed, 18 Mar 2026 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEKMxOWC"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C224368284
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815864; cv=none; b=N0zMRSmjJmx2NssMcmYjb5bcreYGMbvBHsQ5OZLG00yJ/nW2G+/T5b6E6gtKAFiN2e7TAgLMVtL9vu5p7M38wz+J7qG1E71ht5vOTFjDkLPYjdHKNuzre2oFY31rJQPowS5kiwf33nyT0kN2HfaDzWjm/dH3fjVVOEUav5OHP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815864; c=relaxed/simple;
	bh=B6w9+t6iL/TOp54YhkDN8WKI5sr7szB/UfhThNsC4KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtZV45JB9p14yBi8Z70azNVgG7w09SwMW1FekO07+XU+IcB09P0F4Zxqb2jPhGqMeRGmJkjuxcfPJAfTAFCylC2ld/Zb7B5Qb/YiK4p6YviLsNCtVuERbdMwmt4sZzYcG/JfKzu7oHKA8H95EBRam+72l8LNkIy+7nvkLanyR8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEKMxOWC; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50917417efbso6079361cf.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773815862; x=1774420662; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZGvwuMrOAu4OGXCJyfmhbRaVBhCV3KVK8W/0vxO3GY=;
        b=SEKMxOWCeAoc3YF13OcCGHVLNnbFiAJl53HEMRxQh9XNDPxjjurZ0La7FdI4U7uKKZ
         pzxQsGGEBHj5iuQw+L3SDEY19ub96w66qRfYZEeHlIF83UCEkuxs/guWFSg1mUurguYB
         HVDWKBIVQPUqXl4FehYI+BERxHmbu+4uOJFL4MJxNaq59mopVJUJoILy/dtBk1ag1edP
         it2ZXmV3bfhcjWAI/PyXNsX6xbgv8KLnirHSx9xEFRnVyeU9jSinMgreio82ISiXossk
         rmJyJMQHWl6MaQpHRi2N+jKcrN7ZjdFmN8NvO5ZAxgk6/PBiXH6N+w2jFPIofEVBj2oE
         B/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815862; x=1774420662;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dZGvwuMrOAu4OGXCJyfmhbRaVBhCV3KVK8W/0vxO3GY=;
        b=AiZtJI9vWXqNdjsN6Op06Ip6MtcpvCWZ1USbXKZIk7RIutSPu0/HeI3fiNPyWZ7F1x
         tLe6eji2YEZ1g4Gk6uqvJ9lExN2x5MBidRnrhHdi3a70PWPhk8dZYqFyXQQiz/aMqp5M
         URkHtxhxtBw1RAeBozzgQoSi/vZ+3qMOvvz4a4FT/3+84E3If5pt8jv51YJOYJGWnOiY
         TtCWeLGY/723D1mjrNa6Rb8xtFl9MGpSBSdV8z4kIgdmMaq9GewpmgU7JwO3GGGIQPvu
         iepjjjENwqQ6JA/0aS/lmI5mLapiK6iiaBLrjCqwZ4CRdHB/Fz3XzPHTrZ1RE8hJeKHz
         W4aA==
X-Forwarded-Encrypted: i=1; AJvYcCU4BzxFxnHPXSMjvqP/c47zZLPyhmbUnV55Oc4ZWiU/d4+kG3A8104PnuhvHXmnlVg1jSFJER8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFcYBwL9aS+6IzVpBNQcgL0reCgaZuGbZ6weS8xRiz5W1GiZCZ
	HJsy7nBLFoVAtbpLfaqNXzQizV5G8aPtfvocJyG4/IPgMM/2jqNtR82B
X-Gm-Gg: ATEYQzxTGZpLdZjw1QxAw0kwb/Njra5nEnwOclCET8uiomnvYxu9pdtsn0CDC+8Rses
	oCql07MmHSM7+7q+uZLjfvOEslJtGUWvinzFuIj1sNza7FOu4+qKXUP0Pp/E/Z5EWeU+DlrGH6h
	gc5DQ9IAf1NnDipqWdnZqKRWomNQ+s6IyscCm8Q66BX4IhkX+nzhXQP/iAa0ICsEpNQosQt2VXF
	JieLnypgpOE6+tRZ4u7r24eOF4+nqEVw0Vp+tQh9aFoWj+7+j9cw4N1iCJMkp8kpUQBpk192RzI
	5aHa/2UHPNS+r28k3WZ/IVWYswHTOtqOm+2tB3Hk+tmxvFHtFZE6tPAT6VDq6KfwrhnmJq2BklE
	0h/ksVooOSZ0pEpzn7pXDzETyCHheXSXxPuZqdqNGNfl36DY1F5T9VNTKiesQZ+cDDUJPCguJ93
	OUXxqPgSnmV8a676PlYOpCMrVN3pSBbNiq
X-Received: by 2002:a05:622a:607:b0:501:4184:b59f with SMTP id d75a77b69052e-50b138674bamr30444081cf.15.1773815862249;
        Tue, 17 Mar 2026 23:37:42 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b135b875esm15235351cf.25.2026.03.17.23.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:37:41 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Wed, 18 Mar 2026 14:36:59 +0800
Subject: [PATCH net v2 2/2] net: macb: Protect access to net_device::ip_ptr
 with RCU lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-macb-irq-v2-2-f1179768ab24@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226970-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,bootlin.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D80C22B682A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Access to net_device::ip_ptr and its associated members must be
protected by an RCU lock. Since we are modifying this piece of code,
let's also move it to execute only when WAKE_ARP is enabled.

To minimize the duration of the RCU lock, a local variable is used to
temporarily store the IP address. This change resolves the following
RCU check warning:
  WARNING: suspicious RCU usage
  7.0.0-rc3-next-20260310-yocto-standard+ #122 Not tainted
  -----------------------------
  drivers/net/ethernet/cadence/macb_main.c:5944 suspicious rcu_dereference_check() usage!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  5 locks held by rtcwake/518:
   #0: ffff000803ab1408 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0xf8/0x368
   #1: ffff0008090bf088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xbc/0x1c8
   #2: ffff00080098d588 (kn->active#70){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xcc/0x1c8
   #3: ffff800081c84888 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspend+0x1ec/0x290
   #4: ffff0008009ba0f8 (&dev->mutex){....}-{4:4}, at: device_suspend+0x118/0x4f0

  stack backtrace:
  CPU: 3 UID: 0 PID: 518 Comm: rtcwake Not tainted 7.0.0-rc3-next-20260310-yocto-standard+ #122 PREEMPT
  Hardware name: ZynqMP ZCU102 Rev1.1 (DT)
  Call trace:
   show_stack+0x24/0x38 (C)
   __dump_stack+0x28/0x38
   dump_stack_lvl+0x64/0x88
   dump_stack+0x18/0x24
   lockdep_rcu_suspicious+0x134/0x1d8
   macb_suspend+0xd8/0x4c0
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

Fixes: 0cb8de39a776 ("net: macb: Add ARP support to WOL")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/cadence/macb_main.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2d4304331e297accd91ab48813a9bd4722ce72dc..9856764402b17397928d0a61da61865a3b10484f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5909,9 +5909,9 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct macb_queue *queue;
 	struct in_device *idev;
 	unsigned long flags;
+	u32 tmp, ifa_local;
 	unsigned int q;
 	int err;
-	u32 tmp;
 
 	if (!device_may_wakeup(&bp->dev->dev))
 		phy_exit(bp->phy);
@@ -5920,14 +5920,21 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		return 0;
 
 	if (bp->wol & MACB_WOL_ENABLED) {
-		/* Check for IP address in WOL ARP mode */
-		idev = __in_dev_get_rcu(bp->dev);
-		if (idev)
-			ifa = rcu_dereference(idev->ifa_list);
-		if ((bp->wolopts & WAKE_ARP) && !ifa) {
-			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
-			return -EOPNOTSUPP;
+		if (bp->wolopts & WAKE_ARP) {
+			/* Check for IP address in WOL ARP mode */
+			rcu_read_lock();
+			idev = __in_dev_get_rcu(bp->dev);
+			if (idev)
+				ifa = rcu_dereference(idev->ifa_list);
+			if (!ifa) {
+				rcu_read_unlock();
+				netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
+				return -EOPNOTSUPP;
+			}
+			ifa_local = be32_to_cpu(ifa->ifa_local);
+			rcu_read_unlock();
 		}
+
 		spin_lock_irqsave(&bp->lock, flags);
 
 		/* Disable Tx and Rx engines before  disabling the queues,
@@ -5966,7 +5973,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		if (bp->wolopts & WAKE_ARP) {
 			tmp |= MACB_BIT(ARP);
 			/* write IP address into register */
-			tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
+			tmp |= MACB_BFEXT(IP, ifa_local);
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
 

-- 
2.53.0


