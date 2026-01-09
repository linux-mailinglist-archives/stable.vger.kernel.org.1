Return-Path: <stable+bounces-207908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6254D0C113
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 20:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A05AB300350C
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 19:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0DF2F0C7F;
	Fri,  9 Jan 2026 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA250pBl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071CE2E9749
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986797; cv=none; b=s9q6fEyFim55spXFMvM1dl4nyE3aYUfbttQCo1yhuT3eUt0SQca6x2EdA5rHh+uAEU6Ri3vfwfMYGoI+RFaaZNvtCK8G3clLUYaSZS+Xom5NFqOSANxVLiIXTthXk+fb3ao3iM+Cj2emwzzmLw//WxlHpp1HgYjXirWyBnOmraQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986797; c=relaxed/simple;
	bh=MRrKWrouY5OMvtZsZD9GJqZsIcogUe7S+ngMcXQaLB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWQwWVZa7eoMC38eWiR+32OVZkt8T01NrPEZ59zPZJqGfOFMU1Kg3tnH6axZ0lsTmLwDR2Eg88Lfu3W9FnfCQuM5ytNSDGcU/Z3KVeeuX7qX+Vv5JCaQCBqmz2u8/YofvE6HY0kbX8zW8fWXF6LOqmXDO6rDxDAn+Q+op8H2v2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA250pBl; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b31a665ba5so541426085a.2
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 11:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767986795; x=1768591595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPw5pV7xaN+jU6WOQnRGRkHDBZo/niYwQtqpgOhc0f0=;
        b=PA250pBlJnkr8pmxrgkh4w9bYYTi9QMKg6PrsxyiopY+I/PbYoex1OKHrXMHWWvyBd
         Na2QekfgwTImafGGOUhXtjYpo/P4/6ODDnqCk6wr/fN/3g/shLuoGHNeALN3exSjjgCl
         iN6ssKngJGKnVBiZDXAzYFzVfePEG75WZxy4mzmkeAd1dhEdvYKeBVKc2EupK0FveENx
         FtQb12kiNxJrXoWOlHKV0oqhGaoZMQ7cTKKM6Q4V3DiKUgHyH07GsfjreKt8ahS4PZhH
         i7pEfDN12e4kFJ2zcX0lNFYQiiAqrOYmqcF45mMPWqdAxz7YB4Vcy8DW+LToKlER2Q+m
         LaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767986795; x=1768591595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPw5pV7xaN+jU6WOQnRGRkHDBZo/niYwQtqpgOhc0f0=;
        b=QAe7g9PmGKPGrx9V/Ts4oQoNjE4UJ017RsPu6BQ2JtphER1nyId4U0p3lFW+ot25iT
         pobkh29mgm9hNO+yAWoDo3Aa98uPFWvDDpH/5uk4VqJvRTLKOYPrxvx/EzOq276Zfyzu
         fUHT0Y06s03hrdoWi1UBOljos5IuPfj9GVLxThP4yxWzMFTlPq7oOsH1IcoQ/bQotpZ/
         acQ+th5l0bI9F4elWF7CPi817liX3HdsZii02eK3kcoSsf89kfj3TBrVCDr3smFn7eL3
         coDMHNyNfhL8VnfqmPXxcgBUjtGG9T0Fua1mkqqs8zVxisI+0fGPFinlPsw0wvNjesXm
         fr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm8s9tieFwmvmyOcxflFOwiQieoJ76IVqTT31Fdy97l1ahOAMSpmnp0d6fef201k/Cz4dR954=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSSeli6Gx6j9bzZqOX3vBlRXTFH1LJOhv+URoj7JM/dyGGR7x
	iFDhK5WVGPIDdeK1Ex534y81KGQnP16F4cV+dIJfg8nLvIFdCUGE9Srq
X-Gm-Gg: AY/fxX4Zh8KGMJuvl8QjoTZ1UXCLe1oXMEzv9PfIwc7ieCiWM9fjEsAwF0OvXosAqND
	PYaY1Oxz1DY1m5fx5Bk4h3xTJ2at26xytAyKtxvnlesglUyyv2APsafCj+TqCgSO9ytrndiYP7w
	paHh3pa+fc0hf4xc0sRAFMBZN44p52SyQkaup0RfOLSHFYIOjRGUihk7VirjpIswthaMXEZbAg7
	p7noq+ujK7vjjv2CZLgc+5yP9r76CNP2YWDs1cno/XGpKiYPAwKShpeyZU4FE+z1gEBTp9SacwW
	KfMLPD8pcuwQfRooHm2s+WbnXxZS/mlcws/t01MgtiqmJcmtWVjcnxP4zGeDyilxcX4iIAZXY09
	0cz3dAaS/43kRDHpY10YJM1i48erWITKUU7GAm2WNTpnUuajBfiCoQ8fqxHPPsiBnOl1l9M+5fQ
	/BE6brRa2LnDt0gAedcJ6RrwkzYKptPp60fRQWNw==
X-Google-Smtp-Source: AGHT+IEpSopt1fa78qKdz4xtY6yAtTulMWKWceoEJ1Y8Nn/xW67ar+1tYva0HhufzicD6a+WA/63kQ==
X-Received: by 2002:a05:620a:29c4:b0:8b2:655e:52f0 with SMTP id af79cd13be357-8c3893840fdmr1522956985a.22.1767986794877;
        Fri, 09 Jan 2026 11:26:34 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51c05csm880145885a.30.2026.01.09.11.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 11:26:34 -0800 (PST)
Message-ID: <28865e60-dac4-47ec-918b-d2a69975a36c@gmail.com>
Date: Fri, 9 Jan 2026 11:26:30 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/634] 6.1.160-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260109112117.407257400@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/26 03:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.160 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.160-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

