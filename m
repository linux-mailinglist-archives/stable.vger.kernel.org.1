Return-Path: <stable+bounces-73112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7925596CA7B
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 00:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114AAB21B19
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A515573D;
	Wed,  4 Sep 2024 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxmVPR3C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926621487C8
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725489257; cv=none; b=QulKnP/LlFOEvQlmYNtTazuJ+zMVk7hpNGwqMn/XR7Y3RutD00KJ2PDi5uYKWoYzKtlejCyAeYQd+xd4vhitBRxAjkayJa3YOd1oUzpPREfMRkPqwDASexaCY/cn37nRIn2j73UsbXeiUZ53JTihGtIi8RTf+UcJyGq6CyZBT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725489257; c=relaxed/simple;
	bh=Sx8Wgv1eQKylbuzJNMnYYybtbUUvUsPwOWYjEik+7Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mi4j5qd4pkGg8XgXfVrUQOGRJT+eLidvtt6ymelZlzUFQ7zUFNc1P1k/vXX5nfrjvyfeHqRnQN6DTJEmhLoP4kb7MjqXpk5ot+mFyCytqdWbWIkWYNhOJilHmLvJOi0Hk1EdrKqNwLog5Eb/g7OldR86hUML2YYT4DSXgTuNWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxmVPR3C; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71433096e89so96105b3a.3
        for <stable@vger.kernel.org>; Wed, 04 Sep 2024 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725489256; x=1726094056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0IMH0NZ+lHLaI+tIdMYlCgdYPhkZWscTLUdFIUgcAs=;
        b=SxmVPR3C7r9KQkcPvTIFCM40M0ljcyACWIP/dv0UXf0Lw5l4lSbR1XDosvcQhNaKX3
         EEMkaWkwWRVvhDpLSE9OXjTGYZD2YSPmfPeVEoRhBOgUEXJFDKlZl4uSZXZ401lXv9bU
         FMfhZfVnfvHSbdcziFMVGxI0taYrQsRYk8EB7gK0qxJvk18R/rDsot3ROFlFEesgUzUB
         bhmnE4juHybNLLOzy8XcJB4qo6EhduOU1TF4ZvhaHAmTc6kd3gBAU8tEc41+k9qszMvG
         l8RSn5Eu5YPI2gLWmJ/QYRJ6YvT2/KoF605KburRCj50qTZavv4CRjKcNdJOOKNhc0HO
         f0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725489256; x=1726094056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0IMH0NZ+lHLaI+tIdMYlCgdYPhkZWscTLUdFIUgcAs=;
        b=iV2IW4BEe4quf4MSCk7Sd/WVxyvZuFiDBanWQTuxLwKSlVAlQW3K+84VnqU+JHz8Qr
         43Y7JDHc6FtiBDblplt8acwbp1d4IMwWPvgO5C07WAYTK8rUKKkHhSKbtmW+3qZT7N5M
         cf8ry2d53VAoWqP8iC1szgoEEtgQkjUyAhoSIURhMWo5kGPqhnPDQ6d4Et1ZqWMZHfLL
         DN9TBShuQYwJK8b+WS2av0kp8GtGru+9KZpA3NvpJLK7tmU6YO3lepOCxH8HwBg9vJKU
         VmJf/kRVAnegg/aeRwKLAC8F4HXUJHI+FJou5mecjdQPqpPIWfYyc2/5k7uyNLQrIMF9
         AnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfmosDYTI0MnHfyC2xv5RRFoNUlFzjdsrds4Bh3hqQWMvk6SLRbmkcsW6Po2getiZEU9ut/S0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5EHGt+eSlvFvF6tWqSXIk9ZxkVUx+asNpt7ObBLoq+cBNzDp
	8Rgz0aoJ0GEJxfnghHZDpu0ZGOnUX1aD/9NW40lVzcjOZ3yrW+GwY0bv1AsWiQ==
X-Google-Smtp-Source: AGHT+IGJhoyZj5JvkXbJu62mR3+HZoLDUXHbyMA/FpFC11l0mskHUTqSkqBQkp26whTBx+iQ5QgRNA==
X-Received: by 2002:a05:6a00:2345:b0:714:2d05:60df with SMTP id d2e1a72fcca58-7173c30f3c6mr17522720b3a.15.1725489255313;
        Wed, 04 Sep 2024 15:34:15 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e14:7:e8de:a18a:1040:ca3b? ([2a00:79e0:2e14:7:e8de:a18a:1040:ca3b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8538dsm2151763a12.9.2024.09.04.15.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 15:34:14 -0700 (PDT)
Message-ID: <d50e3406-1379-4eff-a8c1-9cae89659e3b@google.com>
Date: Wed, 4 Sep 2024 15:34:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking
 complaint
To: Bart Van Assche <bvanassche@acm.org>,
 Badhri Jagan Sridharan <badhri@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, stable@vger.kernel.org
References: <20240904201839.2901330-1-bvanassche@acm.org>
 <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
 <8feac105-fa35-4c35-bbac-5d0265761c2d@acm.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <8feac105-fa35-4c35-bbac-5d0265761c2d@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bart,

On 9/4/24 2:15 PM, Bart Van Assche wrote:
> On 9/4/24 2:00 PM, Badhri Jagan Sridharan wrote:
>> https://lore.kernel.org/all/ZsiYRAJST%2F2hAju1@kuha.fi.intel.com/ was
>> already accepted
>
> Thanks, I hadn't noticed this yet.
>
>> and is perhaps better than what you are suggesting as
>> it does not use the internal methods of mutex_init().
>
> Although I do not have a strong opinion about which patch is sent to
> Linus, I think my patch has multiple advantages compared to the patch
> mentioned above:
> - Cleaner. lockdep_set_class() is not used. Hence, it is not possible
>   that the wrong lockdep key is used (the one assigned by
>   mutex_init()).
> - The lock_class_key declaration occurs close to the sw->lock
>   declaration.
> - The lockdep_register_key() call occurs close to __mutex_init() call
>   that uses the registered key.
> - Needs less memory in debug kernels. The advantage of __mutex_init()
>   compared to mutex_init() is that it does not allocate (static) memory
>   for a lockdep key.
>
Thanks for the patch.

While I agree on (1) & (4), *may* be a good reason to reconsider.
However, I have seen almost 30+ instances of the prior
method 
(https://lore.kernel.org/all/20240822223717.253433-1-amitsd@google.com/)
of registering lockdep key, which is what I followed.
However, if that's is not the right way, it brings into question the purpose
of lockdep_set_class() considering I would always and unconditionally use
__mutex_init()  if I want to manage the lockdep class keys myself or
mutex_init() if I didn't.


Thanks,

Amit

> Thanks,
>
> Bart.
>

