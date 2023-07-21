Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D875D2D3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGUTEE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGUTED (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:04:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F1C30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBD061D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8ACC433C7;
        Fri, 21 Jul 2023 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966241;
        bh=3kzTfVKWWibrQ+PquFHbQp7KSFHKcdtT0J/DFETlprE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ex0BAK442ux+D0hyMpBcUjasFJGPcPp+mGXPRAypDbTDSz3ALU5Fnhg8oVhHQqT1k
         3/rntjQr93iQrESbJPL122FBxtBq3MjNzMfKdHes04RH63ODYbZ3TyGsJ5CodUdXcy
         8i913G8Ue4LcCLZy7bFbL1yR1TUbJq9qi6aFVAF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+27b0b464864741b18b99@syzkaller.appspotmail.com,
        Duoming Zhou <duoming@zju.edu.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 274/532] media: usb: siano: Fix warning due to null work_func_t function pointer
Date:   Fri, 21 Jul 2023 18:02:58 +0200
Message-ID: <20230721160629.237665466@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 6f489a966fbeb0da63d45c2c66a8957eab604bf6 ]

The previous commit ebad8e731c1c ("media: usb: siano: Fix use after
free bugs caused by do_submit_urb") adds cancel_work_sync() in
smsusb_stop_streaming(). But smsusb_stop_streaming() may be called,
even if the work_struct surb->wq has not been initialized. As a result,
the warning will occur. One of the processes that could lead to warning
is shown below:

smsusb_probe()
  smsusb_init_device()
    if (!dev->in_ep || !dev->out_ep || align < 0) {
         smsusb_term_device(intf);
           smsusb_stop_streaming()
             cancel_work_sync(&dev->surbs[i].wq);
               __cancel_work_timer()
                 __flush_work()
                   if (WARN_ON(!work->func)) // work->func is null

The log reported by syzbot is shown below:

WARNING: CPU: 0 PID: 897 at kernel/workqueue.c:3066 __flush_work+0x798/0xa80 kernel/workqueue.c:3063
Modules linked in:
CPU: 0 PID: 897 Comm: kworker/0:2 Not tainted 6.2.0-rc1-syzkaller #0
RIP: 0010:__flush_work+0x798/0xa80 kernel/workqueue.c:3066
...
RSP: 0018:ffffc9000464ebf8 EFLAGS: 00010246
RAX: 1ffff11002dbb420 RBX: 0000000000000021 RCX: 1ffffffff204fa4e
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: ffff888016dda0e8
RBP: ffffc9000464ed98 R08: 0000000000000001 R09: ffffffff90253b2f
R10: 0000000000000001 R11: 0000000000000000 R12: ffff888016dda0e8
R13: ffff888016dda0e8 R14: ffff888016dda100 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd4331efe8 CR3: 000000000b48e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __cancel_work_timer+0x315/0x460 kernel/workqueue.c:3160
 smsusb_stop_streaming drivers/media/usb/siano/smsusb.c:182 [inline]
 smsusb_term_device+0xda/0x2d0 drivers/media/usb/siano/smsusb.c:344
 smsusb_init_device+0x400/0x9ce drivers/media/usb/siano/smsusb.c:419
 smsusb_probe+0xbbd/0xc55 drivers/media/usb/siano/smsusb.c:567
...

This patch adds check before cancel_work_sync(). If surb->wq has not
been initialized, the cancel_work_sync() will not be executed.

Reported-by: syzbot+27b0b464864741b18b99@syzkaller.appspotmail.com
Fixes: ebad8e731c1c ("media: usb: siano: Fix use after free bugs caused by do_submit_urb")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/siano/smsusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index 1babfe6e2c361..5c223b5498b4b 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -179,7 +179,8 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
 
 	for (i = 0; i < MAX_URBS; i++) {
 		usb_kill_urb(&dev->surbs[i].urb);
-		cancel_work_sync(&dev->surbs[i].wq);
+		if (dev->surbs[i].wq.func)
+			cancel_work_sync(&dev->surbs[i].wq);
 
 		if (dev->surbs[i].cb) {
 			smscore_putbuffer(dev->coredev, dev->surbs[i].cb);
-- 
2.39.2



