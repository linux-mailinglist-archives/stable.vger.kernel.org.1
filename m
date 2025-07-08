Return-Path: <stable+bounces-160599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAEBAFD0E2
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F28484CE7
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C1C2E49A4;
	Tue,  8 Jul 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hbtbRR5I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E3264F9C;
	Tue,  8 Jul 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992126; cv=none; b=E79vyFo2xSArABH8SgiEtvdqS4xdXtHF98fscePnjMzyRDvaXyLg1nmiDtVuJhZMquOlcA5WzhuylYkbvHS8KQCX0RsRCa7jo+OpCYQh4tqR90cIbEd4TN0Ir9L+F3/U4RqLIYBJi7ADQjunhdQoh7MqEHlLrvzPWjlUmJ9y9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992126; c=relaxed/simple;
	bh=3wYeay9j9Sbbb9EWlZ2ipEfaNEu6yg26o38sm+ZKmHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJTC633uH2QWsgM6HlocDC901jizKd1gC+bXRpg3KeviO3g9HqhdBscNHJ1Bum+tKoL06kmSdnFgceBhYJscqZH8pGLogJcn90Fz4KKAxRQMzafnAly2w/bWQ+gjWt1XN8gKo/e5evVyUuvieXhkYpcCe+tQaZk2elWgelRWSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hbtbRR5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4E2C4CEF5;
	Tue,  8 Jul 2025 16:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992126;
	bh=3wYeay9j9Sbbb9EWlZ2ipEfaNEu6yg26o38sm+ZKmHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hbtbRR5ILIg5tqEjtFcqQRpaJfPw2oQLJWYF8ohQ9gu8wsDWwXf6mEWtt81pNBmq8
	 KzPrHGJrUEGCQ2KFowiuh0S06pDKi44R1xw65SO0kCKSoeAnMPH4QfrV1rzP5klijx
	 bMR4JmTkkc48ir+WGKQcq3P51DYhCFX2Hn6XyVA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 67/81] net: usb: lan78xx: fix WARN in __netif_napi_del_locked on disconnect
Date: Tue,  8 Jul 2025 18:23:59 +0200
Message-ID: <20250708162227.095654021@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 6c7ffc9af7186ed79403a3ffee9a1e5199fc7450 ]

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

Fixes: ec4c7e12396b ("lan78xx: Introduce NAPI polling support")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20250627051346.276029-1-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index feff1265cad6f..0f1c9009d793e 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4231,8 +4231,6 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
 
-	netif_napi_del(&dev->napi);
-
 	udev = interface_to_usbdev(intf);
 	net = dev->net;
 
-- 
2.39.5




