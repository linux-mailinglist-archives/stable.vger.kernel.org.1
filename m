Return-Path: <stable+bounces-169296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45817B23ACE
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 23:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ED01AA4819
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F402D47EB;
	Tue, 12 Aug 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjUKFvqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381472F0661;
	Tue, 12 Aug 2025 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034736; cv=none; b=YboNSgMNLOrHcGKzwynYx0yrnsQQmDpDRx2wWIRFw6L3bxLKTYCmiRdzLiIUsSMJsRG/YlZnUxa+CswTIXD+JXfIUWQ3IGCzlwiQcuIjM2zM0z2iy7TpmlnZ4Szn/6MgoWJ+ATVSbJDHb4nzHZeZ30GXQ5E9FOe+2qcqfXXm1cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034736; c=relaxed/simple;
	bh=axiH4a3QJQrYWUfX19Djcue+yx0b1xai/MtOzqIXfxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkmm0N3ntsv89LygV3bS1EL135IwX2dNE5aRJuJDpJAYwo5EmrElFn0b/B7sX6EWXM1d+kO3JIvHNArjrlQZp9RmjeDJrUPPfBswr+k/4sCL/K5yy1HxMaT4zIeY8MwsDWGCywyPrlihQ5shlmxcK+zYjxP8qIwxG768TwPpOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjUKFvqA; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2eb5cbe41e1so6328553fac.0;
        Tue, 12 Aug 2025 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755034734; x=1755639534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJal0HDcOW5BIJClCSpK9SqQz87Zh1sXeHnZhQzPs10=;
        b=fjUKFvqAEcKxlzqR6WdmjZG9dfLdxDvsxsdLxqVUjNOi8AONScGiIjcpb22JKQLCo2
         gvy6DJLSLNBD0/TaHQJSo8amamxw5I0LPFCYpaP4Y5BKUM56CWtFmBK6nbXoxXIUzHLo
         xvsmb0QrascKGCD3mvXFzkFyAlrZl0SOx44TnNOS+WVjiWx+vVVLpM5m6G8IgLcEVqIs
         M2znxBnXIHMtA1yMvabNWEWvhCiLcxD/g+h7T+L6gokCPHOrk/UkdedyJRwl8DB9tFRq
         wAIwsB7bgK5VMqyjXRqTvS5qr1jOTeafjaRygvsunYTbtKE3Aqcg8ytnRTO62Ml2YtY6
         lp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755034734; x=1755639534;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJal0HDcOW5BIJClCSpK9SqQz87Zh1sXeHnZhQzPs10=;
        b=HrFS3prjXjG//A6MFPSATla3jqsGfbZoD1zj1cTw27rGwbCNwz34HnggWkrj0g0l5/
         PKs2Zj2mUYL76raTu3yq43l4uHh5f+pn3HhpgGBKkedqOKNq47nkcdsz+Ac4Jc0GRT4h
         63BJcHc4zmesYKLXc+WXHnUmuaPCe7rhSqCJakLdnCGPkxf0M/m3lxzxu+loW3WGFyZe
         GJJVwj7dBhDKdb9mH7LWNCJeO6fT0n0CuKKUIbmcjwTIy86Jrtk1W3wQjzJwTPeqRRI/
         aTaNM4gPsbg1VwDJ9wyVqrbrOdwBBVOYp2vB3cO0knJsPR6oeloud69v/bsRdBQWRMLi
         Rriw==
X-Forwarded-Encrypted: i=1; AJvYcCUZQ9horOb1DTTMsmWY05zzaYjdbE4tdI7fljqfHWmO1wE2g/60x1UKyENuvsaR3ash2bWVg72MkBNybmU=@vger.kernel.org, AJvYcCX2hn/GMlS7lGGlfHxLpVGaMnQQTRZYnoOvH39LH0tygoqcjIgut30Qw+cK0rvWk72ykd06KgXx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc53oB6JeWTsN8Vfk2uJSbo5EDb3Z9zmyCBY+OTobRhJsRij+/
	qEoyZ96ea4mfcUcyjKjhnB/1il7X0CNY/eaHE2NZ97rw9AilsokJs2wM
X-Gm-Gg: ASbGncsL4+IqNQHPu/5UGoRrehKv1BOzdeX/cL9C054qJVdUJEhFH7ydKh0lGtS4/2l
	TaB5glDSQvdfrn10/KPTt5M6jB9IxNWanxV6/p22HMNo9alXuJCSnqHnIk3imsPxKiAFcQTyQmq
	o14mvF6LwmnBuwW+vZZJDItYT0qQ/SeS/SFeCFdnaRZDEuQwMYyqFCLF42nyPWCiRX1tHo/DPzs
	IW2xWkilIoPIvYiT3ZWoNJBDCwJ7Z4wYojUYKr5sHbsnzgoW3G1/4wB6nKXdthUcfykbVVLlHf8
	zfb49EsH+fcr8yEgm+twgVJXzIVQS8jrwL1Y96XHZ9UHZNayPXrJFl+DfvYRSLGBqkT+nFybUiH
	L5nfqLoBqqv0aHsmVJu0eoOJ9b7+IBtS01iM0+zb50ykuLf3krx+5maE=
X-Google-Smtp-Source: AGHT+IFl2Y79ozRu1ULZq6ZoNCGOMk+NLdBFPuMjL831oBJp6MM/dM0bPqYtOM4m4GbvYYJh+hxX/w==
X-Received: by 2002:a05:6870:a408:b0:2c7:6ad3:fe56 with SMTP id 586e51a60fabf-30cb5ae8711mr504002fac.15.1755034734291;
        Tue, 12 Aug 2025 14:38:54 -0700 (PDT)
Received: from [10.236.102.133] ([108.147.189.97])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7436f87a22fsm465486a34.16.2025.08.12.14.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 14:38:53 -0700 (PDT)
Message-ID: <c33f7e60-9754-4cc2-82e0-e056313365f0@gmail.com>
Date: Tue, 12 Aug 2025 14:38:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/369] 6.12.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250812173014.736537091@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 10:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.42 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.42-rc1.gz
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


