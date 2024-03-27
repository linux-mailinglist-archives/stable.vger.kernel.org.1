Return-Path: <stable+bounces-32466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C22E88DB44
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9607D297827
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175383DABF3;
	Wed, 27 Mar 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9aglByU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8F3DABF0
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535474; cv=none; b=aQzofZPASfNJEGXdchDVzKF23ncV0USszeYM/iP8/xZGa3nd7mzcTV2CltKxtOc/6dA3JiRRl86rNfFxHJVrMjtIDlBjR66KiybJrgMcm1+/AL3cMe7KcKfqakla9N30xJcMKtochzHk+BfkgS3brjX9ZvfdvU78zzKbvdh3zN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535474; c=relaxed/simple;
	bh=BWcv2u4ZFz9iLQ4PRAzI+XEWhCpBoMKy/9/KLS71lNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zet1JznjWqElJiTwznj5kVCsgccu6hyUuzhMwAUFcIFJFIliM0ELfjLoa1MfWcXvTwWMrPcyvy9HRhgUql57h38qC/z6DDIe90c+D+OLZDX4VXbgxFa08s7JYfcSCud6RiED913hgLVjF1y5lA6IbShvuaaOIXY9Ov2ZooOqwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L9aglByU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711535471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oz/8STdJVcyP6J/NyQLwNyYMgSr1ywh4W3yd2bcGzAU=;
	b=L9aglByUZgo7SVshozZDIcETGymf1AyUPnF0u6y4gBV4mhxV0L97Kiz2BJDN42SZHIimcd
	ugCoIzMeme0YOJpKpEoJ83OaSKor4bDBXm2ZDi+BTdXE9DJpEbfbe8QTIlIQPO2Cgz9H3+
	lRaGzesI43t1/O+4qyTef7e+0qvS3m4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-vPw3D-EvMUai2jQVbQdozA-1; Wed, 27 Mar 2024 06:31:09 -0400
X-MC-Unique: vPw3D-EvMUai2jQVbQdozA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a450265c7b6so360604466b.0
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 03:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535468; x=1712140268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oz/8STdJVcyP6J/NyQLwNyYMgSr1ywh4W3yd2bcGzAU=;
        b=VdnLEeIfjByaM1hIF8RQKU0fwaqgIapw/fjEEF/M86OGOS9lkUTjpA9ARQSajqhEbU
         SEqZtF5BCU72bIx8uIdeqlU4+8UAqgtY+dlPK2A+OSnkPoI9oLsKid90+peoX2Fzq3D9
         Bm+BSh1SM7joQhPPZUk8ZNrbrl3It94ztSohVYP8Wi0d1pHVS2wo6/eiA47RmcujMAZI
         dh055lluE8hO4hRjxvQL+Hr11WQwNsjLg0+bwc2zoda9rZjZz7K1p48uATYnmulyq5+c
         lxcdXsItoB0buwJFfcrLNOVlv4IcxjAKQrUtJutCK8w81UXxoYjuEl3oL3ZOO/zBiRrf
         nhEg==
X-Forwarded-Encrypted: i=1; AJvYcCVBzuuZPQMQTFy6HcMNaoeHAIeXrWbvw2ZglirwKNZA7ND6NHOZFGZeF3fR8Aa/uuA/B1VIUJuYnz3vzPTWMWN2rjT9zTrR
X-Gm-Message-State: AOJu0YyzTFjKuObUyD8SOwbRJa5oYgYFd13gNzqy6rKExwnPlqxAglwk
	iP2JtMQ7R79ruIrUzLn6cBR1l7Vp1LvM9D2+xn7BSCv03LoJ9wfGhiAphtBWGyDYxLINWJpf0ej
	DYIA/H+Y/qA23/FpQbT5dxXGNdFJz9u7w5eadic2A4GJ13xkgx5JEJOq+/G5k8A==
X-Received: by 2002:a17:906:4ad3:b0:a46:7c9c:10d0 with SMTP id u19-20020a1709064ad300b00a467c9c10d0mr525191ejt.23.1711535468358;
        Wed, 27 Mar 2024 03:31:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvDn/acwG/UGqPiarbF67n1Zs2AqAU0k5k27uFzbZ/mo94RLYU3Pu0VxMg2scean105xtJXQ==
X-Received: by 2002:a17:906:4ad3:b0:a46:7c9c:10d0 with SMTP id u19-20020a1709064ad300b00a467c9c10d0mr525179ejt.23.1711535468032;
        Wed, 27 Mar 2024 03:31:08 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id li2-20020a170906f98200b00a4736ace734sm5272252ejb.115.2024.03.27.03.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:31:07 -0700 (PDT)
Message-ID: <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
Date: Wed, 27 Mar 2024 11:31:07 +0100
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
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Philip,

On 3/19/24 5:52 AM, Philip Müller wrote:
> On 18/03/2024 17:58, Philip Müller wrote:
>> I'm currently developing on the OrangePi Neo-01, which ships with two similar touchpads using the Synaptics driver. On 6.7.10 those two devices get detected normally. On 6.8.1 it seems to error out.
>>
>> I either get none, or at best only one of those two devices.
>>
>> i2c_hid_acpi: probe of i2c-XXX0001:00 failed with error -110
>> i2c_hid_acpi: probe of i2c-XXX0002:00 failed with error -110
>>
>> what would be the best way to debug this?
>>
> 
> I found the regression in commit aa69d6974185e9f7a552ba982540a38e34f69690
> HID: i2c-hid: Switch i2c_hid_parse() to goto style error handling

I just checked that patch and I don't see anyway how that can create
this regression. I assume you did a git bisect ? 

Did you try the last commit in the tree before that commit got added
and verified that that one works where as building a kernel from commit
aa69d6974185e9f itself does not work ?

> When I use the commit before I can rmmod and modprobe in a batch script using a loop without erroring out to -110. Attached the testing script and dmesg log snippets
> 
> #!/bin/bash
> for ((n=0;n<5;n++))
> do
> sudo rmmod i2c_hid_acpi
> sleep 1
> sudo modprobe i2c_hid_acpi --force-vermagic
> sleep 2
> done

Ok, so you did try the commit before and that did work. Are you
sure that aa69d6974185e9f was not actually the last working
commit ?

AFAICT aa69d6974185e9f makes no functional changes, except for
actually propagating the error from i2c_hid_read_register()
rather then hardcoding -EIO. But that should not matter...

Note that commit aa69d6974185e9f is part of a series and
I would not be surprised if some other commit in that series
is causing your problem, but aa69d6974185e9f itself seems
rather harmless.

Regards,

Hans



