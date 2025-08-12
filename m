Return-Path: <stable+bounces-169298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E27B23B5B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 23:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C756F189BB9A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9152D8DA9;
	Tue, 12 Aug 2025 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic0YmG81"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB1270EBA;
	Tue, 12 Aug 2025 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755035782; cv=none; b=cJbja+dDMs2pOb2Y13CcW2BDVrhFJObDlaJL1c3ukdWKz6RwN+V2z6urSmnEVaRNLWb6XiA3O7R8i7gRk+MAcWziQ/1mo2ww6S9MpGMvl4qkFzGSQntjv2LQ5THGFGcuTsReVOtfOohYpxkspb7VF6rhdY6Y3Ffc/l0fc46uiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755035782; c=relaxed/simple;
	bh=npFsQ/2FJpoQ5YfyMz0bgUYAIYUyvj+q2Q8QbTUvYMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1hnkA0YgSUUR/oN0UaRGROmLa5+6TfAbnI1BUUyjYAmGJnPNSXD08dG5qJaTjTpRE9J5IGHhqlosEu8SZDJuJtFgZLNxNoXJYuTTBo9DGRfIS/ePH8tPMgGTz9oRt7Zy76FExzdYy3igdJOejEfk89f1ESgifjQlfkjYZHFDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic0YmG81; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4358a73e7efso193606b6e.1;
        Tue, 12 Aug 2025 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755035779; x=1755640579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OYO28Q4WMutLsFiJxtUOsDf8GVDoThxADMjckiwEJo=;
        b=ic0YmG81oO1BGc6Zf8Ga0rw4KCYLXY2ydhsDBvrQrwtejIkKCgVCGLWJmr1erI0b2b
         9ycIlANXGGRL+JHezjpwPz/vYr4Bfrw2U322QM50oH7ZcoIpb/xD1luzavifnPUZvjfO
         HISlsVv1HacDWNOLFfqUkZEqZIi7NgS8dt43NM0qCLW62mmW9Ho/UWXkrZnS6iGE2sjf
         1d/JlVw1Bvx+cLIkDrPitbJiLlpxJNr7I90FXmgsl/toz1kCk6NBBqr6CHQW99zrFfI8
         06/H3fZi3vxO2+ZdrhOkCrjKg5CPCrfsqIikjVkRcsBgjK2LKxFPdIFriAK9SkxYdLrN
         zh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755035779; x=1755640579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OYO28Q4WMutLsFiJxtUOsDf8GVDoThxADMjckiwEJo=;
        b=Dj2ZTMmEc+ivEXnDsIlIllMpdJCKiU6mj+nt5Ra7FPNIRCOe0xZ9Kui7nAT0mM+gOH
         hxAJ1Y3UvaYuD2K0Tf5miq7ajTj8GHXKg5uzpAFEQgw0IVCSv4pIh91T3AyqRlj+F2M/
         CMjkshpC4gzKPp8GivP5DVPvR556dGV6NR6VGHuS53Y7pWFoWrzo5TFOW13+flm8BbAp
         +dzvmUZriQeTmKMKax6IWXEegorgVuOysNR9TFlYwG9GB+N4ex3e+3UeUW6NYxmB3SJ6
         M+ajWG92poavZmGhR8wiISNMR6zvdRonC4R4mCZRxjsa88/FHX3YMtVqzMZLOdIGo/z2
         iYqg==
X-Forwarded-Encrypted: i=1; AJvYcCV/8Uide3cZGw8w0uKJgED8bgBOHs/R9zU390HJcnI7X2P2NeEhzbiwlYUVj9L3MzAa8dgOodKs@vger.kernel.org, AJvYcCVZ8KDls+KcXvc5K/KDjzxyffsGQ+58qLQcuKmvMqDwhSfMpTYU3mQm6T1iIiAE5nXDeWaRhtXCkhQO4ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyihl1Wm2pf8M7TCvmxnlMOcbZL4zsz79rcd9cp+D7BhFX5BSS4
	3YcvHTRsnxXjIrr5f7f0o/L+ZFrGdK0mmhTvK142gYUY7Ledy+KJs6uh
X-Gm-Gg: ASbGncv/a+A4/uc52yLQi0KRWZFmcAhAzj4qpHCc4R+tFDMTNfbqW07adrG+VFlXFl6
	pOhsUsPjeQcHxCZYCqRWpcjK4aNZDqxeu3lrfM5eJnL2hbdZ/0uznXoxuRL+lgIyxPTglND2Hxi
	VZ8o+YBz6iQWL4HGwdQcwu0dGq9Y3HloX7qw3D88aJ+FkthFYFCB39VQFQJJh1uVw0F+zf7LL9J
	2Zx/PagAG8Phyv6sz9R48F8cFaqgxnZQyBT5dALpuaGbuB4epAxmmViKwTU94jcW/P7sEK/cKBJ
	DiV3lJLZWi8Bpt56n0wqmhjPzk4Ot2g6Zl6TQVYRYdehjeSpakv0eEVv8RDC9vawWX+b/e58oft
	SynZuMlsxcZGuWIAL5BeLLRijsiIXsonY/Coc5ia9fXcl
X-Google-Smtp-Source: AGHT+IGlTPoVcbuI5YWA0De0mG2ElR/KMShadFbH1lF8C1lKnqHY0jyfGCWMsF17lWgYMOI9sjyPWA==
X-Received: by 2002:a05:6808:4481:b0:414:31e6:f6f1 with SMTP id 5614622812f47-435d640b476mr96195b6e.17.1755035778959;
        Tue, 12 Aug 2025 14:56:18 -0700 (PDT)
Received: from [10.236.102.133] ([108.147.189.97])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce895fd2sm371460b6e.29.2025.08.12.14.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 14:56:18 -0700 (PDT)
Message-ID: <ae04fb61-23d0-4d6b-9ba2-8473f8499272@gmail.com>
Date: Tue, 12 Aug 2025 14:56:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250812173419.303046420@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/12/2025 10:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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


