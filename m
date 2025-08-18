Return-Path: <stable+bounces-169974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA575B29F57
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461A27B1354
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31E52765DC;
	Mon, 18 Aug 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kKCNffQA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A412765C9
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513896; cv=none; b=NEp8uDQX5i7RUVLeSoe9dRs9C2JsCpqeJ4vMNaEIR8ThsK+QkUZaVfb1yW62ZQHJPGj4e3PMftTIcc5HcjVuVPQSgro66/IEXrXLclk+yZlz/H+ud1JJlNpnSgZ6eFmu2PanuuSZiXwVx09R1Joyhobf2OhrDqCNZwklemgMVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513896; c=relaxed/simple;
	bh=5s6nVHsweM5N9m4y5RVqdFke67lpZuvhvJHPf3OXjp4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C/IJYdOa/2TaXhnyNSS3w4qno+VNSXQIT2RclG8amTIEVSwggZYKFkIEPmmtWL3P9aebRwe7xaSmfnDvzMkBt6TkigyWNicTVXZMtmWn4sX7NVJkLy4BbY3SM6l0L3t8pq+zl/1eYz6Sy2wDCzVVxMhQGfan1M54Jnxpx27PzMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kKCNffQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBDBC4CEEB;
	Mon, 18 Aug 2025 10:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755513896;
	bh=5s6nVHsweM5N9m4y5RVqdFke67lpZuvhvJHPf3OXjp4=;
	h=Subject:To:Cc:From:Date:From;
	b=kKCNffQAnZnQ/RqHU4/DScxhFitk6lAwKFpvZav9Lj+zQGXClNDZzTlsHTOXK6XjB
	 QFHE5ILJ8B9x0BKta14cnj0E8VzH3ooSoMti5rGy8RL36TSRc3M6HWGNgJsKu6e0M7
	 lGyH1GAFhxnG+Lee9IfJDfqTKcBFMmXE0nW69CCk=
Subject: FAILED: patch "[PATCH] cdc-acm: fix race between initial clearing halt and open" failed to apply to 5.4-stable tree
To: oneukum@suse.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:44:47 +0200
Message-ID: <2025081847-user-synthesis-c726@gregkh>
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
git cherry-pick -x 64690a90cd7c6db16d3af8616be1f4bf8d492850
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081847-user-synthesis-c726@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


