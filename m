Return-Path: <stable+bounces-35549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B15894CAB
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 09:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9B3282EC6
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD96E3D0B3;
	Tue,  2 Apr 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwKUXKXC"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD03C471
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712043145; cv=none; b=Yo++VdUKZBzoaOhxMP0Mz9e59dbxmbnsBRjZbhkAjIdQabJtwSN57Z7RUk+7MScshq/nQQMMMIwWCsC8nM25IWI3jg1vtGpZGXrddYeZP2yQzOlXT2C1YAXKF9x0xXS2e8UI3Y6yrezX6fit7mfklpURuSLPscYvACfn3cr4EJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712043145; c=relaxed/simple;
	bh=13f1vZXQHVq4J8AmiMAuubtiIHKKSYIGdDHBjVBzyes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YTusWwvZdxzMd8AUt0tgo8hmgUAwlGOlGwdRu9gRpHNmCEjVR/zHGWocQ28B02AdGpmtTxdn7zxyiGTP4ksS+0ftAL8jPaVJ9O9Wz8oDIKARQG7hvrpWXcuK3ukg58dcJeG2ScHHnN5mHfygEXUd0nvCKpR67LjhZL9w+OTVyvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwKUXKXC; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-2282597eff5so3731100fac.3
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712043143; x=1712647943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXRteeqp249vsJd2xu5LjSl3FeQmBLsla/5iDTkWRgQ=;
        b=fwKUXKXCQ0Lz4EwQlJLZNmkfN5pMdof218xcoxbFof8ZWqy02q4GxJc9MqXxDSUzVu
         55cAxda/Im4JW1hJh3Nr46ygyAUewLfM/nySmdeFC2XOt+Nkjr4jKWwRHUQWgEi0SWc6
         zyNMbf6i69rMm6P5NH7BSWX4q/uwwu/xbe59WFyYVToDrC+hEA8Sr9ltCxRYzLx2nqjB
         rsctIm3hVABB/3HJzgKj5H4UpFRfv8amJLLC/3/7Wz/xO57vKWGJNu4pf28rEsPMn52w
         +NQSYMPaAIEGXNOeCJr64urKy2IDnMLKAM0XGPdWgUNhPuXIJrseX/4u1Wx22v0w9AzR
         4rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712043143; x=1712647943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXRteeqp249vsJd2xu5LjSl3FeQmBLsla/5iDTkWRgQ=;
        b=kmNJJ05PlzfkWrAL+DNT9EwOn6/Fs39ABlK910BvTyU6u2zyDk6/EHXb/YsB0MGtre
         wK/LX87weH8YERf/LDt6NAyV8c1tKLWwxTC9uFwrei4aoNn6skR+rX2novdA/GxviLLc
         tTI/1ucGhROFgfL0KBoIjFuzRx/zlq6yPgohuMIfrNswRr3OwoAGW1jj63IErZUkB3BN
         b6iaZ+uR/nF3wWPBdb2bqwULLAWkmxVbF7mTnPcVVUz9X/Fp98yzYcCvdNTJ5uYGI96d
         uK+qdJay7P7M+RomOs9CkZp8s7A8oAumuN0nUyaEylNKlHcVKFa35F9Bli3l5vE5AmlS
         iC6g==
X-Gm-Message-State: AOJu0YwQndwo01dkqaNi7g0XjIVRAxBMcBq80rDdbXV8k+Ce+mk2/1MK
	gqv9WWhsbLHKln28Cdgl9SEPFNpnwEzKYM+aMAlY4oucS+dvXDrvR2tf7lVWXtee8x67Cls=
X-Google-Smtp-Source: AGHT+IG0ZTIL5r4kvG0uGKr4KWkm3/ccMAgRbgPnVlUEA0juNRbp5KXzemOfI2/27FdUz3lzvtunYA==
X-Received: by 2002:a05:6871:71c3:b0:221:4fe5:87cb with SMTP id mj3-20020a05687171c300b002214fe587cbmr12995401oac.42.1712043143102;
        Tue, 02 Apr 2024 00:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2604:abc0:1234:22::2])
        by smtp.gmail.com with ESMTPSA id wx8-20020a0568707e0800b0022a66146d73sm3317842oab.15.2024.04.02.00.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:32:22 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: coiaprant@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] USB: serial: option: add Lonsung U8300/U9300 product Update the USB serial option driver to support Longsung U8300/U9300.
Date: Tue,  2 Apr 2024 00:32:18 -0700
Message-Id: <20240402073218.1749428-1-coiaprant@gmail.com>
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


