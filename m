Return-Path: <stable+bounces-58060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495CC92790F
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AD71F22472
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12881AEFDD;
	Thu,  4 Jul 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZ/1mEML"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC11AED35;
	Thu,  4 Jul 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104215; cv=none; b=YIqEGcaAiklcM+gW9DV1Kj9F6KkbM09KlO244JhMIig156lfA8DOlk7q4uQLsf0zOVv5OhFqHuLnwyhgODwA6rEB5RLdwIkTS9QzGxvBi9CJgHZYaTIGE6kJ4hx6A0E17PZ9z6n5j1qpgtMHR46K+FqrSQCuQHw3584Ty7wroz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104215; c=relaxed/simple;
	bh=8XmkRsTH0HrROXy2csxLPIncW5HM16W8IiTPBYwxuzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdxS/9h8o1uDY7c1jD/Pq0rTY9FvKoMbGqBc99yK+14yLPVgdfaotA/nYUOgqHtudHK2Bkx36Kx3EX5noQy7ulJ/jQ2P16aaxy5n+ZKgbzaNgC1jM1d0X2m68lYtuLmhKxCozEwhdKqQR/CGKHpVqCrunJTUUG5Cwa9+Ps9A/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZ/1mEML; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso2171435ad.0;
        Thu, 04 Jul 2024 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720104213; x=1720709013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rWSy+jbVX03cUaT/TQqGnvRHGq9qradWI2wNFkB+q4A=;
        b=AZ/1mEMLx4RFbPNljLzatiP7+/2Kbgk+4+BeC4RDNT08vcdeb62o5NaJ8Q9U5pAHb7
         Max3S4zrBN1YE66xsTK7MNVg9He+7xN8wpsZm/bU+nFTkrKKDm8hqSP7OvB8bKBa+6YE
         Zeqz3w1PNHcsUOhZBZHS8tw5Ew96P+pNPC5Gx9nqEj8Mz9AMBboB90S7WotFau4JuOqC
         dho83j2SXLeb6nCdovpHDSAMxml/ywEZvhg11zSvxSf+CpeRPxa6zwH56swQtkZpzs/a
         GM1Zo9/5ub1jKX7+7f1uc4MVUX+Vz0KwE5egXhqxQJXf1KFaPqdnrpENvDLoCuK8oeVE
         q4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720104213; x=1720709013;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWSy+jbVX03cUaT/TQqGnvRHGq9qradWI2wNFkB+q4A=;
        b=qPRBltVSyFi0XWaJ7iC4SVU1BFp2qiXp+i3/EMfsIcje1Sng0JzxKnNeFFH1viDAoK
         T92nuXNZRm4+/4GxlcBrtWtJ09hJjLOVOXbmjpI9/fFW8KuylR4i0QU8L/VNrwUFknTE
         u1P7tkn+XwtqmpH7XtU6c+0zCTk0hu1V0qkpvf4CuZ3ErL1f46/ddChXCU7l1n2wSDf3
         sseXxc7uR5m0WG20Tk+AVvLaVEcKEA+fCGppqJ3F6X+Anu/zfsW1lh09FMFFNfqmKWXA
         b4z9dpPtIvDQo94Q50EVYzCJqMqQPicao0L9KLAmLbz2xmC6nCRBO3YZJUYW9uUPIZlK
         ZHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW28Px6SYBfIi196RN4Yd5H0o+X6JDSLcBGDJ/Od+xp1eSJQJy2gYupE7slKdY1vvfxNM/gmjjXQr9/FIcNjJUxKqseTMvkGd0eHxPxrHlGbCgqY3AtrwLCb5aHeTFuob2jW7l
X-Gm-Message-State: AOJu0YwVySrW2DyiG2+w3sECXNkWbbZJagfZtuA02iTE2YPpxjLIuIK8
	Ksmcc56qJu0BQS9Z5rjXVj0GIfWWetNa8J0T3rA2rY/ZBiIMYFse
X-Google-Smtp-Source: AGHT+IGAly86DZO7u2CdyTg2Sn6/lRIas/DjwenSGsiQMeWLos1MWAWTrR4w3RgHtZTanFTquCF2ww==
X-Received: by 2002:a17:902:e742:b0:1fb:2ee5:377d with SMTP id d9443c01a7336-1fb33f33acfmr16982195ad.63.1720104213286;
        Thu, 04 Jul 2024 07:43:33 -0700 (PDT)
Received: from [10.40.5.113] ([89.207.175.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1ec1sm123640375ad.2.2024.07.04.07.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 07:43:32 -0700 (PDT)
Message-ID: <896eb0df-2149-44d3-ae1c-b623f58c941f@gmail.com>
Date: Thu, 4 Jul 2024 16:43:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/356] 5.15.162-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240703102913.093882413@linuxfoundation.org>
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
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
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
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/2024 11:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.162 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jul 2024 10:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.162-rc1.gz
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

