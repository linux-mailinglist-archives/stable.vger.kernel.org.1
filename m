Return-Path: <stable+bounces-200325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CC2CAC3C4
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 07:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0EC30206B6
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C88136672;
	Mon,  8 Dec 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QntxHEES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CDB12B94
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176866; cv=none; b=bDZgVt63zydxIlK+SGem+KKJuYs6k1NChK0SJSxWd8zR3m1vd5k4eLsSomf66A7CwekX1igPC1xt3GFE5Cd7NgD3233mCMZhkmJSyVcasTnoPko8xH3n3TGRbydjdCxG9smfVWvOTF+vhMyeunqMdru+qRLHIxkTxPJbvtbRR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176866; c=relaxed/simple;
	bh=tVX64UYvfgXBU9gKFNEgEgYc88BHidmjGC4MixhLOmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZecTfo5fO0zGflTg6+z6qrPO00bdWjS91ZNGUeQxqEVI1GTQvTfcjMcTM15PNszGGRx/ZNkHRV3mpa3Cf3ou4y/U/jOaGyZJbIVbsDIvime2zD5uF6jLAtIihWE0XNjG4dV2/dG6EAIHj/kJ7jrSYzVhmwkH2ulVug7wP5X7mcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QntxHEES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FB4C4CEF1;
	Mon,  8 Dec 2025 06:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765176866;
	bh=tVX64UYvfgXBU9gKFNEgEgYc88BHidmjGC4MixhLOmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QntxHEESM3iH4s8b1fy13/jFrR168ypWQ8oXQRsNa9Mm2C3vzpo2tAzfQNUMbC9Zf
	 5zTQlrss+1KBi+k154Mv+oAy5dk6S3jCRXVNZEEQeytebvb5mlfRq1UpPYl3Ofe/K9
	 PfvnQ6wHrCLS8G9XU8l7YtcvrVt1iYxiSPbK1XCUeARP/RDGNiGayTR6aDnXe6eBqW
	 ajgFWiSsK8R80s7phDSZpY2RysRXJJ5rHLxkAEIciYqNWQvppjIxpsx9ZWsy4wwzLp
	 aYmIIj7/fWJmcJio/sY4eeUCgeJeImNu5couDZXAP5bA7W9AW7VRp+AmzBKoierMHX
	 nBz7+JEjdU+/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] xhci: dbgtty: use IDR to support several dbc instances.
Date: Mon,  8 Dec 2025 01:54:22 -0500
Message-ID: <20251208065423.260017-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120110-deuce-arrange-e66c@gregkh>
References: <2025120110-deuce-arrange-e66c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit e1ec140f273e1e30cea7e6d5f50934d877232121 ]

To support systems with several xhci controllers with active
dbc on each xhci we need to use IDR to identify and give
an index to each port.

Avoid using global struct tty_driver.driver_state for storing
dbc port pointer as it won't work with several dbc ports

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20220216095153.1303105-6-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.h |  1 +
 drivers/usb/host/xhci-dbgtty.c | 46 ++++++++++++++++++++++++++++------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 5109ea3c51da0..98e7331ca0951 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -102,6 +102,7 @@ struct dbc_ep {
 struct dbc_port {
 	struct tty_port			port;
 	spinlock_t			port_lock;	/* port access */
+	int				minor;
 
 	struct list_head		read_pool;
 	struct list_head		read_queue;
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index f1387161b32da..20e50e559c2a2 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/idr.h>
 
 #include "xhci.h"
 #include "xhci-dbgcap.h"
@@ -18,6 +19,8 @@ static int dbc_tty_init(void);
 static void dbc_tty_exit(void);
 
 static struct tty_driver *dbc_tty_driver;
+static struct idr dbc_tty_minors;
+static DEFINE_MUTEX(dbc_tty_minors_lock);
 
 static inline struct dbc_port *dbc_to_port(struct xhci_dbc *dbc)
 {
@@ -195,7 +198,14 @@ xhci_dbc_free_requests(struct list_head *head)
 
 static int dbc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
-	struct dbc_port		*port = driver->driver_state;
+	struct dbc_port		*port;
+
+	mutex_lock(&dbc_tty_minors_lock);
+	port = idr_find(&dbc_tty_minors, tty->index);
+	mutex_unlock(&dbc_tty_minors_lock);
+
+	if (!port)
+		return -ENXIO;
 
 	tty->driver_data = port;
 
@@ -424,6 +434,15 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 
 	xhci_dbc_tty_init_port(dbc, port);
 
+	mutex_lock(&dbc_tty_minors_lock);
+	port->minor = idr_alloc(&dbc_tty_minors, port, 0, 64, GFP_KERNEL);
+	mutex_unlock(&dbc_tty_minors_lock);
+
+	if (port->minor < 0) {
+		ret = port->minor;
+		goto err_idr;
+	}
+
 	ret = kfifo_alloc(&port->write_fifo, DBC_WRITE_BUF_SIZE, GFP_KERNEL);
 	if (ret)
 		goto err_exit_port;
@@ -439,7 +458,7 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 		goto err_free_requests;
 
 	tty_dev = tty_port_register_device(&port->port,
-					   dbc_tty_driver, 0, NULL);
+					   dbc_tty_driver, port->minor, NULL);
 	if (IS_ERR(tty_dev)) {
 		ret = PTR_ERR(tty_dev);
 		goto err_free_requests;
@@ -455,6 +474,8 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 err_free_fifo:
 	kfifo_free(&port->write_fifo);
 err_exit_port:
+	idr_remove(&dbc_tty_minors, port->minor);
+err_idr:
 	xhci_dbc_tty_exit_port(port);
 
 	dev_err(dbc->dev, "can't register tty port, err %d\n", ret);
@@ -468,10 +489,14 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 
 	if (!port->registered)
 		return;
-	tty_unregister_device(dbc_tty_driver, 0);
+	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
 	port->registered = false;
 
+	mutex_lock(&dbc_tty_minors_lock);
+	idr_remove(&dbc_tty_minors, port->minor);
+	mutex_unlock(&dbc_tty_minors_lock);
+
 	kfifo_free(&port->write_fifo);
 	xhci_dbc_free_requests(&port->read_pool);
 	xhci_dbc_free_requests(&port->read_queue);
@@ -500,9 +525,8 @@ int xhci_dbc_tty_probe(struct device *dev, void __iomem *base, struct xhci_hcd *
 		goto out;
 	}
 
-	dbc_tty_driver->driver_state = port;
-
 	dbc = xhci_alloc_dbc(dev, base, &dbc_driver);
+
 	if (!dbc) {
 		status = -ENOMEM;
 		goto out2;
@@ -541,10 +565,14 @@ static int dbc_tty_init(void)
 {
 	int		ret;
 
-	dbc_tty_driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW |
+	idr_init(&dbc_tty_minors);
+
+	dbc_tty_driver = tty_alloc_driver(64, TTY_DRIVER_REAL_RAW |
 					  TTY_DRIVER_DYNAMIC_DEV);
-	if (IS_ERR(dbc_tty_driver))
+	if (IS_ERR(dbc_tty_driver)) {
+		idr_destroy(&dbc_tty_minors);
 		return PTR_ERR(dbc_tty_driver);
+	}
 
 	dbc_tty_driver->driver_name = "dbc_serial";
 	dbc_tty_driver->name = "ttyDBC";
@@ -564,7 +592,9 @@ static int dbc_tty_init(void)
 	if (ret) {
 		pr_err("Can't register dbc tty driver\n");
 		tty_driver_kref_put(dbc_tty_driver);
+		idr_destroy(&dbc_tty_minors);
 	}
+
 	return ret;
 }
 
@@ -575,4 +605,6 @@ static void dbc_tty_exit(void)
 		tty_driver_kref_put(dbc_tty_driver);
 		dbc_tty_driver = NULL;
 	}
+
+	idr_destroy(&dbc_tty_minors);
 }
-- 
2.51.0


