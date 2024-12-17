Return-Path: <stable+bounces-105075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE19F59E7
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 23:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16201189189D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E231F8699;
	Tue, 17 Dec 2024 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XGyr2pMH"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6E1D9A63
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476318; cv=none; b=DHbmWBkHfUGAxP5hpDGvX+Uas5pBos2UBtXuqo3xtzwCFgkkwLSEqQtOI+RO8sQgsLBK7l5B8kpQ1HxOFS2jlz8mo8bpsyp6PTKs2WgdhpaYBv74mcsFOnypSx0Woo+n2BRQr+IzSnc8koV5tHsVbhOWjIC7OdKm8CnCSkCe/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476318; c=relaxed/simple;
	bh=ezNdIKG5fex1vz/PMbs67WqFA9e2zxQBEQ/jnlZRIWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnVoojesvBamgkfhhOJgpB4FBHarVKJTMV8p7NN3YwUCIU8DyiKCri+6GALwHDeTLqMdExoXqmOLOOqllbQ5OlGodT1CJTTRJrVtEAecOShYthYkJdh+tLnk7VAnt+fbVE/9KXkhTe8oJaxmENWI93AIlNahSiL9LEUjxXVrioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XGyr2pMH; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e61f3902so436323139f.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 14:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734476315; x=1735081115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHLDHmFEFp8u1VKVXZNoakOoMfbmaJWuqMVHMF4IENY=;
        b=XGyr2pMHKA0mJOIgd30/xpcuFIvOsYc4NOJMRebP2r5EvldfTVkkApbpM/1AajNxaz
         w3LKvGr+ttrd3xp9422YK1WA40nnILBVF8vpfIEr3BoVSvJy6CEqfgOdAg2BcDiGtQtq
         9DXT7sEOV1D804K3Kn8iYQSgwPwLRTNooOvgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734476315; x=1735081115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VHLDHmFEFp8u1VKVXZNoakOoMfbmaJWuqMVHMF4IENY=;
        b=eZAf/f5zLy81J2jA0/OKGWATjUqx2l5lZTzbX70gfx7PlZCuwXRlNNtuv+FX3rPctp
         qgPMm4xvIVEYQfs06TVWgUv1AmL2lC4zJAE589m2Tqt43Q7nOEMomtan++1ELfnm+uxx
         lpwhrcrEjZoDOsMJmRK7Z1NFNkhbPAg7BdqVrqJbOhTTinbnott37ev72EQXRfsSC7sY
         3AZTd1Mk/6xHv2JXTAmlxHX9Y+YPmSwD9mxnRF1K0BvMdCQkXj7cUiuoFUmJzwW9EKw/
         dYGr+uSYVwDHUwigeiA2SQHY4VmlW9vUXwTY/YdHIXTqPd+yINhb5HsCdCFgQkP41PDe
         Rodg==
X-Forwarded-Encrypted: i=1; AJvYcCU/hcbIxp2uzA5q0vXjhOzV8VzSqgPG+McGozEjNVvNqY5dqPClI/W1+5Ne2HjNtliQ0hrIaJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQknN1wh3dD8hefBFZ+HQLJBllnoU+rYujCeM3tSEOF58CE+4
	0nWymDN/kNl2nMk2o+TxfSsLLkX1FmAcvPXocx8e3If06jITzxy3m1nZ9l1S/EU=
X-Gm-Gg: ASbGncswjALMRyro8IIuFmvgXXPIo7NauI4crQtU4A8kPpdgDzGoFvkpBmxvnljxHRS
	QwWZeQZlnUHMhmWxxjpzGfH+kbzEbLoAojTdpFx9im70yUZ2O3SdXR6g+kwLz/sNoaee6o0kYWD
	gzdLX0BoUTqma4SyYMNTVUM3tmpiRB+gVL/IuT8tAnBu8r5ZUwhD0uvm6zXGgQ1SIFXaOtfDQlc
	zwrtvCRZFFvNyK/TqxbFQ+AsgmQ96tthN9JFszjmwdKb8izqhwpwkhNo3KaGIfqo+pl
X-Google-Smtp-Source: AGHT+IFv77BQQLGIXsZCeXEiuFTtdJydsCE5cUHiEZjwmk1jeQkDKOeTOJE9aoC1yqn4HWLR4XEXrg==
X-Received: by 2002:a05:6602:6c0a:b0:83d:e526:fde7 with SMTP id ca18e2360f4ac-847585086demr65850939f.6.1734476315338;
        Tue, 17 Dec 2024 14:58:35 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-844f626ad4asm198570939f.16.2024.12.17.14.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 14:58:34 -0800 (PST)
Message-ID: <02fc080e-467c-4f4f-b52e-b20ef722dbe6@linuxfoundation.org>
Date: Tue, 17 Dec 2024 15:58:33 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/172] 6.12.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 10:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.6 release.
> There are 172 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 19 Dec 2024 17:05:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

