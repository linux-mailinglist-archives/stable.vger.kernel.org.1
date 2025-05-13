Return-Path: <stable+bounces-144207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FE2AB5B6C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8369B1B4468A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F562BE7CA;
	Tue, 13 May 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q4SGPOlG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0D64D
	for <stable@vger.kernel.org>; Tue, 13 May 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157649; cv=none; b=NGEVJnNpVsms5XA2W4NWiyRVH8iUmwXHwzxhiIAaBXVtU8PNCfILZAhuTYKNqdEhuLfWhMmASeVEPOj5xFHdwSjX2I4NdIbDctHOnrISs/nFR8ZLVo1uU8AZ5S8p8OeMHhwv6PGhWuUsyjSRdQzRiPxvMmu38oOTYK8qyk+CH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157649; c=relaxed/simple;
	bh=ORgTGq0r7wJyiDFtwXEgoHBuy3lcDA/b8RLDPsQ9cJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzY1dEvZ1913KPgpvPUBxxU9Em+p57kh9G6zecDFTcRCMRiU8D1XztAkEbvmJGml+UiX45yMkKpz3d/fGYmNilpy+PJqdotVlNeYT/0DqHq48tRDRjv7h2aFUNc2xvEwwSzxTIHR2DldUsq4QPVVxTRVAV2k+ssaeJxNSRz1KBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q4SGPOlG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6f54036c4b9so59644726d6.1
        for <stable@vger.kernel.org>; Tue, 13 May 2025 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747157646; x=1747762446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yHcz6mMYEIJbmi3MxPPcq/Bqop867905UG+HusUSuA=;
        b=Q4SGPOlGmaFLR5N0nLVwdhkX5EiH9Ohde38uQJWaQp69xAXKViPsAegHT0ZKVARlDk
         cd2tAhMaeMP2jJgyIzeBuDD8jWlNiGJpUB886JmIAdPAVIgmr4H7W6z19Er0glbndU2p
         a29y19CkU5Kyg8za4Su1AqgBXE7jITYNTpeO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157646; x=1747762446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yHcz6mMYEIJbmi3MxPPcq/Bqop867905UG+HusUSuA=;
        b=HcK5EOsujV1vPX/PKDhm6nYSzPR23i24mMkoMqwwbfw79LPEGXOXxrmKl965f0NvxQ
         GhEQR5uHxi30hTTud+c5ps2G3GSwvojjiCkChbHhsAew7U3ba0UEw8Ju5y30sO6mKgNJ
         ytI+VpXvk6LKWP+rSG4MfzScSvBvXYiz8gmNJzsW45OVB1x1jkHQNYRrYAtImYvA2t9x
         H8h9KedHW9Rnwz3NzsTKtrS7gzvpLYRaB5y3G7vvaAwQXtYM+tJTEgbRjsVNOmbGuoEp
         nbS9l2Bw5QUzyI+xcVnXI5z/D6FzYwl29TlX3YIgQ/qnBsrkJ4vPU+wIhNihIo+pr2iI
         x5bA==
X-Forwarded-Encrypted: i=1; AJvYcCXGnQzuQ4JbrljyLpQ0IImhX+FB6Nt1U0pO2EqxfUop6yLRywPElWxMi1zH6L2PX5F/9c//bSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ0BCp8cAXmk+3tmAYXIbzmLBoKF9nwj/hF+A0hpqaDdqNuIBu
	VuANl0CsGbAc7raXRZNe1BoG5vpdDo09Ol/lbUkFbozYDCErorltcNDf4QnHZGdFqi3vd4hfc+X
	n
X-Gm-Gg: ASbGncvXbS2RntNnT29ylmhI+sBuK9gk3HkLSp99wZ9shV9MQFOIKPVHfaeJrFZgJN+
	dd6fk3Dc2d4VQa+fWqvf7ZHIIjgwHot++TMzqxXIosS5h28Qs2nw2NvVoQEnPTvazTic63nEd0R
	D+oGQ7yJmPf0ewYri3bwQ7pzB3srixhFyFY+6HMlUl3hEngw+PnMxEXcwpi4qZxhhHPwPa7vC5s
	RckrVOzVMEVdtIPz5wLAOtF/pZHsgtVBpfvn6Jk952y7VCayZe2v27TpQPnyxD2hlx8Sb4xzBX6
	TM6+/KippOpvEmQn1KwF6htm3gP0dFAZQXqWl8kgGAon6VWLqkJG/eNzkDJJSg==
X-Google-Smtp-Source: AGHT+IHnUVXnn/cpedUFGgvCl0xpvLpgIL/c/z6hDeUnR2wDQyCd57P1RCSfX1X7sblLh0kPIHFq+A==
X-Received: by 2002:a05:6e02:1887:b0:3d6:d145:2ffb with SMTP id e9e14a558f8ab-3db6f80b0c0mr5126025ab.21.1747157635105;
        Tue, 13 May 2025 10:33:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa22658dd0sm2157241173.114.2025.05.13.10.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 10:33:54 -0700 (PDT)
Message-ID: <08f7e5bc-1a20-45ed-9334-3c2f90504b83@linuxfoundation.org>
Date: Tue, 13 May 2025 11:33:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/54] 5.15.183-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250512172015.643809034@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250512172015.643809034@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/25 11:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.183 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.183-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

