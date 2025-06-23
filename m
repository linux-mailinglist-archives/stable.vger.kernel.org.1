Return-Path: <stable+bounces-157800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36EAE55A3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570311BC5D10
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B5226888;
	Mon, 23 Jun 2025 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0OwI887"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E6B676;
	Mon, 23 Jun 2025 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716751; cv=none; b=YVn7tY3iv/0HpsxwBzpwqJNGFYJdPHjcVmtjmdMHy4w9mo71x3oXQd1+TAx7F6UgBTj13gMMEDKRW2yXyA+TAOle0Y6itSlYG8Yev6BnahwzuLpr2plIJ9xt1cIi+OiBaMp3wu3QgXd5FhopkTrc2Dv/nmg7gwSfmdTpn3W6vcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716751; c=relaxed/simple;
	bh=vX8V9d5czqB7qJFtk/cKvJmbgNp7qUz5USbg6t/IFEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sfev0LOdsLP+0vrC8/qogAfbzOKpqTyDGdwBLlek7koyyvsLDcdEzhgxQZiKt4SFckPaqVadNi/4sU7IDVzf02L8O6cGbpfcrK88S9BOjQXt4jz6d+avMtBOr1fab30EQTooc0cxvbbA7Ht51gnIHl+ruLZfgTD0NLMOxrZ3ChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0OwI887; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so5317386b3a.2;
        Mon, 23 Jun 2025 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750716749; x=1751321549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rNNk9iay4TFsaR3oROHDPyt7j9eK6fHVYAQhw0ci6+U=;
        b=S0OwI887Mi+S73obchApej0WKlYKy1cXfi3ZGs6Rp/DZdsMgoKdrI37kKZF+qOqpJV
         fxWq8iAo+hgcW2jmrFlAcUnJkpDg62DncFfRQTroykN1E4Zx0gVF+ZlhK6VAH5QCIIKq
         qawwoRu6EAdkyUJ4xyTnarZLNyUqoq03Ysl/Kz01lGANv2KkpnWABHnh5RJ+sKVHCLZv
         DJUHoj1UgqOy/GHeL1sSgI+P6MpoHGxHZn4g8UBtX50ZpORbsSAn/4NSpOm/ebnpMmMf
         7JqmpcRjQDc3eCi6+c10ZDpSwo5coS+VKpuq8CEwoY8K5Gzn62O/evOJnefo+DQchHuz
         CdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750716749; x=1751321549;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNNk9iay4TFsaR3oROHDPyt7j9eK6fHVYAQhw0ci6+U=;
        b=pslJlvTMaBuEkbm3+IiWChrrh6nPpWwWMA3gfbkURnjINTX2iuyOlXRuBKkt+Jy42x
         iTQ1PtoVBMYxZDNxvouONHT62NVs3ptzfwf2woUbMKf4928eGXLhybEaMgKCKYaCjrPQ
         dBEoIG31G/mY3oPb18PK6a0m+kcuRzNQj6zunS+QDeEiUAhbx4ibiMD8k0UjV5NiC+fT
         /5FPtWyI+9BsD0rPGwZegVtfh5aqNeQ8FyM2++fizjBcVGN0LuLhxIoPgqPaAqM3OgXP
         nrG8zEiGPH1vI3JhToHOtkg2nAdLHaBh1DrhCGrnfL51rqQ1/egmUgdcl+27FzN1A86h
         MPmg==
X-Forwarded-Encrypted: i=1; AJvYcCVyVCSsJRcuZ7k8tmVm8D0krCX2/hh6yQAq0YSyZihRUtGJn8E1FT/4l3zSSn1ZrVflwQH4Fw0i/N3eAaU=@vger.kernel.org, AJvYcCWOQoYnY1CL8D2b5TgmneDuUc+9D8MqaWsNuuEYNtyo7gDmTEygevvTWf8OK4qE7jwjkPHqmDq0@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYatFGP49hRSIN0AA1BxD0uQipqRK2ZNgA+eq19gyNFBNBE96
	A84iemitXVvSHLaqmuV0Mg+sw6WXtrMWcXRAq4R/LEliLnJdIJVJYjfPFhV3SgME
X-Gm-Gg: ASbGncsDaU8d06BszgAnm/mGNj3H/z/EOMJsixN1fRCANIX/JdzOAKxHk/Bhn6unLRS
	7FQnFb84RJikAzvhGF5SSxVlHZr1ZhIMlUnW2Qs1uYH/SZBQKbYS2n/h3XjET7LqiGNH66usJgb
	wQBc4uyU5VArk7GIsIQySmH2KFI9lidd3jbDmZjy9ErN8erKxiPfZ5KAXm5VK963Y55Bh4m2I9E
	juxNl9lWQRcR0fdkYHVlS1xLM3LEX9jmFRo4l1grQo4qBCVE9gVuIqMcmP47S3x2NhZWd0TPGkx
	/GjMmSD//X1BwT+x609GaWKm5VouSGYcVSFq7BOJ5LAopDBTWW2xEL9HTMhiKAvGbeQSmsodVLg
	Rp+4N8Q94zMTu9BiGN0BvfDAl
X-Google-Smtp-Source: AGHT+IFkA9rLLTXE/wzSDCD/eX9kG0gVoLWTteo6t/0lF66T7wkylkPLNX8ySW5Xjw4muC09909y/A==
X-Received: by 2002:a05:6a00:4fc2:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-7490d52ca7cmr21366005b3a.6.1750716749472;
        Mon, 23 Jun 2025 15:12:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f118e851sm7376633a12.4.2025.06.23.15.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 15:12:28 -0700 (PDT)
Message-ID: <2a1bcdf7-a6e9-4035-b85f-123c76e4ca7b@gmail.com>
Date: Mon, 23 Jun 2025 15:12:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/508] 6.1.142-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130645.255320792@linuxfoundation.org>
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
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 06:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.142 release.
> There are 508 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jun 2025 13:05:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.142-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

