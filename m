Return-Path: <stable+bounces-5330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2B280CA3C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064341F217F8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3DD3C06F;
	Mon, 11 Dec 2023 12:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GDLc+9e3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686E3BB2B
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 12:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65327C433C8;
	Mon, 11 Dec 2023 12:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702299039;
	bh=ikG3WBe15e41mLmGn5QPjrniYBR/avj76KwQ6Rti6P4=;
	h=Subject:To:Cc:From:Date:From;
	b=GDLc+9e3bJCbzcNvYttx8NlBRvNwYqQkXBTcJWJEPJMdipWtW6f3sGaDhhR+bje/C
	 JMVHe3vfashDkZLexr7gWe7cVu4sigSerJCIckraTgvi3wTybbjLA3l6oNwS83cbfh
	 uVAYVgo0jvKcMeullAbfjSo+c9Bdvly4fkjCEhoA=
Subject: FAILED: patch "[PATCH] USB: gadget: core: adjust uevent timing on gadget unbind" failed to apply to 5.4-stable tree
To: royluo@google.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Dec 2023 13:50:33 +0100
Message-ID: <2023121133-groin-undaunted-1dca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 73ea73affe8622bdf292de898da869d441da6a9d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121133-groin-undaunted-1dca@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

73ea73affe86 ("USB: gadget: core: adjust uevent timing on gadget unbind")
50966da807c8 ("usb: gadget: udc: core: Offload usb_udc_vbus_handler processing")
1016fc0c096c ("USB: gadget: Fix obscure lockdep violation for udc_mutex")
f9d76d15072c ("USB: gadget: Add ID numbers to gadget names")
fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
6ebb449f9f25 ("USB: gadget: Register udc before gadget")
af1969a2d734 ("USB: gadget: Rename usb_gadget_probe_driver()")
710f5d627a98 ("Merge tag 'usb-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73ea73affe8622bdf292de898da869d441da6a9d Mon Sep 17 00:00:00 2001
From: Roy Luo <royluo@google.com>
Date: Tue, 28 Nov 2023 22:17:56 +0000
Subject: [PATCH] USB: gadget: core: adjust uevent timing on gadget unbind

The KOBJ_CHANGE uevent is sent before gadget unbind is actually
executed, resulting in inaccurate uevent emitted at incorrect timing
(the uevent would have USB_UDC_DRIVER variable set while it would
soon be removed).
Move the KOBJ_CHANGE uevent to the end of the unbind function so that
uevent is sent only after the change has been made.

Fixes: 2ccea03a8f7e ("usb: gadget: introduce UDC Class")
Cc: stable@vger.kernel.org
Signed-off-by: Roy Luo <royluo@google.com>
Link: https://lore.kernel.org/r/20231128221756.2591158-1-royluo@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index ded9531f141b..d59f94464b87 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1646,8 +1646,6 @@ static void gadget_unbind_driver(struct device *dev)
 
 	dev_dbg(&udc->dev, "unbinding gadget driver [%s]\n", driver->function);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-
 	udc->allow_connect = false;
 	cancel_work_sync(&udc->vbus_work);
 	mutex_lock(&udc->connect_lock);
@@ -1667,6 +1665,8 @@ static void gadget_unbind_driver(struct device *dev)
 	driver->is_bound = false;
 	udc->driver = NULL;
 	mutex_unlock(&udc_lock);
+
+	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 }
 
 /* ------------------------------------------------------------------------- */


