Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577CC76AE8E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjHAJjz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjHAJja (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:39:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D6B46AB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71CBC6150E
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E56EC433C7;
        Tue,  1 Aug 2023 09:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882635;
        bh=iZFei3x9GYH6BSuxgnzWLWMQKot7wy3GWFrEtILFXr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QU7RvM737+dW11Yni1zlXcEjLfJdDNHCEkaPTQ28Ve0ZZ4JqHdqNdADca1AaAbesm
         L+n9Ct9niTR8/NY/NiimzEQ0UB+oMszKM/ER/xKpG14LvUgsr1TI6aLFthxGZP0dkV
         g8M/vSSV7X5Qz03xjOBcVOlmjoR7G/Yxe8+hMyi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com,
        stable <stable@kernel.org>, Zqiang <qiang.zhang1211@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: [PATCH 6.1 148/228] USB: gadget: Fix the memory leak in raw_gadget driver
Date:   Tue,  1 Aug 2023 11:20:06 +0200
Message-ID: <20230801091928.249094870@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zqiang <qiang.zhang1211@gmail.com>

commit 83e30f2bf86ef7c38fbd476ed81a88522b620628 upstream.

Currently, increasing raw_dev->count happens before invoke the
raw_queue_event(), if the raw_queue_event() return error, invoke
raw_release() will not trigger the dev_free() to be called.

[  268.905865][ T5067] raw-gadget.0 gadget.0: failed to queue event
[  268.912053][ T5067] udc dummy_udc.0: failed to start USB Raw Gadget: -12
[  268.918885][ T5067] raw-gadget.0: probe of gadget.0 failed with error -12
[  268.925956][ T5067] UDC core: USB Raw Gadget: couldn't find an available UDC or it's busy
[  268.934657][ T5067] misc raw-gadget: fail, usb_gadget_register_driver returned -16

BUG: memory leak

[<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
[<ffffffff8347eb55>] kmalloc include/linux/slab.h:582 [inline]
[<ffffffff8347eb55>] kzalloc include/linux/slab.h:703 [inline]
[<ffffffff8347eb55>] dev_new drivers/usb/gadget/legacy/raw_gadget.c:191 [inline]
[<ffffffff8347eb55>] raw_open+0x45/0x110 drivers/usb/gadget/legacy/raw_gadget.c:385
[<ffffffff827d1d09>] misc_open+0x1a9/0x1f0 drivers/char/misc.c:165

[<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
[<ffffffff8347cd2f>] kmalloc include/linux/slab.h:582 [inline]
[<ffffffff8347cd2f>] raw_ioctl_init+0xdf/0x410 drivers/usb/gadget/legacy/raw_gadget.c:460
[<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/legacy/raw_gadget.c:1250
[<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]

[<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
[<ffffffff833ecc6a>] kmalloc include/linux/slab.h:582 [inline]
[<ffffffff833ecc6a>] kzalloc include/linux/slab.h:703 [inline]
[<ffffffff833ecc6a>] dummy_alloc_request+0x5a/0xe0 drivers/usb/gadget/udc/dummy_hcd.c:665
[<ffffffff833e9132>] usb_ep_alloc_request+0x22/0xd0 drivers/usb/gadget/udc/core.c:196
[<ffffffff8347f13d>] gadget_bind+0x6d/0x370 drivers/usb/gadget/legacy/raw_gadget.c:292

This commit therefore invoke kref_get() under the condition that
raw_queue_event() return success.

Reported-by: syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com
Cc: stable <stable@kernel.org>
Closes: https://syzkaller.appspot.com/bug?extid=feb045d335c1fdde5bf7
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
Link: https://lore.kernel.org/r/20230714074011.20989-1-qiang.zhang1211@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/legacy/raw_gadget.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -310,13 +310,15 @@ static int gadget_bind(struct usb_gadget
 	dev->eps_num = i;
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	/* Matches kref_put() in gadget_unbind(). */
-	kref_get(&dev->count);
-
 	ret = raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&gadget->dev, "failed to queue event\n");
+		set_gadget_data(gadget, NULL);
+		return ret;
+	}
 
+	/* Matches kref_put() in gadget_unbind(). */
+	kref_get(&dev->count);
 	return ret;
 }
 


