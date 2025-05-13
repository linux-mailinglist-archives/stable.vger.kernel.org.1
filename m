Return-Path: <stable+bounces-144164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93249AB5510
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 14:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1747017A122
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 12:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C86F24EA90;
	Tue, 13 May 2025 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVnWv4GR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731B5433C8;
	Tue, 13 May 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747140072; cv=none; b=jR3AYeE5P5HwGO01LFCbBNYn97hZh4rZ7GwHdXenhoS9OFRpr2cU7+eBesaPynz6i6unLJcIe2rmFWvPzns5CbPizVR0p0atC0MqR/5zdy6D1UZZpKxsHRLgFgrzgaWif7I4GglKynM1fw7rdA+7CntLubnEyCJu+jobSDIMCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747140072; c=relaxed/simple;
	bh=JISFqz2cA0a7f3922N1IeHJedUP3h48dOEe1dzWJ2ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2UMv7p1bVOlsfumZriFW8T97YIfFpDWelA2337uHKqTZoKg/gxzdI4+N3Im6EPptyNRdxQb8E3QWVtRpZLvr27dVxtwIk3AbQk8jwa7YGVX19dKWP2U7Vgn2D6/SyOMwWksAnZNdoVLX66JTkRWYsDbPS/14ZtdRU9OaHtuCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVnWv4GR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736c277331eso5800730b3a.1;
        Tue, 13 May 2025 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747140070; x=1747744870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bd9UlH4zs5u8+x3Qt1weohrUL2/uFJWKaLnVhGkrJVQ=;
        b=MVnWv4GRxv3Gy4k6pracivmlsrgeHF5Ehcaz+zDoOBZunH3S73cAiuFvGOWU/GcK/y
         6EAgu7FIj7UBpIkZnnAcZJwaFAErCY2UoQk3ls0aJc5OU/IJ+9sP9RxokE+lyR6318Qh
         bwTIWKH47bzvT6PANpuroD/AOYnax45l7JvuTC1PL+kpkYzpv+iJNZDifrvLgbxz8P4R
         132Zb/gw9CS4zqvg9TXozXi/373NNxIrlt2Oj1YixfOHXRApNQMaI69caWBqOI1D/Xt8
         oe9CM4I44J1MUjlbwjK24Uq0GsWmOtsiyvnjEZIfTOmafSlzG8WjnlDe3c/TZkqN9HC9
         kuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747140070; x=1747744870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bd9UlH4zs5u8+x3Qt1weohrUL2/uFJWKaLnVhGkrJVQ=;
        b=MIlnm/8qxU79fHtPIyEkRotZXgxmEq1wmDmEQQMM2+4lDG2BSEm7i7AWq5u1O6WVNj
         s+Fsjcjwseff+tLIaU/LbwpdVHMB3OZBEToLsLb25DB4JUfyN+lyc4nGxxM8tEzJiybn
         V9nJyh6tX2Z60200uZkjLMFO8tlN0uQrc5I8raqPQWEwsMX/SnTMptmwKS+vNw03XOtk
         E+Jy0a1Nx5cS7dOcwWTxyZ7R5zdD98bPSnIs9aas6GUHlp9muquVb4TUGFTBi4Zav7y3
         8xS/e34khFOEi6cRzRZPU6evSHMl3fESW5gJZAOzQLvAeCDjWPZG0berUI7ReZ/V4Ml/
         S5cg==
X-Forwarded-Encrypted: i=1; AJvYcCWTcmJlKKITOr2c5XdU0fMASTxXGgJVVdH8YOCv8AbX356PE6QrDqx1TwIPMJLZwm7YEf9wkg0C@vger.kernel.org, AJvYcCXgbQx8JMzeB57CG30Qit4MIAW4PtRTjDUMC6y8G1SsxzyxlOWLfuoXdUtQcJb4v797lZALR+KOz/3IHw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0+b8KXRVqAOBYdfZL577VD/I+sxlGbvVhs4etQKB6uPU+VVIQ
	9HojFQVztrJYbOGnBZ8pKo7QLY4/yq7jMwnuut9Y1C3s6ss9ARF8sEv82NID
X-Gm-Gg: ASbGnctNRkIdZl9ngMqAP70VQCeY2TqXz3U0xRhgkJMYKOXTWKsEMy/6/HWkyq422x4
	ghBHQXklqrlJi2P3HA854IinFTx8rJqmakExmukaRbCavGOs9AXc9xGQHnpim/Lp4qovWPijDw7
	ylZco21XyhRd0IDHmY5ZPs1VQbEYLTu5HW5Q7zPo0fGVT6qe9cLvJ8GYVylzJjWWJpxJ3AR42lC
	jTQLMx9Kyq4tHqculUWx/41YVq/iU/87OxkaPMKPGdfR45mDUpUREaCajDNM43RS63aKbOo2Jhm
	neeZMXQt/r9hDH7ESjKiRCyL8D0CClnnTX/QEI+xWpzVJzaU46CkX9zzOMi6x8icyA2e74krudR
	eZUjXxfpIkQIvMFJodeepJQh0oejMxx04XYc6XA==
X-Google-Smtp-Source: AGHT+IFuXNamy6yvaC4RvY3tYndeRO32yoAe6Ahb6JCwtFYauOhRPmpL8s0mAxZzvLPkKLZ4TvdDzA==
X-Received: by 2002:a05:6a21:a45:b0:215:d1dd:df4c with SMTP id adf61e73a8af0-215eb7262eemr4886882637.6.1747140069544;
        Tue, 13 May 2025 05:41:09 -0700 (PDT)
Received: from [192.168.1.24] (90-47-60-187.ftth.fr.orangecustomers.net. [90.47.60.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a38c1dsm7615233b3a.124.2025.05.13.05.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 05:41:08 -0700 (PDT)
Message-ID: <a8b6fe44-1152-45f6-9799-597525f38792@gmail.com>
Date: Tue, 13 May 2025 14:41:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/184] 6.12.29-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172041.624042835@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/12/2025 7:43 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.29 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.29-rc1.gz
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


