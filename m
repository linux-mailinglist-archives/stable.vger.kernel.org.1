Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254337E252B
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjKFN2y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbjKFN2y (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:28:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18314D4C
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:28:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EBAC433C9;
        Mon,  6 Nov 2023 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277330;
        bh=P9k7Y5P023eMFw8V/FtOKAEG8ywUNJrrGFWaC7a8WdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w70/XQ5UT+GxOV5o4Lv1ILBazGq0MTbPGpL++pipgTCCKkuQKzxDmSKeajqkM+xAC
         R2BXvy8T3XAD4hQk0R863EbTpdQ+cId9yW/oMEkRtRVnCMtYSYTC7kD28syH7TtQbl
         15cVlKUD1XA7bYZkGH9OvmCas7AZ6YNQRgG4ALzM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: [PATCH 5.15 116/128] usb: raw-gadget: properly handle interrupted requests
Date:   Mon,  6 Nov 2023 14:04:36 +0100
Message-ID: <20231106130314.440705311@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@gmail.com>

commit e8033bde451eddfb9b1bbd6e2d848c1b5c277222 upstream.

Currently, if a USB request that was queued by Raw Gadget is interrupted
(via a signal), wait_for_completion_interruptible returns -ERESTARTSYS.
Raw Gadget then attempts to propagate this value to userspace as a return
value from its ioctls. However, when -ERESTARTSYS is returned by a syscall
handler, the kernel internally restarts the syscall.

This doesn't allow userspace applications to interrupt requests queued by
Raw Gadget (which is required when the emulated device is asked to switch
altsettings). It also violates the implied interface of Raw Gadget that a
single ioctl must only queue a single USB request.

Instead, make Raw Gadget do what GadgetFS does: check whether the request
was interrupted (dequeued with status == -ECONNRESET) and report -EINTR to
userspace.

Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
Cc: stable <stable@kernel.org>
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
Link: https://lore.kernel.org/r/0db45b1d7cc466e3d4d1ab353f61d63c977fbbc5.1698350424.git.andreyknvl@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/legacy/raw_gadget.c |   26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -663,12 +663,12 @@ static int raw_process_ep0_io(struct raw
 	if (WARN_ON(in && dev->ep0_out_pending)) {
 		ret = -ENODEV;
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_unlock;
 	}
 	if (WARN_ON(!in && dev->ep0_in_pending)) {
 		ret = -ENODEV;
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_unlock;
 	}
 
 	dev->req->buf = data;
@@ -683,7 +683,7 @@ static int raw_process_ep0_io(struct raw
 				"fail, usb_ep_queue returned %d\n", ret);
 		spin_lock_irqsave(&dev->lock, flags);
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_queue_failed;
 	}
 
 	ret = wait_for_completion_interruptible(&dev->ep0_done);
@@ -692,13 +692,16 @@ static int raw_process_ep0_io(struct raw
 		usb_ep_dequeue(dev->gadget->ep0, dev->req);
 		wait_for_completion(&dev->ep0_done);
 		spin_lock_irqsave(&dev->lock, flags);
-		goto out_done;
+		if (dev->ep0_status == -ECONNRESET)
+			dev->ep0_status = -EINTR;
+		goto out_interrupted;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	ret = dev->ep0_status;
 
-out_done:
+out_interrupted:
+	ret = dev->ep0_status;
+out_queue_failed:
 	dev->ep0_urb_queued = false;
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -1060,7 +1063,7 @@ static int raw_process_ep_io(struct raw_
 				"fail, usb_ep_queue returned %d\n", ret);
 		spin_lock_irqsave(&dev->lock, flags);
 		dev->state = STATE_DEV_FAILED;
-		goto out_done;
+		goto out_queue_failed;
 	}
 
 	ret = wait_for_completion_interruptible(&done);
@@ -1069,13 +1072,16 @@ static int raw_process_ep_io(struct raw_
 		usb_ep_dequeue(ep->ep, ep->req);
 		wait_for_completion(&done);
 		spin_lock_irqsave(&dev->lock, flags);
-		goto out_done;
+		if (ep->status == -ECONNRESET)
+			ep->status = -EINTR;
+		goto out_interrupted;
 	}
 
 	spin_lock_irqsave(&dev->lock, flags);
-	ret = ep->status;
 
-out_done:
+out_interrupted:
+	ret = ep->status;
+out_queue_failed:
 	ep->urb_queued = false;
 out_unlock:
 	spin_unlock_irqrestore(&dev->lock, flags);


