Return-Path: <stable+bounces-107752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BEA03047
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31223A4E9C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601581DF724;
	Mon,  6 Jan 2025 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9Dv9fYj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C901DF74B;
	Mon,  6 Jan 2025 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190717; cv=none; b=qYcN90JKPvctEyA6VcBmysk+4D43Jt5oeVz6orbCq4GVTMjQEDTTdeOYpuBcPPmHCjgL15cnC3oblaY2EzQAecQxEPdUK6BABV0rs9q157cESfarAgMnqiF/YGXwAxf7rBGnxHIGITEcMDcwd/UA14B4lXAemh0/3aEPFkxF0fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190717; c=relaxed/simple;
	bh=4bnJouhl3Fn0czsmNLrIkLHZYVAywAD0MWE1RgDLs8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DA+wrtJHs12Oz3TbasQtzfWc6JD8dQu0Nmd7x1TrRsKPdzmM6VXOXFtaZChcvgj28eRsn2Vlom/UGfSs5WU2VoSkzb/TW3OyJ3dshM3pZ1YKzJLhX0bsbOgu8Uv7iKWQ78cUc+YeVUXb4Q8h/3S3PqlsOUP/q0sY/AmMNuweLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9Dv9fYj; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef6c56032eso15783254a91.2;
        Mon, 06 Jan 2025 11:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736190715; x=1736795515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xNcgslAq8coyl/n5XKt4DbJIGhPR1eHHxRf8/YdlWTc=;
        b=T9Dv9fYjKDD/L6995w1UJ9ldXL9d8smwWfnp2ktQ8h+JWtLlxC3qaPPSKSDMcereMV
         neT9hM+k7HTAsTGsv8xNBAftw2CfUfdlbBCDiuR8fpyNhYOR6gn+YjOlRd61VynQx99b
         XvMQKw06WDr5Py4m2iKTtMeTI3gn34Xk9Mzf7MSW7dWQiBcZig+OfFxe2NgUZanHn49+
         Rte5ZibRT7YdYCr72C6Y0SdvU9CTY9yHZ/MPAzRxVt75KKdCpiJc8JUMwqhbuTt9I+wj
         3xqMovUO1sI3ijcMF5X64gicDGnv9B92kSD/BYWajvidWp3aXLsnVV3KoTS7odHBegTP
         xIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736190715; x=1736795515;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNcgslAq8coyl/n5XKt4DbJIGhPR1eHHxRf8/YdlWTc=;
        b=PWfs1iP0BiOipLi1u1d5KrplaHHq3H593ZZ9zWBBV1lmrBf34XB0eBahHrbHAUr2kZ
         ZftNfnesKYQJpsv5sfaeuLbMFo+uaDZKKQFVNZdHpGy9+RUVlAZnmHtt2jMpEYXr/25Q
         fhNaK7EbScYmrQ/f+fQTja8T34mEOYpZevtEaJxrZmfWs61bjNf6VeedtA7ln5MUWqQx
         kpMiZW5lUyesk6hQYjoQbP/HSI7oZPiZnvjLLCECy45+5KT50jfkwkkcMIbORZd/gziM
         gDnG/ST1lIufOjGkghkQI32vzdlspXrwjw21+T3uWeGCHBFMWbggu5QsfAAZDN6LRUAI
         zcnw==
X-Forwarded-Encrypted: i=1; AJvYcCVXdy3X1ZZ1yr6vRBlNlRyIxhHAsa4ZxE6Qri2grGjEUKn/oRAGJd4KkfuXROraHp/vKfJTOpgGC4dZzvU=@vger.kernel.org, AJvYcCX2MOL7a7ilD0pbcQKSI6onkbLSBiskArZ01qWOc8gUzT6cx8+Tr4hqvhU8sgRnJb3I5w/HloXP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw42ReLbFgyncbbawTWuZWRsWgfPHCGLYYQOyo5WPPXwLdiArO
	dwxg0jNzyqGEAEw/7umXz/h6x9hTeVtZNCW8APwo1E6QG/JZAVFU
X-Gm-Gg: ASbGncvfwRvP5dUpmolKAxbR5Wb8MSMggJX3mQbp7onnLUmWrOU2rpYDeJ5s3LvicB0
	YCjxUbYRmbo+NBPb945R2YMkXu7N84Jztwa9IfXadVl+/ent/wAB9C1H0tIFWNqdIempIbjwmIZ
	nasffoNNFNbTQ04nhXzydkyCUYWwHW3+OJjvGkWehxEh2ZBJNAey0h65FvQY1VwCCZ4iPksoRuG
	bXK+U1CuHKDz6EY65ZxAKUvIzu6w8s8EuTCDeE3nwVGW0Vf/S0e+rX6kGYpGiJwFDTiytiQxbzg
	epe1tCbb
X-Google-Smtp-Source: AGHT+IEzqwc+8Il5TgTrh//Qdxy8eQvafKJ2eP1eNCBEq/izr7NWT0Mjur4MXNgl4trbVix4/JRW+w==
X-Received: by 2002:a17:90a:e18c:b0:2ee:e317:69ab with SMTP id 98e67ed59e1d1-2f452d33b98mr104243667a91.0.1736190714616;
        Mon, 06 Jan 2025 11:11:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52cf9esm39711568a91.8.2025.01.06.11.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 11:11:54 -0800 (PST)
Message-ID: <88330edc-db2e-4bc0-a21d-172636b7b10f@gmail.com>
Date: Mon, 6 Jan 2025 11:11:52 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/138] 5.10.233-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151133.209718681@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 07:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.233 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.233-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

