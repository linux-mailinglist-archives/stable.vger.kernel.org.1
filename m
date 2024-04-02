Return-Path: <stable+bounces-35550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AE7894CB2
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 09:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD7A41F223CC
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C743B295;
	Tue,  2 Apr 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoQBjMRE"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534639AD5;
	Tue,  2 Apr 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043307; cv=none; b=cjEwywfoHi3ft8Nf6Ha9GOsacMjvrCC0NM9Op5NKg7w9zO7S9zGKL9Ha0xqfKzP16vndLprlmJ3a5jXuAVEFj1MhS1mXxWYyL93yhMGFVqi3clhC7jNYtAbjKhW4zkGAobOW7AGoL6ec2CHNRwtC2NlwlleJCwx1t1HZxNtZwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043307; c=relaxed/simple;
	bh=13f1vZXQHVq4J8AmiMAuubtiIHKKSYIGdDHBjVBzyes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cuk2Ht1ZBuduYjQdpDvKxSlL3e7JP5wXsDqZF66ne9bmnd2dONauw9awvzyKCYDeozdAg00q4wz9eBedwPJ+gA3GzQSgX8LT9CDWj8HC5QZ1ik4LT+pBb/14gpKhh4aXm2zYyp4UqXlc2gmu1WAv9J80igBbbMA9jeVK1bRU3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoQBjMRE; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-3c4e99e7fa9so183041b6e.0;
        Tue, 02 Apr 2024 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712043304; x=1712648104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXRteeqp249vsJd2xu5LjSl3FeQmBLsla/5iDTkWRgQ=;
        b=NoQBjMRE6GXORH457fMxlE9i+ACbahWZJcNRbzllpPD0QEYb8/Zh7XVRkEUuhEKY/D
         uNn1e5T9HNj63+Cuehf9qpHpXOfFn1A2X84Gdvxd+kKjJbn53xUxttbeNTBk57stApAt
         j3/oHV8VWCArOduMVq/fOUWhxWFNzxWJOgLMqgYlMkS8C8r+Mj43kC2QR78P6bO9wVxQ
         Z6iPc2l6D1tTufqFqH7GnxBDHvgSoTMrJPGwhKZuGiK3f4mWbnkdzeHYWio9dLU0WYyE
         kP2FzRq1HCBdgnUjBj4EyN5W0U5MDHxPnskLmAm8JTgb01BvOr88GhbBlqTm3Qk6C+PB
         AsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712043304; x=1712648104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXRteeqp249vsJd2xu5LjSl3FeQmBLsla/5iDTkWRgQ=;
        b=WBjJuIXL+ssph7dpnm0RH3WgFAVmBEVnM5BQckLecCWPbx479NtzEeNuBJQqIA0crR
         VPDKEAZGiC+03eBtHlw9I/ppFEEwGnnkLqPU1MeNBRToSdnqRvFz0PHjJ0W8lVWxCq65
         FFpwUUcXGDftdGj+L5yKgWqznyinW9O2kozo9WrNlUcrCnFpXLPyZLrjtHj6umBDVrjM
         DlGTAL0VCf57tWweOJ/s6On29PrMGjg1JrUDg8hmD2kGC/+GC8TVQH2ivtG8y8gRTDGQ
         3LsF4OvX9t3fnIJqSYATzxpQf1cZ/jTmqDW2JzuZlxAqABVsMdYGBh2Zkap5RypZlsFe
         sqlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMmJVI7jKxcD0TE7TWBdAr9mNp+x+xplzC2fEA+xkhBeh3GJ9XlPWS0aAJHtIbdQaUz31cjCbVR16qLJwVYTH14hxEKHg1
X-Gm-Message-State: AOJu0Yy3tV13t/tpjfuHVRrNtv19J6jaitAmc5P35NLsgdPsjMknXNh8
	BJFxmkSQZHWa3xETgLWnxCnkHdlYZHVyFVo1ErB5WaPMPYcQgQCIqlFm0EIAJIbxPR7qJPaLfA=
	=
X-Google-Smtp-Source: AGHT+IEreF5XyZ7JEK/4g3eL1zkgouL5q1wF7+6YBNBAxr0pHRvw+bxDlZPvFxhK0FqSCxMRVihIFw==
X-Received: by 2002:a05:6870:790f:b0:229:ffdf:f929 with SMTP id hg15-20020a056870790f00b00229ffdff929mr5728801oab.10.1712043304517;
        Tue, 02 Apr 2024 00:35:04 -0700 (PDT)
Received: from localhost.localdomain ([2604:abc0:1234:22::2])
        by smtp.gmail.com with ESMTPSA id ld5-20020a0568702b0500b0022e69a4cc30sm367608oab.18.2024.04.02.00.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:35:04 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] USB: serial: option: add Lonsung U8300/U9300 product Update the USB serial option driver to support Longsung U8300/U9300.
Date: Tue,  2 Apr 2024 00:34:51 -0700
Message-Id: <20240402073451.1751984-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ID 1c9e:9b05 OMEGA TECHNOLOGY (U8300)
ID 1c9e:9b3c OMEGA TECHNOLOGY (U9300)

U8300
 /: Bus
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=option, 480M (Debug)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
        ID 1c9e:9b05 OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 5, Class=Vendor Specific Class, Driver=, 480M (ADB)
        ID 1c9e:9b05 OMEGA TECHNOLOGY

U9300
 /: Bus
    |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=, 480M (ADB)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 1, Class=Vendor Specific Class, Driver=option, 480M (Modem / AT)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 2, Class=Vendor Specific Class, Driver=option, 480M (AT)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 3, Class=Vendor Specific Class, Driver=option, 480M (AT / Pipe / PPP)
        ID 1c9e:9b3c OMEGA TECHNOLOGY
    |__ Port 1: Dev 3, If 4, Class=Vendor Specific Class, Driver=qmi_wwan, 480M (NDIS / GobiNet / QMI WWAN)
        ID 1c9e:9b3c OMEGA TECHNOLOGY

Tested successfully using Modem Manager on U9300.
Tested successfully AT commands using If=1, If=2 and If=3 on U9300.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/serial/option.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 55a65d941ccb..27a116901459 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -412,6 +412,10 @@ static void option_instat_callback(struct urb *urb);
  */
 #define LONGCHEER_VENDOR_ID			0x1c9e
 
+/* Longsung products */
+#define LONGSUNG_U8300_PRODUCT_ID		0x9b05
+#define LONGSUNG_U9300_PRODUCT_ID		0x9b3c
+
 /* 4G Systems products */
 /* This one was sold as the VW and Skoda "Carstick LTE" */
 #define FOUR_G_SYSTEMS_PRODUCT_CARSTICK_LTE	0x7605
@@ -2054,6 +2058,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, ZOOM_PRODUCT_4597) },
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, IBALL_3_5G_CONNECT) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U8300_PRODUCT_ID),
+	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE(LONGCHEER_VENDOR_ID, LONGSUNG_U9300_PRODUCT_ID),
+	  .driver_info = RSVD(0) | RSVD(4) },
 	{ USB_DEVICE(HAIER_VENDOR_ID, HAIER_PRODUCT_CE100) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(HAIER_VENDOR_ID, HAIER_PRODUCT_CE81B, 0xff, 0xff, 0xff) },
 	/* Pirelli  */
-- 
2.39.2


