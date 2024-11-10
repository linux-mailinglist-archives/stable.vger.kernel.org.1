Return-Path: <stable+bounces-92046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D927D9C339A
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 16:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D851C204DA
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D0B4594A;
	Sun, 10 Nov 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNjM+Zdp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3EE83CD2;
	Sun, 10 Nov 2024 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254017; cv=none; b=cqDJwH8XuOt8SeFxkvs4EjOFVFJCymjRBl0xfO1r7JyEcrHOKlkS1d3amkQxIJi6jxpXVIBa+JeWmfisCofbBB40uzlj4YYI/e443dKD+5Iu57Cgx/0Ddh6rK6AtIXzTKt0Ghwzue8yK+vBnHR4f3rqQI7fW4WQHea0H3c62G2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254017; c=relaxed/simple;
	bh=/0XsHzXkCXc1NtLkMnoORaYMQgW4Udgyy5wBw+gf/D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCkMrERv9zU1ei48acrYUS3xUFskdbHggizeODdtOdundDqeX1iMKoP9M+h2J4a3IeQpCKZP16OXvAQRJNBY2O7MXTWIPwhSCNjgU1MjuXWVa92jgXuSB/dkmGGb1qTWMZ1BiaKJdKUDuO9UfQcXuTbaz1r1gMVcSr77Wqm80lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNjM+Zdp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7edb6879196so2534196a12.3;
        Sun, 10 Nov 2024 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731254015; x=1731858815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=X6t4/WEwGhfU/qAlitxUy+xJJMJ0Hs4yP3buYEjH58Q=;
        b=MNjM+ZdpwH50QJqlOH1MTOROokihcuLqV+Le26qIVPHkbrH0XYBzFgJkjIkTgU6Y7G
         gsLNmIKvs45mRlWbJAVH8fRIkYZ89q803Gz8MkE+otl40KHSnGB5SzgOzI7K9spg19Iw
         itR3O+QY7ItlmXz4lM6WqzF0pNM+6OjUDmsLxs8hWU5ciERoJluxk3qjm9QiDMeQUa+U
         EpCjMWrGIPz4QsygUgRPtsQtgkzWhbH0JwfxeDMnkH4QLnaJQJ36H4PMnx2OmWVLfIf+
         z2m93UQ1DYza0wRLcYD/trdVdj24mavTX1Rt4mYyfIxkK+zLWOVROcy7CnkWvSVf1YBG
         +hVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254015; x=1731858815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6t4/WEwGhfU/qAlitxUy+xJJMJ0Hs4yP3buYEjH58Q=;
        b=tSsuui7zHb5orn8MzURXRI9x4z6J0zVcGkIbwQ4g9M3/+jGKveMkIGqYeOhGkuc8m+
         5bzptwdgXHmfd48QOQ78l1yt658pZ5gWzPPXNeeXf3+BN4Od664/6ntsPVWff2ZVkelh
         o6rQVdpRL5rqSS96k6haBhcuv7ASd+fjTRn0BZB3lDIG1CdTjOKI1mKq2i8rmWyBFt1F
         /lydB7bOn9YeZM3/4vA1h24MDdpCmRk2+Ei3lgkZh6TiwFQoVQ9lHW3tpPX9hs6W4Y5t
         LlddTs0yEQg2Pb7TyIFlwiqvqwyqonKuBvqkgSM41YZoZU7NPxVqq4OtWWzImaxZvdJO
         m4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrIoD4l5lRE9rNuEDtcrvVPwHvdH4zRe++ZISe/9QneKe0Ycykk87Ruao/Dw76qDapb+k5Hecbi/5D8Uw=@vger.kernel.org, AJvYcCXBy5PmiBFZyFUQFz8Fd9BkrgW4mH3O+0Rh9mcLl4yOat9SNLX23z2kmvB81YV1lrRjNvQOwhIH@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcFIzpVAof+wAiPaGdfl3YiTeYuUv4EDFgW4cMjL86d/y2V9h
	TtnTByI4PFGCFFqlTGbZXjz7CUZ1Ck+oocsr53OqLFFEcrpBYalN
X-Google-Smtp-Source: AGHT+IEpl0f0r1q6JJUA2Cwl1MIzDtE++DW+3p0pbUhI8QlOdmrVNYNGg2McxT/6Ec2l5dTi/JqobQ==
X-Received: by 2002:a17:90b:48c9:b0:2e2:b204:90c5 with SMTP id 98e67ed59e1d1-2e9b1797cedmr13720138a91.33.1731254015486;
        Sun, 10 Nov 2024 07:53:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a541da0sm10047755a91.13.2024.11.10.07.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 07:53:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d440b33c-8634-46c2-8fb6-8ee4e7b43534@roeck-us.net>
Date: Sun, 10 Nov 2024 07:53:32 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com,
 broonie@kernel.org
References: <20241107064547.006019150@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241107064547.006019150@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 22:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 249 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 09 Nov 2024 06:45:18 +0000.
> Anything received after that time might be too late.
> 
[ ... ]

> Naohiro Aota <naohiro.aota@wdc.com>
>      btrfs: fix error propagation of split bios
> 

This patch triggers:

ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [fs/btrfs/btrfs.ko] undefined!

or:

fs/btrfs/bio.o: In function `btrfs_bio_alloc':
fs/btrfs/bio.c:73: undefined reference to `__cmpxchg_called_with_bad_pointer'
fs/btrfs/bio.o: In function `__cmpxchg':
arch/xtensa/include/asm/cmpxchg.h:78: undefined reference to `__cmpxchg_called_with_bad_pointer'

on xtensa builds with btrfs enabled.

Upstream commit e799bef0d9c8 ("xtensa: Emulate one-byte cmpxchg") is
required to fix the problem.

Guenter


