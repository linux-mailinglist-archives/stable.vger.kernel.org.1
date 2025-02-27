Return-Path: <stable+bounces-119830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4876A47C27
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 12:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A6A3B7B93
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9122ACD4;
	Thu, 27 Feb 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzLWQrjN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592B3EEBB;
	Thu, 27 Feb 2025 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655608; cv=none; b=AZ4YQqk4eSeEAoiPDQdl79NvhrOHjwsrF2dm7KMXkp4NBtkfmuMd3nSUsyN6sKTpZrY4oTGOS6ZnKFNiDJ+87cIPPmkuz6i1bQrZH2mbDEgBHDKgG3ihQl1MgiFkVErwofAKzOnJvOajluGUiFkYqnsXJukSbZVM8lZws1aFLKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655608; c=relaxed/simple;
	bh=RxQsWAXlmEj53A0NILzph5AmZ6KGERDtdxEn8UkEinc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT8x4H3+QIjkBdneAwyuYdGeM5UCktRUkIf2HnSlRVlJY/xHS+rU5Qb1pB7aIWgsdEZU6hy41aoPaM/KxqqIje38W0QmGLGnGBGSbWMz6TMi+wPZaq4SCldabIsqWojcBGCLVwWGdPWuYd0txQGK16CPxBVr22/Yf5CLnb+v3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzLWQrjN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43690d4605dso5215945e9.0;
        Thu, 27 Feb 2025 03:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740655604; x=1741260404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aSPmuUuDQIAM57+UeXUfjnESksmlEUpw0pECISkBp8=;
        b=WzLWQrjNefaPWYadCtxtGdA7vYeOySLZfAczjuAIgtAmy8Ukg32OpxjgBUM2AXYuBv
         UBAeP4rZrg5VAOH7WBSnHN5dxKz2Z9Dh9SbOfoBEj1RsasHeBLxah/rT28Zh8l9DOrN4
         7Fq3f7U500VmVyBi5/vUzSNWgnt99G1M8yhDTbJnG6ZWyHIS5wIS8OjbIbFAHnZk6VAQ
         7EzUeoRwe2C3cMfSur8waKjiZ0v1ZDOy+yHOqpN0pCsPqRlq02tN6wLwTBJ9z0hKOJEV
         5r9tZmc67vINTPVzN287WzCKlw7YFzsCcXcoO2DpIMG6zmy/5HTYB2GYkMfpMMM/7Epd
         0zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740655604; x=1741260404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aSPmuUuDQIAM57+UeXUfjnESksmlEUpw0pECISkBp8=;
        b=uQ4dRf2A2DYbDj1R6H+agCDJmR0sK4VfzRyKL66JTURuLlWGPA8YjDNrpS4Lo10f6T
         ednQmDzL2P2T3Vmxc5az022ruWNpog57yLIx4G5RPCq1IeFvuxQy/M12XISyGpnDbdny
         sKpQxl5EiCKCS6vcEduQeByZPe/6Hr3yJAwCB4XUESrRVWD6sMufVrVDliJlo7Zf1Zfr
         1bnUOZ5iEUVg7gpMeqe/GZSO6hHyRFvGZFyaz52U6XTG7rCG3WWK5FnkqlVSpDHAoFE2
         CR7iyTTRKnhfD40VRIrvuiCj73bLQiIL7m1KZ12/Zcw4G8EguUzPczdzwng5h2D+C1kw
         +eFA==
X-Forwarded-Encrypted: i=1; AJvYcCW46zlDpgrz+mlDrykYFWEOrremdOAQscFFXkbPKpSqii4U8Mgpw12m26E4X/cXwc06qdwhu8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzds7/i14Nx/5pqmiLW+1XK/JXJxiv0Xjb9Ke9gAJooQLElASnF
	QVOpu4vczpdQ+oaoIdMWD+fUv2is+3+kdRt4AAjaxx/DXV8DZu/7
X-Gm-Gg: ASbGncv4lbmTMFVzsaAV9JnH3Qf39EG/uEZ8TfLaXx1DlOHnXiqSc0gS5yUJChBHgzE
	1EK8k+ngvCLdBsCetqTLQdyVQ7pp261BiMBn6LjzbAUiZ2uoMbcYJhmaqSUa+LlHFJ6SCQNszso
	ZZ26uP8wE636WkBGvojvAg+CAW8WmLOgoAtkQP9Wugr9cHJwWaeFvsXu2QPmybGuuGY5Y/WnGb+
	PRoei7g1j3JkQogpX/4R7TnyK71/IMumMA6HiHiK2XUkLJ1IvrTYcI+TOarj8ZdSlmyh/bv9Khu
	8mw1EIoQij1HdJdX5J6fZJVp/ky8TAK2/K07G4GNpT+ie0afsLTwdH5WIdQxKRa+SxoLsLQyuhG
	xMiAHOkTDLPuXSmm/JsY=
X-Google-Smtp-Source: AGHT+IFXckm3q95iP1DFJDUjMbwjjtPSxDULzR4s9pw9OoeV+hQfQxOnmqIW0UfXCorBuecijHY2GA==
X-Received: by 2002:a05:6000:402b:b0:38f:4531:3973 with SMTP id ffacd0b85a97d-390cc5f7094mr7643214f8f.4.1740655604503;
        Thu, 27 Feb 2025 03:26:44 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com (static-82-85-31-68.clienti.tiscali.it. [82.85.31.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm1757685f8f.50.2025.02.27.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 03:26:43 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net-next 1/3] net: usb: qmi_wwan: add Telit Cinterion FE990B composition
Date: Thu, 27 Feb 2025 12:24:39 +0100
Message-ID: <20250227112441.3653819-2-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
References: <20250227112441.3653819-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Telit Cinterion FE990B composition:
0x10b0: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
        tty (diag) + DPL + QDSS (Qualcomm Debug SubSystem) + adb

usb-devices:
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  7 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10b0 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FE990
S:  SerialNumber=28c2595e
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
I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 14d1c85c8000..287375b8a272 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1365,6 +1365,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10b0, 0)}, /* Telit FE990B */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c0, 0)}, /* Telit FE910C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c4, 0)}, /* Telit FE910C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10c8, 0)}, /* Telit FE910C04 */
-- 
2.48.1


