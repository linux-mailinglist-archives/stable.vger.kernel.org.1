Return-Path: <stable+bounces-33904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FE189399A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 11:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9131F22064
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B620510788;
	Mon,  1 Apr 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VYi9ZtfB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7C101E3
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711964575; cv=none; b=E0E3054hhlhvOoeOBecICy8SY7waiOWZpWhhBoT7QtcTXC8o76hSqFgPe+RkCuAHBci8EutyXYuOuExBgQjE7/GXEU4/1a3A1VGrMOXbeSRIqXIOVux8FNrQVmRJwDSj7/ZuBDVwURVbUISfQMDVQtTddHkqKym6XdbHEjaDhwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711964575; c=relaxed/simple;
	bh=LstlTlaoKXEHVV6Q1nXA7QTYPkaZh1NHFiSdb2MYGQM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WMZ0/xb9b34mK2Xzz0kRM7I0aHReY9a+niI1eeH/hclmsyAQdmuBqJG4B8eAg9FIRkNCtxIHHw7IAZVsfjT0QDIY07uHifaFxmqG95l6mnKUGectabLbT6b+Ng8ye+Pmz2YU1NTcr193O2oEyd4g/PfESxsEi/mettM1Ie7PDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VYi9ZtfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C306C433F1;
	Mon,  1 Apr 2024 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711964575;
	bh=LstlTlaoKXEHVV6Q1nXA7QTYPkaZh1NHFiSdb2MYGQM=;
	h=Subject:To:Cc:From:Date:From;
	b=VYi9ZtfBclNsoaDakGp1kuzLZp5Dr/EddGPE6Ln2nUWv3SYlu0YXiPUHzSh/enDDY
	 ee0jmA1ub6jXsUjUmMTQhgw2zedAZsExGVtKoxRpb6IhixPECoVnHZxbQvJYOLSWn8
	 WDZUug8UtkF/Gdoh3GPfVma4mlw0LXXaUj4yCkgI=
Subject: FAILED: patch "[PATCH] USB: core: Fix deadlock in usb_deauthorize_interface()" failed to apply to 6.1-stable tree
To: stern@rowland.harvard.edu,gregkh@linuxfoundation.org,samsun1006219@gmail.com,xrivendell7@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Apr 2024 11:42:52 +0200
Message-ID: <2024040151-singular-unfunded-b5a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 80ba43e9f799cbdd83842fc27db667289b3150f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040151-singular-unfunded-b5a8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

80ba43e9f799 ("USB: core: Fix deadlock in usb_deauthorize_interface()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80ba43e9f799cbdd83842fc27db667289b3150f5 Mon Sep 17 00:00:00 2001
From: Alan Stern <stern@rowland.harvard.edu>
Date: Tue, 12 Mar 2024 11:48:23 -0400
Subject: [PATCH] USB: core: Fix deadlock in usb_deauthorize_interface()

Among the attribute file callback routines in
drivers/usb/core/sysfs.c, the interface_authorized_store() function is
the only one which acquires a device lock on an ancestor device: It
calls usb_deauthorize_interface(), which locks the interface's parent
USB device.

The will lead to deadlock if another process already owns that lock
and tries to remove the interface, whether through a configuration
change or because the device has been disconnected.  As part of the
removal procedure, device_del() waits for all ongoing sysfs attribute
callbacks to complete.  But usb_deauthorize_interface() can't complete
until the device lock has been released, and the lock won't be
released until the removal has finished.

The mechanism provided by sysfs to prevent this kind of deadlock is
to use the sysfs_break_active_protection() function, which tells sysfs
not to wait for the attribute callback.

Reported-and-tested by: Yue Sun <samsun1006219@gmail.com>
Reported by: xingwei lee <xrivendell7@gmail.com>

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/linux-usb/CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com/#r
Fixes: 310d2b4124c0 ("usb: interface authorization: SysFS part of USB interface authorization")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1c37eea1-9f56-4534-b9d8-b443438dc869@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index f98263e21c2a..d83231d6736a 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -1217,14 +1217,24 @@ static ssize_t interface_authorized_store(struct device *dev,
 {
 	struct usb_interface *intf = to_usb_interface(dev);
 	bool val;
+	struct kernfs_node *kn;
 
 	if (kstrtobool(buf, &val) != 0)
 		return -EINVAL;
 
-	if (val)
+	if (val) {
 		usb_authorize_interface(intf);
-	else
-		usb_deauthorize_interface(intf);
+	} else {
+		/*
+		 * Prevent deadlock if another process is concurrently
+		 * trying to unregister intf.
+		 */
+		kn = sysfs_break_active_protection(&dev->kobj, &attr->attr);
+		if (kn) {
+			usb_deauthorize_interface(intf);
+			sysfs_unbreak_active_protection(kn);
+		}
+	}
 
 	return count;
 }


