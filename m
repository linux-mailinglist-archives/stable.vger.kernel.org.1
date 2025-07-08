Return-Path: <stable+bounces-160482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65620AFC9F7
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7756B3A373A
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CA82DAFA9;
	Tue,  8 Jul 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dX3v5MoZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE82DA765;
	Tue,  8 Jul 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976012; cv=none; b=P94zsf1uU/z52lfeI3hMIHs2gm9w6+k8ng7r6KuHCLHpc9PUGMKXnNUYeezYavqi6AK2ecbaGUcBPBjsTvOq707kQgIBFwwKueHXX2z5xNW2Ecuq/pDuToHaFal44Tb+hvLBli0PjHt2MKXeJDyf+aZydUuIu92JNw5hLApMYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976012; c=relaxed/simple;
	bh=QPJCaLQJf1iha7lvTJG//NOH9KBEpUbUuwYO1zoRVwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3PSKQv068oAnknn8yuV5nJggCCUeI9HA5li5VLnW5m71TjE/4efVmFcgzz4+RGh3M+DyknxkqTUV8VHLtT1CmHJHsmQSmoc5bcookynPTAUggqYpJoLdzabERk9XdLJyLHl0kc9Z1KAu2bjdrl2gsxKYFm9qi0QGjAjrOwQIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dX3v5MoZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4537deebb01so24544885e9.0;
        Tue, 08 Jul 2025 05:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751976009; x=1752580809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CagQEKzNagLiMSLXYiG7JOcqhJ9gjYM34q2nHraGiZQ=;
        b=dX3v5MoZ8Os0EZ0OqBbj4/W1IJXGcbrWHbFm6cYrusCWiVfzwE1BDoo2vlnzd7vXG3
         bhd8KvoW8B6EOu7ER/2vmzouL6OVYmAFti8E2BOMZhAPAHtpF+fgDc9iOMr9NKXGf3Hc
         U+rjuYAOsC3FMQNlWcWeFifZdwljq7ehiVP276Ab5pxjDUjV0M/kPT1SayGsCxZ8sxpf
         9oKZfiwV/TCvksgsGvyr9VelEebF5j73d+4ustPA1uHWAK8QRD58IeHcCwKSVzpATdAR
         KUBrlSHsi8GgdZgK6QEbN7L/br4V6Fy6V10uAiqKjhjJs5MSDePNGBanU+2TSEQ65I0m
         LBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751976009; x=1752580809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CagQEKzNagLiMSLXYiG7JOcqhJ9gjYM34q2nHraGiZQ=;
        b=xHI8KIuAXPTkZ3KBHv5t6yV3RH7hnSvL0sUFrWAzZETmKcHAp962lCFdxmicVSybLV
         KEEt4dH7BdHIyD17WAaYmXL3/ONvbiyjdAF29YUWET/6TaMZJtKlpD93vbDjMHYEi+lT
         pkFN9Gr2lWXnUSFyBXZl0YYOIsZEV6OkymeLzg5lAAaAOzbSuVhEJ7mtNavipIkGyFtw
         DCjaYt7FbcDlchIq8C2PK0zbJRaAam0xfYeY4DKn+Ew9neZ59Za0QEqNFiCeQsCURMGH
         QqfsfKIKcxVEGNuzV+0Fa2XmOPQeGTTjLDK+8GF5TEmCdf6muzKPF+DusUlSl6KCphwG
         UM5A==
X-Forwarded-Encrypted: i=1; AJvYcCW3dc6ixbqr/D8/1fRMSi+KzW8eY0z1qfGU1njbzxc6rxOVtNPjpIhMaSv0Io7Q54NnJhcBO1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZi+ctLvvl2uhqMz6FBrUigaa6g675JIZ4g3i5afIb1GcBJVcz
	lRGadZ1d+Mc5iGmc8sH7o57/5beT4GHsOZPiDOBzAOB2OzJ1JxarQoZL1dRmKmuD
X-Gm-Gg: ASbGncsjkvk8jzE4v32q051SyWTQ/64zN9CwuKWy8Ha+c0fnbj39/znfIUVhWR92pEc
	Wx3zwTrF7t8w1/3DBpzPc//lSB7NSTUIVdFk40/Hwq+Ea+94wSoHTTVXMBqeFzjMHetIMUHm607
	D2zmBlLXdWv8F2ljv+HI5L1qy4oSe0R0ClcQOkafA1JBn8TSoU6oKxfRY8IrtFbphNOhjmHvZYm
	DY1Es9LFoZiVGCYO1KSwIpk0EMIg5gZLHQHDK4ccbV8PLzqiC8bjDt2nXBB5Fb4kZUr2nc2vhE1
	SVYMNelJoyphuGi34VNNrVcPzAcNlGg4pXHbL68MXjcDjmOI2lIjDo9Bb8sBfrZcnF35Q0CMo6p
	H96TWKcODggURZrIYcA==
X-Google-Smtp-Source: AGHT+IGcDSS8h8Dk5/qU3mNlHtBD+nj6OyPOiTRomIrnFqE0aOWkuoW1YEAdJ7CpgjT6yAxjDVGfww==
X-Received: by 2002:a05:600c:83c4:b0:453:6183:c443 with SMTP id 5b1f17b1804b1-454b4e68402mr137638865e9.5.1751976008296;
        Tue, 08 Jul 2025 05:00:08 -0700 (PDT)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285bdf8sm12650268f8f.87.2025.07.08.05.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:00:07 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition
Date: Tue,  8 Jul 2025 14:00:04 +0200
Message-ID: <20250708120004.100254-1-fabio.porcedda@gmail.com>
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
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index c0c44e594d36..58b02a09b315 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -627,6 +627,7 @@ static void option_instat_callback(struct urb *urb);
 
 /* Interface does not support modem-control requests */
 #define NCTRL(ifnum)	((BIT(ifnum) & 0xff) << 8)
+#define NCTRL_ALL	(0xff << 8)
 
 /* Interface is reserved */
 #define RSVD(ifnum)	((BIT(ifnum) & 0xff) << 0)
@@ -1415,6 +1416,9 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),	/* Telit FE910C04 (ECM) */
+	  .driver_info = NCTRL_ALL },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x30),	/* Telit FN990B (MBIM) */
 	  .driver_info = NCTRL(6) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x40) },
-- 
2.49.0


