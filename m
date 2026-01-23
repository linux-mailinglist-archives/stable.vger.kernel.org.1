Return-Path: <stable+bounces-211397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CErWIqCRc2ntxAAAu9opvQ
	(envelope-from <stable+bounces-211397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 16:20:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ADA77B63
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 16:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C17A303675A
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741652DAFB0;
	Fri, 23 Jan 2026 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs9Flc+f"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6E2DAFA8
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769181571; cv=none; b=etCGqonE2817O9yl10/xm3eaw4gv0Yi9AGOJI9Uk3UXyVPrSE9OSE2ptVDmZazCDpx6BjKBO1EWSyBEkgrdVvKr0pENHfmtZjWYp0/c+WEZayWX98Ka+YITPg/dnTY8q5YwRenlLdoL5MbMgUWcDkC5WAR/sxG/Wa3FwWddzF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769181571; c=relaxed/simple;
	bh=4LpPjfe9rn+yS1PGQxoW/QbbKg7ajPxiq2wbY1UkUUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MW/SzPYtTdPzJEUliLFNIFJmDevOP9jBgp92WCmBWuPPPGNyO1SA5pS4PHTuGcS2xfrzX5IxN6DchBuwN2MFLxSw5G28CX0/slVPMhKFN3x9B7Ah98Da5zbXLZBzYZZTcExDWS9mRDytvxlIvW5ZFkUEceQPBV3UA1spY1O+pfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs9Flc+f; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48049955f7fso17599325e9.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 07:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769181563; x=1769786363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7BCjQjnmUQotpo9OdMGqmi14ed2NFhOcZgtY8X7pDrs=;
        b=Zs9Flc+fAeyyyKHfhmHjUPegKiKLL6nPJmoknG8HJTkjVgJ1c6AB24S6ZM4iQeMIQm
         a5mTUTR8n6MhqqM45xixn0Xs5QweY4GxVQ0YgDVAD7ON7x3cmpI8f2gyyc54Nv02CQ5B
         cntliDFsXi/Oru+K82NZbI0iIULfj7zloo0BBsd4v8XOJ+Lb5QEUZdRWlNUwYvER7WLY
         zt/p6TtMPzILLynMB7QH8V3qc+aJp1IpiRdZmkxWvd6rEQvSzBWnbD7tf+o9yAwLM4UC
         o8ZJo27SkLiPN5G/YogSFv4LFD2lgHdClhqYrCdsjvV1gBI5XfwJ5eHorEmtpwipsLgd
         dhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769181563; x=1769786363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BCjQjnmUQotpo9OdMGqmi14ed2NFhOcZgtY8X7pDrs=;
        b=cY1zuZb7GQzSbHH8bO7oSFBK7oePjRRAew6nM0qPP74FBaHvkaf9AD3rlemEKxFLZT
         s1wDR0DG3+Oaaz0hm4Z5wS/dKfIdMRPuFNxMtIrVL14g79kzR8FFfQXy2KQF2fH6l8ID
         rPSvOD9XBzyiYmHVJZIKOBh6eCWD7K56xyjtP+IGJ8DMAlJDC+tkyuMvacsV4FnzwQ6x
         ToDppm1hXW/KwfBwSanK+EujkuxgoSi8Vlj2s4vZSsnQzXFJFzqu4gzDFav8So93KGw6
         jynHxwMj33wFG0dcFY6EdOHbXBMi8z98zl4MzHGjPNhcwJd1O9z3XofYQ/DU8PHctukK
         Ur/w==
X-Forwarded-Encrypted: i=1; AJvYcCUo4Qwpvb7KOF59Cpg8J4Tvm1AkXJ42PbuRiKRhUhup7f/A8AEddXlrr65FZzMWD6Aj2vKIb6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIMKdSX5rb9Phi4GV6/Y518E4BCDt2DY+H+grKTbXMTvOHRhiN
	U4EIfq2UjR977q79jK8YhIkVgVXEe3WOw7ao9Ii7+ShPilzTiF4bkIZR
X-Gm-Gg: AZuq6aLuikt7aOXNLePeO3/HV6M/8ZwaMzZ6BFYBL6UCLBtrSIknb++4CowWQ+X3rjF
	GiRh83QLVhb4vDKrlqvRs3P9vPDUf4lYi/CtiUCDKGs8XsTVuM9H371IaB3CF3ZrtU/cbGbcJGY
	wfPSwH9utNVdk46hVEbN0VIl7BihhX2X4w6hELhHsaBAEnc73wyoG6Bwtif7wdNUrOIuCuQTqy4
	4W4v49ywmmOK0jR3WGzfbkl20hQyPaNDqQmJNxbfixQkuTbTDvAxWjqPcK8dOySG4NZFsSklSV6
	gMjrB7B7Bv2cJh/s3EZk/I0dA2jQSQUte3ylNAaUSBpDRej4zIdy2Dt7v46aOAQzJAf8j6M77sT
	RWcC8MBOybj1Qze4naL9HmYtmA0BlhOcsSDYmaTMkieuvADF8afCFEN0a6Suyfzw9hdFtiOtmCZ
	Fl5AR/mQlA0psLNeWkU9VxgO/lyF27ckz0TE5z6t9rM10iNR1yrhLRfFfJrJmEbDnWI+5e7QSZ0
	fIavDz0ybPx0dvhtNRHpT/BeKYh48w=
X-Received: by 2002:a05:600c:8216:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-480511e5085mr28092675e9.7.1769181562560;
        Fri, 23 Jan 2026 07:19:22 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804db8da59sm24375875e9.5.2026.01.23.07.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:19:21 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: option: add Telit FN920C04 RNDIS compositions
Date: Fri, 23 Jan 2026 16:19:16 +0100
Message-ID: <20260123151916.25381-1-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211397-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fabioporcedda@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27ADA77B63
X-Rspamd-Action: no action

Add the following compositions:

0x10a1: RNDIS + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  9 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a1 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=d128dba9
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=60 Driver=option
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

0x10a6: RNDIS + tty (AT/NMEA) + tty (AT) + tty (diag)
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10a6 Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=d128dba9
C:  #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
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

0x10ab: RNDIS + tty (AT) + tty (diag) + DPL (Data Packet Logging) + adb
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 11 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1bc7 ProdID=10ab Rev=05.15
S:  Manufacturer=Telit Cinterion
S:  Product=FN920
S:  SerialNumber=d128dba9
C:  #Ifs= 6 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=ef(misc ) Sub=04 Prot=01 Driver=rndis_host
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 4 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Cc: stable@vger.kernel.org
Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 9f2cc5fb9f45..d4505a426446 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1401,12 +1401,16 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a0, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a1, 0xff),	/* Telit FN20C04 (RNDIS) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a2, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a3, 0xff),	/* Telit FN920C04 (ECM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a4, 0xff),	/* Telit FN20C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a6, 0xff),	/* Telit FN920C04 (RNDIS) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a7, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10a8, 0xff),	/* Telit FN920C04 (ECM) */
@@ -1415,6 +1419,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10aa, 0xff),	/* Telit FN920C04 (MBIM) */
 	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10ab, 0xff),	/* Telit FN920C04 (RNDIS) */
+	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x30),	/* Telit FE990B (rmnet) */
 	  .driver_info = NCTRL(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b0, 0xff, 0xff, 0x40) },
-- 
2.52.0


