Return-Path: <stable+bounces-147876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C0AC5A31
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62A491BA7EFA
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F2280CF0;
	Tue, 27 May 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG3302Cf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC830CA5E;
	Tue, 27 May 2025 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748371393; cv=none; b=Wc8UrMmikTWe0B90qPFCwnAvjP/n/8If1aeCGsipGJDXZeyhXzFVKsVsPkYjR7QFar28IasNAWABhxEAJ64u7IEPQ6MWU9KXl5xWYKOsQ5tBdebZd7PqmeP77GdMuYWOYWZQcm1A1GU/tm03rdnmMOEB6bpk/yPA22+/BIu9wDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748371393; c=relaxed/simple;
	bh=Uxxqi3lPyUurFuC0j85HtbPTxOM5XN/7nIKsNvQYQOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdelZwiWP2vvuDujFuDIllsFXD2ebErqFPcts5RsAoJskFQVcLZ/vExPtd0YxdKbaG5II+bLYvOKYF/DF/VaiWy52blNJLxcgqOS2+LqrbcG2+uN2uXpZihb7WAU/RbTNs0dyj2Odspdo4ShkcdxnI7ajoH5sNyQH/H0i2G7EZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG3302Cf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2346765d5b0so23142655ad.2;
        Tue, 27 May 2025 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748371391; x=1748976191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FWrKohcnIv85cbuc7n+x+VuRl8U7VNcTKUXVw5gcCyU=;
        b=EG3302CfL4bXPiYCRQeqJksbN4SsRd3EFQiGWxIYz3acmt6/ptmWdAuqMwOYxBc3zC
         C/llbnmZsKNn1kTFYgihm8ftpVX18nQCSkJH8RrvXXUDY9iwS3qy4RSVZgywQJYNvXJ8
         F12y8x0jDZcEBaDx12TJbEUXy1gWfHEyQ4narZsauW0nU1uiTzJ5KxHggDxSoclkmnCQ
         ZDnmLaJ5X1Dg5bYxuBJykfNdb+bFkWPVEEnfLwhpnrQD2NCc3wFzFug8mB88uh+oe2Hc
         6/UKm+rjmNiyIUCYBiZvbBEeNVYREnej3GX8KixNTFU1kdpzqmVbc6c3Y6FdY8O5ePbi
         Eclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748371391; x=1748976191;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWrKohcnIv85cbuc7n+x+VuRl8U7VNcTKUXVw5gcCyU=;
        b=ISJdd0ABN6baKClNwFewaR+5ZVuiBeKm+FDctL8vK5f7D2K6YzO1UQtBIBq4PGp8BX
         qwF+GdjvHvaJ4BAfiZcllE5LJZ+k3pw+48w9ll+EpFii0aF66vpACYkE+tIYbHRh+Emd
         hoxmtlGXakHw7fVCo6ad3UOnxqYdGYF4gCIjfro2wpZfgAUYifb0kEyBF+35/KXnxRD5
         q1VbvPFi5yCrtww/MmcbzX6k77yd3GLGnCnJuTAX9l+S6xfbY8HwSySvC9qHLXJEEQBY
         mepysc5nlzCR+k4wrhLJof4322U9RGtmrHlqqO7D/rXlfmREDuDqzV/JvjMTS5zFSlMJ
         sgiw==
X-Forwarded-Encrypted: i=1; AJvYcCVTX66SMqN3iL4JS1IaAeOoiYuZKHSoCpqfkM88z3xbjvbHByhJEHfUipAeaH+uKmh0RthH7gbvPzi3+4I=@vger.kernel.org, AJvYcCXNSQ6OluEfNYSMhXvW0oS8YpHg3iptz9ZkbQit7Jq67cktVT6bo9xpuSIziTEcxKTD6c1cC1ab@vger.kernel.org
X-Gm-Message-State: AOJu0YyJH0NyzuHgfs0+Am91V6vmcnLMdSXocPHv61VzxHbQ6rDPHgRC
	dIDE0+MSrOMIo2xwZUR1PEaCVf8jubIxcq8jdxJw2jDp46y9kKabPs0g
X-Gm-Gg: ASbGncuB79iG/Su2Z7+RU+lEgyd44+CNtkJ/SGG2rTmUCx13pORihpw1P1ZeW0UjKPj
	a1LnlFrg6UTVj1NpvnmftHXa9Ms9u7ZlYhR10JF1gnHibvyVd9UEm14u7vfEZHm9yU7HUVXFqfy
	DBbwgGkrVKO+jxcbIfNAy9Cilx+ZMCRY20L/cE3ltgzmSjNtuDlTy58uzsIXheUfzi0zJARasF6
	O9zIaMum4BvWgwvesRxrm/UDaW5TroQjozwG4Zv8COQWmSyGRn0y3THKZILIQ30tCItYwE0uSHb
	VFDV5MPobJEeVhYR+QtgsptaNmitQ40ENrS0/Z3ZdQOCLDij6PNAIP2KJLWyZ9pv5eddJGCeR7s
	lrww=
X-Google-Smtp-Source: AGHT+IHHLop+I3d2LLaRp2FvvBzEHmDqyuZgu12OgR8qf1sVE+wWQIcUtegupgCHhzscV46TJyW2NA==
X-Received: by 2002:a17:902:cf4c:b0:211:e812:3948 with SMTP id d9443c01a7336-23414e9fbdfmr214016845ad.0.1748371391025;
        Tue, 27 May 2025 11:43:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23411640a62sm64868345ad.200.2025.05.27.11.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 11:43:10 -0700 (PDT)
Message-ID: <dd48cfbe-ebbb-4e36-8df6-ad35f2b1c1fa@gmail.com>
Date: Tue, 27 May 2025 11:43:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/626] 6.12.31-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250527162445.028718347@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 09:18, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.31 release.
> There are 626 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.31-rc1.gz
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

