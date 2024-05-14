Return-Path: <stable+bounces-44899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8848C54DF
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F511F22C91
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683205FDB5;
	Tue, 14 May 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sg+AmP6i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267E553361;
	Tue, 14 May 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687500; cv=none; b=MGXCGybqGRiiMK/FBUow+CZpzvsYUpfWNo/UKSJ/ea1WVXS52tiU3flA5jBvK6BTBlKPUNnUPRTR+Y9xye/a4NoQ8802hZ115rZtrGN5cPYpVc0T8W+UjrrYcwnigIaUz9YtaKZpDvLh+1RFof9gGDX0T5sN6KHrYsoBb6Cg/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687500; c=relaxed/simple;
	bh=AF3KgWwJbARw3DYft610vHlHzeM9Q6d/4o0pNB3fv9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFdqW0SQhe0QxohUieDUWpiFNAfrXQRvWEji7qw2Cn9zN/3lU2icr2NrQ36o6Vl+K+vED2p1OeKZvwpnwEPMf6wz9rPILK2ECdAxIcg2vv43tfTiMmFa6AjAqSaXt1Ne+0Ul4AdWXGQRWBioQoESDcM0YC1w7TzxI6t2wa2cNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sg+AmP6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A433AC2BD10;
	Tue, 14 May 2024 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687500;
	bh=AF3KgWwJbARw3DYft610vHlHzeM9Q6d/4o0pNB3fv9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sg+AmP6i7TzLu0kyqKJQLPTfk8Zb84xuB7L6/IhfpNts+ef5Reh+/SpPmK8XRXJt1
	 H+7senaXk0n5/53Lu7ibLZ3qBU51Xt1+rS8xavS97VjL4JzPrIBAi4jOlbnf1XAjLW
	 xfnrSVePB8kJ7uMNGx4gEBtLUsmKGswScMG4EdZE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH 5.10 096/111] usb: gadget: composite: fix OS descriptors w_value logic
Date: Tue, 14 May 2024 12:20:34 +0200
Message-ID: <20240514101000.778009955@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
References: <20240514100957.114746054@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Korsgaard <peter@korsgaard.com>

commit ec6ce7075ef879b91a8710829016005dc8170f17 upstream.

The OS descriptors logic had the high/low byte of w_value inverted, causing
the extended properties to not be accessible for interface != 0.

>From the Microsoft documentation:
https://learn.microsoft.com/en-us/windows-hardware/drivers/usbcon/microsoft-os-1-0-descriptors-specification

OS_Desc_CompatID.doc (w_index = 0x4):

- wValue:

  High Byte = InterfaceNumber.  InterfaceNumber is set to the number of the
  interface or function that is associated with the descriptor, typically
  0x00.  Because a device can have only one extended compat ID descriptor,
  it should ignore InterfaceNumber, regardless of the value, and simply
  return the descriptor.

  Low Byte = 0.  PageNumber is used to retrieve descriptors that are larger
  than 64 KB.  The header section is 16 bytes, so PageNumber is set to 0 for
  this request.

We currently do not support >64KB compat ID descriptors, so verify that the
low byte is 0.

OS_Desc_Ext_Prop.doc (w_index = 0x5):

- wValue:

  High byte = InterfaceNumber.  The high byte of wValue is set to the number
  of the interface or function that is associated with the descriptor.

  Low byte = PageNumber.  The low byte of wValue is used to retrieve
  descriptors that are larger than 64 KB.  The header section is 10 bytes, so
  PageNumber is set to 0 for this request.

We also don't support >64KB extended properties, so verify that the low byte
is 0 and use the high byte for the interface number.

Fixes: 37a3a533429e ("usb: gadget: OS Feature Descriptors support")
Cc: stable <stable@kernel.org>
Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
Link: https://lore.kernel.org/r/20240404100635.3215340-1-peter@korsgaard.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/composite.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1925,7 +1925,7 @@ unknown:
 			buf[5] = 0x01;
 			switch (ctrl->bRequestType & USB_RECIP_MASK) {
 			case USB_RECIP_DEVICE:
-				if (w_index != 0x4 || (w_value >> 8))
+				if (w_index != 0x4 || (w_value & 0xff))
 					break;
 				buf[6] = w_index;
 				/* Number of ext compat interfaces */
@@ -1941,9 +1941,9 @@ unknown:
 				}
 				break;
 			case USB_RECIP_INTERFACE:
-				if (w_index != 0x5 || (w_value >> 8))
+				if (w_index != 0x5 || (w_value & 0xff))
 					break;
-				interface = w_value & 0xFF;
+				interface = w_value >> 8;
 				if (interface >= MAX_CONFIG_INTERFACES ||
 				    !os_desc_cfg->interface[interface])
 					break;



