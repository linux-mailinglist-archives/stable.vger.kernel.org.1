Return-Path: <stable+bounces-126756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85194A71BBD
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4BB177D37
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6851F7569;
	Wed, 26 Mar 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="RRRbODCm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A91F5612
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006233; cv=none; b=Iaf3HAhy8u9hgqNqI29aDK4STZOdgd3Qp4Ge9Y3DcgjHbAFbSw9xJwVnkIKCXXxIKIrPlz3xifFuuR0iLhmyu48wxQWv9RnkVtPcwNjk7Jg1MruaeJlKfQ308wDzH6C8DiGr7NXVOn0IA9rFxPhx1HrnLqcJiHhMb1iKa/8ltAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006233; c=relaxed/simple;
	bh=PeEgCfBvUgiOjdlm8XMEYe+at2eqiLHn8dkuleqfmAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwzBupPZxT+2QxXjjK9V8YqVGlL0JtVC0Z2VdIA1MaI9WbFJQtSApClbhf2mEc2mwzCt+qyhTsohCLwmx/hUYD+h/2q5wDq9qaJhBz23oXAFmrp9ZlOGOSDpAqf8QF5vuNJoUWZc0z69tI0rVhqdW7FRdRgRORjuFOI8emCBI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=RRRbODCm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso1057515766b.1
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1743006230; x=1743611030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9tCKOxWlZzVo+LW0OfZaKnD5ARH/KKbqzp36dlNLJM=;
        b=RRRbODCm2LHcPlpkQaQqOc/Puj2Or9Bj5XdulAevFh0ud/qukCO75P+4YPpZJbn/iq
         9SkpVndWh1PAh9YPIgLEhHoDRyv8QSUYPwNRFiAHqyGir6030Qa9kLCOBO0ZBrg4rwlx
         KYVucIlPZVexwY0o6PiBpke4W+MECeWkDvY+NabYNdiAInVxlJXL3nlthuMEdEtV3OP0
         PwmhUSDCVi9QlAy8jdomeOgzfvJ3ZgGJ4W5OLld0lNjsPmn+MniJO56pVB0jlA0IYSVz
         LsBg7gc3cVZ/i0PpBk6DSwmsBHOy/0pZ8U4Dh5woYvDnihRIvWP1g57FJQ0vJtbpLdCJ
         iyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743006230; x=1743611030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9tCKOxWlZzVo+LW0OfZaKnD5ARH/KKbqzp36dlNLJM=;
        b=AenLWV8miaaRAVPVpHjMHe4sGHXMEM0V8enyZFapOvKYYJFec1yP1eCjyLbUSjKiEU
         mEsp0iLCIqGPI+yXJ8DyXmw6/ruagd17Jajze/th0Gd2uMtcwXi+5c2VcCyCpAeEDgGx
         G9L8KisQp9zmh4LIapcL4fGmcn9PsSNSkOqX0mBPwj7+Azj7EccitGnD+MjD8qo6QOKi
         CoaI+ey6wQu9kVld0QpfXQhsBL3l2OLE/VuMG+iaZazteroYuML/IQy3l2IfOekk+xJr
         CIIfA0WbkE6B/6x/FM1GUe0Zc74/qjnXop3EQ/WvdqIWLsLx6cXMIBUtDwQ6J+vHiNmO
         v/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUSleLDS+2mJoTG58z2dHUkTuRHxDoZ+FILdgFrQ9k1PCYH4/aG/saLv+8TieKBD9Gu4/5PSFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvWGnySb8J1xTofG7CiohUvePUbyGg3naK+BpGsugO+3olqYpo
	ZQT/S+ytPccERqIlf6c9f4XS/ActhjNNSiOF4JScALB07peqE75WeCtofg1N+o8=
X-Gm-Gg: ASbGncsjKOTU0GvmSrNIMFBbGgX1Ay/DMGTm/DcHSUG45wBn1ocEx3//UwhNGTuqKdC
	5cvBg3PddlAVqqsXH5w6RGAEy5mYoYs7m1AB4dzebBnPuE7UvaWxQYZ8GJjQx+w3TAjPSSqK8YZ
	iyYJazO8J54LJRr+YdLJb+L67RReMSyOdMPBc4wKFaUSbTo9aIXtLUQEFzmoSdcr75UxKaTaFPJ
	xbFckjGTyu9xFTmvX8BW9HN23v2KmdVp2a2YFePd5q6DZOlI0wgwjGf8589dEOPbsTLZWeKrIeL
	YZULLbl1Y7328a/vgGKH1OOKkCUYx6jwDpk7fiPXr8FiMoXBU4zFMRnHbQ==
X-Google-Smtp-Source: AGHT+IFR7MKgek1aYBM8pLPyUk2XklCCGA9XeiQoGfN17QwCt+mtrdcAqb3TA1eUWqsMBXRD9Qv/5A==
X-Received: by 2002:a17:906:794a:b0:ac2:dfcf:3e09 with SMTP id a640c23a62f3a-ac6fb100848mr1832966b.43.1743006230250;
        Wed, 26 Mar 2025 09:23:50 -0700 (PDT)
Received: from [127.0.1.1] ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6f0f498ecsm76678866b.135.2025.03.26.09.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:23:50 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Wed, 26 Mar 2025 17:22:56 +0100
Subject: [PATCH 1/5] usb: misc: onboard_usb_dev: fix support for Cypress
 HX3 hubs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-onboard_usb_dev-v1-1-a4b0a5d1b32c@thaumatec.com>
References: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
In-Reply-To: <20250326-onboard_usb_dev-v1-0-a4b0a5d1b32c@thaumatec.com>
To: Matthias Kaehlcke <mka@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 quentin.schulz@cherry.de, stable@vger.kernel.org
X-Mailer: b4 0.13.0

The Cypress HX3 USB3.0 hubs use different PID values depending
on the product variant. The comment in compatibles table is
misleading, as the currently used PIDs (0x6504 and 0x6506 for
USB 3.0 and USB 2.0, respectively) are defaults for the CYUSB331x,
while CYUSB330x and CYUSB332x variants use different values.
Based on the datasheet [1], update the compatible usb devices table
to handle different types of the hub.
The change also includes vendor mode PIDs, which are used by the
hub in I2C Master boot mode, if connected EEPROM contains invalid
signature or is blank. This allows to correctly boot the hub even
if the EEPROM will have broken content.
Number of vcc supplies and timing requirements are the same for all
HX variants, so reuse existing onboard_hub_pdata.

[1] https://www.infineon.com/dgdl/Infineon-HX3_USB_3_0_Hub_Consumer_Industrial-DataSheet-v22_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ecb53f644b8
    Table 9. PID Values

Fixes: b43cd82a1a40 ("usb: misc: onboard-hub: add support for Cypress HX3 USB 3.0 family")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 drivers/usb/misc/onboard_usb_dev.c | 10 ++++++++--
 drivers/usb/misc/onboard_usb_dev.h |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
index 75ac3c6aa92d..f5372dfa241a 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -569,8 +569,14 @@ static void onboard_dev_usbdev_disconnect(struct usb_device *udev)
 }
 
 static const struct usb_device_id onboard_dev_id_table[] = {
-	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 HUB */
-	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6500) }, /* CYUSB330x 3.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6502) }, /* CYUSB330x 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6503) }, /* CYUSB33{0,1}x 2.0 HUB, Vendor Mode */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB331x 3.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB331x 2.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6507) }, /* CYUSB332x 2.0 HUB, Vendor Mode */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6508) }, /* CYUSB332x 3.0 HUB */
+	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x650a) }, /* CYUSB332x 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6570) }, /* CY7C6563x 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 HUB */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 HUB */
diff --git a/drivers/usb/misc/onboard_usb_dev.h b/drivers/usb/misc/onboard_usb_dev.h
index 317b3eb99c02..17696f7c5e43 100644
--- a/drivers/usb/misc/onboard_usb_dev.h
+++ b/drivers/usb/misc/onboard_usb_dev.h
@@ -104,8 +104,14 @@ static const struct of_device_id onboard_dev_match[] = {
 	{ .compatible = "usb451,8027", .data = &ti_tusb8020b_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
+	{ .compatible = "usb4b4,6500", .data = &cypress_hx3_data, },
+	{ .compatible = "usb4b4,6502", .data = &cypress_hx3_data, },
+	{ .compatible = "usb4b4,6503", .data = &cypress_hx3_data, },
 	{ .compatible = "usb4b4,6504", .data = &cypress_hx3_data, },
 	{ .compatible = "usb4b4,6506", .data = &cypress_hx3_data, },
+	{ .compatible = "usb4b4,6507", .data = &cypress_hx3_data, },
+	{ .compatible = "usb4b4,6508", .data = &cypress_hx3_data, },
+	{ .compatible = "usb4b4,650a", .data = &cypress_hx3_data, },
 	{ .compatible = "usb4b4,6570", .data = &cypress_hx2vl_data, },
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
 	{ .compatible = "usb5e3,610", .data = &genesys_gl852g_data, },

-- 
2.43.0


