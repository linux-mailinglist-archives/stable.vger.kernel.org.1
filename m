Return-Path: <stable+bounces-204222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B257ACE9D6F
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 14:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C77313003FFC
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0C7243376;
	Tue, 30 Dec 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ox4H5dJC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348C241103
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103167; cv=none; b=fRYJm1X7H3J7HxVFhdyGlN11Ixb2e14llNQEhOIhDZ3tV32b0Q9G3OdF391yA0s1cwuSOHqnRaYZppkgTZmirldwxlNPQWb1eEsD0Ki1WBEaq2mFjl/IHC/9mMa8+kKoukwlYcGSFMKcDYzOq/o4DRgkoHfpK8lz+Z/OCQ5YIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103167; c=relaxed/simple;
	bh=vGgRUn/jVGpX6UVEIv1sBYfYKeEu49ixcMZOR6IThSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9RPZ4a4gncRi8iPG0qU5OK+4Z48oyRL8pwq2IyqtscyuWFENvOx8+aFK/iumNobkizaiSrGDJhJFz2J+/GJhQgk/bBC76b75/MMI7Hw6KnTmQ+G1i2/eO/579kojymLLiJH9k59kti9c3wCiw9mFQCYZ+z33QftNN1FDgT5QLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ox4H5dJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C73C116D0;
	Tue, 30 Dec 2025 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767103167;
	bh=vGgRUn/jVGpX6UVEIv1sBYfYKeEu49ixcMZOR6IThSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ox4H5dJCLOjjMFFrt1Hvc5/iBjI/rzsWNinuaiIHLu1PqKf/7ZzZwu3F4SrGllDk2
	 FIwgxDtW4zAFoz2ypskPluRZo2Vyq9H532bDSW2QA03QSiyIKTEcyYrkQbhdRX3dej
	 8Z61lWY9atCoaj0JEgoI43gtxVGeghLZpsVIsRJ77kGdftDnQFUHKkp++O0FioJx3Z
	 ReSo6bsKccVQ5z826OGHdLbikxqX4E1u8jzMAdDUNBx2Wd4zLntCkoXmJ34w5Iiomr
	 yRNfEHBiIYd+v8bP5PHGJURn3stpI9CQDboYqz+V+sL/BKZiIQvtLy6pXscd8btqNc
	 QxJTj1iJDRNnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] serial: core: Restore sysfs fwnode information
Date: Tue, 30 Dec 2025 08:59:18 -0500
Message-ID: <20251230135918.2221627-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230135918.2221627-1-sashal@kernel.org>
References: <2025122929-reoccupy-raking-f984@gregkh>
 <20251230135918.2221627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 24ec03cc55126b7b3adf102f4b3d9f716532b329 ]

The change that restores sysfs fwnode information does it only for OF cases.
Update the fix to cover all possible types of fwnodes.

Fixes: d36f0e9a0002 ("serial: core: restore of_node information in sysfs")
Cc: stable <stable@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20251127163650.2942075-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_base_bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

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
 
-- 
2.51.0


