Return-Path: <stable+bounces-233774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ77Mz361Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:48:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B7C3B7B48
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A91BC301B865
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52C726B756;
	Wed,  8 Apr 2026 06:48:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EB366063
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 06:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630884; cv=none; b=d422K1s5iBp3FIHOIQKUTboOzk8VfF19NAn8qMb/0+iDrt0pVN6tNGhvmKvx4AWkXWns4sFzWQlqjltsTkQ+9BPjMFEx/W8BamoOSpUNxpuo3JHFMlBdJ8xlKEE9bcbG7INtnpClsIWeEu/JCDIWdi73Xe7RFmJgBQAJOp0pr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630884; c=relaxed/simple;
	bh=qmtmc7Tp867dlyp86AwzLepvVDbeeKthqK9biJO1W0I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5xh28zhqDXYniU7ob8r4eF2KpEOX/C6jrNCBvp/4tBf7UkA4/cGKpq6YUsfqkWQ9NsaQqIScS7A8UT/EG7F2fVHDNoiLBHUQx3JdlGypNWvIfxrxpqiQ11k/Whl+w/dZFAIyTNP437ayIyiYo96VtF1ZPqd2Tfo1fo9Ak3WvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43ccda008cdso291945f8f.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 23:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775630881; x=1776235681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rkQxvU8d98B7kS0I1V9FO6w4ZFrdFN25ghkBcit1lHM=;
        b=MerWLOTkUCXdlpz6ZGTh8MSISVPIZ+5bSS5kb9YeWBqTWIGVHsHSyN29THcihoHzQQ
         UCDO4MCeVMLRavS1b/UnGo9egagjb7qIpK3vtqfsqcLI9LuEHN5n+jbhwyZIlw3O9/rk
         GChqka7EWA1N7CFbEPWssge6koFgAsXt6v8kr+FjDD+ySnKUmtEkxC8KXNmOnfZhxgVm
         l9AqZ0rK0YkB3/qA+C/QllgTuIS1zZh0WMrmSCeTTyQupHsqUimZYMkYJKY17qvGd95X
         VW+H/deYG1LjK+9MkNxVCpjZGkGP/KMCsfzoqePbYudGQJ65F2IRlt4cUB1OavdXQzkH
         9Rxw==
X-Gm-Message-State: AOJu0YwRvWRoUPH3iaZWeAefC7DgvAZB15qspK/YZqjT5EOK+zxjqWw0
	afdLC7sP293FLVhy1sdiq4KzcXNDi6KzbnAnt7sZ/Rb89JkdDX1201Gk36gYdSA29HE=
X-Gm-Gg: AeBDietL3LCvPhKT9JfaiKphsmYcMaYY6sFV8krBfSL7SpLdfKyvC8GqDXAMOaU0+e8
	G8JyLxyRUAC8xVZ0+73FkQA0YT8XZZKvIXYI0W5cZ+6INdBLDW6tqYcNs1u7c6e813nT/MOW2d6
	6yORxR81c9WSMI2VM9zNLeFfrh3PhRicUvtAVZVkopFIJnIet8QYh+cmC8Jy4asPl49ZesP1cax
	q+M/Wv1NN6bqoPPHQ1JQUUUUEL6u/YTTGA6jWT94CxjwNS1kcCWCMeemMS37HeL/UbDQDvJ0Axu
	7X/fpeQK8dmChLMMYzRHVL2vPOwu2om3Gj45oP9kYRjsEan1TpMfn/CUiv3VB6OnBOLqbu1hfbf
	a5c1CnyRg9hKsB6hwtfqI/uXGKXcvkNr9CRyeu0G9mN5ISfpr4K3w/NQz9tFngol4u0JQjDIrY0
	nB6l7b9vZ9nZ0vZhWMbO5P2UNSB5p0N8ldYgldn7eyybNaZzj6uqGjxg==
X-Received: by 2002:a05:6000:24c5:b0:43d:33a0:f5b6 with SMTP id ffacd0b85a97d-43d33a0f5d0mr23415397f8f.2.1775630881143;
        Tue, 07 Apr 2026 23:48:01 -0700 (PDT)
Received: from hackbase (95-24-76-124.broadband.corbina.ru. [95.24.76.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f7d4esm48976238f8f.34.2026.04.07.23.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:48:00 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Popov <alex.popov@linux.com>
Subject: [PATCH 5.15.y] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free
Date: Wed,  8 Apr 2026 09:47:34 +0300
Message-ID: <20260408064746.32988-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040720-gloss-outwit-968c@gregkh>
References: <2026040720-gloss-outwit-968c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233774-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[alex.popov@linux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,linux.com:email,linux.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: F1B7C3B7B48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently we execute `SET_NETDEV_DEV(dev, &priv->lowerdev->dev)` for
the virt_wifi net devices. However, unregistering a virt_wifi device in
netdev_run_todo() can happen together with the device referenced by
SET_NETDEV_DEV().

It can result in use-after-free during the ethtool operations performed
on a virt_wifi device that is currently being unregistered. Such a net
device can have the `dev.parent` field pointing to the freed memory,
but ethnl_ops_begin() calls `pm_runtime_get_sync(dev->dev.parent)`.

Let's remove SET_NETDEV_DEV for virt_wifi to avoid bugs like this:

 ==================================================================
 BUG: KASAN: slab-use-after-free in __pm_runtime_resume+0xe2/0xf0
 Read of size 2 at addr ffff88810cfc46f8 by task pm/606

 Call Trace:
  <TASK>
  dump_stack_lvl+0x4d/0x70
  print_report+0x170/0x4f3
  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
  kasan_report+0xda/0x110
  ? __pm_runtime_resume+0xe2/0xf0
  ? __pm_runtime_resume+0xe2/0xf0
  __pm_runtime_resume+0xe2/0xf0
  ethnl_ops_begin+0x49/0x270
  ethnl_set_features+0x23c/0xab0
  ? __pfx_ethnl_set_features+0x10/0x10
  ? kvm_sched_clock_read+0x11/0x20
  ? local_clock_noinstr+0xf/0xf0
  ? local_clock+0x10/0x30
  ? kasan_save_track+0x25/0x60
  ? __kasan_kmalloc+0x7f/0x90
  ? genl_family_rcv_msg_attrs_parse.isra.0+0x150/0x2c0
  genl_family_rcv_msg_doit+0x1e7/0x2c0
  ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
  ? __pfx_cred_has_capability.isra.0+0x10/0x10
  ? stack_trace_save+0x8e/0xc0
  genl_rcv_msg+0x411/0x660
  ? __pfx_genl_rcv_msg+0x10/0x10
  ? __pfx_ethnl_set_features+0x10/0x10
  netlink_rcv_skb+0x121/0x380
  ? __pfx_genl_rcv_msg+0x10/0x10
  ? __pfx_netlink_rcv_skb+0x10/0x10
  ? __pfx_down_read+0x10/0x10
  genl_rcv+0x23/0x30
  netlink_unicast+0x60f/0x830
  ? __pfx_netlink_unicast+0x10/0x10
  ? __pfx___alloc_skb+0x10/0x10
  netlink_sendmsg+0x6ea/0xbc0
  ? __pfx_netlink_sendmsg+0x10/0x10
  ? __futex_queue+0x10b/0x1f0
  ____sys_sendmsg+0x7a2/0x950
  ? copy_msghdr_from_user+0x26b/0x430
  ? __pfx_____sys_sendmsg+0x10/0x10
  ? __pfx_copy_msghdr_from_user+0x10/0x10
  ___sys_sendmsg+0xf8/0x180
  ? __pfx____sys_sendmsg+0x10/0x10
  ? __pfx_futex_wait+0x10/0x10
  ? fdget+0x2e4/0x4a0
  __sys_sendmsg+0x11f/0x1c0
  ? __pfx___sys_sendmsg+0x10/0x10
  do_syscall_64+0xe2/0x570
  ? exc_page_fault+0x66/0xb0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>

This fix may be combined with another one in the ethtool subsystem:
https://lore.kernel.org/all/20260322075917.254874-1-alex.popov@linux.com/T/#u

Fixes: d43c65b05b848e0b ("ethtool: runtime-resume netdev parent in ethnl_ops_begin")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Popov <alex.popov@linux.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260324224607.374327-1-alex.popov@linux.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
(cherry picked from commit 789b06f9f39cdc7e895bdab2c034e39c41c8f8d6)
---
 drivers/net/wireless/virt_wifi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index dd6675436bda..4dca9827a420 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -553,7 +553,6 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 	eth_hw_addr_inherit(dev, priv->lowerdev);
 	netif_stacked_transfer_operstate(priv->lowerdev, dev);
 
-	SET_NETDEV_DEV(dev, &priv->lowerdev->dev);
 	dev->ieee80211_ptr = kzalloc(sizeof(*dev->ieee80211_ptr), GFP_KERNEL);
 
 	if (!dev->ieee80211_ptr) {
-- 
2.53.0


