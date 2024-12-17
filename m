Return-Path: <stable+bounces-105065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 552699F5791
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802E516E5FA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFDF1F9439;
	Tue, 17 Dec 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amFEtsRi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60D1F942B;
	Tue, 17 Dec 2024 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466906; cv=none; b=DRDh1UrrSEPFplOvTGIRz+efOOxNGhY0XvUxcDRy7yqOutLP8a/jAdyR5JNl2a5/FChQa1C8XJhnNQ71ReRaa8PGsG9Bq8ThjYOCX0T/doOgKkHbR/tztBO2lBEbsBlSC/J/uzSXBNQ1PzPsTEjbpGAEDB9b26Lg7NIkEJjkG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466906; c=relaxed/simple;
	bh=agT8eWGMj/IgFN3ggsf2C5m/AKg0Pqn264+e4oPJwz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8L3BEqogdIe3RzAAttW7tteB0T7KykELcm4bb5BesyTtnvMwnLt7n3ZaVcqmc+q0oZSM0sm3/8iGf2GCBo0ASCF1KQzjas9bfksYxYbH2gOR8b3wawpUYiY3F8Jr6VKbpxp90rqrKxO7gwEz80OngwV0iApPSvn+crWy+SGnnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amFEtsRi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-386329da1d9so2696915f8f.1;
        Tue, 17 Dec 2024 12:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734466903; x=1735071703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3SrVH1ogv/0HKKAXcg+vVrcc6mwA8k/OcLLwOQZtTQM=;
        b=amFEtsRi/vTuoYpnr6+FvGENKW5OL7HCJW5mvdUO/bIrkYsrdqVPrlUvxcYwUjNI44
         jbZ+Fw++2IKasK/UMZvmmqEjkOtJps7loEHv6tKO6kc/57LRBH4jmdNVZeAkyv6X9Cy4
         QUXabiRtb0MKYH6TiY9xBWQMLoVYytWIVlp6T+5giiFz+aOGvmDYDkdz912zLDWNChOI
         TWR5RrL+YdLwD0GU59HCyqSm5o0Tq+UKd+0VD9AVnm2Iv4BtaBOHMqAslmch0bd4Wgru
         VzdCd0bHFaqB9o+jR5SQ/MuCREpLQDLQ86UmlNjDBuLGmNZ3mcpG+Xb7H76NcN+8gFhS
         NZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734466903; x=1735071703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SrVH1ogv/0HKKAXcg+vVrcc6mwA8k/OcLLwOQZtTQM=;
        b=C0fo9SZmRnDYxozPty0zPfMHGiWzpkqWwTu0PED+wZus2DBLB8R8mNdNrCALe2j+h6
         FkbOLWs5LL8zQNZpNIOs5bFnqorEM4sx5+88s1b0CKSjmMZj+B9ILkXb/Ud2m5ewQyzE
         Oje4WopqtRRck06hLRJTvO6fA30eTnwnWo+JQB45vr8Zu+pjynPC4atVGzFbr3LsJWCe
         NRjg1WBYYA3FzqlX4z4e04TqEZSrTzx5UOJfzwXYkz8LGzOZVfTMGfh1/uKwHXbLdh1D
         XxzDQ1LcKOfHMStMQDkE/UYsdgoVFgDmB4iTEzP2liUqPz6eJR1AA7c6laEhPL1NDeoO
         Wp1w==
X-Forwarded-Encrypted: i=1; AJvYcCUzkMg66KDDs6aOBo/WWqAEV07RZBaPIkj3W+jqKQ9vI+BQq6OX5a1bdUw2nRLGxrkCTN/pkRq5GvfIC78=@vger.kernel.org, AJvYcCVY6kic1p2G0HQTQUD8/QUO6053n7KbTXDRfgSJjlC6Aaos1WQ3DaEskMJL3pynxyldH5Op9BPk@vger.kernel.org
X-Gm-Message-State: AOJu0YxMR9LSZHiFCR0oqPXSfZZ6sjVpXuCCUvV2s82XRBNpH8DW2r+E
	rQJjhIWfiVEUhKl+jIUtUJHhM5BymRDm2QslJTom0ryIvYIOO9tU
X-Gm-Gg: ASbGnctw3UzGVRnkQPPfpZrCLM/CddJNB/lzP0DY7cpHqdxY7psgSBMoasrxO2RcZnf
	bSm3vZs8Y6m5eTBn39scIVgOOy6o0PGeyfd0kdgsTEhrRgN7+f6ifa5x51PNoeywsdlAtNjzUXk
	k7/cLoJBohnNfU3/Gwxr1OK63oyyV6cuTxH2/i0TpYpuzikBf3zBlMSn+E2BEb3nEev2q7aY1D3
	vhvPOixAMh2eoaBXpT8/9Jf2xnqNpkcU3QEQw/wVDVG3V2HGrNUAaVGpVhuXhf6Ss7UZx70wpEw
	ouDJnvex
X-Google-Smtp-Source: AGHT+IE3SiHJy/aH1NN9e0/wEpk+tFK91XI00NEQT+6sU4Xyd2W6jg2mcnmB229Ymf4mP07DcZ4wWg==
X-Received: by 2002:a05:6000:18a4:b0:386:2fc8:ef86 with SMTP id ffacd0b85a97d-388e4d41d82mr227693f8f.14.1734466903010;
        Tue, 17 Dec 2024 12:21:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8012029sm12002041f8f.12.2024.12.17.12.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 12:21:42 -0800 (PST)
Message-ID: <443815cc-271e-46e7-a668-14dd42a8ea70@gmail.com>
Date: Tue, 17 Dec 2024 12:21:33 -0800
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
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241217170546.209657098@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/24 09:05, Greg Kroah-Hartman wrote:
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

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

