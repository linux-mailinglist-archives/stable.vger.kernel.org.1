Return-Path: <stable+bounces-164289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348DB0E3E6
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 21:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84850567579
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD4E1422DD;
	Tue, 22 Jul 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itv+fyIn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17774278E5A;
	Tue, 22 Jul 2025 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211320; cv=none; b=FhQdkkXKeWy2cDIZniMzaNaWoHpfIxqjZBIDAM7nVOIpEUsyduLzP1kToS/BmyRQYG9CIZEdCD/DwMUcIa1Fffz4ylpPyC8PMbR0d1JKYUhpfILcfFzVFpBGx1p8AM7Hd3m38em+Ljt2dD6DGZuUw+J+S6VBMGoVoUx5M9/jFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211320; c=relaxed/simple;
	bh=WhkRd3BMuVmcqkvwnUgVzQxYn1i3OPyNE6F/d7jYi/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dusrADCzCK1PaolqCJaiocaFFYpF/wuzS+hSgok/nwHutOBayOIMY79JdrMgsy8dJjSIZTtMlOpgUrn9x6bqZWQwFibGSbXSBVhjv1y6HayHSw+AOIlmzygxK1xPeXQgze/FfXnToUr7yAMHGmCUrdsH3Qfputb1zplO8ZQr778=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itv+fyIn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e169ac6009so601124985a.0;
        Tue, 22 Jul 2025 12:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753211318; x=1753816118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FHLZA/TNhkdskUZodZoADZK/4mKalHq7MQxkf8qHFVU=;
        b=itv+fyInTLFhdhgc8B9c+3xX2/Z03oYJcXdZN4dFA+5b0gCYV9vjkygrcwo+6ts9kU
         SNb+2Dkm0fBx6LbAlEKUjcElgcuUjtbl808KUJDkzG95l7Jz4eTbZhAxVAYFSyGl19u1
         wozV4SOCRignK576Kg2s8ca6zKSfV+OCqkyLzhZx0M0r30cnLqjJKJSCK+QtK1XmpoPh
         3/8eczM7t0IXR7i9Z+3X3kaxGTABP72NZXzlQKBAf5jxBFAN3n61wPmpzq4SJZUA19HM
         LMT8d78E7bZY9lvYqzL6VFiimG+RjphknwOCySQgtS7dmG5lu6L5O/jPaw86bQQq/SpY
         5Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211318; x=1753816118;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHLZA/TNhkdskUZodZoADZK/4mKalHq7MQxkf8qHFVU=;
        b=JrpMYo9gpibBtzs5HpBRkWvo5vJyZJnDu0flvmd7tl001H+WG9imZgYXFUVPKKqy/D
         sxrJmbQyflnEZAz/OqVpinSPbbdHjjf8Uf3ftruOAejzQLZr0ZtleCeBmFtwiaPeJA+f
         EMXb9zRVs+87vCDhq7qG+5auFbp5M4GduyreGGdg0T+iPCR39wDDkCuBuXgORDYEW7t5
         xDXzTRS+26oo+zXXLOAv3F+i0DJz8ki2oygYIMVl/XBn2r+p69naSa7ipNP2Ne54GPQz
         weMtgTB2+Du9/RbgdkHb7E0tny+KwFU3iAiWu0cyCrQZ6qCl0Y0jK1jIe4XpxI1XkwYI
         fX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/znJURX9/GcbD5+cXxTWP6UHcIuKHPCumCNNokHO0ZrN8VYEGB2eCDWY1C4I5ZUxJfxntlTg6@vger.kernel.org, AJvYcCX+60cZ2D2r7265gdjI/vVtzT6fDGTFpiMdiNgACKtoYvzzM5R3EXDR46dSmWnUI/3GlZtxdLleYz2XtPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDHPTkeaBskGMLPgFKON+LVbhj4/lFcstBPvhrH8WZdWv6tw4
	uZTQD8mCzFRqUCmTn9mv3SVFN55W0juQWM0ZAq+JW8hXe+zbi8FZMul2
X-Gm-Gg: ASbGnctqrqKaKj2bFEwjKKvT9dJGOqQWDvJyFZa9rO4Zh2RvP/c+JucOy7Tb1G5JBuQ
	DsuZALJRHZFrD/8NBYjOdVZ3qzArV86xdVO0tNMH5yDUG6b1CZNQU/3kckyW2OJky9A6By+/Tq+
	6onTZImMwk+/yRm8Y+ti2Ez4WLC9S63B5fHSw7QlV433BpOxZk4cmJn6AQrq4FOkHxwNrKNqrgY
	hb/KWuhMWbyWPHBPAOu9YIv3izn9Qg1Tu9i7cceiT4zY4tVWFfUaFTU/lB15qOgTTyw+pU3B5kH
	BQ+OCPn9yEupNcp8RP8+EtEazYA/8xcav34g0WM0q4W0Z4xkV9XzANWCB8Ij4u0Q2/aZG79Ybvv
	30c8zHkaNFYYR5SZeQ2aE0iQ+I9kcqmVQ1M1+jfZW7ebnaRp8RQ==
X-Google-Smtp-Source: AGHT+IGNgcPjfLPdvGxIgYqVQy3cXB62yix4g1E9jrm8kyGNK60UwHpmSb9lrMeYKsJp90dZKBKbRg==
X-Received: by 2002:a05:620a:454a:b0:7d5:e34d:faaf with SMTP id af79cd13be357-7e62a002111mr66499885a.0.1753211317744;
        Tue, 22 Jul 2025 12:08:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c3f7acsm559967485a.51.2025.07.22.12.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:08:37 -0700 (PDT)
Message-ID: <acf2e205-12a0-436d-a105-e06198d3544f@gmail.com>
Date: Tue, 22 Jul 2025 12:08:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134340.596340262@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.40 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.40-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

