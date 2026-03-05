Return-Path: <stable+bounces-223209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKM4NAGYqWlKAgEAu9opvQ
	(envelope-from <stable+bounces-223209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:49:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA06213D4E
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 15:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D003D30980E8
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C329460;
	Thu,  5 Mar 2026 14:34:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44FA3A1A59
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772721281; cv=none; b=QUgbpemlHJ6rTOOyiDyKPf6YXlCX2u5L/jgjj5rnc9hLZTQ71fxRLvPTIzWP3WIHW+J88KvSkHN/rBb6bU8El3Kp0QaAM48678le8nzgXV2z5UI9RKO/tGXmxuMCfyRd+3Va/FncQeGb274d9XucumsegXkVKyT7CZGEPq7Ft+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772721281; c=relaxed/simple;
	bh=1fnU0MUKwFDu+HuPm2g0JEOYCoHt7uKd2I73uTFW9+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQJb+NcvgtpOIkTaG8GIZhKMaJ9RJh8u/cpWE0MgKuo4jYNX+r2RTagVEa7q8kzUj3RveJj3sCZi9yk7drd+ZrTP2e6zqxlg/b1W9FOYzHJ6BigDHFskeXT+oaDUyVVRE5+QBNA8gFHewCIK5ATfTxhpzRouq9OWuq8+dosbw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mZ-000464-Pm; Thu, 05 Mar 2026 15:34:31 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mX-003two-2B;
	Thu, 05 Mar 2026 15:34:31 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vy9mY-00000002E8c-3zeM;
	Thu, 05 Mar 2026 15:34:30 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 4/4] net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect
Date: Thu,  5 Mar 2026 15:34:29 +0100
Message-ID: <20260305143429.530909-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305143429.530909-1-o.rempel@pengutronix.de>
References: <20260305143429.530909-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Rspamd-Queue-Id: 0BA06213D4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223209-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,pengutronix.de:mid,pengutronix.de:email]
X-Rspamd-Action: no action

Remove redundant netif_napi_del() call from disconnect path.

A WARN may be triggered in __netif_napi_del_locked() during USB device
disconnect:

  WARNING: CPU: 0 PID: 11 at net/core/dev.c:7417 __netif_napi_del_locked+0x2b4/0x350

This happens because netif_napi_del() is called in the disconnect path while
NAPI is still enabled. However, it is not necessary to call netif_napi_del()
explicitly, since unregister_netdev() will handle NAPI teardown automatically
and safely. Removing the redundant call avoids triggering the warning.

Full trace:
 lan78xx 1-1:1.0 enu1: Failed to read register index 0x000000c4. ret = -ENODEV
 lan78xx 1-1:1.0 enu1: Failed to set MAC down with error -ENODEV
 lan78xx 1-1:1.0 enu1: Link is Down
 lan78xx 1-1:1.0 enu1: Failed to read register index 0x00000120. ret = -ENODEV
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 11 at net/core/dev.c:7417 __netif_napi_del_locked+0x2b4/0x350
 Modules linked in: flexcan can_dev fuse
 CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 6.16.0-rc2-00624-ge926949dab03 #9 PREEMPT
 Hardware name: SKOV IMX8MP CPU revC - bd500 (DT)
 Workqueue: usb_hub_wq hub_event
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __netif_napi_del_locked+0x2b4/0x350
 lr : __netif_napi_del_locked+0x7c/0x350
 sp : ffffffc085b673c0
 x29: ffffffc085b673c0 x28: ffffff800b7f2000 x27: ffffff800b7f20d8
 x26: ffffff80110bcf58 x25: ffffff80110bd978 x24: 1ffffff0022179eb
 x23: ffffff80110bc000 x22: ffffff800b7f5000 x21: ffffff80110bc000
 x20: ffffff80110bcf38 x19: ffffff80110bcf28 x18: dfffffc000000000
 x17: ffffffc081578940 x16: ffffffc08284cee0 x15: 0000000000000028
 x14: 0000000000000006 x13: 0000000000040000 x12: ffffffb0022179e8
 x11: 1ffffff0022179e7 x10: ffffffb0022179e7 x9 : dfffffc000000000
 x8 : 0000004ffdde8619 x7 : ffffff80110bcf3f x6 : 0000000000000001
 x5 : ffffff80110bcf38 x4 : ffffff80110bcf38 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 1ffffff0022179e7 x0 : 0000000000000000
 Call trace:
  __netif_napi_del_locked+0x2b4/0x350 (P)
  lan78xx_disconnect+0xf4/0x360
  usb_unbind_interface+0x158/0x718
  device_remove+0x100/0x150
  device_release_driver_internal+0x308/0x478
  device_release_driver+0x1c/0x30
  bus_remove_device+0x1a8/0x368
  device_del+0x2e0/0x7b0
  usb_disable_device+0x244/0x540
  usb_disconnect+0x220/0x758
  hub_event+0x105c/0x35e0
  process_one_work+0x760/0x17b0
  worker_thread+0x768/0xce8
  kthread+0x3bc/0x690
  ret_from_fork+0x10/0x20
 irq event stamp: 211604
 hardirqs last  enabled at (211603): [<ffffffc0828cc9ec>] _raw_spin_unlock_irqrestore+0x84/0x98
 hardirqs last disabled at (211604): [<ffffffc0828a9a84>] el1_dbg+0x24/0x80
 softirqs last  enabled at (211296): [<ffffffc080095f10>] handle_softirqs+0x820/0xbc8
 softirqs last disabled at (210993): [<ffffffc080010288>] __do_softirq+0x18/0x20
 ---[ end trace 0000000000000000 ]---
 lan78xx 1-1:1.0 enu1: failed to kill vid 0081/0

Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- Do not move NAPI enable/disable to link up/down callbacks.
- Remove redundant netif_napi_del() call from disconnect path.
- Update commit message to accurately describe the root cause and solution,
  following feedback from maintainer.
---
 drivers/net/usb/lan78xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index f8558b87eaec..19cdf69fa589 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4552,8 +4552,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	phylink_disconnect_phy(dev->phylink);
 	rtnl_unlock();
 
-	netif_napi_del(&dev->napi);
-
 	unregister_netdev(net);
 
 	timer_shutdown_sync(&dev->stat_monitor);
-- 
2.47.3


