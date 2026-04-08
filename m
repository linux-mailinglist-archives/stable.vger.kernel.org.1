Return-Path: <stable+bounces-233772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKDQFSX51Wn4/gcAu9opvQ
	(envelope-from <stable+bounces-233772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:43:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E125C3B7ADC
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 08:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 877393011047
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 06:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C0364EB6;
	Wed,  8 Apr 2026 06:43:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E98364E88
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630620; cv=none; b=Bv+w9T3CS95R8xMl5/n4Vuv/2ZmVXCWCD7a/EZ1hUOWK9ZKlFaLYJHiywIJDfBB9gBkuVoMi2ckf1Rj18b8zFoSQunM09NWLCk8OYAU0Yu57DgjheWsT6N/83Pns66FVZ0q5VmnDzl+WoWeMeeOq3vFDhsEYtgrUzfs04trk5dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630620; c=relaxed/simple;
	bh=G+q281chvuvhqbXJ+38p5NFB+rljrSWTNPeTdojNm9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8ggMlYXob7OFTXDbA7YfD4AMfovG+VHw+dzxIWRxX2VR3VDwfCi7ByKB8LzmMXWbZb/8hTIs6IMJJU0Dhl01jjLtByv6RzbHiy/Kq/YVKmPUArDi5ALUhgCVBYdtx/W3vIUquTW1fP+Sk0MlDFL1e4OjbzU9bE1JncWbcC4UwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a0fc5e2c59so5883454e87.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 23:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775630617; x=1776235417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JZhpOO1/NQ390zCAVE3GeLvUQ1e64LFEhYwAmdVz/Mw=;
        b=kFcdykCxv3FSkyn6dEsOLdLGddZa1/o79NId4/t8cjs0/gkF0FH+YXwKFb131+hzx0
         wk5lf/cMO+k/YmuI/gxrLMWwR9pdkITZ99+NZPDLdXthDoPhNfwgHNvQTJu53SiE92zl
         VcZnLhoSdNkpF83QNrKXbudGDPByR50N+GxSaPARGUhEHxVh8iPId/jqkHAoH4o+hb5Z
         TkNdOx/R+U7VMGtewp26GNs34Ua5t63osYwtD7fGpg2u9teQBy44UaTltbekIZmOeWYo
         8LXI5Tr/RFS9pO2GR264hskEsKT+eFHs4QNWutCd6/s2aEv0+6JMcMN6RQLduK6Lm53K
         fRhQ==
X-Gm-Message-State: AOJu0YzU1Gw7ETn5BJcOe2avNJb+VAugGQOlsya69bgHG7ANmLCDZZIx
	yt844oH5DLG0IkdlwlfKJtjjb+WIRm5h2NBe64Eu2s8Sic2kcuEqkRUJcjj+reouhkw=
X-Gm-Gg: AeBDieusUjmYU1JkKCVjvKv7hGCk2UF0qYjHPfTSTSuj5xer0mZn+KX9lQt1pDkGImU
	X2kbAF5gFogn553jIKNi01TSJUhppIOraxDgcf9uxIN5OM0PTGNmlzDnAosWtGcQsD/kfRAspc0
	h2Gnccu2O1JpIFTTncWPLPeIS4r/XF8tt8EwYkqHKVMo/QAOzyNZ7skZxo9rS5214Z08F2IyL6r
	MpcHLrx4T0zgkPXsl0aywjMl1qGbUMElcPVBZzUEDnSwfrjUyY0to4EDy21J3F80jk3JLyvRjgv
	jBmM9aFLvFxQMYWkCrQHl1rACdNG6SX221mZis0uTwnOLE+HaPH+392p5+bg7MQRRkZ6laNvfvk
	bOlBiuoKw9opPcQC3j4BpbsIDwXkqVkC2y03fvjmsEl9nNJGr063bB+PLxNidf2vSQLMuIIJWtg
	JPgPeNSiQlcLtsI4i/xkr16Z4OAjdRjAOGxZ/YNYr5lNQQblg0nMdt9yX+HPpK4sBP
X-Received: by 2002:a05:6512:224f:b0:5a3:cd17:8d71 with SMTP id 2adb3069b0e04-5a3cd178dd9mr7363775e87.21.1775630616547;
        Tue, 07 Apr 2026 23:43:36 -0700 (PDT)
Received: from hackbase (95-24-76-124.broadband.corbina.ru. [95.24.76.124])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6ccca2dsm4528889e87.60.2026.04.07.23.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:43:35 -0700 (PDT)
From: Alexander Popov <alex.popov@linux.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Popov <alex.popov@linux.com>
Subject: [PATCH 6.1.y] wifi: virt_wifi: remove SET_NETDEV_DEV to avoid use-after-free
Date: Wed,  8 Apr 2026 09:43:14 +0300
Message-ID: <20260408064323.32628-1-alex.popov@linux.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040719-cofounder-unworldly-b566@gregkh>
References: <2026040719-cofounder-unworldly-b566@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233772-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.com:email,linux.com:mid]
X-Rspamd-Queue-Id: E125C3B7ADC
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
index fb4d95a027fe..eac4838807c7 100644
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


