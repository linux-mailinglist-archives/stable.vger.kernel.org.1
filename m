Return-Path: <stable+bounces-233770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGBTO8z31Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:38:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA03B7A1B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008CF301F1B6
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664AE3644C3;
	Wed,  8 Apr 2026 06:37:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC70435B64E
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630253; cv=none; b=IvQfagmovHdtJL7aHP9Ec/tLqHNbOpGBKUaQ/Wm8ZNT1sL6zgZLf1hADZZsJUQYt/HJPvc2yZeMa8WZvNFaX/BXDaMBucqkV8gnuXjHNT/s3Pvr6FcNxO1MuoevsESqYbjPVEg2kb+n5kqtD98+8R9UQRLJR98vyx+rpSu96eFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630253; c=relaxed/simple;
	bh=XsFV+v2C+zYyRfiliO+yf4TW0iRSNmp4d/9mm36SEhg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb+PFC2jPirMQXaVv+FSvRVocajQLjjOROuAjuDUOzm2q2LucSnmHAgjTvVHL0Oe8AsExvRc21EeUVSKGJuw1sZRh81sl2IOYAqoIBVJhuC0BPit7o4nEdT1fMMm/Dj6ApNRYKb0+luWp/CEQgdadiaOySpaFHdqv0P6B/YkZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfd832155so3648854f8f.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 23:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775630250; x=1776235050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7aIFLAdRVzP09EitKQQ2JFHEsP86nowNcCxxm6hoC0=;
        b=EZYEPKESeSCXV2zhm/SqtpLOSKD1vqAMuEeF8twvhsnMzOsn3b8MNQDGqVN5+pj3nY
         aHcwnWQhS9UKQ33pWIRfuclhN0HDsfC0Fh5vqD1qMyLx7hSYnQ6BBxZs/EDRf2cnlw8r
         saGGwQaSb9A0LeIzq4oDuKo7K1wCXdbQKSGckhnEZsPlZfcL4zzihm4HHbLiSFRs99q+
         16s2A9uCx6mSPIF7BKtkBxBEGznOKj5gFOy8g/u98rKyCZ880+f65bZGOCJIcIxkE5mE
         batN9K4DG2Gp3KjkBpybJKkHF4BTRZGNlQ4et5W1pJrx98KQxS7eEhxboVsCVsBdpe2H
         gXYQ==
X-Gm-Message-State: AOJu0YxDfOtBL65v26zY7Y+5Ys/+Cs50Gs9r+GAUJ4lAj6Q93lBHmhQh
	t6LV4wiVUBKaM1/F4NJhH0MwsqqB8BGt5Y2FH7ti8ACEbk9AgdSf/UxheBcvRSlnmdE=
X-Gm-Gg: AeBDieuqPGTOduKz0yerio7LpzBNRrxo1No5jmnKt3P0oeCLmGgg0GW7/Nnklifwm/j
	SSiead77dFa7FkT0wMITbWuCnfBEfcE5fGjWA3Z8y8/S1NEIJVa/C0l4Idyju7lYJs/ZoezQ586
	obGSE5VtK7du1msiFtHogYw8wYS01Pl7KPgMakr7Fh9M4zcFq41oeg9W5G1/x3A8GWHierl45+M
	uxIOMK2IgsWKGogPd6WWa/FLlE//9c0KGXwcQyIhD8lJ2NnogL3H6knJVkiISxqvSmKtfX+pviH
	ZeWaaL6Vyh1W5ndfqEwMVLDog1Qx7VcmWvIHy5X46NL2hXvj8QdaIJ+hy3if474TrRVwC1+8ytz
	y1W45r/qO610Au5YPUK24UGZDN5CPdMH/6Q3XNhfJcw/1NfmhFgTjx5pc1l+LsaaO8ThwIUUa/6
	0S3u7lLe8Tqf525lHx7OKh2YhGIJ47ePyuzOb9lw+gY0E1e+eGR0eopnxa5aQtky8R
X-Received: by 2002:a05:6000:2c0c:b0:43d:4a74:8ec7 with SMTP id ffacd0b85a97d-43d4a749006mr7893226f8f.20.1775630249723;
        Tue, 07 Apr 2026 23:37:29 -0700 (PDT)
Received: from hackbase (95-24-76-124.broadband.corbina.ru. [95.24.76.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm56535808f8f.3.2026.04.07.23.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:37:29 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Popov <alex.popov@linux.com>
Subject: [PATCH 6.6.y] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free
Date: Wed,  8 Apr 2026 09:36:57 +0300
Message-ID: <20260408063716.32013-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040718-degraded-scrabble-d0ef@gregkh>
References: <2026040718-degraded-scrabble-d0ef@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233770-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[alex.popov@linux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.com:email,linux.com:mid,linuxfoundation.org:email,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 20EA03B7A1B
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
index 2977b30c6d59..55b2d44e4315 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -555,7 +555,6 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 	eth_hw_addr_inherit(dev, priv->lowerdev);
 	netif_stacked_transfer_operstate(priv->lowerdev, dev);
 
-	SET_NETDEV_DEV(dev, &priv->lowerdev->dev);
 	dev->ieee80211_ptr = kzalloc(sizeof(*dev->ieee80211_ptr), GFP_KERNEL);
 
 	if (!dev->ieee80211_ptr) {
-- 
2.53.0


