Return-Path: <stable+bounces-189009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E57ABFCDCC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B4019C7034
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A439C34DB5A;
	Wed, 22 Oct 2025 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvuE/DfD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA3934D4EE;
	Wed, 22 Oct 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146814; cv=none; b=rfBUBGfg21rDnVZpTaBCUNaAQgPw3vpjjdSPIRaNgC0HNMU8BXKICZNg00FHVbaZu+sJV8LCl2b2UqVEy3TVpuRWkAm2WulNilhYhPdNCMTrHdj/1v+Raf9flB5MHwqIUxRefETywcMsM+V/ruT4+19CV8zn2Zdk+zjUYRsLIRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146814; c=relaxed/simple;
	bh=oA3wjbbjuI9VJKX4+gxqJBRq5ZTkS6yh9fDd34QwJ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEFnmsqDgVcJ6GUgCv5MCzTJPc6mDmgIFNVb9MRHEJ/YpXPlJTVGRFEf4tDyL2AGh10aAsFlSipvXdSLl7NhftU5rdNgHmCmI23cIahJz6xgn6TstIF6VKz/nZY+P0n5KNvjWs1osiIsQgRHZqPrsDk9kMejvHuCnogjJ9W8F24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvuE/DfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09DFC4CEF5;
	Wed, 22 Oct 2025 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146813;
	bh=oA3wjbbjuI9VJKX4+gxqJBRq5ZTkS6yh9fDd34QwJ5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvuE/DfD4nqRSWWOdUvufiFepbolnoAiaCMsbkScweEkZC5HcX2oV6K2YHX/PL26J
	 U9p+4JXCOzbRVoRQVles3pOQi9WXEJyWSiW1JblrBV5kunVFH0VPv4KctOTCt2U4sQ
	 W8YOp2hjRCpNoUlT/iLxwERFhtrXnwiPf990EL70iYHoWQ11g3JWgMaVapOciCWA34
	 0XIE1wSGGUPMBRu+eQq3Zpstet2L/kYdjTyTWbEhgd9Y8V8V8/3u6UbOIwTwMvCWoo
	 sHZAs4oZE9oaDajWRcJIVzbxXT1uxfIa2LeBtoRKfgRubeSw4mQPByx93n/XSl/5pi
	 Je3ZFgwPqOhZA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBajr-000000006JG-33xk;
	Wed, 22 Oct 2025 17:26:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/8] USB: serial: kobil_sct: fix TIOCMBIS and TIOCMBIC
Date: Wed, 22 Oct 2025 17:26:34 +0200
Message-ID: <20251022152640.24212-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251022152640.24212-1-johan@kernel.org>
References: <20251022152640.24212-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asserting or deasserting a modem control line using TIOCMBIS or TIOCMBIC
should not deassert any lines that are not in the mask.

Fix this long-standing issue dating back to 2003 when the support for
these ioctls was added with the introduction of the tiocmset() callback.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/kobil_sct.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 464433be2034..96ea571c436a 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -418,7 +418,7 @@ static int kobil_tiocmset(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 	struct device *dev = &port->dev;
 	struct kobil_private *priv;
-	int result;
+	int result = 0;
 	int dtr = 0;
 	int rts = 0;
 
@@ -435,12 +435,12 @@ static int kobil_tiocmset(struct tty_struct *tty,
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
@@ -448,13 +448,13 @@ static int kobil_tiocmset(struct tty_struct *tty,
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
@@ -462,7 +462,7 @@ static int kobil_tiocmset(struct tty_struct *tty,
 			usb_sndctrlpipe(port->serial->dev, 0),
 			SUSBCRequest_SetStatusLinesOrQueues,
 			USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			((rts != 0) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
+			((set & TIOCM_RTS) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
 			0,
 			NULL,
 			0,
-- 
2.49.1


