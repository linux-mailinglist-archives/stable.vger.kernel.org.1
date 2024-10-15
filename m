Return-Path: <stable+bounces-86368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D58C99F3B5
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 19:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3036E1C21F8D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 17:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BA61F76BA;
	Tue, 15 Oct 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSB3cGYp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C21F76CF;
	Tue, 15 Oct 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012161; cv=none; b=l416hnLD4ZR0q9z4IiL0aFj2aShbmVS5aYKE4tvPv5tigP0RCylRbzjCXJXOW9KAgmQQ+Ox7IYuy6IwdFSPKfxTEiarsOoi6lysSkj4VOeVaFLMQR/mOhANrlreKy9dB3qT7fC+Zx69VKbqpEZKTEnMxdSa5ohXcsOR7o4Q1ows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012161; c=relaxed/simple;
	bh=2jEfofjLLXsbVn3Qk7TOhtnVJiZ+0bg5SNgAIipE/0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fiDdJnJmXC+82wWymbLe8oeqVT4DLl+jjFz9OMYnYTOMa0W5LNmopWPrSj9lzxgrFvZgI89KE6FeHjIMdARQdUx69bfqHMYFrSzra5FhWS/pwR6R/K0dvdIk2poYfoBvc3YXmbstCIk8XXgvh/PVQUjZqsYPpyI4e9d1uV3UsVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSB3cGYp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4615654a12.3;
        Tue, 15 Oct 2024 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729012158; x=1729616958; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kZW7qPApC+YS05ogywd/EsqmtRYtB5s/YDB0f/OMcsQ=;
        b=SSB3cGYpkPYWHtmlg7TnDhJXVLh7BJP0FFwHJd+ImjY6g4dZ6h3zf8/m8oRAX0ATZd
         JHj2WIJC4vGtKc7J6VZCQsJKFFy0g1axpwxc/7Wqxdt/WjXU1+0WMZHuB+UwAG73Z7GW
         WzJOyrzFDxNqc/hfsCBG6i2zx282KHZ7YfDr6SFq4a/HNmCeGjb1GkUaF0Lludr2mxIP
         7iKEF723oereXjQeRjiO95hbwBNjmnnXzYtZW5hS34A2PQkC2kzePKVqk435JCgsb8NY
         b2iWAjkd31DuAqHapWB90i7zV/gT+Mffqh80Y9EY5A/piLFwe1LxaIPNrtIEKAQDbz+C
         Y1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729012158; x=1729616958;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZW7qPApC+YS05ogywd/EsqmtRYtB5s/YDB0f/OMcsQ=;
        b=tJt1D3fTcx8CXh56qAU/cqWwxADB2RzlzzRGZPT5kbc1dbYZ1Wyje/okcSgYsk1Wyy
         K+dPIEP8HV8FcfuGOaYPtNzw2K5yVMrSzLn1itoCEItI7+sWZR4mTEOke9Bb2xiq+XkT
         edCbicG8ufMwvke39lif1qbzgNuaW775XSkpWcW/yhb3zRpLMmref1OkSbDqvIGTznwS
         kkRWp1Owc9vMPPp3jZyKuMG0t/uz0g+dXLpTFsVqECikmrxENjDAeHAYTvLBe7ieUj1Y
         3P+cb3aREIfCGiBa6JY0/0XN/DIjRYDd9p/IoP+Q8rO67XAa2i9a0x5uo4lkWTCKxynR
         8glg==
X-Forwarded-Encrypted: i=1; AJvYcCVwn9cxnIqctTGs4b9HmBNxEw5nbSnfBzsL0loOdOhpIlg7MpbkNNkXSdWt4hpkYm2dDP+bMmAK@vger.kernel.org, AJvYcCXLlKeakG6iRj3JD05xRgTUA7mPOATbFnK6HeDjVPoWS6bxqATFiBLNhzlxlcRKdVJ5RlQgar2/QfFfzjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBYje2q08U9oAXhkXaqP/rFCay0owMGfmn7RefFS55gt2F0Bz
	sNlXulprmitiyRPlOVrECVbqn+w1wEbda5mqMFgmu+vsa8e9JP+U
X-Google-Smtp-Source: AGHT+IFbZsTjelVTJRQ3Hukm3pqXejyaolWivijKFWjULKAapbgr3hk3GeQpZtYPgqG05KL9xliLGg==
X-Received: by 2002:a05:6a20:c997:b0:1d8:a29b:8f5e with SMTP id adf61e73a8af0-1d8bcf17375mr23459913637.17.1729012158313;
        Tue, 15 Oct 2024 10:09:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6bb998sm1417200a12.8.2024.10.15.10.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 10:09:17 -0700 (PDT)
Message-ID: <43399648-ea75-4717-b155-73541deacaba@gmail.com>
Date: Tue, 15 Oct 2024 10:09:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/691] 5.15.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241015112440.309539031@linuxfoundation.org>
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
 FgIDAQIeAQIXgAUCZtdNBQUJMNWh3gAKCRBhV5kVtWN2DhBgAJ9D8p3pChCfpxunOzIK7lyt
 +uv8dQCgrNubjaY9TotNykglHlGg2NB0iOLOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
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
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 04:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.168 release.
> There are 691 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build with:

   CC 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/evsel.o
util/evsel.c: In function 'evsel__set_count':
util/evsel.c:1505:14: error: 'struct perf_counts_values' has no member 
named 'lost'
  1505 |         count->lost   = lost;
       |              ^~
make[6]: *** 
[/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/build/Makefile.build:97: 
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/perf/util/evsel.o] 
Error 1

seems like we need to backport upstream 
89e3106fa25fb1b626a7123dba870159d453e785 ("libperf: Handle read format 
in perf_evsel__read()") to add the 'lost' member.
-- 
Florian

