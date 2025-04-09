Return-Path: <stable+bounces-131982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DA8A82F2D
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18486189BAEB
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A44278158;
	Wed,  9 Apr 2025 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9s1jBhP"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB626B2C6
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 18:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224260; cv=none; b=sPKueMWDfe5a5HJTlQu3Z6knXaSkJJeL0ToJ0Wn3WK/IKwq2Av+n+SI4VrWnesigYLqwZDhra8HwoVZfFZYqfIq79JHxzqx+HVOvy+2CJkaTO7BbYhc8Oy8wW3vFNzchZwzHyiZeZZ7W+rU7cRvPF4V0H1a8Fiq5h4qk/OGLKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224260; c=relaxed/simple;
	bh=cLRXd2ba2CeeSosufDG2CuR6OG3+lGXoinJjPTZG6jA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8mpu0BrmxEefhyG5C4isAWJDxLmgeSMuyOcLuleapooHlZV2XiVWsFbfH9fEG1NLgoOZSxLD9lvMEt11wwdODRCj6cjGLnrvsgND63EhItJ4JiRQ/m+gZRk7nQE/R1jkYhzHOtjSQoUzUm4ViCjn+hH2S/2KW8jqoHdSAsT5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S9s1jBhP; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85b5e49615aso5309239f.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 11:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744224256; x=1744829056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXLBtWFo1iG4jl/4yzD55CgxaVLgw5GIoTATgzYBQvE=;
        b=S9s1jBhPM9x0rJXYsw7ombzjkm8hWpkxtvse9piBqmAZu/yotvxo0uvAibPCvtC8sH
         1brKzqcYaoDlcfAfqIp8CTfWeHVzhC2unkRNgevpLCnf5AHlrz2CPJ34lCfioTijnAIz
         Aj6s5bVqyqq78W66E+1IaPr9ANToFLL/jKPiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224256; x=1744829056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wXLBtWFo1iG4jl/4yzD55CgxaVLgw5GIoTATgzYBQvE=;
        b=GeGcIdQgLLGLq6JkfoTZC/JpA3LeriP0nBIR1R/ZcP4AWdMfNmLWEIGJe2uaHfAmyo
         ZKOUC78oTGLKF+Xni22D8LXbmfdj2e+Ql+SDN0AcOhs4mpBbl8F93SFdXWLVre7dGlXd
         TcqqxnEUtC8Jz5NXrGYSBJzRs06mcK/EQV/ChpM66ekGompAH3/QthGMKAT9JaPbN1gR
         6CqMgCIzh+2V3zN7qjbIvjJ8jO6s3Uj3q5E7i57AuMiCFuqbr/DJEZTAGrusabwdVYx5
         ZPw04+cCX1vtJpkdXuBSLQ+kug1MtBxRFfmDDN9RB9PDCd6vLoHBYCl60NtCUy54dgvx
         esjA==
X-Forwarded-Encrypted: i=1; AJvYcCWEzFvgvP31tI3T3i2A8IrX7hiCxZnAijImU7zL+OCJFsFc9qM5ex4qAS2TWJkDdCfaIqIseTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIqsuWrx+BPcSiyzKJoyBgA8xgmUwFFdM/kHfma43FsLuebYnX
	l43xoRiKJJBmq/0LiICXwQpWpW0GOWaga2rC9/b8ur32ik620Xn0wTDrbZeAiJ8=
X-Gm-Gg: ASbGncuAmWHtBohlGmpM0sBwum5INKI6TH3ADQ5DUv3pxBfUQZtSvnVlRCHeTo44tVr
	WuhJyMdiMKWdM8fOPRu/voxyAEmK8h9alCCyA2dcE9WzkhA7HqRJH7NbSJt6Tyxc2paRxbwEVC8
	5JrVseHXs1bjBUn4tQTMdpV2GlflqOvO65tAY3EIMmesSq6dBa9BHumh6S/rTx3td92dPGf8aTT
	dMITPcPB2oHLBU7SpIA1nzyz+6vhYkIDTpj3416vVBMVoNNe3jXM1IfMwcU3wjR8T2NDxeYX0RD
	dY+FADlnSX1PxH4TnRbjxKLk5yuhj1pESYkZc5QLzQnGJ00sIRufymcVm4uN4g==
X-Google-Smtp-Source: AGHT+IGO28kEay463v+HtpsW5QZR5xULtav+EFlWbau8kOYwbqxV37888Qg1KR8L2HGq5JcQPyhIkQ==
X-Received: by 2002:a05:6602:394a:b0:85e:17c5:bb94 with SMTP id ca18e2360f4ac-86161188b7bmr497863839f.1.1744224256359;
        Wed, 09 Apr 2025 11:44:16 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-861656c8808sm28468639f.37.2025.04.09.11.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:44:15 -0700 (PDT)
Message-ID: <4f0ac0d1-9c75-4be7-ba3c-3daec2fdc91a@linuxfoundation.org>
Date: Wed, 9 Apr 2025 12:44:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/726] 6.14.2-rc4 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250409115934.968141886@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250409115934.968141886@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/25 06:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 726 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Apr 2025 11:58:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.2-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

