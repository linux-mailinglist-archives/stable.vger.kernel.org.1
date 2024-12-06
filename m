Return-Path: <stable+bounces-99998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D8B9E7BE3
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C697016D674
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 22:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422211F4E33;
	Fri,  6 Dec 2024 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMU2V+un"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58922C6C3;
	Fri,  6 Dec 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525084; cv=none; b=hVeMWM7WtMtN5SF5PHttvJViFpKeUexL6ffn3n8Qf7zr/yPPpkXeBG3fk88HqE//WRgDh3N3uoQTpHhrfYQIdvw/T0GdCCzVfaTXFl0hcd2Get0JQLla19+vZ5RR5z9wZKqJ4UgKtwUjXYqxBGW9NXTxJXgBXBU65zfYXIRhqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525084; c=relaxed/simple;
	bh=WI2J7dR0+ilHazk4wgjzpDOluD8//9je5uTiSk7GoAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fnfua1se44Inkgx+512q6aYyAKWjDm/N49hqEVPzVGuj7VVbkKJqLpCGFnzgQl4BFP5w3DUw83ZAwd0MBKlciwn4HJAIDk1wowAljPgPc8WLTC1XYnbsa31ctaqTrmvrRoJADWcxjDMdZ+pQyMhbZAIKHpVBGskppbpZ8RGbV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMU2V+un; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4668f208f5fso23278351cf.0;
        Fri, 06 Dec 2024 14:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733525081; x=1734129881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iCN7jYmq/Ly3S+/F2VYvFeB81jNT2qnKK+9AsXABa/Q=;
        b=NMU2V+unWLlqoDVaU0IoWRABJanfLdmh9yhdowmPaFnQzlneqv4CsWN4JAbFauiteZ
         B0cHh6c6Jb/jQ4rmQxWO04f8vuwNiRGoe9lM93FhjHAWuXIS3S/pHsXhww1go2DqXOFV
         BUdT5FsEaAAb0JR3jj1iBjOVMJEn57diyFD0ujQOXZSm49ERPDbHJ/W7SNJwPJdhBuM8
         4PkRUgnhTG/LGnwhm+eh/z4osWzzN5xIWC/yaDDdA6J9EYE9ak0xZa8R3GsyZ1gttiD6
         7mWw1Bb4b0t6nyeVhF5mTQOoKLQ5EB7zMxyJLH5f2le2qhakUu1hdKmp5xqdWuoaMUHE
         RNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525081; x=1734129881;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCN7jYmq/Ly3S+/F2VYvFeB81jNT2qnKK+9AsXABa/Q=;
        b=prnpvrRT7C9MGCMajyoblyEdcsB8XgaPJrQzCjVj8a30FRGXXWBI2hwN3ngo0zL57k
         5Fn+YvtqktN4FW6SIJE1k0ys+l1IJIGajPAOKJL//qKyKWKv0ngaW6DrXscY4+/BJR/o
         OJ+uCRXQWiJlj+Hl6NEph3WoQ6j0QoqVFuNsNwKBQjICTxJSsbUTjlVkKXBMhITPGw9/
         i91Ey9Lf4sUB80TRsExpuPq5kAdZmgpIqNIhT6kUyYajFBQPQkTS8WY7WZjpny6pZkBy
         buJeaIa7krkfS4W6lHKsCUsX8sLtPrspCVzMTKVOLVWpZqm0E4QZJTjq0YF5aaTscDTY
         A+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDOrfosT6DV315Yz7YL3KpvpVG4sCnR7/2oIfx/PLlWZtPU6zwL3RoxzoKODWKfYNkvBv7nbrHKaJfcx4=@vger.kernel.org, AJvYcCXSozuGR6VZk229afm1XSbYoFxDzysBf54RwtKubQlh71BMmXtFTAQMZf2hKLty8uHW7v1W2UZU@vger.kernel.org
X-Gm-Message-State: AOJu0YzUP130AOQcrHAHvK8NoSvpRrzC1SEyCPagKMhmhhb1qdByN9uP
	sEy8XxwFDiZMndNtO1XWayhz1+WO7YUYDNM14KGEzXZ4VznCwOiT
X-Gm-Gg: ASbGncsRdxo04G3rgZrr33oMZF/t5DiBVoiX2QmHZv9vsYr4p9LyM5GvDzUtcogFbav
	Be0/n9c15H3CUGqz/QLv6W0dTKlwwoz9C64DJ1b3ZBG+q2eUiSUwrLtmFjoYRWBGN8xZsB8CD7l
	w08ehei/EAgWnWxOotxKO2yqQGHbSZNKfY3pFgwA3h0lG2fQ7eu3/4OgMlKzB1IjoOKMusmyRJc
	qe3+JFJEZfyEIMiZq9RaUK4WaNMYagh47I3QChuqD07o4SqY19K/P7EnKubDNcVwxF38ioTg0wZ
	uw==
X-Google-Smtp-Source: AGHT+IE+CaF0eGH3ZR5dX95dfeuHr9PvwB934hOYv3WA31istBnI0LMpUh2I1Nn9x0ochL1UtCrAxw==
X-Received: by 2002:a05:622a:1a99:b0:45f:bc9e:c69c with SMTP id d75a77b69052e-46734c87a09mr106144231cf.7.1733525081432;
        Fri, 06 Dec 2024 14:44:41 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467297d6c5esm25928661cf.82.2024.12.06.14.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 14:44:40 -0800 (PST)
Message-ID: <61d56813-0658-4893-994d-4e9f0175554d@gmail.com>
Date: Fri, 6 Dec 2024 14:44:37 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/676] 6.6.64-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241206143653.344873888@linuxfoundation.org>
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
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wn0EExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCZyzoUwUJMSthbgAhCRBhV5kVtWN2DhYhBP5PoW9lJh2L2le8vWFXmRW1
 Y3YOiy4AoKaKEzMlk0vfG76W10qZBKa9/1XcAKCwzGTbxYHbVXmFXeX72TVJ1s9b2c7DTQRI
 z7gSEBAAv+jT1uhH0PdWTVO3v6ClivdZDqGBhU433Tmrad0SgDYnR1DEk1HDeydpscMPNAEB
 yo692LtiJ18FV0qLTDEeFK5EF+46mm6l1eRvvPG49C5K94IuqplZFD4JzZCAXtIGqDOdt7o2
 Ci63mpdjkNxqCT0uoU0aElDNQYcCwiyFqnV/QHU+hTJQ14QidX3wPxd3950zeaE72dGlRdEr
 0G+3iIRlRca5W1ktPnacrpa/YRnVOJM6KpmV/U/6/FgsHH14qZps92bfKNqWFjzKvVLW8vSB
 ID8LpbWj9OjB2J4XWtY38xgeWSnKP1xGlzbzWAA7QA/dXUbTRjMER1jKLSBolsIRCerxXPW8
 NcXEfPKGAbPu6YGxUqZjBmADwOusHQyho/fnC4ZHdElxobfQCcmkQOQFgfOcjZqnF1y5M84d
 nISKUhGsEbMPAa0CGV3OUGgHATdncxjfVM6kAK7Vmk04zKxnrGITfmlaTBzQpibiEkDkYV+Z
 ZI3oOeKKZbemZ0MiLDgh9zHxveYWtE4FsMhbXcTnWP1GNs7+cBor2d1nktE7UH/wXBq3tsvO
 awKIRc4ljs02kgSmSg2gRR8JxnCYutT545M/NoXp2vDprJ7ASLnLM+DdMBPoVXegGw2DfGXB
 TSA8re/qBg9fnD36i89nX+qo186tuwQVG6JJWxlDmzcAAwUP/1eOWedUOH0Zf+v/qGOavhT2
 0Swz5VBdpVepm4cppKaiM4tQI/9hVCjsiJho2ywJLgUI97jKsvgUkl8kCxt7IPKQw3vACcFw
 6Rtn0E8k80JupTp2jAs6LLwC5NhDjya8jJDgiOdvoZOu3EhQNB44E25AL+DLLHedsv+VWUdv
 Gvi1vpiSGQ7qyGNeFCHudBvfcWMY7g9ZTXU2v2L+qhXxAKjXYxASjbjhFEDpUy53TrL8Tjj2
 tZkVJPAapvQVLSx5Nxg2/G3w8HaLNf4dkDxIvniPjv25vGF+6hO7mdd20VgWPkuPnHfgso/H
 symACaPQftIOGkVYXYXNwLVuOJb2aNYdoppfbcDC33sCpBld6Bt+QnBfZjne5+rw2nd7Xnja
 WHf+amIZKKUKxpNqEQascr6Ui6yXqbMmiKX67eTTWh+8kwrRl3MZRn9o8xnXouh+MUD4w3Fa
 tkWuRiaIZ2/4sbjnNKVnIi/NKIbaUrKS5VqD4iKMIiibvw/2NG0HWrVDmXBmnZMsAmXP3YOY
 XAGDWHIXPAMAONnaesPEpSLJtciBmn1pTZ376m0QYJUk58RbiqlYIIs9s5PtcGv6D/gfepZu
 zeP9wMOrsu5Vgh77ByHL+JcQlpBV5MLLlqsxCiupMVaUQ6BEDw4/jsv2SeX2LjG5HR65XoMK
 EOuC66nZolVTwk8EGBECAA8CGwwFAlRf0vEFCR5cHd8ACgkQYVeZFbVjdg6PhQCfeesUs9l6
 Qx6pfloP9qr92xtdJ/IAoLjkajRjLFUca5S7O/4YpnqezKwn
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/24 06:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.64 release.
> There are 676 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 08 Dec 2024 14:34:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.64-rc1.gz
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

