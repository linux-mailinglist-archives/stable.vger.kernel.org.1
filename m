Return-Path: <stable+bounces-181834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD9BA690C
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 08:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EFC189BE7D
	for <lists+stable@lfdr.de>; Sun, 28 Sep 2025 06:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5641A2248AF;
	Sun, 28 Sep 2025 06:35:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105A1A4E70;
	Sun, 28 Sep 2025 06:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041334; cv=none; b=uhogGDzFrNTN9u8JdG/aPM/FCt8x5JVVD1VI1WKgF15twVOrWIj1iYDIQmP/aFUnLLz3riUTisTEe08/nVg/J8ag/1SdDbepvt+4EEW9Pr1OBDXXdgAK77W4s1IzDWB4F6WsqFuHAXizX9aZHW13vxUvDl6asgAmWpZ8BR/8awc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041334; c=relaxed/simple;
	bh=DSNKMpV8F3KeakZPHjRs+ttvKjFPIl4OFROBeTzGsGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WV5ewBUiX/DcmLSGJOE/L81Mt9zo7ruX5g2wdLmpJZIrbcS9o3RqE7RTE/Q/3E85RZ4r5IqU/2CkvIOOCCA9gPXyIRExe3S4IIRl0tpzSynft9Es6LpAjHPh0ABzXyPOc130A66rMr9SVTtMjszwOm8vvXVYcia2rfd4yPaU2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.205] (p57bd9782.dip0.t-ipconnect.de [87.189.151.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5DCEA6028F35A;
	Sun, 28 Sep 2025 08:35:18 +0200 (CEST)
Message-ID: <93c06dea-1e93-4981-bd69-b84f8573fa66@molgen.mpg.de>
Date: Sun, 28 Sep 2025 08:35:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add one more ID 0x13d3:0x3612 for
 Realtek 8852CE
To: Levi Zim <rsworktech@outlook.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250927-ble-13d3-3612-v1-1-c62bbb0bc77c@outlook.com>
 <7926abe4-f824-4ff3-808e-e31b7869a7d6@molgen.mpg.de>
 <SY4P282MB2313F04E53A4381F5EE422E2C618A@SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SY4P282MB2313F04E53A4381F5EE422E2C618A@SY4P282MB2313.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Levi,


Thank you for your reply.

Am 28.09.25 um 06:41 schrieb Levi Zim:

> On 9/27/25 10:25 PM, Paul Menzel wrote:

>> For the summary/title “one more” is not necessary.
>>
> I just blindly followed the format of the last commit that touches that 
> file. > Should I send a V2 with “one more” removed?

No need to resend from my side.

>> Am 27.09.25 um 04:29 schrieb Levi Zim via B4 Relay:
>>> From: Levi Zim <rsworktech@outlook.com>
>>>
>>> Devices with ID 13d3:3612 are found in ASUS TUF Gaming A16 (2025)
>>> and ASUS TX Gaming FA608FM.
>>>
>>> The corresponding device info from /sys/kernel/debug/usb/devices is
>>>
>>> T:  Bus=03 Lev=02 Prnt=03 Port=02 Cnt=02 Dev#=  6 Spd=12 MxCh= 0
>>> D:  Ver= 1.00 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
>>> P:  Vendor=13d3 ProdID=3612 Rev= 0.00
>>> S:  Manufacturer=Realtek
>>> S:  Product=Bluetooth Radio
>>> C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
>>> I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>>> I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
>>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
>>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
>>> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
>>> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
>>> I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
>>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
>>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
>>>
>>> Signed-off-by: Levi Zim <rsworktech@outlook.com>
>>> ---
>>>   drivers/bluetooth/btusb.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>>> index 
>>> 8085fabadde8ff01171783b59226589757bbbbbc..d1e62b3158166a33153a6dfaade03fd3fb7d8231 100644
>>> --- a/drivers/bluetooth/btusb.c
>>> +++ b/drivers/bluetooth/btusb.c
>>> @@ -552,6 +552,8 @@ static const struct usb_device_id quirks_table[] = {
>>>                                BTUSB_WIDEBAND_SPEECH },
>>>       { USB_DEVICE(0x13d3, 0x3592), .driver_info = BTUSB_REALTEK |
>>>                                BTUSB_WIDEBAND_SPEECH },
>>> +    { USB_DEVICE(0x13d3, 0x3612), .driver_info = BTUSB_REALTEK |
>>> +                             BTUSB_WIDEBAND_SPEECH },
>>>       { USB_DEVICE(0x0489, 0xe122), .driver_info = BTUSB_REALTEK |
>>>                                BTUSB_WIDEBAND_SPEECH },
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

