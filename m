Return-Path: <stable+bounces-132428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2CCA87E60
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FB8175B4F
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E1284B31;
	Mon, 14 Apr 2025 11:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GS+0x51K"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7105D281348
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628694; cv=none; b=i1XYc6BIZofFQwsCHW7KqeIlxwy541Q0ST3okxD91ph0baQoiZxsLleNPdxxC4vXcngu1G7ZWQRDq/z5LTZp0gi3DwN+NIt/MUeCfFYat9w6PCejzghvDQojJhn1qkE/YyfEb5iKPIZvgsPN7Auj14kQm/VDOrfnjJlQHfQjH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628694; c=relaxed/simple;
	bh=a1QgMoqZLxidPT8MZIzNeo0ahI4AIlk9j3HsOU7C7SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+ZC3615VdIQUVJp+6IsVy1uoDDeqQk1Zk9kI3rALHlkmR7+on/0W8nSgx9os+sQK4zgZRuEA7lINTeg5GA67QbzaJWCeAeAD2DC2Z25kakNuFkpyG0sYQ8m+oj/s9dZvKogvjNusxexX4K5JAYnWwl5wknGDyK1vVKEKb6Nc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GS+0x51K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744628691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqNH3rALHkPYmFYYLgGdDpOMZYwATfXy50C2/Ds0wAU=;
	b=GS+0x51KvBcaVdf8j5BM+89s5NFnDeUeGFXL90WieMj8nMwKsZ1IIzfU+GJpSXOH7gthmr
	gBo6FMUyr+W2DKAu50ltVmn42B5cTiwlzqWAZO/NM188ZDJENg+5QOT211sfUYI2R5AJTb
	JwHZm4jb5iZQu7ypSc8hefnapsI5NCk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-ZE3yt3puMtyq1zY5sqboaQ-1; Mon, 14 Apr 2025 07:04:50 -0400
X-MC-Unique: ZE3yt3puMtyq1zY5sqboaQ-1
X-Mimecast-MFC-AGG-ID: ZE3yt3puMtyq1zY5sqboaQ_1744628689
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac287f28514so357993066b.0
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 04:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744628689; x=1745233489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqNH3rALHkPYmFYYLgGdDpOMZYwATfXy50C2/Ds0wAU=;
        b=uOOZ3sNcY0PaMEZ+INdYahwZLzruhwSSbgPHhBAJBHCkpJfySFIcQDd4nh2v4qa/Ny
         g+dC7lxnkbOMPOS0id2KGnYMoenMZs6vIIp5XTGjypHvil1qho0c8IH0iiuqijII/aj0
         ay9QCHGWW76DeGXelZxHrdw9Fdjuf3FPqGSh2ySGyjYTuNGRgsOlPNpIXZ4ZiZfRXw7V
         N8f4vpSHHyNl6iO1pYlsU4LANiLoh5Jz1IWt9UZQ5IOIC3nIf0kXbrCETjPTTU4WvGaP
         A/g0IYD8zBYM6dwMmxxu/A+5cKJXHqElf8k7DrSO334YcRc7akY2l+DviVQ3KBvqerZD
         W/gA==
X-Forwarded-Encrypted: i=1; AJvYcCUNoSfM7sadHxGW6cPdKBNj+TfWf8Ph4Yr6O38OvENezSXlMnAKP3On2HIistKRTSVhLq19lQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfZtGbyYBwqFBE7L4tHX/iMs0fmLRvUY/r6CzQRSSpzMZM+OX
	iBoxHvrex69x8aDO8W9QwHc3CRK3Evv8A0SQOZJ9iZmW8iYU7rwANV2sVwKWjBL8wlooQ8VHczT
	Pp1SqSe4/YyoBf5HTaKwhMFgbfWK+75hpwxA+Qwku+/oZ4K9gnlYq8ayALb/XQA==
X-Gm-Gg: ASbGnctpapN14GUlUgajH1v88IBuTbmajUjAjyUox8BIo5HzGjuKK6ulT/VD9hoy+cT
	7YVieBCUEOVj28cTqUSoRDMmU3JML/1xlbrCpmrzZTsk5xIjTRvUGuaxrtvrA6myLWI0CLqer0n
	ZVf0Gf5XrRlDGdYh5ZKzqx6kVPj60sz/RQvpI4pppqdDfhVNHD1MFZaAvM0/rKmrdKzZJFNVadO
	wELutdw5cnXXAfofaP6i5Ly0CDbiE5dGBNZ8z45qNaSoVC+rrUI+solDjyHHtnUpNKlgXTgMocB
	cJCt/Gw/wavDGDo=
X-Received: by 2002:a17:907:3e1b:b0:ac3:c020:25e9 with SMTP id a640c23a62f3a-acad352b84bmr1013631666b.34.1744628688686;
        Mon, 14 Apr 2025 04:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhE+alPWy7hdC04GePGwU5YUyVn9AO1aVXzOVYnmufV8WxGpecarDzQvJenRhXNJ8+nBHdOg==
X-Received: by 2002:a17:907:3e1b:b0:ac3:c020:25e9 with SMTP id a640c23a62f3a-acad352b84bmr1013627866b.34.1744628688129;
        Mon, 14 Apr 2025 04:04:48 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54e11sm4860929a12.2.2025.04.14.04.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 04:04:47 -0700 (PDT)
Message-ID: <01570d5d-0bdf-4192-a703-88854e9bcf78@redhat.com>
Date: Mon, 14 Apr 2025 13:04:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] platform/x86: int3472: add hpd pin support
To: "Yan, Dongcheng" <dongcheng.yan@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Yan, Dongcheng" <dongcheng.yan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
 u.kleine-koenig@baylibre.com, ricardo.ribalda@gmail.com,
 bingbu.cao@linux.intel.com, stable@vger.kernel.org, hao.yao@intel.com
References: <20250411082357.392713-1-dongcheng.yan@intel.com>
 <cfc709a8-85fc-4e44-9dcf-ae3ef7ee0738@redhat.com>
 <c8ae2d43-157c-408a-af89-7248b30d52d1@linux.intel.com>
 <Z_zDGYD1QXZYWwI9@smile.fi.intel.com>
 <d9cab351-4850-42c7-8fee-a9340d157ed9@linux.intel.com>
 <Z_zMMtUdJYpHuny7@smile.fi.intel.com>
 <f10f919e-7bdc-4a01-b131-41bdc9eb6573@intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <f10f919e-7bdc-4a01-b131-41bdc9eb6573@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Apr-25 11:59, Yan, Dongcheng wrote:
> Hi Andy and Hans,
> 
> I found the description of lt6911uxe's GPIO in the spec:
> GPIO5 is used as the interrupt signal (50ms low level) to inform SOC
> start reading registers from 6911UXE;
> 
> So setting the polarity as GPIO_ACTIVE_LOW is acceptable?

Yes that is acceptable, thank you for looking this up.

Regards,

Hans



> We used RISING and FALLING in irq(not GPIO) to ensure that HDMI events
> will not be lost to the greatest extent possible.
> 
> Thanks,
> Dongcheng
> 
> On 4/14/2025 4:49 PM, Andy Shevchenko wrote:
>> On Mon, Apr 14, 2025 at 04:40:26PM +0800, Yan, Dongcheng wrote:
>>> On 4/14/2025 4:11 PM, Andy Shevchenko wrote:
>>>> On Mon, Apr 14, 2025 at 03:52:50PM +0800, Yan, Dongcheng wrote:
>>>>> On 4/11/2025 4:33 PM, Hans de Goede wrote:
>>>>>> On 11-Apr-25 10:23 AM, Dongcheng Yan wrote:
>>
>> ...
>>
>>>>>>> +	case INT3472_GPIO_TYPE_HOTPLUG_DETECT:
>>>>>>> +		*con_id = "hpd";
>>>>>>> +		*gpio_flags = GPIO_LOOKUP_FLAGS_DEFAULT;
>>>>>>
>>>>>> This looks wrong, we really need to clearly provide a polarity
>>>>>> here since the ACPI GPIO resources do not provide one.
>>>>>>
>>>>> I tested gpio_flags=GPIO_LOOKUP_FLAGS_DEFAULT/HIGH/LOW, the lt6911uxe
>>>>> driver can pass the test and work normally.
>>>>
>>>> I doubt you tested that correctly. It's impossible to have level triggered
>>>> event to work with either polarity. It might be also a bug in the code lurking
>>>> somewhere, but it would be unlikely (taking into account amount of systems
>>>> relying on this).
>>>>
>>>> Is it edge triggered event?
>>>>
>>>
>>> It is an edge triggered event in lt6911uxe. In order to better adapt to
>>> other uses, "hpd" is meaningful to specify a polarity here.
>>>
>>> In lt6911uxe, GPIO "hpd" is used as irq, and set irq-flag to
>>> IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT. So no matter
>>> rising or falling, driver can work normally.
>>> "
>>> ret = request_threaded_irq(gpiod_to_irq(lt6911uxe->irq_gpio),	NULL,
>>> lt6911uxe_threaded_irq_fn, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
>>> IRQF_ONESHOT, NULL, lt6911uxe);
>>> "
>>
>> So, the driver must not override the firmware, if there is no bugs.
>> So, why do you even use those flags there? It seems like a bad code
>> in the driver that doesn't look correct to me.
>>
> 


