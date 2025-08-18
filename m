Return-Path: <stable+bounces-171636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD1B2AFD6
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 19:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2662B563E25
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636930DD19;
	Mon, 18 Aug 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giHvqe5E"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A126E70E;
	Mon, 18 Aug 2025 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755539867; cv=none; b=j7B9eU3m91vLr++zr42B29UiC4UPjqALFXnEqrAAhBjE2JLXgxrbY5YFpVEJtrPQ45motI3r5V2ejTO6BCqnqoeQnLq66Vz0abeeTUXtoVagamGWOpmZanw+JpDrVzFMw7QOBS9UQXucI/Fcl76H70ldN3Q2BoEmDh6o34cBh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755539867; c=relaxed/simple;
	bh=7reA1nrrhuVsRD/BNRdqB4StM9Zzk+kKYzf7IJRxOvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxa/E961RNwK8pYFEuz264261jW/c/BZkhCL/hj4ogdlWavhzKEisnIeguw+WQ+nW8wrPXYvdFBbHVUDRQ3OEt3n+drKMOdOsCp/BxF3CEOXsnPuXObCFeLTvnQEYjpVoKOQc+b2Y/EXFtW8dCeZ36cpW7vfOldhxIC9L4gxEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giHvqe5E; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e8706491ecso668665385a.2;
        Mon, 18 Aug 2025 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755539865; x=1756144665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5dpAAc7F/8e7I8kDQez5QitfInVFnriBvKVZ+tJof7o=;
        b=giHvqe5EXcqEFHfvZCj+O8kwRxKk8RjafSJGYkexITreIYVcdeISsTOuRcRRFBJzaE
         cmOqlqIi25LMXaBGcKjzhi31wxyEtv4kVWLaS5VeBeOr/A+1GVO6H+JICDWYxnN3IxM8
         dIR72/2lf6PJBuYblHQu0p+hgz7cefblbU4vsymPRVfJB/dPCmU0cKGTaW+kZW4zihow
         Fi/N9uMXnXNGllp1DEeHh/Q6kPJSnJBrvxCzVgzv+zvBcUSFfQR4c3Ug58x8EoOWmlpq
         eYwUtdcbppN/uxah8t50dLc+DxJZxLZKRs+l2itaVv6dz/qbmDbNd26DR4fEdmYOCX2j
         yCEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755539865; x=1756144665;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dpAAc7F/8e7I8kDQez5QitfInVFnriBvKVZ+tJof7o=;
        b=c4PegHAhyB7i22pNd3Hcj+C8LUiIC5Wse4mqxI9BIpFXdOUXdYfnXMth87aBByR6tM
         ZNVPaMmv7PnMggUnaCSvblmBAc57y1cnuqCPLDRYW4fAtBAeT2AATh8HiweySwY/GV+a
         AuOT6Z4Um6bRohPYYeP1J6L1cbLUkPnERcFq56JkVXcCT5QfyrynkA3hjEenMqTcHnod
         aypWg+iiGE7vnn/cufLBJ2WYY9mklPmAX0BV5N7gBXhKwHWdEz1flKl5sUzFaZTrrhjz
         guBEA8eW/qG8JFsi6Z5MQfjg1n91tZKYc0CfN9vhxXwRlHoJUDpYyC+M7VKixJlmgdcT
         pFTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnXI54xihiuE3kMYeJGBi1rjf9ffr2ZELKRqhQnMvWp8+weoxY5hmt/UI0S8Ghq6IED12WGiI6@vger.kernel.org, AJvYcCXxJXcCawE7R5XvnXTCNH1oYAw/3tVLnesJQCIgnJb9RkjKYX0NtyJakbtoSpurPMLr47PLWIjCdQA+kPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwSIZBIrd2Mif0NWv1RE0+9b+l78H10nrIaCx0M3VH5tdUP+s9
	iCCZ6lH80nmDMMn8fnGqHVS2gb1tperJIJK97SKEb64HD5xbBneGpDaM
X-Gm-Gg: ASbGncsvIHRzrXyr4eDL0BnvYSSdm+BlaFkMtVNxaS0BSV2nuDMD+yaEqXdYcahfY8g
	9nRWKiS6o4mFItDLwpxoB3mKDOmAbifbvIHjwijKUXshkhE2heGHFcaJntLMBppb/OBK/O42pNM
	nIqHXG56IciBk3FsI1vD23uUO5iPVMzTVQ6FIJpVS/JcNThHI/vq189iEtDaEEqRHUSPrY2PF9A
	/9fksx6/g+HrDS7kKUMB48ZlRYJepCfBIhRm8Xsv+kCzeaUNLNWevvEsUlrr087na/U2nah7+XV
	UBVcyLFAmKytPgOjQg84K7556sFu9oOMWYT/eSiPtRbLjHBVm7PRipHI6xEsHTbEitt8hHyl3zD
	SgBiYf43e6LQKkzPvlcQ0HpLn2lCpuf6R0Oen9dQHLyID4pcc3g==
X-Google-Smtp-Source: AGHT+IHYzzYhD1kG1DP3lCnGlBxWAQqboJMYhFCESN69WTGlbet6GMtTiUgPse6bErG/6aS9jEO+5w==
X-Received: by 2002:a05:622a:2485:b0:4b0:71e9:1f99 with SMTP id d75a77b69052e-4b12a74e55bmr121025781cf.30.1755539865088;
        Mon, 18 Aug 2025 10:57:45 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de44f76sm55428721cf.50.2025.08.18.10.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 10:57:44 -0700 (PDT)
Message-ID: <831e5459-a8f2-454f-8c2d-3d96c01c6c8e@gmail.com>
Date: Mon, 18 Aug 2025 10:57:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/570] 6.16.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250818124505.781598737@linuxfoundation.org>
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
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 05:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

