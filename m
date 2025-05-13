Return-Path: <stable+bounces-144144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E1AB5021
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 11:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4438517BB2A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628191E9B12;
	Tue, 13 May 2025 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2gqOBkC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A791A239E96;
	Tue, 13 May 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129424; cv=none; b=PbMmanhmVlz+xia59J8G/TO+hat78fgf5vC2SlV+dlkI2HyR3hWMyqqI/z8qm5SCFdkkdcqLtwT4IPctqAzk7ms+nB/MvXLzA80hs60EIkSLsoNsZxV0fHfIb8xaJCPDv2jhtF4V5eAi5jonwC9LWAPRNyI45z5OIUA7PYBU+Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129424; c=relaxed/simple;
	bh=B6INs+ab+G8y90eQLX78HEfzxVt6RXKWOK3/Dpg9xik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bygoJJY0u6r89LCywCJ8Ux4VvCTxO5AOfQND+ZmkC6TmaktowNPe0AuHgjSUeottpXehIdFrmFJiSY7ZX+4JWEWwC0GKxBNrwMe74gSwNGh6cviJmGVpo4n1VX6uOavSIZF4Up8q9ZyvPq7+2Z18Tvjh1e/Cxn8eiT+IB0SK3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2gqOBkC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73712952e1cso5336918b3a.1;
        Tue, 13 May 2025 02:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747129422; x=1747734222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FveLRfI2XTkw1DlA/5/bt7HJXreSsKBNbe5njxTELig=;
        b=m2gqOBkCK/C9Z3ri09w0ZQqXwOURE002ks5mn+vXwKyO7G+2L9oxJ9OKFnyfm+W6oW
         qf4Emz7CjaZqNzRNxOIHCNmVZwkmu6aV6y3xobjFTsFEV/STOe+9zTiiaL+jjb2Vm/Eq
         Yns+Unc1s/E9Ftj2KR/zVJhPhjYlSWGL5Sms0oKkCGRub/N+Cm2/zoje/FuxP8UhzRv3
         PONqy94cJxWqS+nSNxEd83mY/C+unS3QHqh9WJtF5+4v/OOHBGKxQDIREi8LpFoEd8mQ
         BPF9GhOJMm5//GUpmQexqLa+sHJIdoN5mCKRHSW2TP7WSJvXsMJuAqdJBuEhWIVSgbjw
         0Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747129422; x=1747734222;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FveLRfI2XTkw1DlA/5/bt7HJXreSsKBNbe5njxTELig=;
        b=wbnEArWbBd/fSkt3pUhhv8RFM928Upfbyk5xuK1WTpJQ1cMUKAG66UxMD0RX1pKPDa
         1KQ5BFmqjEcvBUD5oiynM+ajwarxTA0mwTotH6NLdhX5Jg847stahLONrNs9TMbCfbKl
         FXpU1mcittrZ1DfOzmeJFoKh9+T+NB61r/6v4Kt2ar4s477OayzYuvuQZRBdLkh93gUd
         vGqk8IpNT1B1qZrWGgrFtoqOU+BrL4JZNU9lGQOkkyrn18RjzNSN87JnKz2F1DGFPuTC
         TIsdD+jeUW0mAM4JZXH4W+NUDfYljDnFLLn9xvKxHDscWtUSCmz3fUKUJxmKKKcO1YQG
         xYpg==
X-Forwarded-Encrypted: i=1; AJvYcCVuZBQC4F557PtxQVMXkK/wBbKEkMzqp6AFgGd5e2rN5A3WYNMmDgC1Q29ESjjPDZ4wlqPXm4mD@vger.kernel.org, AJvYcCWQRyz0Ue1LUc+M+fWCWJE8uuN9yapTXOJTkSoSvadCiFQIC/wePB++SMlqmJggpFZicy4yWZRF9PxtjnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx29SCxccsNoNPESKuTINgd+YgU2HJjXHIMZlnpiMK3aH0zYfv
	nziAEyO+GtVkxUv5aK9C+CfrvGpeJcBS4BMxEl4Br1JbBDTY+ocW
X-Gm-Gg: ASbGnctVq4uAoY+u27MzDIzdu6WtJT5fTDBww+Dzxdvu1173DJ/xxCcAL34uIzhhBAq
	misTwZ0UuWxZxFn4jLZYcHGA2xzV4H9u0OZoh0PJKtqXgThvzkbEHQqCJJ9ip7qM4M7Ht1GUjtU
	67Th9nsbBI/QtwlJ8xA2RJL2Ppth6kx92FYFycjM+0hOIKAgV19ciq2brylJz5u4nf5Ug5ujgBy
	ZI7B8OTP6Xly/oaaNQXumJhfulCRbsRy2lNDZorp8o/xzqjGAxaOzFInuaJT28nA6rfeN3gZqEA
	gd6fNCW0Y7ic3iRxRLkac4y7xzDnBhw2SGcW0RrYdYDcJfwM9pFzIj1ZL6+kYPJyBHyi7rwBXcU
	2eFMxm6wFphct3HoyCIYeICjid8y4moQiRsaZHg==
X-Google-Smtp-Source: AGHT+IH4UzaiCuDy4Vm+20HRgmeVBDcwBJXOOE/MyeKZGNu95IoTGVedP5pvCI6B0wzOcZ8f06tXuw==
X-Received: by 2002:a05:6a21:3384:b0:215:eb6b:8714 with SMTP id adf61e73a8af0-215eb6b882fmr4729730637.30.1747129421864;
        Tue, 13 May 2025 02:43:41 -0700 (PDT)
Received: from [192.168.1.24] (90-47-60-187.ftth.fr.orangecustomers.net. [90.47.60.187])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2349dd34edsm6866074a12.30.2025.05.13.02.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 02:43:41 -0700 (PDT)
Message-ID: <b2087e45-3937-492e-a39b-de2591dab5b0@gmail.com>
Date: Tue, 13 May 2025 11:43:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.139-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172023.126467649@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250512172023.126467649@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/12/2025 7:44 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.139 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.139-rc1.gz
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


