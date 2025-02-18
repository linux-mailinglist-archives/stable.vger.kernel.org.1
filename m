Return-Path: <stable+bounces-116740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614EA39B4B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77AF53B4507
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992323FC42;
	Tue, 18 Feb 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wp1ArZuj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495E723F276
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879083; cv=none; b=Y5w2Kp8KbD5oUdGpJTljMWDKig9uzcGgBjaMqr63Eqy5azEFjCBr2WGEYVq6xv4GIYY46DTLlHiv7hX23Mm/AcFrxePCu5VqweZhHgh1a4Ma2P5cA43teFBOFv6go9CYKrZD5jeaBtTUgzcPJ8MHDj+QYgyTcuM6J2+PMGvuF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879083; c=relaxed/simple;
	bh=1j3Tdh2Tjt15llQ9C/861cCDVr0/i7MTNrlmGkAZ7mU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o35HjhGhc2ZNN1AWRjUDZhPfYnri1atCKnzK2e33SDOOl7d6vsKtuTBREpoB/rEgcjb3SWZZ8u0+x6Jo8LNhijA9ma6c7I/4BBPvHTQMET98immESub8wb0sxyH399VzX70K86Ijt7PKZt5CxRYM+hY+jwYceOmcOlMfChfYzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wp1ArZuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A00C4CEE2;
	Tue, 18 Feb 2025 11:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739879082;
	bh=1j3Tdh2Tjt15llQ9C/861cCDVr0/i7MTNrlmGkAZ7mU=;
	h=Subject:To:Cc:From:Date:From;
	b=Wp1ArZujEvVePuIMdRJBzXMEAvXDKIApnph6XstbOYDgJevy7cuXnn5dwWYI+v6Cg
	 AUavYM3DBSw8r3gVfcdGTxpB76VhXmOyv2/Mz1G+bwI8DQAA72XkV49XeUxFwQmG2u
	 yEd7S04rB+fqVRSpT6z7DnaRSzv0SqbFgiJFEWPU=
Subject: FAILED: patch "[PATCH] usb: gadget: core: flush gadget workqueue after device" failed to apply to 6.6-stable tree
To: royluo@google.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:44:39 +0100
Message-ID: <2025021839-vacancy-doormat-6a57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 399a45e5237ca14037120b1b895bd38a3b4492ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021839-vacancy-doormat-6a57@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


