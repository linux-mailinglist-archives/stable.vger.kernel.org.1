Return-Path: <stable+bounces-131984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D4A82F32
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 20:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 151DD7A869B
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB87277809;
	Wed,  9 Apr 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WA+r3Tgf"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05F26FA5D
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224389; cv=none; b=MATv5W30SRTs8Yh3ipL7aQBFdBfbdIjWl8f/Cyt5kNISqb1V3oe098Twf41X0lj62B7j8Chn9kPXsN5AOrlPswi9yjLp1OdEiTarHUBaefKL/kLdz/UigfaihqG9uULQsvcSuNuAcncC+TOC30eh/KJpD7o9HqdhbkFv69xDNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224389; c=relaxed/simple;
	bh=GB+KgBrxXEDkjE6FtaK3WN4JU3vY/RUiE6ujvmcCTWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5VsMORKHQy9Eafm2CSXgOPd9QyoTcch+pJfnFJ2ikNzS5G760txZ4j52Ou7gxnlLGpNy51MqqkXiDzLQsYMmmOgwzhcHJ8Nk6LMf26+mOS9alrEpIGBIM21Lu5x8pe7VNQDP0xMAYH+dfAdiYFKtMZRprJvq0Gze97hiYTttxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WA+r3Tgf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d5ebc2b725so165495ab.3
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 11:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744224385; x=1744829185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifMmUjJGIsQhwUTV/RCg0YV0PIkSUdUeNOFNrIPNanA=;
        b=WA+r3TgfktEIAhMZRGAfBM1Rwg7rqRtOAJ2lQTwsC8PssLw+HpyJ8DqBQNbV8jQ/eX
         juLogMf/dLg4G5vAn+xzBjxSfVB1hX2unSyR78r72Hti1jA/jUwssM03FNcsE2VPzEdl
         QOjfsYnKaDEECfeKa6/PGGtpGzfW9H1ki9oIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224385; x=1744829185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifMmUjJGIsQhwUTV/RCg0YV0PIkSUdUeNOFNrIPNanA=;
        b=hea6JHe6bsE0k1GKT0maHLPwT+RLumyN6PzsGsMOyVhFwRrQEWHJXAJQwweBzSzx1w
         ooa5ORxZZ8+GsVT0Pb2jzGFFPHJRI2w+n25HYrAKJkF5qSnpzvf7ENuDAisz2blzJ196
         y4CfB8QHxChk9dseEupFR3E4Ag/2YVpotqvt02R+YLybt2NLMrF0NulvgNLJ0EH0cVYJ
         LpqKNqZMkIUnPx17Kse6z+ne2xvk+NVcmhHnNIqKSiWuU/39ADNMTDgtVYrAcfyNb5fL
         8JcV/in7mBqcTCovD1Eu+EhSZUhSP342QlU3qA+sz/UPj3smqQ3n0tbqjx8fNliHA+zX
         Ns+w==
X-Forwarded-Encrypted: i=1; AJvYcCVXXR6p5AnHJ2doeUoehBWqGrHGSz+r6HkM9FdzOadyXEQVZ7NDy4F4kdU3j5PYrS4g3n114cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmpRxlNrTRgr4/yP1xmKfLBaJ6sop+3U0b/8IHe7++P2QHJsuN
	wbgRddCstE3AFk+/GVs81BFrotrjZwqrVFFKZNP0eHt60QXW6QqmFdDOFm+gp98=
X-Gm-Gg: ASbGncvnGkk7Gh6B5GiKyHrVgHfwkgpskyiBpu6hlDAv3lmrKscIQNUeeWSxo4lebQV
	Jt+eNKc76dVUwXf6VkFCWtvHdqFYYt6H9mhKiHzKtUqt3KSD6L3Uyp65Z5rm2SmcNmATZsO/xSs
	Zbx5NSGfWZmoIs1UhLfsRx+Vljd7MJxRaZeKcc9YX1SJZsFnHrVirS1gGM5ZbEDhPr/t0fErLpL
	3x+OXJpI9aVyajg798WAQQhvsfPpKp35rEusxwMKPcTLL6stQq6+IW6wuRSk7Ba1zebSP6xWKkP
	BVu+gVoxcZUQvWu8azX8l+zZBX5ymmN3Aq7KMqM4BFiQxZt/XAA=
X-Google-Smtp-Source: AGHT+IFQuufNWokgX5APUUxZrBWTZn+tndy1/mhA0AQzSeV+nWt/l+N9Jvp35CKItDvgOWHyX5DPUw==
X-Received: by 2002:a05:6e02:2207:b0:3d6:d162:be02 with SMTP id e9e14a558f8ab-3d7e476fa60mr1761985ab.21.1744224385548;
        Wed, 09 Apr 2025 11:46:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d7da491383sm4091795ab.0.2025.04.09.11.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 11:46:25 -0700 (PDT)
Message-ID: <16d90cc9-72e2-41de-9484-224ee23f6cf7@linuxfoundation.org>
Date: Wed, 9 Apr 2025 12:46:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/731] 6.14.2-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250408154144.815882523@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250408154144.815882523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 09:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.2 release.
> There are 731 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Apr 2025 15:40:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

This is the one I tested - please ignore my reply for rc4.
Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

