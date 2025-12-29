Return-Path: <stable+bounces-203571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC72CE6EC9
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D88693009B24
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815F823EAA5;
	Mon, 29 Dec 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EACTLD3j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E12309BE
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016533; cv=none; b=gD6XBqph3OGAW9OYkCzh02YRny+ELXAd3fuwN/2lKQQxqKaMOIcHZeztMJ09X0ZA2FnBYhmOyogCgjIeMK59fUt4G4uLHMly0bufbxsfguejPUWveXWUHbGDyqQS/1atZOmYUh6CgVoDLhoSZhfMRLpzBZyNPHSWTTy0m2o8i2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016533; c=relaxed/simple;
	bh=rtP7jiAn9fAZU4y7mNCnfhil7Yky50XzerrAwvpYiUg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nHQfltJ+21cIaOUrQFXYxg7sqweWj/xtn4aJgvif9gY44/wA7D3OQis1uPi6OUVfK+XGj8/F0vrp/IYGDip3Oy6lIlVKMRagqck99Yqhin6CPctLvvst6oTLJSak26qWoR0PYH1xXkAmx8oobXyrkPSCjtRWQ48NvB9sp/7KkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EACTLD3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2EAC16AAE;
	Mon, 29 Dec 2025 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016532;
	bh=rtP7jiAn9fAZU4y7mNCnfhil7Yky50XzerrAwvpYiUg=;
	h=Subject:To:Cc:From:Date:From;
	b=EACTLD3j+qCP3NUdwV6P70mnRthXwPKXpSThycbhRgK6h26yV1TZ82EX3hcC555MP
	 oyRf2MwPUutaM1AocBLIKY32DHIVfxzPgp/FINoPgLat3oU8Vv4iPfuGxYU0hE1xP0
	 MiyE4qScvXCMv0AtTBjf7jHogi3qnfuL62Huk//o=
Subject: FAILED: patch "[PATCH] serial: core: Restore sysfs fwnode information" failed to apply to 6.12-stable tree
To: andriy.shevchenko@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:55:29 +0100
Message-ID: <2025122929-reoccupy-raking-f984@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 24ec03cc55126b7b3adf102f4b3d9f716532b329
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122929-reoccupy-raking-f984@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 24ec03cc55126b7b3adf102f4b3d9f716532b329 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 27 Nov 2025 17:36:50 +0100
Subject: [PATCH] serial: core: Restore sysfs fwnode information

The change that restores sysfs fwnode information does it only for OF cases.
Update the fix to cover all possible types of fwnodes.

Fixes: d36f0e9a0002 ("serial: core: restore of_node information in sysfs")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20251127163650.2942075-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 22749ab0428a..8e891984cdc0 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -13,7 +13,7 @@
 #include <linux/device.h>
 #include <linux/idr.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/serial_core.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -60,6 +60,7 @@ void serial_base_driver_unregister(struct device_driver *driver)
 	driver_unregister(driver);
 }
 
+/* On failure the caller must put device @dev with put_device() */
 static int serial_base_device_init(struct uart_port *port,
 				   struct device *dev,
 				   struct device *parent_dev,
@@ -73,7 +74,8 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
-	device_set_of_node_from_dev(dev, parent_dev);
+
+	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
 
 	if (!serial_base_initialized) {
 		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
@@ -94,7 +96,7 @@ static void serial_base_ctrl_release(struct device *dev)
 {
 	struct serial_ctrl_device *ctrl_dev = to_serial_base_ctrl_device(dev);
 
-	of_node_put(dev->of_node);
+	fwnode_handle_put(dev_fwnode(dev));
 	kfree(ctrl_dev);
 }
 
@@ -142,7 +144,7 @@ static void serial_base_port_release(struct device *dev)
 {
 	struct serial_port_device *port_dev = to_serial_base_port_device(dev);
 
-	of_node_put(dev->of_node);
+	fwnode_handle_put(dev_fwnode(dev));
 	kfree(port_dev);
 }
 


