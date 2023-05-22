Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15EB70C9D5
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjEVTwh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjEVTwW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1A139
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDD7262B11
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C58C433D2;
        Mon, 22 May 2023 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785126;
        bh=S5z9YoP3erBRn/s2mkeNQXHNciDxkwcUMlmJrhO+51U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpOVo4Lf0tI8T+wwKZXjoT+HtBt6nP0auiYMuOkO7ebzhV33xaJPmYjSr6hIEWfVV
         s7VYXE/9aPHu4oWrbYF/zDz3gDpAWoejO3RMbNqFkfZDh/FYfsrkIW2faPL23k3pVQ
         fopLUXg22mMj5i9soFUwIWVhcu4mKHAUWb9BU85M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>,
        syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com
Subject: [PATCH 6.3 290/364] USB: usbtmc: Fix direction for 0-length ioctl control messages
Date:   Mon, 22 May 2023 20:09:55 +0100
Message-Id: <20230522190420.018080424@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alan Stern <stern@rowland.harvard.edu>

commit 94d25e9128988c6a1fc9070f6e98215a95795bd8 upstream.

The syzbot fuzzer found a problem in the usbtmc driver: When a user
submits an ioctl for a 0-length control transfer, the driver does not
check that the direction is set to OUT:

------------[ cut here ]------------
usb 3-1: BOGUS control dir, pipe 80000b80 doesn't match bRequestType fd
WARNING: CPU: 0 PID: 5100 at drivers/usb/core/urb.c:411 usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
Modules linked in:
CPU: 0 PID: 5100 Comm: syz-executor428 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
Code: 7c 24 40 e8 1b 13 5c fb 48 8b 7c 24 40 e8 21 1d f0 fe 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 e0 b5 fc 8a e8 19 c8 23 fb <0f> 0b e9 9f ee ff ff e8 ed 12 5c fb 0f b6 1d 12 8a 3c 08 31 ff 41
RSP: 0018:ffffc90003d2fb00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880789e9058 RCX: 0000000000000000
RDX: ffff888029593b80 RSI: ffffffff814c1447 RDI: 0000000000000001
RBP: ffff88801ea742f8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802915e528
R13: 00000000000000fd R14: 0000000080000b80 R15: ffff8880222b3100
FS:  0000555556ca63c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9ef4d18150 CR3: 0000000073e5b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x101/0x4b0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 usbtmc_ioctl_request drivers/usb/class/usbtmc.c:1954 [inline]
 usbtmc_ioctl+0x1b3d/0x2840 drivers/usb/class/usbtmc.c:2097

To fix this, we must override the direction in the bRequestType field
of the control request structure when the length is 0.

Reported-and-tested-by: syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/linux-usb/000000000000716a3705f9adb8ee@google.com/
CC: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/ede1ee02-b718-49e7-a44c-51339fec706b@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/usbtmc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1928,6 +1928,8 @@ static int usbtmc_ioctl_request(struct u
 
 	if (request.req.wLength > USBTMC_BUFSIZE)
 		return -EMSGSIZE;
+	if (request.req.wLength == 0)	/* Length-0 requests are never IN */
+		request.req.bRequestType &= ~USB_DIR_IN;
 
 	is_in = request.req.bRequestType & USB_DIR_IN;
 


