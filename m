Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A2077ACC7
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbjHMVhA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjHMVhA (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5342710DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD4B86323A
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAD2C433C8;
        Sun, 13 Aug 2023 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962621;
        bh=qt6ZrmYX8HKCPGbnKIKdA5lTn+F9u43gARW5IyCoqgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RkNawtnqVPvtwHNWFQ2QNU5uaV4qLui6cmnt/bwAdWWRRj4qzjNAhnVk1yq4aM0hS
         HJ4+oWoaFVpnnS2w7307AWrKz4uHIq07G6z6GJg1WgVV+T/3iu7ofGR86PNyzgrx2K
         oUdNYKFwdytqnWIUPRZu1u9YIWzEvb6MVGMNiEYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alan Stern <stern@rowland.harvard.edu>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Avichal Rakesh <arakesh@google.com>
Subject: [PATCH 6.1 060/149] USB: Gadget: core: Help prevent panic during UVC unconfigure
Date:   Sun, 13 Aug 2023 23:18:25 +0200
Message-ID: <20230813211720.604291804@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 65dadb2beeb7360232b09ebc4585b54475dfee06 upstream.

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
 drivers/usb/gadget/udc/core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -795,6 +795,9 @@ EXPORT_SYMBOL_GPL(usb_gadget_disconnect)
  * usb_gadget_activate() is called.  For example, user mode components may
  * need to be activated before the system can talk to hosts.
  *
+ * This routine may sleep; it must not be called in interrupt context
+ * (such as from within a gadget driver's disconnect() callback).
+ *
  * Returns zero on success, else negative errno.
  */
 int usb_gadget_deactivate(struct usb_gadget *gadget)
@@ -833,6 +836,8 @@ EXPORT_SYMBOL_GPL(usb_gadget_deactivate)
  * This routine activates gadget which was previously deactivated with
  * usb_gadget_deactivate() call. It calls usb_gadget_connect() if needed.
  *
+ * This routine may sleep; it must not be called in interrupt context.
+ *
  * Returns zero on success, else negative errno.
  */
 int usb_gadget_activate(struct usb_gadget *gadget)
@@ -1611,7 +1616,11 @@ static void gadget_unbind_driver(struct
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
 


