Return-Path: <stable+bounces-91480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965329BEE2F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5523F282396
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F51F5828;
	Wed,  6 Nov 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ieYLv6qo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FE1F582D;
	Wed,  6 Nov 2024 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898854; cv=none; b=bxP+S2hnCJO2gDH1kbCteNnkNn049AIq3AWHreJmWm/ymD0uNO6THexn64QpXlDNumA0iuBoShexBTH8hVx9c/SJ0YnoJzEU/KqaLFT8aluIC3u9lKLBDfWiSbu5cmaWKWLeRP2HMFh4C5IpSW3cx1ym1b0lpRIpD/n02yaqWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898854; c=relaxed/simple;
	bh=VIpHFyor3f3vewDA1l9iMz6YmwhD0JLspmmQcbDSiHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIPcED6cyxFfgtkhWBqOZKpFWIfxWZfC1SHt6HVO9/uCbEfB4Fwi/1GEkhWGxpZ/Syyw/l8rdjd/F3yOCYaoKjSoAmWlIQXZP+0dQIcf7KjCB4kZFpD3VFrXsHN+lM7n9uBVr8IddLrQT/+ewq5cZMhCpaib1WhVR6nPf7kpp1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ieYLv6qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC23C4CECD;
	Wed,  6 Nov 2024 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898854;
	bh=VIpHFyor3f3vewDA1l9iMz6YmwhD0JLspmmQcbDSiHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ieYLv6qo6pVN7LAESuTxQzeiw565fIbdmY3ZIeLpnmEKDcKU+V9tySen6ekc1YSl4
	 yEZEWuVP22w2ikH2sLmCg+3hFw6fhCFYHnN0d5b1hXIalS34i0ZNuHO+Q7WdPuWjRI
	 0Y7tD6BEgy63jkYocAJzj6gbpTM6h4mrFdmT0Tzw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Benjamin B. Frost" <benjamin@geanix.com>,
	Lars Melin <larsm17@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.4 377/462] USB: serial: option: add support for Quectel EG916Q-GL
Date: Wed,  6 Nov 2024 13:04:30 +0100
Message-ID: <20241106120340.838722651@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

From: Benjamin B. Frost <benjamin@geanix.com>

commit 540eff5d7faf0c9330ec762da49df453263f7676 upstream.

Add Quectel EM916Q-GL with product ID 0x6007

T:  Bus=01 Lev=02 Prnt=02 Port=01 Cnt=01 Dev#=  3 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=6007 Rev= 2.00
S:  Manufacturer=Quectel
S:  Product=EG916Q-GL
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=200mA
A:  FirstIf#= 4 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=84(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
E:  Ad=88(I) Atr=03(Int.) MxPS=  32 Ivl=32ms
I:  If#= 5 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
I:* If#= 5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

MI_00 Quectel USB Diag Port
MI_01 Quectel USB NMEA Port
MI_02 Quectel USB AT Port
MI_03 Quectel USB Modem Port
MI_04 Quectel USB Net Port

Signed-off-by: Benjamin B. Frost <benjamin@geanix.com>
Reviewed-by: Lars Melin <larsm17@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -279,6 +279,7 @@ static void option_instat_callback(struc
 #define QUECTEL_PRODUCT_EG912Y			0x6001
 #define QUECTEL_PRODUCT_EC200S_CN		0x6002
 #define QUECTEL_PRODUCT_EC200A			0x6005
+#define QUECTEL_PRODUCT_EG916Q			0x6007
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
 #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
@@ -1270,6 +1271,7 @@ static const struct usb_device_id option
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG912Y, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EG916Q, 0xff, 0x00, 0x00) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },



