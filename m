Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD1713E88
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjE1Tg2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjE1Tg1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:36:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74088E1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F389D61E43
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D242C433D2;
        Sun, 28 May 2023 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302582;
        bh=/Ha65achCsfAVtvXbbVawppotu0f/46eBuV4vAd7t3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wu7BkI/lE3accYif8J/fWL4+V/thBkgF12AOPOMgsy9boRDw9gB79uxz/giKaMgtu
         qlzB/YqF3y3RoxCrJd6MJG7BnP2GrFezleu9VXbGGs6crVD3TxURlYmTC/cCE1oG1h
         wkPH49vnAh6Ow073ZC/oeMBiAo/R31+XzAn9rG5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com
Subject: [PATCH 6.1 061/119] USB: sisusbvga: Add endpoint checks
Date:   Sun, 28 May 2023 20:11:01 +0100
Message-Id: <20230528190837.487714203@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit df05a9b05e466a46725564528b277d0c570d0104 upstream.

The syzbot fuzzer was able to provoke a WARNING from the sisusbvga driver:

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 1 PID: 26 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
Modules linked in:
CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.2.0-rc5-syzkaller-00199-g5af6ce704936 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
Code: 7c 24 18 e8 6c 50 80 fb 48 8b 7c 24 18 e8 62 1a 01 ff 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 60 b1 fa 8a e8 84 b0 be 03 <0f> 0b e9 58 f8 ff ff e8 3e 50 80 fb 48 81 c5 c0 05 00 00 e9 84 f7
RSP: 0018:ffffc90000a1ed18 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888012783a80 RSI: ffffffff816680ec RDI: fffff52000143d95
RBP: ffff888079020000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000003
R13: ffff888017d33370 R14: 0000000000000003 R15: ffff888021213600
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005592753a60b0 CR3: 0000000022899000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sisusb_bulkout_msg drivers/usb/misc/sisusbvga/sisusbvga.c:224 [inline]
 sisusb_send_bulk_msg.constprop.0+0x904/0x1230 drivers/usb/misc/sisusbvga/sisusbvga.c:379
 sisusb_send_bridge_packet drivers/usb/misc/sisusbvga/sisusbvga.c:567 [inline]
 sisusb_do_init_gfxdevice drivers/usb/misc/sisusbvga/sisusbvga.c:2077 [inline]
 sisusb_init_gfxdevice+0x87b/0x4000 drivers/usb/misc/sisusbvga/sisusbvga.c:2177
 sisusb_probe+0x9cd/0xbe2 drivers/usb/misc/sisusbvga/sisusbvga.c:2869
...

The problem was caused by the fact that the driver does not check
whether the endpoints it uses are actually present and have the
appropriate types.  This can be fixed by adding a simple check of
the endpoints.

Link: https://syzkaller.appspot.com/bug?extid=23be03b56c5259385d79
Reported-and-tested-by: syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/48ef98f7-51ae-4f63-b8d3-0ef2004bb60a@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/sisusbvga/sisusb.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -3014,6 +3014,20 @@ static int sisusb_probe(struct usb_inter
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct sisusb_usb_data *sisusb;
 	int retval = 0, i;
+	static const u8 ep_addresses[] = {
+		SISUSB_EP_GFX_IN | USB_DIR_IN,
+		SISUSB_EP_GFX_OUT | USB_DIR_OUT,
+		SISUSB_EP_GFX_BULK_OUT | USB_DIR_OUT,
+		SISUSB_EP_GFX_LBULK_OUT | USB_DIR_OUT,
+		SISUSB_EP_BRIDGE_IN | USB_DIR_IN,
+		SISUSB_EP_BRIDGE_OUT | USB_DIR_OUT,
+		0};
+
+	/* Are the expected endpoints present? */
+	if (!usb_check_bulk_endpoints(intf, ep_addresses)) {
+		dev_err(&intf->dev, "Invalid USB2VGA device\n");
+		return -EINVAL;
+	}
 
 	dev_info(&dev->dev, "USB2VGA dongle found at address %d\n",
 			dev->devnum);


