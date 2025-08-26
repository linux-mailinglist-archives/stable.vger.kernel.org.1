Return-Path: <stable+bounces-176404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C8FB37166
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA5A1B2854C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4BF2E2DFC;
	Tue, 26 Aug 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5D7OuEt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A441C2D3A7B;
	Tue, 26 Aug 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229813; cv=none; b=UrrHgvlyTA5bW72RI82sHxkyM78r+zsJ4w3tU+qLS1mC+rXIoVJuY7jkcd3mNFu6J+m01CLRxlBhuaTHjS72+LoP5nZbEbv/Fr+sHBKrC+OYqS/aih9rO4f6tsieU4sjs2YeT9VqeCUmgYlAij6lZQd0/9mzugxtE2nM+96oBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229813; c=relaxed/simple;
	bh=h1hzb6kXNb9sJb6UEdW1dxiFgtKRip9v4zaf7STaU34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o2MhYVtEebSkHKlS02fB7XN9PkjbMGwXHfPECIGQaFqjIqq+L6QUNT8embhcPPWnoFmFhLapSthqz68XBhWTaqceLTgndzfqGxaEG8UpSRUbowOhjlF8Ep5RSR2e93MsROIqsAZTaFaYkf+PQHweYyDkPejIwHffGlNquF1IhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5D7OuEt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7f04816589bso212767885a.3;
        Tue, 26 Aug 2025 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756229810; x=1756834610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2bul+sAEYxjTR9TR/KmNbpMJP4z2RV4SuYQGlJPpSwc=;
        b=k5D7OuEt1psIf9jJUm+EyzTefYSin90/vbtBTG11++UtP1ZXAUX+sHlfUCirdrPNOG
         Pq9qQie3JtU1xU1OMpHjbMuQhzQ6AXxYIwP0fI0bPSP7KiHNYaua9037AS3+BmrqBgrG
         K/P3RfQNM7ZCCzbF2U92Z4LOSNKH+XY4E+Ob6tfOK9gl3FOhoRo4HDQIoeLrXytIAJux
         0PKvWpHp/H46rw64IWa8pl1oQFx8BXhWsVEtf/REZanFdKdNNyj1oTxs3GOx7l3J5Xvi
         CImPrA5zUT70i2meDhaeqjS69xxYu1IZUwMM6QifsPioXMjDqKjfD1HvYNee8H3V41zh
         qm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756229810; x=1756834610;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bul+sAEYxjTR9TR/KmNbpMJP4z2RV4SuYQGlJPpSwc=;
        b=jbb6Io+TjJ082F4z1q8JCQTc8eNlWsfVNNks7f5oMXsMwHZ2aQZkeoZab72vyok4sJ
         pZLP1nmQ9VzEX/EedLz+sNqrCiZ1FWHS1qcCZaVGQJJsv8aFRJPj/YytNZ7BJfpVsOp3
         WFNyAj2dwctz16+VF/a2GmWo4RDz/JQib7W5KlA4n8M1Fv/2Yv64UcxFz5k1OOq40AVB
         TARx9nubLrsrgBK8RkiLhBuPfSxvfP2VGxO9S2EJiai24wgcdET9vKU8UQlY9LgLp6hb
         MseyBdh357YA7mzX0Gtq0MGWqFb8KTCi+UCVBBLbJln6rO6zRp7ziNkFawpvA2t2vyGr
         yRcg==
X-Forwarded-Encrypted: i=1; AJvYcCUpQA39b5WqOdVgekqcNCMNnqNFGfL4RwlCbs9gFPUBVzlh5Scb8N0H/js+7fEFIFtKWTqDpNgi@vger.kernel.org, AJvYcCV0aoCr6I60idczB5nCJyS9EuhRGweYzbAv9l/54C+5rm7FOllSITLuaH/j6n7nt2BaF7eVYKE//jG0RLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrhl7urCiuC7pp7d2XXki508iyhaBFBE5W2A6OP5UFKcI6oDEm
	/OvrF4ND+ptl8U/h6HeTVCsu7erhjmllEYiGdmRuwWT+WXKuyncl0a0K
X-Gm-Gg: ASbGncv8+PEy2Ysmo0kuV88vBXrQvRoIye97F7kWh3Bz7T9TWZT2Rpd4yjRVg48PBnU
	IMM+ZQzWhddxvQoHVvdSPcQ+0+LcSLFXfmY1jiRnnXSP6MABIh4sphyvnmNX+JDPhdsg1Spu49F
	s6t4s+px2GGSr6hwtoHwmc92PBR0DNRq79eUUKnq4M0W5qVckieo0moNjLxkh5xUGdtmVC3pf1N
	Av4YJOecr+M4Fuzp1BXLauWalhfg1ch9kV5oYEyCiN6OundLFxpah/+1fM8os04CuhfBn1BuMdW
	PlIWh+W3+iccxuX9TL2UZSf12E63jw+wYctyStewj8AVf5bn4u4Ybb3VbotPxaVueO9RMUpd88K
	VaWfHW8r0lTq0AU+0lVEh6CaIeTE0zt3vadoc++l/LqlkqXmGaQ==
X-Google-Smtp-Source: AGHT+IGd4yxiaDJ1nN1xxwqrq7CTubcIsmLr29Btgu9rztVhTtyKu+4WSygLfx17nr8zqzbzmsuISA==
X-Received: by 2002:a05:620a:4245:b0:7e8:54f7:67cd with SMTP id af79cd13be357-7ea1107cdf9mr2125426685a.50.1756229810342;
        Tue, 26 Aug 2025 10:36:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7f0929c268asm452807185a.35.2025.08.26.10.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 10:36:49 -0700 (PDT)
Message-ID: <49147e71-067c-467a-9a04-c1729a0a10a7@gmail.com>
Date: Tue, 26 Aug 2025 10:36:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/523] 5.10.241-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250826110924.562212281@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 04:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.241 release.
> There are 523 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 28 Aug 2025 11:08:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.241-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

