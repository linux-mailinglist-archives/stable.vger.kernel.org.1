Return-Path: <stable+bounces-163161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB83EB078E3
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 17:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF76E1882F94
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4CB28A1C8;
	Wed, 16 Jul 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QTHj70jQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB913A244
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677779; cv=none; b=GbcGlgfPUS6lqplAWNtubXXazmPtsgikqF5GFe5MGJw/l8y/KvtlHu/sRERjDeA2U9Ph6T9V4wT5aAI/4egwT5fnwtMmCccrBc1NjSVfTmZxC+73X++QKDa3XAPyuPN7eVP7E6l1UdnG77tFY5RX5o1QZUlVdfVsmn8+205g6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677779; c=relaxed/simple;
	bh=nMYQIUNNbhxTwKtjAj7dPAqrvTYfVjiLl0qUeBv56e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjwyMkofdruuxV1npSWFlGFVAih3O229q4NHKsXqvov6hEoRYcu6ibH7EEcYTwIxYqL/mltX9Bv9Qmr+D2sUb2m5kkLS5LqiPTQZgKUAREVvR09T8psJutsjmH6UVdQUFlgi91bJMGPZJEA/q8M3V+yDni0VjchazDvOPvSz5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QTHj70jQ; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3de18fde9cfso43336535ab.3
        for <stable@vger.kernel.org>; Wed, 16 Jul 2025 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752677775; x=1753282575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUVr6thTEstHKrPJDWmNddZkR2T0nuJlZaUbFO1uHtU=;
        b=QTHj70jQReaTfRtyG8dY3OJPqQvFUD0uknEAbtb1vf62TeLepunSX0R2RVJL7X8X5v
         a+n6f3pwJhLe1hwQhE7mFmFBPpytQSxPvthI0tv2/W7HJU+7SlkQ+7Q/K0nivrbthEvP
         4hS140nZwavwzQa3aBnbX/yDoOUnkq0MvmuEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677775; x=1753282575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUVr6thTEstHKrPJDWmNddZkR2T0nuJlZaUbFO1uHtU=;
        b=ornC/S4Zpo4zS6mM32QFV+7ksD/S4dzcjSUJRCa34THn+lMOHa1grr5yKntFCQYt5p
         ZWBEJ+pIiN9pvOegdiHbH9MYd4nXWU+gMwJ6aKHOI+5e/WbKCkerDTM/SVo+8a5fMNF8
         Q413kTl80xuQjTdOzo6ai3bFeJ4AJYTXc8O/i7ZQ5LwY85pEaf7eFFhezwhHcbAhOqSI
         dOuCeKwV4J7oOQYWSx/n2oiNUNqByP95ZKNHulaF4Z9pQjIxqoHGdlBIJy6eYqHlizyF
         sOmVmdxvKZkTeX5Q1MIo/bxOTpSch64uEXqENxTea/jacyrs6m9sJsZwRUM3Sn3bkX8j
         74ng==
X-Forwarded-Encrypted: i=1; AJvYcCVGwO9cvMJFqJ/UvrSX3dCvjye8M/VuFJwL8Enwz0yknUATAoIjnqxSWqgaDCpfQ2kUGWRE4IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLyWy2u8VjheCmPSEvwhNHbzq8Fk9TLlB6avwtxYTe5OzC+1b+
	UPY7VPHC+L/5AZHlVKjuiIwhqdUMeuDdPmTYUPkPanrzfBFAXJvAY1uCR2R+lD9D9Eg=
X-Gm-Gg: ASbGnctflpbQWBphdj2ue7flmpRCo9lZAATdV+7Cbx1GJvX2KApQLluVb2u5iPw6EXw
	nztidnNw+dgORFl7xT7gze3CiZ0USnT1RSFqjgqEjlnBjGmdEjIGZc3dySb2SxVvxVOo/OBTdKb
	Rq3cXTcIHyLA/COHNsk+nQGC/EnTNJjDGTrj06+k+4GncqyZi2B0jgYrzg0g9OwXLG2SlOcCF8Z
	S3TDKteoeabgKtUebcDj+gfF8n6u7HPNPGX43gJX2zUHktviFkv6B+eP82w24utqOr9vsbagZqW
	rxbkfG/gA+qRtyzpYWWrULN9ofJSZM478MWvFkMlfbyKQY5fUNKYg3WQuOaIGNLqLVpqbLX8J6m
	TAsGRNMn9BS9mL7lx2UvdH7O60ouRYzP8sA==
X-Google-Smtp-Source: AGHT+IEUsiRokRBvipgW01VTedaC+V39tgfxnOQkDTq4jt3Hr6rMqeQ3rVY4UYjScrCHYSad8Y0i/w==
X-Received: by 2002:a05:6e02:e:b0:3e0:4f30:c951 with SMTP id e9e14a558f8ab-3e282eb1858mr28608415ab.14.1752677775170;
        Wed, 16 Jul 2025 07:56:15 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556536065sm3075868173.26.2025.07.16.07.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:56:14 -0700 (PDT)
Message-ID: <3f0cc5fa-149d-430d-844b-dba70a485ffd@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:56:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/88] 6.1.146-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130754.497128560@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130754.497128560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.146 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.146-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

