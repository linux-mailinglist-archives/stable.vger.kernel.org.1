Return-Path: <stable+bounces-100105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F19E8D6B
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 09:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A213218852D8
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 08:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0342156E6;
	Mon,  9 Dec 2024 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRiMP4BB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E022C6E8
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733046; cv=none; b=ARnTt5k+Z9OuKP9Z/lEX28mjogK0wjspF6qAO08zMyca9sxvlsIsOGuQ7PRMi0vrqQ2r7WxQ+ECY+2xqe9ay4HjgnIHeRFvU2CKL427LXmpJhdF9h7eNGybz+hM1TrQbg8BgWpp2H2gBoWXE8LWIwWes1B+kyZFaHgwgpKBqR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733046; c=relaxed/simple;
	bh=1d2UQs4IpJLHgNHjQ0N7DB/H72rwjrFm6x80oXir/GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiGJ6rSYlV+/bNdZCeq8x/W8u4JtBwdjnEJ7CzpU+3xUl0YdsBFnJNocDDIqVW2yzU0MzlwE8F2bGAinihuJgufIsJZ9bU7DQj3TWJOlsYFI57AHVIZEH+3MR25ov9XHFMG3piJH6q5HfBXJldQiDZ6mSi+Bok5X3AgAZ6aqgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRiMP4BB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733733043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBKF2UFZWXbCYwAhv8QttLFQKMvyT8IMYojBhS1/oT8=;
	b=GRiMP4BBoOXcEbPQL+CxzFl156wy66nO/c9zq5/0AZDsVWho05QXTIRs/qyc0CZuAW1N/1
	J8afIrdUEtzfiDewWLGVQrYqDar8AtZw47SK//XDNP3HWYKFUXaKsZR7c0SkFh/qEL4i79
	cytDKbCBCTAV3T+uBnwcrp/0zZFTv4o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-WmURT7-ZPjODf5GujrImpw-1; Mon, 09 Dec 2024 03:30:42 -0500
X-MC-Unique: WmURT7-ZPjODf5GujrImpw-1
X-Mimecast-MFC-AGG-ID: WmURT7-ZPjODf5GujrImpw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa691c09772so36192966b.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 00:30:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733733041; x=1734337841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBKF2UFZWXbCYwAhv8QttLFQKMvyT8IMYojBhS1/oT8=;
        b=WUIMNWuRMMM5WxbS6jXI9HsCUUulhikbhdjdWP5KhAka1PlcKdIeQlaIs2SW3FWz6G
         WEYCwu44oyrBNmEFT/16ZUdPbEJOKS2TGBHBbZBVNWw+duc38aCD7UpS2cPxaRAvTrKK
         tccoetDfPATyhDdIs2vK4myZRv/aFGj04EdgRoqcsxqOOMSIq4hzAHJZdBDyb/YmsJZr
         ///5t0nGADE14d/uqLv24byFpJ16gxUKgLBbfPjT+zyxoL6jblCGPZz/bWsxtdtsfkyl
         KAj7B+Y7SnGexrpxYdvQce0vk8v7utJleOwnnzsYxe68qs3+4WgUAMiRohv6C9yKmcze
         Qpsg==
X-Forwarded-Encrypted: i=1; AJvYcCXkuJM+opoaAZgZC6wtAX+DChvNRpUQv1ech6N5RvL7R4QQZdagcDeZJtB73VJRKnpJj90/iC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9gBe1s9w9Pn04GYwIGMp073cq4+3EpUwaVIdUBeK/Oow07Cs
	zUOslyARTtW5Q8gcfNfFxALrvqIqoINyusYChUe30WKC9aw0tOUKe1ZlmvfY0TngJzRENfKVP5+
	XJaiiJprMwZ8c2gsBe17rDmXcxJDdzKBMZWU1V9rszZbjhUWmVB2R/w==
X-Gm-Gg: ASbGncveD3BCati+wMEUDWukdOr4+4GXT8i801qL6DCWj8Fc0qMHRn4V/PA8V17moat
	C6hQa5wc4s+400Z4Z+wEJHImqd6mXhTtLpEZebT+K4fJ/8oPd2jnm2OnzH7t89rQAavt38B9IF1
	2+UQLk+3lld2udySQ9hasnU/B6kTDzqfBirms9Bm/P0gDKC8kwyWTWKzdSVPTbIuGHDc4RrLqcA
	3n45ONU60IP01jlEY+sI0s9dpBAa9d8BvW+06WU7OIWGuo6YypnbQ==
X-Received: by 2002:a17:907:938a:b0:aa6:851d:af4d with SMTP id a640c23a62f3a-aa6851db0ddmr295608966b.21.1733733041415;
        Mon, 09 Dec 2024 00:30:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEq7O6vhfSo0hMIn8Em0ocaUBDqo5E0XsXucfSOt0kTSkILyqyAJlHkBj5DDT0CDvMJvO4tg==
X-Received: by 2002:a17:907:938a:b0:aa6:851d:af4d with SMTP id a640c23a62f3a-aa6851db0ddmr295607366b.21.1733733041066;
        Mon, 09 Dec 2024 00:30:41 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e2c31sm651505666b.180.2024.12.09.00.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:30:40 -0800 (PST)
Message-ID: <1d59a602-053a-47f1-9dac-5c95483d07b6@redhat.com>
Date: Mon, 9 Dec 2024 09:30:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
To: Ping-Ke Shih <pkshih@realtek.com>, Jes Sorensen <Jes.Sorensen@gmail.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20241107140833.274986-1-hdegoede@redhat.com>
 <6cf370a2-4777-4f25-95ab-43f5c7add127@RTEXMBS04.realtek.com.tw>
 <094431c4-1f82-43e0-b3f0-e9c127198e98@redhat.com>
 <8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <8e0a643ecdc2469f936c607dbd555b4c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9-Dec-24 1:26 AM, Ping-Ke Shih wrote:
> Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 18-Nov-24 3:23 AM, Ping-Ke Shih wrote:
>>> Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>>> The rtl8xxxu has all the rtl8192cu USB IDs from rtlwifi/rtl8192cu/sw.c
>>>> except for the following 10, add these to the untested section so they
>>>> can be used with the rtl8xxxu as the rtl8192cu are well supported.
>>>>
>>>> This fixes these wifi modules not working on distributions which have
>>>> disabled CONFIG_RTL8192CU replacing it with CONFIG_RTL8XXXU_UNTESTED,
>>>> like Fedora.
>>>>
>>>> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Peter Robinson <pbrobinson@gmail.com>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
>>>
>>> 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>>
>>> 31be3175bd7b wifi: rtl8xxxu: add more missing rtl8192cu USB IDs
>>
>> Thank you for merging this, since this is a bugfix patch, see e.g. :
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=2321540
>>
>> I was expecting this patch to show up in 6.13-rc1 but it does
>> not appear to be there.
>>
>> Can you please include this in a fixes-pull-request to the network
>> maintainer so that gets added to a 6.13-rc# release soon and then
>> can be backported to various stable kernels ?
>>
> 
> This patch stays in rtw.git and 6.14 will have it, and then drain to stable
> trees. For the redhat users, could you ask the distro maintainer to take this
> patch ahead?

That is not how things are supposed to work. You are supposed to have a fixes
tree/branch and a next tree/branch and fixes should be send out ASAP.

Ideally you would have already send this out as a fixes pull-request for
6.12 but waiting till 6.14 really is not acceptable IMHO.

Note this is not just about Red Hat / Fedora users, other distros are
likely impacted by this too.

Regards,

Hans



