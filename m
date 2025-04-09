Return-Path: <stable+bounces-132005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0FBA83302
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 23:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9627D8A148C
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 21:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD972139CE;
	Wed,  9 Apr 2025 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICOzqR9V"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781E213E6A;
	Wed,  9 Apr 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744232979; cv=none; b=XcS7wanyWvyIwlhX3t1a5TrxHnxoClF9dPPXVRefujguZkAgMBTLh4iHstfs12vHJaFp1jHHsUTlcwq6QPhv8LavHtMB70/RCObj4gVMz+iXKkH1ctRq6ndJI9nIsV/n5gQuwA+ws+xHEO743rw8oLwiSZbtn1lhEtjdIJxzzEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744232979; c=relaxed/simple;
	bh=npOuAPpyH/Um40xDjHAG4JSR2Wibx3ZFgE1gWtLaqB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSoGiAFV9GvWt6WTvylnq02T6/FWGYIEVYIBQSCYicJg6Wv+A8GBMzQSZgYVi/OAXEDc+vdR6VbElj2hGX8JDs0tQpfSxHBaUxKiwLM/KptRgi5mb/ZcCyl3kafqnuP4pRkFJJi5Fhe36UHkNjjaESg1Id7wWaFs91mfNE77lI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICOzqR9V; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c7f876b321so20900fac.1;
        Wed, 09 Apr 2025 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744232977; x=1744837777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OcsOlJvzuUmBnCnIKSJZk9oAntTNYm6Dxr4uBw9iEnA=;
        b=ICOzqR9Vixynr4JLRjBVE93sioM7fRtUhzlEZQzZolAiScwqMxmcc5CC5krUhWkDJt
         36ORQXWBn6aVBRglypghIYLWHyeZYiuRWFrBjDPGuzStUIG3E33K3yfKOlHRGFrzPl7G
         XGPGUDyKoGpIlpg/DY6xQWWdLmMEbdcguQCq2YZ6Wh3kf9eYukxBK/QxfFMzczovOew6
         P9FIzch1dvYOuBU314Bo6/D/0c6hVKU0gVty9WbyWLXsDtSFl/ocsZs8nDe78yXAautG
         /CNzpjlDmvkSEA4ZhlfL3zft35PJBYA1N7GYmynXrUx4eXcEGsOpPee+c4q/KfNC3Cw1
         1+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744232977; x=1744837777;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcsOlJvzuUmBnCnIKSJZk9oAntTNYm6Dxr4uBw9iEnA=;
        b=nFmQUPJ2WF4QDpVUld9dOdenC7xOvGN5zxlxW4ZbZpqj9U4KHaCgAculMqrlgCtsNt
         Kz3I1FfJHsvb7vhd1GHaWI75bWCju/p2wNfY4S0KZNouMV9u9QZki+ZaQcMGTq0MTEzh
         dpOh7vQZygm7g1+2eSkLxtD9wdhy2fUvhrXl0mXfB4/ueC1M/Q6PSc6+zwcc2v9Y6eWq
         TmFf1L1aYxvjr3xJHdEggdI7We58e+b275lBPP2oxncEvzzz1mxQzn8KQ9KafcJv8Jbq
         K2KQPVx57bUwVztU1zRbqNsV+b/jppJXRNbL0QMoWtwr9kzJNpRCM4eiievRwCpIZRd0
         syRA==
X-Forwarded-Encrypted: i=1; AJvYcCUxDMuD9INDp0rekagPdWrcH3t4FqshzxEjLsoZS2/PPhXRIv+O4Yy66QOToWsliYh9iwOD5IFADCmXdNk=@vger.kernel.org, AJvYcCXVmMmIo1dHVHHui/6rMqb+1KOGtgIimx2wkH4dwHtrEftei/ZjSfH71MPbmKZPHvKG+NS1crE3@vger.kernel.org
X-Gm-Message-State: AOJu0YxKa07gNYf8WuxZOwmzM9S0GtYvEGg6J3RxGa8bjNPeiG5Z7akm
	Ec5s9vbQUsgQNAL2ynVl5Kq3ehzWm8IBS8enfCYedYc3Kl1Iq4cU
X-Gm-Gg: ASbGnctvX7U+s4rI00h+YjAi64oM48q/f3PMfCMH+vDDbf7C4lGxDnyRl0pYxC2ZfYP
	ybyj6gnYW6JDiXsRAg/ZqispROY+304YbsNRxt/xMJmEGD44+TMkjYcoBP3q7r/MyCJK2jZc9fQ
	6WGulCW30ifICpzOXZLTQAG9U1QzvGfIOBOUPmOTK7gOvirhNqxA1J7v+U7p3k62ivw9mnpUFeM
	AN6d2IvAdIjG5kX6XecZkGlO4LNOfYIjHGW9XxmaX2luZ5oAzvwWTL4usCW8IdTiYLMr6PchBQc
	R7ot4mrOSCXGp5gHajkk5DeeoiKuajVfSFCtv6bxY6u5sTKuTT7pwD408t/S2UFtfmRfphcyi4C
	m9zc=
X-Google-Smtp-Source: AGHT+IFsYYtMT/2CHN4NoAwk+1oLCC1zKs+6BGHSa/NCzTrFMsfXL617zOtbprpxS/Cb783ytTp5Uw==
X-Received: by 2002:a05:6871:6184:b0:29e:3c14:2bb0 with SMTP id 586e51a60fabf-2d0b38456ebmr135237fac.30.1744232976716;
        Wed, 09 Apr 2025 14:09:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73e4d498sm311771a34.50.2025.04.09.14.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 14:09:36 -0700 (PDT)
Message-ID: <f46c9c36-38f6-4d89-ba58-f06f1b1a7557@gmail.com>
Date: Wed, 9 Apr 2025 14:09:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/502] 6.13.11-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115907.324928010@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250409115907.324928010@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 05:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 502 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:58:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.11-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

