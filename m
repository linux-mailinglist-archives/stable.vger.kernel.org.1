Return-Path: <stable+bounces-176434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40685B37375
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 21:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31964189C20F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EDA3164B0;
	Tue, 26 Aug 2025 19:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYO6S2Tm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578081FF1C4;
	Tue, 26 Aug 2025 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238146; cv=none; b=q1pHBcLrSd7QGW1k3a06o1lF9pyjllZto5deg6QLQ/qUwO+ZYfNtpOrJg2lxFLzo4X5oDTqsuSYJ209669N7QpU7Vo4SOiv9vLpIEpFtziodhfBs8Q7a2hs5lGn5K6tqvLVoLZWIDWuauUAdIeTEz9poA+cRDvaM9sEt8CsdFiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238146; c=relaxed/simple;
	bh=Vpfyu4NPdnzd9uqNThPbF7jiacLNikWVgUA0cpZAZc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWy4LeF8ERi4R1yVUSxLtCQ+2eFHFIGV8pzHs7H0QquW6SbyMNTSNYu2nXhCuhrzbg9aW2NuN+vF4cbHVRtO+/UP9w6Yj80PMWeOHQ37FMDbKM52fXNbpsN9Cz28jZ59N0jSYFKP3UmkosgqZglZuwlC61uaaD4L9I/Evk1nVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYO6S2Tm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b1098f9ed9so44022911cf.0;
        Tue, 26 Aug 2025 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756238144; x=1756842944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UVH8JQ7MGDoKY9UT6JkPsJuZOOfQY3APeyp3CLg8ACs=;
        b=OYO6S2TmyOcwpIqAg72uKd9edX1NoH4fiOMzRoLPEUzHGNErMXtPf/6gFDXAJi46lt
         utKfJQ+EVaHxpvJpFBfXH63THlpvBHyaHwjcTP4AmWrgyPoAqcy4i6yboXaxBbcdS4DT
         F6D7ytd3/NKAAK3Ihmxh1h85Wue69wA5mo7AZhKLCz/PTkD9zOAzP3FhGM+NrQ6/bBmV
         AUNOQr/2mtHmZV5iJuWz99riHgEkBpUg1QJ7ZqKKDkptWaccS77B2I4Pb73aDttf0jdc
         Zx8hRBJ1PkxQe5LNuC5QZD9rneg6ftK+Ye1bLYBpNRVBwEeA1N6I1h+pt9uW8KwHlEeN
         reuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756238144; x=1756842944;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVH8JQ7MGDoKY9UT6JkPsJuZOOfQY3APeyp3CLg8ACs=;
        b=Io6smbnfaeBEyXfrS4rVVWF0l1gUfQO/frg2Xge2icJC93UOSczYRiYpOB9ychdfZp
         mxq+KE4LFDl2mefNsPXTncO8683VnBHV0OD0Mdbnut64+vmcv1BX0fW2aoRZwe4kahlB
         ALkT/+q2hbZeYUsP6pQRunEzMwFF3PPdtlepAXGFO0UypRa/QX8ipdowLmsphdw8brZb
         rjc4ZFiyXI1VlBCtK6E+3BJbiuoHCHR8gEI1VBRFAN0KXYEatQXy8bBec24qV+ft16el
         lObPm0MHx8m/Atv1DwCJpvmVB0vPSjSH5r6IotZX1SNl/O00Qv7QZuGeePuDQvRZoPnt
         rIgg==
X-Forwarded-Encrypted: i=1; AJvYcCXHNqbNwIWNv7pslHN3OFec7lhDoWav6Wrn3p+ql0d3f9R4VemPvO5E7JuhCNTdir9t5jNoeH8Buq1wNY0=@vger.kernel.org, AJvYcCXOsFBzoFK7/frVL8GZWyl6a/O9D7JtNE9IAW1RM7MwERe5oOCjg9lPZll2ABscbqVYCYQKCD5q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxes56s35/AOvMfUAxRIg8brMFvEXNp/G+05tIMqq0ikNkWqa8S
	MSLWf8b/sbZ6paWFKyvA8p8BW5YQz5ZPKqKrQrL6ipyuBStugnaqCNpN
X-Gm-Gg: ASbGnctBhZ4iG8Odalfg7Qy4oDiOYLLtM/ISrmqfLBiRxLxsWCG7O5hu6NPntjQpIE4
	WvwUciHey5pXCQsGN+u/m9ShxF20I2z3uiTMKXuS6XrR2xBlZjyRJSCSgHhFmqOlbhn9C4pZN2u
	BZirkpp4pAg47yZGLGw/IXg9ZYowt+sX3d23WTS0bfjEQxP10PeUbYse1NJN/JWhC58ES3Hzqgv
	9HvKQ4lIHC6Nvp+jfyDYkoQKNtj1n0cQWJ7EFrKvNU8Q8xUyaGtrqQnSN77A25WFjUo12n+tR3k
	nplnneC3exGbqj/5PrzSXfqHO6a9ds/haHJXonYyCFi9B7FcCzXZciYVvWgJmYod7+Mh0dpMN0l
	nTvXnHyBNhxboVEc7pgO6QKx1fDeGAyOPuyqUKwD9T5wMB196IUVrlCeZc1XE
X-Google-Smtp-Source: AGHT+IGjmrGHQ3/F4QIMSDClatJx9+dntn9vE+x444jydG55BysUGK2+aizCRI+SQPY3+J/XVWrjYw==
X-Received: by 2002:ac8:5e10:0:b0:4b0:b7d2:763f with SMTP id d75a77b69052e-4b2aab20bb8mr207016831cf.47.1756238143872;
        Tue, 26 Aug 2025 12:55:43 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e70fd2sm75011751cf.57.2025.08.26.12.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:55:43 -0700 (PDT)
Message-ID: <70e96b60-f449-4455-934c-8447f968ea7e@gmail.com>
Date: Tue, 26 Aug 2025 12:55:38 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250826110915.169062587@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 04:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.44-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

