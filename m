Return-Path: <stable+bounces-33118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61378891219
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 04:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C021C22A13
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 03:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFB381B8;
	Fri, 29 Mar 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="R5dRjZK7"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315539AC7
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 03:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711683662; cv=none; b=FGYb3dSe+nxXnQ/8bIUNfcbimba07s2feEj1rMte7VcngUJNmpiyjoB/v5vOBOicA1w+5utcpRg0H+FPeRr94j5nnsPtTLH9WIBkpQJmR6ANnX9tOxD7besgfcYat7rJfbsgfg1DOoig2OMw9sPFmo9k/MKaApWBbPb/N4Au9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711683662; c=relaxed/simple;
	bh=PIOhI2TvsvD7P6hAdQRIBEANqtnnWpXwJI4Ii7MRxk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfVv/M8sNYSyMwS+oehG+FoLt6KdeofSmebWTHyZx8Jo2UQcYpsybij/6mV9tAuYKgn/3swfWoq+fYSkoYfMtjyfImdIDWPJ6WpGx6FE0kzW5IrmsIeuKw7odfqEofMakCKggI98pKYhduIMs+XQ7i1ITIKN2Sy+3HElXxD8yi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=R5dRjZK7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <b41ea2c9-9bf3-4491-ac20-00edfc130a87@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711683655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MX/C1DEDmjQjNTtvMfVF2nxnjlbEZ8H6LaAoUGeZ2Ss=;
	b=R5dRjZK7k0qPu1O2T08tzGAKAoiMKksefm1TcDvXewpbaHf1i4U2ulduyUYMAAx8ymXO37
	XADGPJdHd1FjGKxBfeF+ZX6sn/eKJWPgLdsN+FvdbB1DMOoYluDCaFb/5bteOUcwPH1BWi
	8lPdbr0JRdAjB9T4VdmgrzdTCyjq3XAkp6g2/5tPeUmf3OH3pPa7exXcS9+BQVKlNajEwd
	CATRizHuM/3Jd/VXVjVj0K/mAZVEtKoWMDBn0Ln41KiKEJAzJlzt+k5WR7is0st+Aw9l83
	3D2ViTpRpubquSGSo8Jw4ce+WiA8xcngn0fNPXfPdDTAqCpSLTS7DlAX4UYxFQ==
Date: Fri, 29 Mar 2024 10:40:52 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
 <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
 <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
 <122c6af1-b850-4c21-927e-337d9cef6d9c@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <122c6af1-b850-4c21-927e-337d9cef6d9c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 28/03/2024 00:45, Hans de Goede wrote:
> Hi Philip,
> 
> On 3/27/24 4:47 PM, Philip Müller wrote:
>> On 27/03/2024 17:31, Hans de Goede wrote:
>>> Hi Philip,
>>>
>>> On 3/19/24 5:52 AM, Philip Müller wrote:
>>>> On 18/03/2024 17:58, Philip Müller wrote:
>>>>> I'm currently developing on the OrangePi Neo-01, which ships with two similar touchpads using the Synaptics driver. On 6.7.10 those two devices get detected normally. On 6.8.1 it seems to error out.
>>>>>
>>>>> I either get none, or at best only one of those two devices.
>>>>>
>>>>> i2c_hid_acpi: probe of i2c-XXX0001:00 failed with error -110
>>>>> i2c_hid_acpi: probe of i2c-XXX0002:00 failed with error -110
>>>>>
>>>>> what would be the best way to debug this?
>>>>>
>>>>
>>>> I found the regression in commit aa69d6974185e9f7a552ba982540a38e34f69690
>>>> HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling
>>>
>>> I just checked that patch and I don't see anyway how that can create
>>> this regression. I assume you did a git bisect ?
>>>
>>> Did you try the last commit in the tree before that commit got added
>>> and verified that that one works where as building a kernel from commit
>>> aa69d6974185e9f itself does not work ?
>>>
>>
>> No I didn't do a git bisect actually. I did it more manually like git bisect might do it. What I did was to compile just that module and load it against the 6.7.10 kernel. a9f68ffe1170ca4bc17ab29067d806a354a026e0 is the last commit you find in 6.7 series. All the other commits are part of the 6.8 series or later. So I looked at the commit titles and picked a9f68ffe1170ca4bc17ab29067d806a354a026e0 which I compiled the "out of tree" module. I unloaded the 6.7.10 module, copied the new compiled one over and did the rmod, modprobe batch script to see how the touchpads react.
>>
>> Then I went to compile and tested af93a167eda90192563bce64c4bb989836afac1f which created the issue with -110 errors. So I went to aa69d6974185e9f7a552ba982540a38e34f69690 which also results in the error. So I went back to 96d3098db835d58649b73a5788898bd7672a319b which still works. Since now 6.9 development started, I may try 00aab7dcb2267f2aef59447602f34501efe1a07f to see if that fixes anything.
>>
>> I can get the touchpads both working in 6.8 code when I do enough tries by a rmod/modprobe loop. Based on the logs you see, sometimes both are up, mostly one or none is up. having only two commits of 6.7 code in the module it works as 6.7 code. Only when "HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling" gets added I see the error and can reproduce it on my device as shown in the log.
>>
>> Before we had
>>
>> hid_err(hid, "reading report descriptor failed\n");
>> kfree(rdesc);
>>
>> followed by the hardcoded return -EIO;
>>
>> Now we have an redirect to the out function but don't do kfree(rdesc) if you hit the error anymore.
>>
>> Also the last return 0; got removed. So maybe what ever error the device might have hit before might be reverted due to return 0 or not freeing rdesc when hitting the error might prevent it to load.
>>
>> Anyhow, that patch is the first patch which changes the function in that series. Sure it might not be able to compile the whole kernel with it. I only tested the module based on the given code in an out of tree module style.
>>
>> So I might test 6.9rc1 on the device and let you know if that kernel has the same issue still.
>>
>>>> When I use the commit before I can rmmod and modprobe in a batch script using a loop without erroring out to -110. Attached the testing script and dmesg log snippets
>>>>
>>>> #!/bin/bash
>>>> for ((n=0;n<5;n++))
>>>> do
>>>> sudo rmmod i2c_hid_acpi
>>>> sleep 1
>>>> sudo modprobe i2c_hid_acpi --force-vermagic
>>>> sleep 2
>>>> done
>>>
>>> Ok, so you did try the commit before and that did work. Are you
>>> sure that aa69d6974185e9f was not actually the last working
>>> commit ?
>>
>> For me 96d3098db835d58649b73a5788898bd7672a319b was the last working code, as it doesn't change functionality.
>>
>>>
>>> AFAICT aa69d6974185e9f makes no functional changes, except for
>>> actually propagating the error from i2c_hid_read_register()
>>> rather then hardcoding -EIO. But that should not matter...
>>
>> See return 0 and kfree(rdesc) which is now missing.
> 
> The new code is (on error) "goto out;" and then out: looks like this:
> 
> out:
>          if (!use_override)
>                  kfree(rdesc);
> 
>          return ret;
> 
> Since the "goto out;" is an else branch of "if (use_override) { } else {}"
> we know use_override is false here, so !use_override is true and
> the kfree() still happens. Also even if that were to no longer happen that
> would just be a small memleak and would not explain the probe failures
> you are seeing.
> 
> As for "return 0" vs "return ret", the code at the end of i2c_hid_parse()
> before commit aa69d6974185e9f looked like this:
> 
>         if (ret) {
>                 dbg_hid("parsing report descriptor failed\n");
>                 return ret;
>         }
> 
>         return 0;
> 
> So this would also always return ret because if ret
> is non 0 we always hit if (ret) return ret; and if
> ret is 0 then return 0 and return ret are functionally
> the same.
> 
> So since the functionality at the end of the function did
> not change, it still always ends up returning ret, but now
> does it in a less circumspect way.
> 
> Which leaves just the change in the:
> 
> 	hid_err(hid, "reading report descriptor failed\n");
> 
> code path which used to return -EIO and now does goto out
> which ends up returning ret which is the actual return
> value of i2c_hid_read_register() instead of hardcoding -EIO.
> 
> I checked and nothing in the HID core treats -EIO in
> a special way.
> 
> So I still do not see how commit aa69d6974185e9f can break
> anything and I really wonder if you did not make a mistake
> during testing.
> 
> Can you try building a clean broken kernel (the entire
> kernel) and then in reverse order (of them being committed)
> revert my recent i2c-hid changes 1 by one and after each
> revert check if things start working again ?
> 
> And then see which is the first revert after which things
> start working again, that one is the culprit and I expect
> you to find a different commit then aa69d6974185e9f.
> 
> Unless I'm missing / overlooking something in commit
> aa69d6974185e9f...
> 
> Note I'm going offline for a long weekend and I won't be
> replying to emails until next week Tuesday.
> 
> Regards,
> 
> Hans

I managed to do a brief test with Kernel 6.9-rc1. There the issue is 
still given. So I might add the changes of i2c-hid to the working 6.7.x 
kernels and post which commits will break that module.

-- 
Best, Philip


