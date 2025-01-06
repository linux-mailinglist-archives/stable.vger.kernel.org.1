Return-Path: <stable+bounces-107759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30569A030D9
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE351885FB3
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 19:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BCF1DF27D;
	Mon,  6 Jan 2025 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkzqYFtK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2421DED4C;
	Mon,  6 Jan 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192736; cv=none; b=Ijjyyh8PYjh0djLSbn3l8gtlyBvWx89xy35YxYMJiLXk7GtUo4lYb6OoNi8iFc4jQ7j3w5lNCeAxpry8d6N5taKXLgUSy2VBFlK6XdOlJFy238uUjL6ENbAJpDB1uQaDSg0POGPe+49OZ0HklCBJZMMR5gHiN4qeMX0X7NHLnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192736; c=relaxed/simple;
	bh=IWcJ929/9inRj5jhjgQxzqfgzV7m01g5j7K5dy7Ow9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avSuFNY12PFqEw4jzuuEwBIE5xKgVp/CnGpwU10sRWq8WONI0QkOW5QDl9OeVrUWm9Up6UhV9k1r9nsyOHLAtdJPgVweCQBktn8jmRXteRbO2k//YovgmfHTN4Yz/1MhkTz3yjMJVM9nIV8SUllBIwEWecLDAXgbJ383gKC9zbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkzqYFtK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163b0c09afso211596425ad.0;
        Mon, 06 Jan 2025 11:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736192733; x=1736797533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pOQbHTIpJwowN7PSlF4vQq7w1O+77ce6EHIhiyVp8N8=;
        b=lkzqYFtK06KkCtTTrCy/lFObW1ehEIF7cyMpaBmJXJcy3uPf8WO6/yiDtVhqxeTYO9
         otSoLZMLKQE0DP+FqD8FT+EeAwQVWE0Zw/hSGIJ49AtnHfjEqauLkKxSPNfuVFSetmfh
         BghLvm7Umn9+3dV74nvCyedH13Q/yfqBnK5iJn6I+KMrnp9Dft9n9JKvT5BId/hkf92X
         Ogz1NVfq5y4NzmkXc1naeO7+tIcuUi37kdRxSvA81AvQ6IOoQCB2DqcVqzwytic/pAmt
         5/5o9lolvEtBfYe952WlECfFdZQ2/lcD3zkF3sOzPuVW0U4hVphrFGD7TWgNSUamw3xe
         M8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736192733; x=1736797533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOQbHTIpJwowN7PSlF4vQq7w1O+77ce6EHIhiyVp8N8=;
        b=aCXf0vVw8mwUWefjkz2OIydKV4uxhpP7dJO8VYSu50eqX547uar8AYTp15xF2e1sc6
         YXXSJYvHExkrOzYv9Sjy/4z4lr9S30ypRJNdCGDzmzRs7NABP03BBDRtltiy9soOWNHB
         lTtVTqJvcNWjH7dEZ3ztXFRdROR/Q6uZIj9+4FdD2VuYtC/9AMQIy7I69R2V4JMbOgmR
         D0SaedCbtvXNpiVHy84jYtxh4HMWHqHyTgO6hxEH5lqGkBbbPAST8mQMFEYPI4YkyczZ
         fqogGwXuOBpGPBCamBOCftv6y6XKaT8vMfJg08xDoKD/xSMgNx//gJHgYKo6Pe/e4EaU
         xU7g==
X-Forwarded-Encrypted: i=1; AJvYcCUMh27sqtZuiYo5mYpcDO2kdlwMqcvnQUQ0afSQEo6/5PiEK/SCqna1o8BggDWSv/5wDx2mUcr1@vger.kernel.org, AJvYcCWhJcuyw6zJY//buY5aZJ6JUbqVmcTj2qvKpBCiAL9Qc2QLrK7l4kIzSA5mAB4qDHZd7pG+kByoxeGYeJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcMCuZmPIIGZEhihcTTa1WYwDJyt38dIeemuQLJfwFWgSHaO52
	KsTSwI1HfSwz52cXJpLTLOAhdGiFptY/l2Q6zTmg2oRMPp4k/agN
X-Gm-Gg: ASbGnctYHLb7bW6vIgUszlg63WlRCyQMV7WERyKbnAqxtLvcnGRouGvNE1LkgMgjbaK
	wCTl3U7Vg9SJ8/+yikfuNSB4Yk7oNZ5S/uLtFZUY4HScR0vEIPUkstGwFJ0PvXEBG5ixl+fEI05
	TXmGXn53b0l5Vx15uPX1Z47d/xLd2rr4X/d6x5kfBqwm62cVTycZQxiMYrBTvrWRfkfTgXQOkvc
	9cidQjjAy315ym+qji8HNz7Z58nvlytwLJ78COke3JWXPIepgZ3oj/F8D7u756zZ73xJO+L9kWU
	E+boc4d8
X-Google-Smtp-Source: AGHT+IG+H/BD87SJUjPNTCGw985rgYSu3/rv+yovjdRlhXccpwI7SucI25+vhhhZDV3j8Tow7PDmYw==
X-Received: by 2002:a17:902:d481:b0:216:770e:f46 with SMTP id d9443c01a7336-219e6f26692mr817731815ad.54.1736192733026;
        Mon, 06 Jan 2025 11:45:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdeabsm286631335ad.125.2025.01.06.11.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 11:45:31 -0800 (PST)
Message-ID: <449fcb1a-9e16-4e25-84ee-e10db7ca1440@gmail.com>
Date: Mon, 6 Jan 2025 11:45:29 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/168] 5.15.176-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151138.451846855@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 07:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.176 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.176-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

