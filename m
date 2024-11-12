Return-Path: <stable+bounces-92741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C09C5810
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DCCDB25919
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3821A71F;
	Tue, 12 Nov 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZxRlVyUE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4A21A704;
	Tue, 12 Nov 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408439; cv=none; b=BgIpYI76sKBHGh95OV/pIUfpn9BqL0Nvoo1S+hi+cCvth4fZUwt4FCRz5L6DBX3ryTOGxtkwux/aEMY+3EHOVzDY48W4ftNm8DL1/YO0w42a4jdf/TpqjRayYl20f9G5S34NY7ZDr3uTEyII6hvj5ReLYsngdNkBu/l+PGU7FN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408439; c=relaxed/simple;
	bh=kNnGE5VZHjB0IKAFTvr3DDiGnJnXNUOQR/fdF0I/LSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4KM6sm+m32NSeVx3PgmFJ8pybJoDV8HQ2UPnr4KbOzAnJvfoYa4MAjWJhxntR+8iNwM6NSpAkyll/LdtHjXptnCC75J3gg2hWYnINGfQcmCb8AdyQrP70aVlWulrBNEjHxnJQAKiL66V7N16gMdmaE1bVN5DKFX8XL4v5I9Loc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZxRlVyUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACB7C4CECD;
	Tue, 12 Nov 2024 10:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408438;
	bh=kNnGE5VZHjB0IKAFTvr3DDiGnJnXNUOQR/fdF0I/LSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZxRlVyUEHSquQo2dJfglX12Ha8RjDC6BaENu3jh5cRUQyka6U2loU0eLUNO44x3kd
	 hvblWysKQgHyG+vJOy6dcIUlsem8lrYP53+GZ95acDSWwqEEBrPxOOCZeXE+FwNT/V
	 ojTfXNK4tDYFF4sezUGHXSXv/NEX1JxiwbeTpgz8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jack Wu <wojackbb@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.11 161/184] USB: serial: qcserial: add support for Sierra Wireless EM86xx
Date: Tue, 12 Nov 2024 11:21:59 +0100
Message-ID: <20241112101907.048522927@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Wu <wojackbb@gmail.com>

commit 25eb47eed52979c2f5eee3f37e6c67714e02c49c upstream.

Add support for Sierra Wireless EM86xx with USB-id 0x1199:0x90e5 and
0x1199:0x90e4.

0x1199:0x90e5
T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 14 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1199 ProdID=90e5 Rev= 5.15
S:  Manufacturer=Sierra Wireless, Incorporated
S:  Product=Semtech EM8695 Mobile Broadband Adapter
S:  SerialNumber=004403161882339
C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
A:  FirstIf#=12 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=qcserial
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=qcserial
E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 4 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=85(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:* If#=12 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=87(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#=13 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#=13 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

0x1199:0x90e4
T:  Bus=03 Lev=01 Prnt=01 Port=05 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1199 ProdID=90e4 Rev= 0.00
S:  Manufacturer=Sierra Wireless, Incorporated
S:  SerialNumber=004403161882339
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=10 Driver=qcserial
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Jack Wu <wojackbb@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/qcserial.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -166,6 +166,8 @@ static const struct usb_device_id id_tab
 	{DEVICE_SWI(0x1199, 0x9090)},	/* Sierra Wireless EM7565 QDL */
 	{DEVICE_SWI(0x1199, 0x9091)},	/* Sierra Wireless EM7565 */
 	{DEVICE_SWI(0x1199, 0x90d2)},	/* Sierra Wireless EM9191 QDL */
+	{DEVICE_SWI(0x1199, 0x90e4)},	/* Sierra Wireless EM86xx QDL*/
+	{DEVICE_SWI(0x1199, 0x90e5)},	/* Sierra Wireless EM86xx */
 	{DEVICE_SWI(0x1199, 0xc080)},	/* Sierra Wireless EM7590 QDL */
 	{DEVICE_SWI(0x1199, 0xc081)},	/* Sierra Wireless EM7590 */
 	{DEVICE_SWI(0x413c, 0x81a2)},	/* Dell Wireless 5806 Gobi(TM) 4G LTE Mobile Broadband Card */



