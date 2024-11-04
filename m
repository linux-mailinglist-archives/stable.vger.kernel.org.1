Return-Path: <stable+bounces-89705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0229BB70B
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9030E1C22077
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE42E1534E6;
	Mon,  4 Nov 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNv9aOuc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823479FD;
	Mon,  4 Nov 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729033; cv=none; b=TW4WFyU688V9XWk2SjHSH7zLcnmyRosWcx4BkJGdNMmbQhydPilXAfLZT4UfxJCKsIku3Lx6mZ/uy70zzh6yfLkSN+HuAuQ5qAYV9ehPbqmW+DBFji6r1PClEteYEodzKHp2oYxt2Ev5bCWIpUvt55RVv7TZ+Yu1icpfvyFN+SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729033; c=relaxed/simple;
	bh=Es7SovyKCYcHYnpFDoSqTBsJx27R1XCshX7bTOsxyh8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dPRC9N2acGqP9IwSyttVJ7GmFistEEXLZUe25Du1JWFcQtKiAR8SCFBoKTzbqkxNT2M+DU/4PCJ/ZouUepSFbRd8ADLxEG+mh8lL8g1yOFgHKBgkI1HLYuXB9wQ86WwF3sq0EBIwWYFVBx/X+28wZl3N1TaY5rvmIvZiDTjMjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNv9aOuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD533C4CED5;
	Mon,  4 Nov 2024 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729032;
	bh=Es7SovyKCYcHYnpFDoSqTBsJx27R1XCshX7bTOsxyh8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SNv9aOucuUvEb0ZqFsqDoEuekZ2vVS0HRIq43+q9nBZvv7AnIKCCOC8lPOyEVMRMI
	 Ghkk61OA3BtGSlLXzLm9tBNokmtp795r3/W866XqChiGx+59eN9bJpXNBGl8RAxtRY
	 9YmbwOiog5c8SbeX/Zcyrz9JwVgpDgtyAFfKW3Vk4Y0aosLv1zMw/g2oMAeGqKhH81
	 PJpsheLiJrdJTN5j1sMzTpAlBBQxmbBrc3NTj69EApVPfeTu+hhQSmD3wk3yLH9aKZ
	 bPCF96n+XhblXHQZzhYSE/v9twxiiUpg/EIW6l1B8OOEQx5wVHmcwvk7AJZejas9Bd
	 l05216w+8GvHQ==
Message-ID: <6c06456c-0501-45ec-95b4-324f45ae2c5b@kernel.org>
Date: Mon, 4 Nov 2024 16:03:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: core: Fix system suspend on TI AM62
 platforms
From: Roger Quadros <rogerq@kernel.org>
To: William McVicker <willmcvicker@google.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Chris Morgan <macroalpha82@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Dhruva Gole <d-gole@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 msp@baylibre.com, srk@ti.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-usb@vger.kernel.org, stable@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20241011-am62-lpm-usb-v3-1-562d445625b5@kernel.org>
 <ZyVfcUuPq56R2m1Y@google.com>
 <f35aa5a1-96fd-4e9a-9ecc-5e900d440d4c@kernel.org>
 <8df97a64-ab88-4bc6-b015-3995546172a7@kernel.org>
 <dc534e9f-05c3-4f42-afdb-7d7cbe8cac6d@kernel.org>
Content-Language: en-US
In-Reply-To: <dc534e9f-05c3-4f42-afdb-7d7cbe8cac6d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 04/11/2024 14:30, Roger Quadros wrote:
> Hi,
> 
> On 02/11/2024 14:34, Roger Quadros wrote:
>> Hi William & Chris,
>>
>> On 02/11/2024 13:50, Roger Quadros wrote:
>>> Hi William,
>>>
>>> On 02/11/2024 01:08, William McVicker wrote:
>>>> +linux-arm-msm@vger.kernel.org
>>>>
>>>> Hi Roger,
>>>>
>>>> On 10/11/2024, Roger Quadros wrote:
>>>>> Since commit 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init"),
>>>>> system suspend is broken on AM62 TI platforms.
>>>>>
>>>>> Before that commit, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
>>>>> bits (hence forth called 2 SUSPHY bits) were being set during core
>>>>> initialization and even during core re-initialization after a system
>>>>> suspend/resume.
>>>>>
>>>>> These bits are required to be set for system suspend/resume to work correctly
>>>>> on AM62 platforms.
>>>>>
>>>>> Since that commit, the 2 SUSPHY bits are not set for DEVICE/OTG mode if gadget
>>>>> driver is not loaded and started.
>>>>> For Host mode, the 2 SUSPHY bits are set before the first system suspend but
>>>>> get cleared at system resume during core re-init and are never set again.
>>>>>
>>>>> This patch resovles these two issues by ensuring the 2 SUSPHY bits are set
>>>>> before system suspend and restored to the original state during system resume.
>>>>>
>>>>> Cc: stable@vger.kernel.org # v6.9+
>>>>> Fixes: 6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")
>>>>> Link: https://lore.kernel.org/all/1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org/
>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>>>> ---
>>>>> Changes in v3:
>>>>> - Fix single line comment style
>>>>> - add DWC3_GUSB3PIPECTL_SUSPHY to documentation of susphy_state
>>>>> - Added Acked-by tag
>>>>> - Link to v2: https://lore.kernel.org/r/20241009-am62-lpm-usb-v2-1-da26c0cd2b1e@kernel.org
>>>>>
>>>>> Changes in v2:
>>>>> - Fix comment style
>>>>> - Use both USB3 and USB2 SUSPHY bits to determine susphy_state during system suspend/resume.
>>>>> - Restore SUSPHY bits at system resume regardless if it was set or cleared before system suspend.
>>>>> - Link to v1: https://lore.kernel.org/r/20241001-am62-lpm-usb-v1-1-9916b71165f7@kernel.org
>>>>> ---
>>>>>  drivers/usb/dwc3/core.c | 19 +++++++++++++++++++
>>>>>  drivers/usb/dwc3/core.h |  3 +++
>>>>>  2 files changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>>> index 9eb085f359ce..ca77f0b186c4 100644
>>>>> --- a/drivers/usb/dwc3/core.c
>>>>> +++ b/drivers/usb/dwc3/core.c
>>>>> @@ -2336,6 +2336,11 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>>>>  	u32 reg;
>>>>>  	int i;
>>>>>  
>>>>> +	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
>>>>> +			    DWC3_GUSB2PHYCFG_SUSPHY) ||
>>>>> +			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
>>>>> +			    DWC3_GUSB3PIPECTL_SUSPHY);
>>>>> +
>>>>
>>>> I'm running into an issue on my Pixel 6 device with this change when the
>>>> dwc3-exynos device has runtime PM enabled. Basically, after the device boots up
>>>> and I disconnect USB, the dwc3-exynos device enters runtime suspend followed by
>>>> system suspend 15 seconds later. On system suspend, the clocks powering these
>>>> dwc3 registers are off which results in an SError. I have verified that
>>>> reverting this change fixes the issue.
>>>>
>>>> I noticed that dwc3-qcom.c also supports runtime PM for their dwc3 device and
>>>> most likely is affected by this as well. It would be great if someone with a
>>>> Qualcomm device could test out dwc3 suspend as well.
>>>
>>> Chris was facing another issue with this patch on Rockchip RK3566 [1]
>>>
>>> Looks like we totally missed the runtime suspended case
>>> I'll think about a solution and send something by today.
>>>
>>> [1] - https://lore.kernel.org/all/671bef75.050a0220.e4bcd.1821@mx.google.com/
>>>
>>>>
>>>> Here is the crash stack:
>>>>
>>>>   SError Interrupt on CPU7, code 0x00000000be000011 -- SError
>>>>   CPU: 7 UID: 1000 PID: 5661 Comm: binder:477_1 Tainted: G        W  OE      6.12.0-rc3-android16-0-maybe-dirty-4k #1 0439eacb3cff642033630df7ee2e250e0625f2f0
>>>>   96 irq, BUS_DATA0 group, 0x0
>>>>   Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>>>   Hardware name: Raven DVT (DT)
>>>>   pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>   pc : readl+0x40/0x80
>>>>   lr : readl+0x38/0x80
>>>>   sp : ffffffc08baa39a0
>>>>   x29: ffffffc08baa39a0 x28: ffffffd4dd140000 x27: ffffffd4dd140d70
>>>>   x26: ffffffd4dd2b2000 x25: ffffff800cef2410 x24: ffffff800cef24c0
>>>>   x23: ffffffd4dd24e000 x22: ffffff887df59440 x21: ffffffc085298100
>>>>   x20: ffffffd4db8acf60 x19: ffffffc085298200 x18: ffffffc091b730b0
>>>>   x17: 000000002a703c0b x16: 000000002a703c0b x15: 0000000000953000
>>>>   x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
>>>>   x11: 7f7f7f7f7f7fffff x10: 0000000000000000 x9 : ffffffd4dc0d7d48
>>>>   x8 : 0000000000000000 x7 : 0000000000008000 x6 : 0000000000000000
>>>>   x5 : 500020737562ffff x4 : 500020737562ffff x3 : ffffffd4db8acf60
>>>>   x2 : ffffffd4db8a7bac x1 : ffffffc085298200 x0 : 0000000000000020
>>>>   Kernel panic - not syncing: Asynchronous SError Interrupt
>>>>   CPU: 7 UID: 1000 PID: 5661 Comm: binder:477_1 Tainted: G        W  OE      6.12.0-rc3-android16-0-maybe-dirty-4k #1 0439eacb3cff642033630df7ee2e250e0625f2f0
>>>>   Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>>>   Hardware name: Raven DVT (DT)
>>>>   Call trace:
>>>>    dump_backtrace+0xec/0x128
>>>>    show_stack+0x18/0x28
>>>>    dump_stack_lvl+0x40/0x88
>>>>    dump_stack+0x18/0x24
>>>>    panic+0x134/0x45c
>>>>    nmi_panic+0x3c/0x88
>>>>    arm64_serror_panic+0x64/0x8c
>>>>    do_serror+0xc4/0xc8
>>>>    el1h_64_error_handler+0x34/0x48
>>>>    el1h_64_error+0x68/0x6c
>>>>    readl+0x40/0x80
>>>>    dwc3_suspend_common+0x34/0x454
>>>>    dwc3_suspend+0x20/0x40
>>>>    platform_pm_suspend+0x40/0x90
>>>>    dpm_run_callback+0x60/0x250
>>>>    device_suspend+0x334/0x614
>>>>    dpm_suspend+0xc4/0x368
>>>>    dpm_suspend_start+0x90/0x100
>>>>    suspend_devices_and_enter+0x128/0xad0
>>>>    pm_suspend+0x354/0x650
>>>>    state_store+0x104/0x144
>>>>    kobj_attr_store+0x30/0x48
>>>>    sysfs_kf_write+0x54/0x6c
>>>>    kernfs_fop_write_iter+0x104/0x1e4
>>>>    vfs_write+0x3bc/0x50c
>>>>    ksys_write+0x78/0xe8
>>>>    __arm64_sys_write+0x1c/0x2c
>>>>    invoke_syscall+0x58/0x10c
>>>>    el0_svc_common+0xa8/0xdc
>>>>    do_el0_svc+0x1c/0x28
>>>>    el0_svc+0x38/0x6c
>>>>    el0t_64_sync_handler+0x70/0xbc
>>>>    el0t_64_sync+0x1a8/0x1ac
>>>>
>>
>> Does this patch fix it for you?
>>
>> From ee8b353523556a29a423261af9c15be261941ff8 Mon Sep 17 00:00:00 2001
>> From: Roger Quadros <rogerq@kernel.org>
>> Date: Sat, 2 Nov 2024 14:14:47 +0200
>> Subject: [PATCH] usb: dwc3: fix fault at system suspend if device was already
>>  runtime suspended
>>
>> If the device was already runtime suspended then during system suspend
>> we cannot access the device registers else it will crash.
>>
>> Cc: stable@vger.kernel.org # v5.15+
>> Reported-by: William McVicker <willmcvicker@google.com>
>> Closes: https://lore.kernel.org/all/ZyVfcUuPq56R2m1Y@google.com
>> Fixes: 705e3ce37bcc ("usb: dwc3: core: Fix system suspend on TI AM62 platforms")
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/usb/dwc3/core.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 427e5660f87c..4933f1b4d9c6 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -2342,10 +2342,12 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>  	u32 reg;
>>  	int i;
>>  
>> -	dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
>> -			    DWC3_GUSB2PHYCFG_SUSPHY) ||
>> -			    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
>> -			    DWC3_GUSB3PIPECTL_SUSPHY);
>> +	if (!pm_runtime_suspended(dwc->dev)) {
>> +		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
>> +				    DWC3_GUSB2PHYCFG_SUSPHY) ||
>> +				    (dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0)) &
>> +				    DWC3_GUSB3PIPECTL_SUSPHY);
>> +	}
>>  
>>  	switch (dwc->current_dr_role) {
>>  	case DWC3_GCTL_PRTCAP_DEVICE:
>>
>> base-commit: 4b57d665bce1306a2a887cb760aa0c0e7efb42ab
> 
> I think this is not sufficient to fix the issue as there is still a call
> to dwc3_enable_susphy() in the end which needs to be avoided
> if already runtime suspended.
> 

I've sent a new patch [1]. Please test and give your feedback there. Thanks.

[1]- https://lore.kernel.org/all/20241104-am62-lpm-usb-fix-v1-1-e93df73a4f0d@kernel.org/

-- 
cheers,
-roger

