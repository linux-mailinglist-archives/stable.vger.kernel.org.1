Return-Path: <stable+bounces-163397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5EB0AAC6
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 21:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547E7587A92
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 19:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D521A931;
	Fri, 18 Jul 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3GD1XJv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CEB16DEB3;
	Fri, 18 Jul 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867678; cv=none; b=SLMskoJSpJn1BcXgPVKJBXuDqaRcS1ajLOh0r+MhGr5STJauMgphnV6EMw5RXbF3WIgxwnIMiSVmR548hDJ4b3Oaz/EqNDin7huoFS9l4hqUgY8VuveASqQQpSpNgEWs5kDodibhAfXDadeLa8Ph8MeFGEttSa7JbYOvhpCWg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867678; c=relaxed/simple;
	bh=Wx7mxq6ChQzop4uQY5HgvaOf8Be8rggNozwfzEt03JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js0yb/QzX4VvRzh308P39Pu9AyRRq8iIgVEi9SsUuul/QRdQgFeHeEYeP9TpekRP79vVFdbGphQPw31djUKDvRrx2iBiohcjI7btwD/EG4j190ZZxlB4cDLlcF5FEH3LbkeYCtbR7xbhzs9aN60i1dorXBCwHzuvJw2UahP9Rzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3GD1XJv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3141b84bf65so2378637a91.1;
        Fri, 18 Jul 2025 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752867676; x=1753472476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SoPYutq7OwNpmpsRLgWaCVualalc/gklRd4if3lkUSk=;
        b=O3GD1XJvpGznC+pMncQtMFcu5ds0egRLq+z7YZh8WCzNzuMphwXfAafESkHuhjIL4a
         8qnglLd2oYRypw5EVU9wNLPtyy862F08FDSmMUkJ3sewQQYyFfpHbFnAu7xvnPoz1QYA
         jOgk7Ph1IiIrkYs4/bO6vc5lgClrMUyad1YH41asjApEnGn/C6xBkuPr19SzuRf0zP0i
         xFyGDlIlmlLrxbXzsuvlWvzio8RLKMLlwWN+LLpnSzXFQ2E8cWjOdQ+MOSFGtoI/7uE8
         zFFGbji9vcux4hiZy4LwfiFO4q4uyFTJtxjEHoNq9Tjf7QaPlKcQrCXhgmTGJ8zJLSGY
         n0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752867676; x=1753472476;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoPYutq7OwNpmpsRLgWaCVualalc/gklRd4if3lkUSk=;
        b=h0gleZU4jMsjo3KN00LGjLujB2eKNkp7adN/mSrUlrOQn3SlPRZr5NJIlio4i+cT5r
         gcn7BFPYaksFwCrFjKgCL58HloebfNbyFn2218ykRtXC0rXVuoo4DMvV20u50knePt2Y
         kBLw4yVdzOvo06cTz0uGM6pRm6Io87+iaACZ//jd7ht9r96tZHA+O4U+4KOu/F69HBny
         BoygKOWS4uIflx59U0MwUcM36MT4i3SdlwOALZsVKKbSeOVDktYnHtum4iTngYza3Dcy
         PHK4nbKFxriLH41g4LJUJRYqjP2zzUHaOSMypOrh5tZ2eh4kBhoOptTtbYGJcBwTLgE4
         v/jw==
X-Forwarded-Encrypted: i=1; AJvYcCUkv7dGuOLc4Ea9lOARldJJeNwZH62NB6bGk2DDEJRColI3keIkZTqoC3NZ8PkRwk8lwI3EOeju@vger.kernel.org, AJvYcCVk9T4iEefETle4VjF8CSYMPkD1S3tbw5cwVQjbxK0vEpp+O+EPkpmHBgTZu9RIWxK73OzdnZb5JAwGmhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzVxKO0LECKpyqHSke+Px2jv04pG32odsj5pUMO/MCv2uBGcXU
	S+GN97vcLhHtLqiZPuU2pgsJyD53t5LFArdDJ47RlEECxMqnEQwg0SJU
X-Gm-Gg: ASbGncsaF4J2WU5Yx6mqysMXhruazpab38Hdlt8J2aMBzj81Fpn9VvioF3aSlLT30+v
	X9SYItLSuVZEwYpfPtSfFJozgMNmqp7ZjMyKjc+Nx1bS0b/k7jYicsD+UB8ahEfvkhKmZpOgXPN
	MJmGHrGh5l3HuwucL94mFMue3LktzGgzvSmlCTsEFgx52BZpprLtZ6kqGfvEFg1c6rTwiwAF/Cm
	YiDPDoBkH5NiI7Eqm1ta7JkTVNa2k80bzqZS3Z0a/fb+ZoaeLEhmcK80STi0ocyQDlAKFWvBmZ6
	gNz57oETxAtAQkZZwxCXc/lwpS5ZLKFIDu4oG57MQ2ySbk4gRuPD1qjs6EvsNYY5nvTUjRBW74m
	gN+aGIXYfPCQqACheiWQkgBu6uW7yjkwLxUuSaUksbUXNijsIxMkfOSHIe+Sp68uwu1aQMIUNEo
	CEqoTJrg==
X-Google-Smtp-Source: AGHT+IFKiTbiiVzpbk8QLzuU2TDfDJkO4hgcDcJQmWINn6oefs5kIWYWadN7OxzI11iXq/hcdLw3RA==
X-Received: by 2002:a17:90b:1d0c:b0:313:1a8c:c2c6 with SMTP id 98e67ed59e1d1-31caf8db7c3mr12573609a91.16.1752867676486;
        Fri, 18 Jul 2025 12:41:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5b40fsm1739688a91.13.2025.07.18.12.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 12:41:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a0db796c-952a-4e97-9510-760456617db2@roeck-us.net>
Date: Fri, 18 Jul 2025 12:41:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/144] 5.4.296-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
References: <20250716141302.507854168@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20250716141302.507854168@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 07:14, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.296 release.
> There are 144 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 18 Jul 2025 14:12:35 +0000.
> Anything received after that time might be too late.
> 

This is just for reference, in case someone else stumbles over the
same problem.

i386:allmodconfig fails to build.

Building i386:allmodconfig ... failed
--------------
Error log:

/opt/kernel/gcc-11.5.0-2.40-nolibc/x86_64-linux/bin/../lib/gcc/x86_64-linux/11.5.0/../../../../x86_64-linux/bin/ld:
	i386 architecture of input file `net/bpfilter/main.o' is incompatible with i386:x86-64 output

I have no idea how that happens, and I don't think it is worth trying
to track it down. Given that this is an old branch, I'll just stop
testing this configuration.

Guenter


