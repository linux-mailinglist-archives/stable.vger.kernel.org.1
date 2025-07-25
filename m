Return-Path: <stable+bounces-164772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D282DB1266A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3BF17B6DF1
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 22:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE9B2367B7;
	Fri, 25 Jul 2025 22:02:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431401DE892;
	Fri, 25 Jul 2025 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753480928; cv=none; b=gHlgd3RuTePiXaKzjvr8rCDNbVupQbhGfrmf9fdd7yWphuUUJNAHdQth6UHNWG9oWVnClplgml5wpgkflftbJVm7yNfi1oq64YYg68SqLsCbTV5M47qlnzHi/5qeZwKl1Jxq/UmT+i3kBcf1ZGteMWxM6UCUQnjElx9opLWDMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753480928; c=relaxed/simple;
	bh=GnglZ0b04kKrNto5bDI5PFafyFbK9Qb0DQrrkAtwt0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8fqCAJn4XI/EDP2Gmg25iV5oCKX6hDlAij1CKdtgPOinD6kiWFVrkZrZOY5eohNxP9oJo40c4heu0OqkE3v/to+9wxz7G+mCK9qefDvZDCktUjHN0Jjto+6ZVEDX6zQNILuj6mXQgdZib2UFH9H5UtyyVhSAw/P8p5mkzc+3m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5dc557dd.dip0.t-ipconnect.de [93.197.87.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 11ADB61E64848;
	Sat, 26 Jul 2025 00:01:38 +0200 (CEST)
Message-ID: <947f69ec-c66d-4182-aa96-e3e320760131@molgen.mpg.de>
Date: Sat, 26 Jul 2025 00:01:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 2001:332a for D-Link AX9U
 rev. A1
To: Zenm Chen <zenmchen@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, pkshih@realtek.com,
 hildawu@realtek.com, max.chou@realtek.com, rtl8821cerfe2@gmail.com,
 usbwifi2024@gmail.com, stable@vger.kernel.org
References: <20250725161432.5401-1-zenmchen@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250725161432.5401-1-zenmchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chen,


Thank you for your patch.

Am 25.07.25 um 18:14 schrieb Zenm Chen:
> Add USB ID 2001:332a for D-Link AX9U rev. A1 which is based on a Realtek
> RTL8851BU chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=2001 ProdID=332a Rev= 0.00
> S:  Manufacturer=Realtek
> S:  Product=802.11ax WLAN Adapter
> S:  SerialNumber=00e04c000001
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=500mA
> A:  FirstIf#= 0 IfCount= 2 Cls=e0(wlcon) Sub=01 Prot=01
> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
> I:* If#= 2 Alt= 0 #EPs= 8 Cls=ff(vend.) Sub=ff Prot=ff Driver=rtw89_8851bu_git
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0b(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=0c(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
>   drivers/bluetooth/btusb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8085fabad..3595a8bad 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -522,6 +522,8 @@ static const struct usb_device_id quirks_table[] = {
>   	/* Realtek 8851BU Bluetooth devices */
>   	{ USB_DEVICE(0x3625, 0x010b), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x2001, 0x332a), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_WIDEBAND_SPEECH },

I’d sort according to `USB_DEVICE(0x2001`.

>   
>   	/* Realtek 8852AE Bluetooth devices */
>   	{ USB_DEVICE(0x0bda, 0x2852), .driver_info = BTUSB_REALTEK |

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

