Return-Path: <stable+bounces-124047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0171AA5CB0D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6ED189E3FD
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD83D33CA;
	Tue, 11 Mar 2025 16:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="djfMfHx2"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E0F9D6
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711543; cv=none; b=bzG67rZS3oN6JZmVsPmL7tr1/vw+y9zWpq2/f8/EYjwxZk35cqHGh8jXm50C7swkD7U4bR81WKuVldum4picqP4MFNv5yVApUEYDISj1gDqtqXhNfTLz/3pD+2BpVMQSNRyi7MjO8EbqJvEB8VY6XUQ43ejXaZ6dApg6le7viZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711543; c=relaxed/simple;
	bh=dMfpeTf/NllZv9N3DyfOl2z5YpwpaZ2Szk9XzslUpQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poMnqET3pgGUuHYH3iC3PSMC63NZH28YRqTfc8es28/fTj2MbZtiSsMs1HlGQfudQgnzWqj8UldU+tI7hlOrc/UN7gijI9lKfVUPprYUqdvT7iQeH0rYlOPfJKX5BerSe00soqVRZIU6K+TWyQzEbqldsQaczH7k4F/sXqWYCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=djfMfHx2; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d04932a36cso53826025ab.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741711541; x=1742316341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLx2WoIhJiBG3bqAkGfbCh91LVddIJWiQd12L4pfcIA=;
        b=djfMfHx2fzZn2YHtjhqj/SWCS/0kJ4pGiYqYPVEXA5lhWkbref2BdRVQHBWs9pfCFf
         ORFXnYiODlBAA7OkFpzvdDZrCJg/SPw+BoNZ+FVTqJu11rJBy95bep0SiNJrDXeLGaGX
         njYC2x60z7EGqX/WNfWRPV8zIac8TphLTNdCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741711541; x=1742316341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLx2WoIhJiBG3bqAkGfbCh91LVddIJWiQd12L4pfcIA=;
        b=TTFI2+PhF2azjpiJEMBLuo+26/KOOOobO8NIf6tlCW8wtJtsuhizzr2teSWVblh6eP
         A9hWQ68cZgjWJTF7rYSC114UPx1b/KaO0c9XF01PSqqok4k4oRXcCYxIkalRyJjVXe3q
         353Iyf8z0dfUDXOpKz9mL+j34tHtBjzO3Q1ACiZDKKh0s+XwtVS09mLfUGvO+SYCdH2v
         XIxPowlnFhnXNhgq87D57XexxzknqTJ42MjxxsDVQeuRvhdLbH9YE9V3v0wPKEvSNyi7
         10cEaJdZHNtqZWx/ZpGePPdexYx8gEFDVLMZQ3hENTBI2mUgivc87uKRrYwsP+ePjxBP
         FRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoUYIcBUr3bVye1ygFwTifut87Fd+2q45QoOkKaQcF7U91FwI8ga7QF4JPrtfqZmsF4nCX1iE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzma2KjvAaOOVKAJFZaOIPnWdyqCy2VVyWztJRRxESQTzI2OQ0k
	7ISlFgLpXVl2qz76B8TLzubhlAburWtDD9zuFdeygbSqu+zGTgjjMWIXjWhpJyM=
X-Gm-Gg: ASbGncssTfTTeX/1Bu5Byy1IHvlPc0585zLyTsR+tyW9/4C7SxpYwng2ybz7NDVb3KH
	JysU7pQzn3nRvun/UwPMHz34QZjBJ79S/7pmUsp4iPFHRO3V68wCVRWei/xjx6iD8h063POsYzB
	IOdZCucbWyrgfAI7ymVLVFF3uvJuieMR4haXmK1f/xSf8arEWOr4ApKgQgqBDjUNoQ/7K91DmOM
	fnqWrF4I/vG+V24zqibsFRSw/xZD0qJ+y4HxR0RlLAP23MZB22sWh0epUFN19wBAIe7y4MwcuR5
	7iNtFkRzxgM7YHzCHX6jkCw28jrNWsk1tF0u2SOm9PUB/4ilGvHIGxc=
X-Google-Smtp-Source: AGHT+IFNRcfQzm6xuksYf/8LPcPtWo+WVv5uKFa9PKonyffFvWpr2Pt03YoFcJoQfra+HQB8yRxDJQ==
X-Received: by 2002:a92:cdaf:0:b0:3d4:341a:441d with SMTP id e9e14a558f8ab-3d4418d0cdfmr201635105ab.10.1741711541121;
        Tue, 11 Mar 2025 09:45:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f22fa56259sm1456209173.2.2025.03.11.09.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 09:45:40 -0700 (PDT)
Message-ID: <e1be13e3-dd14-4e11-8fd5-6d1e2316aa34@linuxfoundation.org>
Date: Tue, 11 Mar 2025 10:45:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/269] 6.12.19-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/10/25 11:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.19 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.19-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

