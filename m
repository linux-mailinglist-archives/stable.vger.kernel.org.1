Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943E1775B33
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjHILPV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjHILPV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:15:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44618ED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:15:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF3C76283A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC407C433C7;
        Wed,  9 Aug 2023 11:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579719;
        bh=ttnAwukODSMVR9wp52gv1CQibDTga22oKV9SR9+fuvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kt0IMLIZxzRuIQhWJ1a7RGEtHmJA6TkPNB2779wKjhTIhwzuw9lmz+6ipQBFQaXyh
         Fq0vw4u/KVYgOOzAIlx7JMabbS/atXgpVWWAliz4DseQTv3baXrx5kw0QYc+WjhjgE
         6c/dz9a8z2VrzjUN+AvVP/czWi40VW0M5cAOxaZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+27b0b464864741b18b99@syzkaller.appspotmail.com,
        Duoming Zhou <duoming@zju.edu.cn>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/323] media: usb: siano: Fix warning due to null work_func_t function pointer
Date:   Wed,  9 Aug 2023 12:38:49 +0200
Message-ID: <20230809103702.249458773@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 2df3d730ea768..cd706874899c3 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -190,7 +190,8 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
 
 	for (i = 0; i < MAX_URBS; i++) {
 		usb_kill_urb(&dev->surbs[i].urb);
-		cancel_work_sync(&dev->surbs[i].wq);
+		if (dev->surbs[i].wq.func)
+			cancel_work_sync(&dev->surbs[i].wq);
 
 		if (dev->surbs[i].cb) {
 			smscore_putbuffer(dev->coredev, dev->surbs[i].cb);
-- 
2.39.2



