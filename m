Return-Path: <stable+bounces-166840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EBBB1E94E
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 15:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81E064E44E4
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 13:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873727E052;
	Fri,  8 Aug 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2tH2CLN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B827C84B;
	Fri,  8 Aug 2025 13:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659875; cv=none; b=QC5yhVGQUFqT37gPXV9KbOa5Zd3CTgqCyOxQsgY3yHyD2HZh6YqEMPmwf8c9m6CdUJxERFQU6UoPm09il6QdmNMobnUAzF2+zgV6+pKzguJ4gZ2xYViSbHEFlJerF8eT2pbHxireGP7/TkGMXE4vzj+/8G/2xFuwtVuhSaMUjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659875; c=relaxed/simple;
	bh=yhbAlk+bUXw3QlfndteOlJmEcqsQkv8FdfP4A42o/bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvwQ4KTmY37xr6vOhcRzB550OOpDlFYZvkoUAwoh9IDdryQ5KcC6ZEhAxcdK5IZbc8gFnE4Ffn4CCytmA6HRs3ty0vhaLvs2YF0YfucgLwjvB9I1yIVZdUAt3+7nQHkGNVQmQA+z2SG0Ils2l3aAfp8a0tXR9IjyezaxFHFFx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2tH2CLN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-458baf449cbso20330395e9.0;
        Fri, 08 Aug 2025 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754659872; x=1755264672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lp7uMaLHngRmnBy7KRF1MYjSNQthIEfOIUeVdVc23oY=;
        b=N2tH2CLN8HRFXaLRvF+bOlln48UkG4W4YIMsfO9D5nJ+zu/PZTc54JCmk66zGtMwbj
         YX8F1qpzEm2V+aDeu1rEipQCuvG2cXELe1a2YxGZrNPYNj6pc5fb8hsIPkZZvNnCcD1W
         LtSlrc3Qr1G1PdM+mNc6LZlQ4bvU1O/1sbFc+mUmWJOkNMmT4/i+o6hWA63r0a2gG0NV
         lFf7imIdodpRnaTHsYKZbef6Exq70VUlkGtajHUY8wf+ExaZFq3ozfcmz86Z/1AeMK1P
         PSnOG9z9yebxaZ8IEk236SIZ5Dk4h+xurQl58WeqO3/SzTbwikALFXjTv4/4caPmcAu7
         rsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754659872; x=1755264672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp7uMaLHngRmnBy7KRF1MYjSNQthIEfOIUeVdVc23oY=;
        b=bqOlk8EitnzLyV9wN8FhikZZal/xX97ZBU5Uf94tTyNnFcwPrP6gwL4nqaluMzurcX
         taJh4xSeZ9FkK9fc6HASA9tFO2AJgHDsVxkEecG7BSL4naJGLuKFJZE+dDkYXFRGtRRw
         bM7RmyJFm7UK7MOQ7H3+XgsgJruPX/lKm7veA+LY0e22o2ev/vi+QgOWIZ6XuDC0lJBU
         QAOFfLDWYmnzsmXUbu6ij1bfcnkhLt0fWtN2wqAndhwXlZSUyEY+NJ7chl6GN1kek+Dm
         V7l3O2RsNuk6FzK0TqbgSqGwWTTL81OxIV1teCjZNPkL4ylcBoO53PcW1fz3C86veMMA
         idpA==
X-Forwarded-Encrypted: i=1; AJvYcCUHyy1Mv7oeC/OKOZ6abDoPywmHa8eMzqj8P9moWDQVAjnqFayB+q2eU/0pRDDxyFWTs3K41HV/@vger.kernel.org, AJvYcCV70htT0xeCX2ZKNmNb2C6kXqcFNgG3oUacyYK6OKnbzS7mW6cSuj+upDyWry66LVMdymzcFo5FrgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcubnAaRjWBacNEvRjfDECRBIy4L9jhXQcT/BzusFCzND6d3Nc
	1h2VyHx+Be9m3Y12sSWkpXPoIsd+mg3zfBPGOmvsjYQZ6kCCbVNf4UnW
X-Gm-Gg: ASbGncsNOHRC88OqHNHFdtFwIaSHpHedKwpWpJtY3XqpCTKRQPRVv37W3SggREVAfOZ
	Phiq6AW6xMKByOybod8IV4dU/qsODdvw4QPJ2NSq1FUl/zPmsTB5/3KbFt2Cgcs9tRbkGnjazX3
	FUFykoZb59nZG9jdM0+Rn/gT4IQDd3HhcFnjWtKslKBR4Bho5B+ji0D5dQiDWAuWgCzVPTUg96A
	FcEglagm5D8PDUp5gk9o6VpgwOrNZU/UwgHWkPM2A4ec5TbdULqx4ZlPHAZGq62UI+jzWF/WmrW
	KOfQ3u4njSPe43QjZSRp6OB1SX7csDz1OawKk/AYL+EUfytTWKhMRL/xEbRpHIwJA4i/bcXN7Ga
	kfDYKeuxpP/ecF0VPjWKwSCf82VyV8nYCmQkONLQ5iKf8i1hVHnynyKyvrg27MUWh
X-Google-Smtp-Source: AGHT+IGJpls5CYjYfpDD0nrfSMzKf6KXmMloUHe7S+4US4/txZoyNKAT7wIVE1eDUghDpeA/hequwA==
X-Received: by 2002:a05:600c:4686:b0:459:dfde:3324 with SMTP id 5b1f17b1804b1-459f4faf99amr24275765e9.29.1754659871273;
        Fri, 08 Aug 2025 06:31:11 -0700 (PDT)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5e99e04sm133600065e9.11.2025.08.08.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 06:31:10 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio composition
Date: Fri,  8 Aug 2025 15:31:08 +0200
Message-ID: <20250808133108.580624-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the following Telit Cinterion FN990A w/audio composition:

0x1077: tty (diag) + adb + rmnet + audio + tty (AT/NMEA) + tty (AT) +
tty (AT) + tty (AT)
T:  Bus=01 Lev=01 Prnt=01 Port=09 Cnt=01 Dev#=  8 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=1077 Rev=05.04
S:  Manufacturer=Telit Wireless Solutions
S:  Product=FN990
S:  SerialNumber=67e04c35
C:  #Ifs=10 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=01(audio) Sub=01 Prot=20 Driver=snd-usb-audio
I:  If#= 4 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=03(O) Atr=0d(Isoc) MxPS=  68 Ivl=1ms
I:  If#= 5 Alt= 1 #EPs= 1 Cls=01(audio) Sub=02 Prot=20 Driver=snd-usb-audio
E:  Ad=84(I) Atr=0d(Isoc) MxPS=  68 Ivl=1ms
I:  If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 7 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 8 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 9 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8c(I) Atr=03(Int.) MxPS=  10 Ivl=32ms

Cc: stable@vger.kernel.org
Depends-on: ad1664fb6990 ("net: usb: qmi_wwan: fix Telit Cinterion FN990A name")
Depends-on: 5728b289abbb ("net: usb: qmi_wwan: fix Telit Cinterion FE990A name")
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
---

v2:
- add Depends-on
- add Acked-by Bjørn Mork <bjorn@mork.no>

 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index f5647ee0adde..e56901bb6ebc 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1361,6 +1361,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1057, 2)},	/* Telit FN980 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990A */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1077, 2)},	/* Telit FN990A w/audio */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
-- 
2.50.1


