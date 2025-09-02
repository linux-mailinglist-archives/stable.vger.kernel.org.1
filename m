Return-Path: <stable+bounces-177531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB09BB40C26
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807F25E3D5F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F06345721;
	Tue,  2 Sep 2025 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuxqRRm5"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98E21CC59;
	Tue,  2 Sep 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756834419; cv=none; b=rSAOFdLDcOKJ1IFVfRLxzBmkAk9kIw8ObE/1rbCUXdKvKrmODwKbNzwkAyd6KtDjSDyBiQI2Sj1R1EbZ8657W6rjT87Rtv9I8ZF3H5Pv6xtn6bLjLnPmJOl4CaKaKA/gIINWVwIrHFONItH3GbgVhQ9tbLTAi1+WH+LbI/vwk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756834419; c=relaxed/simple;
	bh=1sb4mNzJKiBNJOkSjHwyzDcm6obJKevfcRIBh9I3Y9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IlxykomXS6QQaL7zP6DfUrgBmnqQaOuKmtZA/IyFZ/1vFJ4HWimhTWlHKc1o39AA/FbbwHb15MKzmaIgjzCyauqV8935M89Hm6tz4pepx9TDvL8Ib3X4tNTnhw3vk8b5LAbkhnnxmYlWm25VgbsSvDX3UX4N6BFwMWJNWxGRriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuxqRRm5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-71241d44792so31415946d6.0;
        Tue, 02 Sep 2025 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756834417; x=1757439217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6qN69cGhCW4JcQNOQzKp6W5d08xWFi2OKORK99dzBII=;
        b=PuxqRRm51yB7CI+GvbkDH7DfT9RVZksNrmS+wZCYVjbZHVi/9ZVea6v7vEcqO2qBJo
         VlhIAiRZxvKqRZHQjBp0tuPweXwhBiy2z1Hr3bt7zodpnBP44eIP6x1ncClNf54t3jMH
         t62LMAWM0RjhHfzzoO0FMPrQxkNbJagTJBq/DXvnrS2D0o00tcQTlTOqQQ37VsAVL5DC
         xYFHhTBvEZCaXtlYLPFEtGJr02E9t7ftvV3ts0yh7VvNINM9pEvPnsDEpZGQGjkbT3uB
         G3ct5FEtoIfNWC//iy9M4uxM406PSg0Qyk3FdYYx6o654Wy2J/1lDqFJzRjz2m5CUkt4
         drtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756834417; x=1757439217;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qN69cGhCW4JcQNOQzKp6W5d08xWFi2OKORK99dzBII=;
        b=BSyA4Yf/IWCcyBKYyFtRuzgvuns+GNDXTyflfE++Ej6RPqbpS+NnwDqod6wcPbweDe
         UUB2lt6dmVe7JG2aTgpYyy7pmjRNUIccK+7h/PSXQKdc6KTib85Cd3oEMWgxZ6oLp4mL
         +SLM57sNuf6KWYCS2XwysbXK9VlV4u+8mN6WnJXM+C0IEOBYxqUP3LJ3BXv1wPai7Jvs
         P41EwvLvabLCict0u6tmdadwpNQDpjNOBG1qO1FfJFx5DnA73YB/JsYS5IieFGTyZkc7
         LVJATddMNdy5C/Kn/sOcfk6seaPwfsdTg9bYZ2fNZSbv7HYEFeGC9jiOiQkQbMKSu//U
         wk6A==
X-Forwarded-Encrypted: i=1; AJvYcCWYvJbREVV1OAINU6qw+WjphZSOkNpJI/nJuvIYRXyS5fg7z9cACPNzsC4yAlPeAp+g+F148jpa8LeSXTc=@vger.kernel.org, AJvYcCXEBaGhr5NlFqyGp7OxU/xkxR2b31HQyOLpRpOJ05Mm26AkWgXYJNKoxhQZbO2EpW0jKxiKKz5d@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLAgs7uZLn/2csX0+4Vxx5HGM9ujyTCNuRXfvCYvsRwEfAYXc
	9ygsre7MQNraVAcz1Rn/odyTWzwHTdJBtdQUtf+Efnv6baltGHNRZSZY
X-Gm-Gg: ASbGncsfSVWrE1CwpFrkdXXAEKL/HWZcRC0RHdmhv0LjGaK7VKXTlx1niutIWXfWp7S
	bM51VOEKMsN7ZPKbwyI3SuSGpGpsn81QwX9aDAgHVQa3CswTsZaTgasjwYF0hfa9fBxsktyJcAZ
	6a3pfe9Ktijfvp1lVC09rgs/p/ArJhtva9oAe5bgajga3YEPbHsf0HUhBorJKQwULjapKLF6tMI
	bHFWaz6L43E5+fSgP52LJVOwR9piGDDXA0UzfXIzV1ngDyms5IjcKABrDBg/jZDoRyEL901ZG5d
	DNHeEk7qRgGdBU/lD9T6gsfeW0NPsVfvRpQW9i6o1ulsAkF+dsX1MOJz90vHzjKSQaT3jIMYRK/
	RLUVCNju8USmcSRi93wEvNtNSncOsMV4a6A887oOO3RszLmmieMnajcM7hcPT
X-Google-Smtp-Source: AGHT+IFgSFSvZEOW6oqviYgs/lS2mqs3G5IXLNF5/g52GWc526Espn4quku/UgYDjQAhamCPVdnpJw==
X-Received: by 2002:a05:6214:cc3:b0:722:48f8:66a with SMTP id 6a1803df08f44-72248f806bemr8840036d6.28.1756834361702;
        Tue, 02 Sep 2025 10:32:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720acdff0dbsm15143366d6.18.2025.09.02.10.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:32:41 -0700 (PDT)
Message-ID: <7a44540c-198c-4e15-bc87-f93c7e3a3deb@gmail.com>
Date: Tue, 2 Sep 2025 10:32:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/33] 5.15.191-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250902131927.045875971@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250902131927.045875971@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/25 06:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.191 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.191-rc1.gz
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

