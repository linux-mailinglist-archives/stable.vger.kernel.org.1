Return-Path: <stable+bounces-225469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNlRG/CbtmlAEQEAu9opvQ
	(envelope-from <stable+bounces-225469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 12:45:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 253682908D9
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 12:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CB8A302A7E6
	for <lists+stable@lfdr.de>; Sun, 15 Mar 2026 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD7A301486;
	Sun, 15 Mar 2026 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg/okTxW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC99A1A2392
	for <stable@vger.kernel.org>; Sun, 15 Mar 2026 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773575127; cv=none; b=bPJRvSHXAtecFgK9jNWppxYpTPnEFdSmDxhcsbmEKNdCfAI9liWDOX0oMA85rmwzmOBfY/2pyi1jTztPyhszTKRA0oLQRtSzJ6C55dsw9MhXxrdAU3SRtqC5eee1OFUtBwWwN4F7Swbm7ffACb2sZ5mSCdwZfien5mMbaZaAqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773575127; c=relaxed/simple;
	bh=SXThhcTinaSGWPEU0PblAcrpgSg6ZMmu4eYThX8lXg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haH7Pe92piuwn7qOVxE7jb9XffX9YH3nOBtRsHunFa3VRQ2tYMPOKKiXV2/HeVxNuEpMq53Do7hfKJmnkpahMtNLK24FA1B8ZYW91m9ccVgR5nwnVuZck/AQinO9ZPtA/F9JdhrczZtwfjqNY77KDI/S4QJCSsk2i3oCAZ+YOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg/okTxW; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899f5d337f7so45349206d6.0
        for <stable@vger.kernel.org>; Sun, 15 Mar 2026 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773575125; x=1774179925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVysMRzMPiJzPSkGDk/Vk3UJnuubZcvCxZhYIwEHGTg=;
        b=Mg/okTxWv10+5ytC2gKVJxlYh5Q4vOKejs4HwakKnQgYSrWVSktEtvGGltop7qaZaK
         syGWTALCX6ETSOMhsilfirOiJaos05uxWmV7Fa9t1PAf/soZAsrQyb9d+n4kuACGlJZ4
         MnAGSs4gojqr/oN3VcZMTx6b93lulC9rTIsR5dxa9VBreVRwFNbJD9Ini6BUt9y+wylN
         EoVk6Cs16Pp0HUYBhp1lkGSzkAT7kOrICr5KMwOUbg87AtNV46STpbSwssUfp0EhYQeS
         KAWVusOnjVdS2qOosEsFKKa4O+HgNu+D7to4w0LbPxmrlvVuecTzPW2ugjFWiqxHLl0s
         Ktzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773575125; x=1774179925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FVysMRzMPiJzPSkGDk/Vk3UJnuubZcvCxZhYIwEHGTg=;
        b=dx/mjiwwEQ+6GtVJxZXPeQ279yxlEp1BB+RKP3yp//fNB4zN+MvuAoCctVL3ZCoWIY
         FQdCqAU4YcgvM9363xC+6P6SbwFapbWbb1Pcpp8uV4Bv8z71Ynf510tcJI6AtX1yAiQZ
         wqrd2o4EPLWBJyicF3S1VFtXef9UZKkKVKvhcB4gLtyrhWj5ZBgKbXC4f/mOtvM+utwC
         tC5OKm+7OxV5DZS70HA3oLX43iO1JMELtjZA6FS1GVwomnetxMoKZtPCy9qE+/Cvgdl4
         ZKPjybp+DzUm97+bG2tlowUU7GsZKjk6JdWEdd5PIhRmjmv4n5LSMP7YPIbnljkiF82b
         AXWg==
X-Forwarded-Encrypted: i=1; AJvYcCXYvEUjRW3WtFeZ09hlFicE0gQP7XP91bqS+d3efurxz2FgcQKSFH61EYBwqGOcb1DJNRbLhVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gSjajt9gtAiPigk1N4ZycXO33bvgjqUZOpcAmX6u5B3sMoMy
	1oujiHgT1Cd5Km9KGPSzeT4T8/qJqLlCsY7v4s5njLkesPL5GFdimIJx
X-Gm-Gg: ATEYQzwUHqpp67O5n89ejVKjOcevIKx4s8v5s/5F0FKq0ZDJopH7fMptck0q+hS1/yi
	q8iktyZBMab0N7vXq/+zP93NIub9PUHmbZp3Ov5OJ1SGWFw0zQl8f5SFtYWoH8TBJoG3lfImqwn
	g1iyQuyCa1daCIZ9zq/OPZckI3n0xqm0sJyh2OkPUpHtms34KluY5mHufHvm7B+/XupwDHB4ZP7
	biQawDwLWkW4mhG+1dFxEwBSCiS/Ofj7tTRSvh+YhmoRtEFT4k++fhXSeN/6x/aC/Q2bndIRWaG
	NUcgKiwuZwIPcfxdC4oYPgc8WDdaovutE/RIISuiOJeEHmaXM2BLcg5HPs3bYp6aiXGYlcEzb2M
	h98Gq6mody+f/vLSFNVoEVXhe6PW+1MWTgPzzo0gyS3r/QblpoUPad+YyyLiQAG3m138Y+CP80i
	NoB5qju0/BVk2FVa/fTnQuscfLGCHw9fQ0
X-Received: by 2002:ad4:5749:0:b0:89a:e8:d188 with SMTP id 6a1803df08f44-89a72a79500mr171334046d6.20.1773575124712;
        Sun, 15 Mar 2026 04:45:24 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65ce339dsm98261896d6.26.2026.03.15.04.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:45:24 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 15 Mar 2026 19:44:28 +0800
Subject: [PATCH net 2/2] net: macb: Protect access to net_device::in_ptr
 with RCU lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-macb-irq-v1-2-0154104cbf61@gmail.com>
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
In-Reply-To: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
 Harini Katakam <harini.katakam@amd.com>, Kevin Hao <haokexin@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225469-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 253682908D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Access to net_device::in_ptr and its members should be protected by RCU
lock. This resolves the following RCU check warning:
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
 drivers/net/ethernet/cadence/macb_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f290bc44020e76e681f403306cba998e540a4991..d35bb5f079cd103eea5af7584576c9582a18d22a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5915,13 +5915,16 @@ static int __maybe_unused macb_suspend(struct device *dev)
 
 	if (bp->wol & MACB_WOL_ENABLED) {
 		/* Check for IP address in WOL ARP mode */
+		rcu_read_lock();
 		idev = __in_dev_get_rcu(bp->dev);
 		if (idev)
 			ifa = rcu_dereference(idev->ifa_list);
 		if ((bp->wolopts & WAKE_ARP) && !ifa) {
 			netdev_err(netdev, "IP address not assigned as required by WoL walk ARP\n");
+			rcu_read_unlock();
 			return -EOPNOTSUPP;
 		}
+
 		spin_lock_irqsave(&bp->lock, flags);
 
 		/* Disable Tx and Rx engines before  disabling the queues,
@@ -5963,6 +5966,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
+		rcu_read_unlock();
 
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0

-- 
2.53.0


