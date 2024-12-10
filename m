Return-Path: <stable+bounces-100392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C989EAD85
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 11:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900BE164932
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EEC1DC989;
	Tue, 10 Dec 2024 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnejTZim"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB5378F24;
	Tue, 10 Dec 2024 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824921; cv=none; b=dzGaBMxS5t83wc5p4O84s/Gn96QlmiQAh5JJChenRgEmuypYKuSrACNrc/GQ4CCdadc66KeGbOM5e2NaqazH5LsFrj49cAp5jotviz/ZLIwRcw8DcBv1DmDVC+lqgDVge8I4Bt8zd7Ym4c6MxiMdy89KjWxyutLMEDutUJWmkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824921; c=relaxed/simple;
	bh=7XBDDcF68AQhVjxhT/ZJOXSmiiK/0eaXezVOSjDr+98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCgHlHa04wkyXoHl2hjRampB20W3zxotBe43aIq/QAiH7rvtYtADRtw2WF1frZyiqYzK6DJKwofFBfejgpx3gQFjSDC7l5Bighq/OqGDrG4Tqb9AVedQ4R2cLQEo9jfOkL/GYifIynxy/HFiLvxPzmMk3r4XvrgYRLidzSAEwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnejTZim; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21628b3fe7dso28899305ad.3;
        Tue, 10 Dec 2024 02:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733824919; x=1734429719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/F9Ua4kvSt8BL79rBMm/hToy3OtGMQd8KjA+7WBB/UY=;
        b=DnejTZimXk9ws74ZtqUXNhIw3D5vA5ZjS91N5SSHjwCxWmWFgGklcWdUW4QlZCYj7e
         cZ3CinfyG9s0r8VrdqDZs49xrgh078Jo64lU1FXGsp4aYilWjEdqv3U+IBlUngbK7IqW
         dJSCCBHvwlNfLLTTh9nJX1FkYI86MClxEq/BfH/yUOcy4cSn47sPyhCO0ABp3aCTRmw4
         sfC09emPZnE3g14/lZO6mldtLgMrW0ce9bj6y5v3OAnATq/ldUoBUL8vNDva5f7kXQeI
         dgt8YvqK21PePvEoUJ29RfT4yc2Tw0VVJuARO+irio5Kej8pmHItzrWTaJDx+3rIEGg0
         VqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733824919; x=1734429719;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/F9Ua4kvSt8BL79rBMm/hToy3OtGMQd8KjA+7WBB/UY=;
        b=atktcjCEty0c8X5pQpV/5a2jrdzORg8Sag759f52ldKYz1X2d6XyDawey+4m14p7fi
         trKKF6/7Ox2synMRX6NUVHBvfEeBWsbFDe0RBmTeQj/77xAqxC4uI4PXWy0B+bWWOWdR
         UfGK3lIu+wFfSimp3aERiOoNQ/V/BXBUYBQmFIsSUIFUEVauQ9H5tVlUT+DtDbPfM+03
         fVIphhYBIS+AUCMAdyrFgXd3UhywOhoJsTD3q0GXHaa/wtkZZSaYlkPSwRk4+FCW57BC
         08AoQH4xbaxLxO7tQCRkYjahh8qq1oG+CU7OQac3+ksHYSFYN0HLLmPw/p/Qt27t4f/o
         Hv+g==
X-Forwarded-Encrypted: i=1; AJvYcCVQs0l8QrFBYntlDh9f+kpLaEQ8nVBrR0Q4lTSLa2ACiFGyQaPQ/FMSyF9f6hgTVDayqABeAC/7ONlfZ/4=@vger.kernel.org, AJvYcCXz4tOMF55215JGlIP6gynQKOtaBgbsEa46WbBzWR9o7WuBNuxGgcfHoA0dgol3u3/lnXtx96nB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gs/2Zu7c1+y8NEQrtWJMb83MqiHLRqM+imfNaUAcE3aKZN8p
	LrFzdYcF3Uh1Mn8oYU7p961ZgmUD8Ch4Um/56AAql4WnwsjjiMNC
X-Gm-Gg: ASbGncsCN16n75x04qZzmqQ5vNRiCziACUDu1erAE39HiDHFsDhjON4/wAvw8rMuG9T
	bYOO1CE6CONe/JvJlutCALOX9YLyVyw2RXTnGiY+8M+9wqbV0SCotHWFkLj4vaATwVKBQ7h7b82
	mOYnzKMuHzv+SNq4TqHaJWVyFcdjQbw6HiYr/+jzaQxxJz5L7FwMo7a2vJ1caYGjUdp5/QIkW/H
	Hbp3j4gQBAhLvtchpQnftOAYV8IH8wHKb6V5vy/ZaNJD+rNxDmKJiNGxiz6D21moSGlP0uvOlBG
	Mz/j9johHDXQ4+tTQ0HZVv77tZc=
X-Google-Smtp-Source: AGHT+IE4jkAlNlEo/jdNOzHy/0qGcg0edxQ8DpjFAykqcdAZmWzMXT2/T6NQrspwn62zfEi9FGTTJw==
X-Received: by 2002:a17:902:e751:b0:216:26f1:530b with SMTP id d9443c01a7336-21626f15afamr179976045ad.51.1733824919153;
        Tue, 10 Dec 2024 02:01:59 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e7edsm86537295ad.22.2024.12.10.02.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:01:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e05374de-a45d-46b6-9ac2-a4aba932c6d2@roeck-us.net>
Date: Tue, 10 Dec 2024 02:01:56 -0800
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
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, Stafford Horne <shorne@gmail.com>
References: <20241206143653.344873888@linuxfoundation.org>
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

Building openrisc:defconfig ... failed
--------------
Error log:
drivers/tty/serial/earlycon.c: In function 'earlycon_map':
drivers/tty/serial/earlycon.c:43:9: error: implicit declaration of function 'set_fixmap_io'

Bisect points to:

> Stafford Horne <shorne@gmail.com>
>      openrisc: Implement fixmap to fix earlycon
> 

Applying commit 7f1e2fc49348 ("openrisc: Use asm-generic's version of
fix_to_virt() & virt_to_fix()") fixes the problem because it adds the missing
"#include <asm-generic/fixmap.h>" to arch/openrisc/include/asm/fixmap.h.

Guenter


