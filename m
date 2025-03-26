Return-Path: <stable+bounces-126721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D7A719D8
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC9C3A72C0
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4B1145B27;
	Wed, 26 Mar 2025 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="RKLkZEej"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEFA48
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001461; cv=none; b=izxVgshGRn7dPCnLrXR81YqmmTDjf/6eSaDl+EtCiQMZwYSYkVd4cTPRYtcJjkFZqJhEZG/wrZC4MI/XPxRT3TYB9gFjuNxos+6j1wMxFy5Vprir6qtOaICa2VVaeahQsZG9KpOqeWupevTh8UAjhIuZNiuxNLbxCzbrOYbg+0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001461; c=relaxed/simple;
	bh=A5yVXn+2BpLlQU4WF4JO9d8eH+g6APYRAyi+0ywCnZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua598V0kkH97OhVsQW7nccM8pzejwF8dhfATtQ/8EkYrPfNXor9IF8CAlJ/vFeaIaXk9w05yp5dVx4KOgqYvbgMGh+o5iaPX6xQ9CIuYMrudBZ4OZbkwHTyrnRBxospfmQL1Ol3ghGlHjMPykSmJzpODKhS5LdbEdfP/RIRw7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com; spf=pass smtp.mailfrom=thaumatec.com; dkim=pass (2048-bit key) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b=RKLkZEej; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thaumatec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thaumatec.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so12258903a12.1
        for <stable@vger.kernel.org>; Wed, 26 Mar 2025 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1743001456; x=1743606256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icqeCp4Xakf4b3hI2qfTozWzNzx+CKRf5kL0Tf+xrZs=;
        b=RKLkZEejynFYIHzZVme7t45pViXBB2M0s4BhlTxuviIHXpYfPw6GoMVjma0Z0o0cTq
         47IrD5HKOl+FjssHpb/jphpD8YATCd2D29CW7D4zpxqN4OBZ0AkQoVFyTiwrKlFSAFh9
         RhfcCF1vIm33VSFXENBDfN4n17jVYGuVX+L3QQtvHFISDfBCS2vwY23PXun7I6W5V2JN
         L+zO4lVRajBtzJI8UHe3trOfpAJS9bHgPwtrFDtM676KK+Rul25oTtBoZJWBT9A4x5H8
         KQKdntb+8JYZRQ8GTY1BnCrMo4QnS/kjbjxLSUup1sTf74GyceddRvnx6+bnrzpwAH3K
         u91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001456; x=1743606256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icqeCp4Xakf4b3hI2qfTozWzNzx+CKRf5kL0Tf+xrZs=;
        b=q0n/pBg0g6L5xzdabIOrmvQxhM/waQTXVDGKhbABzg3j7lhFpYk55gBII0xDsjwSmM
         0Xs+BL4c7RY2R6sfKhKvabhfdVpvGaO9qwMqPGao5BkoPz9LQEBKs8IXqB1DjCtyktQw
         /wzJ6BV5GQnDGd3odV6zzvUVBsrpfg0CEUYo8352SFcc4TyqVm1mav80vnGBpMpPfakU
         nnVOi3TwY64iw5yx0OZRCSYy+Vz8b9liRAyoSTzHC5/yE3NSV/O6YVqQGrY41YeLUquX
         BIRSR0QVphhsalXR05cBWsijZPEJZ7Gt43pWBTBTf3iu78dfYcsUGMoaasMZtuHuJkuy
         1t7A==
X-Gm-Message-State: AOJu0Ywc34pLyoeVnAXHuY+3WTgGZ7teZz1p8BQdQD3qJasC5FRbRVLB
	USbMgDDjXfQe28DdKkz1hviC2S6Hxvy1YqprK8FbCsBuT/o9sS/1TaGGCHqOMC0=
X-Gm-Gg: ASbGncu8dKCkS/fQjrntfxda1jZmOE/rUa4YKaYA7PCVd6y1za0nzDL0yBLNmrMRne4
	nOe5WlV8+oVvzHwNKPBL6q391/IsQk+C8BORMdZpV5eRnz/DuVjWFQYGhITCIxNQFbYESXOiN0H
	uWAsAtvPv2YU4d75U97IYTKkrfOR0SZ//vsaVJu8tdabe0neWCIvc1c/jXJG4Fhe7pHDuRAXDTG
	cIbrNeJM/oPW0XklRQL/34HmchDNy1vBfHrukxSArHBXJG4119CgEW56ewxhMT/aivjHbz5R4mF
	9PmgH+xYOpnbPi5J4aktS1+ZUYnNOP/Dpkw9qLyDR6BHuoxEV3C6onCduGaGf3TQXg==
X-Google-Smtp-Source: AGHT+IE5Yt6HtyVyJ3JLSqBJ51ji5+hS34zF9v2hFXAS5z2uesJvSFZ2wDzWnH61TV08hW4QBib+5A==
X-Received: by 2002:a05:6402:2816:b0:5e5:b572:a6d6 with SMTP id 4fb4d7f45d1cf-5ebcd4284b7mr19490946a12.10.1743001456396;
        Wed, 26 Mar 2025 08:04:16 -0700 (PDT)
Received: from lukasz-UX410UAK.. ([91.90.172.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0dfb33sm9489219a12.68.2025.03.26.08.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:04:16 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: lukasz.czechowski@thaumatec.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/5] usb: misc: onboard_usb_dev: fix support for Cypress HX3 hubs
Date: Wed, 26 Mar 2025 16:03:14 +0100
Message-ID: <20250326150318.65415-2-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326150318.65415-1-lukasz.czechowski@thaumatec.com>
References: <20250326150318.65415-1-lukasz.czechowski@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


