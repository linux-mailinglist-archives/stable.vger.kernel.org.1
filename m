Return-Path: <stable+bounces-123433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C775EA5C585
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C9C3A5BEF
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9125E824;
	Tue, 11 Mar 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VDbT1nA0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375D25D8EB;
	Tue, 11 Mar 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705941; cv=none; b=Sr0uqygx/vThIinQW8kNrmblLRMhbN6PpUtdjzYZmPPhlMbgHbIdfRzJtBA92EBemJARAVr8am4FFTJJKKRgRmINr7sphLwOFGLIi26OZzc1oj8+Ko4/msyOwg9ag25wULJEFuEtBOuLEMaFWxnutvj17kvmyIvZeMSGgkIXk4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705941; c=relaxed/simple;
	bh=4eG5LecITsrSL220s6JUDfMtn6Z+yn/cyiovBwj5qkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyqBWBNrBaI0EMcQlQsFrVa2HoyHOQI66ibMi9g2MtqQspDwq3xqDorlJ4kjNvyACMHhQTD0nfiEar65U+Dg0kkZSPvZMz9/gRcnR77BpbFDQ76vI3g72WHOT50KxGmOZcG/OdHVSRC62kUiAOyIWbho9LifD/pZRs4hghF6CbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VDbT1nA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD169C4CEE9;
	Tue, 11 Mar 2025 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705941;
	bh=4eG5LecITsrSL220s6JUDfMtn6Z+yn/cyiovBwj5qkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VDbT1nA0oP6IBLogeKSkyYtKAk4sVTbIK4eSdU/gQ5HEcPVrAEJVh8TchMG51dsWl
	 hb48XNcmxnvQ0TPHCj7wmlLoImkDxQiYS8eQuZB1PDdVrieEbwach3yRVQ3AEeTR2f
	 3npASIvSy/Hm0w+JMIW83nrn1MKcuEfpQO/W8ndk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 189/328] USB: serial: option: add MeiG Smart SLM828
Date: Tue, 11 Mar 2025 15:59:19 +0100
Message-ID: <20250311145722.408714078@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Chester A. Unal <chester.a.unal@arinc9.com>

commit db79e75460fc59b19f9c89d4b068e61cee59f37d upstream.

MeiG Smart SLM828 is an LTE-A CAT6 modem with the mPCIe form factor. The
"Cls=ff(vend.) Sub=10 Prot=02" and "Cls=ff(vend.) Sub=10 Prot=03"
interfaces respond to AT commands. Add these interfaces.

The product ID the modem uses is shared across multiple modems. Therefore,
add comments to describe which interface is used for which modem.

T:  Bus=01 Lev=01 Prnt=05 Port=01 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2dee ProdID=4d22 Rev=05.04
S:  Manufacturer=MEIG
S:  Product=LTE-A Module
S:  SerialNumber=4da7ec42
C:  #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=10 Prot=01 Driver=(none)
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=10 Prot=02 Driver=(none)
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=10 Prot=03 Driver=(none)
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=10 Prot=04 Driver=(none)
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=88(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=10 Prot=05 Driver=qmi_wwan
E:  Ad=0f(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Chester A. Unal <chester.a.unal@arinc9.com>
Link: https://lore.kernel.org/20250124-for-johan-meig-slm828-v2-1-6b4cd3f6344f@arinc9.com
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -621,7 +621,10 @@ static void option_instat_callback(struc
 
 /* MeiG Smart Technology products */
 #define MEIGSMART_VENDOR_ID			0x2dee
-/* MeiG Smart SRM815/SRM825L based on Qualcomm 315 */
+/*
+ * MeiG Smart SLM828, SRM815, and SRM825L use the same product ID. SLM828 is
+ * based on Qualcomm SDX12. SRM815 and SRM825L are based on Qualcomm 315.
+ */
 #define MEIGSMART_PRODUCT_SRM825L		0x4d22
 /* MeiG Smart SLM320 based on UNISOC UIS8910 */
 #define MEIGSMART_PRODUCT_SLM320		0x4d41
@@ -2405,10 +2408,12 @@ static const struct usb_device_id option
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0, 0) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0, 0) },	/* MeiG Smart SRM815 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0x10, 0x02) },	/* MeiG Smart SLM828 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0x10, 0x03) },	/* MeiG Smart SLM828 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },	/* MeiG Smart SRM815 and SRM825L */
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825L */
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825L */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
 	  .driver_info = NCTRL(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */



