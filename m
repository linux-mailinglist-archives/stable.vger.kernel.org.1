Return-Path: <stable+bounces-111892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 136EDA24A02
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 16:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F171883DC8
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26DD1ADC95;
	Sat,  1 Feb 2025 15:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjaj2Nut"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408DF1C2324;
	Sat,  1 Feb 2025 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424634; cv=none; b=eqWYT9TXXYltJ3oyh7eYKrk0ma9uoLOzAw5rRaPouFK7O6+mfvKhv1MAvfviXwxgjC9F8EWSvMAkT/dzEdUZdwKsYknh5To3/gZU9VVCfXXftjWl3lPqpx/WzdA5n+sKgQqZoKVBVpqoD1iwpbWUfudZwsmsER8m4tzdOogSFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424634; c=relaxed/simple;
	bh=J/pldvOV9JghaGP8XdRyjAVSySh9efWu5GyPfZqGzzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l553G5sFhPmUScENEPRnQUssYtvLc1Kc4P62fNVKhGMgn2gD/QUv7nsnc00AuPPQIYJfCABnH5AJy+0pwh90JVRdU/w63j6VP7puaqRl+PXHoL7LZrmN18ejMDpG5jog/+YdUp/MxQSBTTd8JieHdGiFCNLqAFkSdki8aXMxu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjaj2Nut; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21680814d42so49110785ad.2;
        Sat, 01 Feb 2025 07:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738424632; x=1739029432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8dsv4A1pH9PqJpIdBOWXlXzzoGyIBME+a9tzrwR9Oiw=;
        b=Gjaj2Nut3prSUqJn+wUwM2W2uAY7+Xonj+tzSnmDK8eVERkiguM13eefKtgsthQP3T
         hxrM0oclQuYzp9nJx/VL5q4Mo7vfivLYPZYHjTCRxTNj1NM2+2KH7QWv6qseTYXz6N5/
         Ltcbc7LjTe36zNtaYrUaHXY1CDQSU1W6QQb27bKQHRmTpG7mtv3Yl4sGhSW0OHSN+IZl
         RjQDDdNHm2g03Cl8/FHUaoZP5w8k/2Yi+7UyF89meK9xvDndQvmf8Sr7MLyPhI8+ZYJC
         c9XRMVZs2ktM7BMhI9oywf14OZ/LT6hMsV8keQdd2+nn3XbB9a4B08lVDik9JgAC7rDK
         K+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738424632; x=1739029432;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dsv4A1pH9PqJpIdBOWXlXzzoGyIBME+a9tzrwR9Oiw=;
        b=DqGY7fbst0cdIoQ3MbA8gBjBEI8I5HydBWHZMQI2mdD21GeDwEUEaPA1SDbNFh7m6O
         1yE5Ezgcjm2v5uW6eUkilAEbdNFdvgvN1l/xS22LDhrlMEK8k7HXzcOJ1HtloGlHDjIP
         24FXg17lRu8rhstsBnvy3vYk6F1EFj4yjMH3A6zHlDUTQ+RASFmH3v18P0YKhhiExBet
         obaKbpZQZmn2nu4LwdTiPFgIswrWxUkjdEY2FqYJinhLxsoTYP7vBbIx7h+xiMLXvgIH
         lYHbq9MCIcS3eJDvN7r+rKKXy4i3vx48Bh+2ud9VmTuj5kDm/77NgA1Y6nqJ/AfAjf14
         YBJw==
X-Forwarded-Encrypted: i=1; AJvYcCVjVVRtEXyqzPt1ObnY400VWvr3mxWnOGjeFP4AHQ+EHJiUMW1yZLWPoOr7ZKW/EFS8zBXobaLIwcYePUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CXgJ/uJyI1sWciiesZfW9U8XlnSPJPJpXhBw6dltRKtil5w5
	orEaPJXxEa3l9Ga/U5I3R96nbrrP0Z9J4d7HmzGEST6Yfje3BYlb
X-Gm-Gg: ASbGncu/sLrqsEa0ZqY6Hp2N4jhI6W5uTaiA16BhQk0UvDdAmSRPT4MWL2BFp14HkXE
	RUGn5Q7+a9MizkwCEvmj0hyHCAZFPdOruOfDv4USJWzddgMEAXDrzk7J8JknT/XVVSgoNFBXZPG
	rTnVG1fUj4Pw66c4e/q0jolW1zBZF9xdzOR+kIdBKBuEsNWRqKytN+yy08+R8fmDvknQNRtitVI
	+dLr3FYOKra73zEF4lZpAL2xe8cfRB8Za3k5F2G+TjI/TvztrYJUmKj9orjAm5hCRDXWiaJcB6B
	88ZE7P2qzXkl0F/xw5204tSY2Mm6E9IpU/UK8q/l8LIuwQn6oj5YNmKC7FvEqYGx
X-Google-Smtp-Source: AGHT+IHNQZpXdelUXKIZFCMAsgQO9IjWUxLVpBLYD2NvzTvxsnX+UyBZxqsCbeXooorzxlE4KP2Xrg==
X-Received: by 2002:a17:903:947:b0:212:4c82:e3d4 with SMTP id d9443c01a7336-21dd7df2d2cmr243500635ad.46.1738424632275;
        Sat, 01 Feb 2025 07:43:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331f8f5sm47535655ad.228.2025.02.01.07.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 07:43:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5d6f097d-1a69-48b3-888f-131916e3c4d8@roeck-us.net>
Date: Sat, 1 Feb 2025 07:43:49 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/94] 5.4.290-rc2 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250131112114.030356568@linuxfoundation.org>
 <CA+G9fYtT36DGS=6+2u35Ki1nyo0UR2A1ee3ifUfqga6D+K2egg@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CA+G9fYtT36DGS=6+2u35Ki1nyo0UR2A1ee3ifUfqga6D+K2egg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/25 07:08, Naresh Kamboju wrote:
> On Fri, 31 Jan 2025 at 16:51, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 5.4.290 release.
>> There are 94 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sun, 02 Feb 2025 11:20:53 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>          https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.290-rc2.gz
>> or in the git tree and branch at:
>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> As other reported,
> the riscv build failed with defconfig with gcc and clang toolchain on the
> stable-rc 5.4.290-rc1 and 5.4.290-rc2
> 
> * riscv, build
>    - clang-19-allnoconfig
>    - clang-19-allyesconfig
>    - clang-19-defconfig
>    - clang-19-tinyconfig
>    - gcc-12-allnoconfig
>    - gcc-12-allyesconfig
>    - gcc-12-defconfig
>    - gcc-12-tinyconfig
>    - gcc-8-allnoconfig
>    - gcc-8-allyesconfig
>    - gcc-8-defconfig
>    - gcc-8-tinyconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Build regression: riscv kernel traps.c error: use of undeclared
> identifier 'handle_exception'
> 
> Build error:
> ---
> arch/riscv/kernel/traps.c:164:23: error: use of undeclared identifier
> 'handle_exception'
>    164 |         csr_write(CSR_TVEC, &handle_exception);
>        |                              ^
> 1 warning and 1 error generated
> 

FWIW: Reverting the riscv patches fixes the problem.

Guenter


