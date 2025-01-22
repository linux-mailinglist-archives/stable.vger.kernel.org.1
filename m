Return-Path: <stable+bounces-110217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C4A19838
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 19:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B9316874B
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF242153CB;
	Wed, 22 Jan 2025 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/p5aWw/"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0761170A11;
	Wed, 22 Jan 2025 18:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569552; cv=none; b=NyaWpUEWaCxWDNbB2XYv8gF++5PKQM9QNuvdbpw3Cvc8grJszbtQTGRKZoYIBCNy8KXG8VExQcmSyEqoZKI6Eh4Veg17kw86GeerGYMZfhF2EvviriQGg4XmTpC9r00YI6EsAtV9Z+5gfd/CFgH3/ZdCVd9W4SBnYKGoNBp6dX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569552; c=relaxed/simple;
	bh=vKqdUV1xA/kUlfYDw/aCQUiUt7IP55zeYFN7Eec5YwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwZF+DLxy9e3LhnvjLodLz6C0xRlcFiXJ/E3f32iwbdJmAzLlkixns+IiLYxqq/rG7JdFfkZ8EAh5Af5h1Yoiu8SlKEtsWs0duGqlDsaKvdax+24mxXlgLdonDC9Ny9bj09Iazh64QZ1duuMA6fRVBA6K/pnKQ6BSuF1qjvDSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/p5aWw/; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-29fc424237bso74294fac.0;
        Wed, 22 Jan 2025 10:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737569550; x=1738174350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fNvGAAWWGFQC9Zo5194H+eGcmqmXeFUSRJ5hz1QrILM=;
        b=I/p5aWw/lbSyDe224Hks2WjpKshU9G5WoXhAYtSXi7dIZUrGZeR8a7Q6haQiNemACT
         a410nxJSIiBGJAE9pNI9AD2k7xJX4g26tkyTs/cEqetFB/Id0hhNpIDkpnW8utcu15Xi
         PO+iEpI0R8UmE/HojWm12O9TvREbYApSE4JZQ14A4mu5ptSaeFuG+xEfC1tT5/RNBnWd
         TivkCR8ieWlyYF0yo4vu35A33XkDl4UmpcglQkIqirQwdTT5IuwkfotOkhChjhpR8+Hh
         WuWa1ul96oTwHUQy/Sm6JrnMJYnBEHpu3m6SbGI+yHRYzw3Ignct471y3eSEM8+vzRqn
         lz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737569550; x=1738174350;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNvGAAWWGFQC9Zo5194H+eGcmqmXeFUSRJ5hz1QrILM=;
        b=jQSHwsdgxd5zSfu94RC5InIlZ/BlNN8ejZOrsHTpG/LIJO34XHJE2KcUpRLXUJrbYg
         O6ip5/ewLG9MHGdKS894OTKmc161iNMWNO4E8BRa9qDQPVtuEi63c1l2dQuu2BUknU9e
         4MvURqNBQYu7aAVZI4bcjDfYTxdcmZVVnUCTmL9TMh3xfAqcst26kNsuFO1Q/3GxqCjP
         x6/oEqzaVm0mc0vlM745O/a3faD8GKdPCcDjWwqmvPmwlLmdSqsmc98tJKAewf+ORhGp
         N10kjBMbwomZjDxlz0Q0lBe4FXZsoBocZ7S5LNa6Q5qRUcL2coOljxbyUxdYZVhDPkZH
         iDww==
X-Forwarded-Encrypted: i=1; AJvYcCUHB9tPwtuzdJwDuJOmBf0WzYW0QmuUTFRUq6/hlEHEnc56Q0/JGi3YDHJdBCfBHgW6CccUVS6/@vger.kernel.org, AJvYcCUhEA4CXJ9PxKBV3hRnxhYbjGcAfybRmi7SPgwnGY7i2TUPzSeKDA1Lrb6rz+BNNQQmWOAxpgx9RjOyKOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWxQB5Efd18lsxRZWzZAaqUwTwdzq45mOwl4WBhCbo4RvFak0
	3o4YR/rEdSVB8qOOWSgkiY+ie74TwdoWWugYYteKXJdjzBDAC3T6
X-Gm-Gg: ASbGncsKGYwlR14kL0Ls2AEEWNsWR902pimOKhhtPI1pBdpm0fQyezxdv3Qwvxar/Ip
	xZXhFxtypfxrE3eCCeyk9dDEI7eFBvdBQ+YpjIJ3e+Ww4ydokcgGKSkCfhqxA2vkGxM0KP2UlJ7
	sP2vpGkhT5j1VNrb+u100uTlyZy2QO4bqdv0/ZqcvA7m1jslHmd4DuKybhFvG50wgt8NvNu5EfW
	g64bKkf9hvWR2f1RUz4taFodEkH/7vfKfbRmJFuti6uqny5mwWkx7OsKLGVnvBZclZpDuKzTJLb
	yP1YQlVnup948DUKdGmQeEMh2kWP5HVn
X-Google-Smtp-Source: AGHT+IHRrPNlZ+6TzEel53Z/cUZsBfLNG4QPsxpB4GRxkYJwe3fS38wsqgFel3dj4z2ruZvUtfJe1Q==
X-Received: by 2002:a05:6870:7d8d:b0:2ac:2937:299d with SMTP id 586e51a60fabf-2b1c0d030eamr12304609fac.39.1737569548316;
        Wed, 22 Jan 2025 10:12:28 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b1b8ff440dsm4496753fac.45.2025.01.22.10.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 10:12:27 -0800 (PST)
Message-ID: <ebd9fed9-11e8-470d-860b-a019a707378d@gmail.com>
Date: Wed, 22 Jan 2025 10:12:25 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.127-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250122073827.056636718@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250122073827.056636718@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/22/2025 12:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.127 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jan 2025 07:38:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.127-rc2.gz
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


