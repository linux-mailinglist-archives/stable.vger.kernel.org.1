Return-Path: <stable+bounces-207227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47812D09C91
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38D49302CAD3
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38432AAB5;
	Fri,  9 Jan 2026 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUePwLlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AC315ADB4;
	Fri,  9 Jan 2026 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961454; cv=none; b=DbK2O4eyO4iGixavdIFw5tcAdjxH6u3I74p6oNTsLHzwrFcZrZNM1GwnOtZEUZT7tGyzM9Yx6LAFiXZc8o+760WkC4+Ij2Icf8XC0AMrHXWWnu0gEVwxfEp03BlFO5Ldf0y3n7Q4oy9UDYHZCCmYoHAjYSL0Lpb3JHTBZzqWnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961454; c=relaxed/simple;
	bh=lMfPRcRoaN9hqAj8dCoNt+yLWffxiAhyk9x9c51OYmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdFr0mn3JOZ7n6GRz2JdhwrEZ+OV2G6i4nXLsSxRc5AagShCIkH2zgslnK1ZW4IEzEcPlfye2FTuCx/ZIZyMvhF+72Yfc7NpfEKFMPmoXKHqDGe4W2dGWcB3idWYdQ20HbR6NUAezEFPc64oR2P8EdTuM67yt3TQ+RDdN9u39vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUePwLlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12000C4CEF1;
	Fri,  9 Jan 2026 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767961454;
	bh=lMfPRcRoaN9hqAj8dCoNt+yLWffxiAhyk9x9c51OYmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cUePwLlWUciJUV57Q4ubwQfSsgKvQt/yEYE87xHtp3wLUiXJJPGv/jurUDvBaYSio
	 DcZk98PvSDvc0E/B2BNkZ68770gF+qNhB1kf4GEzhrhOkgTR3uZAtdtxw6FOX+xSq7
	 SkYgiBpQN4mTGNt/N45LxqchZpi4NmTQpOuYY5qc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.1 020/634] USB: serial: kobil_sct: fix TIOCMBIS and TIOCMBIC
Date: Fri,  9 Jan 2026 12:34:58 +0100
Message-ID: <20260109112118.195670035@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit d432df758f92c4c28aac409bc807fd1716167577 upstream.

Asserting or deasserting a modem control line using TIOCMBIS or TIOCMBIC
should not deassert any lines that are not in the mask.

Fix this long-standing issue dating back to 2003 when the support for
these ioctls was added with the introduction of the tiocmset() callback.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/kobil_sct.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -420,7 +420,7 @@ static int kobil_tiocmset(struct tty_str
 	struct usb_serial_port *port = tty->driver_data;
 	struct device *dev = &port->dev;
 	struct kobil_private *priv;
-	int result;
+	int result = 0;
 	int dtr = 0;
 	int rts = 0;
 
@@ -437,12 +437,12 @@ static int kobil_tiocmset(struct tty_str
 	if (set & TIOCM_DTR)
 		dtr = 1;
 	if (clear & TIOCM_RTS)
-		rts = 0;
+		rts = 1;
 	if (clear & TIOCM_DTR)
-		dtr = 0;
+		dtr = 1;
 
-	if (priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID) {
-		if (dtr != 0)
+	if (dtr && priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID) {
+		if (set & TIOCM_DTR)
 			dev_dbg(dev, "%s - Setting DTR\n", __func__);
 		else
 			dev_dbg(dev, "%s - Clearing DTR\n", __func__);
@@ -450,13 +450,13 @@ static int kobil_tiocmset(struct tty_str
 			  usb_sndctrlpipe(port->serial->dev, 0),
 			  SUSBCRequest_SetStatusLinesOrQueues,
 			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			  ((dtr != 0) ? SUSBCR_SSL_SETDTR : SUSBCR_SSL_CLRDTR),
+			  ((set & TIOCM_DTR) ? SUSBCR_SSL_SETDTR : SUSBCR_SSL_CLRDTR),
 			  0,
 			  NULL,
 			  0,
 			  KOBIL_TIMEOUT);
-	} else {
-		if (rts != 0)
+	} else if (rts) {
+		if (set & TIOCM_RTS)
 			dev_dbg(dev, "%s - Setting RTS\n", __func__);
 		else
 			dev_dbg(dev, "%s - Clearing RTS\n", __func__);
@@ -464,7 +464,7 @@ static int kobil_tiocmset(struct tty_str
 			usb_sndctrlpipe(port->serial->dev, 0),
 			SUSBCRequest_SetStatusLinesOrQueues,
 			USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			((rts != 0) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
+			((set & TIOCM_RTS) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
 			0,
 			NULL,
 			0,



