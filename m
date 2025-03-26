Return-Path: <stable+bounces-126760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB068A71C09
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C613BE3DE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 16:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B851F790F;
	Wed, 26 Mar 2025 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNu5xj+K"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBC91F7557;
	Wed, 26 Mar 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007273; cv=none; b=AOtzRBiS1vhG8/G+sZPSD3cAngA0/tzgaPn31diM5r1GNaa7YwmhnoBEaHop2/wHZ1L0VkPbWJ3m8RVeoCMc7RQZ6ltltER/JNHNrtbresDbCvETgvc+c6AASHOyhkQECk1KeacHlA1V9p7m/upXqaf9px8FsyouzTjsxvuydak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007273; c=relaxed/simple;
	bh=TRPCTeOblCNc+WaPMVcdL7R3jZ+yjzK8dIVH4te2LzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fi54Ml191e6lolL8F/1GkNsJC5WIN8sdhW/viLhlixMjD42MgP3kMzJ/rwYIlGKhgg72zRwKg9mxeurOnloffYUpguccb8f2JwvtWvs6AznrwnP4fRrBj00CLOAs2YXhRNlHVFdSLNkGYmfQ61FeExLCZ/Fo0JQVd3WIPJVia+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNu5xj+K; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f6a92f234dso3996791b6e.3;
        Wed, 26 Mar 2025 09:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743007270; x=1743612070; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DuR6RrNn5JVp/SGXjPsHV3iRc5Uc6pEi1SUbL9dqAmA=;
        b=SNu5xj+KULoQNnEAPkMulkr+W6uSupFCE9mOh1PNEMqJ8mlPCIHf1LPYf2RxLWEDqb
         l8sMLJRXrYxeRI/vzcyO34GTX7njyUNQ/umMDOcL1/U50dED/58fvGD0WyQVUqSoxfOa
         op9KSRCEUkR0bpwgzgTNC13umduT7Nw4/upAJp1RLEWtVHCZiaNi/dN6DPtUlNur26/A
         lmwTCRSv4RcW7tCwzxk3QPZhBZI6nJ/GueuHhKNeEcx4CSkS+pj6Y3/rxa6hu/BuY/nL
         b7PY6M31ysk6+8AARnVX2reB9prAipX8IygqokWDqidAiVWgiXFGqqm1WpGc+bmU2762
         zUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007270; x=1743612070;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuR6RrNn5JVp/SGXjPsHV3iRc5Uc6pEi1SUbL9dqAmA=;
        b=HbPogLc+x/KzGprJ4jx+ag3DTGs3EZ5knMpMvJj0gYAAEz2/pWjpEv+NiKtKLn/zuc
         kp9rUrZI9flQvPyTzr3aBLtaVlddvPIpkYJiO06ceVQhUjEZuJ8T+9TZXPTe/iXWTONJ
         854betV2keOnjqS4J4QLvrBO3rGvPxpYQlxa7u65epSLS2wVTasMF96rW2ttqov92fqL
         naMvwSgVka93aLQAandsYWKX/gOWDaoeEO0dAoD12bf3eCzr2NmEmxTXcRtUGvgwjvhG
         XR9joVE+m7aLsLTkrtU8fL8b7WWqBglf+CfSpzKHCq2N0STds/aZU+9UTlbp66CjJQwD
         xH4g==
X-Forwarded-Encrypted: i=1; AJvYcCUOhQUQvYI1L4O9pU+JsGFTHUsrzeg0k4NxJk+UVfCy2nPrt5WXnDd9Gevgti88sC84EZvUcVQhE/yPmM8=@vger.kernel.org, AJvYcCW+oRjiP5Auu88JDYZYhkRjWQIHvu+vO1Kyj8Z0CjHb5ATx0sZ8fODxx3J2n0zNj1kHMFr1DkEV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GvZqrq9VRIn7ocoF0+i4blEJr74ecd/+dsKpOzEpRK0q4fJ8
	XdqG1HnmWkUmSUWidJOgkEwA75kLNvZRjaqoG+yUnPdlNqZh2yLE
X-Gm-Gg: ASbGncvf6M3zEIaneGrTfN553V/gizuJfaRaHQs9ozO77p9JUuHrdTg9MRPrA9rNtDt
	L7NYi64l27nsGIo1mxdmVivK4GsMFMg1e/75fu8gmTQRk9isLS6iv/6fVkvu1OYOtHgagNyqTmW
	TcNbeRt0SVrG6GQowKpx+1WSJsotvdK9VbGyOyemYN2ByUJo6WyjXcKgXsVhq1QinzAZSBXXtrd
	RXIZnhzkLxqJTzr2w+ovPOSF46TV9LaxZxgN7pbV9kyVNii0j45wJUMh9s7/2h5Ue1Nfo6te3AC
	fcVtA5UHb49EsuMWfWJjAB08kzJBxsBQd4SJCO5bMcUHkrOOJQBj8cBnGU0jFnO/7emSM9KU
X-Google-Smtp-Source: AGHT+IEmQtI7rlWgL7N8H1faOpD3vZb0pZHTQTAvPeHVI00gjl3GJfby348T43wqGb8GCvK22tFxLw==
X-Received: by 2002:a05:6808:bc7:b0:3f8:91d1:d950 with SMTP id 5614622812f47-3fefa6309b1mr121472b6e.38.1743007269922;
        Wed, 26 Mar 2025 09:41:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3febf6e95d8sm2431122b6e.13.2025.03.26.09.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 09:41:09 -0700 (PDT)
Message-ID: <542780c5-5ccd-457a-9a61-4df9144d38de@gmail.com>
Date: Wed, 26 Mar 2025 09:41:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/197] 6.1.132-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250326154349.272647840@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250326154349.272647840@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/25 08:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.132 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Mar 2025 15:43:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.132-rc2.gz
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

