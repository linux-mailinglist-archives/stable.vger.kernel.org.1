Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF23277009C
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHDM5x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 08:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHDM5w (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 08:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C694B11B
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 05:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 646B561FBA
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 12:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7594CC433C8;
        Fri,  4 Aug 2023 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691153870;
        bh=+aCfIknFmxeVtXkAhXwC+xXbw1YItcsx+VARDpSi7XY=;
        h=Subject:To:From:Date:From;
        b=DsJrHBWmlJHy3cI2W83ulM8lIjyVjUz+BnOi5X+w6KfSZCZa3O55qt02cYndjqbSa
         bVwD8lQYyesRgjeq6tz81aDP6ojIVqh4zpBQcUuUa0XXp2nWe7fAzwyuuxZynKUWG+
         EhZC6ZyWuPwKf88rxq5NdrYqk/+08bxKDKYtcdpI=
Subject: patch "USB: Gadget: core: Help prevent panic during UVC unconfigure" added to usb-linus
To:     stern@rowland.harvard.edu, arakesh@google.com, badhri@google.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 04 Aug 2023 14:57:39 +0200
Message-ID: <2023080438-gap-craziness-9ae8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    USB: Gadget: core: Help prevent panic during UVC unconfigure

to my usb git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
in the usb-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 65dadb2beeb7360232b09ebc4585b54475dfee06 Mon Sep 17 00:00:00 2001
From: Alan Stern <stern@rowland.harvard.edu>
Date: Sat, 29 Jul 2023 10:59:38 -0400
Subject: USB: Gadget: core: Help prevent panic during UVC unconfigure

Avichal Rakesh reported a kernel panic that occurred when the UVC
gadget driver was removed from a gadget's configuration.  The panic
involves a somewhat complicated interaction between the kernel driver
and a userspace component (as described in the Link tag below), but
the analysis did make one thing clear: The Gadget core should
accomodate gadget drivers calling usb_gadget_deactivate() as part of
their unbind procedure.

Currently this doesn't work.  gadget_unbind_driver() calls
driver->unbind() while holding the udc->connect_lock mutex, and
usb_gadget_deactivate() attempts to acquire that mutex, which will
result in a deadlock.

The simple fix is for gadget_unbind_driver() to release the mutex when
invoking the ->unbind() callback.  There is no particular reason for
it to be holding the mutex at that time, and the mutex isn't held
while the ->bind() callback is invoked.  So we'll drop the mutex
before performing the unbind callback and reacquire it afterward.

We'll also add a couple of comments to usb_gadget_activate() and
usb_gadget_deactivate().  Because they run in process context they
must not be called from a gadget driver's ->disconnect() callback,
which (according to the kerneldoc for struct usb_gadget_driver in
include/linux/usb/gadget.h) may run in interrupt context.  This may
help prevent similar bugs from arising in the future.

Reported-and-tested-by: Avichal Rakesh <arakesh@google.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Fixes: 286d9975a838 ("usb: gadget: udc: core: Prevent soft_connect_store() race")
Link: https://lore.kernel.org/linux-usb/4d7aa3f4-22d9-9f5a-3d70-1bd7148ff4ba@google.com/
Cc: Badhri Jagan Sridharan <badhri@google.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/48b2f1f1-0639-46bf-bbfc-98cb05a24914@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index cd58f2a4e7f3..7d49d8a0b00c 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -822,6 +822,9 @@ EXPORT_SYMBOL_GPL(usb_gadget_disconnect);
  * usb_gadget_activate() is called.  For example, user mode components may
  * need to be activated before the system can talk to hosts.
  *
+ * This routine may sleep; it must not be called in interrupt context
+ * (such as from within a gadget driver's disconnect() callback).
+ *
  * Returns zero on success, else negative errno.
  */
 int usb_gadget_deactivate(struct usb_gadget *gadget)
@@ -860,6 +863,8 @@ EXPORT_SYMBOL_GPL(usb_gadget_deactivate);
  * This routine activates gadget which was previously deactivated with
  * usb_gadget_deactivate() call. It calls usb_gadget_connect() if needed.
  *
+ * This routine may sleep; it must not be called in interrupt context.
+ *
  * Returns zero on success, else negative errno.
  */
 int usb_gadget_activate(struct usb_gadget *gadget)
@@ -1638,7 +1643,11 @@ static void gadget_unbind_driver(struct device *dev)
 	usb_gadget_disable_async_callbacks(udc);
 	if (gadget->irq)
 		synchronize_irq(gadget->irq);
+	mutex_unlock(&udc->connect_lock);
+
 	udc->driver->unbind(gadget);
+
+	mutex_lock(&udc->connect_lock);
 	usb_gadget_udc_stop_locked(udc);
 	mutex_unlock(&udc->connect_lock);
 
-- 
2.41.0


