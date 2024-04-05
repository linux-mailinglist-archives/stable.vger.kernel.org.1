Return-Path: <stable+bounces-35992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C9489951F
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79475B27586
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E543E249FA;
	Fri,  5 Apr 2024 06:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Cr2wnymL"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94705225AE;
	Fri,  5 Apr 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297651; cv=none; b=flZrxACw8LUCfg6TRvxksqHjR0e1Mf/gWPyCCzt8iBovZ21TPvzGZsdIvq1Kco6xscK/2xd0zQZrix7Fu4CmYDG/ADLw1Oj+Ph3uA6p7EhjkitNJfv2nT9aD8W476rH24dt8BOsq1Vs3J2Jgx2AS50WRgNzXoGMMfKCNdSIZ9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297651; c=relaxed/simple;
	bh=Y73ejoqOno5fyAe5OApfKn42Z9VgVEiazySE3cRTsU8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tGfHHt2CP6iRn8BkIkL/z5xTy3M+xSaggm6VYTbhCj+59aKX+9ynjJgI1mpOC0w3jsZflg+sSG7igAm4quAt0Aw7ObuJDP+m1Se3x+6R7HELGfbVP2KHbvdwM6xGRU8R1ORje5olIrxSIJPEsSRiYvJfjvQx2BRldpApCSbCKwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Cr2wnymL; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Reply-To:Subject:From:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=PiIR9uARf8/+ulKS9Us4quW+aLsEoxSn7m3WArQ8Wdk=;
	t=1712297649; x=1712729649; b=Cr2wnymLvvayoDtHXA18r+tMpItZLJ+o3Uj8z/lf/TGlAAi
	VcIE0XSE9KFOkOSPO4PNvnnj/Elkv+w8GZK/TskO06vjc+PYjy7EJCZWjh8GQAlddK1A8CXhxVBrf
	do6uO0/Ys3OUfnjQ6tu8dKQ3qknCBpNRsEY2HvGt+tYCOHrHw6BSgB1ymk8QmKd+QuC4wJJsBeytx
	8NmE0F0OFG1UzwRnqgWvPo5IvM8sPE6G6V+x73eYJ2f3tyFpndOmdeG5jn6YHFM8/4qkGiyo4FAcH
	IuwYuxEFUpcTqIZ1YZ+qI0A8v86x4X2QxIpAgk2oEquiU0wHhHVE5xiIRpnynpfw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rscpw-0005OI-1Z; Fri, 05 Apr 2024 08:14:04 +0200
Message-ID: <1d7c3e03-fb25-4891-87bb-f4e7b8b4ee30@leemhuis.info>
Date: Fri, 5 Apr 2024 08:14:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Subject: Re: [PATCH] serial: 8250_dw: Revert: Do not reclock if already at
 correct rate
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Peter Collingbourne <pcc@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
 stable@vger.kernel.org, VAMSHI GAJJELA <vamshigajjela@google.com>
References: <20240317214123.34482-1-hdegoede@redhat.com>
 <ZfgZEcg2RXSz08Gd@smile.fi.intel.com>
 <CAMn1gO4zPpwVDcv5FFiimG0MkGdni_0QRMoJH9SSA3LJAk7JqQ@mail.gmail.com>
 <35cdaf7e-ef32-470f-ab61-e5f4a3b35238@redhat.com>
 <33110d20-45d6-45b9-8af0-d3eac8c348b8@redhat.com>
 <CAMn1gO5-WD5wyPt+ZKDL-sRKhZvz1sUSPP-Mq59Do5kySpm=Sg@mail.gmail.com>
 <8cbe0f5f-0672-4bca-b539-8bff254c7c97@redhat.com>
 <2024032922-stipulate-skeleton-6f9c@gregkh>
Content-Language: en-US, de-DE
In-Reply-To: <2024032922-stipulate-skeleton-6f9c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712297649;8224f19b;
X-HE-SMSGID: 1rscpw-0005OI-1Z

On 29.03.24 13:12, Greg Kroah-Hartman wrote:
> On Fri, Mar 29, 2024 at 12:42:14PM +0100, Hans de Goede wrote:
>> On 3/29/24 3:35 AM, Peter Collingbourne wrote:
>>> On Thu, Mar 28, 2024 at 5:35 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>> On 3/28/24 8:10 AM, Hans de Goede wrote:
>>>>> On 3/18/24 7:52 PM, Peter Collingbourne wrote:
>>>>>> On Mon, Mar 18, 2024 at 3:36 AM Andy Shevchenko
>>>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>>
>>>>>>> On Sun, Mar 17, 2024 at 10:41:23PM +0100, Hans de Goede wrote:
>>>>>>>> Commit e5d6bd25f93d ("serial: 8250_dw: Do not reclock if already at
>>>>>>>> correct rate") breaks the dw UARTs on Intel Bay Trail (BYT) and
>>>>>>>> Cherry Trail (CHT) SoCs.
>>>>>>>>
>>>>>>>> Before this change the RTL8732BS Bluetooth HCI which is found
>>>>>>>> connected over the dw UART on both BYT and CHT boards works properly:
>>>>>>>>
>>>>>>>> Bluetooth: hci0: RTL: examining hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
>>>>>>>> Bluetooth: hci0: RTL: rom_version status=0 version=1
>>>>>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_fw.bin
>>>>>>>> Bluetooth: hci0: RTL: loading rtl_bt/rtl8723bs_config-OBDA8723.bin
>>>>>>>> Bluetooth: hci0: RTL: cfg_sz 64, total sz 24508
>>>>>>>> Bluetooth: hci0: RTL: fw version 0x365d462e
>>>>>>>>
>>>>>>>> where as after this change probing it fails:
> [...]
>>> Acked-by: Peter Collingbourne <pcc@google.com>
>>
>> Thanks. Greg can we get this merged please
>> (it is a regression fix for a 6.8 regression) ?
> 
> Will queue it up soon, thanks.

You are obviously busy (we really need to enhance Git so it can clone
humans, too!), nevertheless: friendly reminder that that fix afaics
still is not queued.

Side note: there is another fix for a serial 6.8 regression I track
waiting for review here:
https://lore.kernel.org/linux-serial/20240325071649.27040-1-tony@atomide.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

