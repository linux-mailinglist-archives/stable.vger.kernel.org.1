Return-Path: <stable+bounces-92381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027209C544A
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CACC1B35DFC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA02144A4;
	Tue, 12 Nov 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bMpWAiaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD10213124;
	Tue, 12 Nov 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407475; cv=none; b=iSMYDWRecV75KkRAdTkR399mpPno2lEzYYDvYMxXTc7W7fORtm+Npu3+iYZJbs9bFZUGKN/4HHeWZ6/LHVc5hSz8d2DT+FX2kIGCfWePYR7zh27v5H/Fqag5FZTLS8870JSZPMG+dX/2FpxESxKyOZMsQCjdLfahrzNm6RPBSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407475; c=relaxed/simple;
	bh=S4rmLpUYsutORoL7XppGqHUb+011SSGrR+KvqCmb8Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3wmJV/bGEB7O7aivBP0iVsgROsRpLjxqM7gNh2piiIrh6jJD3b+kRdL85kJiofNRFa6HDnUGmcsT7+jzSf0UIUj/wzhmYG85h/0O3YP2DKYXWobCaRPSPby7ge6umkQ6Dao1Tp0ydzNGjzFkrGZWXSCZRTmYJv30BXPlJXUBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bMpWAiaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C04CC4CECD;
	Tue, 12 Nov 2024 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407474;
	bh=S4rmLpUYsutORoL7XppGqHUb+011SSGrR+KvqCmb8Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMpWAiaIoSuhUJsZzs+Qk53WZT1i1r+HQ7oTOCBAVzVJdBegpcBUZJ4xwKl2Dh6TF
	 TvOyyGQnxuAraGbCe7AIpY34OuoIP63k+sa0BJZenhmLdYS/erBWV9/HBGuO4SDjRn
	 Oi+v5qVOl2fDDcdTl7Vy7WhJH2wxx4kuPxkG4o/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.1 87/98] USB: serial: io_edgeport: fix use after free in debug printk
Date: Tue, 12 Nov 2024 11:21:42 +0100
Message-ID: <20241112101847.564682788@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
References: <20241112101844.263449965@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit 37bb5628379295c1254c113a407cab03a0f4d0b4 upstream.

The "dev_dbg(&urb->dev->dev, ..." which happens after usb_free_urb(urb)
is a use after free of the "urb" pointer.  Store the "dev" pointer at the
start of the function to avoid this issue.

Fixes: 984f68683298 ("USB: serial: io_edgeport.c: remove dbg() usage")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/io_edgeport.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -770,11 +770,12 @@ static void edge_bulk_out_data_callback(
 static void edge_bulk_out_cmd_callback(struct urb *urb)
 {
 	struct edgeport_port *edge_port = urb->context;
+	struct device *dev = &urb->dev->dev;
 	int status = urb->status;
 
 	atomic_dec(&CmdUrbs);
-	dev_dbg(&urb->dev->dev, "%s - FREE URB %p (outstanding %d)\n",
-		__func__, urb, atomic_read(&CmdUrbs));
+	dev_dbg(dev, "%s - FREE URB %p (outstanding %d)\n", __func__, urb,
+		atomic_read(&CmdUrbs));
 
 
 	/* clean up the transfer buffer */
@@ -784,8 +785,7 @@ static void edge_bulk_out_cmd_callback(s
 	usb_free_urb(urb);
 
 	if (status) {
-		dev_dbg(&urb->dev->dev,
-			"%s - nonzero write bulk status received: %d\n",
+		dev_dbg(dev, "%s - nonzero write bulk status received: %d\n",
 			__func__, status);
 		return;
 	}



