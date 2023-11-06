Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B584B7E2548
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjKFNaX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjKFNaW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:30:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37625D8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:30:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76658C433C8;
        Mon,  6 Nov 2023 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277418;
        bh=lqrHdQfQqa5vSGxH53KgvflLLjtGg5y/UjPuiO1Ru5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nahXkh5+CqlGrYT7zKxYFPXzHsFHH5ruUwvg7i6C6fdTSkpSvcbNs6eLPVGYn17yY
         zO/79gUP607r1lHOwBbR0z31kv946j1Mkh+v9Vyt2RVoH8WiTyD8DyzIr3IDty7Sft
         0S1pYuLQoujYfDnMALcIv2nZO8emKHRiOIF8+h/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shigeru Yoshida <syoshida@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+c74c24b43c9ae534f0e0@syzkaller.appspotmail.com,
        syzbot+2c97a98a5ba9ea9c23bd@syzkaller.appspotmail.com
Subject: [PATCH 5.10 16/95] net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg
Date:   Mon,  6 Nov 2023 14:03:44 +0100
Message-ID: <20231106130305.325151516@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
References: <20231106130304.678610325@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit 51a32e828109b4a209efde44505baa356b37a4ce ]

syzbot reported the following uninit-value access issue [1]:

smsc95xx 1-1:0.0 (unnamed net_device) (uninitialized): Failed to read reg index 0x00000030: -32
smsc95xx 1-1:0.0 (unnamed net_device) (uninitialized): Error reading E2P_CMD
=====================================================
BUG: KMSAN: uninit-value in smsc95xx_reset+0x409/0x25f0 drivers/net/usb/smsc95xx.c:896
 smsc95xx_reset+0x409/0x25f0 drivers/net/usb/smsc95xx.c:896
 smsc95xx_bind+0x9bc/0x22e0 drivers/net/usb/smsc95xx.c:1131
 usbnet_probe+0x100b/0x4060 drivers/net/usb/usbnet.c:1750
 usb_probe_interface+0xc75/0x1210 drivers/usb/core/driver.c:396
 really_probe+0x506/0xf40 drivers/base/dd.c:658
 __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
 driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
 __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
 bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
 __device_attach+0x3bd/0x640 drivers/base/dd.c:1030
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
 bus_probe_device+0x3d8/0x5a0 drivers/base/bus.c:532
 device_add+0x16ae/0x1f20 drivers/base/core.c:3622
 usb_set_configuration+0x31c9/0x38c0 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:238
 usb_probe_device+0x290/0x4a0 drivers/usb/core/driver.c:293
 really_probe+0x506/0xf40 drivers/base/dd.c:658
 __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
 driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
 __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
 bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
 __device_attach+0x3bd/0x640 drivers/base/dd.c:1030
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
 bus_probe_device+0x3d8/0x5a0 drivers/base/bus.c:532
 device_add+0x16ae/0x1f20 drivers/base/core.c:3622
 usb_new_device+0x15f6/0x22f0 drivers/usb/core/hub.c:2589
 hub_port_connect drivers/usb/core/hub.c:5440 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5580 [inline]
 port_event drivers/usb/core/hub.c:5740 [inline]
 hub_event+0x53bc/0x7290 drivers/usb/core/hub.c:5822
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2703
 worker_thread+0xf45/0x1490 kernel/workqueue.c:2784
 kthread+0x3e8/0x540 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Local variable buf.i225 created at:
 smsc95xx_read_reg drivers/net/usb/smsc95xx.c:90 [inline]
 smsc95xx_reset+0x203/0x25f0 drivers/net/usb/smsc95xx.c:892
 smsc95xx_bind+0x9bc/0x22e0 drivers/net/usb/smsc95xx.c:1131

CPU: 1 PID: 773 Comm: kworker/1:2 Not tainted 6.6.0-rc1-syzkaller-00125-ge42bebf6db29 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Workqueue: usb_hub_wq hub_event
=====================================================

Similar to e9c65989920f ("net: usb: smsc75xx: Fix uninit-value access in
__smsc75xx_read_reg"), this issue is caused because usbnet_read_cmd() reads
less bytes than requested (zero byte in the reproducer). In this case,
'buf' is not properly filled.

This patch fixes the issue by returning -ENODATA if usbnet_read_cmd() reads
less bytes than requested.

sysbot reported similar uninit-value access issue [2]. The root cause is
the same as mentioned above, and this patch addresses it as well.

Fixes: 2f7ca802bdae ("net: Add SMSC LAN9500 USB2.0 10/100 ethernet adapter driver")
Reported-and-tested-by: syzbot+c74c24b43c9ae534f0e0@syzkaller.appspotmail.com
Reported-and-tested-by: syzbot+2c97a98a5ba9ea9c23bd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c74c24b43c9ae534f0e0 [1]
Closes: https://syzkaller.appspot.com/bug?extid=2c97a98a5ba9ea9c23bd [2]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 9297f2078fd2c..569be01700aa1 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -86,7 +86,9 @@ static int __must_check __smsc95xx_read_reg(struct usbnet *dev, u32 index,
 	ret = fn(dev, USB_VENDOR_REQUEST_READ_REGISTER, USB_DIR_IN
 		 | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 0, index, &buf, 4);
-	if (ret < 0) {
+	if (ret < 4) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		if (ret != -ENODEV)
 			netdev_warn(dev->net, "Failed to read reg index 0x%08x: %d\n",
 				    index, ret);
-- 
2.42.0



