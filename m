Return-Path: <stable+bounces-116742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA6A39B4F
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CFB7A4A3A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01523F276;
	Tue, 18 Feb 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gm17gKHE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1023C8DC
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879091; cv=none; b=k5GmX78oM57m1NUHIwXF+sveQgI5nYGN8Ep88DNS4NIFnwdxhFzxOuuRDxQRo4GDU+a/EJ7U8BHZyUUlFV5axu9jalfyYcTXKdAcEW96qvnrHCbBkFfzRBhGS40gS2HnZgWkYjYih9USTfycWXqJweSsrJcUJbLEBeDW5U4L5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879091; c=relaxed/simple;
	bh=1BKKBUuM95+31crhbriy3PClGUrUy7i6uqbafGtQ+XM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e971xlwIav0XnyHaY5bmJsgHcQ9jcos6b5iybuzFNg122yFHOppkG/Mu0JiU1f5Sp1zE3MBh0L5m1Is/m96XZcrkIgOXhYXeSgi60Ak4AEirzynFonyn//hMrzS4PiKIT7VtmkprcIr3tPZ37GdsEyL95rLkVwWTLx4PHTHsOFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gm17gKHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096DFC4CEE6;
	Tue, 18 Feb 2025 11:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739879090;
	bh=1BKKBUuM95+31crhbriy3PClGUrUy7i6uqbafGtQ+XM=;
	h=Subject:To:Cc:From:Date:From;
	b=gm17gKHExeIH4PxPjLYHLAkFSTlPTEd+ajPS7zvpsK1uiZERvRBVLD5nyNpF0l3xl
	 RFSPg2s9A0dxQXk9iYntDpuD3XKt4DsJ/cGqklMVgiXdD1JZNvrl/T+FI0SIYP1+o5
	 ReDstwxLoZHuHngU5bI5w9v2zli/l7AlJy83nJUI=
Subject: FAILED: patch "[PATCH] usb: gadget: core: flush gadget workqueue after device" failed to apply to 5.15-stable tree
To: royluo@google.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:44:44 +0100
Message-ID: <2025021844-stimuli-handmade-9628@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 399a45e5237ca14037120b1b895bd38a3b4492ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021844-stimuli-handmade-9628@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 399a45e5237ca14037120b1b895bd38a3b4492ea Mon Sep 17 00:00:00 2001
From: Roy Luo <royluo@google.com>
Date: Tue, 4 Feb 2025 23:36:42 +0000
Subject: [PATCH] usb: gadget: core: flush gadget workqueue after device
 removal

device_del() can lead to new work being scheduled in gadget->work
workqueue. This is observed, for example, with the dwc3 driver with the
following call stack:
  device_del()
    gadget_unbind_driver()
      usb_gadget_disconnect_locked()
        dwc3_gadget_pullup()
	  dwc3_gadget_soft_disconnect()
	    usb_gadget_set_state()
	      schedule_work(&gadget->work)

Move flush_work() after device_del() to ensure the workqueue is cleaned
up.

Fixes: 5702f75375aa9 ("usb: gadget: udc-core: move sysfs_notify() to a workqueue")
Cc: stable <stable@kernel.org>
Signed-off-by: Roy Luo <royluo@google.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20250204233642.666991-1-royluo@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index a6f46364be65..4b3d5075621a 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1543,8 +1543,8 @@ void usb_del_gadget(struct usb_gadget *gadget)
 
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	sysfs_remove_link(&udc->dev.kobj, "gadget");
-	flush_work(&gadget->work);
 	device_del(&gadget->dev);
+	flush_work(&gadget->work);
 	ida_free(&gadget_id_numbers, gadget->id_number);
 	cancel_work_sync(&udc->vbus_work);
 	device_unregister(&udc->dev);


