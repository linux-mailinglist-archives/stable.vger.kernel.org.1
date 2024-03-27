Return-Path: <stable+bounces-33016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E4888ED04
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 18:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A791F304B8
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3C5152163;
	Wed, 27 Mar 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnPIixbk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE014EC78
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561544; cv=none; b=TtvBYa7HjAG5hkJn2yt5Irv/c2Nlne/9f+bRliT0fKpezPfWhiLYD7VAnwiqKiTcChK9P+JNiNRABaqUycMgM4+OjRrvq6NQL3sYs+F6XuGSVDjJXX/5X4nlBgr8iR6I1p8TtlPQXesxZ/7O/9nuyG5gaO6fgCW4sxhTuM21aPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561544; c=relaxed/simple;
	bh=aM2o/4svt/zoVg/+XqK0yf+XNNi7LQQ9yiAMc8Bf58s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GaRkiA55BSKkf+0mZO25WFo0MaUH4OBjs0Wd71uKDkiXWBdL1JtYQXChyiGagP17mhmhtdqHQ+SQvw9SideHAvhQxL7wCGI6WseqhxGug4BrSIHdnFDmpBUuCXgBZcyR0SS0MG9KoGwQOqX8kCSZuMuMFQAtdYMxOYgkMwyytLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnPIixbk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711561541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llBPkQ+VHBGr2utiEuPrmvpSNQUaaCYA/llHA+5UpYE=;
	b=TnPIixbkjcM52HKfGy65NYpISXX6R+8f8tnNcbZM4M12lXMXlMtMpTWLyBLcg65vYlLsJn
	UZYpoE/Ga3KiyOO/+eB6vWTE3t9SGkng+zEo739SLnlKaOm5Am4I3oUB78mN1XYX0JmmuX
	Gf6g9gyrMkQL7Vdx2fUQx3rNivb3f0A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-dVreZXT7Px-Gd3E3pUICuw-1; Wed, 27 Mar 2024 13:45:38 -0400
X-MC-Unique: dVreZXT7Px-Gd3E3pUICuw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a474ee91f00so4199566b.0
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 10:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711561537; x=1712166337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llBPkQ+VHBGr2utiEuPrmvpSNQUaaCYA/llHA+5UpYE=;
        b=kLyCnUjRMn3prh9Yst/bDMDKZrGK64+aJiL470b3D93kRXh7jQIN5/CoOf6TMQA/V/
         WTLUZnORQ4V549vPT2S4W6XBCQKgQQTf8kP0o8AUrxOxd4Pgrltm0VzyDa+deEFkyWcF
         bbAQL7t+nhJDa4rWRSs/CjSBGd/H4lYmqMAa8X4qCwSbcbL6PTtM0o6n3bTr+IpriSg9
         n744x+wAgB7iItwm+zJ2IMAcPpQEYKdZ6oo7OS8AMVbE5uEiQB7VOayS6QloQsdgAYa1
         lxvbSMH0y+CaMW+tD/YcbxkLbOKWZmZSJtM+KENJjhakUN+E07n2qN081oJHcGZvn1ml
         zmVw==
X-Forwarded-Encrypted: i=1; AJvYcCX+yP7XqaNYZhn3mRkW52YsiilFvhgsVdEp3Nl2J4FUE+hY21K6u+VbIo6fhV4lI2UAeoV3QhdE24UY4YsvGVGlZDwBpzSz
X-Gm-Message-State: AOJu0Yz0MA34wGZN03B3n8h8EjjbuEcW/EOf1tXUMQW9GlFzw4wtVJOl
	KFt8TCLtPbAzY/XKMw4lbsS2E2Y+XXAJdXIjjL+MNR8dfFZBDlglSdLgJukD5nr3jfIw5o0BAmh
	xflN5g/PX/ctkqiihc9vajBrqHbwSao7G6Ycl+Q6lXUjfEY4rhga0YBDAMtsqcA==
X-Received: by 2002:a17:906:b14:b0:a4e:e18:bc3f with SMTP id u20-20020a1709060b1400b00a4e0e18bc3fmr72989ejg.52.1711561537359;
        Wed, 27 Mar 2024 10:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFN6PXQ2DOxk40ooKhFZ0eMfqlGdu0LzXFlvQ4t8bWagaAdS39TS+HAn9LPRZlaPOIe7dGVg==
X-Received: by 2002:a17:906:b14:b0:a4e:e18:bc3f with SMTP id u20-20020a1709060b1400b00a4e0e18bc3fmr72978ejg.52.1711561536931;
        Wed, 27 Mar 2024 10:45:36 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bu15-20020a170906a14f00b00a4e0df9e793sm405101ejb.136.2024.03.27.10.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 10:45:36 -0700 (PDT)
Message-ID: <122c6af1-b850-4c21-927e-337d9cef6d9c@redhat.com>
Date: Wed, 27 Mar 2024 18:45:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
Content-Language: en-US, nl
To: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
 <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
 <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Philip,

On 3/27/24 4:47 PM, Philip Müller wrote:
> On 27/03/2024 17:31, Hans de Goede wrote:
>> Hi Philip,
>>
>> On 3/19/24 5:52 AM, Philip Müller wrote:
>>> On 18/03/2024 17:58, Philip Müller wrote:
>>>> I'm currently developing on the OrangePi Neo-01, which ships with two similar touchpads using the Synaptics driver. On 6.7.10 those two devices get detected normally. On 6.8.1 it seems to error out.
>>>>
>>>> I either get none, or at best only one of those two devices.
>>>>
>>>> i2c_hid_acpi: probe of i2c-XXX0001:00 failed with error -110
>>>> i2c_hid_acpi: probe of i2c-XXX0002:00 failed with error -110
>>>>
>>>> what would be the best way to debug this?
>>>>
>>>
>>> I found the regression in commit aa69d6974185e9f7a552ba982540a38e34f69690
>>> HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling
>>
>> I just checked that patch and I don't see anyway how that can create
>> this regression. I assume you did a git bisect ?
>>
>> Did you try the last commit in the tree before that commit got added
>> and verified that that one works where as building a kernel from commit
>> aa69d6974185e9f itself does not work ?
>>
> 
> No I didn't do a git bisect actually. I did it more manually like git bisect might do it. What I did was to compile just that module and load it against the 6.7.10 kernel. a9f68ffe1170ca4bc17ab29067d806a354a026e0 is the last commit you find in 6.7 series. All the other commits are part of the 6.8 series or later. So I looked at the commit titles and picked a9f68ffe1170ca4bc17ab29067d806a354a026e0 which I compiled the "out of tree" module. I unloaded the 6.7.10 module, copied the new compiled one over and did the rmod, modprobe batch script to see how the touchpads react.
> 
> Then I went to compile and tested af93a167eda90192563bce64c4bb989836afac1f which created the issue with -110 errors. So I went to aa69d6974185e9f7a552ba982540a38e34f69690 which also results in the error. So I went back to 96d3098db835d58649b73a5788898bd7672a319b which still works. Since now 6.9 development started, I may try 00aab7dcb2267f2aef59447602f34501efe1a07f to see if that fixes anything.
> 
> I can get the touchpads both working in 6.8 code when I do enough tries by a rmod/modprobe loop. Based on the logs you see, sometimes both are up, mostly one or none is up. having only two commits of 6.7 code in the module it works as 6.7 code. Only when "HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling" gets added I see the error and can reproduce it on my device as shown in the log.
> 
> Before we had
> 
> hid_err(hid, "reading report descriptor failed\n");
> kfree(rdesc);
> 
> followed by the hardcoded return -EIO;
> 
> Now we have an redirect to the out function but don't do kfree(rdesc) if you hit the error anymore.
> 
> Also the last return 0; got removed. So maybe what ever error the device might have hit before might be reverted due to return 0 or not freeing rdesc when hitting the error might prevent it to load.
> 
> Anyhow, that patch is the first patch which changes the function in that series. Sure it might not be able to compile the whole kernel with it. I only tested the module based on the given code in an out of tree module style.
> 
> So I might test 6.9rc1 on the device and let you know if that kernel has the same issue still.
> 
>>> When I use the commit before I can rmmod and modprobe in a batch script using a loop without erroring out to -110. Attached the testing script and dmesg log snippets
>>>
>>> #!/bin/bash
>>> for ((n=0;n<5;n++))
>>> do
>>> sudo rmmod i2c_hid_acpi
>>> sleep 1
>>> sudo modprobe i2c_hid_acpi --force-vermagic
>>> sleep 2
>>> done
>>
>> Ok, so you did try the commit before and that did work. Are you
>> sure that aa69d6974185e9f was not actually the last working
>> commit ?
> 
> For me 96d3098db835d58649b73a5788898bd7672a319b was the last working code, as it doesn't change functionality.
> 
>>
>> AFAICT aa69d6974185e9f makes no functional changes, except for
>> actually propagating the error from i2c_hid_read_register()
>> rather then hardcoding -EIO. But that should not matter...
> 
> See return 0 and kfree(rdesc) which is now missing.

The new code is (on error) "goto out;" and then out: looks like this:

out:
        if (!use_override)
                kfree(rdesc);

        return ret;

Since the "goto out;" is an else branch of "if (use_override) { } else {}"
we know use_override is false here, so !use_override is true and
the kfree() still happens. Also even if that were to no longer happen that
would just be a small memleak and would not explain the probe failures
you are seeing.

As for "return 0" vs "return ret", the code at the end of i2c_hid_parse()
before commit aa69d6974185e9f looked like this:

       if (ret) {
               dbg_hid("parsing report descriptor failed\n");
               return ret;
       }

       return 0;

So this would also always return ret because if ret
is non 0 we always hit if (ret) return ret; and if
ret is 0 then return 0 and return ret are functionally
the same.

So since the functionality at the end of the function did
not change, it still always ends up returning ret, but now
does it in a less circumspect way.

Which leaves just the change in the:

	hid_err(hid, "reading report descriptor failed\n");

code path which used to return -EIO and now does goto out
which ends up returning ret which is the actual return
value of i2c_hid_read_register() instead of hardcoding -EIO.

I checked and nothing in the HID core treats -EIO in
a special way.

So I still do not see how commit aa69d6974185e9f can break
anything and I really wonder if you did not make a mistake
during testing.

Can you try building a clean broken kernel (the entire
kernel) and then in reverse order (of them being committed)
revert my recent i2c-hid changes 1 by one and after each
revert check if things start working again ?

And then see which is the first revert after which things
start working again, that one is the culprit and I expect
you to find a different commit then aa69d6974185e9f.

Unless I'm missing / overlooking something in commit
aa69d6974185e9f...

Note I'm going offline for a long weekend and I won't be
replying to emails until next week Tuesday.

Regards,

Hans






