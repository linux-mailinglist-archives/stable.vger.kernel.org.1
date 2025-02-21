Return-Path: <stable+bounces-118626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B82A3FE10
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B055F4273A7
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 18:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575E024E4AD;
	Fri, 21 Feb 2025 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hA13xfsr"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0391DF98B;
	Fri, 21 Feb 2025 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740160915; cv=none; b=TvBDywyksTY0k0TQ1H5sYoqqZGmL3Y7V6KmI78Kl5+CQqbsymOKUndyu1Ry01JEnRDl4kbgNV+NBghiuvbrOX9P9V2woYi4WlkBs7eOzCq3Kk4yjtJHAfFO70KcFstYXgH524TEe4ymhkRrD1og4kwzAdANzKGtk4DBNWxIK0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740160915; c=relaxed/simple;
	bh=xK2abE7dId99Kg0nnMRsABxibU1gxsKp6VtQDcyIvQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiiD+DP9gCfKCAH1UQBGJ2LUx0FzkEqdk9vrWNlIvtWVZ/fe/boNuP70PkPc2bn/JFFntKSL4+nxG2MJ4oYcOfkqyu/A4jysegFggehxVqgXG3UswN2B/1LuapjIseO4CjKvQpYX7HOMNetA5NPa7bcL5cRgy1dwf3CWLl5yHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hA13xfsr; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2bc79a81e6bso674674fac.0;
        Fri, 21 Feb 2025 10:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740160913; x=1740765713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E4FDHLTC0qLTxlBy/OkCpWWyQCJJcEAsVkARFMFcw+I=;
        b=hA13xfsr9Mtx3Qmw4uv+5NwP5U/H8JUKzUzMEZ0ntDvF4fK2++aqdh5iNDTQS0C7ma
         xcrfwmmnx4jJijBy89RwYxMJKNvzrIEbHVnFWOkxmUbzTsPGSbQVjZn0MMN73WyaweQO
         BteET8m/R3Kt3V1FQHXMyGsBXBLzS3sWwNWF5DUzEekobEkcftTSKeQphh/k4rAtT4GY
         I0gsEBJR2aFDyaW7aAaJ2LV71GJO3LVp7jpv3zjNbNqwsaXSeFadqVd3SHwTvK4cw3RX
         6RDIAoRaG0/bDF/yhuVuLqxR40weBHp5FpJGd15QV6kAh+G/vALIdAW0wb7c0BHPPpdu
         hGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740160913; x=1740765713;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4FDHLTC0qLTxlBy/OkCpWWyQCJJcEAsVkARFMFcw+I=;
        b=ja70FFNsa6b7DKIT3+A40cSWrRjqbdWOCpK46Va4dgW2D3DNyVIQgLHBHi7IKWT4c5
         eOUQzMaeJOHWn/7MIDm9sZNdW565Ly+MZuLoImGS7wzIJx11iwWtTQcXMAkrZDTD3VhJ
         Omodc4CfMDR4dRkgWFBNyXMww0HYx6OW4zxggDEnhpqp3cGNBC7erQlVrI591zrlI5JG
         FGCdJc4DvAGiZqktSDEjBdb7Uam9g1OQhQaGfjU9Tc/mzhxtVcy8rAcFrouHguShQ85T
         2Frv3vq+Zg7gxdGO0nZxizgIz7dW1U0mjhKc0sI2FKkHe17kjKWXuPS5TeQHU5rwbMoT
         ZDyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMbF9QICS6i3fC43H6HxnrDcxZqUIXbImprXqzJOQUsXN5Kt8IRxckFsdXbe+W8aHHm9s/gQuI@vger.kernel.org, AJvYcCVtyIY/SW7P+VoZvif00TNqJ736iOIiVoLvL0bAOYaDEKd9hFEQvIlpMlIrFX6qYBxSAHfOzxMc+KS9DqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzaa53SOHBl09S+iFIHxyRY0FS6EoV+ZIBTWRZEvFpAEU7oiIK
	/iSJT+W9QE+UKDDw93M000gfzNHJ+zk/r5ZMWny1WCW/n5tgQ9k7
X-Gm-Gg: ASbGncvKSeNhwa3uxf6PEAZjH3YpSvgygCxifidYZiOIOIWsfW7Baa5vC2Spf7hJAgl
	VytQZCHaMrmwDfmTRj3A4bbk/6uNk6NcOP26NWs/+LfptS3Y5ERSE0G9isQxhialWk642s3LwNm
	zuVKXQuB3GUasS97SCM1gr0ouPkWfICno/RTl2R6HddkR+ctlLiZpMMaJUr00iyRjvvv9BBS4bF
	Koa2LhYCjhDjvFxXJYh4Z6DM5Q7qOjEW0ZWGkidDM43TJStoNp8QgvXWdGDdZEXVsGu4U8Tm0CV
	GUC7fGfoYJHk3ThLjWC0nXIS1uvH+fCLur9Z8uhLzbMrq0NSDI2uMg==
X-Google-Smtp-Source: AGHT+IHsFnCKIzi6WuFVASwQmthHRMuJ7iXdlofe+e+uKgr7mtqHXKOxVDDiDvD52SzyUGYiU12CnQ==
X-Received: by 2002:a05:6870:f815:b0:29e:3132:5897 with SMTP id 586e51a60fabf-2bd50c5a426mr3634160fac.5.1740160912743;
        Fri, 21 Feb 2025 10:01:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b95a7b5495sm7015941fac.36.2025.02.21.10.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:01:49 -0800 (PST)
Message-ID: <53c3cd38-03d7-4264-9b5a-4ea885bc141f@gmail.com>
Date: Fri, 21 Feb 2025 10:01:46 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/152] 6.6.79-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250219082550.014812078@linuxfoundation.org>
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
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 00:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.79 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.79-rc1.gz
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

