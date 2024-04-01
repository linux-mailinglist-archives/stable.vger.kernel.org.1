Return-Path: <stable+bounces-34454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE86893F6A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 643852841BD
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7C47A6B;
	Mon,  1 Apr 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SFTU4hlD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF497481B3;
	Mon,  1 Apr 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988176; cv=none; b=cbU8sP2S8uOzUbzD5bEJYCbWsbwJsaxrOOB2XmUn+RHucNH1jZzWDteKCs1dY8WKIsHlIEQsXTKqv4p1TcF0r2HkhbRj9XAs6DEOigjOGyD5cSs5riUnI+6bzwWUTzVGTvGClQ+lTTQ9fJoP4O5Z4Ve1bVzjpJXz1/1Yw522k00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988176; c=relaxed/simple;
	bh=gsSQMY+mXcxXQtbriR5BBAZ9BSf0WQmv6S0ff1DQgs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aIkGP67thsvCp0xq501c4nb6qnDP2e+W81PMTT9fYDtpDEjNx9ShuxVJoPq5uZvCTfjPbJVMpWX24rf05GQSpW+GvVyKRezv6XeLjPul/UmpMbIKT4orun5jXnSlLU69TuI4LWOLRHfVHqr6cbnj88ZNrNvnuIqes4Ch1WX8V34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SFTU4hlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DCAC433F1;
	Mon,  1 Apr 2024 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988176;
	bh=gsSQMY+mXcxXQtbriR5BBAZ9BSf0WQmv6S0ff1DQgs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFTU4hlD41k90C6MZDET8frir7OaS5Y0+Qs6QXwpM8sToYm2paOZH6fJ0ISXBLQVT
	 WC1l6kzXk7BKVuyIE1K72pU5pStCfoOmnpezA5MNKbeNimPGpENAiGcLlS3tmB5FFX
	 FebNCELfmauKtQ1Dx7a2jxC0fcnKdWzB7A0hhnUU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Christian=20H=C3=A4ggstr=C3=B6m?= <christian.haggstrom@orexplore.com>,
	Johan Hovold <johan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 079/432] USB: serial: cp210x: add ID for MGP Instruments PDS100
Date: Mon,  1 Apr 2024 17:41:06 +0200
Message-ID: <20240401152555.479438595@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Häggström <christian.haggstrom@orexplore.com>

[ Upstream commit a0d9d868491a362d421521499d98308c8e3a0398 ]

The radiation meter has the text MGP Instruments PDS-100G or PDS-100GN
produced by Mirion Technologies. Tested by forcing the driver
association with

  echo 10c4 863c > /sys/bus/usb-serial/drivers/cp210x/new_id

and then setting the serial port in 115200 8N1 mode. The device
announces ID_USB_VENDOR_ENC=Silicon\x20Labs and ID_USB_MODEL_ENC=PDS100

Signed-off-by: Christian Häggström <christian.haggstrom@orexplore.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d339d81f6e8cf..2169b6549a260 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -144,6 +144,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x85EA) }, /* AC-Services IBUS-IF */
 	{ USB_DEVICE(0x10C4, 0x85EB) }, /* AC-Services CIS-IBUS */
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
+	{ USB_DEVICE(0x10C4, 0x863C) }, /* MGP Instruments PDS100 */
 	{ USB_DEVICE(0x10C4, 0x8664) }, /* AC-Services CAN-IF */
 	{ USB_DEVICE(0x10C4, 0x8665) }, /* AC-Services OBD-IF */
 	{ USB_DEVICE(0x10C4, 0x87ED) }, /* IMST USB-Stick for Smart Meter */
-- 
2.43.0




