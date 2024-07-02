Return-Path: <stable+bounces-56723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BBA9245B3
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93008B246C9
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5421BE222;
	Tue,  2 Jul 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qv8lxsdb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FD1B583A;
	Tue,  2 Jul 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941143; cv=none; b=ITw/rRv4iRo08EvrRuSUJCGjPvkEvkswCuFEMr0uUKyd98DqafWEwQBa+jUTajmMeNcA03uaf8ah+htyVQrGgbs/7mW4ZHF7Q+l3AAmVOr7LME3p6ZKUR6U9WQASl/zuiFb+H5QCwRS7s4SOvQtEIaMFg/W31JCOJMy863c5KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941143; c=relaxed/simple;
	bh=WPbzg34fj1SxgY9EA91Cseqcx4CBwwbcRyrUzoUKLjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlGPFRmnNv4iBGK8ijk/5BscIs/PNGvgfhIg7oHWQzfvdvHi6x9HypYTAHyhs/dQrJpkX/DQqVdx+z4jeGo3vLBZ5SVFIfNvR3a7xnoEzwzqonL710tkaqgLSkfSahzugdPL+d9ej56alEZDNx4W9YA2TuhBKws1OFFnkI999fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qv8lxsdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1686DC116B1;
	Tue,  2 Jul 2024 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941143;
	bh=WPbzg34fj1SxgY9EA91Cseqcx4CBwwbcRyrUzoUKLjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qv8lxsdbRtXkH6+9bPwX/QTtJ5nKW/e786hC/aZvUgTU5vkjfHWDBwbJXJGUmpvif
	 zltGpgPIm+aKJn6jUv0bzkP2yxR8m9KnFqtpw/sPvaGpfdE1wnb/o8BNWvV9ZMadsq
	 9pHUVifuWoYY/oN2w84UGMs914FvFKmbtGZuUpcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neal Liu <neal_liu@aspeedtech.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>
Subject: [PATCH 6.6 110/163] usb: gadget: aspeed_udc: fix device address configuration
Date: Tue,  2 Jul 2024 19:03:44 +0200
Message-ID: <20240702170237.221248338@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
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

From: Jeremy Kerr <jk@codeconstruct.com.au>

commit dba7567c2fbbf10a4de2471cdb0e16e5572dc007 upstream.

In the aspeed UDC setup, we configure the UDC hardware with the assigned
USB device address.

However, we have an off-by-one in the bitmask, so we're only setting the
lower 6 bits of the address (USB addresses being 7 bits, and the
hardware bitmask being bits 0:6).

This means that device enumeration fails if the assigned address is
greater than 64:

[  344.607255] usb 1-1: new high-speed USB device number 63 using ehci-platform
[  344.808459] usb 1-1: New USB device found, idVendor=cc00, idProduct=cc00, bcdDevice= 6.10
[  344.817684] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  344.825671] usb 1-1: Product: Test device
[  344.831075] usb 1-1: Manufacturer: Test vendor
[  344.836335] usb 1-1: SerialNumber: 00
[  349.917181] usb 1-1: USB disconnect, device number 63
[  352.036775] usb 1-1: new high-speed USB device number 64 using ehci-platform
[  352.249432] usb 1-1: device descriptor read/all, error -71
[  352.696740] usb 1-1: new high-speed USB device number 65 using ehci-platform
[  352.909431] usb 1-1: device descriptor read/all, error -71

Use the correct mask of 0x7f (rather than 0x3f), and generate this
through the GENMASK macro, so we have numbers that correspond exactly
to the hardware register definition.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Cc: stable@vger.kernel.org
Reviewed-by: Neal Liu <neal_liu@aspeedtech.com>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
Link: https://lore.kernel.org/r/20240613-aspeed-udc-v2-1-29501ce9cb7a@codeconstruct.com.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/aspeed_udc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -66,8 +66,8 @@
 #define USB_UPSTREAM_EN			BIT(0)
 
 /* Main config reg */
-#define UDC_CFG_SET_ADDR(x)		((x) & 0x3f)
-#define UDC_CFG_ADDR_MASK		(0x3f)
+#define UDC_CFG_SET_ADDR(x)		((x) & UDC_CFG_ADDR_MASK)
+#define UDC_CFG_ADDR_MASK		GENMASK(6, 0)
 
 /* Interrupt ctrl & status reg */
 #define UDC_IRQ_EP_POOL_NAK		BIT(17)



