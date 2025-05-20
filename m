Return-Path: <stable+bounces-145695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D24ABE27F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 20:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB251BC16D9
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C86B27FB08;
	Tue, 20 May 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWQ9AMbk"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA12262FD6;
	Tue, 20 May 2025 18:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765168; cv=none; b=OtMoCA+SOzsBlQs0pDdNjqyOOEMv56w0Oboo7TNJIbv1hA1dGbNWIp82KXpZMcZAj+AowWziU3Bnokr07b9K6jUkY5iSjt6i3v9/1incIlEip4vNfqcBEYLMOxlrh1Mip5YHrOrdfszBnW4pfm5Cs9K3SsHuHZh6x0cRJoFrxko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765168; c=relaxed/simple;
	bh=IxR++kloUJc3RyylQhbXGp9wRrX6m+pcg5jG15OjKas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dE94eMe2LyAYZZ3JpESHXRgifQjMNQC0lsDbqUHSvRJ9BfsOAezmgQBXWNZyOMBep6kkONtt0qWWas/vw9nwq5T+rI2EGvOdzEHDgSthLNeEcGDU3j8Uk/cGP89lpehobjKh301uu0ISR7fl6Qz/vzPF5FlnJOguiGI9WX2f9FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWQ9AMbk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-231f6af929eso44190685ad.2;
        Tue, 20 May 2025 11:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747765165; x=1748369965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DoKyA3bBBGJsvFy+XPHReVuHpiex51sJQBrZyjvoQcc=;
        b=lWQ9AMbk/zEZe3n5BURY22o+SzlHHUSIoZ6+NSSaRJmsAQLSqSRawwB8A8lLNnM3Xi
         nqg8MUBuRtHYt8i4yP6vRrImSiqe6F8xHD90AUnLjnYglTpaoe++RbRlywJHPqKYtzQy
         rc7LSLx8xZ0AFICfm4/12ffNcQw8nuMhsj4p4P1MknppCiuqST6ZpzVLFLA1t2yhe0wL
         gZVYuWgjltK26b4bekB7lXCU0zNCF944qDdoYVjUVLKATMbYEQwJo+mk1VLwnoMlLOmr
         JTot5uMD7yhGmMMwDT43+Qda3s23Cni90/rmu2Edb+X7S8n/zk1gjfAQW2owenmpQBZv
         HK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747765165; x=1748369965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoKyA3bBBGJsvFy+XPHReVuHpiex51sJQBrZyjvoQcc=;
        b=K6bYSDI2UTPH45oiFXrHx59MXg5vbSx3nbDZ18SMG3s4gRAZ1UXATvnRvgUBjanwy4
         +rKUrU1y0mHLdAGr+TlhdNwMyxt7rcmaPsfpQmD+E5tGhhiGDYMJ0jxwVNqhZACN6sd8
         D2s/Mvw7ibppZY5N8XyKH8haGkUU9QgZqhKEoe0dx6ioIAT3J054iSixnjhKmz4zfVyD
         R1dEPSYj/b27yz2ItGABBL9WzMxqTMjryf72bOGFSk9eC+FN1NvGlVbOHqICf2DkUWUd
         72wRV9yJUiCIN2TRFdsqwhqOlmUpgG4BdxbRgO8Vn2fL+HdK7gjKu6A9vHesjE5Rco9X
         2o9w==
X-Forwarded-Encrypted: i=1; AJvYcCUBTX0BE5XFrTfyR9Tj3VLMTrxBSdL+0WyJo1HYhjfjFOwwHRHd7nzcikvdAIjMZHDs9X+9QugP@vger.kernel.org, AJvYcCWY0azZj7yFMjQhVCZQySwzzYappe4puu/7NFKMGII89kYxIkTgirasG17PpczjfeDJ0KelJKlUbZPIL5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzppPtm1swE2sTaglF6OBVhHT2snbHHIg8hxsM3WnPUbthjLX5b
	B9PCqe+jF1N4EqXWEZJHkKp6LedyodMVIENxUZlXSk/tfXQixL9trVpD
X-Gm-Gg: ASbGncsEG0bgumh3dC3YliEyyFfg3tVRA6Pc26AvhL3c7u6QeLSF/nrCSfjlbgP7A9e
	jJtUWzRFU7P/rocQOwCDf+CXb42sv/Mqn7+B2l3n7SW4XWLKaB3RJu0mUnftSGrFSnFm0bVMf6G
	lspMvl/8eJI4rt3l0eqj9jiM/yn1Ob7QWdpQHBm8D757x3qUxBi53xjUq5YlTI/T7jPuM2hMmN8
	rHt35PZ1cwwZmMiB49CsZbazxFY4d6QSg/QNkCGwezjUxph2ZTOw0y6tcOFgLJV+zayi826lGS6
	eK4OQkHJ/pgUHbfu8oNwBTvfFKn3IklnD5q17Nfidz8Swo2l44wFWZ3wn1ke3x1xPanM61XBD3Q
	ezAvG6Gys+omRPQ==
X-Google-Smtp-Source: AGHT+IGwQsi+8LxueG7nm1aZmo1UnaHvJZf+HsSsQQMtspoPLyCUE/TSSuNXzyEMuI5THrd+rgbtxg==
X-Received: by 2002:a17:902:ce01:b0:224:194c:6942 with SMTP id d9443c01a7336-231d452d6e8mr274361115ad.34.1747765165516;
        Tue, 20 May 2025 11:19:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed255dsm79721135ad.213.2025.05.20.11.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 11:19:24 -0700 (PDT)
Message-ID: <cedb87c7-cb1e-450b-8d83-62b2d39ceea3@gmail.com>
Date: Tue, 20 May 2025 11:19:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/59] 5.15.184-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125753.836407405@linuxfoundation.org>
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
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.184 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.184-rc1.gz
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

