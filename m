Return-Path: <stable+bounces-68549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B29532E1
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4DA1F21F93
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AD21AD404;
	Thu, 15 Aug 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L9i+MMpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516119F49B;
	Thu, 15 Aug 2024 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730921; cv=none; b=SFQIOZUtoYhcin8Avfu6lo/1OlMTFnj8U6WxXL1eA2vYVxn7P6kTuLMF+j4JbFpeCU+TCOPJwwe0qpOE9h18Ux2SzUD2BhoUTk1bmeLGqRUNNd3xZ+L/BcTb561UjjkVrxkneqSRJ2HeLOwKppnsh+G19rzIQemCZ9zXMn40Pfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730921; c=relaxed/simple;
	bh=4tWxhbAZMOk+fJFHVBBJotIhYSoI3WW3cahaWFdjX8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJK3CJAJwczRBt+LaUdwN7k3NvPZ42nZshksRlEynELpd3Mp3aI9bdacnJqevNzYo0fWk67hJhoOnbzB6JkJzoeGi61qMHReAgv40DBTgGpNUKoIwtRuJXxBYvMkwCTXi2UxN+WSIEvqW9ThvGIfPwHO6HogCKBqzcujD7BH6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L9i+MMpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B082C32786;
	Thu, 15 Aug 2024 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730921;
	bh=4tWxhbAZMOk+fJFHVBBJotIhYSoI3WW3cahaWFdjX8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L9i+MMpFKjpfgtgKIT4+5OljBayqRu41KsuU3zPebjOZzu2VdjhrxH+iYBTUV9tMG
	 u1rbqQ2Y82U1LQ+gdxowaFESCwK0G1aJ2uN64EEm9hoEUKWRjsi1og5dYA3dsCOoWG
	 3Jjb1Uuf5qS1BYhaJiPB6xn7HHFEsqmSBenVTVGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
Subject: [PATCH 6.6 35/67] Input: bcm5974 - check endpoint type before starting traffic
Date: Thu, 15 Aug 2024 15:25:49 +0200
Message-ID: <20240815131839.670893903@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
References: <20240815131838.311442229@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 2b9c3eb32a699acdd4784d6b93743271b4970899 ]

syzbot has found a type mismatch between a USB pipe and the transfer
endpoint, which is triggered by the bcm5974 driver[1].

This driver expects the device to provide input interrupt endpoints and
if that is not the case, the driver registration should terminate.

Repros are available to reproduce this issue with a certain setup for
the dummy_hcd, leading to an interrupt/bulk mismatch which is caught in
the USB core after calling usb_submit_urb() with the following message:
"BOGUS urb xfer, pipe 1 != type 3"

Some other device drivers (like the appletouch driver bcm5974 is mainly
based on) provide some checking mechanism to make sure that an IN
interrupt endpoint is available. In this particular case the endpoint
addresses are provided by a config table, so the checking can be
targeted to the provided endpoints.

Add some basic checking to guarantee that the endpoints available match
the expected type for both the trackpad and button endpoints.

This issue was only found for the trackpad endpoint, but the checking
has been added to the button endpoint as well for the same reasons.

Given that there was never a check for the endpoint type, this bug has
been there since the first implementation of the driver (f89bd95c5c94).

[1] https://syzkaller.appspot.com/bug?extid=348331f63b034f89b622

Fixes: f89bd95c5c94 ("Input: bcm5974 - add driver for Macbook Air and Pro Penryn touchpads")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-and-tested-by: syzbot+348331f63b034f89b622@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20231007-topic-bcm5974_bulk-v3-1-d0f38b9d2935@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/bcm5974.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index ca150618d32f1..953992b458e9f 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -19,6 +19,7 @@
  * Copyright (C) 2006	   Nicolas Boichat (nicolas@boichat.ch)
  */
 
+#include "linux/usb.h"
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -193,6 +194,8 @@ enum tp_type {
 
 /* list of device capability bits */
 #define HAS_INTEGRATED_BUTTON	1
+/* maximum number of supported endpoints (currently trackpad and button) */
+#define MAX_ENDPOINTS	2
 
 /* trackpad finger data block size */
 #define FSIZE_TYPE1		(14 * sizeof(__le16))
@@ -891,6 +894,18 @@ static int bcm5974_resume(struct usb_interface *iface)
 	return error;
 }
 
+static bool bcm5974_check_endpoints(struct usb_interface *iface,
+				    const struct bcm5974_config *cfg)
+{
+	u8 ep_addr[MAX_ENDPOINTS + 1] = {0};
+
+	ep_addr[0] = cfg->tp_ep;
+	if (cfg->tp_type == TYPE1)
+		ep_addr[1] = cfg->bt_ep;
+
+	return usb_check_int_endpoints(iface, ep_addr);
+}
+
 static int bcm5974_probe(struct usb_interface *iface,
 			 const struct usb_device_id *id)
 {
@@ -903,6 +918,11 @@ static int bcm5974_probe(struct usb_interface *iface,
 	/* find the product index */
 	cfg = bcm5974_get_config(udev);
 
+	if (!bcm5974_check_endpoints(iface, cfg)) {
+		dev_err(&iface->dev, "Unexpected non-int endpoint\n");
+		return -ENODEV;
+	}
+
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(struct bcm5974), GFP_KERNEL);
 	input_dev = input_allocate_device();
-- 
2.43.0




