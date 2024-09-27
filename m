Return-Path: <stable+bounces-77895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385AE9881E1
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 11:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954D0B2184F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 09:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6928F1BB6B3;
	Fri, 27 Sep 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SewGu2qO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261871BB6AC;
	Fri, 27 Sep 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430744; cv=none; b=qpJSvjnewvfjLe7ChmWFfCGa1GAcKtaqOWRQIQXtlB4EtInAJyBtkQ6uS53KsJZA4chXpceH1Nr76qGRgsLsIlGViArUOi2LsrUESzIIll3w/WDLo+0+x+ibK+n+XvPlwrP3zLOxszzxl9sO+dxZa/BPFxSqVpcpiMKx76xqALg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430744; c=relaxed/simple;
	bh=gh3HxbhmkIkR+faLyEwUhDkIWcudrr+ZDgyMz+iog4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emO00tgFY4ff5b9uV1OWHYP0oMIMAtdRvJhDHofPnYEiOkx4xCvMcXmVHM+H1ZQeMMmfAUjVpHRfqJh9eQh9XloXC0dmqR0B1+6tMB7UxB+g2CCxl60VavNkOW9grhvd07VFiEnoKdYrfgGvYTbhy89uOvJdX0dej4iUUflsizY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SewGu2qO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F44C4CECD;
	Fri, 27 Sep 2024 09:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727430743;
	bh=gh3HxbhmkIkR+faLyEwUhDkIWcudrr+ZDgyMz+iog4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SewGu2qO24Wsq/Fqb0IZJkF5HlreubY1jzAYEEJm8J/VeGUr5QwmaoM88wz9uF2Io
	 f5jtKwb1lqm0uvLuzDvMYqC9Mnu/HxLmlMMbfx0kBWM6TA9PRxymTDpD7KPBSnxtD9
	 SxPzl15FRpGXdRLqDRJ2Kr3EQW9OB2YY4yx689Ae1cXgvc/i6yoUNXtcIanoMP/sWE
	 lJ10Pt15ob/53d7LxJ/ownwvVjAtzaz/GC+FPGLqZRsVqF9Cv57Z9uv3PnfEInz9mS
	 fIo0Km2Jmy9/AH0kv+ILVDz4BbH+//Jrgs/GEMiefD8Pzw+hHC/UElrpwutVnWmux1
	 hoVzKcMwFwc6A==
Message-ID: <8e3e34d3-9034-4701-9fe9-baa43daf23b5@kernel.org>
Date: Fri, 27 Sep 2024 12:52:18 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: dwc3: core: Prevent phy suspend during init
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Youn <John.Youn@synopsys.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "msp@baylibre.com" <msp@baylibre.com>, "Vardhan, Vibhore" <vibhore@ti.com>,
 "Govindarajan, Sriramakrishnan" <srk@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Vishal Mahaveer <vishalm@ti.com>
References: <cover.1713310411.git.Thinh.Nguyen@synopsys.com>
 <e8f04e642889b4c865aaf06762cde9386e0ff830.1713310411.git.Thinh.Nguyen@synopsys.com>
 <1519dbe7-73b6-4afc-bfe3-23f4f75d772f@kernel.org>
 <20240926215141.6xqngt7my6ffp753@synopsys.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240926215141.6xqngt7my6ffp753@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/09/2024 00:51, Thinh Nguyen wrote:
> Hi Roger,
> 
> On Wed, Sep 25, 2024, Roger Quadros wrote:
>> Hello Thinh,
>>
>> On 17/04/2024 02:41, Thinh Nguyen wrote:
>>> GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY should be cleared
>>> during initialization. Suspend during initialization can result in
>>> undefined behavior due to clock synchronization failure, which often
>>> seen as core soft reset timeout.
>>>
>>> The programming guide recommended these bits to be cleared during
>>> initialization for DWC_usb3.0 version 1.94 and above (along with
>>> DWC_usb31 and DWC_usb32). The current check in the driver does not
>>> account if it's set by default setting from coreConsultant.
>>>
>>> This is especially the case for DRD when switching mode to ensure the
>>> phy clocks are available to change mode. Depending on the
>>> platforms/design, some may be affected more than others. This is noted
>>> in the DWC_usb3x programming guide under the above registers.
>>>
>>> Let's just disable them during driver load and mode switching. Restore
>>> them when the controller initialization completes.
>>>
>>> Note that some platforms workaround this issue by disabling phy suspend
>>> through "snps,dis_u3_susphy_quirk" and "snps,dis_u2_susphy_quirk" when
>>> they should not need to.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 9ba3aca8fe82 ("usb: dwc3: Disable phy suspend after power-on reset")
>>> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>
>> This patch is causing system suspend failures on TI AM62 platforms [1]
>>
>> I will try to explain why.
>> Before this patch, both DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY
>> bits (hence forth called 2 SUSPHY bits) were being set during initialization
>> and even during re-initialization after a system suspend/resume.
>>
>> These bits are required to be set for system suspend/resume to work correctly
>> on AM62 platforms.
> 
> Is it only for suspend or both suspend and resume?

I'm sure about suspend. It is not possible to toggle those bits while in system
suspend so we can't really say if it is required exclusively for system resume or not.

> 
>>
>> After this patch, the bits are only set when Host controller starts or
>> when Gadget driver starts.
>>
>> On AM62 platform we have 2 USB controllers, one in Host and one in Dual role.
>> Just after boot, for the Host controller we have the 2 SUSPHY bits set but
>> for the Dual-Role controller, as no role has started the 2 SUSPHY bits are
>> not set. Thus system suspend resume will fail.
>>
>> On the other hand, if we load a gadget driver just after boot then both
>> controllers have the 2 SUSPHY bits set and system suspend resume works for
>> the first time.
>> However, after system resume, the core is re-initialized so the 2 SUSPHY bits
>> are cleared for both controllers. For host controller it is never set again.
>> For gadget controller as gadget start is called, the 2 SUSPHY bits are set
>> again. The second system suspend resume will still fail as one controller
>> (Host) doesn't have the 2 SUSPHY bits set.
>>
>> To summarize, the existing solution is not sufficient for us to have a
>> reliable behavior. We need the 2 SUSPHY bits to be set regardless of what
>> role we are in or whether the role has started or not.
>>
>> My suggestion is to move back the SUSPHY enable to end of dwc3_core_init().
>> Then if SUSPHY needs to be disabled for DRD role switching, it should be
>> disabled and enabled exactly there.
>>
>> What do you suggest?
>>
>> [1] - https://urldefense.com/v3/__https://lore.kernel.org/linux-arm-kernel/20240904194229.109886-1-msp@baylibre.com/__;!!A4F2R9G_pg!Y10q3gwCzryOoiXpk6DMGn74iFQIg6GloY10J16kWCbqwgS1Algo5HRg05vm38dMw8n47qmKpqJlyXt9Kqlm$ 
>>
> 
> Thanks for reporting the issue.
> 
> This is quite an interesting behavior. As you said, we will need to
> isolate this change to only during DRD role switch.
> 
> We may not necessarily just enable at the end of dwc3_core_init() since
> that would keep the SUSPHY bits on during the DRD role switch. If this
> issue only occurs before suspend, perhaps we can check and set these
> bits during suspend or dwc3_core_exit() instead?

dwc3_core_exit() is not always called in the system suspend path so it
may not be sufficient.

Any issues if we set this these bits at the end of dwc3_suspend_common()
irrespective of runtime suspend or system suspend and operating role?
And should we restore these bits in dwc3_resume_common() to the state they
were before dwc3_suspend_common()?

-- 
cheers,
-roger

