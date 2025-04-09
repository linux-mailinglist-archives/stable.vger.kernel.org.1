Return-Path: <stable+bounces-132003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 854F4A832C3
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 22:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505D319E7D4E
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15551DFFD;
	Wed,  9 Apr 2025 20:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB3lwpGd"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9517A2E7;
	Wed,  9 Apr 2025 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744231691; cv=none; b=NLTDi4iqttTRJaSZtaIGIY4eDlTmrufm3szzaTRvKFNje+zSt24poSyfolX8lvVkk4YnE/T2Cqn8mchuRyTU0fL0G1hBh3TgRpxaaH/ZrbnVKq9oVivZe4AUwIhda+7G1R3hOIKueQk/QkwV9uFi/+iC5j6VDkPQtEULfL9ESHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744231691; c=relaxed/simple;
	bh=ci2MJdeLa8QYlzDF+6TEf9mOfzQANaZw1JDjNq84gT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4rL5A6nO2dsVTTrP58eW4Cn/ALcuXjLIY5CCMMFaj/2BTrEnEQ8SFk73M+y5+DfGhizcHn2JUrpAiMI+QvYksD77E7zKFcuOl8UVmX7RO13VMlTAUQHlabD9xkQ0bW6SklYBpXpJ/Zc/9IurBzpCWpTYUODjI4wxKdfbm00M4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UB3lwpGd; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3fea0363284so94244b6e.1;
        Wed, 09 Apr 2025 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744231689; x=1744836489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QzpW2OvJ6ytIBSqPjs77ATyTugyG3+0hV/t4YJsRyPU=;
        b=UB3lwpGdpQsoXIpoLY0HoxZ18oCBWKbzcyqvcFAIYiSuKn13Exx5vUax9Spq/Q9vrp
         kzE+0/yD0vSbN5om4lphWEz8fuok1SOladTQzlPzCBqJBg8UJWzCj/WwtxrX10sW7xN/
         OLJ7/wP8VU8C+7iXLr0HU7u75U0AVwB1RDLb7AyekBMwxxxgbuHqcyO9TvUskwLKrbmp
         pvg7v3H6Vp6aPM+CYgWa2TxA34iIYY3u1kMF8Jp30Krm2RMDfjODX/Sh3VJFXFy4w4uv
         jUg2ARpTAhbjb+0h2pK/Vc2S7wrtF7KuYNisrqU9YFFOBI6X/OtHQjpFennYq+Ehdzq5
         JQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744231689; x=1744836489;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzpW2OvJ6ytIBSqPjs77ATyTugyG3+0hV/t4YJsRyPU=;
        b=uQJuUeZqXzZ4Emhy2mUhZE0pkk4sbt9PbqwipnhiN/3INj2mKdlCIuqzKIMbc53l1i
         31OXZKqGpK40S7D+WCLxAQkLpMhxSYTxhxOJ0g+wXGGBxAdE3x/BKLQZGvdbz4ij4QNY
         TEtAB+1dsi2C/VtqJUFmn1RMPnok/Agi6j87e0LH9yyozK95EB1gfjiI01K5Bxi+t5xw
         ipOOi9oG7GONjakluqDFqlknMIxGPiwIo3/DBQzI8dxZUh/Its/ZgYADuW+MzkoBZ8QU
         kXW8PhsRyjH6At1TBMv0ec9IhccUGYCMILpy0ZxcmXIn8j1hdxLG5O9KMime0HuZ0j+4
         N7hA==
X-Forwarded-Encrypted: i=1; AJvYcCUHYyErlR31t9Gjv2VtDuIo5GmfIwPTAFx09JOhTvqhstPUH5Ij6W4tqPGfUchcs9fbNdvwVnLw1I5V+jQ=@vger.kernel.org, AJvYcCXFUwWHbW1MjG6KkKnMjerS1UC1N52ECuYqSO18x6hoD/T8d6xwYUfSN74iXs0e6cKa2hk3TGUv@vger.kernel.org
X-Gm-Message-State: AOJu0YzL99i2toZLGIVPWDCaX/Qrl0MpXXdKmoSsRFsUC+ijpW41JMOK
	eSjKFLyuiPipNrfqMVar/xypnOk1PFQOSSEaPZeFnoPPUmMX/kzR
X-Gm-Gg: ASbGncsAHUboRwOizdV/UUy1k3Cl4+5zoEkqCPYRwv1mbM3X3lQ2BdSfbjPpxjTILqx
	iRrBkDE/x9sFbIa9ty6TLq+HSR4A+8H0K0b8wtoHgNKRNF0kQ527yctJXTJxCjIvUjjd1NiXo1k
	C8utzyvUA0iJO6WC2Y/6SgxzQMebqgJIAL2mXv1p5D+Snlqx90gziFOmCehNGGNORwo0mfLCfUA
	GstwuOLp2kWiDTWQYzKJ0PE1uSIHaLxY7HCGdnqVENLn/qSwBZzm+Z+7jTdDoOuI18WHJPCDJ57
	N1GeWp0GAmVgvYIkptKlbpZ0wcK996AF2h33vWrJnsT3N9eJT1DD+H81bBW4BFl+mFkW
X-Google-Smtp-Source: AGHT+IH92opdxDnKJ8ntfWYBpmwwZrfGEwlMj0ef/gZhbqWnJjMvUcIQFgFfDjGgeDz4h1n/w4YXHQ==
X-Received: by 2002:a05:6808:2f13:b0:3f6:7677:5bef with SMTP id 5614622812f47-4007bfa52femr147102b6e.2.1744231689136;
        Wed, 09 Apr 2025 13:48:09 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-400762a4d02sm302188b6e.18.2025.04.09.13.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 13:48:07 -0700 (PDT)
Message-ID: <767410f0-d7ad-4216-855f-3cca00e8a726@gmail.com>
Date: Wed, 9 Apr 2025 13:48:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/269] 6.6.87-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115840.028123334@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250409115840.028123334@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 05:02, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.87 release.
> There are 269 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:58:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.87-rc2.gz
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

