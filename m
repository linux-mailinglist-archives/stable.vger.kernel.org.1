Return-Path: <stable+bounces-171841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D3B2CE4C
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 22:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60B97BBDC4
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA010343215;
	Tue, 19 Aug 2025 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftCAjsNj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2F3431F5;
	Tue, 19 Aug 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636687; cv=none; b=Ybf5e0uL8BDpBiULJmUjRQMGNmwWkZEFhV9o/Aa/f6/FR+LCbTNRdePo8HQSbLpFuBdcrLe0eYIVXXXDr3ehM/MwmjBTYqDSZiYzXjcqKCW+H/28EkWS9PQHsT0VSWH+TVT5bFYqPOru4Q30wsyjHR8ZGMkLtE2ulJgIth6DXqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636687; c=relaxed/simple;
	bh=w+I5h9FrVo6GJyf42svnrmSfu80vcabvipVnsOk01FE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7PiS94mLHyRb+WbuU5bChiGzvuQi9PS0ltB+4JPMYU8KUtegmdu9W1tn6cIv+rHy0tFHURJNNt/ZE12ums3KglcUQvPbKMzeEXdxlWDKRRa3R4zhjsCfsI1MRzlOHKs8V+did9L8eZW5lFzfBu8qFDFAC6OsC7BzOEuVyRyxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftCAjsNj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e629fc4so5868068b3a.0;
        Tue, 19 Aug 2025 13:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755636685; x=1756241485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtxagHbraCahR6FZkzV7pKn/fsOuCmexTQaCPXbwYIY=;
        b=ftCAjsNjfaZ5Eqqo+Cnq9zVuzxLh5+0kAm7VWFvMSWzOgTCem0DQPHlvCmdyvnMX3u
         WSOeCcpAsTGYUkr8smGWaEChxrtnCYVC67RplEZo4oGYvw5qRiQST99/VpBUI5S6AFuC
         WLIr4j1mfsLoA0p9W5lrH3osY09nRizao8H2Yxb/+En6csgmQYdWJfAsdVEtG+WdQZNr
         CbGsUVGJIeo3kWXuZmo2w4mU9T/GZxmRI/xKbsXADN4B8eVxXozwO2VlCtCoYelOArog
         kXzm2iPdJS0thQWhQQ3dsBUClxNtx2I/nO38dVict0m1OjkPzHMEPVdNjYsSm5Q11ufc
         kcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755636685; x=1756241485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtxagHbraCahR6FZkzV7pKn/fsOuCmexTQaCPXbwYIY=;
        b=qAHOcDBG0jsXSu1ye7Ww+3+fSLekzn7ejYT8fMgxHYUVhG2RxHexqzOqEAKV0ASPhz
         3ckzC0GWzxz/S1JFhy9eXMcmjjCLSp/ohVJq+6mo7zWXKJ8sm5kZBsnNNxeyuagac9ir
         dPhjJz9XhVDCOQELpkDkmx9XE+bPe1u5tc34D8zbt/WAPWHSw4sZmz+RglWk2n/E0W7d
         pxFe7CSI2AhUVTQyJCnbab+5tA9M/16PA/KbVmsjG+jKd4tL44J0xGq4+zymk7IoQojc
         tP6f2eLz7Ip5W5U5bw1tavA95vAwNAaJ44aDa+K9dPJSdczzNz2FH6tn84gZwMYTZ6CZ
         eqLg==
X-Forwarded-Encrypted: i=1; AJvYcCUeIYV4CXb4DkD98eembphA3EzY3QH1GBhdMykZuK5o9109HyMAR3sWs/tjAjvKxlgukjpNiPQ00+kqaMQ=@vger.kernel.org, AJvYcCW1B+dwqMfCNlCrjhaV0kbElaZXCEP0D4PAnV7KXKYrOApFwnMHrf14r3/YYM7F3LiSNLDMw4XB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4Vgl8vRsXazTAO5s7TUHJZrZmsF7ji8kW0JfmyJa3ZvkVyBd
	UfZ/FVp5Zwhtzy5yR6KgMv1btzNmaqN/gQc63YMH2B9lv6ibd29l/ILL
X-Gm-Gg: ASbGnct+8v5XobGO7q846u2A0yU+9sCW5wGZEzo4mYQkOsBZxOkEwZMlxfKwxPegf2s
	fxAbcDP8jqR+UasFxFoS+kIHhMWwp807BGldSKdIljjzrr91DPpH2KosGpjSWrsVu4UMb1lV2GI
	PMycL6Cs83MQlcikrRXu+RQYwFOM4Yx+cVeFnp9VNKEciTMEEq+dmJfPhYTCZGdefnPHIJdO+vl
	Y+aH9XDKi45KayGBFza64Ea+Q8VrH2/nhH0q2FgnO3ogxWim7yWXHRxT8kXmT+kVOYU53PnltRC
	3dttnZEjrcn9fxyRZqmHsNSyFtE4Q9CxL0q5a+bSlfiENXci/zNcS66ynaiqkWd68dc3zTdpaZR
	flQnzysA+Fbqh6jnWpcri4t0pvm1CCjN4pcn6zwKOXTgPFXqKs4mmxg8=
X-Google-Smtp-Source: AGHT+IFzMdg3jlRsNy0AGKdptqmbmqpbyojhjAFG8O2tXO1V/DLRxCVqRPUx2IOlzuQWkaFtgIG3Hw==
X-Received: by 2002:a05:6a00:21cd:b0:76b:f06f:3bdf with SMTP id d2e1a72fcca58-76e8dd0aac3mr791397b3a.17.1755636685549;
        Tue, 19 Aug 2025 13:51:25 -0700 (PDT)
Received: from [10.236.102.133] ([207.212.61.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdd6sm3411398b3a.29.2025.08.19.13.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 13:51:25 -0700 (PDT)
Message-ID: <c645aa7c-20cb-4619-b507-a6cb7b7d0d34@gmail.com>
Date: Tue, 19 Aug 2025 13:51:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250819122844.483737955@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250819122844.483737955@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/19/2025 5:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.2 release.
> There are 564 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <floria.fainelli@broadcom.com>
-- 
Florian


