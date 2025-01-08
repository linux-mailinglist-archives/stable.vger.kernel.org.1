Return-Path: <stable+bounces-107981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5070FA05811
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 11:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40057A080D
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BA1F75B3;
	Wed,  8 Jan 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C66O9fGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C52A1CEAD6;
	Wed,  8 Jan 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331887; cv=none; b=mx5YlV3997cIFm3lw7FKi6kM1gWivUXmfjlnVUmu+RnG4s5qIwBBAwStGip460fUIVeT7MGWYdFE56/LsBOYsSYBe4jgau0XbqX9PE/X8qHnLg/TO+WIvFGJ6NGxOZO9wsiFxuR6ETWvXWHXOhPGjVVZyPYDsEG1+LeTxU6LXAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331887; c=relaxed/simple;
	bh=dIvIKEgaV2quHkVp9B49gKPvI3m7KtT5nA+lZz81J40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsan21t3nghQabj1/wHpQBSLKnr/+lu9Aml5XJ275o0UKMC3gLxGEOr2TSES7gPe+AxtTdoWDALovFR2Led/alzgpvAqVk+5hdDpw+wOTb9AOVChTvqeW/FYSAtMGj7eAUG3KPf2IGl9alcQkIH9bLWpSb9YVa85kVRE1/RxLT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C66O9fGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04990C4CEDF;
	Wed,  8 Jan 2025 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736331887;
	bh=dIvIKEgaV2quHkVp9B49gKPvI3m7KtT5nA+lZz81J40=;
	h=From:To:Cc:Subject:Date:From;
	b=C66O9fGk8VdyB/mf8FpOd5aH+X/NnaLmb3S+iA5/K2ZuvC6cemXB82d3MlvAU9qRE
	 JokPrsZxZiaa4K5qeAg4W0y1d+jirNK8j8iQmcBkU9dU+MJGxlSFoOzoqfxcD/9Jaq
	 5ws01KxPWqAFdBV/5Ymr1FVuQ3vak+dT3bQdg5gaTmZ7AHWx3xQhBdJunIrqg2GO65
	 JStRq6MKiim91DnZtq9I3XdwACQjjhTsFcqfIJEEbDlAxZETy+NLOGgK9tWUePurdq
	 Gi3/r/ZQpCBVw1fmCimnghSkyAFlj3naNIzjhaSRKBwVgh4A/pBAO4XVYVq14eVpWz
	 u4UhQqelINTAg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tVTF0-000000008IY-0FOq;
	Wed, 08 Jan 2025 11:24:46 +0100
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giuseppe Corbelli <giuseppe.corbelli@antaresvision.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: cp210x: add Phoenix Contact UPS Device
Date: Wed,  8 Jan 2025 11:24:36 +0100
Message-ID: <20250108102436.31884-1-johan@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Phoenix Contact sells UPS Quint devices [1] with a custom datacable [2]
that embeds a Silicon Labs converter:

Bus 001 Device 003: ID 1b93:1013 Silicon Labs Phoenix Contact UPS Device
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x1b93
  idProduct          0x1013
  bcdDevice            1.00
  iManufacturer           1 Silicon Labs
  iProduct                2 Phoenix Contact UPS Device
  iSerial                 3 <redacted>
  bNumConfigurations	 1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0020
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              2 Phoenix Contact UPS Device
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0

[1] https://www.phoenixcontact.com/en-pc/products/power-supply-unit-quint-ps-1ac-24dc-10-2866763
[2] https://www.phoenixcontact.com/en-il/products/data-cable-preassembled-ifs-usb-datacable-2320500

Reported-by: Giuseppe Corbelli <giuseppe.corbelli@antaresvision.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index c24101f0a07a..9960ac2b10b7 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -223,6 +223,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x19CF, 0x3000) }, /* Parrot NMEA GPS Flight Recorder */
 	{ USB_DEVICE(0x1ADB, 0x0001) }, /* Schweitzer Engineering C662 Cable */
 	{ USB_DEVICE(0x1B1C, 0x1C00) }, /* Corsair USB Dongle */
+	{ USB_DEVICE(0x1B93, 0x1013) }, /* Phoenix Contact UPS Device */
 	{ USB_DEVICE(0x1BA4, 0x0002) },	/* Silicon Labs 358x factory default */
 	{ USB_DEVICE(0x1BE3, 0x07A6) }, /* WAGO 750-923 USB Service Cable */
 	{ USB_DEVICE(0x1D6F, 0x0010) }, /* Seluxit ApS RF Dongle */
-- 
2.45.2


