Return-Path: <stable+bounces-33873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D71893854
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 08:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C272819BF
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 06:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F262B669;
	Mon,  1 Apr 2024 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kb0GY7UZ"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580E48F4E;
	Mon,  1 Apr 2024 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711952465; cv=none; b=N/ZSqyVfIFAVlODlVvSWPsOQvyBMX5FMtGrf8LAQ3OKIXzpVe/1t5rMlONqtpZNWHlk+HirrWWJxc7OMdNk+sYHfO75EuqOq9875sSd2dQeH4H79c+wTvlVygOsL9jZX5PBxnKlwctWAFwyDZslz1NMPiAOqRZAsLkB2iZHOV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711952465; c=relaxed/simple;
	bh=gbuiOirfoIWh54pMmo5shiyLrAmHo3JTT9lZWDZurHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9fO/1n/iY2VU8mJ9ThwVvYeevJIv9CXChGHd1fvC69PWLRVEaID5TvLAzvoFbZBJJAOnmJpPoECCANclYwlxeMXpSZT8jxx8DapRYB153QRHH2Xw9j9l7SVbeNq3mPwpoCgfw8khIRQJCxuzBod7zPlLNi62CXAXyXaq19wPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kb0GY7UZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=EPEBBUax3R8dQ824/i1Uw9psgL+yAsVIg7UMjkkjhx4=;
	t=1711952461; x=1712384461; b=kb0GY7UZxFwHJPCwuNIOZfiq7myYVK6hJqcm9K6iYuP8Kc4
	guDbgUg8tSYAI8UqJ2DNeohT4rOieVZeXijCiigxOS7vlnWTFYxsm36z8d1RpNT7ghrafczhB/bZd
	vTVgJ3LlxoBxjEEhQB9WF35v4+OHVIklOJWoUb8TMjylmB1GWOmqYziq3C+zWWfFBF/tdtS6s3R40
	chPDHRf4v12xhAy8T0bw+6iQfVuqR+FDOJfK+7U8QUQYTfA6pLVIkmlYRp7PXL/wfkHl/YULVT0cY
	+LQlyftgD2VduG52QAnCX6DkI7kiUKoAW+97uHIOzK4VLT+zz+o7mFqUBdN9vr/w==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rrB2Q-0002AT-HP; Mon, 01 Apr 2024 08:20:58 +0200
Message-ID: <297c2412-5680-4a4f-bd43-b3431a0bb4bd@leemhuis.info>
Date: Mon, 1 Apr 2024 08:20:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
To: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Kenny Levinsen
 <kl@kl.wtf>, Linux kernel regressions list <regressions@lists.linux.dev>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
 <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
 <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
 <122c6af1-b850-4c21-927e-337d9cef6d9c@redhat.com>
 <b41ea2c9-9bf3-4491-ac20-00edfc130a87@manjaro.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <b41ea2c9-9bf3-4491-ac20-00edfc130a87@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711952461;c1bb395f;
X-HE-SMSGID: 1rrB2Q-0002AT-HP

On 29.03.24 04:40, Philip Müller wrote:
> On 28/03/2024 00:45, Hans de Goede wrote:
>> On 3/27/24 4:47 PM, Philip Müller wrote:
>>> On 27/03/2024 17:31, Hans de Goede wrote:
>>>> On 3/19/24 5:52 AM, Philip Müller wrote:
>>>>> On 18/03/2024 17:58, Philip Müller wrote:
>>>>>> I'm currently developing on the OrangePi Neo-01, which ships with
>>>>>> two similar touchpads using the Synaptics driver. On 6.7.10 those
>>>>>> two devices get detected normally. On 6.8.1 it seems to error out.
>>>>>>
>>>>>> I either get none, or at best only one of those two devices.
>>>>>>
>>>>>> i2c_hid_acpi: probe of i2c-XXX0001:00 failed with error -110
>>>>>> i2c_hid_acpi: probe of i2c-XXX0002:00 failed with error -110
>>>>>>
>>>>>> what would be the best way to debug this?
>>>>>>
>>>>>
>>>>> I found the regression in commit
>>>>> aa69d6974185e9f7a552ba982540a38e34f69690
>>>>> HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling

TWIMC: Kenny Levinsen (now CCed) posted a patch to fix problems
introduced by af93a167eda9:
https://lore.kernel.org/all/20240331182440.14477-1-kl@kl.wtf/

Looks a bit (but I might be wrong there!) like he ran into similar
problems as Philip, but was not aware of this thread.

Ciao, Thorsten

>>>> I just checked that patch and I don't see anyway how that can create
>>>> this regression. I assume you did a git bisect ?
>>>>
>>>> Did you try the last commit in the tree before that commit got added
>>>> and verified that that one works where as building a kernel from commit
>>>> aa69d6974185e9f itself does not work ?
>>>>
>>>
>>> No I didn't do a git bisect actually. I did it more manually like git
>>> bisect might do it. What I did was to compile just that module and
>>> load it against the 6.7.10 kernel.
>>> a9f68ffe1170ca4bc17ab29067d806a354a026e0 is the last commit you find
>>> in 6.7 series. All the other commits are part of the 6.8 series or
>>> later. So I looked at the commit titles and picked
>>> a9f68ffe1170ca4bc17ab29067d806a354a026e0 which I compiled the "out of
>>> tree" module. I unloaded the 6.7.10 module, copied the new compiled
>>> one over and did the rmod, modprobe batch script to see how the
>>> touchpads react.
>>>
>>> Then I went to compile and tested
>>> af93a167eda90192563bce64c4bb989836afac1f which created the issue with
>>> -110 errors. So I went to aa69d6974185e9f7a552ba982540a38e34f69690
>>> which also results in the error. So I went back to
>>> 96d3098db835d58649b73a5788898bd7672a319b which still works. Since now
>>> 6.9 development started, I may try
>>> 00aab7dcb2267f2aef59447602f34501efe1a07f to see if that fixes anything.
>>>
>>> I can get the touchpads both working in 6.8 code when I do enough
>>> tries by a rmod/modprobe loop. Based on the logs you see, sometimes
>>> both are up, mostly one or none is up. having only two commits of 6.7
>>> code in the module it works as 6.7 code. Only when "HID: i2c-hid:
>>> Switch i2c_hid_parse() to goto style error handling" gets added I see
>>> the error and can reproduce it on my device as shown in the log.
>>>
>>> Before we had
>>>
>>> hid_err(hid, "reading report descriptor failed\n");
>>> kfree(rdesc);
>>>
>>> followed by the hardcoded return -EIO;
>>>
>>> Now we have an redirect to the out function but don't do kfree(rdesc)
>>> if you hit the error anymore.
>>>
>>> Also the last return 0; got removed. So maybe what ever error the
>>> device might have hit before might be reverted due to return 0 or not
>>> freeing rdesc when hitting the error might prevent it to load.
>>>
>>> Anyhow, that patch is the first patch which changes the function in
>>> that series. Sure it might not be able to compile the whole kernel
>>> with it. I only tested the module based on the given code in an out
>>> of tree module style.
>>>
>>> So I might test 6.9rc1 on the device and let you know if that kernel
>>> has the same issue still.
>>>
>>>>> When I use the commit before I can rmmod and modprobe in a batch
>>>>> script using a loop without erroring out to -110. Attached the
>>>>> testing script and dmesg log snippets
>>>>>
>>>>> #!/bin/bash
>>>>> for ((n=0;n<5;n++))
>>>>> do
>>>>> sudo rmmod i2c_hid_acpi
>>>>> sleep 1
>>>>> sudo modprobe i2c_hid_acpi --force-vermagic
>>>>> sleep 2
>>>>> done
>>>>
>>>> Ok, so you did try the commit before and that did work. Are you
>>>> sure that aa69d6974185e9f was not actually the last working
>>>> commit ?
>>>
>>> For me 96d3098db835d58649b73a5788898bd7672a319b was the last working
>>> code, as it doesn't change functionality.
>>>
>>>>
>>>> AFAICT aa69d6974185e9f makes no functional changes, except for
>>>> actually propagating the error from i2c_hid_read_register()
>>>> rather then hardcoding -EIO. But that should not matter...
>>>
>>> See return 0 and kfree(rdesc) which is now missing.
>>
>> The new code is (on error) "goto out;" and then out: looks like this:
>>
>> out:
>>          if (!use_override)
>>                  kfree(rdesc);
>>
>>          return ret;
>>
>> Since the "goto out;" is an else branch of "if (use_override) { } else
>> {}"
>> we know use_override is false here, so !use_override is true and
>> the kfree() still happens. Also even if that were to no longer happen
>> that
>> would just be a small memleak and would not explain the probe failures
>> you are seeing.
>>
>> As for "return 0" vs "return ret", the code at the end of i2c_hid_parse()
>> before commit aa69d6974185e9f looked like this:
>>
>>         if (ret) {
>>                 dbg_hid("parsing report descriptor failed\n");
>>                 return ret;
>>         }
>>
>>         return 0;
>>
>> So this would also always return ret because if ret
>> is non 0 we always hit if (ret) return ret; and if
>> ret is 0 then return 0 and return ret are functionally
>> the same.
>>
>> So since the functionality at the end of the function did
>> not change, it still always ends up returning ret, but now
>> does it in a less circumspect way.
>>
>> Which leaves just the change in the:
>>
>>     hid_err(hid, "reading report descriptor failed\n");
>>
>> code path which used to return -EIO and now does goto out
>> which ends up returning ret which is the actual return
>> value of i2c_hid_read_register() instead of hardcoding -EIO.
>>
>> I checked and nothing in the HID core treats -EIO in
>> a special way.
>>
>> So I still do not see how commit aa69d6974185e9f can break
>> anything and I really wonder if you did not make a mistake
>> during testing.
>>
>> Can you try building a clean broken kernel (the entire
>> kernel) and then in reverse order (of them being committed)
>> revert my recent i2c-hid changes 1 by one and after each
>> revert check if things start working again ?
>>
>> And then see which is the first revert after which things
>> start working again, that one is the culprit and I expect
>> you to find a different commit then aa69d6974185e9f.
>>
>> Unless I'm missing / overlooking something in commit
>> aa69d6974185e9f...
>>
>> Note I'm going offline for a long weekend and I won't be
>> replying to emails until next week Tuesday.
>>
>> Regards,
>>
>> Hans
> 
> I managed to do a brief test with Kernel 6.9-rc1. There the issue is
> still given. So I might add the changes of i2c-hid to the working 6.7.x
> kernels and post which commits will break that module.
> 

