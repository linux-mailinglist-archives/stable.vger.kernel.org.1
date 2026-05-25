Return-Path: <stable+bounces-254179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oErJCj13FGqgNgcAu9opvQ
	(envelope-from <stable+bounces-254179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 18:22:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E3C5CCC80
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B43B303FAC8
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC33F58EB;
	Mon, 25 May 2026 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh2plauP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129AA3ECBFE
	for <stable@vger.kernel.org>; Mon, 25 May 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726004; cv=none; b=YrKGsmYVPlGEYAiY3EKDYVjo7eDE/JLmbN4Ukp3DWtYaPoaNYJwNV6gUjXpZ9QR08GV91gSrCClZ7GmUjXTLu5JDhZh6XRzyKQJYQa8d1NapDi34/q9KTidw2tsAfqJxy5/zQpHsOCqi2bevZbl9fFH1MvPz5w7ZzqYf/r3RyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726004; c=relaxed/simple;
	bh=iyS+b9DSSYsGAsvugwS4FzAaGls8ZbHNFyXqF0iuyRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P/0dADBwtvknXN6c5dct/JktEH1irl/DUY8D1ebUK0ZqRA9qDUkSBrpnadbh+NdCKPzNh0wiMW854TluqlVj8kmtRCM4Tp6mB17fxiIJ7JdeDlU2Z+6dv69r2Nk6mwgQwSinKfwsmaWoXIJN5pLSYCf2qc/AmlvbCFWQliGkVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oh2plauP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f8b60e485so4034242b3a.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779726001; x=1780330801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RoWP+5iXGGorIrPHxGK0nyTarrooaD3pQuWFHKUsdE=;
        b=Oh2plauPg9BoMXTAPAtY6M2bGtha2aWiwt6mSqqBWxBabQ3DQ5bGAfS2HgVxjc5z4F
         /UuoV1Js4oGmZeYwJzNofrw6x49KXprqGbph9kOtrGjtcK8Dts/KAgTshs+1XqZdnpBw
         lIZ79j1P1ZDMo0On89LwicnlXfiPtgsBezTm1jZwq5XIZWz+n7lzgUgUC3IfP7MUGGPZ
         SbJRwtCNXDE32J4vzwjjBBzdeDlJbFyhuHKthVe4kKBPE43TTU5+xlGcizM/zb5Cjtmh
         6jQDiFMHaePEGjTcFE679FIMRDNRJSrYbRSlRWeYFV33290s6NHJRTccIMTrFhBifIG3
         sTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726001; x=1780330801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RoWP+5iXGGorIrPHxGK0nyTarrooaD3pQuWFHKUsdE=;
        b=YvJMfaAOGlAPzhR8J0rCndxwZ4IlUKoCdBm2RX7x3Aw1LbE0z2eoy9M1eleEb0zfI1
         PN14JR0AXP7ni+9YJVviCJLL1jW/5B+taBvNeGIUlqb0G5a+8Dvih8npP4wI279VXGJs
         FxI0mUwyTNZD2OAxp0hDn0Fc+yQxjtmYBxyOs+d1fPt0pbIb+QLr3zJhLVL6v36PX0/o
         AsIMN/MOSM0M5hDwh6mX8FHd/ySUGjhVjsku9xvqL02G1fJf4UnuAQP3mL8uuX1iFD8B
         t90rbsFMsiMfNrJ1pyqe3Nvtp9Mf/PbbmdQjSya0kUEE2yYHYddxI1PVs1OfHqrEfkpW
         Gz2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+69Z681cFm/EwTtabgxNGO5ZGUl6l9RXInDqt38dAM/Pphnipp1ycugwox9+AuGTkRDRS7iAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQjGnYn0tHlhzWTVbg3LR+ZAUQRYDXoHXQRfCUXkHUmOofp9lf
	1yhvlb3C1zuRwenEPRDnz5vZ7tAo2hWZmvFoJGaJSKtVPqaJwJ8Aolq0
X-Gm-Gg: Acq92OEL8LlF+BqA4zajw+tNClB9mxkTZcaU6YPSIpOEJdDKD8KSKLlk+pFC6ui4XHL
	Bkmj4CstoXmHOUNXvlisrIdobFueYUkP7G1iz/TDLl9fasUFVBQKBmlnBEVE6SJjCVzvQ5V2FYR
	EavoqLmfi691tSEgI+M6AALCIYTgi7if2vyTObZ0TJZ+NgnO8qOe2VXeHM0Tuj1Iloqwoyb0JlX
	SCO9sC0vfz2b1thHJMfVC3N9x+3PDY7wi7csGdeRNYb4QB4Vp09siWwH0PjcMeU++GGLChpAPVu
	U0faq1Ed/nlcAJdjXCbMiwQDQT9NeY3/f1nS6xm9xCvmPYToR3cPbRbL3r/8dV9h8Y6eDaQ9vPN
	iyqw6ZnZOmldAYPRwJTV+1vRKOU9uj36/9qlXNxihnnjdzI2owhMliBK+LGZS8Jr64b3a6kLwzM
	V53TPVZSPEmYNFjO+B1BQQP0YTxvQN3KKmwlDx67yxSTgUyeM2RLZ56gA=
X-Received: by 2002:a05:6a00:421a:b0:838:af72:fb44 with SMTP id d2e1a72fcca58-8415f0f16ddmr15242462b3a.2.1779726001426;
        Mon, 25 May 2026 09:20:01 -0700 (PDT)
Received: from BM5220 (123-194-40-181.dynamic.kbronet.com.tw. [123.194.40.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84164ac9fa5sm9871585b3a.1.2026.05.25.09.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 09:20:00 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pkshih@realtek.com,
	max.chou@realtek.com,
	hildawu@realtek.com,
	rtl8821cerfe2@gmail.com,
	guillem@gservera.com,
	zenmchen@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add USB ID 2c4e:0128 for Mercusys MA60XNB
Date: Tue, 26 May 2026 00:19:42 +0800
Message-ID: <20260525161942.5206-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254179-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,gservera.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75E3C5CCC80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add USB ID 2c4e:0128 for Mercusys MA60XNB, an RTL8851BU-based
Wi-Fi + Bluetooth adapter.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=03 Lev=01 Prnt=01 Port=04 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c4e ProdID=0128 Rev= 0.00
S:  Manufacturer=Realtek
S:  Product=802.11ax WLAN Adapter
S:  SerialNumber=00e04c000001
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtw89_8851bu
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3523d86a4..a13f10c7a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -532,6 +532,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x7392, 0xe611), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2c4e, 0x0128), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
-- 
2.53.0


