Return-Path: <stable+bounces-161558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9E3B00171
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 14:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EF53B22C9
	for <lists+stable@lfdr.de>; Thu, 10 Jul 2025 12:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3024DCF8;
	Thu, 10 Jul 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsU4qeQ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B403241C71;
	Thu, 10 Jul 2025 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752149804; cv=none; b=D2aEgYNYo+96wePCpBGGM4gJwb5MLhQ157S3aPTMrsXrksNLx/9Rc2rH4XMo8ICWJztkmUYwLP9rrT08mFNgByiBuZPRarirsDF8B20hELIqotEtGkc3RZUh1e4Bp1q5Ik3Kn2sTChntYiCSmdIJi5dasov+dM4u+xYL5f5hCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752149804; c=relaxed/simple;
	bh=OqWFd6b+X//t3ckRR51QPPBHvoZ0MhmG7lwJZhuMCA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBDXj2H8s2YANwwvhOF4XdHw3z84fMeMHuZBrG9q56sLKd2jRg0aeKOEKAyo6d3v9POXYvzjTsvvIADqeeVQIHl3jfFL9B13tmpkTaaq9fDHm/kJ2DJEcigU1yPlWTgjKxJt+mEseGLJetSj1Hvm4ZgC3CmyQNPZI/0a6JumPk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsU4qeQ3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so5226495e9.2;
        Thu, 10 Jul 2025 05:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752149801; x=1752754601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GWDOSl2rgDLjMGrT+X7lzogJYNUDzCtbNnobaivJ58M=;
        b=JsU4qeQ3r5SrWb8ljncAI+o/lIakgmr9WcOy3YtirFAa5Remmj/Gpp3yugDrMuuH7u
         fZaRXcohYEh98w//xn2Nt0jG8zX3PZjoe7QfIuPGppy0h0lxe6Rna+X+tQa2+DC8XRZj
         2/c0fp3kEeySwtWVcz8nvF2sKkGFB0vS0BmlAX0vsQ9/JSxc6mcdZhcKcMws+s8DrRoH
         uUSW8julnM+g7IY0pz5IVEBbif45OPUmtVgyHqKFMQ4ZXVHKDIwHQrPNJaCAB1RvjRC/
         o0aokOlrk2LM1dFBVL04di3spdFMuPyPUB6eb+IUYbQcctkU1q39np4lu6xhf4+u+ToY
         rlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752149801; x=1752754601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWDOSl2rgDLjMGrT+X7lzogJYNUDzCtbNnobaivJ58M=;
        b=MOIblgo/W/4ZYf4+lyvD/PP/96dKQnj1wK2cbdlOD18peqkOTuvREqtFNXTK1BB1TK
         5bCQfY12uN4AYYvWD2OmG0ih9KVAK8NLxb+zq4EnX3/KzZRWmDJnMAOAtbEJW1/mNtCO
         WJuHbuTcmDc1ayCMfiUYP8X52RGThDiJd1IkIMCRbJwAJHOvx3IjGthn8FFwihKe0H3w
         Vu5iRqo5jXhM671EXmG4FIQ4tt+3GtYH//xxjT0sKUU6kISmofm3bKfD7+c5TlVdyhmH
         Dpuzct/daAOvLg3cfSU2HQ2vrYPC2+PIwtTRAxG6K8mbYYcmiPHZMo9DfYwqConJc3Fu
         pueg==
X-Forwarded-Encrypted: i=1; AJvYcCU9fOWiEA1HvJXdDnk6h+vIfQa6dQwi6oJ4d61OxOSIEZhEK2GHTFP6bpxFL+NkuCHXozzdG08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBFubPO9ghsiVBr5gnxVAJldPbSSFXEemI9y8ddtE+hLT5NOA
	lWPs751bom+yOVYyObuAwyAhVRaZq/7+tkE46c2OOhoI1pMmZ+YYcLWf
X-Gm-Gg: ASbGncsq25m0p7o/x+5EPp8tfXUTOPp8omS+DOucWgrJmC04MRrMWPXyDJd0P+ml0Mu
	8SfUZ1zQk/LLjttH6BInsnT5nkvGkNiplm59Cf7a9J2RCqGbajBABov12NKoBelT8RjI0w0/4+f
	E/dUgqgNhTG/bYAF0rAxnO7JN0T0HrDDMGclokSn3g+KrvYmvGUhGAKEofDThb9DiSX7yXf7j9O
	O5yZtCV1M/CAi82Lg+KnEHPIAoYaeLTfC1FOZoO7jdidr5kkPeGsS0Slg7klNV625L+LBHfmxRI
	cYhk7lI/yyjelX4JP93N5LHLcpQVVD0GyrD4DuzasksbKrvXmQjFizk5fL4EXL98Lq3qUigvqTJ
	6REfX/Bp5avCJa79V7A==
X-Google-Smtp-Source: AGHT+IE9mYJ2LnB0l2FATaftyTwmgn1hBsc6d5VSOoLvQl2bva29E/6NYmizZe3vvHbRXutWCCa6SA==
X-Received: by 2002:a05:6000:2891:b0:3a3:6e62:d8e8 with SMTP id ffacd0b85a97d-3b5e454564emr6393582f8f.55.1752149800632;
        Thu, 10 Jul 2025 05:16:40 -0700 (PDT)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc217esm1691301f8f.28.2025.07.10.05.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 05:16:39 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition
Date: Thu, 10 Jul 2025 14:16:38 +0200
Message-ID: <20250710121638.121574-1-fabio.porcedda@gmail.com>
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
v3:
* Add missing change history

v2:
* https://lore.kernel.org/linux-usb/20250710115952.120835-1-fabio.porcedda@gmail.com/
* NCTRL_ALL -> NCTRL(4)

v1:
* https://lore.kernel.org/linux-usb/20250708120004.100254-1-fabio.porcedda@gmail.com/

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


