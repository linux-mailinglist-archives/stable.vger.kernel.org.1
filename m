Return-Path: <stable+bounces-158704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 589D2AEA46F
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 19:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381791C25402
	for <lists+stable@lfdr.de>; Thu, 26 Jun 2025 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1231E20D4F2;
	Thu, 26 Jun 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAxfxP94"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8162F1C5D55;
	Thu, 26 Jun 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959211; cv=none; b=j5isCSsfx6VKlXu6aSshmqQ0OkI/ekJEdviLWYxuyE9I93fW8D14zjClj3+rC0WrjS6JL2upO+G+woNzdJhxp3dICJhvZ7ruKZ5D/d67DExvLiV63arjEg/jn/ZBMw9C66qGds7CnzhM7vD6q2cq9nO49sL1PiU5NP+uKRW4gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959211; c=relaxed/simple;
	bh=zm90ABypoBui1WOoW9+0AA47chVc53mgeVPJkHtakks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI1chA0AMm19T4cFlaohMUo1ZenpODijau2xMaAi6wl7rz8BzETjxXybw67yXB1xMzM+0Kk1zvLpy9CR2BcPzGJFp7A2Il3zc7jerbQkXPpxtNe8iMWakJlkqpn7YObbQ7XtJVAel99YV8FHsDfLwYgMWQtkwBiWW/WppTZ/WcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAxfxP94; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a71d9208so989041a12.3;
        Thu, 26 Jun 2025 10:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750959210; x=1751564010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8LhjWLQQyVIxYnEL5IpUGPLzTNUEDSWnSd9GjisnV4=;
        b=nAxfxP94IzUvaYw8/bJMlzWAq4eP54cKxsdCu/Z2DS8Jptm/O2AOzYP980vyPLqc/o
         tM/IJO10sCBEAWuB/Cp6hscYnamnXvlZMQvfUOvyOpm/Jwchy913kBmIEAVbZHTtdfMa
         Z2Vj7MqI5v0csISCMmXwCdZY1cCgWhzGRptKJ96NyDPFvgND6cgA0I3MsjiYV5svuExn
         7ZWzV2EKHJcf2Re3R4JczweqBmp+fStUY3HVlRNT33FqDWwoX7bPAYZjogFSd957yL7O
         Rj6mwKXhtoW0oqRVLr7tQmJMdELzjY/c/xTTaPKVYYm3pmRUsfzJXJNBETiRcsSLYMfy
         sOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750959210; x=1751564010;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8LhjWLQQyVIxYnEL5IpUGPLzTNUEDSWnSd9GjisnV4=;
        b=akEaGIjNmecBBpn01mKOEcwp77Zpn1BxSITm0mJnfPm1m6v1gcLw0RzOAN4wa1sMSn
         mpclnvdOajb8bMv5Z1BaXtV0XLeGaEQobNwfNXpY+NJ1wGKZArOYKZOgRPps/T42GH7l
         wUUdFyxgAxxBkETb82bPkPROHODDA9p2vvejeHeTPiWn3NWIb9eord5dcsTV9URwnSzW
         YC1gLC9xGbXbP2aU5gm2SqOYSJcYrW6ED77uSrCvR2RnsxNWp0vkTLtc6rxdr2tuH+Of
         oH07mJyk1Hjl7wLRma9+yyKcGgdhHRY1tMAfRAjwo1zAF/yOKTpmcDkX6lCnoZShk9SL
         u18Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB0ibr8msSnkygMQjR+VV7iza7qAt9rDFc+qnxmQNUeh7AinvAgRMkVloL8+5Z2gUwgfO50uV5owtq0cQ=@vger.kernel.org, AJvYcCVCVZW62ipWk1oDO3RSm7ue/YXvewdnO30xS3sHGFNsHHrddlO5juWQF+cxZs0ftTFscfbPxZ/v@vger.kernel.org
X-Gm-Message-State: AOJu0YyVfqMjuuX3EqaI4F4u0i+M0ybZwZfkIkVjk+lPPuCpUTiMK+vi
	TsIP3mtKqZfIvcQCJQLcc79w7ZnXH0R9ow1ul6CAuPJkk8biYr1iuJPT
X-Gm-Gg: ASbGncv3MsvFrr+9885kJJkbf5M5WcSHYN8pAe7JBersy1HC6Q2vIELfpVe+mijmjbN
	mPfXWej3kpHlVaxmMV2pmIKezVxjN/XAhh4CuJvQtpPvRWzM319RyPI3mEozyE7uGpTzdoPsLfQ
	bKWXu9OcrUPz12u80hgEmHrlvP7bieZ8qnxk96fchSCIUwA1l+Sg+W2CDXnkOWsLaUdaxTpR+PI
	KPCYaMoqiHfZpNiSpK2nUz7i/F1HUD8FHck+5qoqF2Kckx9ckc3UnhZ4sSWIohHKdUswPHhmzys
	VWqJhs+x5WAyGu4zE3KQa+vA858a1/FxMENXZfhWojezR7errFhc3bHdVnnBQ/SSJfx4kJLo8Wk
	Dsj9NavLX+FL/sw==
X-Google-Smtp-Source: AGHT+IFIG2MCLoHB58nsekBzQgo8xaHzxZEoF4DlbrEYNJEHA4e2QUAxgu4vLUP1uCJthk/vnGGVjA==
X-Received: by 2002:a05:6a20:2591:b0:21f:5598:4c49 with SMTP id adf61e73a8af0-2207f1e6010mr13389707637.2.1750959209681;
        Thu, 26 Jun 2025 10:33:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34c4445b31sm2121918a12.48.2025.06.26.10.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 10:33:28 -0700 (PDT)
Message-ID: <0804c4fa-120c-4000-b4d1-4f47477d3f5f@gmail.com>
Date: Thu, 26 Jun 2025 10:33:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/589] 6.15.4-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250626105243.160967269@linuxfoundation.org>
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
In-Reply-To: <20250626105243.160967269@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 03:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 28 Jun 2025 10:51:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.4-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

