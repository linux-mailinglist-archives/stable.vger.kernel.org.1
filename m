Return-Path: <stable+bounces-125684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D320A6AD1E
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 19:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC4A172807
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76EA226D14;
	Thu, 20 Mar 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfEkKOGJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB2617A30E;
	Thu, 20 Mar 2025 18:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495338; cv=none; b=NpKHwsJhpy5ucLyHp6ac5ocsNm9jZtAyZa2KKT4VjZBC5hyvaWw6RlmCPWb/hO6D/TdMw+YP2Lkie9MbbHWttj3kNSo0sSKHHR3swxu1pH66IlZM5wj6SdLq15prlHAxG4lumXBgKM5X9Yc1go+oxQDv3xVdLQJU/Gw4dVNhowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495338; c=relaxed/simple;
	bh=Plfowq0KFer0siwzLcZW8/vSCVw400KQjHSjlQ4jkoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvkLxEQt7n/SK9qDZfPnSQZMJAdv3ZUUgWPLJaoOxY7zCt775jIhtKIYQdahRQOOo82JIw1YHB8hUMQmgZmZdFP54AjJpIQPxUvA7yDBkc7550EP7YkiHQXOt9A+yOXc+5+4BP+xBQyj9jhOkoB7xOzFXDE9+rJDO4HWXlk34qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfEkKOGJ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2bcca6aa8e1so390320fac.1;
        Thu, 20 Mar 2025 11:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742495336; x=1743100136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HW/LIsGIPLKhuQXiS4oCB9/8flni1RJfR88TIPdmowA=;
        b=gfEkKOGJ/ibDem0U+Dm+RfIU9cetmWdjTc4b+dlsvwWkDun4m3SGPud2h4/yl10xGy
         TxCmws9B9fExs+07qRWAnfH500lwsrRYh7tVu55fYcav0ko5Q1Ph+jbimqKaYEyegk4o
         zyH0aYztBjrESugBtxCfIsFaMNUkuR7nQYm+gKWpfm25p01mAwwVt3TbBrLMZFa4nXGj
         DfwM1BuTSAgjqfXG0jmxESJZH1cYPXgfMb7M0YYdOwkqBXN3TI7qQIoptcUl0YDdD+kL
         i39ODqGELIP5stkYWyoTlMxkH2cuEy6r4kvNY7wLgVkehqM7GWsPu0Sg4mAOXlouyhKJ
         L6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742495336; x=1743100136;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW/LIsGIPLKhuQXiS4oCB9/8flni1RJfR88TIPdmowA=;
        b=C3le9q2cwEAsVZY+Nsh3kqHSE9DrZz2TzrmKbqnlF7pXcj4zFjVlAeS3nohAC5Kl4b
         jcT46t51QlXhMjkSThtkmDEOK0SKmou0X6ghUQbHqPWCL5ilDfuUBvQJg4pYXj6UfW6+
         F8Ioj4Vtd32oOAhUS/4m3HDTCI7hmcjO0a8fPv+0PE1IogsIEr6ceC02Zr2yz4WtnABw
         qnFVg4BLqP5i9moLCagVMZddOQ0+t9z07Omci8LyLD2TaiE0BoLnV+upW5j6933a6PSf
         oJ9IDkBKx/xgi/mDQMcPQP4t1VjZ0nU0D8wIlHq/fXjd31J+rglOLxM+4Ly265vh6WUg
         SSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEHAkiP7SMJlkBnjpCY5WVrXwFPKF2E9ap+v7H5xPuiaEJLK7lUWslvSgQes5qlgL2SV9i3XkYQlaROzU=@vger.kernel.org, AJvYcCXKpbkWZGJu7THxQysytTfMnkUKAHzclwHDoUxwK5BYuLLkMwQMhjjFt5t/Uq9s6pt2HrudKuVh@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9M1UetLq/VEhYlAlvcyI10bqi638JWzJS4wH4uzCZNuLypie
	Im8O3lCd64dVLTOGaMMDuySBP154/o69YjojOubVk6izPLpBt9cG
X-Gm-Gg: ASbGncuzcsNEPSaJJkMFUmXkOLfFa7rVaWYucEDfpRg8P9Mqrb5IcitPqQIiAreCZ0F
	gEZguwSkOM21BYApeq3aJVpEY80f1VfGGzyxjO0joNDiw12k8YZP8Z/I7UqWJDmzyykOmcjUoE+
	GuBztzm9MIDQQPj2AhAedc7KaDjjjB9aib1tmV0rXOaWObns4QJ5h0EtiWhJ9SelKKbuMZR8OrM
	VYs0nJMg/3w7x+c8u/SMBzVs+NwSRI2efIxiPEzofqPuEEyAa+yVBo+u7mR2Hr/cfv+aVbaz1t9
	S1Ue39hnNE+xXLyHAtGfwE8mds6hhA/5YO+SHNghaGmEh4Na+XJQnGcSr1theD6+ESh/ryN8+xY
	Jq4lDYQw=
X-Google-Smtp-Source: AGHT+IG5RgbMaiZlm951zawlAC8+hWKyontiV7Pl7ZVPI1+0v05juqySzCNKvVqE/AGF/77jGSra0g==
X-Received: by 2002:a05:6870:a784:b0:29e:6bdb:e362 with SMTP id 586e51a60fabf-2c78030f84amr359639fac.17.1742495335770;
        Thu, 20 Mar 2025 11:28:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0abcc037sm48469a34.33.2025.03.20.11.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 11:28:55 -0700 (PDT)
Message-ID: <8ee4139a-19d3-4727-8823-8130353d8da7@gmail.com>
Date: Thu, 20 Mar 2025 11:28:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250319143027.685727358@linuxfoundation.org>
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
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/2025 7:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.8-rc1.gz
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


