Return-Path: <stable+bounces-116744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273BCA39B4D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3B23B46B5
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D87C23FC59;
	Tue, 18 Feb 2025 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLgTkVSl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D323FC66
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879101; cv=none; b=Fdu9O0LAn61TlB1thO6a80E/8VZkI9QHwxLu62i5oisFjgDcmIbwpm0ZvY+6vQVCwluxaPc/YqNChzJ6jByht337ljOLeejXkjpH4++7JAj3f0QJMhayw9PbXYeDLnCxqEYnDYxtRIYkazKhtCyigt7AtxrBUYtIKGagB5sRpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879101; c=relaxed/simple;
	bh=2VXEZalKWkzS3ddKUTbifnJzYisNFJPXDVSG9lhTpB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N79TgLRfsS/exmxxcAhytmWMtiM2aden8iWepqaxC3C/0Fe+3acpE+LgYHbjxf2T4z/nhSi4kI4AzZOh/VXOSaS78WHHDQnGUe3O87p2i0CzK3Nu/r3mG/v59/iTewx4cn46mZwC04TJE0TjKuns6R8mXT0YKwBbzhsrr0iuCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLgTkVSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47691C4CEE2;
	Tue, 18 Feb 2025 11:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739879100;
	bh=2VXEZalKWkzS3ddKUTbifnJzYisNFJPXDVSG9lhTpB4=;
	h=Subject:To:Cc:From:Date:From;
	b=DLgTkVSlDZoKKBhvlPW51GINcsQKmduPjaz+Hhv7qYl+KylegqQTPZzVFh8zoEJnB
	 R4y4NVGclzvmnV/hJjmu3lY6YAVaTRAUDC2YszSNjehwDzJ4SKiGp0usVdUlevX2r+
	 3IRwX+Y/Ag0AAB+cGTGLiQM1/PkcE9Qk1XDTUJeo=
Subject: FAILED: patch "[PATCH] usb: gadget: core: flush gadget workqueue after device" failed to apply to 5.4-stable tree
To: royluo@google.com,Thinh.Nguyen@synopsys.com,gregkh@linuxfoundation.org,stable@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:44:49 +0100
Message-ID: <2025021848-sixtieth-living-e034@gregkh>
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
git cherry-pick -x 399a45e5237ca14037120b1b895bd38a3b4492ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021848-sixtieth-living-e034@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


