Return-Path: <stable+bounces-40071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F28A7CEA
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 09:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053C7282839
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 07:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D1D6A339;
	Wed, 17 Apr 2024 07:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InuVlEGd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA736A026;
	Wed, 17 Apr 2024 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338167; cv=none; b=TySyq33l9I+TAAUh06SJRIMBFBTBvfiuYyOt84eE8XCIy16ZRzm+ClX8soKQcJ3Z3nTac/mNDM98icZPxMrhJv9+YGHR46VVEGkHNUzTxlpMGmbHN+hFCifyEqEyKKJ1+dpX4f+5rj2L0JEK7N09gzQ2dnCKziyFioN+vOk8Haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338167; c=relaxed/simple;
	bh=+4QWXCj+biITG+CTGUl2TaL6oX1SsKUGgqJvymNZLVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTZhV+RMVw8H7wmRmTA2He2Ix6JKcnUpBSwVDFwURDAZQjTFBqFZlW71UhqIvnhbJRZTTYgrJvyptF0StOWHr4/r9YQG5MUvXED+R9Mj+KiTM/53HueBvbvS4tQgQZ1Q8W/tf2ceRrII0gGDJnW+ijK6w7BI/DVr0qrEB7CCLog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InuVlEGd; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44f2d894b7so584926766b.1;
        Wed, 17 Apr 2024 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713338164; x=1713942964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gJFjIIyfOnTcc+Ki8SFiPbyym05w2ZeaGhJ9wPPSOP4=;
        b=InuVlEGdGq60JjJXz3xd6+BhRKQpJ/4MYDpCF9RS77z97zGmBWJx0US322zSEbW6fT
         p1f9+FRuHpF3mxZb08RO3hbKsxixFvFPcs8ZcEAPnynVQaXVlxHlJji5MEXvp7MFEbNE
         Wc5s2l3qRyDFsb91Cww2MmH/hibZ23YEHvefUJK+7FmL6bPih9xa/Zhp3/t4lxx2Kzb0
         cxv5sNCQ8grqmHTuxfuDibXTmgxAhIXNB8/PPCP9ue3UCbGYz24GrQwby/qVpWjMR4Sh
         EXpjgCN0Wx2ERwl32zB/iMFaDb/gsYUDh5vfGtaWQj6tCmeTPJq3UQHnEfFFw03IGvTH
         AomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713338164; x=1713942964;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJFjIIyfOnTcc+Ki8SFiPbyym05w2ZeaGhJ9wPPSOP4=;
        b=ha9hbTLKfVVUgzMj/ofEXkTa6a5hyYZEmE3Z1N7Yyli5x1qYxDtx3myj2EcZX6w3x9
         ZTKMxgSWW95GgI/CICXkvnYukfrG6vBdtCGQHy+DgG5SeK84mue0Cr9IOix1FONaPA7E
         WrFS5fYn0+iXRgxsK1i19ESo7ipPNqE6pfSJia2tYe5Vo7ppFA0yLxSdyZW+H46Ko0uI
         i8dzbb27yjYcULj52E7OiiaySmzV/+62kogEXxU8XBHltgBohXgk5auX2afcuV0gMBIl
         nmslUsOgcnbqlMCpb2jMMLG1KdULjmQC/mTzdDCIFX2WEK5dGsPg9GU5skajXtEfAbeR
         DOnA==
X-Forwarded-Encrypted: i=1; AJvYcCXVswGIkqMYCdZeHCbJFrs7VolP7pT8HZtEAft+SgjJbsrprzOJ4rKzyoih8J0lcpnb+KTZrsmmUlthQmhiRcwfg2HbNda1bu3gNxK7CjMD16VvtWNpsQxIPJjyygqE
X-Gm-Message-State: AOJu0Yzw2BzQtOuAZ+ZMjalBsX8b7r1lj6nfPGsrkfrvODjVQfn8xwVQ
	dMRpDepsCVQU7s0/br51VRtP6hV54UjjVj2Ih7bDAwI9BpOTSgNx
X-Google-Smtp-Source: AGHT+IEPvQcEhx8SJOsXDBITO9obYBeiJlrOPN/IMN6zmBbRe5fkPq2328P1a7Q3wbOVFrlZENTnJg==
X-Received: by 2002:a17:907:9496:b0:a52:30d3:41dd with SMTP id dm22-20020a170907949600b00a5230d341ddmr12918574ejc.41.1713338164183;
        Wed, 17 Apr 2024 00:16:04 -0700 (PDT)
Received: from ?IPV6:2a01:c22:721d:1e00:e86e:6f8a:5e9e:a11a? (dynamic-2a01-0c22-721d-1e00-e86e-6f8a-5e9e-a11a.c22.pool.telefonica.de. [2a01:c22:721d:1e00:e86e:6f8a:5e9e:a11a])
        by smtp.googlemail.com with ESMTPSA id x2-20020a1709065ac200b00a5238156017sm6584107ejs.88.2024.04.17.00.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 00:16:03 -0700 (PDT)
Message-ID: <17a3f8cb-26d4-4185-8e8b-0040ed62ae77@gmail.com>
Date: Wed, 17 Apr 2024 09:16:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
 <20240416193458.1e2c799d@kernel.org>
 <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
 <2024041709-prorate-swifter-523d@gregkh>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <2024041709-prorate-swifter-523d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.04.2024 09:04, Greg KH wrote:
> On Wed, Apr 17, 2024 at 08:02:31AM +0200, Heiner Kallweit wrote:
>> On 17.04.2024 04:34, Jakub Kicinski wrote:
>>> On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
>>>> Binding devm_led_classdev_register() to the netdev is problematic
>>>> because on module removal we get a RTNL-related deadlock. Fix this
>>>> by avoiding the device-managed LED functions.
>>>>
>>>> Note: We can safely call led_classdev_unregister() for a LED even
>>>> if registering it failed, because led_classdev_unregister() detects
>>>> this and is a no-op in this case.
>>>>
>>>> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
>>>> Cc: <stable@vger.kernel.org> # 6.8.x
>>>> Reported-by: Lukas Wunner <lukas@wunner.de>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>
>>> Looks like I already applied one chunk of this as commit 97e176fcbbf3
>>> ("r8169: add missing conditional compiling for call to r8169_remove_leds")
>>> Is it worth throwing that in as a Fixes tag?
>>
>> This is a version of the fix modified to apply on 6.8.
> 
> That was not obvious at all :(
> 
Stating "Cc: <stable@vger.kernel.org> # 6.8.x" isn't sufficient?

>> It's not supposed to be applied on net / net-next.
>> Should I have sent it to stable@vger.kernel.org only?
> 
> Why woudlu a commit only be relevent for older kernels and not the
> latest one?
> 
The fix version for 6.9-rc and next has been applied already.

> thanks,
> 
> greg k-h


