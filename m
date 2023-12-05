Return-Path: <stable+bounces-4564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E3804804
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6CE281776
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7571A8C07;
	Tue,  5 Dec 2023 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sChf/3QZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE616FB0;
	Tue,  5 Dec 2023 03:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBBDC433C8;
	Tue,  5 Dec 2023 03:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747895;
	bh=STxGxxp/espNgw3wBEvnFRDqRwR5+nTbC/8Qw7Zduhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sChf/3QZ+j+yY7aQkuqdzQXi77++orK18bRSOfJYy4TMfYFEv3uGtj8LUx9MkUwBF
	 Za5IqpRumT4r6L4CtTcedeDg2gb/5exfVcb4gaCZCn5f33JdTb3K+4FFJr9jj1/xpb
	 Hpw94hUaMdOB3uPFMzY3fJQcUSQ/S1OlinlmL3Y4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yangyu Chen <cyy@cyyself.name>,
	Asuna Yang <SpriteOvO@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 37/94] USB: serial: option: add Luat Air72*U series products
Date: Tue,  5 Dec 2023 12:17:05 +0900
Message-ID: <20231205031524.962487111@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Asuna Yang <spriteovo@gmail.com>

commit da90e45d5afc4da2de7cd3ea7943d0f1baa47cc2 upstream.

Update the USB serial option driver support for Luat Air72*U series
products.

ID 1782:4e00 Spreadtrum Communications Inc. UNISOC-8910

T: Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 13 Spd=480 MxCh= 0
D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
P: Vendor=1782 ProdID=4e00 Rev=00.00
S: Manufacturer=UNISOC
S: Product=UNISOC-8910
C: #Ifs= 5 Cfg#= 1 Atr=e0 MxPwr=400mA
I: If#= 0 Alt= 0 #EPs= 1 Cls=e0(wlcon) Sub=01 Prot=03 Driver=rndis_host
E: Ad=82(I) Atr=03(Int.) MxPS= 8 Ivl=4096ms
I: If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=rndis_host
E: Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I: If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I: If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I: If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E: Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E: Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

If#= 2: AT
If#= 3: PPP + AT
If#= 4: Debug

Co-developed-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Asuna Yang <SpriteOvO@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -609,6 +609,8 @@ static void option_instat_callback(struc
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+/* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
+#define LUAT_PRODUCT_AIR720U			0x4e00
 
 /* Device flags */
 
@@ -2271,6 +2273,7 @@ static const struct usb_device_id option
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);



