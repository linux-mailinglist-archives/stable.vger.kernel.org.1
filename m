Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E864B7BE1BE
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377539AbjJINxk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377535AbjJINxj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:53:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2395591
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:53:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68184C433C7;
        Mon,  9 Oct 2023 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859617;
        bh=j8ifZ8PpJMqxjn/xq+97dM5t63LggOngoA5sbqrkdDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nypz2LVOACk4mMqK/yZpInbvZvq08rKNf6/4LYq2pvYSuCSAD4u6X+g5w2XVfNB9M
         7uME5To0JWC3k2q8pYaq8ZBYv2XRVs3oCGBV3lW3tz6VTlQUGo2wSvzIy0IZN0stpP
         /wrFmTV5aSi0wo1cR5fwyse1FR3mevTBfayTlSko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shigeru Yoshida <syoshida@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+6966546b78d050bb0b5d@syzkaller.appspotmail.com
Subject: [PATCH 4.19 78/91] net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg
Date:   Mon,  9 Oct 2023 15:06:50 +0200
Message-ID: <20231009130114.251467466@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit e9c65989920f7c28775ec4e0c11b483910fb67b8 ]

syzbot reported the following uninit-value access issue:

=====================================================
BUG: KMSAN: uninit-value in smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:975 [inline]
BUG: KMSAN: uninit-value in smsc75xx_bind+0x5c9/0x11e0 drivers/net/usb/smsc75xx.c:1482
CPU: 0 PID: 8696 Comm: kworker/0:3 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:975 [inline]
 smsc75xx_bind+0x5c9/0x11e0 drivers/net/usb/smsc75xx.c:1482
 usbnet_probe+0x1152/0x3f90 drivers/net/usb/usbnet.c:1737
 usb_probe_interface+0xece/0x1550 drivers/usb/core/driver.c:374
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_set_configuration+0x380f/0x3f10 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x138/0x300 drivers/usb/core/generic.c:241
 usb_probe_device+0x311/0x490 drivers/usb/core/driver.c:272
 really_probe+0xf20/0x20b0 drivers/base/dd.c:529
 driver_probe_device+0x293/0x390 drivers/base/dd.c:701
 __device_attach_driver+0x63f/0x830 drivers/base/dd.c:807
 bus_for_each_drv+0x2ca/0x3f0 drivers/base/bus.c:431
 __device_attach+0x4e2/0x7f0 drivers/base/dd.c:873
 device_initial_probe+0x4a/0x60 drivers/base/dd.c:920
 bus_probe_device+0x177/0x3d0 drivers/base/bus.c:491
 device_add+0x3b0e/0x40d0 drivers/base/core.c:2680
 usb_new_device+0x1bd4/0x2a30 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x5e7b/0x8a70 drivers/usb/core/hub.c:5576
 process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
 worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
 kthread+0x551/0x590 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Local variable ----buf.i87@smsc75xx_bind created at:
 __smsc75xx_read_reg drivers/net/usb/smsc75xx.c:83 [inline]
 smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:968 [inline]
 smsc75xx_bind+0x485/0x11e0 drivers/net/usb/smsc75xx.c:1482
 __smsc75xx_read_reg drivers/net/usb/smsc75xx.c:83 [inline]
 smsc75xx_wait_ready drivers/net/usb/smsc75xx.c:968 [inline]
 smsc75xx_bind+0x485/0x11e0 drivers/net/usb/smsc75xx.c:1482

This issue is caused because usbnet_read_cmd() reads less bytes than requested
(zero byte in the reproducer). In this case, 'buf' is not properly filled.

This patch fixes the issue by returning -ENODATA if usbnet_read_cmd() reads
less bytes than requested.

Fixes: d0cad871703b ("smsc75xx: SMSC LAN75xx USB gigabit ethernet adapter driver")
Reported-and-tested-by: syzbot+6966546b78d050bb0b5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6966546b78d050bb0b5d
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230923173549.3284502-1-syoshida@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc75xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 313a4b0edc6b3..573d7ad2e7082 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -102,7 +102,9 @@ static int __must_check __smsc75xx_read_reg(struct usbnet *dev, u32 index,
 	ret = fn(dev, USB_VENDOR_REQUEST_READ_REGISTER, USB_DIR_IN
 		 | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 		 0, index, &buf, 4);
-	if (unlikely(ret < 0)) {
+	if (unlikely(ret < 4)) {
+		ret = ret < 0 ? ret : -ENODATA;
+
 		netdev_warn(dev->net, "Failed to read reg index 0x%08x: %d\n",
 			    index, ret);
 		return ret;
-- 
2.40.1



