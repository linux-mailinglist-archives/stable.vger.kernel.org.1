Return-Path: <stable+bounces-113949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07ABA2970F
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 18:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52D81675E5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F2F1FC7C4;
	Wed,  5 Feb 2025 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBV8HWb/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BA2E64A;
	Wed,  5 Feb 2025 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775818; cv=none; b=MCVAwq3mLlp8KbIhyX/eKrOMCOCS+317TdsAwVXhkMOFeazDqRonLA8SeNwwdipJ342ZuVZqY5Br+V44xMK68EmmdQLWo79Tl1kUx165SLLt3Qr2+G8+kGSN2O2J8Hs4pzmmPGAu1hIk5qjP+fboTbSwQ/ALRtNBodgVWJh9Q4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775818; c=relaxed/simple;
	bh=E/hRNJtuqtMXNGvoVGdIomguAq0eLAENGGI5vNfV3ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PKidH9qfClKTNMWW+e956mtFKEj0weZMASqhTYayjCcJMl9lugNbW7I5CJKtAi0rAO0OXlWgsO1wmKAScU5wNZryog4MsskpQSxit6lxC/jRhNkEPaVcumebE4gpKsrt21ymEFoFqPAjCLBVzbTW5gNVuWwB7V1eX+l9onELy/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBV8HWb/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso161305e9.0;
        Wed, 05 Feb 2025 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738775815; x=1739380615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYCfTbmKlTJiaL0ZiUMYD0efLC2XV52Kcudlo3pKSOY=;
        b=cBV8HWb/MfeK8Jky0TwakdZqW17xM147n4Nu0ddjyMFNX+X++CBFl9MtnOLG2XgYqh
         149MZRxFicBIwSeNz9J/mG7axg9jpCSM9oex9SyHQCh4i8XWweMtr/av64zDEjBXrK48
         jwwQtDZ7BCIDRQB1IU/3TCJgNHhzDZI41G/63O2IstpxCH3+wCJk+jhxzJloPLbEKhGC
         VJRPwSfdEf+U48K/sCw7ZjtDeYaPQ1UdNxbrz1xXUqtVRcS4d9Kys480WbpdmrV6jJQf
         FZCLHvCpDmC9U5P202D3jK3rCM+p7RCRo9t43s9WIO9MPp2tDoQby5pPGm57kLVQ+zDe
         lqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738775815; x=1739380615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYCfTbmKlTJiaL0ZiUMYD0efLC2XV52Kcudlo3pKSOY=;
        b=BEQLaupv3fdJTaVF7o3v175OuY15F1ikdZbe169HRAOKNdGuV+J6Y6optB/zHCuSE8
         F3EDkhHq+E76OayzmPN716ndvazjWgIA48hbvbeFwBz81UJIY/fVYlmYz+yoJ7F4zIE+
         vyLQ9NHWgNvZZoZiPMw9fcGPOqML/s+il0FLRn1RaO6BKk8s/RMtZ7xavEGuF+vYTpKK
         sQg/01vYU7WpQbT844/WLYMzupdLHC9cAiV6UdJpGKL0dmXBcBbhG/HWbhSut4wpUuW2
         fwZDyB3UqFIcR5Z2yC3B5QBTvS3fYI+ZKYuah9NnIX2SnWGZCeIYQ2CVayfghvcO11AL
         Db3w==
X-Forwarded-Encrypted: i=1; AJvYcCUw7puGt2PVg35SQ6VomRq1+HOP+AHIPFAwJcvlhhIVgbiFKn0WZKp4wmG5s5Yrf4lyYQk0y5lR@vger.kernel.org, AJvYcCX1dB4H06rRpqjo8IxrFkSyCCwMn5RgfD1LmEI87Q6C/iPSFSjVjozA7k+AoH6aLf45iQFURp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOUiwHZeJZMW849glZQ/9Ahe2dpESj/rxpjHwQQcWZPN1WDDZZ
	I2cNWa7PUiOAXj5Kct+Oh4p4OFvq3SyYoY8YSw8brs5YveyDl8I9
X-Gm-Gg: ASbGnct3giYvhiE5cxuqiA8pSdUjuCcIMMStxYK74xCXx5OV3yy/CYFECwyKL3ZJs8M
	K7DAOByD1kRRT8dBNJQKvpN8esXygE9QWcNUET9vuwKYFMRQSDnihQApUQq45RUJQyCOIzVC6Tp
	C1BzRfRGSP9/v40Qej/e5MxN+UUPTXud7Icv3Q0sJrYiIP+giUcgb+9HTmn0XzOucIuXuirNLzR
	bezWkjC4iFItbqVFMk1wEuz6RPAgJB1zGub0XBDv8Oy4IOuSxjftiu9De5Be4OPW39pQA/GesAC
	uukuNYjLS3LHNqGrWRFMc0GeYLrtnmTqcDf9JUPHMIhEGQ==
X-Google-Smtp-Source: AGHT+IG4LmeiGSnhtR301szGZvrRrj5gNVVv5pwvYPtBamzvQr9VJ3r4Avwp1be5HJDO8GNHaKzRNg==
X-Received: by 2002:a05:600c:46c9:b0:434:ff08:202b with SMTP id 5b1f17b1804b1-4390d436322mr32758115e9.12.1738775814376;
        Wed, 05 Feb 2025 09:16:54 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4480sm27185705e9.27.2025.02.05.09.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:16:53 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] net: usb: qmi_wwan: add Telit Cinterion FN990B composition
Date: Wed,  5 Feb 2025 18:16:46 +0100
Message-ID: <20250205171649.618162-3-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205171649.618162-1-fabio.porcedda@gmail.com>
References: <20250205171649.618162-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Telit Cinterion FN990B composition:

0x10d0: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
        tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 17 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10d0 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN990
S:  SerialNumber=43b38f19
C:  #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 6 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 7 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e9208a8d2bfa..7548ac187c26 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1368,6 +1368,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c0, 0)}, /* Telit FE910C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c4, 0)}, /* Telit FE910C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c8, 0)}, /* Telit FE910C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10d0, 0)}, /* Telit FN990B */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
-- 
2.48.1


