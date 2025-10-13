Return-Path: <stable+bounces-185471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B725BD52F1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E763E18A582D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6C264A8D;
	Mon, 13 Oct 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOvdfm91"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3D42050
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374033; cv=none; b=e46eDI2kO1d0fV7B7pqsVHiEmDakO+29twHtSjn+BVAkW++mgpdkNmJOPpeSJ4YAi1l5UQQP4cFNLrT5nslsJtMDt3OgLnQmMhJp/f7inko+2AlOQdMTsHR9oT1NajU7L9aDPi4zxZz7tXtIcCA+d+lvRw1a7uHqwrp/GgpXXQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374033; c=relaxed/simple;
	bh=nysorLopTDqkbUL0tqqaEE1x9Ol5vXn2RSHBgnImewg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NblTOjXjTS7G6gjRSxPLaiaAhbYilOIDMUgjLmnPZwd/68GdBjBOrAxxIx3isNHRNMy/pA7BZw5QXbs1rCEku1LiQVzlvMjbijXbutostxKGZmICSTd20xFlO7UwqX5YgrhrsldFIARRn9ht3XongblvKjBVnT5jPq6TNazZO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOvdfm91; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-330b4739538so4196205a91.3
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760374031; x=1760978831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voyfMb5RRcwzl6imzXpESkU1fXWIq4jQYbcfjDP3qrI=;
        b=ZOvdfm91ZmAAbeVTYPxQ9XA3eaqUY3LYoqdydv5yaBMhHGFbaIYR3WnKsQG9tZKMeY
         1svukWkhnamC8tQENgkjhn9OxCw6A1vS8/POLockeWdGEJ0SWHQkce4vOliM0uwOkRxM
         VNdt25GwCgEojXNGJgr9c28Iba/KKrK8uXR3AFI9QacAGMvkj++iSzFt9BsldLQhuBfb
         +zyRYpaCxVFiANj0JcPCzkapbbke2PvQwsokMkXCTFsurgGLgAfcabY1au/69o6DPF4V
         X6ao1D9tqmmE0caKXYvRBGgLZ2tPWkBZK/s/CYShX2+wYK5oXYxgMgqCjgI7kWgi9GlR
         5siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374031; x=1760978831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voyfMb5RRcwzl6imzXpESkU1fXWIq4jQYbcfjDP3qrI=;
        b=hEgfcvs6HGOrDtPA/9aiaQVxtmRypNCdWrU1UEin6NosFIpSdDbqJ+EoeMzwDdlR4g
         SSNE/tJNLAJPAF61zqWNYSAntZ89ZQq3cxKzFcC1fJ0DHDDpkDBV9XaJMedoGyWuyXjM
         oIwsOlL3rfxrOd/e8GjydKOPjzj5cyavq2BJZvc/v1CpggZwBNx/DPubmVRSrO3UNZND
         GfCUb+Q+kL75vuNTAzsV/HSEQgbtUgfSujWef5oIFiLEh45Ogc3Lpx6wFhHIlW3Q1azc
         Q5YOBYEnz/F4gzsfe7O9uFE0fbgYWshfodovTwk4Zz8Tvn2nKC6EUAhS13htHpZZx5AE
         YCOw==
X-Forwarded-Encrypted: i=1; AJvYcCWWZS4K+qq5YOyYe6CGho5fdp0j2BlovjGoUZ9UdAnhnAY5QjjtRAzdwvLjA4UhzCNlG6GMQU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz40JVqO37tWLrg6tKLTxOQPmlGhhV1FL8jcdwea6snHbz5WAft
	/ccUofJ1CShSl6dqRuR+HktUqreL67wTD70HjQUGUXC3JCTyU07r8Yx+
X-Gm-Gg: ASbGncvDqgzjA8vDWBh/EzNZC6EYee+h9pJxmKnQofc5eEYfchh6JTOyl4jcozszbnF
	/Y8ZUsDy6l8VuOa3dttTiQ5xLOXB3tG+8W/H6s0LRrXwpPmUEed1ZKICgZdHaLUZCc/Fa0Dzmc8
	0IfITu9yMbu9XNP35T5YFZfcIXWp6ham2Jawjan6ZxSESO+zn8XJZCJb3axRXiqzWYV9MNJKy00
	RUxnMyY17ldHTYyOphXEVxaJf02eRLGprfoTlMB+OWtqJ+ATEbGpRaTW9X8VZd4VQXnNOEVe7Ci
	NYwKt7ZniGDBLwA/F/LuikQPvgEvbstol4yfZk8rwrM2J8r4tlZxCWQDq7rAHaTS19swUxtCR15
	VUvExoxUc40s6qF6IIh2DLwXofgKSkBjDg6unqach89WLRRAYoeh1VkD0dmyvoZHD6k1gge0VgO
	2jHS0=
X-Google-Smtp-Source: AGHT+IG1Ysy5KBOTuH75LYJyCJhrc7Jg42bTix5dwVq4VuJYEECGxkpdofnArrrEtSYwS+l9+qhUwg==
X-Received: by 2002:a17:90b:1b41:b0:330:82b1:ef76 with SMTP id 98e67ed59e1d1-33b513d08e3mr27148095a91.28.1760374031086;
        Mon, 13 Oct 2025 09:47:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3dbsm13073884a91.4.2025.10.13.09.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:47:10 -0700 (PDT)
Message-ID: <5f1ac6fe-5b28-43f5-b143-dbece62505d2@gmail.com>
Date: Mon, 13 Oct 2025 09:47:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/196] 6.6.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144315.184275491@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/13/25 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.112 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Oct 2025 14:42:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.112-rc1.gz
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

