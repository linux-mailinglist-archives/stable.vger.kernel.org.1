Return-Path: <stable+bounces-118471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 558B5A3E047
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2C3700865
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B8204840;
	Thu, 20 Feb 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YoBjlBES"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E120C038
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068076; cv=none; b=qBPY5++29O7Cg20MnFU9/+eirOA5wGfVRpK2+Y5bt7lTzz3GnjewmSymQpSyd40EpkVQx8wM3ff7KyLU1jE0s7HeP57w4Z0kha2Qe9n6hbKdz9OF/Wc0Ffgg1e1DgMXVjdfBhaYjRyf7KuTMvW9fG2Ofp67MWwgl76zLvg5v2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068076; c=relaxed/simple;
	bh=AeWS/JuF83zRBQJJyVjU8mcMgJejFBEFiJlmItfKqc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2jH929mrn1lS9s/FGnv6o8Ll5DpPdHRcXlWLWk1UF9boz07oO6lHlC5S9WO5fBmh13boIkBMhHGIorTln7wZpZcOiidw/cJl6IheFBKsXLJYtICSavFrjNEZeyI83gysodNy9ub5AXmRveNDzWR66crH5gCuTP/QXUJotZL0Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YoBjlBES; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3cfcf8b7455so8818835ab.3
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 08:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740068073; x=1740672873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dI0srPPOo8S7V8Myr7HFucm2ZHT05UfWeqQYkZ5WTeA=;
        b=YoBjlBES3t8sv300i2HKEc3yz6xLTDFFTCf/O1Aq7cXIKE0yA+pkCjQPfDx+AGK/PU
         2m0RsW8Qe5Uus/+ElSqix6DI5oLuhqmMugi/TZAwixO1MZaxLS5BQu2865PWhig5UkhN
         H6YBlRBRpOC9HhfjkvMKNc35YO6DDehl9ZqNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740068073; x=1740672873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dI0srPPOo8S7V8Myr7HFucm2ZHT05UfWeqQYkZ5WTeA=;
        b=xI78tf3Q/xyn7zi8FsttXeYWp1unM+zbN4vBsZKwo/iw6Gy+K8XbG6IAV1VWIQfrMT
         mB/xmigjtEbP8eEUSTIHlf6ze8pWE/wEaP04G/EnLNqE0OFby5+pTPtl/9YUif8RLz8K
         71JrOO7p8tNe2K6SQbM9jV48gTlluQgahSWkr7KZD2Ce1L/B37BNDLWMjQ6RZW1lnMY4
         0wtoOxSukT2RmJsfPqchpKaJJTAnlpZKmv2Eh0WEnj183F1t4p+ygDwnNmD0dhlqtO3Y
         O/7eGB74qkQqTWbVg/x2ppcz+Zm5b+Uv2S6YdsWwJ2IOIOe8NFY3VeWKSgYSyF8Xw+zX
         yOoA==
X-Forwarded-Encrypted: i=1; AJvYcCUi+22ZM/6qMyG72LcxQg6xKqT4UNZSxBnH4C1L9ozJK76Wm8kHJuAyPREOH9HJADmX5TQZh00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3KG609UtZVKoI1B53dtGgDNy7vVPIvVHmK/3xD6XTPl0CvBW
	40IcSkjXgAQkXBAjVNyC0JGNFTcBWDhw0T/qjDQbYdSXsqSSwTU+Xlje9trVn9s=
X-Gm-Gg: ASbGnct28TCkLGMrN6DluJTO5EmNrBScXAyPR974tM1L66fP5jHFLmh3/oW94Mp6OFu
	w1iPfTDg5/zmMSNUPenapAqB7idvAcMjjPIJHbmAhZt7/Q3IUSwG0ieOVLsfJZZnBT3iDIGp/s1
	Sa9vh1D00oAal6fbojUkoddeBnJJdOQvut+KGL37R9UwBfEW3mHplP/CS5KOzyy/B7VY3zRxggW
	/BENlryHdlH4ur5VGy5hMA4Iap3lR81WpLnLwToZrxg0xkFRgTRv22nqjzws8qJFSGWjuVQ/pdI
	uG13uSfcoQ9oZCcwmL+RMs1lxA==
X-Google-Smtp-Source: AGHT+IERvZlWYEeZFxmoldq5ZudEzhNy4QwhwxU996FqfPDpmWgYU6X1zjIzJ5iE23uPC5Ep8G8I/w==
X-Received: by 2002:a05:6e02:3285:b0:3d2:b509:af44 with SMTP id e9e14a558f8ab-3d2b52bcc85mr108180595ab.8.1740068073182;
        Thu, 20 Feb 2025 08:14:33 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ee8d3b29a2sm2449370173.8.2025.02.20.08.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 08:14:32 -0800 (PST)
Message-ID: <a60c071b-f30a-4d93-83c9-d056e7130b68@linuxfoundation.org>
Date: Thu, 20 Feb 2025 09:14:31 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/152] 6.6.79-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250219082550.014812078@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 01:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.79 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.79-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


