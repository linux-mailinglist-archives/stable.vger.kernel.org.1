Return-Path: <stable+bounces-33941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736C893BB0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691561C20DF6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 13:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA263FBAA;
	Mon,  1 Apr 2024 13:59:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 13FAE3FB1E
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711979964; cv=none; b=cBJhgc3HhhmDLInnW/1DLoG3oowSPPUJ0mYCGTzaycnXzfVkgOL9/CvlwB36upSa5eywudLUOmporeobLDWasFfAYSeYnJinLolwn/1bXTKBbQ2QEHOSwI+PmClilwUpX49KnDJdT1qYDJyOXntrG/oBjBQREBxCqvEEdOrbFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711979964; c=relaxed/simple;
	bh=c2EyeQBx9NYtRbJIdnzM4J73JGosmuHOGsuvEIFB0Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiIbF/8wUmj+E3B53+OfffHkEyP+L+8fDriLq/suJ2BUzPQgysaZVpO9oMg+BJYbLQ/sDDPOAyQICdK1alBjANNp8Z87sNT1/q5jLYiItI/AWVecaEkXOBr4vAAMNo8fkxiUbxAZEhbS7a47oXOZdIrwISyDAhUXjNiNpt3AR3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 1082225 invoked by uid 1000); 1 Apr 2024 09:59:14 -0400
Date: Mon, 1 Apr 2024 09:59:14 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, samsun1006219@gmail.com, xrivendell7@gmail.com
Subject: Re: FAILED: patch "[PATCH] USB: core: Fix deadlock in
 usb_deauthorize_interface()" failed to apply to 4.19-stable tree
Message-ID: <40fa743b-97cc-4172-96eb-1d55a54784aa@rowland.harvard.edu>
References: <2024040157-entrench-clicker-d3df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040157-entrench-clicker-d3df@gregkh>

On Mon, Apr 01, 2024 at 11:42:57AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x 80ba43e9f799cbdd83842fc27db667289b3150f5
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040157-entrench-clicker-d3df@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
> 
> Possible dependencies:
> 
> 80ba43e9f799 ("USB: core: Fix deadlock in usb_deauthorize_interface()")
> 
> thanks,
> 
> greg k-h

Here is the back-ported version of the patch.  It was necessary to change
kstrtobool to strtobool.

This should apply to the -stable kernels from 4.19 up to 6.1.

Alan Stern

-----------------------------------------------

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
 
 	if (strtobool(buf, &val) != 0)
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

