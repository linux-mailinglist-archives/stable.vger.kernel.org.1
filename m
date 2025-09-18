Return-Path: <stable+bounces-167622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171AB230F1
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C11567B9F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCE72F8BE7;
	Tue, 12 Aug 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c1JdnP/h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7702FE57D;
	Tue, 12 Aug 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021433; cv=none; b=roWJvYuvl6QqfRfGQPNVLkkvQwk7FnOR57MQXMPJXreCGRwb09eDKuxQuPj3g6Q/aleMHCA9sUdSCHpRzhRZuylYRSCQxKFeHqvIOmCIRz34nTRPejDkGvlLt2/7pCU6ZHwBZmeg3PbvxNAl4Z0m8k47oMrUqRlYtuSAfeqd57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021433; c=relaxed/simple;
	bh=jkBvDnVBgmY5H7+dZR+XjMdXKr2kQoxBFDTs9+V6Xbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duT637jxBMRKpjLSikc16BLdUDZa9K4koJBEKvm5rRoL0cNit2CaUmvCiIL3/PBa0NcAK5Zf+109yv3kSiufXFUYXZmxeCHoxYxxa6MeMUdLKpA8M7MSwQ7Q2xIJZDli3eApslO1jsBwmTdVIOXFNaX2kOa17aIWHi9wYaTBZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c1JdnP/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD0DC4CEF0;
	Tue, 12 Aug 2025 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021433;
	bh=jkBvDnVBgmY5H7+dZR+XjMdXKr2kQoxBFDTs9+V6Xbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c1JdnP/h+EFe/CB5P9Fhmg8Gc2n5b/bySu7BNGNvMRxH7s17GPPbHfOncDIwYqKVp
	 xaw0lj20SirehumTm3qLwZsw6Z0c0c+ypAwGKyh6h02UVzuqr55eYbHF0Wxe3/FMfC
	 +BYOE1vQbMo8jUnzREyIofocv2VtplNUwgMgLrt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Slark Xiao <slark_xiao@163.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.1 244/253] USB: serial: option: add Foxconn T99W709
Date: Tue, 12 Aug 2025 19:30:32 +0200
Message-ID: <20250812172959.242567843@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Slark Xiao <slark_xiao@163.com>

commit ad1244e1ce18f8c1a5ebad8074bfcf10eacb0311 upstream.

T99W709 is designed based on MTK T300(5G redcap) chip. There are
7 serial ports to be enumerated: AP_LOG, GNSS, AP_META, AT,
MD_META, NPT, DBG. RSVD(5) for ADB port.

test evidence as below:
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  7 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e15f Rev=00.01
S:  Manufacturer=MediaTek Inc.
S:  Product=USB DATA CARD
S:  SerialNumber=355511220000399
C:  #Ifs=10 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0e Prot=00 Driver=cdc_mbim
I:  If#=0x1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:  If#=0x2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
I:  If#=0x6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
I:  If#=0x9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2346,6 +2346,8 @@ static const struct usb_device_id option
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe145, 0xff),			/* Foxconn T99W651 RNDIS */
 	  .driver_info = RSVD(5) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe15f, 0xff),                     /* Foxconn T99W709 */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe167, 0xff),                     /* Foxconn T99W640 MBIM */
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */



