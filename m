Return-Path: <stable+bounces-33000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E018288E9BF
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3EB1C313BE
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1F412AAEB;
	Wed, 27 Mar 2024 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="oQTsF1jZ"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD042A89
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554436; cv=none; b=fDNg0P1gsqJs4TB5W+DhO23xvB84R/unpgdnFpzf2xPSleRIBpFp8k40xFrWrr3z375/nsQL8V3MabNyr9qhtzQvyIvj8jwpkA96pfD5TIN52zC5IVg63Oe6VaKZOxu5AJAvP5X9kjUIdzCLzSz3Jy/QFNZegzKbeDRTAKMjHcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554436; c=relaxed/simple;
	bh=L5sfChLqjAc41tOAZzSnZdwb5xsmwaeDIKXFVjNdSdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luN73DD8Zk/mlYGSMFUgeb8Z4k4SIdg5CY4jf1pxwNfoawr8L+JDnYY94TJLHM3gg7Le6fHilnS2Cm4a/sM6bl6W6nhw5Joa3v7M1PT+xzHpyr7/VuK++mLruX/gzdCnDhSVOrGTaqkXQeJRu/sAi32VaQl8SEoSgUlJL79ThrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=oQTsF1jZ; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711554429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EMM/gBw7aZ5RN+GZDcFgDdOGxzUQjrzOEhjnMfI0jM=;
	b=oQTsF1jZJOmH2RbgjO+6mZJDpeEVI9+T13j913dkUCvrIyTlduJSVlnugMmiY82Zf3sefS
	Y+Y8wcjfEJmPLb6vUVfsY+suidKTGDlw0nr2F/bHPo/ke7jPounAappGWBPB0hWMsk5eF9
	WOGFlF4kSyZGhaOps874BIQsbKDMzijsKngHxlwL/YEBAKwSHJpumXrGZxiqRmCFDy1psJ
	NZ68UepPWEC40NI8pCbDM0plx5VVV0d9NtckCT/yFXaiaP1X0LY/rXJZy89iyQoI5RqHbK
	sQQO5qiuQXBd3yW9qmTGiQiviWHHRgpHnOHWhcSWZyVaalfSkagPDXeLUBfFeQ==
Date: Wed, 27 Mar 2024 22:47:04 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
To: Hans de Goede <hdegoede@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
 <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 27/03/2024 17:31, Hans de Goede wrote:
> Hi Philip,
> 
> On 3/19/24 5:52 AM, Philip Müller wrote:
>> On 18/03/2024 17:58, Philip Müller wrote:
>>> I'm currently developing on the OrangePi Neo-01, which ships with two similar touchpads using the Synaptics driver. On 6.7.10 those two devices get detected normally. On 6.8.1 it seems to error out.
>>>
>>> I either get none, or at best only one of those two devices.
>>>
>>> i2c_hid_acpi: probe of i2c-XXX0001:00 failed with error -110
>>> i2c_hid_acpi: probe of i2c-XXX0002:00 failed with error -110
>>>
>>> what would be the best way to debug this?
>>>
>>
>> I found the regression in commit aa69d6974185e9f7a552ba982540a38e34f69690
>> HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling
> 
> I just checked that patch and I don't see anyway how that can create
> this regression. I assume you did a git bisect ?
> 
> Did you try the last commit in the tree before that commit got added
> and verified that that one works where as building a kernel from commit
> aa69d6974185e9f itself does not work ?
> 

No I didn't do a git bisect actually. I did it more manually like git 
bisect might do it. What I did was to compile just that module and load 
it against the 6.7.10 kernel. a9f68ffe1170ca4bc17ab29067d806a354a026e0 
is the last commit you find in 6.7 series. All the other commits are 
part of the 6.8 series or later. So I looked at the commit titles and 
picked a9f68ffe1170ca4bc17ab29067d806a354a026e0 which I compiled the 
"out of tree" module. I unloaded the 6.7.10 module, copied the new 
compiled one over and did the rmod, modprobe batch script to see how the 
touchpads react.

Then I went to compile and tested 
af93a167eda90192563bce64c4bb989836afac1f which created the issue with 
-110 errors. So I went to aa69d6974185e9f7a552ba982540a38e34f69690 which 
also results in the error. So I went back to 
96d3098db835d58649b73a5788898bd7672a319b which still works. Since now 
6.9 development started, I may try 
00aab7dcb2267f2aef59447602f34501efe1a07f to see if that fixes anything.

I can get the touchpads both working in 6.8 code when I do enough tries 
by a rmod/modprobe loop. Based on the logs you see, sometimes both are 
up, mostly one or none is up. having only two commits of 6.7 code in the 
module it works as 6.7 code. Only when "HID: i2c-hid: Switch 
i2c_hid_parse() to goto style error handling" gets added I see the error 
and can reproduce it on my device as shown in the log.

Before we had

hid_err(hid, "reading report descriptor failed\n");
kfree(rdesc);

followed by the hardcoded return -EIO;

Now we have an redirect to the out function but don't do kfree(rdesc) if 
you hit the error anymore.

Also the last return 0; got removed. So maybe what ever error the device 
might have hit before might be reverted due to return 0 or not freeing 
rdesc when hitting the error might prevent it to load.

Anyhow, that patch is the first patch which changes the function in that 
series. Sure it might not be able to compile the whole kernel with it. I 
only tested the module based on the given code in an out of tree module 
style.

So I might test 6.9rc1 on the device and let you know if that kernel has 
the same issue still.

>> When I use the commit before I can rmmod and modprobe in a batch script using a loop without erroring out to -110. Attached the testing script and dmesg log snippets
>>
>> #!/bin/bash
>> for ((n=0;n<5;n++))
>> do
>> sudo rmmod i2c_hid_acpi
>> sleep 1
>> sudo modprobe i2c_hid_acpi --force-vermagic
>> sleep 2
>> done
> 
> Ok, so you did try the commit before and that did work. Are you
> sure that aa69d6974185e9f was not actually the last working
> commit ?

For me 96d3098db835d58649b73a5788898bd7672a319b was the last working 
code, as it doesn't change functionality.

> 
> AFAICT aa69d6974185e9f makes no functional changes, except for
> actually propagating the error from i2c_hid_read_register()
> rather then hardcoding -EIO. But that should not matter...

See return 0 and kfree(rdesc) which is now missing.

> Note that commit aa69d6974185e9f is part of a series and
> I would not be surprised if some other commit in that series
> is causing your problem, but aa69d6974185e9f itself seems
> rather harmless.

Well, it might also revealed an issue, which was ignored all the time 
and by erroring out it might stop the process to continue something. Cos 
maybe return 0 had skipped any recorded error before.

If you want me to test or try something else, let me know. I'm open for 
ideas.

> 
> Regards,
> 
> Hans
> 
> 

-- 
Best, Philip


