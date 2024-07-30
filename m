Return-Path: <stable+bounces-64680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D24942323
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 00:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B28A1F2349C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 22:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC26145A11;
	Tue, 30 Jul 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdr9Zwjl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD3618CC1E;
	Tue, 30 Jul 2024 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380075; cv=none; b=NftgLhGixRvk2rSFoEdX95OMtKn+oVqnPOHZbPEBdkwp5kDq6NTGLmIb+fZgMVtfClb4WpTQH+a9l3pcnIWyD1YqbEuw7VpJA6C0dFZV7l5WOTmn16Mz7GSv775ACW3dPEc1RCOZjU9VmtP8QpmmVZe7wI9ebRorat0Qi7KZ0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380075; c=relaxed/simple;
	bh=dwwEUbUzgWL5vS5biiRn9oO1+11MCQQo5aKWpvA6bqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ge20kKwYmAKWV7m5cMBJqaJU738i/Q8U2nl9qBoe4SAML3ST2vAvFIO9CR9/Wf5wCIIJK1Mto+E767IsUkACUXBnAM8Jgqevqsds5IBasYK+Oc2wC3jydk9XHBxZJCvV13ZtnKmhNBAr+tk4/zoNG0MW2p1ftxyVplUbw8517gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hdr9Zwjl; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b5f46191b5so27499356d6.3;
        Tue, 30 Jul 2024 15:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722380072; x=1722984872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tG4ibj1e6Js89Q0K69BYaWj3uwGB1GC2b5DG+Nb0V8=;
        b=Hdr9ZwjliSL6cJ2hErZwTtS0u7HzD4uhahUX0CXL4av1IAiNrZSwT376bjJ/oNqH8z
         J3Ufq8pP2jM9Tve+Sf+lUlNRFN0k+Bz+loUPw3A9p4xjq9kOVqbD3vas0KX0taz7GgJQ
         L/Y9ca8hGgG0JqYGUcdvUyyhK59/i1vZrZ8UYd11rNN8Mp2khS4o9lqVLSX+dSVRSHp/
         Y0mJYSivt9hCXj4YAC3hiZVnZ5HgZcOuuS7EgakqwzApJhRXuu+TaGzLjpJvbgRhN9zB
         PrUi/4BFC0zvJP5ySzXz2lyXq6rJ7tVeN4vq+IO3zfzwPCUgsrcxzMQmr33EH7zU05P6
         Rfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380072; x=1722984872;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tG4ibj1e6Js89Q0K69BYaWj3uwGB1GC2b5DG+Nb0V8=;
        b=xQ+MfL4Lyn1sNRq36rkGoFNs0HGCFZYn+F60s8GXZXpD81PTs/dDFupFlLgFVvQhtt
         DiijyCJd7vKD6hOWHi9BaXYANjdWgvw3CaqGUEj8UD4xsgph3xYZq0O4cyxNI7nQik+I
         j3H9JUcxOltqmn7AhbrYazZ7bDjbIurT27+9nMnt7M5yvmpCu7M3xyNmkLa/l60S8l8l
         eqEJ0vBqpYq5Z56PwEkHMVNl9bNmB2FXv1yaA47KqBN7QF4XNazJP9y11keH6e+IMQis
         pkZnRRio8f7oFyy2ZvQYE/Dx6MQGKOtdOjFYkQtz19zFy58n3XDpZiA5TOlH3VSx/zWT
         KmFA==
X-Forwarded-Encrypted: i=1; AJvYcCWGiClL6yejmTQTBafj8ax2KXRpIe9c+MXBvNbz+0QI87f3QkeCqtYKIKJ92TjmcMmBMpYuryZ0B5TR3s8aA0dV7fMx0DJrm0tGr7cpOIuU2ABhKPPDl6JpL3T+ddlIkZQJeI/n
X-Gm-Message-State: AOJu0YzHRt4C5cbVTTDfAUh7G8SfAKCIPhRTtC30yZ+cthZabIGHpSXJ
	M8rqFC4c3Ucyne1x80XHNOBnlHmpVCcLDJmcCH0zWD76inFPknP5
X-Google-Smtp-Source: AGHT+IFGRAi4mVeDyJj/FKJYt1axQZPWTQGevsa8iIP75abxnaROHuKfpSs+p+ytCVHUtGmDutX88g==
X-Received: by 2002:a05:6214:1307:b0:6b0:789f:9ce2 with SMTP id 6a1803df08f44-6bb5599f07fmr176892356d6.2.1722380072396;
        Tue, 30 Jul 2024 15:54:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bb3fa94e70sm67155976d6.83.2024.07.30.15.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:54:31 -0700 (PDT)
Message-ID: <10b0a584-e07d-4fb9-99a4-6359563c1e47@gmail.com>
Date: Tue, 30 Jul 2024 15:54:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/568] 6.6.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240730151639.792277039@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.44 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.44-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


