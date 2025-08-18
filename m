Return-Path: <stable+bounces-169975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C81B29F59
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F763BBF23
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198FA2765D5;
	Mon, 18 Aug 2025 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sUVO22BR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03B2C2371
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513899; cv=none; b=Ys20i+WZ8lg4K84sdiWti+Yt0C0CWBwc1nwWsBiiYtr0j59Sall6LT2QTVMpI3ye5tTnFkXwO+7UPac2R88OwtXhqShvCTTiToxAart0DVIDUZIexOZeGr0uE5qd+uXn5sFdLDCyHm4jxj+FWF3CTBALqwky3PhfjKEEyRgthiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513899; c=relaxed/simple;
	bh=yJQ+yOYZIpA4PMSXExqj9fShJy2WFnuMPiKbWuXkvgI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fl8XZxd+Vm3RKHmgdqUdhhLlD+kUxEJ4cD5u4Zz3yseXjfh0vZmHtmC/j/RRyw2pOmzYs9dHKFAPX3hobc39T/OevKuR5gbkcb6j15dMHrxLErEOBJKu2EFNVCzyVtieZzq2wvN7Kx2LvWnCY94YdE4vrvvYQVgi+esv2pa2MZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sUVO22BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B54C4CEEB;
	Mon, 18 Aug 2025 10:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755513899;
	bh=yJQ+yOYZIpA4PMSXExqj9fShJy2WFnuMPiKbWuXkvgI=;
	h=Subject:To:Cc:From:Date:From;
	b=sUVO22BRFOyYUWGRu/tgxJkPqTH0T0bK/aZkEoFnK5sqAhxJY/FtsyrbrSCN975RU
	 e+fyMj6SsYD5X6ZWNwL1xGrzlGGmYnaOmmbAk1NqnBPZq9SWA4VAW3+Q3iWSAUuX3R
	 z4xk5N73QaKo3E+9SLZtNRSHRfjMkrrJNpzbXvqY=
Subject: FAILED: patch "[PATCH] cdc-acm: fix race between initial clearing halt and open" failed to apply to 5.10-stable tree
To: oneukum@suse.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:44:47 +0200
Message-ID: <2025081847-resident-transform-fcca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 64690a90cd7c6db16d3af8616be1f4bf8d492850
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081847-resident-transform-fcca@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 64690a90cd7c6db16d3af8616be1f4bf8d492850 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Thu, 17 Jul 2025 16:12:50 +0200
Subject: [PATCH] cdc-acm: fix race between initial clearing halt and open

On the devices that need their endpoints to get an
initial clear_halt, this needs to be done before
the devices can be opened. That means it needs to be
before the devices are registered.

Fixes: 15bf722e6f6c0 ("cdc-acm: Add support of ATOL FPrint fiscal printers")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/20250717141259.2345605-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index c2ecfa3c8349..5a334e370f4d 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -1520,6 +1520,12 @@ static int acm_probe(struct usb_interface *intf,
 			goto err_remove_files;
 	}
 
+	if (quirks & CLEAR_HALT_CONDITIONS) {
+		/* errors intentionally ignored */
+		usb_clear_halt(usb_dev, acm->in);
+		usb_clear_halt(usb_dev, acm->out);
+	}
+
 	tty_dev = tty_port_register_device(&acm->port, acm_tty_driver, minor,
 			&control_interface->dev);
 	if (IS_ERR(tty_dev)) {
@@ -1527,11 +1533,6 @@ static int acm_probe(struct usb_interface *intf,
 		goto err_release_data_interface;
 	}
 
-	if (quirks & CLEAR_HALT_CONDITIONS) {
-		usb_clear_halt(usb_dev, acm->in);
-		usb_clear_halt(usb_dev, acm->out);
-	}
-
 	dev_info(&intf->dev, "ttyACM%d: USB ACM device\n", minor);
 
 	return 0;


