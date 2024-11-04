Return-Path: <stable+bounces-89736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABB9BBCCD
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 19:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5901C21DF3
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525E1C9B62;
	Mon,  4 Nov 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=581238.xyz header.i=@581238.xyz header.b="E34K4cFY"
X-Original-To: stable@vger.kernel.org
Received: from mail.581238.xyz (86-95-37-93.fixed.kpn.net [86.95.37.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D36F224F0;
	Mon,  4 Nov 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=86.95.37.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743457; cv=none; b=PaaTLPHzfCIgR2UxLBkPNgO5hqnXJOvHUWcLVY+EK711DmnO+dU1FOFmrvJTVyj2wYN+GVxXRYtr2/JsTFoJh/yPm66uTArZsw9VkAoiusWbVT7+bQdgMX94DxV6UakZd+VPiIBvjWkoIALLv3C8VHw7CvvQclEDpadpW5EUqNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743457; c=relaxed/simple;
	bh=xRTNzfFTI3aprmS1lYPw3G8pOeLW/95DsCDLNygQfsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtEfi8HvCczsoKWykbwdRkn7zDT281AozHT+9dluo/eARj+QuCRN6bPIqg1Hn2x0EaHjgNbw7xyRnYtSKT05evJPk6LDy0OYiCcKSbG47ZuXcHIJLVfbSoOBi0pJiemK/i/qynJVkwHy8mByx+Mn9+2L4fSbpX1EymzhU2Bxm18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=581238.xyz; spf=pass smtp.mailfrom=581238.xyz; dkim=pass (1024-bit key) header.d=581238.xyz header.i=@581238.xyz header.b=E34K4cFY; arc=none smtp.client-ip=86.95.37.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=581238.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=581238.xyz
Received: from [192.168.1.14] (Laptop.internal [192.168.1.14])
	by mail.581238.xyz (Postfix) with ESMTPSA id 3FE9A43088F3;
	Mon, 04 Nov 2024 19:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=581238.xyz; s=dkim;
	t=1730743448; bh=xRTNzfFTI3aprmS1lYPw3G8pOeLW/95DsCDLNygQfsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E34K4cFYy0+unzM4WEGwLRxS3TAkBuHcsVqiuLL8WXwmX1O7Kq+Tsvnm8D3gmM32V
	 bmdEoMXjj5EmnlF9F87fAUV0spik7PrOnbHu4q+eyWTw9mtoq34ys4t/rvSBgWJgbj
	 YAcVSexb1OGeLqDJ9qKUapBj//H69imHCJsDFLWo=
Message-ID: <effdfd51-66dd-44a4-968c-0f762ab8f93b@581238.xyz>
Date: Mon, 4 Nov 2024 19:04:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Sanath.S@amd.com,
 christian@heusel.eu, fabian@fstab.de, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <96560f8e-ab9f-4036-9b4d-6ff327de5382@amd.com>
 <22415e85-9397-42db-9030-43fc5f1c7b35@581238.xyz>
 <20241022161055.GE275077@black.fi.intel.com>
 <7f14476b-8084-4c43-81ec-e31ae3f7a3c6@581238.xyz>
 <20241023061001.GF275077@black.fi.intel.com>
 <4848c9fe-877f-4d73-84d6-e2249bb49840@581238.xyz>
 <20241028081813.GN275077@black.fi.intel.com>
 <2c27683e-aca8-48d0-9c63-f0771c6a7107@581238.xyz>
 <20241030090625.GS275077@black.fi.intel.com>
 <70d8b6b2-04b4-48a6-964d-a957b2766617@581238.xyz>
 <20241104063656.GZ275077@black.fi.intel.com>
Content-Language: en-US
From: Rick <rick@581238.xyz>
Autocrypt: addr=rick@581238.xyz; keydata=
 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
In-Reply-To: <20241104063656.GZ275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mika

On 04-11-2024 07:36, Mika Westerberg wrote:
> Hi Rick,
> 
> On Fri, Nov 01, 2024 at 01:57:50PM +0100, Rick wrote:
>> I compiled 6.12.0-rc5-00181-g6c52d4da1c74-dirty resulting in docking station
>> not working.
>>
>> Then I compiled 6.12.0-rc5-00181-g6c52d4da1c74-dirty without commit
>> c6ca1ac9f472 (reverted), and now the docking station works correctly (as in
>> screen output + USBs + Ethernet)
>>
>> So it seems c6ca1ac9f472 is causing issues for my setup.
> 
> Okay, thanks for testing!
> 
> It indeed looks like there is no any kind of link issues anymore with
> that one reverted. So my suspect is that we are taking too long before
> we enumerate the device router which makes it to reset the link.
> 
> Can you try the below patch too on top of v6.12-rcX (without the revert)
> and see if that still keeps it working? This one cuts down the delay to
> 1ms which I'm hoping is sufficient for the device. Can you share
> dmesg+trace from that test as well?
> 
> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> index c6dcc23e8c16..1b740d7fc7da 100644
> --- a/drivers/thunderbolt/usb4.c
> +++ b/drivers/thunderbolt/usb4.c
> @@ -48,7 +48,7 @@ enum usb4_ba_index {
>   
>   /* Delays in us used with usb4_port_wait_for_bit() */
>   #define USB4_PORT_DELAY			50
> -#define USB4_PORT_SB_DELAY		5000
> +#define USB4_PORT_SB_DELAY		1000
>   
>   static int usb4_native_switch_op(struct tb_switch *sw, u16 opcode,
>   				 u32 *metadata, u8 *status,

See below pasts without the revert, and with the above provided patch.

dmesg with patch (and without the revert): 
https://gist.github.com/ricklahaye/8412af228063546dd8375ca796fffeef
tbtrace with patch (and without the revert): 
https://gist.github.com/ricklahaye/4b9cbeeb36b546c6686ce79a044a2d61

Seems to be working correctly with the provided patch.
Thank you!

Kind regards,
Rick

