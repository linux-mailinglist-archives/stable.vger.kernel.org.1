Return-Path: <stable+bounces-161556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEFEB0011A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD2958556A
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2512E7188;
	Thu, 10 Jul 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZn6aZnN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB402E7181;
	Thu, 10 Jul 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148798; cv=none; b=dW7RrGcGoBtJ6OnjJ0rWqWtDevMaLU/5oLVF3M4IzphtgO6OnYXcFbu+ATaMTJ2A8UuSbfz+2hKtshf8ZjnRHHihsfCCXPuvxrJkCzlPWA3M9wGK/E2wgdcxshM2Cm4K+uQ/z2zWZiMCoObiD4LGEqVZyeZGkFz/6VRHCWUwo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148798; c=relaxed/simple;
	bh=jXgTXfo+uXd5q4IP5mrlpnmxcuJvDPPfB1qgwUAdklE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhjCPcjKjGi+nz4laPMIeEQJEwX9JJ9+ktDEvJCXOvPcFDVIauF9VMM3CVVGFiznBvCuqHBsH/Pb0dLb8PRAlRky4FaPzty6FRL5M7xdZxUrbS51nCfOE26ZDo0GuxpbAdvBvWHGk9R9Z+0ZO+3RG+yTbsT+s3DcdgVEuZ4Yju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZn6aZnN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso7258745e9.2;
        Thu, 10 Jul 2025 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752148795; x=1752753595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0n7RtejPAKXAWkJE8W7I9jwI9tyMXDcMSzReQXSM8o=;
        b=PZn6aZnN8uqMQPRIeuewQEni1COQhJC5wF8sgJJelJYvUEKu04n4udMvSW5uFoI5Z8
         M8etf1PPBH+77A1QwDNaMeOBOT+UPSgoTpNEz8TO22TcaLrVwW1IB5KZW5tuRMM0lkYm
         /ZnpmZJb2xrAxcSXMKR0JmDvUN+Eh+VQkA43Ms1vxu5XfJH1jdiZoF5n+vsJoeudt3+p
         ktHeYEXnEYCXaeiQS/rKMRnsdUabkBSm8E6f+8TY2q+Qk3B9ORA7zEFnsD/SCKEdgM35
         hKv3tZsunJKzicBMOiworAeboYSjxnpobLEgZTsw7jIfiUt/L4yOEtlzzEBj3ywoluVp
         3+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752148795; x=1752753595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0n7RtejPAKXAWkJE8W7I9jwI9tyMXDcMSzReQXSM8o=;
        b=IhxonEdzcFhGQLh4aseUkze0TigV/bkNy9N3uds4xzBMxUsPRrnjXN3M/DnQ6rx3sH
         izqCuN7nJMhWfaPIk/LzCLouhXpAFC3ro3DL8W2D4nsFT+IQGOG8Hnmk94nkcSbfxmFf
         /tkuERDmjLyBJ20rZD+5AG9gCyTQMhgbK5DU+Nwlo7EYrJbw5uOSSGsX1UiS6aeAyNs9
         +eLfsy+8ndhQwdzwoQdLZ6ErXnt0Cl5Xg2z+LsE4U4ROnH2qEXhIV5l/vdOaqSDLGWy+
         QfLpXzvJwRkG6C9r6MQBOn12e82SQZR/hbO3rQmhV9S+79kob83HTZnnaiyJKbSmPWI5
         d8OA==
X-Forwarded-Encrypted: i=1; AJvYcCWSIuXjxGSkl4S0AsQ3gCuFRQFzbFSXJrX6t2DiESESqDrlql/Oa5NPhwMceYnnEoOhxO/LHfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDTKVhFjZS/dOTAvhfDtnn79qjrw5ZybPo6K4r9nMe0hUDbFg
	UoPQdbGxW86ASKyLgQQKUfV/0i1tPNLLdi9wOWFoCsW3YNGzkiV3NveZ
X-Gm-Gg: ASbGncuQJCkB3NEJZVdrv7an7F7fFPYWaQCMuoHclwdQx+oLZ294o4HeZTJ9uWDOFMr
	igOjKCwwaOwRrdsm0LDkWxY7Y/OIK7rferwBFh0DJ2kKVmwNRvgqZHQrpr+4damOJCK3tiirIh2
	I845WcAOYm6C2jLMHDjnd/tWNb+m2Qp/dfE2jO8js1Sw61Tp1NEIEBK2xKFFXy3Aif2vnIweK51
	A2BDg8FJqaQoq6mflX/LzCjcWjrMdSY1Ybp6C1XplJUOMUB5RgCW4xXVhZ8hcWHBT7S0Xpfcvj4
	AYNbS9tRmajsyOv0qShgnR9YfKwzQ5lQFohnqyIKRnCnWO998aiS2c4wICojb3GtRDjBDVfDs4u
	rGdJFYfoVKYausmS47w==
X-Google-Smtp-Source: AGHT+IGJo+O+tFjGOpuJ/+h4bV4Afs8uqms69IMZb6bS1XV0YURMaTJPiyx/YwXhJ5omi6nJX7tqTA==
X-Received: by 2002:a05:600c:870c:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-454db887938mr38057695e9.29.1752148794807;
        Thu, 10 Jul 2025 04:59:54 -0700 (PDT)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd436ac4sm18016695e9.4.2025.07.10.04.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:59:54 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition
Date: Thu, 10 Jul 2025 13:59:52 +0200
Message-ID: <20250710115952.120835-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Telit Cinterion FE910C04 (ECM) composition:
0x10c7: ECM + tty (AT) + tty (AT) + tty (diag)

usb-devices output:
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  7 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10c7 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE910
S:  SerialNumber=f71b8b32
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c0c44e594d36..147ca50c94be 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1415,6 +1415,9 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),	/* Telit FE910C04 (ECM) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x30),	/* Telit FN990B (MBIM) */
 	  .driver_info = NCTRL(6) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x40) },
-- 
2.49.0


