Return-Path: <stable+bounces-197652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA713C94680
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 19:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 72BDC345322
	for <lists+stable@lfdr.de>; Sat, 29 Nov 2025 18:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355B31076B;
	Sat, 29 Nov 2025 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmqyEWGV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4216F288
	for <stable@vger.kernel.org>; Sat, 29 Nov 2025 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440882; cv=none; b=Y9qiZpY//Ww+rXl4XsJroU90VCXUHaxQ94DzUVb6l2awiVw7sjvcaQbIUBCB8szJ4qU1u2a1WptMlqSyyftq359QIWtJnmY4ZjVTED+oUcBsfV6kS3x68w7DCQUXK+hh3jF2Q4Twj8zzGAbyWkaWxzqEMnCFNgJoV0nuvT1uqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440882; c=relaxed/simple;
	bh=2FZMWlMhsFRsdyG8nb/9r421Iual8A70RFxKmbSV6ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8xNauVxJAptSgeNQo+/WwHCNYCF+yCMWXisJgrr0f3HaDTuuSfDd2Wufr3b2R5tNz39bSQIdT/XiKzQVdl5M+IFrt3y4l/spT21ZOvDMAPMxqlWrdphnjBOByQExBkAog/+V9I63xjy/ki1NEY3uVfaSFlk+hehgPZGyiFUdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmqyEWGV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295548467c7so33452765ad.2
        for <stable@vger.kernel.org>; Sat, 29 Nov 2025 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764440881; x=1765045681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1ZNnmzyXK+QEuvpasXA8vnwZpIAkRyBsEqcKtTg0+0=;
        b=OmqyEWGV9Zp7iBp90RdG7h2yB6LhGGsSHgTST0LCYhWV4V2WbDm5lALOQDYX55JUee
         XbxMJBgwFUpAY7Wbsbr8vvjVQagRJYpEZxxspYjYfJvg+GrEVTJNMpS8sB4RHVr6QbB1
         IYrkBOFU4IwWJHHZi8esqJwE8qkuKWYsq4SSrAAgjyIbF93mYojamdi1dwPRFoyrVj3f
         vh3kk6FAn1S9LA8Hbsnioj67zHaoqS0xjXudGagyqjhaD7gNWL8wJPQMmKVlPaoU5nS3
         ERb4BfDU/ekxBGWCEpUeFTSjqrKZldKGcZooPdcjWkWS6323rZD2H0rfI58/16/kTcSe
         a7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764440881; x=1765045681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1ZNnmzyXK+QEuvpasXA8vnwZpIAkRyBsEqcKtTg0+0=;
        b=obBjRkw+wyyiBmw7g81QSsuBFvj/Ddp802AvjW4p8M8P9TuHwBntvxMdZ7fzv17KI3
         i04GTWOfGN6DRwTVTjtIBI6j6jyghWcBkLGP85FYZElpCBg6oKnOyiwvYqgU6ClPQeFc
         IjuqVzmiQsHqxucFP+0JXRbAz+38LYuun5Lm1AoRa7r6rluZxqYGZgyYVc3HimyrJt8J
         nIvHvqsjT0G6cmyKACN0CotOoTFno0sPIpuXmUJdDSVPnhUMmLoRjofv7pdXiPmQKCH8
         xoFR+G7z1LFzAPwI/dNDDpsXV1bHSyIPm9SxLYC8N242Sq/xo/SwSMLHwgn3re5HobAI
         c8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUHb2xqIX63wyb8G5PzdSaDUdgXIdviyYneBUcwoXqJScMViphyiHhAWZFAvPYmD6nDcRzGSbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmd+vZ7PyzmHVE++p5vgtVcxm0v0A/ZCuLUmpVlmffh2ruOZjW
	U13jsdq+xr0ORLNyMIwugXPQUUoeHBo9veKZBMqXH9R6w67o64AVoAJk
X-Gm-Gg: ASbGncuL34aHWDdgLoe1TBF0L3+a42lmrXVfJ5Fd2F2hSlGWxXz0mObmeSq9qMqPuke
	SLsSDHR3tssD4FzRAPnDYe3o4yP+n1BN/DebPl4VW62rnJMa12nUH+vYojNFxWpTOefT+nNnFnG
	SAhNKxKGLwRYjRoDBWF2fQYTcIKJdhRgtSNjUc5COLBO2vxBIDFqofq1O0la5HhLN0mPUTlFRGw
	+Wh1OXIxDD3Ll7HCl7uXTkANh2LPyG8IhWB0Mwe2ju5m3HbCEJtoQFPDbLSTCeJ+uNz9B0NHKGp
	ZNAf0W3LP3P/n6T5vmJJphxq3jvgbrJDQG1AOs+y8NIYrQb/eaNo+kAaTw+6x0m7dNqD+W07ryf
	Sy4SIvRc6okEVnqP7+p7FJT1IN6XQgvMvPGQJHLy1XwgNPJZMtZwIx0K0h17D6NlcKqH2WJetZA
	elsSnSegIPf2+2aR2KA4qhew0CUclWlHkDNwh6PHnBiHWDDcHYFZOB
X-Google-Smtp-Source: AGHT+IGsKBIqwjVq/z6YqD9YkTOEMz9bOaKVCUA/DGn8f4xoraR3Uunlrc8fGZpSQstawo1cRi/3Xg==
X-Received: by 2002:a05:7022:4191:b0:119:e569:fbac with SMTP id a92af1059eb24-11c9d852cc6mr24315984c88.27.1764440880585;
        Sat, 29 Nov 2025 10:28:00 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee7076sm33776019c88.4.2025.11.29.10.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Nov 2025 10:27:59 -0800 (PST)
Message-ID: <043aa312-5a2d-4fac-93d4-4fddb167526e@gmail.com>
Date: Sat, 29 Nov 2025 10:27:58 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/113] 6.12.60-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com, Sebastian Ene <sebastianene@google.com>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
References: <20251127150346.125775439@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251127150346.125775439@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/27/2025 7:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.60 release.
> There are 113 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Nov 2025 15:03:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.60-rc2.gz
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


