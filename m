Return-Path: <stable+bounces-87649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58D9A9374
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 00:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6360B224F1
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D4137750;
	Mon, 21 Oct 2024 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HL0JHm/H"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A050C1FEFAE
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 22:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729550171; cv=none; b=fIOa9M0GlK/XBhEL1QLnKpDqABFdCrzXH5E0L4iYCRUWD7axQKGmS25gGWIRe/sjAXcClD9pr2OuvCQ+OY64DntvhCYZWS9cKRTm6+jlnxlGZHoTb+bQI25ej4zT9u1anx7zqaDBhskB79yXFFRp7Pbr7itBgPVK1JIQBcLd+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729550171; c=relaxed/simple;
	bh=7ridXmxOHKWZoFTcCWYzOqNgAI+K4jvfNxUVNRtv7CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=art7/LyWlxVlzgHHgbV2WYHDNbdNDvsT0c4yJs8D+e4poP1J/tIklWt9dvkOTfateltLiifD2aH6a/iIk0EMUPzyPeBBqUNer4Uz9FlUjMAylXMzJEXS47u4rgNqHkc2uJi1K64v1kvmgS0YR8rQl3n2zBHWsaHcyRavlWmjZv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HL0JHm/H; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3bd422b52so17459585ab.0
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729550168; x=1730154968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1oI+BubvD3PxPJMfqOmKVBP9PushioezVB2K9owCDI=;
        b=HL0JHm/HtdsFs1dUe8r6aDCbz8NM1mYKzBLk++cX9nxVvNdOQ2owAsblhAMVSNzR7X
         X8RtrwZgRMQ6cLUV6DfOZSQmJzIuV6FzM8sdefjLrDwnCAyMgKvnKvtz2Jme+pJkv4SR
         PNRp4e38vxwONqtTlSsRFu/1lI7+X9KXMZUkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729550168; x=1730154968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1oI+BubvD3PxPJMfqOmKVBP9PushioezVB2K9owCDI=;
        b=JANFh6OZOpAJrdPrCTLXK7BxN97XUQdPdtB5gV+9nOwj+JIK2S7patisbSlpA0/vXs
         I5YDZbhQP02g0a/zPD1NQQxnPD4RKxjkduvrPkX9kyqqFNz238BCGn6KTogx/K7fPFpK
         aiXYncYG2VHFqx51kK+UsutW+E11OZdmim96Dgyp+v+TuamMribVOqClMA1r+Tgy2u9g
         rPULa7tL9VXkqcTFelqnGRRWbStN5mtwmxSzMWITDo0sLf0XJDHB2KHosC4AjaK2Sx9Y
         bogmgvFcUYP/4gCY7OMvcBtvfbGOvHvzzX/ZnxSV/0NaH5RsauNixn9NxgvZn8u1g6i+
         boRg==
X-Forwarded-Encrypted: i=1; AJvYcCVQTRp3kKxaOnYZ1LngC0dzHHPMT12tX0TTeGgPIayv/mMIPYBMYF/oysCRIH1NKP3Smc50epc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3fFuqvuMSXJCxHeGu/XjAlJRG+GhfLxPd1nGqrd29q5YX4fpU
	ifZPlmEnmxcvzX7o4N2GSN8AFYKam2UofJLimwTwy/tuF/3rYsGlqbLZPDYkSa0=
X-Google-Smtp-Source: AGHT+IHQbwFRjNv3mvRv4eYW87D6KlEthx3nm80SwdMIqSHvZkHg4K6C8J+Gc1bJjQZixmB4IFeUFg==
X-Received: by 2002:a05:6e02:1908:b0:3a0:b384:219b with SMTP id e9e14a558f8ab-3a4cd81a173mr4512455ab.26.1729550167696;
        Mon, 21 Oct 2024 15:36:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a63020asm1268461173.149.2024.10.21.15.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:36:07 -0700 (PDT)
Message-ID: <59996bfa-013d-4ade-954b-33974d86cbb9@linuxfoundation.org>
Date: Mon, 21 Oct 2024 16:36:06 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/91] 6.1.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241021102249.791942892@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241021102249.791942892@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/24 04:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.114 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

