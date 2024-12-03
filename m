Return-Path: <stable+bounces-96815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364599E277F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B836B36EF4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D351FAC5A;
	Tue,  3 Dec 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bzWNzUQP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73811FAC53;
	Tue,  3 Dec 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238673; cv=none; b=D33J75xHrzSZv+164SNQMFi8NUzoNyd51E/W+L8nDr5C3xiV78qB30Ns3A3aEpXIy6sun6YvUkV/T+3xYilyGixo4hTHNa/YAPGy2L78sAqHDD5CjmwP1SgFXvBvVp+azjgLpVl+EgqMvklzD9oRxHAlvtFEqywATR45xJWn8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238673; c=relaxed/simple;
	bh=Sa4GcU+SibPxy35O2JTr0g0O/8Swzhav0ADIFIOTF5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HC9/pWjDu7G8Oc3HULaI7CO9n5sZ2B1lHa0/7oTRS6MgNnsEFCEJQoS9S8NxgiAW0Mn1LaDaQgkQ13ruvPuAD48jGtlIyt5V52kkwu9jfTkzozf7CNLNqHu1PCgVdvImI9N4y4O7j7gMi9se51tDD34Ec055zUWU/AZ6PdFIvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bzWNzUQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF3CC4CECF;
	Tue,  3 Dec 2024 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238672;
	bh=Sa4GcU+SibPxy35O2JTr0g0O/8Swzhav0ADIFIOTF5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzWNzUQPjc7oO9OI2am4vnqGrk+urEW0Ul2A8Jy/JHx094HTagxEOmDAh76Pq8ojb
	 +AnqvxtgDpty8P+22c0jeLb6H1xdLehfjSM1f0UaHUT/gJxP+MsJZ2TBdHquSzmbQz
	 VadRUjp/IbtF7Suws4pVapFLLljv80tgp0BEk0R0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Lu <chris.lu@mediatek.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 358/817] Bluetooth: btmtk: adjust the position to init iso data anchor
Date: Tue,  3 Dec 2024 15:38:50 +0100
Message-ID: <20241203144009.807059275@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Lu <chris.lu@mediatek.com>

[ Upstream commit 61c5a3def90ac729a538e5ca5ff7f461cff72776 ]

MediaTek iso data anchor init should be moved to where MediaTek
claims iso data interface.
If there is an unexpected BT usb disconnect during setup flow,
it will cause a NULL pointer crash issue when releasing iso
anchor since the anchor wasn't been init yet. Adjust the position
to do iso data anchor init.

[   17.137991] pc : usb_kill_anchored_urbs+0x60/0x168
[   17.137998] lr : usb_kill_anchored_urbs+0x44/0x168
[   17.137999] sp : ffffffc0890cb5f0
[   17.138000] x29: ffffffc0890cb5f0 x28: ffffff80bb6c2e80
[   17.144081] gpio gpiochip0: registered chardev handle for 1 lines
[   17.148421]  x27: 0000000000000000
[   17.148422] x26: ffffffd301ff4298 x25: 0000000000000003 x24: 00000000000000f0
[   17.148424] x23: 0000000000000000 x22: 00000000ffffffff x21: 0000000000000001
[   17.148425] x20: ffffffffffffffd8 x19: ffffff80c0f25560 x18: 0000000000000000
[   17.148427] x17: ffffffd33864e408 x16: ffffffd33808f7c8 x15: 0000000000200000
[   17.232789] x14: e0cd73cf80ffffff x13: 50f2137c0a0338c9 x12: 0000000000000001
[   17.239912] x11: 0000000080150011 x10: 0000000000000002 x9 : 0000000000000001
[   17.247035] x8 : 0000000000000000 x7 : 0000000000008080 x6 : 8080000000000000
[   17.254158] x5 : ffffffd33808ebc0 x4 : fffffffe033dcf20 x3 : 0000000080150011
[   17.261281] x2 : ffffff8087a91400 x1 : 0000000000000000 x0 : ffffff80c0f25588
[   17.268404] Call trace:
[   17.270841]  usb_kill_anchored_urbs+0x60/0x168
[   17.275274]  btusb_mtk_release_iso_intf+0x2c/0xd8 [btusb (HASH:5afe 6)]
[   17.284226]  btusb_mtk_disconnect+0x14/0x28 [btusb (HASH:5afe 6)]
[   17.292652]  btusb_disconnect+0x70/0x140 [btusb (HASH:5afe 6)]
[   17.300818]  usb_unbind_interface+0xc4/0x240
[   17.305079]  device_release_driver_internal+0x18c/0x258
[   17.310296]  device_release_driver+0x1c/0x30
[   17.314557]  bus_remove_device+0x140/0x160
[   17.318643]  device_del+0x1c0/0x330
[   17.322121]  usb_disable_device+0x80/0x180
[   17.326207]  usb_disconnect+0xec/0x300
[   17.329948]  hub_quiesce+0x80/0xd0
[   17.333339]  hub_disconnect+0x44/0x190
[   17.337078]  usb_unbind_interface+0xc4/0x240
[   17.341337]  device_release_driver_internal+0x18c/0x258
[   17.346551]  device_release_driver+0x1c/0x30
[   17.350810]  usb_driver_release_interface+0x70/0x88
[   17.355677]  proc_ioctl+0x13c/0x228
[   17.359157]  proc_ioctl_default+0x50/0x80
[   17.363155]  usbdev_ioctl+0x830/0xd08
[   17.366808]  __arm64_sys_ioctl+0x94/0xd0
[   17.370723]  invoke_syscall+0x6c/0xf8
[   17.374377]  el0_svc_common+0x84/0xe0
[   17.378030]  do_el0_svc+0x20/0x30
[   17.381334]  el0_svc+0x34/0x60
[   17.384382]  el0t_64_sync_handler+0x88/0xf0
[   17.388554]  el0t_64_sync+0x180/0x188
[   17.392208] Code: f9400677 f100a2f4 54fffea0 d503201f (b8350288)
[   17.398289] ---[ end trace 0000000000000000 ]---

Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmtk.c | 1 -
 drivers/bluetooth/btusb.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 2b7c80043aa2e..4b30d13ad5e96 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -1215,7 +1215,6 @@ static int btmtk_usb_isointf_init(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int err;
 
-	init_usb_anchor(&btmtk_data->isopkt_anchor);
 	spin_lock_init(&btmtk_data->isorxlock);
 
 	__set_mtk_intr_interface(hdev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2408e50743ca6..09afd75145ed9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2670,6 +2670,7 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	}
 
 	set_bit(BTMTK_ISOPKT_OVER_INTR, &btmtk_data->flags);
+	init_usb_anchor(&btmtk_data->isopkt_anchor);
 }
 
 static void btusb_mtk_release_iso_intf(struct btusb_data *data)
-- 
2.43.0




