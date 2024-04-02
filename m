Return-Path: <stable+bounces-35571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA17894E01
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24C21C21451
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3947A53;
	Tue,  2 Apr 2024 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hELQRyDy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5129429
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047942; cv=none; b=HC9tLCYo2Dxk9d3VmfqzN8fdS+o2odAYp2dAh0INB+Rttaq7vKvUtDwpMzCHgl1JWHtYTi58Brz/9Xl93DV5YqX8lxYK6Jgo9kE2HcP46mz8szQkxax4uES/TKXIoRJ4kqHGYNzEZgF4+UQOI3hCpyAUjF7OHy0enXy7b0ohHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047942; c=relaxed/simple;
	bh=CduvOfpNr10U0zJ7tmMXTKm0KE3QKyqNx79uKqk/67I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEuCiHhYzUUuFs9a18D5kfelXthWJbZmI9+zTGdk1zNouakX+33gZ0D2AhPsZUJFmWuC7x5q3mElltpg5tyI92iqeLhAKcnxA12RcWhg521pqihrSpCRJvjVffgUULZPjeL/ej1NbxhwLjnxxovyN2fTGSL6VSAUJ0azjzHDhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hELQRyDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712047939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qmqISHrX7p8E4bjz/SbLCAo5L7xzypND/kDcSX9+b4o=;
	b=hELQRyDynpb2CqjFjhc3sKBoidhrgGZqNdtG+/9RZa6nkTxRNK17BfwsBDX62Qd7NHjSLA
	BabeK751qAQc+JE3L2g/+NJGehkeMz78Qz8esVdu0gMmyi9jxtuXzr/yI43v1jJiL8R284
	ywGCR185tINmFoRKwyshsOtgZjpXdeI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-ZD83l3b4McSzxbVeY9E_Nw-1; Tue, 02 Apr 2024 04:52:18 -0400
X-MC-Unique: ZD83l3b4McSzxbVeY9E_Nw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56c0d3514baso2454572a12.0
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 01:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712047937; x=1712652737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qmqISHrX7p8E4bjz/SbLCAo5L7xzypND/kDcSX9+b4o=;
        b=peTw0jYtpyeh7Mm+H0ywhFp2Miovi5DOoWv6eS6aZY1dho7FoC82o7N7glhIqwDJ4S
         e7lvFu36xeB1N/H4+aBGphkJH/vB+Ibo2TB7az9JfdjasCBFHvrOcbB8x8Jit/qjBI41
         ZSVFE303nmbP8RnFIPXviP8g5/WtnTcdH/LC3dseBNwQAoewDprWfeIoulTJivUsVKM5
         w+FjDjkmc11q6kvHXP0axtrghm8drtevxQUHnomiKjpe4gQNKvbq3ci7JwoL0VWja9JM
         9IU9hikA2NVTeyB3nlu/hSJCyhebX/fgkDc31OZLbzWM6umFBwVMOYw5W+ZM05PcMtAt
         zUXA==
X-Forwarded-Encrypted: i=1; AJvYcCXaus7D0TU/IPn1ZS2rLOkr826MzHvA/yyTUSMYyTw8OM717KPg9qchKKc9XDZS3l9NOf9aeH8tt/h+pByhNHoHvICenhux
X-Gm-Message-State: AOJu0YzYx26s1B3U+qvsIMjjRuuZHNgglkOLAwNn+Tn7LuMndXu24xGl
	KZRcEN2rHB9ucyvuW30LwNkz2uPQB44WkvpdFgYgj2ajNjDFTEaxiktPMUCjWVc1uwLGQRr9Nx/
	ljk9HXevULu5WZ3yc0AOgziCgcetDs+wJ8pW96+rwhWawNRlcVcZVAg==
X-Received: by 2002:a05:6402:13c3:b0:56c:24e6:ca7e with SMTP id a3-20020a05640213c300b0056c24e6ca7emr10120201edx.2.1712047936916;
        Tue, 02 Apr 2024 01:52:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxZNIhdg9DmPYf6bST2boxaoATIApzbjQ4SopPZFPI60yMRJTBr51gXneKjYtdWsAnX04nHA==
X-Received: by 2002:a05:6402:13c3:b0:56c:24e6:ca7e with SMTP id a3-20020a05640213c300b0056c24e6ca7emr10120182edx.2.1712047936475;
        Tue, 02 Apr 2024 01:52:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 11-20020a0564021f4b00b0056c36b2f6f4sm6501806edz.59.2024.04.02.01.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:52:16 -0700 (PDT)
Message-ID: <599f96d2-31d6-49ac-9623-1dd03c5407a2@redhat.com>
Date: Tue, 2 Apr 2024 10:52:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
To: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
 <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
 <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
 <122c6af1-b850-4c21-927e-337d9cef6d9c@redhat.com>
 <b41ea2c9-9bf3-4491-ac20-00edfc130a87@manjaro.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b41ea2c9-9bf3-4491-ac20-00edfc130a87@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Philiph,

Someone else has hit the same problem and has correctly pinpointed
it to another commit (in the same series) and submitted a fix
upstream:

https://lore.kernel.org/linux-input/20240331182440.14477-1-kl@kl.wtf/T/#u

I'll be reviewing this patch shortly.

Regards,

Hans







On 3/29/24 4:40 AM, Philip Müller wrote:
> On 28/03/2024 00:45, Hans de Goede wrote:
>> Hi Philip,
>>
>> On 3/27/24 4:47 PM, Philip Müller wrote:
>>> On 27/03/2024 17:31, Hans de Goede wrote:
>>>> Hi Philip,
>>>>
>>>> On 3/19/24 5:52 AM, Philip Müller wrote:
>>>>> On 18/03/2024 17:58, Philip Müller wrote:
>>>>>> I'm currently developing on the OrangePi Neo-01, which ships with two similar touchpads using the Synaptics driver. On 6.7.10 those two devices get detected normally. On 6.8.1 it seems to error out.
>>>>>>
>>>>>> I either get none, or at best only one of those two devices.
>>>>>>
>>>>>> i2c_hid_acpi: probe of i2c-XXX0001:00 failed with error -110
>>>>>> i2c_hid_acpi: probe of i2c-XXX0002:00 failed with error -110
>>>>>>
>>>>>> what would be the best way to debug this?
>>>>>>
>>>>>
>>>>> I found the regression in commit aa69d6974185e9f7a552ba982540a38e34f69690
>>>>> HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling
>>>>
>>>> I just checked that patch and I don't see anyway how that can create
>>>> this regression. I assume you did a git bisect ?
>>>>
>>>> Did you try the last commit in the tree before that commit got added
>>>> and verified that that one works where as building a kernel from commit
>>>> aa69d6974185e9f itself does not work ?
>>>>
>>>
>>> No I didn't do a git bisect actually. I did it more manually like git bisect might do it. What I did was to compile just that module and load it against the 6.7.10 kernel. a9f68ffe1170ca4bc17ab29067d806a354a026e0 is the last commit you find in 6.7 series. All the other commits are part of the 6.8 series or later. So I looked at the commit titles and picked a9f68ffe1170ca4bc17ab29067d806a354a026e0 which I compiled the "out of tree" module. I unloaded the 6.7.10 module, copied the new compiled one over and did the rmod, modprobe batch script to see how the touchpads react.
>>>
>>> Then I went to compile and tested af93a167eda90192563bce64c4bb989836afac1f which created the issue with -110 errors. So I went to aa69d6974185e9f7a552ba982540a38e34f69690 which also results in the error. So I went back to 96d3098db835d58649b73a5788898bd7672a319b which still works. Since now 6.9 development started, I may try 00aab7dcb2267f2aef59447602f34501efe1a07f to see if that fixes anything.
>>>
>>> I can get the touchpads both working in 6.8 code when I do enough tries by a rmod/modprobe loop. Based on the logs you see, sometimes both are up, mostly one or none is up. having only two commits of 6.7 code in the module it works as 6.7 code. Only when "HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling" gets added I see the error and can reproduce it on my device as shown in the log.
>>>
>>> Before we had
>>>
>>> hid_err(hid, "reading report descriptor failed\n");
>>> kfree(rdesc);
>>>
>>> followed by the hardcoded return -EIO;
>>>
>>> Now we have an redirect to the out function but don't do kfree(rdesc) if you hit the error anymore.
>>>
>>> Also the last return 0; got removed. So maybe what ever error the device might have hit before might be reverted due to return 0 or not freeing rdesc when hitting the error might prevent it to load.
>>>
>>> Anyhow, that patch is the first patch which changes the function in that series. Sure it might not be able to compile the whole kernel with it. I only tested the module based on the given code in an out of tree module style.
>>>
>>> So I might test 6.9rc1 on the device and let you know if that kernel has the same issue still.
>>>
>>>>> When I use the commit before I can rmmod and modprobe in a batch script using a loop without erroring out to -110. Attached the testing script and dmesg log snippets
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
>>> For me 96d3098db835d58649b73a5788898bd7672a319b was the last working code, as it doesn't change functionality.
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
>> Since the "goto out;" is an else branch of "if (use_override) { } else {}"
>> we know use_override is false here, so !use_override is true and
>> the kfree() still happens. Also even if that were to no longer happen that
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
> I managed to do a brief test with Kernel 6.9-rc1. There the issue is still given. So I might add the changes of i2c-hid to the working 6.7.x kernels and post which commits will break that module.
> 


