Return-Path: <stable+bounces-163598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB7B0C5EB
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 16:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F0E3A5284
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C1029E0F8;
	Mon, 21 Jul 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqqrOb1I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBA91A2630;
	Mon, 21 Jul 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107166; cv=none; b=IxEr3LKjsAH0xYd1cFy8Kyz0iK+gJHGmYKpRPGikzt+OTwfZ3cPXtRCwNMSLkg8lRVQ7kmoujtd7jxA+6GqKQDa12VSTPkCvxse4kJ24ZUt9oE8WQmjWjrLItt9IhLV5fV76/BwxvfUKrvdv4aMhovV57Z1ZHDezRWlP8hf7mSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107166; c=relaxed/simple;
	bh=ZUI8iUx1rsk7qlGgAROdXcmZjMxCmthu2xxgxWdw8mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psmhFtajn7C+7NBzN5Am4JiOiaK3E+UbaJJJEZRdxQshLNkdmOarM3Q2R0fvezhB7dVmoECAFYv34iNILy5+GELfpJVuLOGBbQFGLf1QNWNK4qADcRUw//GTVn3saKiYJkn2M2BYtslFzJvotuA1T+XKvqoNGga+ITlix9rIMYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqqrOb1I; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235a3dd4f0dso26572005ad.0;
        Mon, 21 Jul 2025 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753107164; x=1753711964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ut6brFnBlSnwk0Q8CozCYF46EtBI5orpBCdYQfsXC0=;
        b=nqqrOb1IQ1O4MSruWFgot9vr3fN0trUsKVw9z7QWKw2chOcyRAB66wDd3n4qSh+Pv6
         XWFLA+Osgqd/8E8zgG6i+XXx24LNBVggltRJOpVG2X9VL1QcLOtaGa9nTaiXbI8tf7Qe
         zNAXvNYTnUqmvXdMKG1oAX3Fu46tlE68e5/LHc/Ip4xqNHh2iI8KdCDwGIBTOdiQ4ODL
         OMd82neZ0H5YR7rdW6gj2PBQ0tS0Fy3GzugpZi7sZj7bkXpb/95teYrCvxC8Ljj2pX7O
         IuJihvcpegppmQ3sLLwzYI2oqPaWHcapTmM+5JWjyxkSX7sNrOHQSSIWHR9Co3rx2vqT
         9jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107164; x=1753711964;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Ut6brFnBlSnwk0Q8CozCYF46EtBI5orpBCdYQfsXC0=;
        b=YLY5kVWv3KqOMCAExxG6K7PbFPy3Bw55Iw3uoX9gcVyzWJaO7sEtOHYETfpxTH6lOu
         2QhwTQgHj9ZPLGPnV2Z1OtlyyVsxn5JoLcNN8JY5EJmJNiKyfqIR3770Lz9b1ZoVmTRc
         ku+4NBEkJAI7tlNfLiVuK84eu5FWrvZIzA1fA/CiXodaJE+RjmDSv/DNI/ON+6grejBp
         QrvUMBnAhICqT1dpj/LE4jqrxea2Sa33fbehPSQJWNjlWOG/P+MnblwKoALlyVZz2mmU
         EF1jbnoBdbowc8mmsMhZpF1HDz96B1pPIfxqip03WgS0GUGiniXqUb9jXZQzPsHSogYh
         q/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaDtxjHzrlVMpTkSJjqehwZ+xVg4+12by++GN/X7DulUxT5J7hIeYFh7H0FcvhcYunS9qa2K1McNhHqsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiAYhkWBFtYSGO0YZO1BqBS6aU+iMJMuHKA6mfu1MqE/3jXzw
	ZHNkZy6Af55d/1D1LkS/BuGhgcavFl9FTJyxPj+HYHMoZY8sufoHgEBz
X-Gm-Gg: ASbGncvtpChZ1Ml/veGkSPfbST1v4uw0zxZGaL4SoLV5RNuTHxYWgecLFFufLEYR4/L
	H6bTBmjxNE114Jom5LoisnB0OzCHaFxinUYhzT2RfHe75eSl7IuYjUc4Tp2LRcmiQLQhxhWwhnr
	/68m4BK6ub6+Rn/9eP9aPbrQEmsLDr2h3Js8VfC3DAysgvx0cu/hDSRi6vyPQWSCmCSpF1UBQVr
	iSVazdafPTe9Dba21c0NdG4eyKKizAeHXxLyR6bmEXJ2rpEk+MIYipcJBSKk6mm38qFGvkwAxHE
	f3hlp/VIBiyb222SKzJcOHHGYU/AalhmY/B7Vm9yqJhD00Q7PNE6tWa5J1+gy+7mBzPQ7/BjjcC
	Bi57A9utke+tqZuWUZt48Vh2f7/rW012UQPSbw9GZVATR95qamHvTrV+g/m7QaQK5X3//+ZVfET
	S+etF3HQ==
X-Google-Smtp-Source: AGHT+IEhh4PQd2ROStgh9+KWpiN6IyyICQzPAk7eNwOYWjv+ZqpNAA78MYJD4MWTGR3bE99SGljvOA==
X-Received: by 2002:a17:902:d50e:b0:234:d7c5:a0ea with SMTP id d9443c01a7336-23e24f4aec0mr359810765ad.24.1753107164118;
        Mon, 21 Jul 2025 07:12:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6efb69sm58324555ad.195.2025.07.21.07.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 07:12:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <82683e59-308c-4ef5-b12a-3d929a3e6036@roeck-us.net>
Date: Mon, 21 Jul 2025 07:12:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/411] 5.15.186-rc1 review
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130632.993849527@linuxfoundation.org>
 <70823da1-a24d-4694-bf8a-68ca7f85e8a3@roeck-us.net>
 <CAFBinCD8MKFbqzG2ge5PFgU74bgZVhmCwCXt+1UK8b=QDndVuw@mail.gmail.com>
 <2025071238-decency-backboard-09dd@gregkh>
 <CAFBinCANe9oajzfZ_OGHoA-TtGC-CQdOm_O5TG8ke8m_NNE5NQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAFBinCANe9oajzfZ_OGHoA-TtGC-CQdOm_O5TG8ke8m_NNE5NQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/14/25 12:56, Martin Blumenstingl wrote:
> Hi Greg,
> 
> On Sat, Jul 12, 2025 at 2:37 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Jul 08, 2025 at 06:05:14PM +0200, Martin Blumenstingl wrote:
>>> Hi Guenter,
>>>
>>> On Mon, Jul 7, 2025 at 8:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On Mon, Jun 23, 2025 at 03:02:24PM +0200, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 5.15.186 release.
>>>>> There are 411 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
>>>>> Anything received after that time might be too late.
>>>>>
>>>> ...
>>>>> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>>>      drm/meson: use unsigned long long / Hz for frequency types
>>>>>
>>>>
>>>> This patch triggers:
>>>>
>>>> Building arm:allmodconfig ... failed
>>>> --------------
>>>> Error log:
>>>> drivers/gpu/drm/meson/meson_vclk.c:399:17: error: this decimal constant is unsigned only in ISO C90 [-Werror]
>>>>    399 |                 .pll_freq = 2970000000,
>>>>
>>>> and other similar problems. This is with gcc 13.4.0.
>>> Sorry to hear that this is causing issues.
>>> Are you only seeing this with the backport on top of 5.15 or also on
>>> top of mainline or -next?
>>>
>>> If it's only for 5.15 then personally I'd be happy with just skipping
>>> this patch (and the ones that depend on it).
>>
>> It's already merged, and I see these errors in the Android build reports
>> now.  I think they've just disabled the driver entirely to get around it :(
> Can you confirm that only 5.15 is affected - or do you also see
> problems with other stable versions?
> 

Only 5.15.y is affected. I think that is due to "-std=gnu11" which was introduced
around v5.18.

Guenter


