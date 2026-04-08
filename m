Return-Path: <stable+bounces-233764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHorOu3z1Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:21:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 954033B7827
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B273301106E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F5F3624AF;
	Wed,  8 Apr 2026 06:21:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA14635C1B6
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775629285; cv=none; b=aHIYEEjxQHSVk1oXgG+UqCgJ6FAktap+6k3FUBoWaCBuHzqTlJdMC6VyNiZM5joYbkiv6Cg6HNpbgT2OK5/jognucUpUgS2NDExq6KA5rlu8p/UIJwf29MCLhoEUmY/odi23bgmtB1YZzQ+O0Y1lkaGBPnzfWlrAazxad/JT+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775629285; c=relaxed/simple;
	bh=PE/7KOQTUUI4eFe1WC1G6sJrqh0+D5Qk7KgGxUkU91A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrGmkbTSxY16Qt//NflIVRNR0XFACx0NjFvwY17T5xq/0+By1E2i+jlJbseCLlvPvXRfqLRf5XkM5EoHBmYZon0DBaLlTaYwWxBSmLeUFstZzJQcpvUPWp86pJvqXYF0W50G5D/GJSPe1UOcQqKr7l0zy4OyLAcHmiZJontlrbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so6361454e87.2
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 23:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775629282; x=1776234082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+aQ7qZB62vw22URUg0yl7/bcBDdLQ6KVExRcwvTyWNM=;
        b=hxY4WCKxij38YR3sEyBQBj+OytTzOxB/JJluf1UrrhwQ1HJpYwu5t9Oai1g55ss73k
         WXLaElECm6h4jhE5EuhHwR1XAnxk9RhJiDvaRKnIHwM3VZzkescAaObR9JFAP1e04QOM
         Rec/6eJVXaHXkO8kadvLhvA2l0DWX5uVMe/pw2VH403M2WiY57GqiFXbKijfceFdEd53
         HwDrn+Fk/u4Cb7qStCBh4LmNygtFw67uh9MJ4xY0FQuSMhf+86vSAtN22JKO2P7Rwq3G
         WNMez7o7IXQCsDlihnfnXKpwK0LINh/Tb+OhoDZu22U5TKNLqjSYqSD992/lhs71eu+B
         JYPQ==
X-Gm-Message-State: AOJu0Yy9+jCg6GS6wZnCWNAqIi9LyedMb5VTAdRliAlxp+KX5KJT6NyP
	SguxRsHIrGdLShwaQFBdN4RsQcKRi5t7cfLrYcE6juV2vJfRgJ4/vkySZLzu6NQFkeI=
X-Gm-Gg: AeBDiesF9q9E5ovpwHHwUTIOV0h2/fPev1uv2+Ht8G/ENsL/MIltnRwCpiB+wQtn/Sa
	HGuQOIgQrtfGFrIRVTb4VbihL09x98BH3h5BtQaMizkPHDZjiQOVUH0SgqkKRgg2Ux2q6oKRUeJ
	XY0LYPW3jU5ngapGiogYNRDD0DY6E3qMHUQkf04VPI8Pu6/6jsXbLRqf+JE4pFJC6BHNFZXbLrX
	ZAm+y4RLyGXm/h1dD+bhqerakNH2PMzijQWnchmxRg+uRGtdCjHj7FzRx09xGZWA/lAYvBSJizz
	JgjySED9OPNPxNurQeGJN6GXbJXCJmU4YVIGRLIJSf02Cs72jiMVh99j49S6qB+bEMH7MX0TLWT
	BZpkzHDj9+kLbIJxCGTtBH9IGp4kCysh8AuOiqzU3op3AP4H1gxbkJRHOx/7YKlHmx84qQwj5Bd
	FTeDaUJMAHf0Fq/iA1f6DXDXQO2fUF02/rTtsk72AsoX0Fymybvk71zQ==
X-Received: by 2002:a05:6512:3caa:b0:5a2:d239:cb9c with SMTP id 2adb3069b0e04-5a33757bdc2mr6725584e87.28.1775629281559;
        Tue, 07 Apr 2026 23:21:21 -0700 (PDT)
Received: from hackbase (95-24-76-124.broadband.corbina.ru. [95.24.76.124])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ccc9bcsm4476796e87.57.2026.04.07.23.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:21:20 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Popov <alex.popov@linux.com>
Subject: [PATCH 6.18.y] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free
Date: Wed,  8 Apr 2026 09:20:56 +0300
Message-ID: <20260408062111.31128-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040716-embezzle-hula-66ad@gregkh>
References: <2026040716-embezzle-hula-66ad@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233764-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[alex.popov@linux.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.942];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.com:email,linux.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: 954033B7827
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


