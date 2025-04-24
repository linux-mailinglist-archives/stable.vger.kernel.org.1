Return-Path: <stable+bounces-136579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C8FA9AE36
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EEF31B664BB
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4CB1CFBC;
	Thu, 24 Apr 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl8Q7G2q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5518AE2;
	Thu, 24 Apr 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499718; cv=none; b=PyC/JB9+Y+hrymyAt7Qn4qIC/YpTlo4XZ27ysgoPpNMKQIdoyCDp8C3ctDbB/jYIscDa4D75VaVsAhVYaXWEzUhPLQQd5z23rtD0Gz8vAVvwTG6E3bxqgnXZ5boD9kMR5QIkIfNr9OmXqc/Ai2OP5xZc2d5jMUrZjYkBOTCSgu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499718; c=relaxed/simple;
	bh=1F2XUYXNrQPB6q9KRQqg72j5fUKRvi6UdnMTwwBvVzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFMxyLBVrbcjEjTSC8bI/1WScocuhuL5X2FgiBmXB1WzYr55+qvbX2kzWwX/U5Mj3OFDEGdWDwVDO+IMEUYgWmRXfV4aJpucbRUZTP3J7lSgT0KCM64XuMKzCugeINPfWN+NXhgIsZmagAn2fKaU9mHuZtrm+b6ioCEZXNwqtFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl8Q7G2q; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72c3b863b8eso817521a34.2;
        Thu, 24 Apr 2025 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745499716; x=1746104516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IXaY0dXhkP+YGC1PjwJEeiUwI092bd5gxHppU4kUvWk=;
        b=Kl8Q7G2qAzZNgMCSbmxAzE8MxKAOCQIwXe3djE7W1CCdoZ8kEkT8E3SaNGpk/x19S7
         dxQ0wMsTSPeiPBFHbtQGD9/UZsaNE3W1QbMaz6oOPMnGZL1gjSU4tuhSuMxO+3TIT+T9
         6axEokORwZqeeCjmFVEVV5/j/OWS2hWepkTlPKygpgePA1CFj+rP/Cjx/20e2E2zzEDD
         bY4zSHxw6SyQJvxhTBzZMK/P/uCrj36CWIAFB36zVhn2l8OFxD2BXuYprTsNI5NYT3O1
         1s8sqgNIaD1+tXPr9TBv+XRv/Xe69R/YsoLnz5ZsUTFG/KMKcaHRtgP4urcMi+tx6ZXH
         jEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499716; x=1746104516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXaY0dXhkP+YGC1PjwJEeiUwI092bd5gxHppU4kUvWk=;
        b=c/C04OwW/1l5FcI9Vo4YOXPdfTadvDV97j04X2+xFC2LMl3kiXsBgHDHi+EbAzjytq
         Y2CDJcQqh9vdRcT9yU9EV7NTOZbA8m3hR3AFq7ytmWYThDgoaTdfUGmIS/SLbyKe7lnm
         E6aXZ4xqpwlVGNdeAs/zvR3IDXWqdwcE+QAJl4hcMKTgz62xWp+CAl+uEW9SSXu56G9F
         i5Rac/bZvGzvTNvKVqYLMWu6/vw9AINg/tmYybqi1+/EMK6YjOws+9wadELuKCDEd/fn
         I/ArQzlx3YS+yo9JsdcpEpAz88vQ+I5UHu7nDVrAqoRbCUxNvbJNoZx7+FwjB8USQ2sM
         iL3g==
X-Forwarded-Encrypted: i=1; AJvYcCUHUC2+anQuakXq49jY6h9nkv+sjQf5hlSdcMpYr9kYM9xxploB0c7eHjG5qO0dh5J8I7U3zTd3jAVX7jU=@vger.kernel.org, AJvYcCUemcwYxJEipS1gr3GtLx9P3VkXbCZQ43IjHCzHZloiC03GS7+GVGbQY8uIZQnjLjF/k3oIDIJ9@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbfrruTaBsVviVrU8kVhldwOxCbomk2WG+mU9YpYeh22PUhg3
	gtVxJNgdnx4/apNYjb352uBh4NBjwaMGZ2usYv7Ps34vYuKKPsD1
X-Gm-Gg: ASbGncvV2EAcfGzZPDjTfxgLq35kV2E1VUGV+xVgpsJuAKXQRCow1TaUnnVNaiZf9i9
	Ce/l7ugNNLV2a5fGZXkCl3k5UGiFK4ykcJRw3IwuBIGmtIrzDYOlZ+KqhoF1qW2sgzmy4vVmUvy
	BzDHbWi1oG427SmC4sa1VUV7Vskf3W/zN7/jd9i1fRV/klUOQq0OGsK8GAnC/u8AXefTnsWpHI7
	URGv/zrGoCzqIgFQNhq64UkYY+3K3aIsKfl+nPOPte43e4W0ajwpRXB1fH1VJ7CcCDjXwdH5exy
	G8BWo0I8uF/7QpTetQ1dAPkNeZHXaKoZD1b/XF7437NONO5AaHmQ
X-Google-Smtp-Source: AGHT+IFsO2jlMyW9MQpU2D5+LIkus/y6+yDCGP6+lPB6USYbWWKD/czpTi1UjozahQH8xn+1rnbviw==
X-Received: by 2002:a05:6830:620b:b0:72c:3289:827d with SMTP id 46e09a7af769-7304db526b4mr1557962a34.18.1745499715418;
        Thu, 24 Apr 2025 06:01:55 -0700 (PDT)
Received: from [10.54.6.12] ([89.207.171.92])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f3986besm219178a34.60.2025.04.24.06.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 06:01:54 -0700 (PDT)
Message-ID: <7146c07f-ada8-4c07-a52c-f5c7922f2e6f@gmail.com>
Date: Thu, 24 Apr 2025 15:01:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/393] 6.6.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250423142643.246005366@linuxfoundation.org>
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
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/2025 4:38 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.88 release.
> There are 393 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.88-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


