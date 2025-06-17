Return-Path: <stable+bounces-153493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA5ADD4B7
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D12177FC2
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3E72EE5FE;
	Tue, 17 Jun 2025 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jo1O0xMp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3212EE60C;
	Tue, 17 Jun 2025 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176140; cv=none; b=gxN9O1Y2p0UoB6Ue8IAjUYpe6AaCPiCK/hRNCna5xLASWr5EQTR4FQX687IVFvy8C8a/i/kq5krMYWEKaKnUAVm4g9LbBC/if1i2xv2WQPrdoy5QTP6k+WaFyzQ/w7o82+2lAM2Z3imw1bL7mXyyElTxwqatEHOQMoNyVKQlnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176140; c=relaxed/simple;
	bh=vUkz5R2O/inHOb7Qkqpz/cdfZZHxKb1R7n9qGnyr2B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCuitwFsDx+xoRDNY/7dW4IUHnlW4CnjNPtsOeChl+x0hU+D1/TJ+8k0LXi3AGG6AvjDWGq/dbqjHZYWvHDQfiTa336SpGGibmunM5LeG9uGn8GtXf7lcmQ7BK7Z2iDRG+2DCvdTgAjtzEtQCI9bv3jkZJbDxmGnRelnHrgqhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jo1O0xMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CCFC4CEE3;
	Tue, 17 Jun 2025 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176140;
	bh=vUkz5R2O/inHOb7Qkqpz/cdfZZHxKb1R7n9qGnyr2B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jo1O0xMpHl2/9qT9Roe8kEmT/86ElRFhvbjqprTVnlP121tXY4yn5Ik3QvQTnnk49
	 SMD7QYZJURmkO1p+kRBZe1ULfrsrZanTM9KjOhwhBtECk8GYIW7uaxnKJY+ELwSXlV
	 FD6elazu/z35JTjMdu5HdAGKsqgpf4NW42QK8C1Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 200/512] net: usb: aqc111: fix error handling of usbnet read calls
Date: Tue, 17 Jun 2025 17:22:46 +0200
Message-ID: <20250617152427.736124740@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 405b0d610745fb5e84fc2961d9b960abb9f3d107 ]

Syzkaller, courtesy of syzbot, identified an error (see report [1]) in
aqc111 driver, caused by incomplete sanitation of usb read calls'
results. This problem is quite similar to the one fixed in commit
920a9fa27e78 ("net: asix: add proper error handling of usb read errors").

For instance, usbnet_read_cmd() may read fewer than 'size' bytes,
even if the caller expected the full amount, and aqc111_read_cmd()
will not check its result properly. As [1] shows, this may lead
to MAC address in aqc111_bind() being only partly initialized,
triggering KMSAN warnings.

Fix the issue by verifying that the number of bytes read is
as expected and not less.

[1] Partial syzbot report:
BUG: KMSAN: uninit-value in is_valid_ether_addr include/linux/etherdevice.h:208 [inline]
BUG: KMSAN: uninit-value in usbnet_probe+0x2e57/0x4390 drivers/net/usb/usbnet.c:1830
 is_valid_ether_addr include/linux/etherdevice.h:208 [inline]
 usbnet_probe+0x2e57/0x4390 drivers/net/usb/usbnet.c:1830
 usb_probe_interface+0xd01/0x1310 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x4d1/0xd90 drivers/base/dd.c:658
 __driver_probe_device+0x268/0x380 drivers/base/dd.c:800
...

Uninit was stored to memory at:
 dev_addr_mod+0xb0/0x550 net/core/dev_addr_lists.c:582
 __dev_addr_set include/linux/netdevice.h:4874 [inline]
 eth_hw_addr_set include/linux/etherdevice.h:325 [inline]
 aqc111_bind+0x35f/0x1150 drivers/net/usb/aqc111.c:717
 usbnet_probe+0xbe6/0x4390 drivers/net/usb/usbnet.c:1772
 usb_probe_interface+0xd01/0x1310 drivers/usb/core/driver.c:396
...

Uninit was stored to memory at:
 ether_addr_copy include/linux/etherdevice.h:305 [inline]
 aqc111_read_perm_mac drivers/net/usb/aqc111.c:663 [inline]
 aqc111_bind+0x794/0x1150 drivers/net/usb/aqc111.c:713
 usbnet_probe+0xbe6/0x4390 drivers/net/usb/usbnet.c:1772
 usb_probe_interface+0xd01/0x1310 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
...

Local variable buf.i created at:
 aqc111_read_perm_mac drivers/net/usb/aqc111.c:656 [inline]
 aqc111_bind+0x221/0x1150 drivers/net/usb/aqc111.c:713
 usbnet_probe+0xbe6/0x4390 drivers/net/usb/usbnet.c:1772

Reported-by: syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3b6b9ff7b80430020c7b
Tested-by: syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com
Fixes: df2d59a2ab6c ("net: usb: aqc111: Add support for getting and setting of MAC address")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://patch.msgid.link/20250520113240.2369438-1-n.zhandarovich@fintech.ru
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/aqc111.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index ff5be2cbf17b9..453a2cf82753f 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -30,10 +30,13 @@ static int aqc111_read_cmd_nopm(struct usbnet *dev, u8 cmd, u16 value,
 	ret = usbnet_read_cmd_nopm(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR |
 				   USB_RECIP_DEVICE, value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < size)) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
+	}
 
 	return ret;
 }
@@ -46,10 +49,13 @@ static int aqc111_read_cmd(struct usbnet *dev, u8 cmd, u16 value,
 	ret = usbnet_read_cmd(dev, cmd, USB_DIR_IN | USB_TYPE_VENDOR |
 			      USB_RECIP_DEVICE, value, index, data, size);
 
-	if (unlikely(ret < 0))
+	if (unlikely(ret < size)) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		netdev_warn(dev->net,
 			    "Failed to read(0x%x) reg index 0x%04x: %d\n",
 			    cmd, index, ret);
+	}
 
 	return ret;
 }
-- 
2.39.5




