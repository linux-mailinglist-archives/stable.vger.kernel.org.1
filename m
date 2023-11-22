Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C017F4E4E
	for <lists+stable@lfdr.de>; Wed, 22 Nov 2023 18:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344066AbjKVRYh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 22 Nov 2023 12:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344070AbjKVRYg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 22 Nov 2023 12:24:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BEA1A4
        for <stable@vger.kernel.org>; Wed, 22 Nov 2023 09:24:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F1AC433C7;
        Wed, 22 Nov 2023 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700673872;
        bh=1KUpajgDNcNnZV/haOs8/ERaqSz1A7hOfyb2d9hD3Mk=;
        h=Subject:To:Cc:From:Date:From;
        b=VaNWJViFWm3zjiMOG/Be2B6ePredMSgLzAdZQ+PepdpZGSUGZESFrfC2QsWPRqt4N
         uk/IYIRIal5jVgtWPAjVaSISxnjSDutCHEmuWsBpf4zV2n7TxIBoXs6xutSJJeiYzM
         zLUuqRffO5amGuN2t8N0pIiALUhjVmf5Nyo/wxnQ=
Subject: FAILED: patch "[PATCH] hvc/xen: fix console unplug" failed to apply to 5.4-stable tree
To:     dwmw@amazon.co.uk, gregkh@linuxfoundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 22 Nov 2023 17:24:29 +0000
Message-ID: <2023112229-slicing-deceiving-2f7c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a30badfd7c13fc8763a9e10c5a12ba7f81515a55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112229-slicing-deceiving-2f7c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

a30badfd7c13 ("hvc/xen: fix console unplug")
df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
37711e5e2325 ("Merge tag 'nfs-for-5.9-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a30badfd7c13fc8763a9e10c5a12ba7f81515a55 Mon Sep 17 00:00:00 2001
From: David Woodhouse <dwmw@amazon.co.uk>
Date: Fri, 20 Oct 2023 17:15:29 +0100
Subject: [PATCH] hvc/xen: fix console unplug

On unplug of a Xen console, xencons_disconnect_backend() unconditionally
calls free_irq() via unbind_from_irqhandler(), causing a warning of
freeing an already-free IRQ:

(qemu) device_del con1
[   32.050919] ------------[ cut here ]------------
[   32.050942] Trying to free already-free IRQ 33
[   32.050990] WARNING: CPU: 0 PID: 51 at kernel/irq/manage.c:1895 __free_irq+0x1d4/0x330

It should be using evtchn_put() to tear down the event channel binding,
and let the Linux IRQ side of it be handled by notifier_del_irq() through
the HVC code.

On which topic... xencons_disconnect_backend() should call hvc_remove()
*first*, rather than tearing down the event channel and grant mapping
while they are in use. And then the IRQ is guaranteed to be freed by
the time it's torn down by evtchn_put().

Since evtchn_put() also closes the actual event channel, avoid calling
xenbus_free_evtchn() except in the failure path where the IRQ was not
successfully set up.

However, calling hvc_remove() at the start of xencons_disconnect_backend()
still isn't early enough. An unplug request is indicated by the backend
setting its state to XenbusStateClosing, which triggers a notification
to xencons_backend_changed(), which... does nothing except set its own
frontend state directly to XenbusStateClosed without *actually* tearing
down the HVC device or, you know, making sure it isn't actively in use.

So the backend sees the guest frontend set its state to XenbusStateClosed
and stops servicing the interrupt... and the guest spins for ever in the
domU_write_console() function waiting for the ring to drain.

Fix that one by calling hvc_remove() from xencons_backend_changed() before
signalling to the backend that it's OK to proceed with the removal.

Tested with 'dd if=/dev/zero of=/dev/hvc1' while telling Qemu to remove
the console device.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20231020161529.355083-4-dwmw2@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 4a768b504263..34c01874f45b 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -377,18 +377,21 @@ void xen_console_resume(void)
 #ifdef CONFIG_HVC_XEN_FRONTEND
 static void xencons_disconnect_backend(struct xencons_info *info)
 {
-	if (info->irq > 0)
-		unbind_from_irqhandler(info->irq, NULL);
-	info->irq = 0;
+	if (info->hvc != NULL)
+		hvc_remove(info->hvc);
+	info->hvc = NULL;
+	if (info->irq > 0) {
+		evtchn_put(info->evtchn);
+		info->irq = 0;
+		info->evtchn = 0;
+	}
+	/* evtchn_put() will also close it so this is only an error path */
 	if (info->evtchn > 0)
 		xenbus_free_evtchn(info->xbdev, info->evtchn);
 	info->evtchn = 0;
 	if (info->gntref > 0)
 		gnttab_free_grant_references(info->gntref);
 	info->gntref = 0;
-	if (info->hvc != NULL)
-		hvc_remove(info->hvc);
-	info->hvc = NULL;
 }
 
 static void xencons_free(struct xencons_info *info)
@@ -553,10 +556,23 @@ static void xencons_backend_changed(struct xenbus_device *dev,
 		if (dev->state == XenbusStateClosed)
 			break;
 		fallthrough;	/* Missed the backend's CLOSING state */
-	case XenbusStateClosing:
+	case XenbusStateClosing: {
+		struct xencons_info *info = dev_get_drvdata(&dev->dev);;
+
+		/*
+		 * Don't tear down the evtchn and grant ref before the other
+		 * end has disconnected, but do stop userspace from trying
+		 * to use the device before we allow the backend to close.
+		 */
+		if (info->hvc) {
+			hvc_remove(info->hvc);
+			info->hvc = NULL;
+		}
+
 		xenbus_frontend_closed(dev);
 		break;
 	}
+	}
 }
 
 static const struct xenbus_device_id xencons_ids[] = {
@@ -616,7 +632,7 @@ static int __init xen_hvc_init(void)
 		list_del(&info->list);
 		spin_unlock_irqrestore(&xencons_lock, flags);
 		if (info->irq)
-			unbind_from_irqhandler(info->irq, NULL);
+			evtchn_put(info->evtchn);
 		kfree(info);
 		return r;
 	}

