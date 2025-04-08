Return-Path: <stable+bounces-131851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520CAA81742
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 22:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796AE4E24FB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 20:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02D4255250;
	Tue,  8 Apr 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNhH+Kx2"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD6255243;
	Tue,  8 Apr 2025 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145739; cv=none; b=czyNUfo4/zNUSUVFv/eYvv2wMJQ3LJgcXJ8Y+QkwH3f5gC5IUfDXAKdwg5jbVIt1aPiOv6wp8jzAk0bApA1AlBzcaQ9dDEXchtJXHFjKGZ5lBKIsmkRzpR+7tM8Dl+5SI/TuDTSdSWkIg/zESWrudHOSWkaHSt+LXkXyX8qDPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145739; c=relaxed/simple;
	bh=iOxNRJc0WXEIMK79EXVfvMEpc84T6S4BQZVnIq/OHQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B74aSEnbYjAcfB5ZU0/8iWTEekhLa6QWlSLgf1jkVkPgGd3F5FcnmQcE/eQU1oFoEOqLIpt6Bdr4syQBCi/ax/sq0bM2ZORW9iiO53kEc05FLOzobB/vgMIrODlrChz2TcJS4sUNYve7eo618cI8M+ulRgLfv5UcKS/HyhfGwcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNhH+Kx2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3fbaa18b810so1896659b6e.2;
        Tue, 08 Apr 2025 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744145736; x=1744750536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NnVz+cffqMT5bt+OlszMM6LQ0gX2IA0dtLrnQm9Cdvo=;
        b=dNhH+Kx2VA5P+JYM+u5+iVQg+pcIm81EJ63NfwIJ3gq4T0Do2pD9irwB/utrPX9QiB
         Xvdo4v0/+FEJJSOY0CgY3Q0vRxmxxEh8ygo4soP5AU84FmT12RJoXwwXjXUCCIUvamaL
         5TteVUGAd1CMgW7w5MDE6m8u/gZeGMIeYKPFRDy9vDe/noXsqQ3JiS/gQdLG7lMe+ECp
         Mn4Ldl4NNJQiIe0Eg7Lc9aVlkedZO2ez7hJtx+ZInAs9MCXIWh5HzIIXdcP8cNINWDWJ
         BVMQfwe7yj+N42aSh+XH0+83ROVRgt5Gyu68HPt1kGONXMCFiotiE8khd6ORlG66zamt
         vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744145736; x=1744750536;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnVz+cffqMT5bt+OlszMM6LQ0gX2IA0dtLrnQm9Cdvo=;
        b=tRELP1O2KZqf4bf/gb4+RH0C+IZRAx/Vj8rpdk4qmLfCWkVdklBVUYNY0bP7phUMHI
         y/J5ps5NRCvRG9OhQ4wH86XwIPaYIagGiP9/TT5Xkt70kmNJf8BfPeNLPAS7QV1/tzwi
         QhEZV35FRnoM1vsl71K2tisECgEO8CKd4GymGGB3Nexz1r/YxnFID70nDuWx92x99myf
         MrfIgyWSHU+6z8yApYoCpR6B2F4iL7cfy77yVk7ts9ALusghNehrZ6MXxE+wRzHg/vPg
         0EWEZI1ZvefSMv6p/BPuCuNtHT+3U5RG2NT2WMoWJkLgmW792LIVuhvT2ddTzzJBwNxr
         x0HA==
X-Forwarded-Encrypted: i=1; AJvYcCV79Ns72ovX6iBm0dDP41m3EZyeFVsVLNekf1+ntTnB3rfkP/vqNdOOYkSKgLP2HQxbB3hlMgTKZ4mz7S4=@vger.kernel.org, AJvYcCXGJhUqZfD8zm2nTQdHqkz/1NNDPDVNKPlNS9xlaHzgGOegB2DEHIsk8oggGzp+paxSwomorXbd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7OPjw6YLQdMSJXeNOg9vzrVC4rvzdSnrULqENXG+tqcLj1O/
	NboVPTHkrsh3Y5tX6z0n7yYX4WAHE4f9Ik0XcA5Od/fpka0qaF0I
X-Gm-Gg: ASbGncvS4DRmw00z3V2ZkpxWOSLiqN9ktMdpqBsv7tiyeEbzVz3ZNXuFPssf2lsd98O
	nmdZSKyNWNaJtdO+a0AGQUs5KWV5Hu0DWfEPyb6PBjMg6XAfq8CCWwsE7OTw+ySwj8PS2z2Xb9o
	wBDBTZpR9CY4G5vbtOg9LrFDmIR/LBAFNiyiRFyJP9VdH+FZ/1exg3p8pvZn2GRMAG+JXXPW6nU
	kSrTwkvPI4VKEpvV+S6Fg+AQBfRF09mng/fkq3brBd/b2sZVPLS1J92CzaZzHBr67fM6zGZom6s
	Zif80QXZyEKzyPv6i+qkx79MhexRhdcPDjqxz/tM3jGl1GpBLZ5HHnY3X8O7rM17/uc3tIl4
X-Google-Smtp-Source: AGHT+IHxEjVdkIdDAgYSHiRW2k6YrGT+r6JpcU6wkmLMD3ZM85dPF2EMopCGR6mYbf+vwGe1bIzQzQ==
X-Received: by 2002:a05:6808:22ac:b0:3f6:a476:f7d3 with SMTP id 5614622812f47-400740111ebmr59183b6e.9.1744145735911;
        Tue, 08 Apr 2025 13:55:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6044f4bf7a3sm598835eaf.23.2025.04.08.13.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 13:55:35 -0700 (PDT)
Message-ID: <84133fc1-d312-4058-95ae-f12b68d1b889@gmail.com>
Date: Tue, 8 Apr 2025 13:55:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/227] 5.10.236-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104820.353768086@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCZ7gLLgUJMbXO7gAKCRBhV5kVtWN2DlsbAJ9zUK0VNvlLPOclJV3YM5HQ
 LkaemACgkF/tnkq2cL6CVpOk3NexhMLw2xzOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJn
 uAtCBQkxtc7uAAoJEGFXmRW1Y3YOJHUAoLuIJDcJtl7ZksBQa+n2T7T5zXoZAJ9EnFa2JZh7
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 03:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.236 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.236-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

