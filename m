Return-Path: <stable+bounces-166696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6B2B1C5A4
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 14:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2C73B5332
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B0B28A1D3;
	Wed,  6 Aug 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GePPYCjm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F018DB01;
	Wed,  6 Aug 2025 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754482491; cv=none; b=st7nmTk75xTBR35tqmwek8V0uV0G2o875k7Gda1JPASRhKxiWYx9NosdvH0QK+TIoDmv+zNoogEfkss/9RKu5+wM0Ln8CDQQQhQlW+PMsdw78mM4YCoQCNENZEK0UrJJo0oO6y3t0JrSRjYpcIz8/DzhqmFjJflFbjnQMPpmqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754482491; c=relaxed/simple;
	bh=2SHhmrLJhEaqqVr9125p95YXo98HuVuwhqj7qA3ejLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LM93+7YS/eIvSVZS1fD8jTcBn3CqC6OgUfdK3Upd0LP0/4BeIRAopOHPrfjrwk4Kvkd4dHsKxfZIM4Ir6qM81VFjQN7mpbaQdb1cJe857qBhJLdHe8pf6Qd8vwoTEAqMJ3iwQipRpeTUEc928pw6A615lYQwveSkTWX7KJi1HdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GePPYCjm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459d62184c9so23436805e9.1;
        Wed, 06 Aug 2025 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754482488; x=1755087288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVbeEujlJDiEncI61Afb6eEQ6w8x/k1Hu1Ve2S+nKIo=;
        b=GePPYCjmTyiUr0EJzWJZFoZkJPck7ydYFvURoqg/h8BYYcDr6GaKjG8waR2mgcfByt
         HX9HyIvgmVwflZT+UWwpdx5fnM6UMDbDSOsj4hbTCMEed+QlZszJ6VRxgdXhNexGC9hw
         JEsE2bcoaJZKYYjuQdTsjXitLxc04iiQ/xqTFFajSq2wtkG+ggHdFJWJC8x+qBKthdmv
         G5z/CSJE35eC6cDd+/WzWqwwsK2GiEI5kKYIUxD5ryhIGKBDI3hiu3COsPK6t89YSVmW
         MWYj1ImJxXIGdbjtHoMrqucl95pYxiZyBnpyvoyX+yzioVFn/gliyAnWuA6XhUlPmme+
         Ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754482488; x=1755087288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVbeEujlJDiEncI61Afb6eEQ6w8x/k1Hu1Ve2S+nKIo=;
        b=Ul4xk8A/q+mtSTytOz9kFf0DjMjaL8twaCalMLLIeg5pytA5qQYwACBqWONYScgMnI
         7KV/xBhrwWKVWayiOmcFxhtJMsE6gemXt9sol6RWwQeCFvDd6sGEOWgGjsX6uqC5CibK
         xQFmKoV9b+JrjBmyCd9upq4+gZsASjJ09ewY4CCG+2PxYHidwSde0QHgeeK3imzcwke7
         g+ZQupEUk1+jbcLYVs53jQf7qGOIt5Y8xKnEibjfRwy/skwH1tt3bEvTXN1vjrF4AiyE
         ymnoqScrzLg1mTwdAv7t71v2P3TO10KjyA1eRU5/mClegBxOEpk3Dn2i9rLikU7Gx0my
         BGrg==
X-Forwarded-Encrypted: i=1; AJvYcCUhRe5vrvH00+/a1gVofup3QqLFAp/AyGtAZA5MkO9m3Y5xCqPCgTkn1sjLljcyABZnU38hNhg9@vger.kernel.org, AJvYcCWMz9dqKCfHYu20eg2ZOUSeVoe+iC864PY+TsYtkxPAcRaqQdSTuHnkWX0TXBBv4PkvoMcGFyCUNC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9Qk73zqpVfrEGBLVSDfNCuvxleRxkMJfI06BOeyW+SziGRl1
	zIVCl0nD/eVVHYd7aqLQH6VWi1ArUvkvZffkkGEqwz7soCoRwRDQg5l5
X-Gm-Gg: ASbGncvd7GvYogxKbMSvo47YAjkhFGf5H/kIGcvmDnfG7uXZYe3tyEwA4Km+h9v5SkO
	VHObabiggVV0bKw0f8/TXp4ZawFJxxwuYZwLe/FrmWwHfY578bIhyLuSy0SXqyLGouKgn/ahf6o
	CQ7D1p5W3EI9LtKZl1Iw2kDqIAX+Oo1i4nwHRE/Sh3H3D7XSc/jLOe1db6uEwnMy7xxey6G+eqr
	yNGmA+kMOHtjMsccTVBZz4yyLrkvVGUb6Ect/5JlDURwjG+eCyPZSmeX8APtK1KfeVTzdEK2z0Y
	dN6/QvJ7xQ8BsNNj53w0EAnUgPllLevGHWuaIofR0OCoHmHio+BquyWjaUnNCWaNZQSE6a6OWwS
	Neqz+ThkGSnVABkxYbkzmPEqVOtZ7nLc7K2Y6cCa7jHk3usCZC5vo5Q==
X-Google-Smtp-Source: AGHT+IFs9jZIaeUglriML0shGDqWmBTnIYT1xOprRf7ZDwlMPY5StVsyncH3xVVHRIpYkmnDD2dHUw==
X-Received: by 2002:a05:600c:1e89:b0:453:23fe:ca86 with SMTP id 5b1f17b1804b1-459e707975bmr24073315e9.4.1754482487776;
        Wed, 06 Aug 2025 05:14:47 -0700 (PDT)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458b501f22dsm120115075e9.0.2025.08.06.05.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:14:47 -0700 (PDT)
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
Subject: [PATCH] net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio composition
Date: Wed,  6 Aug 2025 14:14:45 +0200
Message-ID: <20250806121445.179532-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
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


