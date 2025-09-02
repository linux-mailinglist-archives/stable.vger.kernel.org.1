Return-Path: <stable+bounces-177543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC65B40D7D
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 21:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6407AFCAE
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0C3451CA;
	Tue,  2 Sep 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efvAv9ZQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551E32779E;
	Tue,  2 Sep 2025 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839771; cv=none; b=o6uQgdqJ5jVoTlJcW893lLyfTzAzof1bBAG2F3tHWdBcYfhQLj8DyBlSZRrFk5wVWniPWRg4gcjv4cp9Txn3AqDp3aIb0mGRm7dczULy6W2lX6JL9xaL37qCXwZypjj65/ytZ8/jwFDVV7dHjvDcm2jkTqYRVzpGcx042A8bSlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839771; c=relaxed/simple;
	bh=HkcNc2m17+XClu97tQ7M8DyDCI6zfFSV8KjNgglm614=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/I72i2IbJXF7OCdo9cUtH66/KB4YIAsY6EYU9ODnq/GZRfExqmotLYq/mhwGiRP52uIJkFDx4c3PQDPyltQqwM6DA1kI+4FdL1wiFFPig0u8RfEMjv2fF0WSvmsFOm97ghUQ2uZagIOBUyK0inekgRJCk1g0dJr7ANdkIoZo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efvAv9ZQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b109c4af9eso49801161cf.3;
        Tue, 02 Sep 2025 12:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756839767; x=1757444567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij3T/Iq7U8QtnuXchf+BWF5w1PmRhpoHZpQyoWdQ6+c=;
        b=efvAv9ZQVb4/8D56oKATPzgRDmyBACqHjWLEi/JcLDhvfO0KGcVMFmgSwMCXp0Fxyd
         8sDBRccE1A2OYcbMCQHHhraD6j7zREgD9j6V7/k5a9bcdyI8bfQyxvL9Eh7h2MP/+3HQ
         vwRM1mas5txY3iIRm0FDw3ktfDvdO0c3JOmEb03bxTFOV6Dgz1qpQqbiq+iJnLSr8xDt
         2p2AWWOfupH9Y8OZpe/BP2iO5ygvReFGU3fLdmb9jan10Wq6D1S40aLhurShhjNv5Ui3
         fap1VSg8WYQEm9+KUw8ouUP3LthwZJsGSvQimUbF9HIFaq3UdZ55r8Qy8zEnxd37iPlV
         vTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756839767; x=1757444567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij3T/Iq7U8QtnuXchf+BWF5w1PmRhpoHZpQyoWdQ6+c=;
        b=Qh5ivMudzMCvQ7bbD50X1vrL9msPdox9ZPt3VhB6ZE9gAkGifQVbbrRrUoAZVch15g
         phJFzTfHxL+v9qko0Uoke0G9ASSm/htjoywIF2vKzt8FnEqCDQxPl5t/5uBFuiiFmYE8
         nOORS8dHViN+rqIXBiX0vQnjQHZgyNp9t3ZjTBjBM3oUeXzhS59SoDT+g5E2qZyEKTUk
         rXtvvJlLD1pFjQB9HrqLI3FnJ8QAlnRYnxO0LUzmFvHoIjb1l2V82onKrh96071pDpO2
         Zs5dm/XkMN3tEJDKhiNbibe0PPOAptCe5sBvUQyxOq+0baOG9tJvaX2NCg9wUvpvbO4l
         x7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXD7Csrpgz6daN84FMEgUirWs/Kcn5tZpqJA4qCbb6qItqthvsVc9jshP46nVfs+ZvnkxaQqZEy@vger.kernel.org, AJvYcCXoUZPY8nLm+mBa0/X4A9nFBYqCd+K9YjZEXivnsTbs0EeNSSGLX/0HZe8WvfugN2adAKBqVCjPaPLexcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5eRqMioPsKriNh+HPQWcbEf9b3ucY2o7+SnjbMJXq3BZx/3cp
	S5pTVN6vCyOxiv3P7tY3u5kxdsftdvc+QD5g/m2UnEnwM13AkhK7JKYQ
X-Gm-Gg: ASbGncs4N1I3Gbr85KKU6xqQt3bGD9U9iZMjMMJMG/xskSbev0Bxe0KDQrF+WiX8ke0
	PW1b/8GJur8funtAn39XSUtiT1LG3mFb1Pn0ONGmFb3TXLcuT8Wadsn7xTVKoxHHKLNg/aPMBU6
	QjTKSk9DfzOCeqOBYCnnPLt2U40lxewLsj6qYdSy8pdwU5hWQitRt5YNIYiHOnRKnVWyxZZSz2s
	c6W9QVFoHtDkPgQmqtoMJToe+X0e1L6gB0N6I4SjSb62sDn2okd3P+1ueRopxrsoO/ZNOfrr1Za
	zq+LTkPRlL30tc+HOUhyMG/NsUebBJTm+vA1SZUk1fAN4rF7q2bPPWACuo5s0gUN1TDaOkf9TTj
	wu56uCrjU2nX+O3aR682QB/QY2DcmN7QXmV2kr6CI2k3PxHxcxQ==
X-Google-Smtp-Source: AGHT+IGn9mO7rvgjXLCjs6fJgBCEFLOZhY6IcSWV6Neruv/fYtq1iOvVP72VqjRYWpl7BrigGf6SwQ==
X-Received: by 2002:a05:6214:2262:b0:70f:a04f:233b with SMTP id 6a1803df08f44-70fac88dbaamr141766736d6.32.1756839767406;
        Tue, 02 Sep 2025 12:02:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16deffsm16216746d6.12.2025.09.02.12.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 12:02:46 -0700 (PDT)
Message-ID: <8eda7a50-8d4b-4974-9ee8-6e69065e9c90@gmail.com>
Date: Tue, 2 Sep 2025 12:02:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/50] 6.1.150-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250902131930.509077918@linuxfoundation.org>
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
In-Reply-To: <20250902131930.509077918@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 06:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.150 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.150-rc1.gz
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

