Return-Path: <stable+bounces-212727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBdwKs7FemmY+QEAu9opvQ
	(envelope-from <stable+bounces-212727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:28:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F8DAB1E8
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CE2B301C6E1
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4D435503C;
	Thu, 29 Jan 2026 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9I/wtM2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F454739
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 02:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769653708; cv=none; b=Y7JGEEsZd5K850ezpgTzE9z7GRc4BSQbBc5qXFpEi2NdX+YPYCXejoRsdfLgYGBBYWGT5wqBqGH6cussHXk8G5a5gMFLIvPM+/aFt3U5rAm3ax+E/v+NwQmarpMyQvxbdb7ov7c7BHe0IcHRM3tuAKtl8QQ1pqy5ikZzQLuwNcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769653708; c=relaxed/simple;
	bh=jke16qGYYZ/PPyh9bOnhUq/mxF6cZ5UQRXZewvQRH2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZjxhGHhIf2dLvRc6cEnH41KE3Ltlpi0qD9S23F87qPtPEyHFy5fS0bJOLZS8y/r11W7oTrB6rYQ9dQaXZRsY7dKGpxub623PswkX4H5/r1va8XZeozTVYpwpwRCf5Cjj0d8sOo7M7sfBYr8KQHYvhqkwJyirkNu7WH5YEs36PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9I/wtM2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3530715386cso275371a91.2
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 18:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769653706; x=1770258506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EGo4hoj4EdUYYd7PUFglCgfUu6wH660sspS1uAlnjzA=;
        b=A9I/wtM2D33VPGlfxefNG3u0gT3CwNkAa8x5jOre22yqRWd60pST4xhQZZbrl1EDrr
         ktWYj+y0ff7XB/3F4bUL/R0cAJkx0E1QEXxnfOLhirTXOL5OZrTsRnjaAYFSOwOko8v/
         C2mHp2K3v8DvGlUvdkyB3IkYQCjW/7FuXkD4omg/I3eZYon8a1Jfher6KCCANEJzP92H
         2+Xzh0fmvxSCzT2/n+AXS/1erIblWNfVhJyf6GwEysv5Ay9SsR/DkmwV6mkuFPyAMBNg
         Yr5X1CnoVZDI8EchD7FiPfSJ5H/PZ1ubiTRGr0X0oL3xewkBH01kjxA0eNm3UhUKCuaT
         ewEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769653706; x=1770258506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGo4hoj4EdUYYd7PUFglCgfUu6wH660sspS1uAlnjzA=;
        b=pqBNIyfQ9OR4KLQuJx8BH5f0+KcMWAFQz2G0iGNHhVO9HfxDC4cJjZYMp0kFlpRvmK
         lL09cTbCtzatX8IK0EYcQKrcT/jrA/2TgyWDV/e3BlvsrUpJaWBmxuqxf6hEsIPIcMAv
         NzeJza+BaOfC/XQyUCG/rIqf+buFy5Ky0nJOSKRT7oxUbcsssAzm8uzYtv1CByWoo3AR
         8xpfGXRHUe1g16ssNkl3h06v3bLchBWJVi4YTjQlAZbS9RIlCe81pu94AvsGF3AKEwoU
         6pHcUXyYDzo4Fre6SkJhaE0bWikRz+gHtWXHTGAiLskOfczlC9n4z9+NGDwsj5Uyfytl
         kt2g==
X-Forwarded-Encrypted: i=1; AJvYcCWINpn5F41WUslly50/SuSN2YPOxu8/LEPLsiJylL4lfGlQ8rAquGhGoGsst9yQnIbodIodnxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSJrJkjjNT70cJ9Sc2BdFzoyw64TDzkur/8W3ifz1OkX1Dsg4
	c/Rqj2j7vSHgq0CDymkDtBl0q8W7k6NBexmy2N2a/Gftsyt6k3ldt6wF
X-Gm-Gg: AZuq6aLd1XbiXZYXGdXN8KM+w6UMGkM+9pgTTBeJbidQQGWEWJkOCaX5EDcV22mfSb4
	OolWKoQPC+MHSNzaonWNo4w1Bkhjl6tWXSTynGhOtaQb3/drfVJWiNq8XqTJvRspM/1F2Zsct7D
	+JINGhlZWTWv/Ww9zotLOMTyV7CVcd2p4DmMMXFErSiS9ONfrqaPR52P3zHTx+yZf1r6sgsPNYa
	bQm31eQd1H17Ydnhig1phapWY3+PWGCvsIYyLCHAC1qBHTrroO/YFPgop/DMMHJci1hiFc6pI9b
	eTq0rkBZ3x+ArBYNCUMSMfo85imFbGvjtCXYfWGevtbOtuom8c61Qp0u6Z4FfTX16XbevoUnrz3
	t+V3VWN58lt18Qw3dWdNtxPilayWY6ViLN4QATQI9KDinfrhScMK5RSoslwYyYGLUYJizL0ZkdX
	TDSEudfjwLvFIdh/7i23rBJ+LbPYXjkGBX7WmXuuuI
X-Received: by 2002:a17:90b:544b:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-353fed907d7mr6446368a91.33.1769653706068;
        Wed, 28 Jan 2026 18:28:26 -0800 (PST)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-353f61e0230sm6783867a91.11.2026.01.28.18.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 18:28:25 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pkshih@realtek.com,
	max.chou@realtek.com,
	hildawu@realtek.com,
	rtl8821cerfe2@gmail.com,
	zenmchen@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add USB ID 7392:e611 for Edimax EW-7611UXB
Date: Thu, 29 Jan 2026 10:28:19 +0800
Message-ID: <20260129022819.61290-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-212727-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenmchen@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 24F8DAB1E8
X-Rspamd-Action: no action

Add USB ID 7392:e611 for Edimax EW-7611UXB which is RTL8851BU-based
Wi-Fi + Bluetooth adapter.

The information in /sys/kernel/debug/usb/devices about the Bluetooth
device is listed as the below:

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=7392 ProdID=e611 Rev= 0.00
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
I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtw89_8851bu_git
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
index 8c34a17ed..fcec8e589 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -529,6 +529,8 @@ static const struct usb_device_id quirks_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x7392, 0xe611), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek 8852AE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |
-- 
2.52.0


