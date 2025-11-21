Return-Path: <stable+bounces-196556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A2C7B4FA
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E41C3A19EE
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4951E8320;
	Fri, 21 Nov 2025 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcgU2sRc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB821579F
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749330; cv=none; b=eoZQssDk2z8GMpoIJhSH49RvXbh/+8zjfmZJgJ+iDOPe/VrZpPR+kTQMgH9EXDP231axfY7CMTL6LK1/ixWutOkXH/RSetQR9BsEm8ICE5QPp8n0AMTlE0UWc1Lw8YDfrPTdX/XVHZLcXb3PI/kjWCSBpkQ36Nag6ha5zkXQicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749330; c=relaxed/simple;
	bh=fKLWeU+mvv+lELFB7zRAfgFbuyBdL30rpqdulQlpDpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nC0ms+D/T0i2gBPh7wyQH7giQmMrq4LGlF2Ul71ulRta50jriGUT0ITpfKFvM4BVeDLB324WCxYGvUccQbXjIyD8IyD1TYN8f+IfZCWKxS7oSJId+jpgfHgfb747YOidDoXRDCFhgWVL9tdoDlDrpHx1k6pwW9f/zu/1oKqKCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcgU2sRc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297e264528aso27152835ad.2
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763749328; x=1764354128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ilgbmsIJ1j0KJltWHFpHfevy610h2K+d7d+0zN3F/9M=;
        b=AcgU2sRcQDjzCuX2ESFWauZiXtX1bMZQWiskdjIi6fTJQcFmckOyD22zH+2u5RVijx
         F9/zlCKFiQ0Mk53tbY6L3f2Fv/OZIJ9pbNVoIKop4VIdtGjHwxmbLwGFXdS6XHVwFrTR
         BeArORKHtNihYIBh/z8MfPAOisETeqCUpZP6t+pHdkBvBm9cDyDeH3pUO2gFsMABlWit
         Xmwup2T9jgZcv6pLR1oMIPpSy+7tsmYyYBx0Si6G82cIAN8pFzPjuOEbz9t01s5GkuGc
         aSQUpkMWvVaohFOR0MexblzvDFI+6ff95eAhZlTFvkLeSLFGFIzqitUqnPf+sdpHRAR4
         6COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763749328; x=1764354128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilgbmsIJ1j0KJltWHFpHfevy610h2K+d7d+0zN3F/9M=;
        b=kNQX7w2uAPol9bpcW/VFDb+AaqfNeLBWuIDaJqkpeprW9a6X9bl9T7Ev3d0Br7sQu0
         pcNruVnI82Dl/mID7t5bBl1jQ4qdK+gUmfG/7XhUjSNieCwjSpCs2vau5yupfyxp+LV3
         +zMpHB7FYOCWKnQHVLApBn7bZ8DElsbVLsFX2Wow1vKrvJP36hKWo030Agn7BxPP0ZZT
         +1pRmUbjPVv5eFmOeHzPSwWBJZ89GI+iJnoO1EK2Rklctz38FEVha+yFmQL1d3jLbyPv
         SXEKI7HzAGLlJu8+6k5OpEVlcqljC91KVGmPV4bMa1LdLDO++aXXENTQ7WEGkUkeVJEn
         SYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMpuuay1J4bbbLT19f1JKSAzUmSiEAvx0E8Wk4Q17xj2v5RyEykkTCZqUe9JLJfAVZKZhfZvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCTBLnBUuD56NuEZS551mq8JqfVKJpvO6PygCzBvwOmuMHwfOw
	DM8u2Xr225isgtONjyTjDO8h4SWOFDaJWjo1AJSu3CcbU7dJkOYlQbYk
X-Gm-Gg: ASbGnctAZFzs3+qWHgEygSRE2jmtUEgB8EDuejk55hvRKlkoCUgdQeSfAcLsz3Qv/di
	95PkkhSeAiFTovj13sGwqj06kqWuwMTBG7BQAKlS2pHfX4soUMhTNjJ5lzYDvEY3TZ6i2bIgwYb
	f4NpMB/WTvirXAZvKvG9CcknbWgHCLZBGOKPNGMHxFt7Wb9CH7dzXdVd0SNU+kH8TshIDEeEp5x
	diWqlfIg2Fd1NHbpkShPNATl8oIjckqVc84+jTk/8lyynpTw0OnG+yKA6eetoJ7N75su9oN4oVT
	MFeCbiAZQIS5qpXr4ESWT/CgckQQ9kyZkYOmio2LiE+Qe7zWuTXeU6Ig+kR0jgTvJqLI4gUwWzi
	6rNAheSM8o+RA6Tk/txaWSD07bSAwR/8GuwxzW6pEcomq6j5MC1EV6ijLQ6b+yihU/WGPb8V8xY
	g0PrRC431qZRcendphPqJvHNksGk3O4oL1Xc+dXw==
X-Google-Smtp-Source: AGHT+IH8hbBlzvqYRFzIPKqJyiL2DbZcQ1P0RcoVriGzy64BNuTiJSmpQhVZ+EIjGJFvqS32RaZ2zQ==
X-Received: by 2002:a17:902:d583:b0:295:4d24:31bd with SMTP id d9443c01a7336-29b6bebe2eamr42752635ad.17.1763749328420;
        Fri, 21 Nov 2025 10:22:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b107ee9sm62524545ad.1.2025.11.21.10.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 10:22:07 -0800 (PST)
Message-ID: <4a3f450f-cf7a-4c5f-861c-10d15b9e6733@gmail.com>
Date: Fri, 21 Nov 2025 10:22:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/185] 6.12.59-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251121130143.857798067@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/25 05:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.59 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Nov 2025 13:01:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.59-rc1.gz
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

