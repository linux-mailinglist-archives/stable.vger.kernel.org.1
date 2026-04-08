Return-Path: <stable+bounces-233918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPCgGu5g1mmDEwgAu9opvQ
	(envelope-from <stable+bounces-233918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:06:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5083BD65A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 766C63004934
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795253D0914;
	Wed,  8 Apr 2026 14:06:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51842F3C10
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657196; cv=none; b=qdkr+Jy4VNDUbP47lfrKUDw0DN1mbcWkRpLn12lERxuIa3qmiN6clP96T46I7h2TPvph+ulv11FokRZq4NPPcD6Y8u9TdyN/4DIRFwnZPoVgrHVF3MHUJ/ovIESVo7As72WZWRGGAA6XPpOmjkzSnNgAyVKIyclCedm/TY1fJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657196; c=relaxed/simple;
	bh=PE/7KOQTUUI4eFe1WC1G6sJrqh0+D5Qk7KgGxUkU91A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4cASjdlielhWM2uaUmhRPxo4iOvbfVmrPIJMFfp22c085ayoaHR7aUiRdR2NW1YIgcaIWXbkOhPvCUU9QboQNB8ZDQzDdXxH8qR1YqDJHOupMShX51azeVGoRtRUPHx1T5Eqvc/d1+NixFVlZzLLXvGOC4az074R3KANnxo0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2c500750dso7624446e87.1
        for <stable@vger.kernel.org>; Wed, 08 Apr 2026 07:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775657193; x=1776261993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+aQ7qZB62vw22URUg0yl7/bcBDdLQ6KVExRcwvTyWNM=;
        b=mpoa9q490NknHYckpk7x82BudBybdZDzj0Rkxo38bJ5IasZgK+HSijNR+XPxhrVKwu
         qxa6OF0MQqDI3tPQoTpeAWvgtm5DwYgoBBWWNA86avrSixJe0fjxoYMho7jPaROyEhI/
         ucMGIRfj3FSbWVVt/UQaoYxM2rlZCoZpfalWFZlLB56mOXQaxXXzcOVcCDbzyljm/aP9
         CVQM/SP0QUCS4NJNI8Svo5FEY7doH5T3IS3UgqHl8lArf2mEL2SRoIiOJ5/pN+k195zT
         oNq4eVCTaajU6w+X6uf5+1mM1XT0pp9ZqfM6kIjhR/a3myHb2QWECCoce/B2Tr+il3Be
         401g==
X-Gm-Message-State: AOJu0Yz+vH4AqtFFH6UP4SezTEhwjd2Wpa4cAQ5efE1bOKjQnvyuUPku
	iPMMaAiCvXY+RARgaT5U0mkKTEAHW+oDlVmAszdevUMghc+wHxRLB1av6OonVC3r
X-Gm-Gg: AeBDietE4Jiyd/PkxiCv7vwHfVzV1Y1nWG32p6FQrth1IAqtjotS4S7llioUU1L0VAK
	HtBoTISP8Dc8TQMbvwz2UWTtow+Iga0Zq8u0hokpR2QQZLewWa2wJzPVmmYVjB0SkWi1W1Fr3yi
	gbwpySiOdu04rUPRh7nKGayC4/b6BEIDrwIs/Abl6jRIBMWzYgfDRLFCEEpTciV4je5l3kwRAd6
	kxABFKgSqXGvEQAkYZZ+nyFQyYATwXumP/iAHtM6KcUGDcLTIYW+CF/MKGy6Lb9heEkazGkj1U3
	Hs3yaPwBPOb0CFnQoxCvmrxaeSa1wHGLhUpi+3nB7OQmrkcTogGbrbuBLdid8oy1gXRJ2WZJTqe
	4Yve9Tz63AYFgqs8RUs3ViaLj736ZRE0N3SWNnz+btk9ZD7VT7wiNjBQAoWUoGUa1w4u5KuDbfb
	PpkMB1QyOrZr5KrOlYFQIr
X-Received: by 2002:a05:6512:b83:b0:59e:65ff:e57e with SMTP id 2adb3069b0e04-5a33755d848mr5949305e87.12.1775657192082;
        Wed, 08 Apr 2026 07:06:32 -0700 (PDT)
Received: from hackbase ([213.87.138.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ca3100sm4836036e87.35.2026.04.08.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:06:31 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Popov <alex.popov@linux.com>
Subject: [PATCH 6.19.y] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free
Date: Wed,  8 Apr 2026 17:06:05 +0300
Message-ID: <20260408140620.54527-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040715-good-overture-8018@gregkh>
References: <2026040715-good-overture-8018@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233918-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[alex.popov@linux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linux.com:email,linux.com:mid]
X-Rspamd-Queue-Id: 0E5083BD65A
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
 drivers/net/wireless/virtual/virt_wifi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4eae89376feb..cd6b66242bff 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -557,7 +557,6 @@ static int virt_wifi_newlink(struct net_device *dev,
 	eth_hw_addr_inherit(dev, priv->lowerdev);
 	netif_stacked_transfer_operstate(priv->lowerdev, dev);
 
-	SET_NETDEV_DEV(dev, &priv->lowerdev->dev);
 	dev->ieee80211_ptr = kzalloc(sizeof(*dev->ieee80211_ptr), GFP_KERNEL);
 
 	if (!dev->ieee80211_ptr) {
-- 
2.53.0


