Return-Path: <stable+bounces-83747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7D99C3FF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE121F24311
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C7B14A62E;
	Mon, 14 Oct 2024 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFZyEC2D"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF251A270;
	Mon, 14 Oct 2024 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895773; cv=none; b=OajG4WRluiIYRy8lF2sJP7+0htC0TE7aQgzAVDVbsgdaKhWuJgr7pLUn7S4fv0yWLMu4yAoSOjqb2fa5Y6iypAbqhSg5BhSNXgZOYVzpTnkVdbyA0xQGd/1bQkM0PcQLEL+TELm8h+Jx00XJ4QFRKWBo4+uzHyxnYRX5SAb9OJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895773; c=relaxed/simple;
	bh=0FnX3kslkJmARMtmR5XzRR5CxoTQbloPjTXJKUtr1BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSZYT7H6hWilDBNsDsAr78lYNZitkodCPYVc98EH3gdHXVvvBGyZIfWt5lTm/ad1DVa0GAtsuFKpIYXbOJ1EJ/tPEFcA+gX7A7LU7RHwu+vgSCUkO3OE8aPBQGXsJ7dc11sIWHNTmm7kGBu8tAWKp92qshGsVFtL0uBPI95WI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFZyEC2D; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c9634c9160so1671760a12.2;
        Mon, 14 Oct 2024 01:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728895770; x=1729500570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/pc6u088b0sZFymIkJ7ThisTP08fpmM8RFfE7zodyE=;
        b=iFZyEC2DTX1E8rgRCYmTFgGktKaubFnP4krgXAo7D6ZvEsU1wa6CH7+KttH8FG8sjZ
         afSfA/bdSuhtHMXGoPmYQAD45L4TIP8Sb08/tG6kHdLXcpaI3HmkTcTNLk7JXtLRuPww
         sZB5RaLmGuAvYRrGRqLNYDKj3yawiBVxf0dPaq1Cu22yHfwX0nDVaLVM/nfwhzUr98Ry
         T4DnL2msvmX9mcoHRV7zh52vt6znZWW4RfeNcWve5F+DpcICeEki1fss2NYVn5/ESGJ/
         T39xxZV5zN5IWq9KQUbyd3E8P3UgYmy1pK2f9Jl1VVj0T+JlDGPLf4FKbA8jYqtuFmfo
         HvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895770; x=1729500570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/pc6u088b0sZFymIkJ7ThisTP08fpmM8RFfE7zodyE=;
        b=bTmdmS+GWpV3XpeMBq3UzMcWeQeZ4xgjJSRqP2KVV9y7k3LFHHhoA6c87BNVJgJA4q
         WNcXRVL/zjp3n3sdM2CSMoolU21ylk6oqFxFO7ODSn03IcJQO5UG5riBn92UXXKVGkU/
         CTuAbzDsu7OF7E29KmNNvuaG1uVsa4F6al+xPbqX1VIPGZ6Db0fLzOTz8rgCU/dHAk/O
         3Q2ZDNtM1BknFU+59jT+E3r+KO+pc7iirkGQlRLZcUC9ndT6wKQHcauelNkCLeclPHtp
         Y7ik+5alInyNy7pLIOvt51uLBNZGCrm7fIF9ETHGie9613/2Ax7Bbyxg8qrQWAahE/CJ
         Xh+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm+mRjKuqR0tP6Qw5oHfIrQHHavx3UGzun2zvCAdnHOSjI9nIa8QaJLacWFa+/6xuRXMift3bNxNEGE6E=@vger.kernel.org, AJvYcCWjNjkM2B681G5QoBH8s23mzMunKcGOpcNgyPkb8UOtxpiz1IlKJkoJDYGVCksWi/T7CyaBaAC1@vger.kernel.org
X-Gm-Message-State: AOJu0YyB/Giz4sCWfVDmYkR9sRpXwkHqOdUdh6mPquRYN3/sIrhjrjNM
	zWDcL4uXuRlONVwNpsufxulK3PmmISw8R928qsiGFEmBlWUINdCd
X-Google-Smtp-Source: AGHT+IF7onz7xq/lQNOnFDIr2wn5OnIJSIVfCPqEkOhi3dcJunRv41jwKHXl3xS+WE+yHR/3TgQkHQ==
X-Received: by 2002:a05:6402:1e8c:b0:5c9:806a:c921 with SMTP id 4fb4d7f45d1cf-5c9806ad393mr940321a12.32.1728895770364;
        Mon, 14 Oct 2024 01:49:30 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937260964sm4639710a12.69.2024.10.14.01.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:49:29 -0700 (PDT)
Message-ID: <a3a8418a-57f2-4f3e-80a3-011de2af1296@gmail.com>
Date: Mon, 14 Oct 2024 10:49:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
 <a4283afc-f869-4048-90b4-1775acb9adda@stanley.mountain>
 <47c7694c-25e1-4fe1-ae3c-855178d3d065@gmail.com>
 <767f08b7-be82-4b5e-bf82-3aa012a2ca5a@stanley.mountain>
 <8c0bbde9-aba9-433f-b36b-2d467f6a1b66@gmail.com>
 <20d12a96-c06b-4204-9a57-69a4bac02867@stanley.mountain>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20d12a96-c06b-4204-9a57-69a4bac02867@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2024 10:39, Dan Carpenter wrote:
> On Mon, Oct 14, 2024 at 10:15:25AM +0200, Javier Carrasco wrote:
>> On 14/10/2024 10:12, Dan Carpenter wrote:
>>> On Mon, Oct 14, 2024 at 09:59:49AM +0200, Javier Carrasco wrote:
>>>> This approach is great as long as the maintainer accepts mid-scope
>>>> variable declaration and the goto instructions get refactored, as stated
>>>> in cleanup.h.
>>>>
>>>> The first point is not being that problematic so far, but the second one
>>>> is trickier, and we all have to take special care to avoid such issues,
>>>> even if they don't look dangerous in the current code, because adding a
>>>> goto where there cleanup attribute is already used can be overlooked as
>>>> well.
>>>>
>>>
>>> To be honest, I don't really understand this paragraph.  I think maybe you're
>>> talking about if we declare the variable at the top and forget to initialize it
>>> to NULL?  It leads to an uninitialized variable if we exit the function before
>>> it is initialized.
>>>
>>
>> No, I am talking about declaring the variable mid-scope, and later on
>> adding a goto before that declaration in a different patch, let's say
>> far above the variable declaration. As soon as a goto is added, care
>> must be taken to make sure that we don't have variables with the cleanup
>> attribute in the scope. Just something to take into account.
>>
> 
> Huh.  That's an interesting point.  If you have:
> 
> 	if (ret)
> 		goto done;
> 
> 	struct device_node *fw_node __free(device_node) = something;
> 
> Then fw_node isn't initialized when we get to done.  However, in my simple test
> this triggered a build failure with Clang so I believe we would catch this sort
> of bug pretty quickly.
> 
> regards,
> dan carpenter
> 

Yes, the only pity is that GCC (I guess still the most common compiler
for the Linux kernel) stays silent, and it happily builds a buggy image.
But as you said, the patch will trigger some alarms as soon as it is
sent upstream.

In this particular case, and as Greg pointed out, that is not a real
threat anyway. My digression comes to an end, and v2 is on its way.

Thanks and best regards,
Javier Carrasco

